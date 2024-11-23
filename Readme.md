This repo contains a dockerfile which builds a container with grafana, prometheus and node exporter. This can be easily run on a server and grafana with hosts stats can be as simple as forwarding a port.

# Building

```bash
docker build -t grafana-prometheus-node-exporter .
```

# Running

```bash
docker run \
     -e GF_SECURITY_ADMIN_PASSWORD="admin2" \
     -v=/proc:/host/proc:ro \
     -p 3000:3000 \
     grafana-prometheus-node-exporter
```
