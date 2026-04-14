#!/bin/sh
set -e

PORT="${SOCKS_PORT:-1080}"
BACKEND_PORT=10800
ARGS="-p $BACKEND_PORT -b 127.0.0.1"

if [ -n "$SOCKS_USER" ] && [ -n "$SOCKS_PASS" ]; then
  ARGS="$ARGS -1 -u $SOCKS_USER -P $SOCKS_PASS"
fi

# Dual-stack (IPv4+IPv6) listener, relay to microsocks on loopback
socat TCP6-LISTEN:$PORT,ipv6only=0,reuseaddr,fork TCP4:127.0.0.1:$BACKEND_PORT &

exec /usr/local/bin/microsocks $ARGS
