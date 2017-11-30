#!/bin/sh
set -e

docker pull certbot/certbot:v0.19.0
docker rm -f letsencrypt || true

for DOMAIN in pr0.wibbly-wobbly.de app.pr0gramm.com ; do
  docker run --rm --name letsencrypt \
    -v "/data/nginx/static:/webroot" \
    -v "/data/nginx/ssl:/etc/letsencrypt" \
    -v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
    certbot/certbot:v0.19.0 \
      auth -d $DOMAIN \
      --webroot --webroot-path /webroot \
      -m mopsalarm.pr0gramm@gmx.de \
      --renew-by-default --agree-tos
done

echo "reloading nginx"
docker exec nginx nginx -s reload
