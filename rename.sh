#!/bin/bash

for folder in monatswerte*
do
	dirname=`echo $folder | sed 's/_[0-9]\+_[0-9]\+_hist$//' | sed 's/_akt$//'`
	mv $folder $dirname
	filename=`echo $dirname/produk* | sed 's/monat_[0-9]\+_[0-9]\+/monat/'`
	mv $dirname/produk* $filename
done


