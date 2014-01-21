![dbsake](https://raw.github.com/abg/dbsake/master/sake-icon.png)

## DBSake

dbsake - a (s)wiss-(a)rmy-(k)nif(e) for various dba tasks

dbsake (pronounced "dee-bee sah-kay") is a set of commands to assist with:

  - [Parsing MySQL .frm files and output DDL][0]
  - [Splitting mysqldump output into a file per object][1]
  - [Patching a my.cnf to remove or convert deprecated options][2]
  - [Deploying a new standalone MySQL "sandbox" instance][3]
  - [Decoding/encoding MySQL filenames][4]
  - [Managing OS caching for a set of files][5]


[0]: http://docs.dbsake.net/subcommands.html#frm-to-schema
[1]: http://docs.dbsake.net/subcommands.html#split-mysqldump
[2]: http://docs.dbsake.net/subcommands.html#upgrade-mycnf
[3]: http://docs.dbsake.net/subcommands.html#mysql-sandbox
[4]: http://docs.dbsake.net/subcommands.html#filename-to-tablename
[5]: http://docs.dbsake.net/subcommands.html#fincore

Read the documentation at: http://docs.dbsake.net

## Dependencies

- Requires python v2.6+

## Quickstart

You can fetch dbsake easily from get.dbsake.net:

    $ curl get.dbsake.net > dbsake

This is an executable python zipfile.  You can see the contents by running:

    $ unzip -l dbsake
    or
    $ python -mzipfile -l dbsake

You can run as a script by making it executable:

    $ chmod u+x dbsake

Run it with no arguments to see all possible commands:

    $ ./dbsake
    Usage: dbsake COMMAND <options>

    Available commands:
     filename-to-tablename  Decode a MySQL tablename as a unicode name
     fincore                Check if a file is cached by the OS
     frm-to-schema          Decode a binary MySQl .frm file to DDL
     import-frm             Import a binary .frm as a MyISAM table
     mysql-sandbox          Create a temporary MySQL instance
     read-ib-binlog         Extract binary log filename/position from ibdata
     split-mysqldump        Split mysqldump output into separate files
     tablename-to-filename  Encode a unicode tablename as a MySQL filename
     uncache                Uncache a file from the OS page cache
     upgrade-mycnf          Patch a my.cnf to a new MySQL version

    Use 'dbsake <command> --help' for individual command help.

### "Upgrading" a my.cnf

    $ ./dbsake upgrade-mycnf --target=5.5 --config=my.cnf --patch
    [INFO]:Rewriting option 'log-slow-queries'. Reason: Logging options changed in MySQL 5.1
    [INFO]:Removing option 'skip-external-locking'. Reason: Default behavior in MySQL 4.1+
    --- a/my.cnf
    +++ b/my.cnf
    @@ -26,7 +26,6 @@
     [mysqld]
     port		= 3306
     socket		= /var/run/mysqld/mysqld.sock
    -skip-external-locking
     key_buffer_size = 384M
     max_allowed_packet = 1M
     table_open_cache = 512
    @@ -127,7 +126,9 @@
     #innodb_log_buffer_size = 8M
     #innodb_flush_log_at_trx_commit = 1
     #innodb_lock_wait_timeout = 50
    -log-slow-queries = /var/lib/mysql/slow.log
    +slow-query-log = 1
    +slow-query-log-file = /var/lib/mysql/slow.log
    +log-slow-slave-statements

     [mysqldump]
     quick

### Splitting up mysqldump output

    $ mysqldump -A | ./dbsake split-mysqldump -t 5.6 -C mydata/
    Deferring indexes and constraints for sakila.actor (mydata/sakila/actor.schema.sql)
    Injecting deferred index creation mydata/sakila/actor.data.sql
    Deferring indexes and constraints for sakila.address (mydata/sakila/address.schema.sql)
    Injecting deferred index creation mydata/sakila/address.data.sql
    Deferring indexes and constraints for sakila.city (mydata/sakila/city.schema.sql)
    Injecting deferred index creation mydata/sakila/city.data.sql
    Deferring indexes and constraints for sakila.customer (mydata/sakila/customer.schema.sql)
    Injecting deferred index creation mydata/sakila/customer.data.sql
    Deferring indexes and constraints for sakila.film (mydata/sakila/film.schema.sql)
    Injecting deferred index creation mydata/sakila/film.data.sql
    Deferring indexes and constraints for sakila.film_actor (mydata/sakila/film_actor.schema.sql)
    Injecting deferred index creation mydata/sakila/film_actor.data.sql
    Deferring indexes and constraints for sakila.film_category (mydata/sakila/film_category.schema.sql)
    Injecting deferred index creation mydata/sakila/film_category.data.sql
    Deferring indexes and constraints for sakila.inventory (mydata/sakila/inventory.schema.sql)
    Injecting deferred index creation mydata/sakila/inventory.data.sql
    Deferring indexes and constraints for sakila.payment (mydata/sakila/payment.schema.sql)
    Injecting deferred index creation mydata/sakila/payment.data.sql
    Deferring indexes and constraints for sakila.rental (mydata/sakila/rental.schema.sql)
    Injecting deferred index creation mydata/sakila/rental.data.sql
    Deferring indexes and constraints for sakila.staff (mydata/sakila/staff.schema.sql)
    Injecting deferred index creation mydata/sakila/staff.data.sql
    Deferring indexes and constraints for sakila.store (mydata/sakila/store.schema.sql)
    Injecting deferred index creation mydata/sakila/store.data.sql
    Split input into 6 database(s) 44 table(s) and 14 view(s)

### Deploying a MySQL sandbox instance

```bash
$ ./dbsake mysql-sandbox -m 5.7.3-m13
Preparing sandbox instance: /home/localuser/sandboxes/sandbox_20140121_221858
  Creating sandbox directories
    - Created /home/localuser/sandboxes/sandbox_20140121_221858/data
    - Created /home/localuser/sandboxes/sandbox_20140121_221858/tmp
    * Prepared sandbox in 0.00 seconds
  Deploying MySQL distribution
    - Attempting to deploy distribution for MySQL 5.7.3-m13
    - Downloading from http://cdn.mysql.com/Downloads/MySQL-5.7/mysql-5.7.3-m13-linux-glibc2.5-x86_64.tar.gz
    - Caching download: /home/localuser/.dbsake/cache/mysql-5.7.3-m13-linux-glibc2.5-x86_64.tar.gz
    - Unpacking tar stream. This may take some time
(100.00%)[========================================] 322.9MiB / 322.9MiB
    - Stored MD5 checksum for download: /home/localuser/.dbsake/cache/mysql-5.7.3-m13-linux-glibc2.5-x86_64.tar.gz.md5
    - Using mysqld (v5.7.3): /home/localuser/sandboxes/sandbox_20140121_221858/bin/mysqld
    - Using mysqld_safe: /home/localuser/sandboxes/sandbox_20140121_221858/bin/mysqld_safe
    - Using mysql: /home/localuser/sandboxes/sandbox_20140121_221858/bin/mysql
    - Using share directory: /home/localuser/sandboxes/sandbox_20140121_221858/share
    - Using mysqld --basedir: /home/localuser/sandboxes/sandbox_20140121_221858
    - Using MySQL plugin directory: /home/localuser/sandboxes/sandbox_20140121_221858/lib/plugin
    * Deployed MySQL distribution to sandbox in 17.42 seconds
  Generating my.sandbox.cnf
    - Generated random password for sandbox user root@localhost
    * Generated /home/localuser/sandboxes/sandbox_20140121_221858/my.sandbox.cnf in 0.00 seconds
  Bootstrapping sandbox instance
    - Logging bootstrap output to /home/localuser/sandboxes/sandbox_20140121_221858/bootstrap.log
    - Generated bootstrap SQL
    - Running /home/localuser/sandboxes/sandbox_20140121_221858/bin/mysqld --defaults-file=/home/localuser/sandboxes/sandbox_20140121_221858/my.sandbox.cnf --bootstrap
    * Bootstrapped sandbox in 3.56 seconds
  Creating sandbox.sh initscript
    * Generated initscript in 0.00 seconds
Sandbox created in 20.98 seconds
Here are some useful sandbox commands
       Start sandbox: /home/localuser/sandboxes/sandbox_20140121_221858/sandbox.sh start
        Stop sandbox: /home/localuser/sandboxes/sandbox_20140121_221858/sandbox.sh stop
  Connect to sandbox: /home/localuser/sandboxes/sandbox_20140121_221858/sandbox.sh mysql <options>
   mysqldump sandbox: /home/localuser/sandboxes/sandbox_20140121_221858/sandbox.sh mysqldump <options>
Install SysV service: /home/localuser/sandboxes/sandbox_20140121_221858/sandbox.sh install-service
```

```bash
$ /home/localuser/sandboxes/sandbox_20140121_221858/sandbox.sh start
Starting sandbox: [OK]
```

The sandbox.sh script has some convenient commands for interacting with the sandbox too:

```bash
$ /home/localuser/sandboxes/sandbox_20140121_221858/sandbox.sh mysql -e 'select @@datadir, @@version, @@version_comment\G'
*************************** 1. row ***************************
        @@datadir: /home/localuser/sandboxes/sandbox_20140121_221858/data/
        @@version: 5.7.3-m13-log
@@version_comment: MySQL Community Server (GPL)
```

The sandbox.sh script can also install itself, if you want to make the sandbox more persistent:

```bash
$ sudo /home/localuser/sandboxes/sandbox_20140121_221858/sandbox.sh install-service
+ /bin/cp /home/localuser/sandboxes/sandbox_20140121_221858/sandbox.sh /etc/init.d/mysql-5.7.3
+ /sbin/chkconfig --add mysql-5.7.3 && /sbin/chkconfig mysql-5.7.3 on
Service installed in /etc/init.d/mysql-5.7.3 and added to default runlevels
```

### Extracting the schema from a binary .frm file

```
$ sudo ./dbsake frm-to-schema /var/lib/mysql/sakila/actor.frm
--
-- Table structure for table `actor`
-- Created with MySQL Version 5.5.34
--

CREATE TABLE `actor` (
  `actor_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`actor_id`),
  KEY `idx_actor_last_name` (`last_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```
You can also format VIEW .frm files directly as well:
```
$ sudo ./dbsake frm-to-schema /var/lib/mysql/sakila/actor_info.frm
--
-- View:         actor_info
-- Timestamp:    2014-01-18 18:22:54
-- Stored MD5:   402b8673b0c61034644b5b286519d3f1
-- Computed MD5: 402b8673b0c61034644b5b286519d3f1
--

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `actor_info` AS select `a`.`actor_id` AS `actor_id`,`a`.`first_name` AS `first_name`,`a`.`last_name` AS `last_name`,group_concat(distinct concat(`c`.`name`,': ',(select group_concat(`f`.`title` order by `f`.`title` ASC separator ', ') from ((`sakila`.`film` `f` join `sakila`.`film_category` `fc` on((`f`.`film_id` = `fc`.`film_id`))) join `sakila`.`film_actor` `fa` on((`f`.`film_id` = `fa`.`film_id`))) where ((`fc`.`category_id` = `c`.`category_id`) and (`fa`.`actor_id` = `a`.`actor_id`)))) order by `c`.`name` ASC separator '; ') AS `film_info` from (((`sakila`.`actor` `a` left join `sakila`.`film_actor` `fa` on((`a`.`actor_id` = `fa`.`actor_id`))) left join `sakila`.`film_category` `fc` on((`fa`.`film_id` = `fc`.`film_id`))) left join `sakila`.`category` `c` on((`fc`.`category_id` = `c`.`category_id`))) group by `a`.`actor_id`,`a`.`first_name`,`a`.`last_name`;
```

## License

dbsake is licensed under GPLv2.
