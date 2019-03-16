#!/bin/bash

# Atualizamos o apt-get
sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade;
sudo apt-get install software-properties-common python-software-properties curl;
sudo add-apt-repository -y ppa:ondrej/php && sudo apt-get update

# Instalamos o apache, o mysql, o composer, o curl e o git
sudo apt install curl
sudo apt install apache2;
sudo apt-get install mysql-server;
sudo apt-get install composer;
sudo apt-get install git;

# Instalamos as versões 5.6, 7.2 e 7.3, assim como as extensões mais utilizadas do php
sudo apt-get install -y php5.6;
sudo apt-get install -y php7.2;
sudo apt-get install -y php7.3;
sudo apt-get install php5.6-mysql php5.6-intl php5.6-xml php5.6-gd php5.6-soap php5.6-curl php5.6-common php5.6-json php5.6-mbstring php5.6-pgsql php5.6-xdebug php5.6-zip php5.6-dev php5.6-cli php-memcached;
sudo apt-get install php7.2-mysql php7.2-intl php7.2-xml php7.2-gd php7.2-soap php7.2-curl php7.2-common php7.2-json php7.2-mbstring php7.2-pgsql php7.2-xdebug php7.2-zip php7.2-dev php7.2-cli;
sudo apt-get install php7.3-mysql php7.3-intl php7.3-xml php7.3-gd php7.3-soap php7.3-curl php7.3-common php7.3-json php7.3-mbstring php7.3-pgsql php7.3-xdebug php7.3-zip php7.3-dev php7.3-cli;

# Habilitamos o PHP 7.2 como padrão
sudo a2dismod php5.6;
sudo a2dismod php7.3;
sudo a2enmod php7.2;
sudo update-alternatives --set php /usr/bin/php7.2;
sudo update-alternatives --set phar /usr/bin/phar7.2;
sudo update-alternatives --set phar.phar /usr/bin/phar.phar7.2;
sudo update-alternatives --set phpize /usr/bin/phpize7.2;
sudo update-alternatives --set php-config /usr/bin/php-config7.2;

# Fazemos um backup de arquivos críticos
sudo cp "/etc/mysql/my.cnf" "./Backup Files/my.cnf";
sudo cp "/etc/php/5.6/apache2/php.ini" "./Backup Files/php5.6.cnf";
sudo cp "/etc/php/7.2/apache2/php.ini" "./Backup Files/php7.2.cnf";
sudo cp "/etc/php/7.3/apache2/php.ini" "./Backup Files/php7.3.cnf";

# Ativamos o skip-grant-tables
sudo cp "./Helper Files/my-skip.cnf" "/etc/mysql/my.cnf";
sudo service mysql stop;
sudo service mysql start;

# Mudamos a senha do usuário root do mysql para root
mysql -uroot < "./Helper Files/rootpass.sql";

# Desativamos o skip-grant-tables
sudo cp "./Helper Files/my.cnf" "/etc/mysql/my.cnf";
sudo service mysql stop;
sudo service mysql start;

# Atualizamos o php.ini
sudo cp "./Helper Files/php5.6.cnf" "/etc/php/5.6/apache2/php.ini";
sudo cp "./Helper Files/php7.2.cnf" "/etc/php/7.2/apache2/php.ini";
sudo cp "./Helper Files/php7.3.cnf" "/etc/php/7.3/apache2/php.ini";

# Reiniciamos o apache para concluir
sudo service apache2 stop
sudo service apache2 start