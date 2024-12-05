# Grafana-Prometheus-Node-Exporter

This repository contains a Docker setup to build and run a container with Grafana, Prometheus, and Node Exporter. This setup allows you to monitor system stats by deploying one container with one port forwarded.


## Building and Running the Docker Image

To build the Docker image, run the following command:

```bash
docker build -t grafana-prometheus-node-exporter .
```

To run the Docker container, use the following command:

```bash
docker run \
     -e GF_SECURITY_ADMIN_PASSWORD="secure_admin_password" \
     -v=/proc:/host/proc:ro \
     -p 3000:3000 \
     grafana-prometheus-node-exporter
```

## Using Docker Compose

Alternatively, you can use Docker Compose to build and run the container. First, ensure Docker Compose is installed, then run:

```bash
docker-compose up --build
```

## Configuration Files

- **Dockerfile**: Docker image instruction.
- **docker-compose.yml**: Sample deployment via docker-compose.
- **prometheus.yml**: Configuration file for Prometheus.
- **provisioning/dashboards/dashboard.yml**: Configuration for the default dashboard.
- **provisioning/datasources/prometheus.yml**: Configuration the Prometheus datasource in Grafana.
- **dashboards/NodeExporter.json**: Grafana dashboard configuration for Node Exporter metrics.