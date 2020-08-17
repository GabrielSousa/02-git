#!/usr/bin/env bash

source functions.sh

command_sequence=""

while getopts ":hy:x:dcX" opt; do
    case ${opt} in
        h )
            echo "Usage:"
            echo "      flight-delays.sh -h                Display this help message."
            echo "      flight-delays.sh [FILTERS] PATH    Show all the registers in PATH and apply some FILTERS."
            echo
            echo "      FILTERS:"
            echo "              -y YEAR                    Show only flighs of YEAR."
            echo "              -x CARRIER_CODE            Show only flighs of a particular carrier."
            echo "              -d                         Show only delayed flights."
            echo "              -c                         Count results from previous filters."
            echo "              -X                         Show the unique codes and name of the carriers present in previous filters."
            exit 0
            ;;
        y )
            command_sequence+=" | only_year $OPTARG"
            ;;
        x )
            command_sequence+=" | only_carrier $OPTARG"
            ;;
        d )
            command_sequence+=" | delayed_flights"
            ;;
        c )
            command_sequence+=" | count_results"
            ;;
        X )
            command_sequence+=" | get_carriers \$data_path"
            ;;
        : )
            echo "Option -$OPTARG requires an argument."
            exit 1 
            ;;
        \? )
            echo "Invalid option: -$OPTARG" 1>&2
            exit 1
            ;;
    esac
done

data_path=${@:$OPTIND:1}
download_datasets $data_path

echo "cat $data_path/2006.csv | remove_header $command_sequence"
eval "cat $data_path/2006.csv | remove_header $command_sequence"
