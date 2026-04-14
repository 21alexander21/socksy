# socksy

Lightweight SOCKS5 proxy server, optimized for Telegram. Built on [microsocks](https://github.com/rofl0r/microsocks) — a tiny, fast, portable SOCKS5 server written in C.

## Features

- IPv4 + IPv6 dual-stack support (important for Telegram)
- Minimal attack surface — statically compiled binary, non-root user, read-only filesystem
- Username/password authentication
- Single-process, low memory (~64MB limit)
- Docker-first deployment

## Quick start

```bash
cp .env.example .env
# set SOCKS_USER and SOCKS_PASS in .env
docker compose up -d
```

The proxy is now available at `your-server-ip:1080`.

## Telegram setup

1. Open Telegram → Settings → Data and Storage → Proxy
2. Add Proxy → SOCKS5
3. Set **Server** to your host IP, **Port** to `1080`
4. Enter **Username** and **Password** from your `.env`
5. Save and connect

## Configuration

All settings are in `.env` (see [.env.example](.env.example)):

| Variable | Default | Description |
|---|---|---|
| `SOCKS_PORT` | `1080` | Port to listen on |
| `SOCKS_USER` | *(required)* | Auth username |
| `SOCKS_PASS` | *(required)* | Auth password |

## Networking

The default `docker-compose.yml` uses `network_mode: host` so the proxy listens directly on the host network with full IPv4/IPv6 support. This is the simplest setup and works out of the box with Telegram.

If you prefer Docker's bridge networking, replace `network_mode: host` with explicit port bindings and ensure [Docker IPv6 is enabled](https://docs.docker.com/config/daemon/ipv6/).

## Security notes

- The container runs as a non-root user with all capabilities dropped
- `no-new-privileges` and `read_only` are enabled
- **Always set `SOCKS_USER` and `SOCKS_PASS`** on public-facing servers to prevent unauthorized use
- Consider placing behind a firewall that only allows traffic from Telegram subnets

## License

MIT
