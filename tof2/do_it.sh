#!/bin/bash
echo necessary grants are:
echo \ \ CREATE USER \'tofuser\'@\'hostofchoice.domainofchoice\'\;
echo \ \ GRANT ALL on TOFMap2.\* to \'tofuser\'@\'hostofchoice.domainofchoice\'\;
echo \ \ GRANT FILE ON \*.\* TO \'tofuser\'@\'hostofchoice.domainofchoice\'\;
mysql -utofuser -e 'drop database if exists TOFMap2'
mysql -utofuser -e 'create database TOFMap2'
cat ../sql/pmt.sql ../sql/pmt_location.sql ../sql/module_location.sql | mysql -utofuser TOFMap2
working_dir=`pwd`
#mysql -utofuser TOFMap2 -e "load data local infile '$working_dir/rachel.txt' into table TOFMap2.pmt"
#rm -f pmt_location.txt
#./pmt_location.py > pmt_location.txt
#mysql -utofuser TOFMap2 -e "load data local infile '$working_dir/pmt_location.txt' into table TOFMap2.pmtLocation"
awk '{print "UPDATE pmt SET pmtLocationId = (SELECT id FROM pmtLocation WHERE label=\""$3"\") WHERE serialNo = \""$2"\";"}' < rachel_label.txt | mysql -utofuser TOFMap2
awk '{print "INSERT INTO moduleLocation set", "id="$1",", "label=\""$2"\",", "layer="$3",", "position="$4",", "moduleType=\""$5"\",", "end="$6",", "orientation=\""$7"\";"}' < module_location.txt | mysql -utofuser TOFMap2
./mod_pmt_locations.py | awk '{print "UPDATE pmtLocation set moduleLocationId = (SELECT id from moduleLocation where label = \""$2"\") where label = \""$1"\";"}' | mysql -utofuser TOFMap2
