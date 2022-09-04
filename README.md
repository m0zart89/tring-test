# tring-test

Docker env parameters:
* HTTP_PORT (default 80)
* HTTPS_PORT (default disabled)
* SSL_CERTIFICATE (default disabled)
* SSL_CERTIFICATE_KEY (default disabled)
* STATIC_PATH (default /usr/share/nginx/html)

1. Clone repo:
```
git clone git@github.com:m0zart89/tring-test.git
```

2. HTTP Server:
```
sudo docker run \
 -p 82:82 -e HTTP_PORT=82 \
 -it mozart89/tring-test
```
Result:
[http://localhost:82/](http://localhost:82/)


3. HTTPS Server:
```
sudo docker run \
 -p 1443:1443 -e HTTPS_PORT=1443 \
 -e SSL_CERTIFICATE=/foo/bar/file.cert \
 -e SSL_CERTIFICATE_KEY=/foo/bar/file.key \
 -v /home/eugen/repos/test/cert:/foo/bar \
 -it mozart89/tring-test
```
Result:
[https://localhost:1443/](https://localhost:1443/)


4. File Server:
```
sudo docker run \
 -p 80:80 \
 -e STATIC_PATH=/path/to/static/files \
 -v /home/eugen/repos/test/static:/path/to/static/files \
 -it mozart89/tring-test
```

Result:
[http://localhost/test.png](http://localhost/test.png)

