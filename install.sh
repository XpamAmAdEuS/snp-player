#!/bin/bash

phpv=php7.4

apt install -y curl sudo


## enable root ssh
sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
systemctl restart sshd

##enable sury repository
curl -sSL https://packages.sury.org/php/README.txt | sudo bash -x
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

apt install -y apache2 $phpv $phpv-cli $phpv-fpm $phpv-curl $phpv-json $phpv-mbstring $phpv-xml $phpv-zip php-phalcon4 vlc lftp

##apt remove --purge -y libapache2-mod-$phpv

a2enmod proxy_fcgi setenvif rewrite
a2enconf $phpv-fpm

wget -O /usr/bin/zephir https://github.com/phalcon/zephir/releases/download/0.12.19/zephir.phar
chmod +x /usr/bin/zephir

#Make sure user www-data has bash shell
sed -i "s/^www-data:x.*/www-data:x:33:33:www-data:\/var\/www:\/bin\/bash/g" /etc/passwd

systemctl restart apache2
systemctl restart $phpv-fpm


