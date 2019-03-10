#!/bin/bash
# Setup script for video manager envrionment

echo "Creating postgres docker volume"
mkdir -p ~/.video-manager/postgres
echo "Creating pgadmin docker volume"
mkdir -p ~/.video-manager/pgadmin