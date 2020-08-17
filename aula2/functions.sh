#!/usr/bin/env bash


function load_datasets {
    if [[ -d "$1" ]]; then
        if [[ ! -f "$1/2006.csv" ]]; then
            if [[ ! -f "$1/2006.csv.bz2" ]]; then
                echo "Baixando arquivo de 2006"
                wget -q 'https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/HG7NV7/EPIFFT' -O "${1}/2006.csv.bz2"
            fi
            echo "Descompactando arquivo de 2006"
            bzip2 --decompress "$1/2006.csv.bz2"
        fi


        if [[ ! -f "$1/2007.csv" ]]; then
            if [[ ! -f "$1/2007.csv.bz2" ]]; then
                echo "Baixando arquivo de 2007"
                wget -q 'https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/HG7NV7/2BHLWK' -O "${1}/2007.csv.bz2"
            fi
            echo "Descompactando arquivo de 2007"
            bzip2 --decompress "$1/2007.csv.bz2"
        fi


        if [[ ! -f "$1/carriers.csv" ]]; then
            echo "Baixando arquivo carriers"
            wget -q 'https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/HG7NV7/3NOQ6Q' -O "${1}/carriers.csv"
        fi

        if [[ ! -f "$1/airports.csv" ]]; then
            echo "Baixando arquivo airports"
            wget -q 'https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/HG7NV7/XTPZZY' -O "${1}/airports.csv"
        fi
    else
        echo "Destino do download não existe"
        exit 1
    fi
}

function remove_header {
    tail -n +2
}

function delayed_flights {
    awk -F',' '$15>0 {print}'
}

function only_year {
    awk -F',' -v year=$1 '$1==year {print}'
}

function only_carrier {
    awk -F',' -v carrier=$1 '$9==carrier {print}'
}

function count_results {
    wc -l
}

function get_carriers {
    local present_carriers=($(awk -F',' '{print $9}' | sort | uniq -c))
    #echo ${present_carriers[*]}
    awk -F',' -v pc="${present_carriers[*]}" 'BEGIN{split(pc, codes, " "); for (c in codes) dict[codes[c]]=""} {gsub(/"/,"",$1)} $1 in dict' $1/carriers.csv
}

function get_airports {
    local present_airports=($(awk -F',' '{print $18}' | sort | uniq -c))
    awk -F',' -v pa="${present_airports[*]}" 'BEGIN{split(pa, codes, " "); for (c in codes) dict[codes[c]]=""} {gsub(/"/,"",$1)} $1 in dict' $1/airports.csv
}
