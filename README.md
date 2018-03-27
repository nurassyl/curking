### Install Virtualbox & Vagrant
```
# In first enable VT-X in BIOS
sudo apt-get update && sudo apt-get install -f && sudo apt-get autoremove
sudo apt-get install bash build-essential curl git linux-headers-generic
wget https://download.virtualbox.org/virtualbox/5.2.8/virtualbox-5.2_5.2.8-121009~Ubuntu~xenial_amd64.deb virtualbox.deb && dpkg -i virtualbox.deb
wget https://releases.hashicorp.com/vagrant/2.0.3/vagrant_2.0.3_x86_64.deb?_ga=2.118442121.1605114216.1522017342-842427046.1522017342 vagrant.deb && dpkg -i vagrant.deb
#vagrant box add ubuntu/xenial64 --box-version 20180323.0.0
```
---
### Install all dependencies
```
./vgreset
vagrant up
vagrant ssh

### Locale configure
cat /usr/share/i18n/SUPPORTED
locale -a # enabled locales list
sudo locale-gen en_US.UTF-8
#sudo dpkg-reconfigure locales #=> All locales => en_US.UTF-8 => OK
echo "export LANGUAGE=$LANG && export LC_ALL=$LANG" >> ~/.bashrc && source ~/.bashrc
#source /etc/default/locale
locale # setted locales list

### Datetime & timezone configure
date # current datetime
date -u # UTC
#export TZ=UTC
#ls /usr/share/zoneinfo/ && sudo cp -f /usr/share/zoneinfo/UTC /etc/localtime && source ~/.bashrc
#sudo dpkg-reconfigure tzdata #=> None of the above => UTC => OK
#sudo date +%T -s "00:00:00"
#sudo date +%Y%m%d -s "19961121"
sudo date --set="19961121 00:00:00"
#sudo hwclock --set --date "11/21/1996 00:00:00"
#sudo hwclock --show

echo "source /vagrant/r.sh" >> ~/.bashrc && source ~/.bashrc
sudo apt-get update && sudo apt-get install -f && sudo apt-get autoremove
sudo apt-get install bash build-essential curl git libxml2-dev libssl-dev zlib1g-dev
#sudo apt-get upgrade

install_ruby
install_node
install_rails
install_pg

pgvm list # installed postgresql versions list
create_pg_cluster nurasyl
pgvm cluster list
pgvm cluster start nurasyl # start the SQL server
pgvm console nurasyl@9.6.7 # sign in to postgresql console
\q # to exit from postgresql console
```
---
### Create database in PostgreSQL console
```
CREATE USER nurasyl WITH PASSWORD '12345';
ALTER ROLE nurasyl SET client_encoding TO 'UTF8';
ALTER ROLE nurasyl SET default_transaction_isolation TO 'SERIALIZABLE';
ALTER ROLE nurasyl SET timezone TO 'UTC';
CREATE DATABASE my_app;
CREATE DATABASE my_app_test;
CREATE DATABASE my_app_dev;
GRANT ALL PRIVILEGES ON DATABASE my_app, my_app_test, my_app_dev TO nurasyl;
\! clear
\q
```
---
# Run development HTTP server
```
vagrant reload
vagrant ssh
cd /vagrant/app
RAILS_ENV=development bin/rails server # localhost:8080
```
