--
-- discCable table
--
-- id: identifier
-- label: label of this cable, from Fernando
-- splitterLocationId: splitter on one end
-- discLocationId: discriminator location on the other end
-- channel: discriminator channel number
--

create table discCable (
  id smallint not null,
  label varchar(128) not null,
  splitterLocationId smallint,
  discLocationId smallint,
  channel smallint,
  primary key (id)
);
