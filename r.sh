# Requirement file
# OS: Linux Ubuntu Server 16.04.4 LTS (Xenial) x64
# Command to include: source ./r.sh

######################################################

PROJECT_DIR=/project

install_ruby() {
  sudo apt-add-repository ppa:brightbox/ruby-ng
  sudo apt-get update
  sudo apt-get install ruby2.4 ruby2.4-dev
}

install_node() {
  curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
  sudo apt-get update
  sudo apt-get install -y nodejs
  sudo apt-get install -y build-essential

  ### Install yarn
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt-get update && sudo apt-get install yarn
}

install_rails() {
  sudo apt install libxml2-dev libssl-dev zlib1g-dev sqlite3 libsqlite3-dev
  sudo gem install --no-ri --no-rdoc bundler:1.16.1 rails:5.1.5
}

install_pg() {
  sudo apt install curl libpq-dev zlib1g-dev git
  sudo touch /etc/apt/sources.list.d/pgdg.list
  sudo bash -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

  sudo apt-get update
  sudo apt-get install postgresql-9.6
}
