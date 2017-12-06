#!/bin/sh


apt-get -y install xfce4 xfce4-terminal mousepad  software-properties-common postfix vim screen wget elinks telnet openssh-server mc iptraf iputils-ping git sudo bind9  libreoffice gimp xpdf ristretto wodim xfburn galculator system-config-printer cups cups-client midori chromium xtightvncviewer xarchiver xrdp directvnc filezilla dia pidgin xfce4-screenshooter firefox-esr libgtkglext1 libxcb-damage0 libxcb-xtest0 gnome-disk-utility pulseaudio hplip speex  chromium  xtightvncviewer xarchiver xrdp directvnc filezilla  dictionaries-common myspell-en-gb libreoffice-l10n-en-gb libreoffice-l10n-hi libreoffice-grammarcheck-en-gb libreoffice-lightproof-en mythes-en-us hyphen-en-us libappindicator1 libdbusmenu-glib4 libdbusmenu-gtk4  libindicator7  gtk2-engines-murrine gtk2-engines-pixbuf xscreensaver-data-extra fonts-roboto fonts-droid-fallback fonts-noto typecatcher  xfce4-battery-plugin  xfce4-power-manager  xfce4-power-manager-plugins   xfce4-power-manager-data xfce4-datetime-plugin xfce4-screenshooter-plugin xfce4-systemload-plugin evince inkscape slim synaptic apt-xapian-index gdebi gksu firmware-linux

## install lighdm instead of slim if needed different x-login

## mount other server via sshfs for storage
apt-get -y install sshfs


apt-get -y install ttf-mscorefonts-installer

## for teamviewer not on proxmox only on debian desktop
#dpkg --add-architecture i386


#remove default pdf reader  as gimp
perl -i.bak  -p -e 's/application\/pdf=gimp.desktop;/application\/pdf=/g;' /usr/share/applications/mimeinfo.cache
