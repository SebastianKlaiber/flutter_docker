# Flutter Docker

This repository contains a Docker image for Flutter development with FVM (Flutter Version Management) support.

## Automated Build & Push

Use the provided script to automate the build and push process:

```bash
./build-and-push.sh <version>
```

Example:
```bash
./build-and-push.sh 1.1.7-fvm
```

The script will:
1. Build the Docker image locally
2. Tag it for GitHub Container Registry
3. Push it to `ghcr.io/sebastianklaiber/flutter_docker/flutter_docker:<version>`

## Manual Commands

If you prefer to run the commands manually:

```bash
docker build --tag flutter_docker:latest .
docker tag flutter_docker ghcr.io/sebastianklaiber/flutter_docker/flutter_docker:<version>
docker push ghcr.io/sebastianklaiber/flutter_docker/flutter_docker:<version>
```

## Prerequisites

Make sure you're logged in to GitHub Container Registry:

```bash
docker login ghcr.io -u <username> -p <token>
```

Where `<token>` is a GitHub Personal Access Token with `write:packages` permission.