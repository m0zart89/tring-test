#!/bin/sh

HTTP_PORT="${HTTP_PORT:=80}"

HTTPS_PORT="${HTTPS_PORT:=}"
SSL_CERTIFICATE="${SSL_CERTIFICATE:=}"
SSL_CERTIFICATE_KEY="${SSL_CERTIFICATE_KEY:=}"

STATIC_PATH="${STATIC_PATH:=/usr/share/nginx/html}"


cat <<EOF >/etc/nginx/nginx.conf
# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/

user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '\$remote_addr - \$remote_user [\$time_local] "\$request" '
                      '\$status \$body_bytes_sent "\$http_referer" '
                      '"\$http_user_agent" "\$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

    server {
        listen       $HTTP_PORT default_server;
        listen       [::]:$HTTP_PORT default_server;
        server_name  _;
        root         $STATIC_PATH;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location / {
        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }

EOF

if [ ! -z "$HTTPS_PORT" ] && [ ! -z "$SSL_CERTIFICATE" ] && [ ! -z "$SSL_CERTIFICATE_KEY" ]
then

cat <<EOF >>/etc/nginx/nginx.conf
# Settings for a TLS enabled server
#
    server {
        listen       $HTTPS_PORT ssl http2 default_server;
        listen       [::]:$HTTPS_PORT ssl http2 default_server;
        server_name  _;
        root         $STATIC_PATH;

        ssl_certificate "$SSL_CERTIFICATE";
        ssl_certificate_key "$SSL_CERTIFICATE_KEY";
        ssl_session_cache shared:SSL:1m;
        ssl_session_timeout  10m;
        ssl_ciphers PROFILE=SYSTEM;
        ssl_prefer_server_ciphers on;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location / {
        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }

EOF


fi

cat <<EOF >>/etc/nginx/nginx.conf
}

EOF

cat /etc/nginx/nginx.conf

nginx -g 'daemon off;'
