create table pmt (
  serialNo varchar(32) not null,
  type varchar(32) not null,
  pmtLocationId int(11) default null,
  comment varchar(128) default null,
  primary key (serialNo)
);
