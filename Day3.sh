#Write a script to pull code changes from the development branch, build a Docker image, and push it to a private Docker Hub registry.

#!/bin/bash

# Fail on error
set -e

# Variables (Update these)
REPO_URL="https://github.com/your-org/your-repo.git"
CLONE_DIR="/tmp/myapp"
BRANCH="development"
DOCKER_IMAGE_NAME="yourdockerhubusername/yourimagename"
DOCKER_TAG="latest"
DOCKERHUB_USERNAME="yourdockerhubusername"
DOCKERHUB_PASSWORD="yourdockerhubpassword"

# Clone or pull latest changes
if [ -d "$CLONE_DIR" ]; then
    echo "Directory exists. Pulling latest changes..."
    cd "$CLONE_DIR"
    git checkout $BRANCH
    git pull origin $BRANCH
else
    echo "Cloning repository..."
    git clone -b $BRANCH $REPO_URL "$CLONE_DIR"
    cd "$CLONE_DIR"
fi

# Log in to Docker Hub (private registry)
#Using --password-stdin is more secure than passing the password directly as a CLI argument (like --password), because:

# It avoids the password showing up in the process list (which is visible to other users on the same system).

# It works well in CI/CD pipelines and automation scripts.

echo "$DOCKERHUB_PASSWORD" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin

# if the passwords are stored in AWS secrets manager and if we want to use it
#use
#!/bin/bash

# Step 1: Fetch secret JSON from Secrets Manager
# secret_json=$(aws secretsmanager get-secret-value --secret-id dockerhub/credentials --query SecretString --output text)

# # Step 2: Extract username and password from JSON
# DOCKERHUB_USERNAME=$(echo "$secret_json" | jq -r '.username')
# DOCKERHUB_PASSWORD=$(echo "$secret_json" | jq -r '.password')

# # Step 3: Login to Docker
# echo "$DOCKERHUB_PASSWORD" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin


# Build the Docker image
echo "Building Docker image..."
docker build -t "$DOCKER_IMAGE_NAME:$DOCKER_TAG" .

# Push to Docker Hub
echo "Pushing Docker image to private Docker Hub registry..."
docker push "$DOCKER_IMAGE_NAME:$DOCKER_TAG"

echo "✅ Docker image pushed successfully!"
