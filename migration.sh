#!/bin/bash

container_names=("tower" "delivery" "inventory" "warehouse")

for container_name in "${container_names[@]}"; do
    if docker inspect -f '{{.State.Running}}' "$container_name" >/dev/null 2>&1; then
        echo "Docker container $container_name is running."
        
        docker exec "$container_name" npx prisma migrate dev
    else
        echo "Docker container $container_name is not running."
    fi
done