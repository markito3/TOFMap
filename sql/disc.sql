--
-- disc table
--
-- serialNo: serial number
-- discLocationId: ID of location where discriminator is
--

create table disc (
  serialNo varchar(32) not null,
  discLocationId smallint not null,
  primary key (serialNo)
);
