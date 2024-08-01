Phoromatic server in a docker

docker composer

``` 
version: "3.8"
services:
  phoromatic-server:
    image: iotech17/phoromatic-server:latest
    ports:
      - 15000:15000
    healthcheck:
      test: wget --spider -S http://localhost:15000 2>&1 > /dev/null | grep -q "200 OK$"
      interval: 30s
      timeout: 1m
      retries: 2
