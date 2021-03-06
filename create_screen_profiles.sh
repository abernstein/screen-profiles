#!/bin/bash
#
# Currently this takes two params:
# type && env = gives two filters levels
#
#
if [ ${#@} == 0 ]; then
  usage="Usage: $(basename $BASH_SOURCE) [param1] [param2]"
  usage+="\n* param1: type of server"
  usage+="\n* param2: environment\n"
  echo -e $usage;
else
  output="source /home/$(whoami)/.screenrc\n"
  hostlist="./host_list"
  if [ -e $hostlist ]; then
    type=$1
    env=$2

    configfile="./.screenrc-${type}${env}";

    i=0;
    for host in `cat ${hostlist} | grep -i "$type" | grep -i "$env"`;
    do
      shortname=`echo $host | cut -d'.' -f1`
      output+="screen -t ${shortname} $((i++)) ssh $(whoami)@${host}\n"
    done
    echo -e $output > $configfile;
    echo -e "${output}\n\nTo execute screen -c ${configfile}";
  else
    echo "Need to supply a host file"
  fi;
fi;
