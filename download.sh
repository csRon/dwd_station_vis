#!/bin/bash

# choose folder and the basis url to extract the stuff to download
folder="ger-cl-mon-kl-hist-new"
path=./../../data/${folder}
filepath=${path}/${folder}.html
url="https://opendata.dwd.de/climate_environment/CDC/observations_germany/climate/monthly/kl/historical"

# extract lines with links to downloads 
wget $url -O $filepath
grep -e "<a href=\"monatswerte_KL_" $filepath > ${path}/filtered.html

# run script to produce a file of urls (named urls.txt)
python3 html_ext.py

# read urls.txt line by line and download file from url
input="${path}/urls.txt"
while IFS= read -r line
do
	wget $line -P $path/
done < "$input"

# unzip all files
cd $path
. ./../../scripts/download/unzip.sh

# rename folders and files because of stupid standardnaming
. ./../../scripts/download/rename.sh

# delete all unnecessary html files
#find . -name '*.html' | xargs rm
