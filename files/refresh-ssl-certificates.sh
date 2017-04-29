#!/bin/sh
set -e

docker pull quay.io/letsencrypt/letsencrypt:latest
docker rm -f letsencrypt || true

for DOMAIN in pr0.wibbly-wobbly.de app.pr0gramm.com ; do
  docker run --rm --name letsencrypt \
    -v "/data/nginx/static:/webroot" \
    -v "/data/nginx/ssl:/etc/letsencrypt" \
    -v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
    quay.io/letsencrypt/letsencrypt:latest \
      auth -d $DOMAIN \
      --webroot --webroot-path /webroot \
      -m mopsalarm.pr0gramm@gmx.de \
      --renew-by-default --agree-tos
done

echo "reloading nginx"
docker exec nginx nginx -s reload
