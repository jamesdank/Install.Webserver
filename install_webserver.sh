#!/bin/bash

user=""

// install webserver
cd /home/$user/Downloads
wget https://sourceforge.net/projects/xampp/files/XAMPP%20Linux/8.2.12/xampp-linux-x64-8.2.12-0-installer.run
chmod +x xampp-linux-*-installer.run
sudo ./xampp-linux-*-installer.run --mode text

// non production error handling
sudo sed -i -e 's/display_errors=Off/display_errors=On/g' /opt/lampp/etc/php.ini

// security
sudo sed -i -e 's/Listen 80/Listen 127.0.0.1:80/g' /opt/lampp/etc/httpd.conf

// start on reboot
(sudo crontab -l 2>/dev/null; echo "@reboot /opt/lampp/lampp start") | sudo crontab -

// create folder
sudo mkdir -p /opt/lampp/htdocs/www
sudo chown -R $user:$user /opt/lampp/htdocs/www

// add shortcut in thundar
echo 'file:///opt/lampp/htdocs/www' >> /home/$user/.config/gtk-3.0/bookmarks

// create aliases in .bashrc
echo 'alias web.stop="sudo /opt/lampp/lampp stop"' >> /home/$user/.bashrc
echo 'alias web.start="sudo /opt/lampp/lampp start"' >> /home/$user/.bashrc
echo 'alias web.restart="sudo /opt/lampp/lampp restart"' >> /home/$user/.bashrc
