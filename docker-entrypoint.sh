#!/bin/sh
set -e

echo "Starting nginx:"

nginx -t

exec nginx -g 'daemon off;'
