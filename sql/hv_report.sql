select hvCable.label, channel, slot from hvCable, pmtLocation, hvCardLocation where pmtLocationId = pmtLocation.id and hvCardLocationId = hvCardLocation.id order by slot, channel;
