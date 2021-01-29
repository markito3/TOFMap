select substr(labelPhysics from 1 for 1) as horiz_or_vert, substr(labelPhysics from 4 for 1) as end, substr(labelPhysics from 2 for 2) as pmt_no, slot, channel, moduleType, pmtLocation.label
       from adcCable, adcLocation, splitterLocation, signalCable, pmtLocation, moduleLocation
       where adcLocationId = adcLocation.id
       	     and adcCable.splitterLocationId = splitterLocation.id
	     and signalCable.splitterLocationId = adcCable.splitterLocationId
	     and pmtLocationId = pmtLocation.id
	     and pmtLocation.moduleLocationId = moduleLocation.id
       order by horiz_or_vert, end, pmt_no
       into outfile '/tmp/adc.txt'
       fields terminated by ',';
