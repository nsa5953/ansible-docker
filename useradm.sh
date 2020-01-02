#!/bin/bash
__create_user() {
  # Create a user to SSH into as.
  useradd user
  SSH_USERPASS=newpass
  echo -e "$SSH_USERPASS\n$SSH_USERPASS" | (passwd --stdin user)
  echo ssh user password: $SSH_USERPASS
}

__add_user_to_sudoers() {
  echo "user ALL=(ALL:ALL) NOPASSWD: ALL" | (EDITOR="tee -a" visudo)
}

__passwordless_user_auth(){
mkdir -p /home/user/.ssh
chmod 700 /home/user/.ssh
touch /home/user/.ssh/authorized_keys
chmod 600 /home/user/.ssh/authorized_keys
cat /tmp/id_rsa.pub > /home/user/.ssh/authorized_keys
chown -R user /home/user/.ssh
rm -f /tmp/id_rsa.pub
}

# Call all functions
__create_user
__add_user_to_sudoers
__passwordless_user_auth
