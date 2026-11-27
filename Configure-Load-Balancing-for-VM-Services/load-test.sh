#!/bin/bash
echo "Starting load test..."
for i in {1..50}; do
  response=$(oc exec test-client -- curl -s -w "%{http_code}" http://webserver-clusterip)
  echo "Request $i: $response"
done
echo "Load test completed"
