create table module (
  serialNo varchar(32) not null,
  type enum('long_6.0', 'long_4.5_sym', 'long_4.5_asym', 'long_3.0', 'short_4.5_sym', 'short_4.5_right', 'short_4.5_left') not null,
  moduleLocationId int(11) default null,
  comment varchar(128) default null,
  primary key (serialNo)
);
