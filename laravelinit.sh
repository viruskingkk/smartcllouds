#!/bin/bash

#建置Docker 環境
curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh
sudo yum install docker-compose
sudo usermod -aG docker smartclouds
service docker start
docker -v

#建置Docker-Compose 環境
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version

# 刪除沒用的shell檔
rm -f get-docker.sh init.sh

# 建立smartclouds專案資料夾
mkdir smartclouds
# 進入資料夾
cd smartclouds
mkdir www
git clone https://github.com/laradock/laradock.git

cd laradock
# 複製 env-example = .env檔名
cp .env.example .env
sed -i 's#APP_CODE_PATH_HOST=../#APP_CODE_PATH_HOST=~/smartclouds#g' .env

# 設定Laravel 專案
docker-compose run -d nginx mysql
docker-compose exec workspace composer create-project laravel/laravel --prefer-dist

# 修改Nginx 設定
cd ~/smartclouds/Laradock/nginx/sites
cp laravel.conf.example smartclouds.conf
sed -i 's#server_name laravel.test#server_name smartclouds.com#g' smartclouds.conf

# 修改本機host
sed -i '$a 127.0.0.1 smartclouds.com' /etc/hosts

# 容器重啟
docker-compose down
docker-compose run -d nginx mysql
