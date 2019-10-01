--
-- adcCable table
--
-- id: identifier
-- label: label of this cable, from Fernando
-- pmtLocationId: pmt on one end
-- splitterLocationId: splitter on the other end
--

create table adcCable (
  id smallint not null,
  label varchar(128) not null,
  splitterLocationId smallint not null,
  adcChannelId smallint not null,
  primary key (id)
);
