#!/bin/sh

echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

curl -s https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
apt-get update


apt-get -y install google-chrome-stable


