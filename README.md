#docker-cloud9-ide
[![](https://images.microbadger.com/badges/image/msumpter/docker-cloud9-ide.svg)](https://microbadger.com/images/msumpter/docker-cloud9-ide "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/msumpter/docker-cloud9-ide.svg)](https://microbadger.com/images/msumpter/docker-cloud9-ide "Get your own version badge on microbadger.com")

Cloud9 IDE - Ubuntu base with common dev tools (ruby, python, php, nodejs, build-essential) 
built to run as specific system user to maintain proper file ownership in workspace for mounted volume. 
Image may take input via environment variables passed at run time, upon startup directory permissions are 
adjusted, not passing the AUTH variable disables authentication completely.

#Quickstart
```
docker run -d -p 8081:3000 -v `pwd`:/workspace/ -e AUTH=username:password -e USERID=`id -u` -e USER=`id -un` -e GROUPID=`id -g` msumpter/docker-cloud9-ide
```
