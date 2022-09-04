# tring-test

Docker env parameters:
* HTTP_PORT (default 80)
* HTTPS_PORT (default disabled)
* SSL_CERTIFICATE (default disabled)
* SSL_CERTIFICATE_KEY (default disabled)
* STATIC_PATH (default /usr/share/nginx/html)

Docker image usage:
```
sudo docker run \
 -p 82:82 \
 -e HTTP_PORT=82 \
 -it mozart89/tring-test
```

```
sudo docker run \
 -p 1443:1443 \
 -e HTTPS_PORT=1443 \ # work simultaneously
 -e SSL_CERTIFICATE=/foo/bar1/file.cert \ # work simultaneously
 -e SSL_CERTIFICATE_KEY=/foo/bar2/file.key \ # work simultaneously
 -it mozart89/tring-test
```

```
sudo docker run \
 -e STATIC_PATH=/path/to/static/files \
 -it mozart89/tring-test
```
