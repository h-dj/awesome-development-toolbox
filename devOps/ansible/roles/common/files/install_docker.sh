#!/bin/bash

# Check if Docker is already installed
if ! [ -x "$(command -v docker)" ]; then
    echo "Docker is not installed. Proceeding with the installation..."
    
    # Install Docker
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh --mirror Aliyun

    
    # Add current user to the 'docker' group
    sudo usermod -aG docker $USER

    
    echo "Docker installation completed."
else
    echo "Docker is already installed. Skipping the installation."
fi
