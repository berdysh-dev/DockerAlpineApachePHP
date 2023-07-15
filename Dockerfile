FROM alpine:latest

MAINTAINER 0.1 http://berdysh.net/

RUN adduser -u 1200 mysql ; exit 0
RUN adduser -u 1201 postgres ; exit 0
RUN adduser -u 1202 redis ; exit 0
RUN adduser -u 1204 nginx ; exit 0
RUN adduser -u 1205 apache ; exit 0
RUN adduser -u 1206 sshd ; exit 0

RUN apk update
RUN apk add git tcsh vim bind-tools bash tcsh busybox busybox-extras build-base linux-headers alpine-sdk libtool autoconf \
bison re2c \
expat expat-dev expat-static libexpat \
pcre pcre-dev pcre2 pcre2-dev postfix-pcre \
sqlite sqlite-dev sqlite-doc sqlite-libs sqlite-static \
libxml2 libxml2-dbg libxml2-dev libxml2-doc libxml2-static libxml2-utils libxmlb libxmlb-dbg libxmlb-dev \
libpng libpng-dev libpng-static libpng-utils \
oniguruma oniguruma-dev \
tidyhtml tidyhtml-dev tidyhtml-libs tidyhtml-static \
yaml yaml-dev yaml-static yaml-cpp yaml-cpp-dev \
libsodium libsodium-dev libsodium-static \
libuuid uuidgen \
lua5.4 \
c-ares c-ares-dev c-ares-static \
libevent libevent-dev libevent-static \
libssh2 libssh2-dev libssh2-static


RUN apk add rsyslog
RUN apk add libcurl curl curl-dev curl-static
RUN apk add grpc protobuf
RUN apk add libmaxminddb libmaxminddb-dev php81-pecl-maxminddb
RUN apk add redis
RUN apk add mariadb mariadb-client mariadb-common mariadb-connector-c-dev mysql-dev mysql-client
RUN apk add postgresql libpq libpq-dev

COPY SRC /usr/local/src

RUN cd /usr/local/src ; tar xzf apr-1.7.4.tar.gz ; tar xzf apr-util-1.6.3.tar.gz ; tar xzf apr-iconv-1.2.2.tar.gz ; tar xzf httpd-2.4.57.tar.gz ;


RUN cd /usr/local/src ; tar xzf php-8.3.0alpha3.tar.gz ; \
tar xzf event-3.0.8.tgz ; tar xzf grpc-1.56.0.tgz ; tar xzf igbinary-3.2.14.tgz ; tar xzf memcache-8.2.tgz ; \
tar xzf memcached-3.2.0.tgz ; tar xzf msgpack-2.2.0.tgz ; tar xzf openswoole-22.0.0.tgz ; tar xzf protobuf-3.23.4.tgz ; \
tar xzf redis-5.3.7.tgz ; tar xzf ssh2-1.4.tgz ; tar xzf swoole-5.0.3.tgz ; tar xzf uuid-1.2.0.tgz ; tar xzf xdebug-3.2.1.tgz ; \
tar xzf yaml-2.2.3.tgz ; tar xzf zstd-0.12.3.tgz ; exit 0 ;

RUN export RM="rm -f" ; cd /usr/local/src/apr-1.7.4         ; ./configure ; make ; make install
RUN export RM="rm -f" ; cd /usr/local/src/apr-iconv-1.2.2   ; ./configure --with-apr=/usr/local/apr/bin/apr-1-config ; make ; make install
RUN export RM="rm -f" ; cd /usr/local/src/apr-util-1.6.3    ; ./configure --with-apr=/usr/local/apr/bin/apr-1-config ; make ; make install
RUN export RM="rm -f" ; cd /usr/local/src/httpd-2.4.57      ; ./configure --with-apr=/usr/local/apr/bin/apr-1-config ; make ; make install

COPY mk.sh /usr/local/src

# RUN cd /usr/local/src ; mv event-3.0.8 ssh2-1.4 uuid-1.2.0 yaml-2.2.3 zstd-0.12.3 /usr/local/src/php-src-php-8.3.0alpha3/ext
RUN cd /usr/local/src ; mv uuid-1.2.0 yaml-2.2.3 zstd-0.12.3 /usr/local/src/php-src-php-8.3.0alpha3/ext

RUN cd /usr/local/src/php-src-php-8.3.0alpha3 ; sh ../mk.sh ; exit 0 ;

COPY httpd.conf /usr/local/apache2/conf/httpd.conf

COPY php.ini /usr/local/lib/php.ini

COPY entry.sh /usr/local/bin/entry.sh

CMD ["sh","/usr/local/bin/entry.sh"]




















