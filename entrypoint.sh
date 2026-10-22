#!/bin/bash
set -eu
if [ -n "${PORT:-}" ] && [ "$PORT" != "8080" ]; then
  case "$PORT" in
    *[!0-9]*) echo "PORT must be numeric" >&2; exit 1 ;;
  esac
  sed -i "s/port=\"8080\"/port=\"$PORT\"/" "$CATALINA_HOME/conf/server.xml"
fi
exec "$CATALINA_HOME/bin/catalina.sh" run
