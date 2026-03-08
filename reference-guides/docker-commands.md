# Docker Commands Reference

Essential Docker commands for container management, building, and deployment in production environments.

## Image Management
```bash
# Build image
docker build -t myapp:latest .

# Build with no cache
docker build --no-cache -t myapp:latest .

# Tag image
docker tag myapp:latest myregistry.azurecr.io/myapp:v1.0.0

# List images
docker images

# Remove image
docker rmi myapp:latest

# Remove dangling images
docker image prune -f

# Save image to tar
docker save myapp:latest > myapp.tar

# Load image from tar
docker load < myapp.tar
```

## Container Management
```bash
# Run container
docker run -d --name mycontainer -p 8080:80 myapp:latest

# Run with environment variables
docker run -d --name mycontainer -p 8080:80 -e ENV=production myapp:latest

# Run with volume mount
docker run -d --name mycontainer -v /host/path:/container/path myapp:latest

# List running containers
docker ps

# List all containers
docker ps -a

# Stop container
docker stop mycontainer

# Start container
docker start mycontainer

# Restart container
docker restart mycontainer

# Remove container
docker rm mycontainer

# Remove all stopped containers
docker container prune -f
```

## Container Operations
```bash
# View container logs
docker logs mycontainer

# Follow logs
docker logs -f mycontainer

# Execute command in container
docker exec -it mycontainer /bin/bash

# Copy files to container
docker cp ./file.txt mycontainer:/app/file.txt

# Copy files from container
docker cp mycontainer:/app/file.txt ./file.txt

# Inspect container
docker inspect mycontainer

# View container stats
docker stats mycontainer
```

## Registry Operations
```bash
# Login to registry
docker login myregistry.azurecr.io

# Push image
docker push myregistry.azurecr.io/myapp:v1.0.0

# Pull image
docker pull myregistry.azurecr.io/myapp:v1.0.0

# Search registry
docker search nginx
```

## Docker Compose
```bash
# Start services
docker-compose up -d

# Start with build
docker-compose up --build -d

# Stop services
docker-compose down

# View logs
docker-compose logs

# Scale service
docker-compose up -d --scale web=3

# Execute command in service
docker-compose exec web bash
```

## Networking
```bash
# List networks
docker network ls

# Create network
docker network create mynetwork

# Connect container to network
docker network connect mynetwork mycontainer

# Disconnect container from network
docker network disconnect mynetwork mycontainer

# Inspect network
docker network inspect mynetwork
```

## Volumes
```bash
# List volumes
docker volume ls

# Create volume
docker volume create myvolume

# Remove volume
docker volume rm myvolume

# Inspect volume
docker volume inspect myvolume

# Remove unused volumes
docker volume prune -f
```

## Multi-stage Builds
```dockerfile
# Example Dockerfile
FROM golang:1.19 AS builder
WORKDIR /app
COPY . .
RUN go build -o myapp .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /app/myapp .
CMD ["./myapp"]
```

## Security
```bash
# Scan image for vulnerabilities
docker scan myapp:latest

# Run container as non-root
docker run -d --user 1000:1000 myapp:latest

# Use security options
docker run --security-opt no-new-privileges myapp:latest
```

## Performance
```bash
# View system-wide info
docker system info

# View disk usage
docker system df

# Clean up everything
docker system prune -a --volumes -f

# View events
docker events
```

## Best Practices
- Use multi-stage builds to reduce image size
- Don't run containers as root
- Use .dockerignore file
- Tag images with semantic versions
- Regularly update base images
- Use health checks in Dockerfiles
- Implement proper logging
- Use secrets for sensitive data
- Monitor container resource usage
- Keep images minimal and secure