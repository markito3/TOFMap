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
    | mysql -utofuser TOFMap2
echo === Create PMTs ===
grep -v \# pmt_info.txt \
    | awk '{print "INSERT INTO pmt set serialNo = \""$2"\", type = \""$3"\", pmtLocationId = "$1";"}' \
    | mysql -utofuser TOFMap2
echo === Enter data into moduleLocation table ===
awk '{print "INSERT INTO moduleLocation set", "id="$1",", "label=\""$2"\",", "layer="$3",", "moduleType=\""$4"\",", "end="$5",", "orientation=\""$6"\";"}' \
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
grep -v \# adc.txt | awk '{print "INSERT INTO adcLocation SET id = "$1", crateLocationId = "$2", slot = "$3"; INSERT INTO adc SET serialNo = \""$4"\", adcLocationId = "$1";"}' | mysql -utofuser TOFMap2
echo === Create ADC crate/slot/channel data ===
rm -f adc_csc.tmp
grep -v Slot adcs.csv | awk -F"," '{print "1 3 "$1, $2"\n1 4 "$1, $3"\n1 5 "$1, $4"\n1 6 "$1, $5"\n1 7 "$1, $6"\n1 8 "$1, $7"\n1 9 "$1, $8"\n1 10 "$1, $9"\n1 13 "$1, $10"\n1 14 "$1, $11"\n1 15 "$1, $12"\n1 16 "$1, $13}' > adc_csc.tmp
echo === Connect ADC cables to ADCs ===
grep " TOF-" adc_csc.tmp | awk '{print "UPDATE adcCable set adcLocationId = (SELECT id FROM adcLocation where crateLocationId = "$1" and slot = "$2"), channel = "$3" WHERE label = \""$4"\";"}' | mysql -utofuser TOFMap2
echo === Add HV cards and cables ===
hv.py < hv.csv | mysql -utofuser TOFMap2
echo === Add discriminators and their cables ===
disc.py < disc.csv | mysql -utofuser TOFMap2
echo === Add tdcs and their cables ===
tdc.py < tdc.csv | mysql -utofuser TOFMap2
