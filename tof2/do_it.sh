#!/bin/bash
echo necessary grants are:
echo \ \ CREATE USER \'tofuser\'@\'hostofchoice.domainofchoice\'\;
echo \ \ GRANT ALL on TOFMap2.\* to \'tofuser\'@\'hostofchoice.domainofchoice\'\;
echo === Drop and create database ===
mysql -utofuser -e 'drop database if exists TOFMap2'
mysql -utofuser -e 'create database TOFMap2'
echo === Create tables ===
cat \
    ../sql/pmt.sql \
    ../sql/pmt_location.sql \
    ../sql/module_location_2.sql \
    ../sql/splitter_location.sql \
    ../sql/signal_cable.sql \
    ../sql/adc_cable.sql \
    ../sql/adc_location.sql \
    ../sql/adc.sql \
    ../sql/hv_card.sql \
    ../sql/hv_card_location.sql \
    ../sql/hv_cable.sql \
    ../sql/disc.sql \
    ../sql/disc_location.sql \
    ../sql/disc_cable.sql \
    ../sql/tdc.sql \
    ../sql/tdc_location.sql \
    ../sql/tdc_cable.sql \
    ../sql/crate.sql \
    ../sql/crate_location.sql \
    | mysql -utofuser TOFMap2
echo === Create PMTs ===
grep -v \# pmt_info.txt \
    | awk '{print "INSERT INTO pmt set serialNo = \""$2"\", type = \""$3"\", pmtLocationId = "$1";"}' \
    | mysql -utofuser TOFMap2
echo === Enter data into moduleLocation table ===
awk '{print "INSERT INTO moduleLocation set", "id="$1",", "label=\""$2"\",", "layer="$3",", "moduleType=\""$4"\",", "end="$5",", "orientation=\""$6"\", bar="$7";"}' \
    < module_info.txt | mysql -utofuser TOFMap2
echo === Enter data into pmtLocation table ===
grep -v \# pmt_info.txt | awk '{print "INSERT INTO pmtLocation SET id = "$1", moduleLocationId = (SELECT id FROM moduleLocation WHERE label = \""$6"\"), end = "$7", label = \""$5"\";"}' | mysql -utofuser TOFMap2
echo === Add physics labels ===
grep -v \# pmt_info.txt | pmt.py | mysql -utofuser TOFMap2
echo === Enter data into signalCable table ===
grep -v \# pmt_info.txt | awk '{print "INSERT INTO signalCable SET id="$1", label=\""$5"\", pmtLocationId="$1";"}' | mysql -u tofuser TOFMap2
echo === Enter data into splitterLocation table ===
awk '{print "INSERT INTO splitterLocation SET id = "$1", label = \""$2"\";"}' < splitter_location_info.txt | mysql -utofuser TOFMap2
echo === Connect signal cables to splitters ===
awk '{print "UPDATE signalCable SET splitterLocationId = "$1" WHERE label = \""$3"\";"}' < splitter_location_info.txt | mysql -utofuser TOFMap2
echo  === Enter data into adcCable table ===
awk '{print "INSERT INTO adcCable SET id = "$1", label = \""$2"\";"}' < adc_cable.txt | mysql -u tofuser TOFMap2
echo === Connect ADC cables to splitters ===
awk '{print $3}' < splitter_location_info.txt | awk -F"-" '{print $1"-"$2"-"$3, $1"-"$2"-A-"$3}' | awk '{print "UPDATE adcCable SET splitterLocationId = (SELECT splitterLocation.id FROM splitterLocation, signalCable WHERE splitterLocation.id = splitterLocationId AND signalCable.label = \""$1"\") WHERE label = \""$2"\";"}' | mysql -u tofuser TOFMap2
echo === Enter data into adcLocation table ===
adc.py < adc.csv | mysql -utofuser TOFMap2
echo === Add HV cards and cables ===
hv.py < hv.csv | mysql -utofuser TOFMap2
echo === Add discriminators and their cables ===
disc.py < disc.csv | mysql -utofuser TOFMap2
echo === Add tdcs and their cables ===
tdc.py < tdc.csv | mysql -utofuser TOFMap2
echo === Add crates ===
grep -v \# crate_info.txt | awk -F',' '{print "INSERT INTO crate SET serialNo = \""$3"\", type = \""$2"\", crateLocationId = "$1"; INSERT INTO crateLocation SET id = "$1", cratePositionLabel = \""$4"\";"}' | mysql -u tofuser TOFMap2
