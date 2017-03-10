#docker-cloud9-ide

[![](https://images.microbadger.com/badges/image/msumpter/docker-cloud9-ide.svg)](https://microbadger.com/images/msumpter/docker-cloud9-ide "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/msumpter/docker-cloud9-ide.svg)](https://microbadger.com/images/msumpter/docker-cloud9-ide "Get your own version badge on microbadger.com")

Cloud9 IDE - Ubuntu/Phusion-base image built to run as specific system user to maintain proper file ownership 
within the mounted workspace volume. Image may take input via environment variables passed at run time, upon 
startup directory permissions are adjusted, not passing the AUTH variable disables authentication completely. 
Passing SUDO=true allows the use of sudo within the container to allow customization. 

#Quickstart
```
docker run -d -p 8081:3000 -p 8080:8080 -v `pwd`:/workspace/ -e AUTH=username:password -e SUDO=true -e USERID=`id -u` -e USER=`id -un` -e GROUPID=`id -g` msumpter/docker-cloud9-ide
```
Then direct your web browser to http://hostname:8081/ 

To install additional packages from within Cloud9 console (if sudo is enabled)
```
sudo apt update
sudo apt -y install php-cli
```

You can also expose a local service from within the docker container on port 8080
```
mkdir phpinfo
cd phpinfo
echo "<?php phpinfo(); ?>" > index.php
php -S 0.0.0.0:8080
```
