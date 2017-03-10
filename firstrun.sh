#!/bin/bash

## Set defaults for environmental variables in case they are undefined
user=${USER:=cloud9}
userid=${USERID:=1000}
groupid=${GROUPID:=1000}
auth=${AUTH}
sudo=${SUDO}

if [ ! -f /home/cloud9/.configured ]; then

   echo "creating new user and group ($user) with UID $userid"
   groupadd -g "$groupid" "$user"
   useradd -M "$user" -u "$userid" -d /home/cloud9 -g "$groupid"
   chown -R "$user:$user" /home/cloud9
   sed -i -e "s_root_${user}_g" /etc/rc.local
   [[ ! -z "$auth" ]] && sed -i -e "s_port_auth ${auth} --port_g" /etc/rc.local
   if [ "$sudo" = true ]; then
      echo "$user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user
   fi
   su "$user" -c "touch /home/cloud9/.configured"
fi
