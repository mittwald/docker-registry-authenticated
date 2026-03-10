#!/bin/sh

if [ -z "$REGISTRY_USER" ] || [ -z "$REGISTRY_PASSWORD" ]; then
  echo "Error: REGISTRY_USER and REGISTRY_PASSWORD environment variables must be set."
  exit 1
fi

htpasswd -Bbc /tmp/htpasswd $REGISTRY_USER $REGISTRY_PASSWORD

set -x

export REGISTRY_AUTH=htpasswd
export REGISTRY_AUTH_HTPASSWD_REALM="${REGISTRY_AUTH_HTPASSWD_REALM:-Registry Realm}"
export REGISTRY_AUTH_HTPASSWD_PATH=/tmp/htpasswd

exec /bin/sh entrypoint.sh "$@"