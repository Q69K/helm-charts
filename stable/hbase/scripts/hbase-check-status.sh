#!/usr/bin/env bash
# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Exit on error inside any functions or subshells.
set -o errtrace
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch an error in command pipes.
set -o pipefail
# Turn on traces, useful while debugging.
set -o xtrace

# Check if region server registered with the master and got non-null cluster ID.
_PORTS="16030"
_URL_PATH="jmx?qry=Hadoop:service=HBase,name=RegionServer,sub=Server"
_CLUSTER_ID=""
for _PORT in $_PORTS; do
_CLUSTER_ID+=$(curl -s http://localhost:"${_PORT}"/"$_URL_PATH" |  \
    grep clusterId) || true
done
echo "$_CLUSTER_ID" | grep -q -v null
