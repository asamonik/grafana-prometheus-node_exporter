# other stuff
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# random pkgs
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    tar \
    gzip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

# version variables
ARG PROMETHEUS_VERSION=3.0.0
ARG NODE_EXPORTER_VERSION=1.8.2
ARG GRAFANA_VERSION=11.3.1

# prometheus
RUN wget https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz \
    && tar -xvf prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz \
    && mv prometheus-${PROMETHEUS_VERSION}.linux-amd64 prometheus \
    && rm prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz

# node exporter
RUN wget https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz \
    && tar -xvf node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz \
    && mv node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64 node_exporter \
    && rm node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz

# grafana enterprise
RUN wget https://dl.grafana.com/enterprise/release/grafana-enterprise-${GRAFANA_VERSION}.linux-amd64.tar.gz \
    && tar -zxvf grafana-enterprise-${GRAFANA_VERSION}.linux-amd64.tar.gz \
    && mv grafana-v${GRAFANA_VERSION} grafana \
    && rm grafana-enterprise-${GRAFANA_VERSION}.linux-amd64.tar.gz

COPY ./prometheus.yml /opt/prometheus/prometheus.yml

# copy default datasource and dashboards
COPY ./provisioning /opt/grafana/conf/provisioning
COPY ./dashboards /opt/grafana/conf/dashboards

CMD ["/bin/bash", "-c", " \
    /opt/node_exporter/node_exporter --path.procfs=/host/proc & \
    /opt/prometheus/prometheus --config.file=/opt/prometheus/prometheus.yml --storage.tsdb.path=/opt/prometheus/data & \
    GF_SECURITY_ADMIN_PASSWORD=${GF_SECURITY_ADMIN_PASSWORD} /opt/grafana/bin/grafana-server --homepath=/opt/grafana" ]
