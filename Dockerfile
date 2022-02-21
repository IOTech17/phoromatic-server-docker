FROM ubuntu:20.04

RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" TZ="Europe/Dublin" apt-get install -y git php7.4 php7.4-simplexml php7.4-dom php7.4-gd php7.4-sqlite3 php7.4-curl php7.4-bz2 php7.4-zip
RUN addgroup --system pts && adduser --system pts --group

WORKDIR /home/pts

RUN git clone https://github.com/phoronix-test-suite/phoronix-test-suite .

COPY ./phoronix-test-suite.xml /home/pts/.phoronix-test-suite/user-config.xml

RUN /home/pts/install-sh

COPY ./phoronix-test-suite.xml /etc/

EXPOSE 15000

CMD ["/usr/bin/phoronix-test-suite","start-phoromatic-server"]
