#!/bin/bash

# choose folder and the basis url to extract the stuff to download
folder_historical="ger-cl-mon-kl-historical"
path_historical=./data/${folder_historical}
filepath_historical=${path_historical}/${folder_historical}.html
url_historical="https://opendata.dwd.de/climate_environment/CDC/observations_germany/climate/monthly/kl/historical/"

folder_recent="ger-cl-mon-kl-recent"
path_recent=./data/${folder_recent}
filepath_recent=${path_recent}/${folder_recent}.html
url_recent="https://opendata.dwd.de/climate_environment/CDC/observations_germany/climate/monthly/kl/recent/"


download(){
	path=$1
	filepath=$2
	url=$3

	# create folder
	mkdir -p $path 
	
	wget $url/KL_Monatswerte_Beschreibung_Stationen.txt -P $path

	# extract lines with links to downloads 
	wget $url -O $filepath
	grep -e "<a href=\"monatswerte_KL_" $filepath > ${path}/filtered.html

	# run script to produce a file of urls (named urls.txt)
	python3 html_ext.py $path $url

	# read urls.txt line by line and download file from url
	input="${path}/urls.txt"
	while IFS= read -r line
	do
		wget $line -P $path/
	done < "$input"

	# unzip all files
	cd $path
	bash ./../../unzip.sh

	# rename folders and files because of stupid standardnaming
	bash ./../../rename.sh

	# delete all unnecessary html files
	find . -name '*.html' | xargs rm

	cd ../..
}

download $path_historical $filepath_historical $url_historical
download $path_recent $filepath_recent $url_recent
