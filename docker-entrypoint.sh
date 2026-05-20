#!/bin/sh
set -e

# Проверяем что обязательные переменные заданы
: "${BACKEND_HOST:?Переменная BACKEND_HOST не задана}"
: "${BACKEND_PORT:?Переменная BACKEND_PORT не задана}"
: "${LISTEN_PORT:=8443}"

echo "Starting nginx:"
echo "  LISTEN_PORT  = $LISTEN_PORT"
echo "  BACKEND_HOST = $BACKEND_HOST"
echo "  BACKEND_PORT = $BACKEND_PORT"

# envsubst подставляет переменные в шаблон и пишет финальный nginx.conf
envsubst '${BACKEND_HOST} ${BACKEND_PORT} ${LISTEN_PORT}' \
    < /etc/nginx/nginx.conf.template \
    > /etc/nginx/nginx.conf

# Проверяем конфиг
nginx -t

# Запускаем nginx
exec nginx -g 'daemon off;'
