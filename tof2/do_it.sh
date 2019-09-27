#!/bin/bash
echo necessary grants are:
echo \ \ CREATE USER \'tofuser\'@\'hostofchoice.domainofchoice\'\;
echo \ \ GRANT ALL on TOFMap2.\* to \'tofuser\'@\'hostofchoice.domainofchoice\'\;
mysql -utofuser -e 'drop database if exists TOFMap2'
mysql -utofuser -e 'create database TOFMap2'
cat ../sql/pmt.sql ../sql/pmt_location.sql ../sql/module_location_2.sql \
    | mysql -utofuser TOFMap2
working_dir=`pwd`
grep -v \# pmt_serial.txt \
    | awk '{print "INSERT INTO pmt set serialNo = \""$2"\", type = \""$3"\", pmtLocationId = "$1";"}' \
    | mysql -utofuser TOFMap2
awk '{print "INSERT INTO moduleLocation set", "id="$1",", "label=\""$2"\",", "layer="$3",", "moduleType=\""$4"\",", "end="$5",", "orientation=\""$6"\";"}' \
    < module_location.txt | mysql -utofuser TOFMap2
#./mod_pmt_locations.py | awk '{print "UPDATE pmtLocation set moduleLocationId = (SELECT id from moduleLocation where label = \""$2"\") where label = \""$1"\";"}' | mysql -utofuser TOFMap2
