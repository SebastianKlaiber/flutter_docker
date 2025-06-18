#!/bin/bash

# Script to build and push Flutter Docker image to GitHub Container Registry
# Usage: ./build-and-push.sh <version>
# Example: ./build-and-push.sh 1.1.7-fvm

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_step() {
    echo -e "${BLUE}[STEP]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Check if version parameter is provided
if [ $# -eq 0 ]; then
    print_error "Version parameter is required!"
    echo "Usage: $0 <version>"
    echo "Example: $0 1.1.7-fvm"
    exit 1
fi

VERSION=$1
IMAGE_NAME="flutter_docker"
REGISTRY="ghcr.io/sebastianklaiber/flutter_docker"
FULL_TAG="${REGISTRY}/${IMAGE_NAME}:${VERSION}"

echo "================================================"
echo "Flutter Docker Build & Push Automation"
echo "================================================"
echo "Version: ${VERSION}"
echo "Registry: ${REGISTRY}"
echo "Full Tag: ${FULL_TAG}"
echo "================================================"

# Step 1: Build the Docker image
print_step "Building Docker image..."
if docker build --tag ${IMAGE_NAME}:latest .; then
    print_success "Docker image built successfully"
else
    print_error "Failed to build Docker image"
    exit 1
fi

# Step 2: Tag the image for the registry
print_step "Tagging image for registry..."
if docker tag ${IMAGE_NAME} ${FULL_TAG}; then
    print_success "Image tagged successfully"
else
    print_error "Failed to tag image"
    exit 1
fi

# Step 3: Push the image to the registry
print_step "Pushing image to registry..."
if docker push ${FULL_TAG}; then
    print_success "Image pushed successfully"
else
    print_error "Failed to push image"
    print_warning "Make sure you're logged in to GitHub Container Registry:"
    print_warning "docker login ghcr.io -u <username> -p <token>"
    exit 1
fi

echo "================================================"
print_success "All steps completed successfully!"
echo "Image available at: ${FULL_TAG}"
echo "================================================"

# Optional: Clean up local images to save space
read -p "Do you want to clean up local images? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_step "Cleaning up local images..."
    docker rmi ${IMAGE_NAME}:latest ${FULL_TAG} 2>/dev/null || true
    print_success "Local images cleaned up"
fi 