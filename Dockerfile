FROM nginx:1.25-alpine

# Копируем конфиг как шаблон
COPY nginx-cloudrun.conf /etc/nginx/nginx.conf
# Копируем entrypoint
COPY docker-entrypoint.sh /docker-entrypoint.sh

# Создаём нужные директории и даём права пользователю nginx
RUN mkdir -p /tmp/client_body /tmp/proxy_temp /tmp/fastcgi_temp \
             /tmp/uwsgi_temp /tmp/scgi_temp \
             /var/log/nginx \
    && chown -R nginx:nginx \
             /tmp/client_body /tmp/proxy_temp /tmp/fastcgi_temp \
             /tmp/uwsgi_temp /tmp/scgi_temp \
             /var/log/nginx \
             /etc/nginx \
    && touch /tmp/nginx.pid \
    && chown nginx:nginx /tmp/nginx.pid \
    && chmod +x /docker-entrypoint.sh

USER nginx


ENV LISTEN_PORT=8080

EXPOSE 8080

ENTRYPOINT ["/docker-entrypoint.sh"]
