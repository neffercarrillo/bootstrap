#!/usr/bin/bash

# 2024-10-25: TODO: Re-create this script in perl

# update server
apt update
apt upgrade

# install nginx server
apt install -y nginx

# update nginx config to remove showing version number on error pages
sed -i 's/# server_tokens off;/server_tokens off;/g' /etc/nginx/nginx.conf 

# create and insert configuration into file
cat <<EOF > /etc/nginx/sites-available/$1
server {
        listen 80 ;
        listen [::]:80 ;
        server_name $1 ;
        root /var/www/$1 ;
        index index.html index.htm index.nginx-debian.html ;
        location / {
                try_files $uri $uri/ =404 ;
        }
}
EOF

# create directory for the site
mkdir /var/www/$1

# create index file
cat <<EOF > /var/www/$1/index.html
<!DOCTYPE html>
<h1>Website</h1>
<p>The website is live!</p>
EOF

# enable site
ln -s /etc/nginx/sites-available/$1 /etc/nginx/sites-enabled/$1

# enable service
systemctl reload nginx

# update firewall
ufw allow 80
ufw allow 443

# install certbot plugin
apt install -y python3-certbot-nginx

# run certbot
certbot --nginx

# 

