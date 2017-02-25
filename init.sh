#!/bin/bash

## Set defaults for environmental variables in case they are undefined
user=${USER:=cloud9}
userid=${USERID:=1000}
groupid=${GROUPID:=1000}
auth=${AUTH}

echo "creating new user and group ($user) with UID $userid"
groupadd -g "$groupid" "$user"
useradd -M "$user" -u "$userid" -d /home/cloud9 -g "$groupid"
chown -R "$user:$user" /home/cloud9
sed -i -e "s_root_${user}_g" /etc/supervisor/conf.d/supervisor-cloud9.conf
[[ ! -z "$auth" ]] && sed -i -e "s_port_auth ${auth} --port_g" /etc/supervisor/conf.d/supervisor-cloud9.conf

supervisord -c /etc/supervisor/supervisord.conf
