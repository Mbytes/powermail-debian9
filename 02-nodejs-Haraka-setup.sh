#!/bin/sh

echo > /etc/apt/sources.list.d/nodesource.list

echo "deb https://deb.nodesource.com/node_6.x stretch main" >> /etc/apt/sources.list.d/nodesource.list
echo "deb-src https://deb.nodesource.com/node_6.x stretch main" >> /etc/apt/sources.list.d/nodesource.list

curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -

apt-get update

apt-get install -y nodejs

npm install -g Haraka

