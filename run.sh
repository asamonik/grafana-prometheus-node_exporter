docker stop $(docker ps -q) -t 0
docker build -t grafana-prometheus-node-exporter .
docker run \
    -e GF_SECURITY_ADMIN_PASSWORD="admin2" \
    -p 3000:3000 \
    -v=/proc:/host/proc:ro \
    grafana-prometheus-node-exporter
