--
-- moduleLocation table
--  for TOF II
--
-- id: identifier
-- layer: upstream (-1) or downstream (+1)
-- moduleType: one of seven geometries for the modules
-- end: NULL for double ended modules, -1 or +1 for single-ended, sign goes
--      with physicist coordinate system
-- orientation: tilt of light guides, up or down, up = tilted upstream
-- label: text label for the module location
--

create table moduleLocation (
  id smallint not null,
  layer smallint not null,
  moduleType enum('long_60', 'long_45_sym', 'long_45_asym', 'long_30',
  	     'short_45_sym', 'short_45_left', 'short_45_right') not null,
  end smallint default null,
  orientation enum('up', 'down') not null,
  label varchar(16) not null,
  primary key (id)
);
