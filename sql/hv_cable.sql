--
-- hvCable table
--
-- id: identifier
-- label: label of this cable, from Fernando
-- pmtLocationId: pmt on one end
-- hvCardLocationId: HV card in HV crate
-- channel: channel on card
--

create table hvCable (
  id smallint not null,
  label varchar(128),
  pmtLocationId smallint,
  hvCardLocationId smallint,
  channel smallint,
  primary key (id)
);
