# Ruby developer seed
# OS: Linux Ubuntu 16.04.3 LTS x64 (Xenial)
# @author: Nurasyl Aldan <nurassyl.aldan@gmail.com>
# Command to include: source ./r.sh

######################################################

install_ruby() {
  ### Install RVM
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
  \curl -sSL https://get.rvm.io | bash -s stable
  source $HOME/.rvm/scripts/rvm || source /etc/profile.d/rvm.sh

  ### Install Ruby & GEM
  #rvm list known
  #rmv install 2.4 && rvm use 2.4 --default
  rvm use --default --install 2.4
  #rvm list
}

install_node() {
  ### Install NVM
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
  echo "source $HOME/.nvm/nvm.sh" >> $HOME/.profile
  . $HOME/.profile

  ### Install Node & NPM
  nvm install 8
  nvm use 8

  ### Install yarn
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt-get update && sudo apt-get install yarn
}

install_rails() {
  sudo apt install libxml2-dev libssl-dev zlib1g-dev sqlite3 libsqlite3-dev
  gem install --no-ri --no-rdoc bundler:1.16.1 rails:5.1.5
}

install_pg() {
  ### Install dependencies
  sudo apt install curl zlib1g-dev git

  ### Install PGVM
  curl -s -L https://raw.github.com/guedes/pgvm/master/bin/pgvm-self-install | bash
  source ~/.bashrc

  # Install PostgreSQL
  pgvm install 9.6.7
  pgvm use 9.6.7
  pgvm list
}

create_pg_cluster() {
  locales=$(locale -a)
  cluster_name=$1
  for locale in $locales; do
    if [ $locale == "C.UTF-8" ]; then
      pgvm cluster create $cluster_name --encoding=UTF8 --locale=$locale
      pgvm cluster start $cluster_name
      pgvm cluster list
    fi
  done
  #pgvm console $1@9.6.7
}
