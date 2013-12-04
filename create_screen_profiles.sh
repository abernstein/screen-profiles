#!/bin/bash
output="source /home/$(whoami)/.screenrc\n"
hostlist="./host_list"
type=$1
env=$2

i=0;
for host in `cat ${hostlist} | grep -i "$type" | grep -i "$env"`; 
do
  shortname=`echo $host | cut -d'.' -f1`
  output+="screen -t ${shortname} $((i++)) ssh $(whoami)@${host};\n"
done
echo -e $output;
