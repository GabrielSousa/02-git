#!/usr/bin/env bash

source functions.sh

while getopts ":dya" opt; do
    case ${opt} in
        d ) # process option h
            shift # Removes de First Argument from the queue
            download_datasets $1
        ;;
        y ) # process option n
            shift      
            if [ -e "data/$1.csv" ] ; then 
                if [ ! -e "data/atrasados_$1.csv" ] ; then 
                   awk -F , '{ if (toupper($15) > 0)  print }' data/$1.csv > "data/atrasados_$1.csv"               
                fi 
                value=$(cat data/atrasados_$1.csv | wc -l)
            else 
                echo "Arquivo não existe"
                exit 1
            fi
        
            echo "Em $1 tiveram $value voos atrasados"
        ;;
        a ) #process option a
            shift
            airport_ids=$(awk -F , '{print $17}' data/atrasados_$1.csv | sort | uniq )
            awk -F',' -v ai="${airport_ids}" 'BEGIN{split(ai, codes, " "); for (c in codes) dict[codes[c]]=""} {gsub(/"/,"",$1)} $1 in dict {print $2}' data/airports.csv 
            #awk -F , '$1 ~ /ABI/ {print $2}' data/airports.csv 
        ;;
        \? ) echo "Usage: flight-delays.sh [-d] [-y]"
        ;;
  esac
done
