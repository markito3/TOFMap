--
-- crateLocation table
--
-- id: identifier
-- cratePositionLabel: label
--

create table crateLocation (
  id smallint not null,
  cratePositionLabel varchar(32),
  primary key (id)
);
