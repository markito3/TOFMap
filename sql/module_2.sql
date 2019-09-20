create table module (
  serialNo varchar(32) not null,
  type enum('long_60', 'long_45_sym', 'long_45_asym', 'long_30', 'short_45_sym', 'short_45_left', 'short_45_right') not null,
  moduleLocationId int(11) default null,
  comment varchar(128) default null,
  primary key (serialNo)
);
