# 创建prometheus挂在目录

prometheus_path=$PWD

mkdir -p $prometheus_path/monitor/prometheus
mv $prometheus_path/prometheus.yml  $prometheus_path/monitor/prometheus/prometheus.yml
mkdir $prometheus_path/monitor/prometheus_data

# 创建alertmanager挂在目录
mkdir -p $prometheus_path/monitor/alertmanager
mv   $prometheus_path/alertmanager-config.yml $prometheus_path/monitor/alertmanager/config.yml
# 创建grafana挂在目录
mkdir -p $prometheus_path/monitor/grafana_data
mkdir -p $prometheus_path/monitor/grafana/provisioning/dashboards
mkdir -p $prometheus_path/monitor/grafana/provisioning/datasources

mkdir -p $prometheus_path/caddy