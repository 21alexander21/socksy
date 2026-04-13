#!/bin/sh
set -e

ARGS="-p ${SOCKS_PORT:-1080} -b 0.0.0.0"

if [ -n "$SOCKS_USER" ] && [ -n "$SOCKS_PASS" ]; then
  ARGS="$ARGS -1 -u $SOCKS_USER -P $SOCKS_PASS"
fi

exec /usr/local/bin/microsocks $ARGS
