PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
DROP TABLE IF EXISTS 'domainlist_by_group';
DROP TABLE IF EXISTS 'group';
DROP TABLE IF EXISTS 'domainlist';
DROP TABLE IF EXISTS 'adlist';
CREATE TABLE IF NOT EXISTS "group"
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	enabled BOOLEAN NOT NULL DEFAULT 1,
	name TEXT UNIQUE NOT NULL,
	date_added INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
	date_modified INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
	description TEXT
);
INSERT INTO "group" VALUES(0,1,'Default',1641325623,1641325623,'The default group');
CREATE TABLE domainlist
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	type INTEGER NOT NULL DEFAULT 0,
	domain TEXT NOT NULL,
	enabled BOOLEAN NOT NULL DEFAULT 1,
	date_added INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
	date_modified INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
	comment TEXT,
	UNIQUE(domain, type)
);
INSERT INTO domainlist VALUES(1,0,'micron.com',1,1589593772,1641325907,'Migrated from /etc/pihole/whitelist.txt');
INSERT INTO domainlist VALUES(2,0,'crucial.com',1,1589593772,1641325907,'Migrated from /etc/pihole/whitelist.txt');
INSERT INTO domainlist VALUES(3,0,'ytmnd.com',1,1589593772,1641325907,'Migrated from /etc/pihole/whitelist.txt');
INSERT INTO domainlist VALUES(4,0,'homedepot.com',1,1589593772,1641325907,'Migrated from /etc/pihole/whitelist.txt');
INSERT INTO domainlist VALUES(5,0,'secure2.homedepot.com',1,1589593772,1641325907,'Migrated from /etc/pihole/whitelist.txt');
INSERT INTO domainlist VALUES(6,0,'sincerelynuts.com',1,1589593772,1641325907,'Migrated from /etc/pihole/whitelist.txt');
INSERT INTO domainlist VALUES(7,0,'audible.com',1,1589593772,1641325907,'Migrated from /etc/pihole/whitelist.txt');
INSERT INTO domainlist VALUES(8,0,'mobile.audible.com',1,1589593772,1641325907,'Migrated from /etc/pihole/whitelist.txt');
INSERT INTO domainlist VALUES(9,0,'cvs.com',1,1589593772,1641325907,'Migrated from /etc/pihole/whitelist.txt');
INSERT INTO domainlist VALUES(10,0,'fabrics-store.com',1,1589593772,1641325907,'Migrated from /etc/pihole/whitelist.txt');
INSERT INTO domainlist VALUES(11,0,'ebay.com',1,1589593772,1641325907,'Migrated from /etc/pihole/whitelist.txt');
INSERT INTO domainlist VALUES(12,0,'syf.com',1,1589593772,1641325907,'Migrated from /etc/pihole/whitelist.txt');
INSERT INTO domainlist VALUES(13,0,'crowdcast.io',1,1589593772,1641325907,'Migrated from /etc/pihole/whitelist.txt');
INSERT INTO domainlist VALUES(14,0,'patreon.com',1,1589593772,1641325907,'Migrated from /etc/pihole/whitelist.txt');
INSERT INTO domainlist VALUES(15,0,'oneillhouse.net',1,1589593772,1641325907,'Migrated from /etc/pihole/whitelist.txt');
INSERT INTO domainlist VALUES(16,0,'nexus.ensighten.com',1,1589593772,1641325907,'Migrated from /etc/pihole/whitelist.txt');
INSERT INTO domainlist VALUES(17,0,'js-agent.newrelic.com',1,1589593772,1641325907,'Migrated from /etc/pihole/whitelist.txt');
INSERT INTO domainlist VALUES(18,0,'dpm.demdex.net',1,1589593772,1641325907,'Migrated from /etc/pihole/whitelist.txt');
INSERT INTO domainlist VALUES(19,0,'open.oneplus.net',1,1595102633,1641325907,NULL);
INSERT INTO domainlist VALUES(20,0,'api.segment.io',1,1597878536,1641325907,NULL);
INSERT INTO domainlist VALUES(22,0,'api.bugsee.com',1,1597878545,1641325907,NULL);
INSERT INTO domainlist VALUES(23,0,'api.leanplum.com',1,1597878567,1641325907,NULL);
INSERT INTO domainlist VALUES(24,2,'(\.|^)crowdcast\.io$',1,1613941451,1641325907,NULL);
INSERT INTO domainlist VALUES(27,0,'s0.2mdn.net',1,1625259423,1641325907,NULL);
INSERT INTO domainlist VALUES(37,2,'(\.|^)2mdn\.net$',0,1625266492,1641325907,NULL);
INSERT INTO domainlist VALUES(38,0,'cbsinteractive.hb.omtrdc.net',0,1625267059,1641325907,'Paramount Plus Roku');
INSERT INTO domainlist VALUES(39,0,'saa.cbsi.com',0,1625552842,1641325907,NULL);
INSERT INTO domainlist VALUES(41,2,'(\.|^)cws\.conviva\.com$',0,1625877844,1641325907,'Paramount Roku');
INSERT INTO domainlist VALUES(42,0,'pubads.g.doubleclick.net',0,1625878196,1641325907,'Added from Query Log');
INSERT INTO domainlist VALUES(44,0,'www.digitallis.co.uk',1,1629919058,1641325907,'Added from Query Log');
INSERT INTO domainlist VALUES(45,3,'(\.|^)harrahs\.org$',1,1630441272,1695341069,'Block work related records while not on VPN');
INSERT INTO domainlist VALUES(46,2,'(\.|^)go\.usa\.gov$',1,1651514405,1651514405,NULL);
INSERT INTO domainlist VALUES(47,0,'trace.svc.ui.com',1,1664151847,1664151847,'Added from Query Log');
INSERT INTO domainlist VALUES(48,0,'nfl.hb.omtrdc.net',1,1664152076,1664152076,'Added from Query Log');
INSERT INTO domainlist VALUES(52,2,'(\.|^)harrahs\.org$',1,1695341069,1695341069,NULL);
INSERT INTO domainlist VALUES(53,0,'app.adjust.com',1,1699693168,1699693168,'Added from Query Log');
CREATE TABLE adlist
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	address TEXT UNIQUE NOT NULL,
	enabled BOOLEAN NOT NULL DEFAULT 1,
	date_added INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
	date_modified INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
	comment TEXT,
	date_updated INTEGER,
	number INTEGER NOT NULL DEFAULT 0,
	invalid_domains INTEGER NOT NULL DEFAULT 0,
	status INTEGER NOT NULL DEFAULT 0
);
INSERT INTO adlist VALUES(1,'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts',1,1641325623,1641325623,'Migrated from /etc/pihole/adlists.list',1705205642,152449,1,1);
CREATE TABLE domainlist_by_group
(
	domainlist_id INTEGER NOT NULL REFERENCES domainlist (id),
	group_id INTEGER NOT NULL REFERENCES "group" (id),
	PRIMARY KEY (domainlist_id, group_id)
);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(1,1,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(2,2,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(3,3,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(4,4,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(5,5,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(6,6,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(7,7,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(8,8,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(9,9,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(10,10,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(11,11,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(12,12,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(13,13,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(14,14,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(15,15,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(16,16,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(17,17,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(18,18,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(19,19,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(20,20,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(21,22,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(22,23,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(23,24,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(24,37,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(25,27,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(26,39,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(27,42,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(28,41,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(29,38,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(30,44,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(31,45,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(32,46,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(33,47,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(34,48,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(37,52,0);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(38,53,0);
COMMIT;
