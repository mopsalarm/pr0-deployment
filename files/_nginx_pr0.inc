
ssl_session_cache shared:SSL:1m;
ssl_session_timeout 1440m;

ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
ssl_prefer_server_ciphers on;

# Using list of ciphers from "Bulletproof SSL and TLS"
ssl_ciphers "ECDHE-ECDSA-AES128-GCM-SHA256 ECDHE-ECDSA-AES256-GCM-SHA384 ECDHE-ECDSA-AES128-SHA ECDHE-ECDSA-AES256-SHA ECDHE-ECDSA-AES128-SHA256 ECDHE-ECDSA-AES256-SHA384 ECDHE-RSA-AES128-GCM-SHA256 ECDHE-RSA-AES256-GCM-SHA384 ECDHE-RSA-AES128-SHA ECDHE-RSA-AES128-SHA256 ECDHE-RSA-AES256-SHA384 DHE-RSA-AES128-GCM-SHA256 DHE-RSA-AES256-GCM-SHA384 DHE-RSA-AES128-SHA DHE-RSA-AES256-SHA DHE-RSA-AES128-SHA256 DHE-RSA-AES256-SHA256 EDH-RSA-DES-CBC3-SHA";

ssl_stapling on;
ssl_stapling_verify on;

location ~ ^/api/thumby/v1/(.+)/thumb.jpg$ {
  proxy_pass http://172.17.42.1:15001/$1;
  proxy_cache thumby;
  expires 1y;
}

location ^~ /api/gif-to-webm/v1/ {
  proxy_pass http://172.17.42.1:15000/;
  proxy_cache webm;
  expires 1y;
}

location ^~ /api/meta/v1/ {
  proxy_pass http://172.17.42.1:15003/;
  proxy_connect_timeout 2s;
  proxy_read_timeout 2s;
  proxy_send_timeout 2s;
}

location ^~ /api/feedback/v1/ {
  proxy_pass http://172.17.42.1:15002/;
}

location ^~ /api/categories/v1/ {
  proxy_pass http://172.17.42.1:15050/;
}

location ^~ /api/comments/v1/ {
  proxy_pass http://172.17.42.1:15051/;
}

location /api/ {
  proxy_pass http://pr0gramm.com/api/;
  proxy_pass_request_headers on;
}

location = /basic_status {
  stub_status;
}

location /static/ {
  alias /data/nginx/static/;
}

location /.well-known/ {
  alias /data/nginx/static/.well-known/;
}

location = /update.json {
  rewrite ^ $scheme://raw.githubusercontent.com/mopsalarm/pr0gramm-updates/beta/open/update.json;
}

location = /beta/update.json {
  rewrite ^ $scheme://raw.githubusercontent.com/mopsalarm/pr0gramm-updates/beta/open/update.json;
}
