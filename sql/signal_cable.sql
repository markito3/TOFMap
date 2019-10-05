--
-- signalCable table
--
-- id: identifier
-- label: label of this cable, from Fernando
-- pmtLocationId: pmt on one end
-- splitterLocationId: splitter on the other end
--

create table signalCable (
  id smallint not null,
  label varchar(128),
  pmtLocationId smallint,
  splitterLocationId smallint,
  primary key (id)
);
