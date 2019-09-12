#!/bin/bash
mysql -utofuser -e 'drop database if exists TOFComponent'
mysql -utofuser -e 'create database TOFComponent'
cat pmt.sql pmt_location.sql | mysql -utofuser TOFComponent
working_dir=`pwd`
mysql -utofuser TOFComponent -e "load data infile '$working_dir/rachel.txt' into table TOFComponent.pmt"
rm -f pmt_location.txt
./pmt_location.py > pmt_location.txt
mysql -utofuser TOFComponent -e "load data infile '$working_dir/pmt_location.txt' into table TOFComponent.pmtLocation"
