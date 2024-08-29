Phoromatic server in a docker

docker composer

``` 
version: "3.8"
services:
  phoromatic-server:
    image: iotech17/phoromatic-server:latest
    ports:
      - 15000:15000
    volumes:
      - ptsconf:/var/lib/phoronix-test-suite
      - ptscache:/var/cache/phoronix-test-suite
    healthcheck:
      test: ["CMD-SHELL", "wget --no-check-certificate --spider -S http://localhost:15000 || exit 1"]
      interval: 30s
      timeout: 10s
      retries: 3
volumes:
  ptsconf:
  ptscache:
