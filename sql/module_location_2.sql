create table moduleLocation (
  id smallint not null,
  layer smallint not null,
  position smallint not null,
  moduleType enum('long_6.0', 'long_4.5_sym', 'long_4.5_asym', 'long_3.0', 'short_4.5_sym', 'short_4.5_right', 'short_4.5_left') not null,
  end smallint default null,
  orientation enum('up', 'down') not null,
  label varchar(16) not null,
  primary key (id)
);
