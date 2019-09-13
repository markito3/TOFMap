create table pmtLocation (
  id smallint not null,
  moduleLocationId smallint default 0 not null,
  end smallint not null,
  label varchar(128) not null,
  primary key (id)
);
