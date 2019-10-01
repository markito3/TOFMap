--
-- adcLocation table
--
-- id: identifier
-- crateId: crate ID
-- slot: slot number
--

create table adcLocation (
  id smallint not null,
  crateId smallint not null,
  slot smallint not null,
  primary key (id)
);
