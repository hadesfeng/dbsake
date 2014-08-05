CREATE TABLE `time_types_test` (
  `a` time DEFAULT '00:01:02',
  `b` time DEFAULT '00:02:03',
  `c` date DEFAULT '2011-03-11',
  `d` date DEFAULT '2012-11-12',
  `e` datetime DEFAULT '2014-01-16 05:04:03',
  `f` datetime DEFAULT '2013-12-29 04:59:49',
  `g` datetime(6) DEFAULT '2014-07-09 19:07:54.181000',
  `h` datetime(6) DEFAULT '2014-07-22 22:47:23.994000',
  `i` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `j` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `k` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `l` timestamp(6) NOT NULL DEFAULT '2014-05-22 17:04:17.035000',
  `m` timestamp(6) NOT NULL DEFAULT '2014-07-24 16:42:49.142000'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
