--
-- crate table
--
-- serialNo
-- type: type of crate
-- crateLocationId: identifier of location
--

create table crate (
  serialNo varchar(32) not null,
  type varchar(32),
  crateLocationId smallint,
  primary key (serialNo)
);
