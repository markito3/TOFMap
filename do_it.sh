#!/bin/bash
mysql -utofuser -e 'drop database if exists TOFComponent'
mysql -utofuser -e 'create database TOFComponent'
cat pmt.sql pmt_location.sql module_location.sql | mysql -utofuser TOFComponent
working_dir=`pwd`
mysql -utofuser TOFComponent -e "load data infile '$working_dir/rachel.txt' into table TOFComponent.pmt"
rm -f pmt_location.txt
./pmt_location.py > pmt_location.txt
mysql -utofuser TOFComponent -e "load data infile '$working_dir/pmt_location.txt' into table TOFComponent.pmtLocation"
awk '{print "UPDATE pmt SET pmtLocationId = (SELECT id FROM pmtLocation WHERE label=\""$3"\") WHERE serialNo = \""$2"\";"}' < rachel_label.txt | mysql -utofuser TOFComponent
awk '{print "INSERT INTO moduleLocation set", "id="$1",", "label=\""$2"\",", "layer="$3",", "position="$4",", "moduleType=\""$5"\",", "end="$6",", "orientation=\""$7"\";"}' < module_location.txt | mysql -utofuser TOFComponent
