#!/bin/bash
set -eoxu pipefail
INSTANCE_ID=$(ec2-metadata --instance-id | grep -oP 'instance-id: \K.*')

docker_stats=$(docker stats --all --no-stream --format '{{ json . }}')
echo "[$(sed '$!s/$/,/' <<< "$docker_stats")]" > stats.json
sed -i 's/\%//g' stats.json

declare -a metric_names=("CPUPerc" "MemPerc")

container_names=($(jq -r '.[].Name' stats.json))

for metric in "${metric_names[@]}"; do
  for ((i = 0; i < ${#container_names[@]}; i++)); do
    val=$(jq -r ".[$i].$metric" stats.json)
    aws cloudwatch put-metric-data --metric-name "${container_names[$i]}-$metric" --dimensions Instance="$INSTANCE_ID" --namespace "DockerStats" --unit "Percent" --value $val
  done
done
