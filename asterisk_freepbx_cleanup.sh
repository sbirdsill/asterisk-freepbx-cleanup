#!/bin/bash
#
# File name: asterisk_freepbx_cleanup.sh
# Description: Hopefully this bash script will clean up Asterisk and FreePBX along with all of its associated files.
# Last tested on Ubuntu 18.04 with FreePBX 14.0.5.2
# Version: 0.1

cleanup () {

# Asterisk cleanup
echo "Stopping Asterisk services..."
killall -9 safe_asterisk
killall asterisk
service asterisk stop
service fwconsole stop
service freepbx stop
service dahdi stop
echo "Removing Asterisk and its config files..."
apt-get purge "asterisk*" -y
apt-get purge "dahdi*" -y
rm -rf /etc/asterisk
rm -f /etc/dahdi.conf
rm -rf /var/log/asterisk
rm -rf /var/lib/asterisk
rm -rf /var/spool/asterisk
rm -rf /usr/lib/asterisk

# FreePBX cleanup
echo "Removing the FreePBX web files..."
rm -rf /var/www/html/freepbx # FreePBX web files (make sure to set this to the proper location)
echo "Removing FreePBX config files..."
rm /etc/freepbx.conf
rm /etc/amportal.conf
rm -rf /usr/src/freepbx*

# Install cleanup
echo "Resetting the Root login configuration for SSH..."
sed -i 's/PermitRootLogin yes/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
echo "Resetting the PHP max upload size to 2M..."
sed -i 's/\(^upload_max_filesize = \).*/\2M/' /etc/php/5.6/cgi/php.ini
echo "Resetting Apache defaults..."
sed -i 's/asterisk/www-data/' /etc/apache2/envvars
sed -i 's/AllowOverride All/AllowOverride None/' /etc/apache2/apache2.conf
echo "Restarting apache..."
service apache2 restart
echo "Removing Asterisk MySQL configuration..."
sed -i '/MySQL-asteriskcdrdb/,+8 d' /etc/odbc.ini
sed -i '/MySQL/,+4 d' /etc/odbcinst.ini
echo "Removing the 'asterisk' user account..."
userdel -r -f asterisk
echo "Done! Please remember to check if any errors occured."
}

# https://stackoverflow.com/a/226724
while true; do
    read -p "This will completely remove Asterisk/FreePBX along with its associated files. Continue? [Y/N]" yn
    case $yn in
        [Yy]* ) cleanup; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
