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
 -p 82:82 -e HTTP_PORT=82 \
 -it mozart89/tring-test
```

```
sudo docker run \
 -p 1443:1443 -e HTTPS_PORT=1443 \ # work simultaneously
 -e SSL_CERTIFICATE=/foo/bar/file.cert \ # work simultaneously
 -e SSL_CERTIFICATE_KEY=/foo/bar/file.key \ # work simultaneously
 -v /home/eugen/repos/test/cert:/foo/bar \
 -it mozart89/tring-test
```

```
sudo docker run \
 -p 80:80 \
 -e STATIC_PATH=/path/to/static/files \
 -v /home/eugen/repos/test/static:/path/to/static/files \
 -it mozart89/tring-test
```
