create table moduleLocation (
  id smallint not null,
  layer smallint not null,
  position smallint not null,
  moduleType enum('long_60', 'long_45_sym', 'long_45_asym', 'long_30', 'short_45_sym', 'short_45_left', 'short_45_right') not null,
  end smallint default null,
  orientation enum('up', 'down') not null,
  label varchar(16) not null,
  primary key (id)
);
