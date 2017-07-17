#!/bin/sh

echo "deb http://download.webmin.com/download/repository sarge contrib " > /etc/apt/sources.list.d/webmin.list 
curl -s http://www.webmin.com/jcameron-key.asc | apt-key add -
apt-get update
apt-get install webmin

