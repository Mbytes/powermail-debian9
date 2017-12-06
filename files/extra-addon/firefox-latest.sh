
#!/bin/sh

cd /tmp/

mkdir /opt/firefox

wget -O FirefoxSetup.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US"
 tar xjf FirefoxSetup.tar.bz2 -C /opt/firefox/

mv /usr/bin/firefox /usr/bin/firefox_orig
mv /usr/lib/firefox-esr/firefox-esr /usr/lib/firefox-esr/firefox-esr_orig

ln -s /opt/firefox/firefox/firefox /usr/lib/firefox-esr/firefox-esr
ln -s /opt/firefox/firefox/firefox /usr/bin/firefox

