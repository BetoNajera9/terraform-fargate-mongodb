import json
import os
import boto3
from botocore.exceptions import ClientError


ecs = boto3.client("ecs")


def env(name: str, default: str | None = None) -> str:
    val = os.getenv(name, default)
    if val is None:
        raise RuntimeError(f"Missing required environment variable: {name}")
    return val


def _register_new_task_def_with_image(existing_td: dict, new_image: str) -> str:
    # Build register_task_definition params from the existing task definition
    allowed_keys = {
        "family",
        "taskRoleArn",
        "executionRoleArn",
        "networkMode",
        "containerDefinitions",
        "volumes",
        "placementConstraints",
        "requiresCompatibilities",
        "cpu",
        "memory",
        "pidMode",
        "ipcMode",
        "proxyConfiguration",
        "inferenceAccelerators",
        "ephemeralStorage",
        "runtimePlatform",
    }

    params = {k: v for k, v in existing_td.items() if k in allowed_keys and v is not None}

    # Update container image on the target container if provided; if not, update the first container
    container_name = os.getenv("CONTAINER_NAME")
    for cd in params.get("containerDefinitions", []):
        if container_name is None or cd.get("name") == container_name:
            cd["image"] = new_image
            if container_name:
                break

    resp = ecs.register_task_definition(**params)
    return resp["taskDefinition"]["taskDefinitionArn"]


def _force_new_deployment(cluster: str, service: str):
    ecs.update_service(cluster=cluster, service=service, forceNewDeployment=True)


def lambda_handler(event, context):
    # Expected EventBridge event from ECR Image Action (PUSH)
    # https://docs.aws.amazon.com/AmazonECR/latest/userguide/ecr-eventbridge.html
    print("Incoming event:", json.dumps(event))

    cluster = env("CLUSTER")
    service = env("SERVICE")
    repo_uri = env("REPOSITORY_URI")
    strategy = os.getenv("DEPLOYMENT_STRATEGY", "FORCE").upper()

    detail = event.get("detail", {})
    action = detail.get("action-type")
    result = detail.get("result")
    image_tag = detail.get("image-tag") or detail.get("imageTags", [None])[0]

    if action != "PUSH" or result != "SUCCESS":
        print("Ignoring event: not a successful PUSH action")
        return {"ignored": True}

    print(f"Detected new image tag: {image_tag}")

    if strategy == "FORCE":
        # Assumes the task definition uses a mutable tag (e.g., 'latest').
        _force_new_deployment(cluster, service)
        return {"status": "ok", "mode": "forceNewDeployment"}

    # Otherwise, register a new task definition revision with the specific tag from event
    if not image_tag:
        raise RuntimeError("Event did not include 'image-tag' and DEPLOYMENT_STRATEGY != FORCE")

    new_image = f"{repo_uri}:{image_tag}"
    print(f"Will register new task definition with image: {new_image}")

    # Get current service task definition
    svc = ecs.describe_services(cluster=cluster, services=[service])
    if len(svc.get("services", [])) == 0:
        raise RuntimeError(f"Service not found: {service}")
    td_arn = svc["services"][0]["taskDefinition"]

    td = ecs.describe_task_definition(taskDefinition=td_arn)
    existing_td = td["taskDefinition"]

    new_td_arn = _register_new_task_def_with_image(existing_td, new_image)
    print(f"Registered new task definition: {new_td_arn}")

    ecs.update_service(cluster=cluster, service=service, taskDefinition=new_td_arn)
    print("Service updated to new task definition")

    return {"status": "ok", "mode": "registerTaskDefinition", "taskDefinition": new_td_arn}
