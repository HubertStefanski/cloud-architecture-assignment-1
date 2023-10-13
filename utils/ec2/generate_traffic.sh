#!/usr/bin/bash
while sleep 2; do curl -X GET "$TRAFFIC_TARGET_URL"/ 2>&1 > /dev/null ; done