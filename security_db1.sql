-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.17-nt


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema securitydb
--

CREATE DATABASE IF NOT EXISTS securitydb;
USE securitydb;

--
-- Definition of table `logindetail`
--

DROP TABLE IF EXISTS `logindetail`;
CREATE TABLE `logindetail` (
  `id` bigint(20) NOT NULL auto_increment,
  `loginstatusid` bigint(20) NOT NULL,
  `sessionid` varchar(100) NOT NULL,
  `logintime` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `logouttime` varchar(50) default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`),
  KEY `FK_logindtl_1` (`loginstatusid`),
  CONSTRAINT `FK_loginstatus_id` FOREIGN KEY (`loginstatusid`) REFERENCES `loginstatus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `logindetail`
--

/*!40000 ALTER TABLE `logindetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `logindetail` ENABLE KEYS */;


--
-- Definition of table `loginstatus`
--

DROP TABLE IF EXISTS `loginstatus`;
CREATE TABLE `loginstatus` (
  `id` bigint(20) NOT NULL auto_increment,
  `userid` bigint(20) NOT NULL,
  `loggedin` char(1) NOT NULL,
  `lastlogintime` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `FK_userid` (`userid`),
  CONSTRAINT `FK_userid` FOREIGN KEY (`userid`) REFERENCES `msecusers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `loginstatus`
--

/*!40000 ALTER TABLE `loginstatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `loginstatus` ENABLE KEYS */;


--
-- Definition of table `msecbusgroups`
--

DROP TABLE IF EXISTS `msecbusgroups`;
CREATE TABLE `msecbusgroups` (
  `id` bigint(20) NOT NULL auto_increment,
  `name` varchar(15) NOT NULL,
  `tenantId` bigint(20) default NULL,
  `createdby` varchar(45) default NULL,
  `createddate` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `modifiedby` varchar(45) default NULL,
  `modifieddate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `deletionstatus` char(1) NOT NULL,
  `description` varchar(60) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `busgrp_code_unique_const` USING BTREE (`name`),
  KEY `FK_sysfacet_id` (`tenantId`),
  CONSTRAINT `FK_tenant_id` FOREIGN KEY (`tenantId`) REFERENCES `systenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `msecbusgroups`
--

/*!40000 ALTER TABLE `msecbusgroups` DISABLE KEYS */;
INSERT INTO `msecbusgroups` (`id`,`name`,`tenantId`,`createdby`,`createddate`,`modifiedby`,`modifieddate`,`deletionstatus`,`description`) VALUES 
 (1,'SecurityGrpName',NULL,'admin','2013-05-01 11:35:41','admin','2013-05-01 11:35:41','N','SecurityGrpdesc'),
 (2,'NewGrpName',NULL,'admin','2013-05-14 14:28:06','admin','2013-05-14 14:28:06','N','NewGrpdesc');
/*!40000 ALTER TABLE `msecbusgroups` ENABLE KEYS */;


--
-- Definition of table `msecbusrolemenu`
--

DROP TABLE IF EXISTS `msecbusrolemenu`;
CREATE TABLE `msecbusrolemenu` (
  `id` bigint(20) NOT NULL auto_increment,
  `busRoleId` bigint(20) NOT NULL,
  `menuItemId` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK_busrole_id1` (`busRoleId`),
  KEY `FK_menuItem_id` (`menuItemId`),
  CONSTRAINT `FK_menuItem_id` FOREIGN KEY (`menuItemId`) REFERENCES `msecmenuitem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_busrole_id1` FOREIGN KEY (`busRoleId`) REFERENCES `msecbusroles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `msecbusrolemenu`
--

/*!40000 ALTER TABLE `msecbusrolemenu` DISABLE KEYS */;
INSERT INTO `msecbusrolemenu` (`id`,`busRoleId`,`menuItemId`) VALUES 
 (10,2,1),
 (12,2,3),
 (21,2,2),
 (26,1,9),
 (27,1,8),
 (31,1,7),
 (32,4,1),
 (33,4,3),
 (34,4,4),
 (35,4,2),
 (36,3,1),
 (37,3,4),
 (38,3,2);
/*!40000 ALTER TABLE `msecbusrolemenu` ENABLE KEYS */;


--
-- Definition of table `msecbusroles`
--

DROP TABLE IF EXISTS `msecbusroles`;
CREATE TABLE `msecbusroles` (
  `id` bigint(20) NOT NULL auto_increment,
  `busgroupid` bigint(20) NOT NULL,
  `name` varchar(15) NOT NULL,
  `createdby` varchar(45) default NULL,
  `createddate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `modifiedby` varchar(45) default NULL,
  `modifieddate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `deletionstatus` char(1) NOT NULL,
  `description` varchar(60) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `busrole_code_unique_const` USING BTREE (`name`),
  KEY `FK_busGroup_id` (`busgroupid`),
  CONSTRAINT `FK_busGroup_id` FOREIGN KEY (`busgroupid`) REFERENCES `msecbusgroups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `msecbusroles`
--

/*!40000 ALTER TABLE `msecbusroles` DISABLE KEYS */;
INSERT INTO `msecbusroles` (`id`,`busgroupid`,`name`,`createdby`,`createddate`,`modifiedby`,`modifieddate`,`deletionstatus`,`description`) VALUES 
 (1,2,'rolename',NULL,'2013-05-21 12:41:11',NULL,'2013-05-21 12:40:55','N','description'),
 (2,1,'rolename1','admin','2013-05-14 20:22:23','admin','2013-05-14 17:56:10','N','rolename_desc2'),
 (3,1,'rolename2','admin','2013-05-14 20:22:23','admin','2013-05-14 17:55:06','N','rolename_desc3'),
 (4,2,'rolename4','admin','2013-05-14 20:22:23','admin','2013-05-14 14:28:08','N','rolename_desc4');
/*!40000 ALTER TABLE `msecbusroles` ENABLE KEYS */;


--
-- Definition of table `msecentities`
--

DROP TABLE IF EXISTS `msecentities`;
CREATE TABLE `msecentities` (
  `id` bigint(20) NOT NULL auto_increment,
  `parentId` bigint(20) default NULL,
  `name` varchar(255) default NULL,
  `table` varchar(255) default NULL,
  `createdby` varchar(45) default NULL,
  `createddate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `modifiedby` varchar(45) default NULL,
  `modifieddate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `deletionstatus` char(1) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `msecentities`
--

/*!40000 ALTER TABLE `msecentities` DISABLE KEYS */;
INSERT INTO `msecentities` (`id`,`parentId`,`name`,`table`,`createdby`,`createddate`,`modifiedby`,`modifieddate`,`deletionstatus`) VALUES 
 (1,NULL,'BIM',NULL,'admin','2013-05-14 13:26:00','admin','2013-05-11 18:31:26','N'),
 (2,1,'Bim Child',NULL,'admin','2013-05-14 20:11:04','admin','2013-05-11 18:31:26','N'),
 (3,2,'Bim Child1',NULL,'admin','2013-05-14 20:11:05','admin','2013-05-12 18:02:30','N'),
 (4,2,'Bim Child2',NULL,'admin','2013-05-14 13:26:13','admin','2013-05-14 13:26:13','N'),
 (5,NULL,'SECURITY',NULL,'admin','2013-05-14 13:26:13','admin','2013-05-14 13:26:13','N'),
 (6,5,'Security Child',NULL,'admin','2013-05-14 13:26:13','admin','2013-05-14 13:26:13','N'),
 (7,6,'Security Child1',NULL,'admin','2013-05-14 13:26:13','admin','2013-05-14 13:26:13','N'),
 (8,6,'Security Child2',NULL,'admin','2013-05-14 13:26:13','admin','2013-05-14 13:26:13','N');
/*!40000 ALTER TABLE `msecentities` ENABLE KEYS */;


--
-- Definition of table `msechierarchygroups`
--

DROP TABLE IF EXISTS `msechierarchygroups`;
CREATE TABLE `msechierarchygroups` (
  `id` bigint(20) NOT NULL auto_increment,
  `tenantId` bigint(20) default NULL,
  `name` varchar(15) NOT NULL,
  `createdby` varchar(45) default NULL,
  `createddate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `modifiedby` varchar(45) default NULL,
  `modifieddate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `deletionstatus` char(1) NOT NULL,
  `description` varchar(60) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `hiergrp_code_unique_const` USING BTREE (`name`),
  KEY `FK_facet_id_hierarchy` (`tenantId`),
  CONSTRAINT `FK_tenant_id_hierarchy` FOREIGN KEY (`tenantId`) REFERENCES `systenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `msechierarchygroups`
--

/*!40000 ALTER TABLE `msechierarchygroups` DISABLE KEYS */;
INSERT INTO `msechierarchygroups` (`id`,`tenantId`,`name`,`createdby`,`createddate`,`modifiedby`,`modifieddate`,`deletionstatus`,`description`) VALUES 
 (1,NULL,'hiergrp_name','admin','2013-05-01 11:35:41','admin','2013-05-01 11:35:41','N','hiergrp_desc'),
 (2,NULL,'hiergrp_name1','admin','2013-05-14 20:32:42','admin','2013-05-11 18:22:39','N','hiergrp_desc1'),
 (3,NULL,'hierGrp','admin','2013-05-14 20:32:42','admin','2013-05-11 18:23:50','N','grpdesc'),
 (4,NULL,'NewHierGrp','admin','2013-05-14 20:32:53','admin','2013-05-11 18:41:36','N','Newgrpdesc1');
/*!40000 ALTER TABLE `msechierarchygroups` ENABLE KEYS */;


--
-- Definition of table `msechierarchyroleentities`
--

DROP TABLE IF EXISTS `msechierarchyroleentities`;
CREATE TABLE `msechierarchyroleentities` (
  `id` bigint(20) NOT NULL auto_increment,
  `hierarchyroleId` bigint(20) NOT NULL,
  `entityId` bigint(20) NOT NULL,
  `ccreate` bigint(20) default NULL,
  `cread` bigint(20) default NULL,
  `cupdate` bigint(20) default NULL,
  `cdelete` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK_hierarchyrole` (`hierarchyroleId`),
  KEY `FK_dataentity_id` (`entityId`),
  CONSTRAINT `FK_entity_id` FOREIGN KEY (`entityId`) REFERENCES `msecentities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_hierarchyrole_id` FOREIGN KEY (`hierarchyroleId`) REFERENCES `msechierarchyroles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `msechierarchyroleentities`
--

/*!40000 ALTER TABLE `msechierarchyroleentities` DISABLE KEYS */;
INSERT INTO `msechierarchyroleentities` (`id`,`hierarchyroleId`,`entityId`,`ccreate`,`cread`,`cupdate`,`cdelete`) VALUES 
 (1,1,1,NULL,NULL,NULL,NULL),
 (2,1,2,NULL,NULL,NULL,NULL),
 (3,3,2,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `msechierarchyroleentities` ENABLE KEYS */;


--
-- Definition of table `msechierarchyroles`
--

DROP TABLE IF EXISTS `msechierarchyroles`;
CREATE TABLE `msechierarchyroles` (
  `id` bigint(20) NOT NULL auto_increment,
  `name` varchar(15) NOT NULL,
  `hierarchygroupId` bigint(20) NOT NULL,
  `createdby` varchar(45) default NULL,
  `createddate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `modifiedby` varchar(45) default NULL,
  `modifieddate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `deletionstatus` char(1) NOT NULL,
  `description` varchar(60) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `hierrole_code_unique_const` USING BTREE (`name`),
  KEY `FK_hierarchy_group_id` (`hierarchygroupId`),
  CONSTRAINT `FK_hierarchy_group_id` FOREIGN KEY (`hierarchygroupId`) REFERENCES `msechierarchygroups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `msechierarchyroles`
--

/*!40000 ALTER TABLE `msechierarchyroles` DISABLE KEYS */;
INSERT INTO `msechierarchyroles` (`id`,`name`,`hierarchygroupId`,`createdby`,`createddate`,`modifiedby`,`modifieddate`,`deletionstatus`,`description`) VALUES 
 (1,'hierrole_name',1,'admin','2013-05-01 11:35:41','admin','2013-05-01 11:35:41','N','hierrole_desc'),
 (2,'hierrole_name1',1,'admin','2013-05-14 20:13:36','admin','2013-05-11 18:16:08','N','hierrole_desc1'),
 (3,'hierrolename2',4,'admin','2013-05-14 20:33:35','admin','2013-05-11 18:42:45','N','hierrole_desc2'),
 (4,'Namehierrole',4,'admin','2013-05-14 20:33:35','admin','2013-05-14 11:09:27','N','hierrole_desc3');
/*!40000 ALTER TABLE `msechierarchyroles` ENABLE KEYS */;


--
-- Definition of table `mseclanguages`
--

DROP TABLE IF EXISTS `mseclanguages`;
CREATE TABLE `mseclanguages` (
  `id` bigint(20) NOT NULL auto_increment,
  `code` varchar(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `createdby` varchar(45) default NULL,
  `createddate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `modifiedby` varchar(45) default NULL,
  `modifieddate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `deletionstatus` char(1) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `code_constraint` (`code`),
  UNIQUE KEY `name_constraint` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mseclanguages`
--

/*!40000 ALTER TABLE `mseclanguages` DISABLE KEYS */;
INSERT INTO `mseclanguages` (`id`,`code`,`name`,`createdby`,`createddate`,`modifiedby`,`modifieddate`,`deletionstatus`) VALUES 
 (1,'101','English','admin','2012-11-07 12:38:20','admin','2012-11-06 18:50:32','N'),
 (2,'102','Spanish','admin','2012-12-06 17:48:27','admin','2012-11-06 18:50:32','N'),
 (3,'103','French','admin','2012-11-07 12:38:20','admin','2012-11-06 18:50:32','N');
/*!40000 ALTER TABLE `mseclanguages` ENABLE KEYS */;


--
-- Definition of table `mseclicenseitem`
--

DROP TABLE IF EXISTS `mseclicenseitem`;
CREATE TABLE `mseclicenseitem` (
  `id` bigint(20) NOT NULL,
  `licensepoolId` bigint(20) NOT NULL,
  `licenseCode` varchar(255) NOT NULL,
  `count` bigint(20) NOT NULL,
  `expiryDate` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK_licencepool_id` (`licensepoolId`),
  CONSTRAINT `FK_licencepool_id` FOREIGN KEY (`licensepoolId`) REFERENCES `mseclicensepool` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mseclicenseitem`
--

/*!40000 ALTER TABLE `mseclicenseitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `mseclicenseitem` ENABLE KEYS */;


--
-- Definition of table `mseclicensepool`
--

DROP TABLE IF EXISTS `mseclicensepool`;
CREATE TABLE `mseclicensepool` (
  `id` bigint(20) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mseclicensepool`
--

/*!40000 ALTER TABLE `mseclicensepool` DISABLE KEYS */;
INSERT INTO `mseclicensepool` (`id`,`name`) VALUES 
 (1,'BR'),
 (2,'CAUSEWAY'),
 (3,'CONNECT');
/*!40000 ALTER TABLE `mseclicensepool` ENABLE KEYS */;


--
-- Definition of table `msecmenuitem`
--

DROP TABLE IF EXISTS `msecmenuitem`;
CREATE TABLE `msecmenuitem` (
  `id` bigint(20) NOT NULL auto_increment,
  `parentId` bigint(20) default NULL,
  `name` varchar(255) NOT NULL,
  `launchUrl` varchar(1000) default NULL,
  `licenseCode` varchar(255) default NULL,
  `createdby` varchar(45) default NULL,
  `createddate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `modifiedby` varchar(45) default NULL,
  `modifieddate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `deletionstatus` char(1) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK_msecprogram_id` (`licenseCode`),
  KEY `FK_selfjoin_parentid` (`parentId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `msecmenuitem`
--

/*!40000 ALTER TABLE `msecmenuitem` DISABLE KEYS */;
INSERT INTO `msecmenuitem` (`id`,`parentId`,`name`,`launchUrl`,`licenseCode`,`createdby`,`createddate`,`modifiedby`,`modifieddate`,`deletionstatus`) VALUES 
 (1,NULL,'BIM',NULL,NULL,'admin','2013-04-23 18:05:23','admin','2012-11-06 18:50:32','N'),
 (2,1,'BIM Manager','',NULL,'admin','2013-05-13 15:40:20','admin','2012-11-06 18:50:32','N'),
 (3,2,'Clash Detection','','BIM_CLASH','admin','2013-05-04 15:07:03','admin','2012-11-06 18:50:32','N'),
 (4,2,'Versioning',NULL,'BIM_VERSION','admin','2013-05-04 15:07:03','admin','2012-11-06 18:50:32','N'),
 (5,2,'QA Logs',NULL,'BIM_MEASURE','admin','2013-05-04 15:16:43','admin','2012-11-06 18:50:32','N'),
 (6,7,'RFIs',NULL,NULL,'admin','2013-05-14 04:58:50','admin','2012-11-06 18:50:32','N'),
 (7,9,'BIM Desktop','https://www.google.co.in',NULL,'admin','2013-05-13 16:06:32','admin','2012-11-06 18:50:32','N'),
 (8,7,'Measure',NULL,'BIM_MEASURE','admin','2013-05-04 15:09:43','admin','2012-11-06 18:50:32','N'),
 (9,NULL,'FINANCE',NULL,NULL,'admin','2013-04-23 18:05:23','admin','2013-04-23 18:05:23','N'),
 (10,NULL,'SIP','',NULL,'admin','2013-04-23 18:05:23','admin','2013-04-23 18:05:23','N'),
 (11,10,'Security',NULL,'SIP_security','admin','2013-04-23 18:05:23','admin','2013-04-23 18:05:23','N'),
 (12,11,'Mashapps',NULL,'SIP_Mashapps','admin','2013-05-04 15:09:45','admin','2013-04-23 18:05:23','N'),
 (13,11,'Wavemaker',NULL,'SIP_Wavemaker','admin','2013-05-04 15:09:43','admin','2013-04-23 18:05:23','N');
/*!40000 ALTER TABLE `msecmenuitem` ENABLE KEYS */;


--
-- Definition of table `msectenantuser`
--

DROP TABLE IF EXISTS `msectenantuser`;
CREATE TABLE `msectenantuser` (
  `id` bigint(20) NOT NULL auto_increment,
  `tenantId` bigint(20) NOT NULL,
  `userId` bigint(20) NOT NULL,
  `userbusroles` bigint(20) default NULL,
  `userhierroles` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK_user_id1` (`userId`),
  KEY `FK_systenant_id` (`tenantId`),
  CONSTRAINT `FK_systenant_id` FOREIGN KEY (`tenantId`) REFERENCES `systenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_user_id1` FOREIGN KEY (`userId`) REFERENCES `msecusers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `msectenantuser`
--

/*!40000 ALTER TABLE `msectenantuser` DISABLE KEYS */;
INSERT INTO `msectenantuser` (`id`,`tenantId`,`userId`,`userbusroles`,`userhierroles`) VALUES 
 (1,1,5107,1,1);
/*!40000 ALTER TABLE `msectenantuser` ENABLE KEYS */;


--
-- Definition of table `msecuserbusroles`
--

DROP TABLE IF EXISTS `msecuserbusroles`;
CREATE TABLE `msecuserbusroles` (
  `id` bigint(20) NOT NULL auto_increment,
  `userId` bigint(20) NOT NULL,
  `busRoleId` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK_msecuserbusroles_1` (`busRoleId`),
  KEY `FK_msecuserbusroles_2` (`userId`),
  CONSTRAINT `FK_msecuserbusroles_2` FOREIGN KEY (`userId`) REFERENCES `msecusers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_msecuserbusroles_1` FOREIGN KEY (`busRoleId`) REFERENCES `msecbusroles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `msecuserbusroles`
--

/*!40000 ALTER TABLE `msecuserbusroles` DISABLE KEYS */;
/*!40000 ALTER TABLE `msecuserbusroles` ENABLE KEYS */;


--
-- Definition of table `msecuserhierarchyroles`
--

DROP TABLE IF EXISTS `msecuserhierarchyroles`;
CREATE TABLE `msecuserhierarchyroles` (
  `id` bigint(20) NOT NULL auto_increment,
  `userId` bigint(20) NOT NULL,
  `hierarchyRoleId` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK_users_id` (`userId`),
  KEY `FK_hiearchyRole_id` (`hierarchyRoleId`),
  CONSTRAINT `FK_hiearchyRole_id` FOREIGN KEY (`hierarchyRoleId`) REFERENCES `msechierarchyroles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_users_id` FOREIGN KEY (`userId`) REFERENCES `msecusers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `msecuserhierarchyroles`
--

/*!40000 ALTER TABLE `msecuserhierarchyroles` DISABLE KEYS */;
/*!40000 ALTER TABLE `msecuserhierarchyroles` ENABLE KEYS */;


--
-- Definition of table `msecuserpwdhist`
--

DROP TABLE IF EXISTS `msecuserpwdhist`;
CREATE TABLE `msecuserpwdhist` (
  `id` bigint(20) NOT NULL auto_increment,
  `whenchange` varchar(255) default NULL,
  `pwd` varchar(255) NOT NULL,
  `userid` bigint(20) NOT NULL,
  `createdby` varchar(45) default NULL,
  `createddate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `modifiedby` varchar(45) default NULL,
  `modifieddate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `deletionstatus` char(1) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FKD7DEB630E545F90D` (`userid`),
  CONSTRAINT `FK_msecuser_id` FOREIGN KEY (`userid`) REFERENCES `msecusers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `msecuserpwdhist`
--

/*!40000 ALTER TABLE `msecuserpwdhist` DISABLE KEYS */;
INSERT INTO `msecuserpwdhist` (`id`,`whenchange`,`pwd`,`userid`,`createdby`,`createddate`,`modifiedby`,`modifieddate`,`deletionstatus`) VALUES 
 (5153,'2013-05-08 15:11:52','21232f297a57a5a743894a0e4a801fc3',5104,'admin','2012-11-07 12:40:55','admin','2012-11-06 18:50:32','N'),
 (5154,'2013-05-08 15:11:52','62ae3923eefd39fb45f8d90c3cadfb99',5107,'admin','2013-05-01 12:28:09','admin','2013-05-01 11:35:41','N');
/*!40000 ALTER TABLE `msecuserpwdhist` ENABLE KEYS */;


--
-- Definition of table `msecusers`
--

DROP TABLE IF EXISTS `msecusers`;
CREATE TABLE `msecusers` (
  `id` bigint(20) NOT NULL auto_increment,
  `authPIN` bigint(20) default NULL,
  `defentity` varchar(255) NOT NULL,
  `email` varchar(200) NOT NULL,
  `language` bigint(20) default NULL,
  `mobile` varchar(200) default NULL,
  `name` varchar(200) NOT NULL,
  `status` varchar(255) NOT NULL,
  `username` varchar(200) NOT NULL,
  `photo` mediumblob,
  `createdby` varchar(45) default NULL,
  `createddate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `modifiedby` varchar(45) default NULL,
  `modifieddate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `deletionstatus` char(1) NOT NULL,
  `passnxtchange` int(10) NOT NULL,
  `password` varchar(50) default NULL,
  `pwdattempts` int(11) unsigned default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `uname_constraint` (`username`),
  UNIQUE KEY `email_constraint` (`email`),
  KEY `FK_mseclanguage_id` (`language`),
  CONSTRAINT `FK_mseclanguage_id` FOREIGN KEY (`language`) REFERENCES `mseclanguages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `msecusers`
--

/*!40000 ALTER TABLE `msecusers` DISABLE KEYS */;
INSERT INTO `msecusers` (`id`,`authPIN`,`defentity`,`email`,`language`,`mobile`,`name`,`status`,`username`,`photo`,`createdby`,`createddate`,`modifiedby`,`modifieddate`,`deletionstatus`,`passnxtchange`,`password`,`pwdattempts`) VALUES 
 (5104,1234,'Irish Division','admin@email.com',1,'9876543245','admin','Active','admin',NULL,'admin','2013-05-01 15:05:52','admin','2012-11-06 18:50:32','N',0,'21232f297a57a5a743894a0e4a801fc3',0),
 (5107,12,'Southern Division','email@email.com',1,'9876543245','Administrator','Active','Administrator',NULL,'admin','2013-05-01 15:05:52','admin','2013-05-01 11:35:41','N',0,'21232f297a57a5a743894a0e4a801fc3',0);
/*!40000 ALTER TABLE `msecusers` ENABLE KEYS */;


--
-- Definition of table `msecuserscount`
--

DROP TABLE IF EXISTS `msecuserscount`;
CREATE TABLE `msecuserscount` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `parentuserid` bigint(20) NOT NULL,
  `childuserid` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK_msecusers_created_id` (`childuserid`),
  KEY `FK_msecusers_createdby_id` (`parentuserid`),
  CONSTRAINT `FK_childuserid` FOREIGN KEY (`childuserid`) REFERENCES `msecusers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_parentuserid` FOREIGN KEY (`parentuserid`) REFERENCES `msecusers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 9216 kB; (`msecusers_createdby_id`) REFER `secu';

--
-- Dumping data for table `msecuserscount`
--

/*!40000 ALTER TABLE `msecuserscount` DISABLE KEYS */;
/*!40000 ALTER TABLE `msecuserscount` ENABLE KEYS */;


--
-- Definition of table `openjpa_sequence_table`
--

DROP TABLE IF EXISTS `openjpa_sequence_table`;
CREATE TABLE `openjpa_sequence_table` (
  `ID` tinyint(4) NOT NULL,
  `SEQUENCE_VALUE` bigint(20) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `openjpa_sequence_table`
--

/*!40000 ALTER TABLE `openjpa_sequence_table` DISABLE KEYS */;
INSERT INTO `openjpa_sequence_table` (`ID`,`SEQUENCE_VALUE`) VALUES 
 (0,5401);
/*!40000 ALTER TABLE `openjpa_sequence_table` ENABLE KEYS */;


--
-- Definition of table `syscontrols`
--

DROP TABLE IF EXISTS `syscontrols`;
CREATE TABLE `syscontrols` (
  `id` bigint(20) NOT NULL auto_increment,
  `maxpwddays` bigint(20) NOT NULL,
  `minpwdlen` bigint(20) NOT NULL,
  `minpwdnum` bigint(20) NOT NULL,
  `minpwdchar` bigint(20) NOT NULL,
  `minpwdspec` bigint(20) NOT NULL,
  `history` bigint(20) NOT NULL,
  `denyaccess` int(11) unsigned default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `syscontrols`
--

/*!40000 ALTER TABLE `syscontrols` DISABLE KEYS */;
INSERT INTO `syscontrols` (`id`,`maxpwddays`,`minpwdlen`,`minpwdnum`,`minpwdchar`,`minpwdspec`,`history`,`denyaccess`) VALUES 
 (1,45,10,3,3,1,1,3);
/*!40000 ALTER TABLE `syscontrols` ENABLE KEYS */;


--
-- Definition of table `systenant`
--

DROP TABLE IF EXISTS `systenant`;
CREATE TABLE `systenant` (
  `id` bigint(20) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `dbConnection` varchar(255) default NULL,
  `createdby` varchar(45) default NULL,
  `createddate` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `modifiedby` varchar(45) default NULL,
  `modifieddate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `deletionstatus` char(1) NOT NULL,
  `denyaccess` bigint(20) NOT NULL,
  `licensepoolId` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `tenant_name_constraint` (`name`),
  KEY `FK_mseclicencepool_id` (`licensepoolId`),
  CONSTRAINT `FK_mseclicencepool_id` FOREIGN KEY (`licensepoolId`) REFERENCES `mseclicensepool` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `systenant`
--

/*!40000 ALTER TABLE `systenant` DISABLE KEYS */;
INSERT INTO `systenant` (`id`,`name`,`dbConnection`,`createdby`,`createddate`,`modifiedby`,`modifieddate`,`deletionstatus`,`denyaccess`,`licensepoolId`) VALUES 
 (1,'BR','tenant_br','admin','2013-05-21 13:13:50','admin','2013-05-21 13:13:50','N',3,1),
 (2,'CAUSEWAY','tenant_causeway','admin','2013-05-21 13:13:50','admin','2013-05-21 13:13:50','N',3,2),
 (3,'CONNECT','tenant_connect','admin','2013-05-21 13:13:50','admin','2013-05-21 13:13:50','N',3,3);
/*!40000 ALTER TABLE `systenant` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
