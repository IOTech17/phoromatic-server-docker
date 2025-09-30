FROM debian:stable-slim

RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" TZ="Europe/Dublin" apt-get install -y git php8.4 php8.4-simplexml php8.4-dom php8.4-gd php8.4-sqlite3 php8.4-curl php8.4-zip php8.4-bz2 wget

WORKDIR /home/pts

RUN git clone https://github.com/phoronix-test-suite/phoronix-test-suite .

COPY ./phoronix-test-suite.xml /home/pts/.phoronix-test-suite/user-config.xml

RUN /home/pts/install-sh

COPY ./phoronix-test-suite.xml /etc/

RUN apt-get remove --purge -y --allow-remove-essential apt git && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 15000

CMD ["/usr/bin/phoronix-test-suite","start-phoromatic-server"]
