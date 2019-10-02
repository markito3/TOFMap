--
-- adc table
--
-- id: identifier
-- adcLocationId: crate ID
-- slot: slot number
--

create table adc (
  serialNo varchar(32) not null,
  adcLocationId smallint not null,
  primary key (serialNo)
);
