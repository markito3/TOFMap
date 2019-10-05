--
-- tdcCable table
--
-- id: identifier
-- label: label of this cable, from Fernando
-- discLocationId: disc on one end
-- discChannel: discriminator channel
-- tdcLocationId: tdc on the other end
-- tdcHalf: half of the TDC
-- tdcChannel: channel number
--

create table tdcCable (
  id smallint not null,
  label varchar(128) not null,
  discLocationId smallint,
  discChannel smallint,
  tdcLocationId smallint,
  tdcHalf enum('TOP', 'BOT'),
  tdcChannel smallint,
  primary key (id)
);
