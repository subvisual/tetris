#
# tetrominos app
# This is served under subvisual.co/tetrominos
# Most of the actual configs are handled in the config for subvisual.co
#

server {
  listen 443;
  server_name tetrominos.subvisual.co;

  error_page 404 /index.html;

  root /apps/tetrominos/subvisual.co/current;

  access_log /apps/tetrominos.subvisual.co/shared/log/nignx.out;
  error_log /apps/tetrominos.subvisual.co/shared/log/nignx.err;

  location ^~ /nginx.conf {
    return 404;
  }

  location / {
    index index.html;
  }

  location ~* \.(svg|jpg|jpeg|png|gif|ico|css|js)$ {
    gzip_static on;
    expires 365d;
    add_header Cache-Control public;
  }

  ssl_certificate     /etc/nginx/ssl/subvisual.co-2016/SSL.crt;
  ssl_certificate_key /etc/nginx/ssl/subvisual.co-2016/server.key;
  ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
  ssl_prefer_server_ciphers on;
  ssl_ciphers AES256+EECDH:AES256+EDH:!aNULL;
}

# www redirect
server {
  listen 80;
  listen 443 ssl;
  server_name www.tetrominos.subvisual.co;
  return 301 https://tetrominos.subvisual.co/$request_uri;

  ssl_certificate     /etc/nginx/ssl/subvisual.co-2016/SSL.crt;
  ssl_certificate_key /etc/nginx/ssl/subvisual.co-2016/server.key;
  ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
  ssl_prefer_server_ciphers on;
  ssl_ciphers AES256+EECDH:AES256+EDH:!aNULL;
}

# http redirect
server {
  listen 80;
  server_name tetrominos.subvisual.co;
  return 301 https://tetrominos.subvisual.co/$request_uri;

  ssl_certificate     /etc/nginx/ssl/subvisual.co-2016/SSL.crt;
  ssl_certificate_key /etc/nginx/ssl/subvisual.co-2016/server.key;
  ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
  ssl_prefer_server_ciphers on;
  ssl_ciphers AES256+EECDH:AES256+EDH:!aNULL;
}