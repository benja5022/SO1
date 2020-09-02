#!/bin/bash

cd /proc

if[ $# -eq 0];then
    model_name=$(cat cpuinfo | grep "model name" | awk '{ printf $4 $5 $6 "\n"}')
    uptime=$(cat uptime | awk '{ printf "%0.3f\n",$1/60/60/24}')
    verison=$(cat version | awk '{ printf $3}')
    memTotal=$(cat meminfo | grep MemTotal | awk '{printf $2}')

    echo "model name:" $model_name

fi


if [ $1 = "-ps"];then
    cd /proc
    for directorio in $(ls);do
        numeritos='^[0-9]+$'
        if [[ $directorio =~ $numeritos]] && [[ -d $directorio]];then
            cd $directorio
            status=$(cat status | grep State | awk '{ printf $3 }')
            pid=$directorio
            ppid=$(cat status | grep PPid | awk '{ printf $2 }')
            uid=$(cat status | grep Uid | awk '{ printf $2 }')

            auxIFS=$IFS
            IFS='\n'
            for linea in $(cat /etc/passwd);do
                substring=$(echo $linea | cut -d':' -f 3)
                if [ $substring = $uid];then
                    name_uid=$(echo $linea | cut -d':' -f 1)
                    cmdline=$(echo $linea | cut -d':' -f 1)
                fi
            done
        fi
    done
fi
