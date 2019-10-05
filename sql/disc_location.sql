--
-- discLocation table
--
-- id: identifier
-- crateLocationId: crate ID
-- slot: slot number
--

create table discLocation (
  id smallint not null,
  crateLocationId smallint not null,
  slot smallint not null,
  primary key (id)
);
