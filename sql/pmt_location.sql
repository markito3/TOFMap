--
-- pmtLocation table
--
-- id: identifier
-- moduleLocationId: pointer to the location of a module
-- end: end of module that is occupied by this pmt
-- label: label of this pmt location, use the cable label from Fernando
--

create table pmtLocation (
  id smallint not null,
  moduleLocationId smallint,
  end smallint,
  label varchar(128),
  labelPhysics char(4),
  primary key (id)
);
