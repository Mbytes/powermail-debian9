#!/bin/sh

## XFCE4 Desktop with Firefox , Libreoffice office tools
apt-get -y install  lightdm xfce4 xfce4-* galculator mousepad firefox-esr libreoffice-calc libreoffice-writer libreoffice-base libreoffice-impress xscreensaver mythes-en-us libreoffice-voikko libreoffice-writer2xhtml  libreoffice-help-en-us libreoffice-evolution libreoffice-draw libreoffice-java-common numix-gtk-theme numix-icon-theme libreoffice-l10n-en-gb libreoffice-math libreoffice-mysql-connector libreoffice-pdfimport libreoffice-report-builder libreoffice-report-builder-bin libreoffice-style-oxygen libreoffice-wiki-publisher hyphen-en-us hyphen-en-gb libreoffice-lightproof-en  libreoffice-style-breeze xfe-themes

apt-get -y install xfce4 xfce4-terminal mousepad  software-properties-common postfix vim screen wget elinks telnet openssh-server mc iptraf iputils-ping git sudo bind9  libreoffice gimp xpdf ristretto wodim xfburn galculator system-config-printer cups cups-client midori chromium xtightvncviewer xarchiver xrdp directvnc filezilla dia pidgin xfce4-screenshooter firefox-esr libgtkglext1 libxcb-damage0 libxcb-xtest0 gnome-disk-utility pulseaudio hplip speex  chromium  xtightvncviewer xarchiver xrdp directvnc filezilla  dictionaries-common myspell-en-gb libreoffice-l10n-en-gb libreoffice-l10n-hi libreoffice-grammarcheck-en-gb libreoffice-lightproof-en mythes-en-us hyphen-en-us libappindicator1 libdbusmenu-glib4 libdbusmenu-gtk4  libindicator7  gtk2-engines-murrine gtk2-engines-pixbuf xscreensaver-data-extra fonts-roboto fonts-droid-fallback fonts-noto typecatcher  xfce4-battery-plugin  xfce4-power-manager  xfce4-power-manager-plugins   xfce4-power-manager-data xfce4-datetime-plugin xfce4-screenshooter-plugin xfce4-systemload-plugin evince inkscape lightdm synaptic apt-xapian-index gdebi gksu firmware-linux xscreensaver-gl file-roller parcellite qalculate clementine vlc bleachbit shotwell gparted xscreensaver xss-lock gvfs-bin syslinux-themes-debian


## install slim instead of lightdm if needed different x-login

## if video issue
#apt-get install xserver-xorg-video-nvidia
#apt-get install xserver-xorg-video-nouveau
#apt-get install nvidia-legacy-340xx-driver

# for teamviewer --adddon 
apt-get install -y qml-module-qtgraphicaleffects qml-module-qtquick-controls qml-module-qtquick-dialogs qml-module-qtquick-layouts qml-module-qtquick-privatewidgets qml-module-qtquick-window2  qml-module-qtquick2


## for multimedia pc
#apt-get install -y libavcodec-extra 

## huge openclipart collection 128MB+
#apt-get -y install openclipart-libreoffice 

## mount other server via sshfs for storage
#apt-get -y install sshfs

## extra fonts
apt-get -y install ttf-mscorefonts-installer ttf-freefont ttf-bitstream-vera ttf-dejavu ttf-liberation

## if have to install any 32bit packages.
#dpkg --add-architecture i386


#remove default pdf reader  as gimp
perl -i.bak  -p -e 's/application\/pdf=gimp.desktop;/application\/pdf=/g;' /usr/share/applications/mimeinfo.cache

### install Google Chrome
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
curl -s https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
apt-get update
apt-get -y install google-chrome-stable

