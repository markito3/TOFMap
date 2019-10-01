--
-- adcCable table
--
-- id: identifier
-- label: label of this cable, from Fernando
-- pmtLocationId: pmt on one end
-- adcLocationId: adc on the other end
-- channel: channel number
--

create table adcCable (
  id smallint not null,
  label varchar(128) not null,
  splitterLocationId smallint,
  adcLocationId smallint,
  channel smallint,
  primary key (id)
);
