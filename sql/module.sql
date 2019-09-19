create table module (
  serialNo varchar(32) not null,
  type enum('standard', 'narrow', 'short') not null,
  moduleLocationId int(11) default null,
  comment varchar(128) default null,
  primary key (serialNo)
);
