# tring-test

Dockerfile env parameters:
* HTTP_PORT (default 80)
* HTTPS_PORT (default disabled)
* SSL_CERTIFICATE (default disabled)
* SSL_CERTIFICATE_KEY (default disabled)
* STATIC_PATH (default /usr/share/nginx/html)

Dockerfile build usage:
```
docker build . \
 -f Dockerfile \
 -t mozart89/tring-test \
 -e HTTP_PORT=81 \
 -e HTTPS_PORT=1443 \ # work simultaneously
 -e SSL_CERTIFICATE=/foo/bar1/file.cert \ # work simultaneously
 -e SSL_CERTIFICATE_KEY=/foo/bar2/file.key \ # work simultaneously
 -e STATIC_PATH=/foo/bar3
```
