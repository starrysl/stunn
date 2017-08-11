#!/bin/bash
# V2: add configurable parameters 
# V1: change checking mechanism to prevent zombie process

. ssh-forward.conf

ssh -fNR $LOCAL_PORT:$LOCAL_HOST:$LOCAL_SSH_PORT $REMOTE_USER@$REMOTE_HOST -p $REMOTE_SSH_PORT $SSH_PARAMS 
sleep 5 

if [ ! -d ~/logs ]
then
    mkdir -p ~/logs
fi

while true
    do
	/bin/bash check-ssh-forward.sh
	RETURN_CODE=$?
	#echo $RETURN_CODE
        if [ $RETURN_CODE -eq 1 ]; then
            echo "the recent ssh disconnect at `date`" >> ~/logs/check_ssh.log
            echo "restart ssh connect"
            ssh -fNR $LOCAL_PORT:$LOCAL_HOST:$LOCAL_SSH_PORT $REMOTE_USER@$REMOTE_HOST -p $REMOTE_SSH_PORT $SSH_PARAMS 
	    sleep 5 
        else
	    #echo $RETURN_CODE
            echo "ssh connect at `date`"
	    # for crontab
	    #break
	    
	    # for screen
	    sleep $SLEEP_TIME 
        fi
    done
