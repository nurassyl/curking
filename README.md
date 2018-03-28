**Project name:** Curking (Currency king)
**Server:** Linux Ubuntu Server 16.04.4 LTS (Xenial) x64 [download here](http://releases.ubuntu.com/16.04.4/ubuntu-16.04.4-server-amd64.iso?_ga=2.226583453.1643071992.1522193063-1427039001.1522193063 "download here")

---
## For vagrant
- Enable VT-X in BIOS
- Install VirtualBox v5.1.34
- Install Vagrant v2.0.3
- Install OpenSSH client

---
###### Start virtual server
```
vagrant up
#PROJECT_DIR=~/curking && ssh vagrant@localhost -p 2222 -i $PROJECT_DIR/.vagrant/machines/default/virtualbox/private_key
```
###### The virtual server status
```
vagrant status
```
###### Restart the virtual server and reload Vagrantfile configuration
```
vagrant reload
```
###### Stop the virtual server
```
vagrant halt
```
###### Destroy the virtual server
```
vagrant destroy
```
###### Log into the virtual server
```
#rm -f ~/.ssh/known_hosts
vagrant ssh-config # see the SSH server info
vagrant ssh # log into the virtual server
cd /home/nurasyl && su nurasyl
```

---
### Create new user
```
### Create user
username=nurasyl
#sudo rm -rf /home/$username &&sudo deluser $username
sudo locale-gen en_US.UTF-8 && echo "export LANGUAGE=$LANG && export LC_ALL=$LANG" >> ~/.bashrc && source ~/.bashrc
group_id=$(id -u vagrant) && sudo adduser --gid $group_id $username
sudo adduser $username sudo # add user into sudo group
#sudo passwd $username
cat /etc/passwd # display users list
cd /home/$username && su $username
pwd # display current directory
```

---
### Delete ".vagrant"
```
./vgreset
```

---
# Configure and install dependencies
---
### Configure server
```
### Locale configure
#cat /usr/share/i18n/SUPPORTED
locale -a # enabled locales list
sudo locale-gen en_US.UTF-8
#sudo dpkg-reconfigure locales #=> All locales => en_US.UTF-8 => OK
echo "export LANGUAGE=$LANG && export LC_ALL=$LANG" >> ~/.bashrc && source ~/.bashrc
#source /etc/default/locale
locale # setted locales list

### Datetime & timezone configure
date # current datetime
date -u # current UTC datetime
#export TZ=UTC
#ls /usr/share/zoneinfo/ && sudo cp -f /usr/share/zoneinfo/UTC /etc/localtime && source ~/.bashrc
#sudo dpkg-reconfigure tzdata #=> None of the above => UTC => OK
#sudo date +%T -s "00:00:00"
#sudo date +%Y%m%d -s "19961121"
sudo date --set="19961121 00:00:00"
#sudo hwclock --set --date "11/21/1996 00:00:00"
#sudo hwclock --show
```

---
### Include requirement file
```
PROJECT_DIR=/project
echo "source $PROJECT_DIR/r.sh" >> ~/.bashrc && source ~/.bashrc
```

---
### Install all dependencies
```
### Install system dependencies
sudo apt-get install bash build-essential curl git libxml2-dev libssl-dev zlib1g-dev
#sudo apt-get upgrade
#sudo apt-get update && sudo apt-get install -f && sudo apt-get autoremove

### Install frameworks
install_ruby
install_node
install_rails

### Install database server
install_pg

### Give a permission to project
sudo chmod 777 -R $PROJECT_DIR

### Install gems
cd $PROJECT_DIR/app # into rails app directory
sudo bundle install
#bundle update

### Configure rails app database
$PROJECT_DIR/app/config/database.yml
```

---
### Create user & database in PostgreSQL server
```
sudo service postgresql status
sudo -u postgres psql # log into postgresql server

SHOW is_superuser;
CREATE USER nurasyl PASSWORD '12345';
ALTER ROLE nurasyl SET client_encoding TO 'UTF8';
ALTER ROLE nurasyl SET default_transaction_isolation TO 'READ UNCOMMITTED';
ALTER ROLE nurasyl SET TimeZone TO 'UTC';
CREATE DATABASE curking;
CREATE DATABASE curking_test;
CREATE DATABASE curking_dev;
GRANT ALL PRIVILEGES ON DATABASE curking, curking_test, curking_dev TO nurasyl;
\q

psql -h localhost -p 5432 -U nurasyl -d curking

SHOW server_encoding;
SHOW transaction_isolation;
SHOW lc_collate;
SHOW log_timezone;
```

Commands:
- \? => list all the commands
- \l or \list => list databases
- \conninfo => display information about current connection
- \c [DBNAME] => connect to database
- \dt => list tables
- \d [TABLENAME] => show all columns
- \! clear => clear console
- \q => quit psql

---
### Migration
```
sudo rake db:migrate RAILS_ENV=production
```

---
### Testing
```
bundle exec rake
bundle exec rspec
```

---
### Run HTTP server
```
cd $PROJECT_DIR/app
SECRET_KEY=$(rails secret) # generate a secure secret key
RAILS_ENV=production SECRET_KEY_BASE=$SECRET_KEY sudo bin/rails server
```
