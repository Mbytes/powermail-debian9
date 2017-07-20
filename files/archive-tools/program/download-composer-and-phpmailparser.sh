#!/bin/sh

cd /tmp
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
composer --version
cd -
composer require php-mime-mail-parser/php-mime-mail-parser


mkdir /archive-mail-data
mkdir /archive-mail-data/stage1
mkdir /archive-mail-data/stage2
mkdir /archive-mail-data/indexdata
mkdir /archive-mail-data/maildata

