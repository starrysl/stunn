#!/bin/bash
. ssh-forward.conf
cd $DIR

/usr/bin/screen -dmS ssh /bin/bash ssh-forward.sh
