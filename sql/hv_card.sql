--
-- hvCard table
--
-- serialNo: serial number
-- hvCardLocationId: card is plugged in here
--

create table hvCard (
  serialNo varchar(32) not null,
  adcLocationId smallint,
  primary key (serialNo)
);
