#! /bin/sh

export LANG=C
export TZ=JST-9

/usr/local/apache2/bin/apachectl start

while test true
do
    echo DockerAlpineApachePHP
    date
    sleep 60
done



