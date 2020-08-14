#!/usr/bin/env bash

source functions.sh

while getopts ":dy" opt; do
    case ${opt} in
        d ) # process option h
            shift # Removes de First Argument from the queue
            download_datasets $1
        ;;
        y ) # process option n
            shift
            if [ -e "data/$1.csv" ] ; then 
                value=$(awk -F , '{ if (toupper($15) > 0)  print }' data/$1.csv | wc -l) 
                echo "Em $1 tiveram $value voos atrasados"
            else 
                echo "Arquivo não existe"
            fi
        ;;
        \? ) echo "Usage: flight-delays.sh [-d] [-y]"
        ;;
  esac
done
