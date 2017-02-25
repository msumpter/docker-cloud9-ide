#!/bin/bash
docker build --force-rm=true --tag="$USER/docker-cloud9-ide:latest" .
docker run -d -p 8081:3000 -v /home/$USER/sites/:/workspace/ \
	-e AUTH=username:password \
	-e USERID=$UID \
	-e USER=$USER \
	-e GROUPID=`id -g $USER` \
	$USER/docker-cloud9-ide:latest
