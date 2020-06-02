#!/bin/bash

phpv=php7.4


## enable root ssh
sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
systemctl restart sshd

apt-get install -y apache2 $phpv $phpv-cli


#Make sure user www-data has bash shell
sed -i "s/^www-data:x.*/www-data:x:33:33:www-data:\/var\/www:\/bin\/bash/g" /etc/passwd
