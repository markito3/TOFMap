#!/bin/bash
echo necessary grants are:
echo \ \ CREATE USER \'tofuser\'@\'hostofchoice.domainofchoice\'\;
echo \ \ GRANT ALL on TOFMap2.\* to \'tofuser\'@\'hostofchoice.domainofchoice\'\;
mysql -utofuser -e 'drop database if exists TOFMap2'
mysql -utofuser -e 'create database TOFMap2'
cat \
    ../sql/pmt.sql \
    ../sql/pmt_location.sql \
    ../sql/module_location_2.sql \
    ../sql/splitter_location.sql \
    ../sql/signal_cable.sql \
    ../sql/adc_cable.sql \
    | mysql -utofuser TOFMap2
working_dir=`pwd`
grep -v \# pmt_info.txt \
    | awk '{print "INSERT INTO pmt set serialNo = \""$2"\", type = \""$3"\", pmtLocationId = "$1";"}' \
    | mysql -utofuser TOFMap2
awk '{print "INSERT INTO moduleLocation set", "id="$1",", "label=\""$2"\",", "layer="$3",", "moduleType=\""$4"\",", "end="$5",", "orientation=\""$6"\";"}' \
    < module_info.txt | mysql -utofuser TOFMap2
grep -v \# pmt_info.txt | awk '{print "INSERT INTO pmtLocation SET id = "$1", moduleLocationId = (SELECT id FROM moduleLocation WHERE label = \""$6"\"), end = "$7", label = \""$5"\";"}' | mysql -utofuser TOFMap2
grep -v \# pmt_info.txt | awk '{print "INSERT INTO signalCable SET id="$1", label=\""$5"\", pmtLocationId="$1";"}' | mysql -u tofuser TOFMap2
awk '{print "INSERT INTO splitterLocation SET id = "$1", label = \""$2"\";"}' < splitter_location_info.txt | mysql -utofuser TOFMap2
awk '{print "UPDATE signalCable SET splitterLocationId = "$1" WHERE label = \""$3"\";"}' < splitter_location_info.txt | mysql -utofuser TOFMap2
awk '{print "INSERT INTO adcCable SET id = "$1", label = \""$2"\";"}' < adc_cable.txt | mysql -u tofuser TOFMap2
awk '{print $3}' < splitter_location_info.txt | awk -F"-" '{print $1"-"$2"-"$3, $1"-"$2"-A-"$3}' | awk '{print "UPDATE adcCable SET splitterLocationId = (SELECT splitterLocation.id FROM splitterLocation, signalCable WHERE splitterLocation.id = splitterLocationId AND signalCable.label = \""$1"\") WHERE label = \""$2"\";"}' | mysql -u tofuser TOFMap2
