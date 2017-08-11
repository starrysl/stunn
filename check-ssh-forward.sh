#!/bin/bash
. ssh-forward.conf
 
CONNECT=`ssh $LOCAL_USER@$REMOTE_HOST -p $LOCAL_PORT $SSH_PARAMS "date"`
if [ $? -ne 0 ]
then
    while [ 1 ]
    do 
        NUM=`ps -ef | grep "ssh" | grep $LOCAL_PORT | grep -v grep | wc -l`
        RET=`ps -ef | grep "ssh" | grep $LOCAL_PORT | grep -v grep | sort -u -k5`
        PID=`echo -e $RET | cut -d' ' -f2`
        if [ $NUM -eq 0 ]
        then 
            break
        else
            kill -HUP $PID
            echo -e "kill ssh tunnelling zombie process $PID\n"
        fi
    done
    exit 1
else
    /bin/date
    echo -e "No Problemo\n"
    exit 0
fi
