--
-- tdc table
--
-- id: identifier
-- tdcLocationId: crate ID
--

create table tdc (
  serialNo varchar(32) not null,
  tdcLocationId smallint not null,
  primary key (serialNo)
);
