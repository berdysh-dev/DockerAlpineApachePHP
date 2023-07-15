#! /bin/sh

cd /usr/local/src/php-src-php-8.3.0alpha3 ; ./buildconf --force ; \
./configure --with-apxs2=/usr/local/apache2/bin/apxs --enable-fpm --enable-gd --enable-mbstring --enable-sockets \
--enable-sysvmsg --enable-sysvsem --enable-sysvshm \
--with-pdo-mysql --with-mysqli --enable-mysqlnd --with-pdo-pgsql --with-pgsql \
--with-openssl --with-curl --with-zlib --with-bz2 --enable-zstd   --with-libzstd --with-yaml --with-expat --with-tidy \
--with-lua \
--with-sodium --with-uuid --enable-cares \
--with-event-core --enable-event-sockets \
; make ; make install ;




















