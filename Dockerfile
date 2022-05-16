FROM ubuntu:latest

RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" TZ="Europe/Dublin" apt-get install -y git php8.1 php8.1-simplexml php8.1-dom php8.1-gd php8.1-sqlite3 php8.1-curl php8.1-zip php8.1-bz2 wget
#php7.4 php7.4-simplexml php7.4-dom php7.4-gd php7.4-sqlite3 php7.4-curl php7.4-bz2 php7.4-zip wget

RUN addgroup --system pts && adduser --system pts --group

WORKDIR /home/pts

RUN git clone https://github.com/phoronix-test-suite/phoronix-test-suite .

COPY ./phoronix-test-suite.xml /home/pts/.phoronix-test-suite/user-config.xml

RUN /home/pts/install-sh

COPY ./phoronix-test-suite.xml /etc/

RUN apt-get remove --purge -y --allow-remove-essential apt git && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 15000

CMD ["/usr/bin/phoronix-test-suite","start-phoromatic-server"]
HEALTHCHECK --interval=30s --timeout=5s\
    CMD wget --spider -S http://localhost:15000 2>&1 > /dev/null | grep -q "200 OK$"
