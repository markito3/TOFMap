create table moduleLocation (
  id smallint not null,
  layer smallint not null,
  position smallint not null,
  moduleType enum('standard', 'narrow', 'short') not null,
  end smallint default null,
  orientation enum('up', 'down') not null,
  label varchar(16) not null,
  primary key (id)
);
