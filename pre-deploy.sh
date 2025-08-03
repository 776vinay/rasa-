#!/bin/bash

# Create necessary directories
mkdir -p models

# Ensure correct permissions
chmod 644 config.yml domain.yml credentials.yml endpoints.yml
chmod 644 actions/*.py
chmod -R 755 models/

# Create directories if they don't exist
mkdir -p data
chmod 755 data

# Verify file existence and permissions
echo "Checking file permissions and existence..."
ls -l config.yml domain.yml credentials.yml endpoints.yml
ls -l actions/*.py
ls -ld models/ data/

echo "Pre-deployment setup complete!"
