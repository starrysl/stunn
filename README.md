Stunn - A fast and stable SSH port-forwarding tool
==================================================

About Stunn
-----------

Stunn is short for "Starry Tunnelling", which is a collection of bash scripts that I use for connecting my computers hidden inside an internal network (which has internet connections). It comes with a self-checking and automatic reconnection mechanism that keeps constant secure connection.

Requirements
------------
1. Bash environment (or any other sh)
2. A computer connected to internal network (but it must have internet connection), with ports opened (port 22 and 8848 by default).
3. A computer with a public IP address (static IP is preferred), with both ports opened (port 22 and 8848 by default).
4. OpenSSH (`sudo apt install openssh-server`)
5. (Optional) Screen (`sudo apt install screen`)

Customize configurations
------------------------
Rename "ssh-forward.conf.example" to "ssh-forward.conf", and modify it according to your server settings.

SSH public key settings
-----------------------
If you want password-less connection, please create an SSH key pairs on the local machine and send the public key to the remote server (steps as follows). If not, every time you start the service, you need to specify the password on the remote server.

Steps to set up SSH password-less connection:

1. On the local server, run `ssh-keygen -t rsa 2048`. Then press enter until it is fully executed.
2. There will be two files "id\_rsa" and "id\_rsa.pub" located in $HOME/.ssh/ folder. Send the public key "id\_rsa.pub" to your remote server by running `scp $HOME/.ssh/id_rsa.pub $REMOTE_USERNAME@$REMOTE_SERVER_IP:~/local_pubkey.pub`
3. SSH to the remote server, and run `mkdir -p ~/.ssh; cat ~/local_pubkey.pub >> ~/.ssh/authorized_keys`

Wala, now you can SSH to the remote machine from you local one without password prompts.
 
Start the service
-----------------
On the local server, run `bash ssh-forward.sh` to start the SSH tunneling service. If you have "screen" installed, you can also run `bash run-on-startup.sh` to run the service in the background. If you can also put "run-on-startup.sh" in crontab to start the SSH tunnelling service upon system reboot.

Connect the local server outside the internal network
-----------------------------------------------------
Just run `ssh $REMOTE_USERNAME@$REMOTE_SERVER_IP -p 8848` to connect to the server hidden inside an internal network.

Enjoy!
------
