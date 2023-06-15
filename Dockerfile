FROM ubuntu:latest

RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" TZ="Europe/Dublin" apt-get install -y git php8.2 php8.2-simplexml php8.2-dom php8.2-gd php8.2-sqlite3 php8.2-curl php8.2-zip php8.2-bz2 wget

RUN addgroup --system pts && adduser --system pts --group

WORKDIR /home/pts

RUN git clone https://github.com/phoronix-test-suite/phoronix-test-suite .

COPY ./phoronix-test-suite.xml /home/pts/.phoronix-test-suite/user-config.xml

RUN /home/pts/install-sh

COPY ./phoronix-test-suite.xml /etc/

RUN apt-get remove --purge -y --allow-remove-essential apt git && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 15000

CMD ["/usr/bin/phoronix-test-suite","start-phoromatic-server"]
#HEALTHCHECK --interval=30s --timeout=5s\
#    CMD wget --spider -S http://localhost:15000 2>&1 > /dev/null | grep -q "200 OK$"
