--
-- splitterLocation table
--
-- id: identifier
-- label: label of this splitter, use the input cable label from Fernando
--

create table splitterLocation (
  id smallint not null,
  label varchar(128) not null,
  primary key (id)
);
