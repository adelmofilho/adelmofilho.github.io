
```
sudo git clone https://github.com/rstudio/rstudio.git
cd rstudio/dependencies/linux
sudo su
./install-dependencies-debian --exclude-qt-sdk
apt-get install -y openjdk-8-jdk
apt autoremove
cd /home/pi/rstudio
mkdir build
cd build
cmake .. -DRSTUDIO_TARGET=Server -DCMAKE_BUILD_TYPE=Debug
make install
```


```
cd
useradd -r rstudio-server
cp /usr/local/lib/rstudio-server/extras/init.d/debian/rstudio-server /etc/init.d/rstudio-server
chmod +x /etc/init.d/rstudio-server 
update-rc.d rstudio-server defaults
ln -f -s /usr/local/lib/rstudio-server/bin/rstudio-server /usr/sbin/rstudio-server
chmod 777 -R /usr/local/lib/R/site-library/
mkdir -p /var/run/rstudio-server
mkdir -p /var/lock/rstudio-server
mkdir -p /var/log/rstudio-server
mkdir -p /var/lib/rstudio-server
rm -rf /home/pi/rstudio
sudo nano /etc/init.d/rstudio-server
# Modify your PATH for ussing the compiled version of R
	# PATH=/usr/local/bin/:/sbin:/usr/sbin:/bin:/usr/bin
systemctl daemon-reload
rstudio-server start
exit
```