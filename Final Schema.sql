CREATE DATABASE  IF NOT EXISTS `vaccination_table` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `vaccination_table`;
-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: vaccination_table
-- ------------------------------------------------------
-- Server version	5.7.29-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `AuthUsers`
--

DROP TABLE IF EXISTS `AuthUsers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AuthUsers` (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(255) NOT NULL,
  `emailID` varchar(255) NOT NULL,
  `contact` varchar(11) DEFAULT NULL,
  `roleID` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `emailID_UNIQUE` (`emailID`),
  UNIQUE KEY `contact_UNIQUE` (`contact`),
  KEY `roleID` (`roleID`),
  CONSTRAINT `AuthUsers_ibfk_1` FOREIGN KEY (`roleID`) REFERENCES `RoleRef` (`roleId`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AuthUsers`
--

LOCK TABLES `AuthUsers` WRITE;
/*!40000 ALTER TABLE `AuthUsers` DISABLE KEYS */;
INSERT INTO `AuthUsers` VALUES (101,'ssssssss','aaa@ggg.com',NULL,1,'Vasu Goel'),(102,'password','sargam@mail.com',NULL,1,'Sargam'),(103,'vg261999','alohanvasu@gmail.com',NULL,1,'Vasu Goel'),(110,'password','bhagwan@gmail.com','2346465132',1,'Bhagwan Das'),(112,'password','shuchi@gmail.com','9654381570',2,'Shuchi'),(113,'vg261999','vasug@gmail.com',NULL,3,'Vasu Goel');
/*!40000 ALTER TABLE `AuthUsers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Availability`
--

DROP TABLE IF EXISTS `Availability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Availability` (
  `healthCentreID` int(11) NOT NULL,
  `VaccineID` int(11) NOT NULL,
  `Count` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`healthCentreID`,`VaccineID`),
  KEY `fk_vaccine_idx` (`VaccineID`),
  CONSTRAINT `fk_healthCentre` FOREIGN KEY (`healthCentreID`) REFERENCES `PublicHealthCentre` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_vaccine` FOREIGN KEY (`VaccineID`) REFERENCES `Vaccinations` (`VaccineID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Availability`
--

LOCK TABLES `Availability` WRITE;
/*!40000 ALTER TABLE `Availability` DISABLE KEYS */;
INSERT INTO `Availability` VALUES (1,90396,2),(2,90287,32),(3,90283,2),(4,90470,22),(7,90620,15),(10,90654,12),(11,90393,12),(12,90378,6),(13,90646,12),(14,90291,4),(15,90651,12),(16,90645,28),(17,90621,16),(18,90647,33),(20,90653,43),(21,90476,3),(22,90296,12),(23,90581,4),(26,90644,0),(33,90375,3),(41,90371,46);
/*!40000 ALTER TABLE `Availability` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`binaryblood`@`localhost`*/ /*!50003 TRIGGER `vaccination_table`.`Availability_BEFORE_INSERT` BEFORE INSERT ON `Availability` FOR EACH ROW
BEGIN
	declare msg varchar(128);
	if exists (SELECT * from Availability
    where healthCentreID=new.healthCentreID and VaccineID=new.VaccineID) 
    then
		set msg = concat('VacciCureError: Trying to insert into existing entry');
		signal sqlstate '45000' set message_text = msg;
	else
		if (new.Count < 0) then
        set msg = concat('VacciCureError: Negative entry not allowed');
		signal sqlstate '45000' set message_text = msg;
        end if;
    end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`binaryblood`@`localhost`*/ /*!50003 TRIGGER `vaccination_table`.`Availability_BEFORE_UPDATE` BEFORE UPDATE ON `Availability` FOR EACH ROW
BEGIN
	declare msg varchar(128);
	if (new.Count < 0) then
        set msg = concat('VacciCureError: Negative entry not allowed');
		signal sqlstate '45000' set message_text = msg;
        end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `CountryImmunizationRecords`
--

DROP TABLE IF EXISTS `CountryImmunizationRecords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CountryImmunizationRecords` (
  `CountryCode` varchar(4) NOT NULL,
  `CountryName` varchar(45) NOT NULL,
  `VaccinationID` int(11) NOT NULL,
  PRIMARY KEY (`CountryCode`,`VaccinationID`),
  KEY `CountryImmunizationRecords_ibfk_1` (`VaccinationID`),
  KEY `idx_CountryImmunizationRecords_CountryName` (`CountryName`),
  CONSTRAINT `CountryImmunizationRecords_ibfk_1` FOREIGN KEY (`VaccinationID`) REFERENCES `Vaccinations` (`VaccineID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CountryImmunizationRecords`
--

LOCK TABLES `CountryImmunizationRecords` WRITE;
/*!40000 ALTER TABLE `CountryImmunizationRecords` DISABLE KEYS */;
INSERT INTO `CountryImmunizationRecords` VALUES ('AF','Afghanistan',90281),('AL','Albania',90283),('DZ','Algeria',90287),('AS','American Samoa',90291),('AD','Andorra',90296),('AO','Angola',90371),('AI','Anguilla',90375),('AQ','Antarctica',90376),('AG','Antigua and Barbuda',90378),('AR','Argentina',90379),('AM','Armenia',90389),('AW','Aruba',90393),('AU','Australia',90396),('AT','Austria',90470),('AZ','Azerbaijan',90476),('BS','Bahamas (the)',90477),('BH','Bahrain',90581),('BD','Bangladesh',90585),('BB','Barbados',90620),('BY','Belarus',90621),('BE','Belgium',90625),('BZ','Belize',90630),('BJ','Benin',90632),('BM','Bermuda',90633),('BT','Bhutan',90634),('BO','Bolivia (Plurinational State of)',90636),('BQ','Bonaire, Sint Eustatius and Saba',90644),('BA','Bosnia and Herzegovina',90645),('BW','Botswana',90646),('BV','Bouvet Island',90647),('BR','Brazil',90648),('BN','Brunei Darussalam',90650),('BG','Bulgaria',90651),('BF','Burkina Faso',90653),('BI','Burundi',90654),('CV','Cabo Verde',90655),('KH','Cambodia',90656),('CM','Cameroon',90657),('CA','Canada',90658),('KY','Cayman Islands (the)',90659),('TD','Chad',90661),('CL','Chile',90662),('CN','China',90663),('CX','Christmas Island',90664),('CC','Cocos (Keeling) Islands (the)',90665),('CO','Colombia',90666),('KM','Comoros (the)',90668),('CD','Congo (the Democratic Republic of the)',90669),('CG','Congo (the)',90670),('CK','Cook Islands (the)',90672),('CR','Costa Rica',90673),('CI','Côte d\'Ivoire',90682),('HR','Croatia',90674),('CU','Cuba',90675),('CW','Curaçao',90676),('CY','Cyprus',90680),('CZ','Czechia',90681),('DJ','Djibouti',90686),('DM','Dominica',90687),('DO','Dominican Republic (the)',90688),('EC','Ecuador',90690),('EG','Egypt',90690),('SV','El Salvador',90691),('GQ','Equatorial Guinea',90692),('ER','Eritrea',90693),('EE','Estonia',90694),('SZ','Eswatini',90696),('ET','Ethiopia',90697),('FK','Falkland Islands (the) [Malvinas]',90698),('FO','Faroe Islands (the)',90700),('FJ','Fiji',90701),('FI','Finland',90702),('FR','France',90703),('GF','French Guiana',90704),('PF','French Polynesia',90705),('TF','French Southern Territories (the)',90706),('GA','Gabon',90707),('GM','Gambia (the)',90708),('GE','Georgia',90710),('DE','Germany',90712),('GH','Ghana',90713),('GI','Gibraltar',90714),('GR','Greece',90715),('GL','Greenland',90716),('GD','Grenada',90717),('GP','Guadeloupe',90718),('GU','Guam',90720),('GT','Guatemala',90721),('GG','Guernsey',90723),('GN','Guinea',90724),('GW','Guinea-Bissau',90725),('GY','Guyana',90726),('HT','Haiti',90727),('IN','India',90649);
/*!40000 ALTER TABLE `CountryImmunizationRecords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `CountryWiseRequirements`
--

DROP TABLE IF EXISTS `CountryWiseRequirements`;
/*!50001 DROP VIEW IF EXISTS `CountryWiseRequirements`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `CountryWiseRequirements` AS SELECT 
 1 AS `CountryName`,
 1 AS `CountryCode`,
 1 AS `VaccineName`,
 1 AS `DiseaseName`,
 1 AS `SpreadBy`,
 1 AS `Complications`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Disease`
--

DROP TABLE IF EXISTS `Disease`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Disease` (
  `ICD10` varchar(10) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Symptoms` varchar(255) DEFAULT NULL,
  `VaccinationType` varchar(10) NOT NULL,
  `SpreadBy` varchar(450) DEFAULT NULL,
  `Complications` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ICD10`),
  KEY `fk_vaccination_cat_idx` (`VaccinationType`),
  KEY `idx_Disease_Name` (`Name`),
  CONSTRAINT `fk_vaccination_cat` FOREIGN KEY (`VaccinationType`) REFERENCES `VaccineCategories` (`VaccineCategoryID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Disease`
--

LOCK TABLES `Disease` WRITE;
/*!40000 ALTER TABLE `Disease` DISABLE KEYS */;
INSERT INTO `Disease` VALUES ('A00.0','CHOLERA','Watery Diarrhea, vomiting, rapid heart rate.','INV','Spreads by drinking water or eating food contaminated by bacterium.','Rapid fluid loss, low blood sugar. '),('A08.0','ROTAVIRUS','decreased urination, dry mouth and throat.','LAV','It spreads fecal-oral contact.','Severe diarrhea, dehydration, electrolyte imbalance'),('A22.9','ANTHRAX','Sore throat, mild fever, shortness of breath','TXV','Spreads through wound in skin,','Inflammation of membranes fluid covering brain and spinal cord'),('A33','TETANUS','Stiffness of neck, jaw and other muscles, fever and sweating.','TXV','Spreads when dirt enters a wound or cut.','Fractures, aspiration pneumonia.'),('A36.9','DIPHTHERIA','Sore throat and hoarseness, swollen glands(enlarged lymph nodes)','TXV','Spreads through respiratory droplets like coughing and sneezing.','paralysis, lung infection, nerve damage.'),('A39.9','MENINGOCOCCAL','Sudden high fever, nect stiffness, nausea or vomiting','SRPC','spreads by sharing respiratory and throat secretions.','Vasomotor collapse and shock'),('A80.9','Poliomyelitis (Polio)','Fever, sore throat, headache, vomitting, fatique.','INV','It is spread through infected fecal matter entering mouth.','Paralysis of muscles used for breathing'),('A82.9','RABIES','Irritability or aggressiveness, agitation, confusion','INV','Spread through saliva of infected animals.','Insomnia, anxiety, agitation'),('A95.9','YELLOW FEVER','Fever, Headache, Muscles aches, Nausea','LAV','Spread by bite of an infected female mosquito, ','Vomitting, bleeding, jaundice, liver failure, death.'),('B01.89','CHICKEN-POX','loss of appetite, aching muscles','LAV','spreads by closeness and contact with someone with chickenpox','bacterial infectons of skin'),('B02.9','SHINGLES','One-sided stabbing pain, headache, nausea, body aches','SRPC','Caused by varicella zoster virus. Can be caused after chickenpox.','Postherpetic neuralgia, Vision loss'),('B03','Small-Pox','sudden onset of high fever, malaise, widespread skin rash, severe headache, diarrhoea','LAV','infected person talks, coughs or sneezes small droplets containing infectious agents into the air. The droplets in the air may be breathed in by those nearby or may contaminate objects, Smallpox can also be spread by direct contact with blister fluid or contaminated objects.','Eye problems including corneal ulceration and blindnes, Bronchopneumoni, Arthritis, Osteomyelitis'),('B05.9','MEASLES','runny or blocked nose, sneezing, swollen eyelids','LAV','infection with rubeola virus. ','diarrhoea, vomitting, middle ear infection.'),('B06.9','RUBELLA','swollen and tender lymph nodes, mild fever, muscle pain, inflamed or red eyes.','LAV','It can be spread when an infected person coughs or sneezes.','Bleeding problems, testicular swelling.'),('B15.9','HEPATITIS A','flu-like sumptoms, dark urine, loss of appetite','INV','Spreads when virus from contaminated object is taken.','Liver Failure, Guillain Barre Syndrome.'),('B19.10','HEBATITIS B','Abdominal pain, dark urine, joint pain, loss of appetite','SRPC','Spread when blood,semen or other body fluid infected with Hepatitis B','Scarring of the liver, liver cancer.'),('B26.9','Mumps','pain while chewing, fever, pain in swollen salivary gland, muscle aches.','LAV','It can be transmitted by respiratory secretions.','Meningitis, encephalities.'),('B96.3','Haemophilus influenzae b (Hib)','headache, stiff neck, joint pain, fever.','SRPC','Bacteria can move to other parts of body and cause infection.','lung inflammation, joint infection'),('G00.1','Pneumococcal ','Fever, chills, chest pain, shortness of breath','SRPC','Spreads through contact with ill people or who have bacteria in throat','Empyema, pericarditis and respiratory failure'),('R87.810','human papillomavirus (hpv)','warts, genital warts.','SRPC','Spread by having intercourse with someone who has the virus.','Cancer in cervix');
/*!40000 ALTER TABLE `Disease` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `DiseaseVaccineMap`
--

DROP TABLE IF EXISTS `DiseaseVaccineMap`;
/*!50001 DROP VIEW IF EXISTS `DiseaseVaccineMap`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `DiseaseVaccineMap` AS SELECT 
 1 AS `VaccineID`,
 1 AS `purpose`,
 1 AS `VaccineName`,
 1 AS `requiredDosages`,
 1 AS `ICD10`,
 1 AS `DiseaseName`,
 1 AS `Symptoms`,
 1 AS `SpreadBy`,
 1 AS `Complications`,
 1 AS `VaccinationType`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `DiseaseVaccineRelation`
--

DROP TABLE IF EXISTS `DiseaseVaccineRelation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DiseaseVaccineRelation` (
  `ICDCode` varchar(20) NOT NULL,
  `VaccineID` int(11) NOT NULL,
  PRIMARY KEY (`ICDCode`,`VaccineID`),
  KEY `fk_DiseaseVaccineRelation_VaccineID_idx` (`VaccineID`),
  CONSTRAINT `fk_DiseaseVaccineRelation_ICD` FOREIGN KEY (`ICDCode`) REFERENCES `Disease` (`ICD10`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_DiseaseVaccineRelation_VaccineID` FOREIGN KEY (`VaccineID`) REFERENCES `Vaccinations` (`VaccineID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DiseaseVaccineRelation`
--

LOCK TABLES `DiseaseVaccineRelation` WRITE;
/*!40000 ALTER TABLE `DiseaseVaccineRelation` DISABLE KEYS */;
INSERT INTO `DiseaseVaccineRelation` VALUES ('B02.9',90646),('A82.9',90647),('B19.10',90648),('A95.9',90649),('A80.9',90650),('G00.1',90651),('A39.9',90653),('A00.0',90654),('A36.9',90655),('A33',90656),('B15.9',90657),('A22.9',90658),('R87.810',90659),('B26.9',90660),('B06.9',90661),('A08.0',90662),('B96.3',90663),('B01.89',90664),('B05.9',90665),('B19.10',90666),('A95.9',90668),('A80.9',90669),('A95.9',90670),('A80.9',90672),('G00.1',90673),('A39.9',90674),('A00.0',90675),('A22.9',90676),('R87.810',90680),('B26.9',90681),('B06.9',90682),('A08.0',90685),('B96.3',90686),('B01.89',90687),('B05.9',90701),('B19.10',90702),('A95.9',90703),('R87.810',90705),('B26.9',90706),('B06.9',90707),('A08.0',90708),('B96.3',90710),('B01.89',90712),('B05.9',90713);
/*!40000 ALTER TABLE `DiseaseVaccineRelation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DoctorAuthMap`
--

DROP TABLE IF EXISTS `DoctorAuthMap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DoctorAuthMap` (
  `AuthID` int(11) NOT NULL,
  `DoctorID` varchar(255) NOT NULL,
  PRIMARY KEY (`AuthID`,`DoctorID`),
  UNIQUE KEY `AuthID_UNIQUE` (`AuthID`),
  UNIQUE KEY `DoctorAuthMapcol_UNIQUE` (`DoctorID`),
  CONSTRAINT `fk_DoctorAuthMap_1` FOREIGN KEY (`AuthID`) REFERENCES `AuthUsers` (`userID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_DoctorAuthMap_2` FOREIGN KEY (`DoctorID`) REFERENCES `RegisteredPractitioners` (`LicenseNumber`) ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DoctorAuthMap`
--

LOCK TABLES `DoctorAuthMap` WRITE;
/*!40000 ALTER TABLE `DoctorAuthMap` DISABLE KEYS */;
INSERT INTO `DoctorAuthMap` VALUES (112,'123121245');
/*!40000 ALTER TABLE `DoctorAuthMap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HealthCentreAuthMap`
--

DROP TABLE IF EXISTS `HealthCentreAuthMap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HealthCentreAuthMap` (
  `AuthID` int(11) NOT NULL,
  `HealthID` int(11) NOT NULL,
  PRIMARY KEY (`AuthID`,`HealthID`),
  UNIQUE KEY `HealthCentreAuthMapcol_UNIQUE` (`HealthID`),
  UNIQUE KEY `AuthID_UNIQUE` (`AuthID`),
  CONSTRAINT `fk_HealthCentreAuthMap_1` FOREIGN KEY (`AuthID`) REFERENCES `AuthUsers` (`userID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_HealthCentreAuthMap_2` FOREIGN KEY (`HealthID`) REFERENCES `PublicHealthCentre` (`id`) ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HealthCentreAuthMap`
--

LOCK TABLES `HealthCentreAuthMap` WRITE;
/*!40000 ALTER TABLE `HealthCentreAuthMap` DISABLE KEYS */;
INSERT INTO `HealthCentreAuthMap` VALUES (110,110);
/*!40000 ALTER TABLE `HealthCentreAuthMap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PublicHealthCentre`
--

DROP TABLE IF EXISTS `PublicHealthCentre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PublicHealthCentre` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `pincode` varchar(10) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `NumberOfHealthCamps` int(11) DEFAULT NULL,
  `OperationalSince` varchar(30) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `Contact` varchar(20) NOT NULL,
  `location` point DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `idx_PublicHealthCentre_state` (`state`),
  KEY `LocationIndex` (`location`(25))
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PublicHealthCentre`
--

LOCK TABLES `PublicHealthCentre` WRITE;
/*!40000 ALTER TABLE `PublicHealthCentre` DISABLE KEYS */;
INSERT INTO `PublicHealthCentre` VALUES (1,'Health Centre1','110088','AE-9 Shalimar Bag',20,'2010-10-10','Delhi','New Delhi','9874561234',_binary '\0\0\0\0\0\0\0\��%}�|:@\�獼��S@'),(2,'Innotype','443929','57 Sutteridge Place',38,'27/03/2014','Delhi','New delhi','302-274-8402',_binary '\0\0\0\0\0\0\0\�C0E�;@`�5!X�S@'),(3,'Vinte','668162','6615 Hallows Road',78,'23/06/2004','Uttar Pradesh','Bulandshahr','612-342-3932',_binary '\0\0\0\0\0\0\0\�+\��\�:@��x\�\�S@'),(4,'Tanoodle','668162','8577 Corben Avenue',95,'18/05/2006','Goa','murgaon','215-189-1219',_binary '\0\0\0\0\0\0\0>t�\�;@Њ���\"S@'),(5,'Browsezoom','668162','9 Westridge Parkway',42,'30/12/2013','Delhi','New Delhi','318-674-5796',_binary '\0\0\0\0\0\0\0��۠�<@���\�S@'),(6,'Jaxworks','211231','3817 Muir Avenue',18,'4/5/1984','Bihar','Patna','952-649-7215',_binary '\0\0\0\0\0\0\0����;@1�@ELS@'),(7,'Browsebug','443929','672 Westend Center',56,'19/05/2008','Punjab','Chandigarh','843-850-7849',_binary '\0\0\0\0\0\0\0��Z~�:@7\�\�ͷS@'),(8,'Jazzy','211231','064 Autumn Leaf Junction',76,'1/1/2019','Delhi','New Delhi','907-932-4939',_binary '\0\0\0\0\0\0\0h*i��J:@\\\�	\�uS@'),(9,'Voonix','222312','6161 Luster Alley',2,'25/01/2010','Goa','panaji','260-736-4849',_binary '\0\0\0\0\0\0\0�S�\��T<@\�\"Fp�S@'),(10,'Topicshots','443929','719 Arizona Street',42,'30/01/1983','Rajasthan','jaipur','901-781-1684',_binary '\0\0\0\0\0\0\0�jF��<@\��4AS@'),(11,'Yacero','183221','28970 Logan Road',35,'16/05/2019','Bihar','patna','240-180-1384',_binary '\0\0\0\0\0\0\0?&Ə	:@_!&�WS@'),(12,'Gabcube','211231','99080 Golf Course Circle',92,'13/09/1989','Delhi','New Delhi','862-346-7449',_binary '\0\0\0\0\0\0\0�(zF)�:@�N	���S@'),(13,'Yambee','183221','0 Butterfield Trail',1,'26/05/2001','Goa','murgaon','801-832-5744',_binary '\0\0\0\0\0\0\0	�\�R\�:@�\�ȼ*S@'),(14,'Blogpad','211231','7 Magdeline Alley',13,'19/08/1991','Rajasthan','Jodhpur','617-776-1099',_binary '\0\0\0\0\0\0\0\�V����:@\�\�\��:S@'),(15,'Zoonder','183221','89819 Judy Avenue',58,'21/03/1990','Bihar','munger','952-692-0279',_binary '\0\0\0\0\0\0\0�fc\�\�<@\�|\�|7�S@'),(16,'Divavu','211231','2885 Hauk Junction',54,'15/05/2008','Punjab','Amritsar','650-513-5924',_binary '\0\0\0\0\0\0\0̍��r\�:@��qI��S@'),(17,'Demizz','668162','92 Lindbergh Pass',39,'25/03/1992','Delhi','New Delhi','347-358-1819',_binary '\0\0\0\0\0\0\0�묿\�::@t6��MS@'),(18,'Twinte','183221','93078 3rd Junction',52,'20/12/2014','Madhya Pradesh','Bhopal','334-278-8553',_binary '\0\0\0\0\0\0\0�~mK�_<@\�:�㴎S@'),(19,'Agimba','668162','80 Stuart Pass',26,'15/08/1996','Goa','murgaon','313-261-6267',_binary '\0\0\0\0\0\0\0\��\�7;@�s�9\�\\S@'),(20,'Skyndu','183221','08594 Trailsway Lane',70,'30/09/1991','Bihar','chappra','202-265-3165',_binary '\0\0\0\0\0\0\0��|\�h,;@5�I\�`S@'),(21,'Yabox','668162','5926 Lighthouse Bay Pass',69,'28/10/2017','Uttar Pradesh','Mathura','479-167-9464',_binary '\0\0\0\0\0\0\0>+ti\�\n;@n��h+S@'),(22,'Zoomcast','211231','9 Schmedeman Junction',10,'5/2/2013','Madhya Pradesh','Indore','501-289-8516',_binary '\0\0\0\0\0\0\0\��(��=:@E/\�<ыS@'),(23,'Meejo','679130','3270 Helena Hill',71,'17/11/1985','Delhi','New Delhi','206-898-4327',_binary '\0\0\0\0\0\0\0\�\�\�\�63;@Crv֐�S@'),(24,'Oozz','443929','44327 International Plaza',40,'30/10/2003','Bihar','patna','702-202-0750',_binary '\0\0\0\0\0\0\0��*>��<@�Ѵ\�d�S@'),(25,'Fivechat','211231','2480 Johnson Point',82,'2/12/1987','Goa','murgaon','214-233-8018',_binary '\0\0\0\0\0\0\0l\�,\�2:@����cbS@'),(26,'Eamia','359120','523 Merry Parkway',28,'17/05/2018','Madhya Pradesh','Indore','216-684-5401',_binary '\0\0\0\0\0\0\0\�\\�5;@_\��\�5S@'),(27,'Fiveclub','443929','2 Blackbird Center',79,'13/12/2016','Goa','bicholim','502-775-0092',_binary '\0\0\0\0\0\0\0？�;\�:@&b��S@'),(28,'Yodo','359120','20592 Superior Point',63,'6/6/1989','Rajasthan','jaipur','405-871-5449',_binary '\0\0\0\0\0\0\0C\����;@�@��*S@'),(29,'Tagopia','359120','2898 Muir Terrace',3,'6/11/1996','Goa','Mapusa','516-419-1440',_binary '\0\0\0\0\0\0\0�ƕ��q;@/vAʋS@'),(30,'Rhybox','443929','8 Londonderry Plaza',68,'21/12/1985','Uttar Pradesh','Gorakhpur','704-550-3717',_binary '\0\0\0\0\0\0\0\�\�\��:@�\0<\�S@'),(31,'Zoombeat','359120','0155 Sachs Hill',19,'25/04/1987','Goa','Pernem','817-245-1078',_binary '\0\0\0\0\0\0\0�=\�|�<@\�N7[��S@'),(32,'Skyble','211231','47 Brown Park',1,'28/04/1992','Madhya Pradesh','Indore','202-845-7832',_binary '\0\0\0\0\0\0\0lpC�\Z\�:@\�_���S@'),(33,'Jabberstorm','211231','9820 Rusk Circle',81,'22/06/1998','Goa','bicholim','818-717-3584',_binary '\0\0\0\0\0\0\0�*��J<@\�US�uUS@'),(34,'Chatterpoint','434345','9079 Cascade Parkway',32,'19/05/1984','Uttar Pradesh','Agra','515-289-7183',_binary '\0\0\0\0\0\0\05�\�B\�<@\�\0��2@S@'),(35,'Tavu','443929','6921 Grayhawk Crossing',35,'3/1/1984','Rajasthan','Jaiselmer','202-119-8235',_binary '\0\0\0\0\0\0\0�p~\',�<@}\nS�BS@'),(36,'Roombo','183221','29556 Orin Point',51,'17/06/2015','Uttar Pradesh','Agra','406-129-3204',_binary '\0\0\0\0\0\0\0�\�\�_:@.�2�pS@'),(37,'Skalith','359120','4 Walton Way',22,'13/07/2014','Rajasthan','Jaipur','480-896-0604',_binary '\0\0\0\0\0\0\0u�\�R�;@\�o�A�S@'),(38,'Linkbuzz','183221','461 Mariners Cove Court',4,'1/10/1988','Madhya Pradesh','Bhopal','502-420-0658',_binary '\0\0\0\0\0\0\0<W�\�Ε:@�=\0\�|S@'),(39,'Aimbu','183221','026 Tennessee Crossing',64,'25/08/1990','Goa','Mapusa','502-582-4373',_binary '\0\0\0\0\0\0\0M\��,St<@Ƌ���S@'),(40,'Zooxo','211231','4972 Hagan Center',68,'18/04/1991','Uttar Pradesh','Aligarh','717-792-0230',_binary '\0\0\0\0\0\0\0�wR\�]<@,23 �LS@'),(41,'Brainsphere','183221','3398 Memorial Park',80,'17/08/1991','Punjab','Amritsar','314-723-5950',_binary '\0\0\0\0\0\0\0����+\�;@T\�2ճS@'),(42,'Tavu','359120','4559 Nobel Parkway',38,'22/10/1982','Rajasthan','Jodhpur','205-232-0327',_binary '\0\0\0\0\0\0\0��\�\�\"i<@��sN\�\'S@'),(43,'Avavee','183221','2 Bartillon Avenue',47,'3/4/1995','Bihar','Patna','402-149-0451',_binary '\0\0\0\0\0\0\07�˩\r\�;@1�F)dS@'),(44,'Kwimbee','183221','251 Hollow Ridge Road',78,'21/12/1989','Goa','Mapusa','515-110-1154',_binary '\0\0\0\0\0\0\0)��=\�\'<@a�Q�S@'),(45,'DabZ','359120','5 Calypso Road',52,'14/03/1997','Punjab','Chandigarh','860-445-6892',_binary '\0\0\0\0\0\0\0ⓩ��<@��f�\�S@'),(46,'Kare','211231','992 Spenser Circle',28,'18/08/1983','Bihar','chappra','757-514-0095',_binary '\0\0\0\0\0\0\0\�/\�x�;@Du8�PS@'),(47,'Youtags','183221','1384 Mandrake Alley',93,'29/08/1982','Goa','Pernem','989-683-8794',_binary '\0\0\0\0\0\0\0̙xs&<@t`\�S@'),(48,'Vinte','443929','2 Lillian Drive',78,'11/4/2009','Punjab','Amritsar','512-935-4931',_binary '\0\0\0\0\0\0\0��i�\�n;@2	�yLS@'),(49,'Flipopia','211231','9140 Arkansas Road',18,'21/09/1998','Madhya Pradesh','Bhopal','901-820-3248',_binary '\0\0\0\0\0\0\0����>\�;@�Jj\�S@'),(50,'Kwilith','359120','7 Clemons Junction',96,'19/03/2004','Rajasthan','Jaipur','907-628-3919',_binary '\0\0\0\0\0\0\0\�EC\�u\�;@b7��؍S@'),(51,'Vidya Health Centre 2','110055','Shalimar Bagh',0,'2005-06-02','Delhi','New Delhi','1234567891',_binary '\0\0\0\0\0\0\0+�&Ί�<@�|*�#S@'),(110,'Bhagwan Das','110066','Chandni Chwok',0,'1987-06-02','Delhi','New Delhi','2346465132',_binary '\0\0\0\0\0\0\0�4j�(�:@!L\�2SS@');
/*!40000 ALTER TABLE `PublicHealthCentre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RegisteredPractitioners`
--

DROP TABLE IF EXISTS `RegisteredPractitioners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RegisteredPractitioners` (
  `LicenseNumber` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `practicingSince` date DEFAULT NULL,
  `healthCentreID` int(11) DEFAULT NULL,
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`LicenseNumber`),
  UNIQUE KEY `userID_UNIQUE` (`userID`),
  KEY `healthCentreID` (`healthCentreID`),
  KEY `userID` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RegisteredPractitioners`
--

LOCK TABLES `RegisteredPractitioners` WRITE;
/*!40000 ALTER TABLE `RegisteredPractitioners` DISABLE KEYS */;
INSERT INTO `RegisteredPractitioners` VALUES ('123121245','Shuchi','1999-09-27',1,112),('132-65-4505','Sybille Crispe','2000-08-12',14,31),('133-74-2721','Devlen Gottschalk','2002-10-02',25,38),('144-30-9830','Ximenez Ibbeson','2001-07-20',42,16),('161-14-4194','Verene Gwalter','2003-10-01',1,3),('163-28-0269','Perceval Helversen','2001-06-11',15,33),('172-96-7136','Rois Stener','2003-10-30',37,28),('178-28-7001','Wynnie Ravenshear','2000-09-27',9,19),('184-28-6779','Reinold Rentoll','2002-12-27',45,4),('187-18-3221','Nathanael La Croce','2002-08-29',5,9),('190-99-3495','Iolanthe Heyworth','2003-01-18',18,39),('205-50-6160','Meggie Rake','2000-03-30',30,49),('214-19-9964','Clevey Trillo','2000-08-04',39,22),('217-03-0076','Mirilla Henfre','2002-03-30',44,1),('222-32-7213','Britteny Abbis','2002-07-30',7,13),('233-74-2310','Pru Weathers','2002-12-04',47,6),('244-97-4387','Karlen Tofanelli','2003-10-25',13,29),('265-69-5180','Roobbie Barneveld','2003-01-04',26,36),('279-61-6727','Trista Fossett','2002-03-28',35,47),('316-98-9546','Adiana Primak','2003-07-29',48,8),('344-63-2140','Killy Wyllcock','2001-09-06',6,11),('369-12-1813','Ignacius Bandy','2003-06-03',28,32),('369-98-9669','Yolande Weed','2000-10-05',41,18),('384-78-2405','Vasili Heinssen','2001-04-01',17,37),('399-28-3462','Merrile Coldicott','2001-02-08',50,50),('456-91-4930','Noll Graddon','2003-06-06',23,42),('480-64-7628','Gallagher Files','2001-01-15',40,20),('490-71-9607','Krissy Sanger','2002-10-02',31,17),('491-66-4775','Nora Waistell','2000-02-09',38,24),('522-46-9351','Kristofer Cray','2000-08-23',20,43),('552-14-8904','Rivy Richemond','2003-11-02',19,41),('580-44-2922','Poul Jaggi','2000-07-17',12,27),('616-98-8641','Petrina Willgress','2002-03-31',32,21),('628-69-5304','Humfried Lowin','2002-04-28',8,15),('629-75-0484','Myrwyn Geill','2003-07-03',21,46),('675-39-3063','Annabel Combes','2000-02-12',27,34),('686-78-9971','Gianina Gurdon','2002-11-29',24,40),('706-92-2789','Nichols Allbrook','2000-04-13',34,45),('730-09-3334','Giselle Collinette','2000-09-30',16,35),('760-56-5920','Duncan McGonnell','2001-07-13',46,12),('770-60-7147','Bryanty Schirak','2000-09-10',22,44),('782-07-9052','Kylila Guinnane','2002-05-04',33,26),('782-71-9260','Dania Cometti','2004-02-02',11,25),('798-70-8645','Kingston Glancy','2000-08-12',49,10),('804-07-1073','Savina McTrustie','2001-02-03',29,30),('811-82-0121','Avigdor Angear','2001-07-05',2,2),('843-11-9362','Garrett Solon','2000-08-26',4,7),('846-88-3030','Madeline Creed','2002-10-27',43,14),('871-68-4228','Robbert Zorzoni','2002-07-11',10,23),('882-93-4886','Lisabeth Gosnall','2002-05-24',3,5),('899-88-1049','Ulysses Eagle','2002-04-24',36,48);
/*!40000 ALTER TABLE `RegisteredPractitioners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RoleRef`
--

DROP TABLE IF EXISTS `RoleRef`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RoleRef` (
  `roleId` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RoleRef`
--

LOCK TABLES `RoleRef` WRITE;
/*!40000 ALTER TABLE `RoleRef` DISABLE KEYS */;
INSERT INTO `RoleRef` VALUES (1,'admin'),(2,'patient'),(3,'doctor'),(4,'General'),(5,'Official');
/*!40000 ALTER TABLE `RoleRef` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VaccinationRecords`
--

DROP TABLE IF EXISTS `VaccinationRecords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VaccinationRecords` (
  `VaccineID` int(11) DEFAULT NULL,
  `UserID` int(11) DEFAULT NULL,
  `VaccineDate` date DEFAULT NULL,
  `PublicHealthCentreID` int(11) DEFAULT NULL,
  `DosageNo` int(11) DEFAULT NULL,
  `CampID` int(11) DEFAULT NULL,
  `DoctorLicenseNo` varchar(255) DEFAULT NULL,
  `VaccineCode` varchar(255) NOT NULL,
  PRIMARY KEY (`VaccineCode`),
  KEY `VaccineID` (`VaccineID`),
  KEY `UserID` (`UserID`),
  KEY `DoctorLicenseNo` (`DoctorLicenseNo`),
  CONSTRAINT `VaccinationRecords_ibfk_1` FOREIGN KEY (`VaccineID`) REFERENCES `Vaccinations` (`VaccineID`),
  CONSTRAINT `VaccinationRecords_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `users` (`id`),
  CONSTRAINT `VaccinationRecords_ibfk_5` FOREIGN KEY (`DoctorLicenseNo`) REFERENCES `RegisteredPractitioners` (`LicenseNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VaccinationRecords`
--

LOCK TABLES `VaccinationRecords` WRITE;
/*!40000 ALTER TABLE `VaccinationRecords` DISABLE KEYS */;
INSERT INTO `VaccinationRecords` VALUES (90281,73,'2020-03-03',14,5,22,'217-03-0076','0054-4301'),(90650,34,'2020-02-10',10,4,9,'163-28-0269','0280-1197'),(90656,24,'2020-04-03',42,5,12,'133-74-2721','0456-0045'),(90653,75,'2020-02-02',31,1,37,'730-09-3334','0574-0016'),(90376,37,'2020-03-30',30,3,46,'316-98-9546','0781-5791'),(90476,24,'2020-01-10',22,3,27,'628-69-5304','0942-6479'),(90389,85,'2020-03-15',30,4,43,'344-63-2140','15370-101'),(90644,1,'2020-02-06',26,2,NULL,'882-93-4886','154684'),(90625,5,'2020-03-31',13,4,44,'616-98-8641','21695-036'),(90287,11,'2020-03-15',50,3,12,'161-14-4194','21695-461'),(90620,98,'2020-02-23',8,1,50,'178-28-7001','23155-240'),(90375,51,'2020-03-23',19,5,11,'843-11-9362','24236-933'),(90649,65,'2020-01-28',5,3,49,'369-12-1813','33261-975'),(90660,23,'2020-01-27',30,4,25,'456-91-4930','33342-047'),(90477,36,'2020-02-16',35,2,42,'144-30-9830','35781-0230'),(90283,28,'2020-01-27',18,5,46,'811-82-0121','36987-2623'),(90658,1,'2020-03-02',49,1,38,'686-78-9971','36987-3391'),(90630,92,'2020-02-26',22,5,20,'214-19-9964','37000-705'),(90470,39,'2020-03-17',40,3,3,'846-88-3030','37205-694'),(90291,32,'2020-02-14',14,2,26,'184-28-6779','43269-619'),(90661,15,'2020-03-15',9,5,45,'522-46-9351','43479-108'),(90393,23,'2020-03-09',7,2,16,'760-56-5920','47335-676'),(90621,51,'2020-03-23',9,2,39,'480-64-7628','49643-328'),(90659,97,'2020-03-03',42,3,22,'552-14-8904','50242-138'),(90645,46,'2020-03-18',31,3,45,'172-96-7136','50436-0284'),(90665,33,'2020-03-23',35,5,20,'279-61-6727','51769-003'),(90371,91,'2020-03-28',27,2,39,'233-74-2310','52125-398'),(90657,40,'2020-03-30',17,3,42,'190-99-3495','52599-282'),(90378,4,'2020-03-17',24,2,12,'187-18-3221','53645-1090'),(90296,71,'2020-01-05',33,3,11,'882-93-4886','53808-0687'),(90585,41,'2020-03-17',35,5,25,'369-98-9669','54170-120'),(90655,25,'2020-01-23',23,1,8,'384-78-2405','54868-3408'),(90647,58,'2020-03-01',31,3,38,'804-07-1073','54868-5590'),(90632,53,'2020-04-09',33,2,28,'871-68-4228','57896-638'),(90646,97,'2020-02-26',1,2,7,'244-97-4387','59779-182'),(90634,94,'2020-01-12',39,3,20,'782-71-9260','60429-310'),(90648,84,'2020-01-15',25,3,22,'132-65-4505','60429-372'),(90633,2,'2020-03-29',27,2,31,'491-66-4775','60432-834'),(90669,71,'2020-01-27',1,5,16,'399-28-3462','61734-085'),(90664,38,'2020-03-28',27,3,29,'629-75-0484','61957-0008'),(90663,8,'2020-01-05',1,5,30,'706-92-2789','63548-6352'),(90654,56,'2020-02-08',37,2,36,'265-69-5180','63629-3204'),(90668,88,'2020-03-17',2,2,10,'205-50-6160','63667-507'),(90396,36,'2020-03-19',34,1,6,'222-32-7213','64117-969'),(90644,99,'2020-02-23',42,4,5,'580-44-2922','64679-920'),(90581,10,'2020-01-10',24,1,16,'490-71-9607','65862-079'),(90666,58,'2020-03-30',38,5,34,'899-88-1049','67510-0633'),(90379,70,'2020-01-27',22,2,2,'798-70-8645','67877-147'),(90651,15,'2020-03-18',48,5,42,'675-39-3063','68462-192'),(90662,42,'2020-02-14',47,1,15,'770-60-7147','68703-051'),(90636,58,'2020-02-06',26,1,2,'782-07-9052','76385-103');
/*!40000 ALTER TABLE `VaccinationRecords` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`binaryblood`@`localhost`*/ /*!50003 TRIGGER `vaccination_table`.`VaccinationRecords_BEFORE_INSERT` BEFORE INSERT ON `VaccinationRecords` FOR EACH ROW
BEGIN
	declare msg varchar(128);
	if (NOT exists (Select * from Availability as A where 
    A.healthCentreID=new.PublicHealthCentreID and A.VaccineID=new.VaccineID)
    or
    (Select A.Count from Availability as A where 
    A.healthCentreID=new.PublicHealthCentreID 
    and A.VaccineID=new.VaccineID) <= 0)
    then
		set msg = concat('VacciCureError: No availability for vaccine code', cast(new.VaccineID as char));
        signal sqlstate '45000' set message_text = msg;
    end if; 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`binaryblood`@`localhost`*/ /*!50003 TRIGGER `vaccination_table`.`VaccinationRecords_AFTER_INSERT` AFTER INSERT ON `VaccinationRecords` FOR EACH ROW
BEGIN
	UPDATE Availability as A SET Count = Count - 1
    where A.healthCentreID=new.PublicHealthCentreID 
    and A.VaccineID=new.VaccineID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Vaccinations`
--

DROP TABLE IF EXISTS `Vaccinations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Vaccinations` (
  `VaccineID` int(11) NOT NULL,
  `purpose` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `requiredDosages` int(11) unsigned NOT NULL,
  PRIMARY KEY (`VaccineID`),
  UNIQUE KEY `VaccineID_UNIQUE` (`VaccineID`),
  KEY `idx_Vaccinations_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Vaccinations`
--

LOCK TABLES `Vaccinations` WRITE;
/*!40000 ALTER TABLE `Vaccinations` DISABLE KEYS */;
INSERT INTO `Vaccinations` VALUES (90281,'Immune globulin (Ig), human, for intramuscular use','IG',1),(90283,'Immune globulin (IgIV), human, for intravenous use','IGIV',4),(90287,'Botulinum antitoxin, equine, any route','botulinum antitoxin',2),(90291,'Cytomegalovirus immune globulin (CMV-IgIV), human, for intravenous use','CMVIG',1),(90296,'Diphtheria antitoxin, equine, any route','diphtheria antitoxin',4),(90371,'Hepatitis B immune globulin (HBIg), human, for intramuscular use','HBIG',2),(90375,'Rabies immune globulin (RIg), human, for intramuscular and/or subcutaneous use','RIG',4),(90376,'Rabies immune globulin, heat-treated (RIg-HT), human, for intramuscular and/or subcutaneous use','RIG',3),(90378,'Respiratory syncytial virus, monoclonal antibody, recombinant, for intramuscular use, 50 mg, each','RSV-MAb',2),(90379,'Respiratory syncytial virus immune globulin (RSV-IgIV), human, for intravenous use','RSV-IGIV',4),(90389,'Tetanus immune globulin (TIg), human, for intramuscular use','TIG',1),(90393,'Vaccinia immune globulin, human, for intramuscular use','vaccinia immune globulin',5),(90396,'Varicella-zoster immune globulin, human, for intramuscular use','VZIG',2),(90470,'H1N1 immunization administration (intramuscular, intranasal), including counseling when performed','Novel Influenza-H1N1-09, all formulations',5),(90476,'Adenovirus vaccine, type 4, live, for oral use','adenovirus, type 4',3),(90477,'Adenovirus vaccine, type 7, live, for oral use','adenovirus, type 7',1),(90581,'Anthrax vaccine, for subcutaneous or intramuscular use','anthrax',5),(90585,'Bacillus Calmette-Guerin vaccine (BCG) for tuberculosis, live, for percutaneous use','BCG',1),(90620,'Meningococcal recombinant protein and outer membrane vesicle vaccine, serogroup B (MenB-4C), 2 dose schedule, for intramuscular use','meningococcal B, OMV',1),(90621,'Meningococcal recombinant lipoprotein vaccine, serogroup B (MenB-FHbp), 2 or 3 dose schedule, for intramuscular use','meningococcal B, recombinant',1),(90625,'Cholera vaccine, live, adult dosage, 1 dose schedule, for oral use','cholera, live attenuated',6),(90630,'Influenza virus vaccine, quadrivalent (IIV4), split virus, preservative free, for intradermal use','influenza, intradermal, quadrivalent, preservative free',2),(90632,'Hepatitis A vaccine (HepA), adult dosage, for intramuscular use','Hep A, adult',1),(90633,'Hepatitis A vaccine (HepA), pediatric/adolescent dosage-2 dose schedule, for intramuscular use','Hep A, ped/adol, 2 dose',3),(90634,'Hepatitis A vaccine (HepA), pediatric/adolescent dosage-3 dose schedule, for intramuscular use','Hep A, ped/adol, 3 dose',3),(90636,'Hepatitis A and hepatitis B vaccine (HepA-HepB), adult dosage, for intramuscular use','Hep A-Hep B',2),(90644,'Meningococcal conjugate vaccine, serogroups C & Y and Haemophilus influenzae type b vaccine (Hib-MenCY), 4 dose schedule, when administered to children 6 weeks-18 months of age, for intramuscular use','Meningococcal C/Y-HIB PRP',3),(90645,'Hemophilus influenza b vaccine (Hib), HbOC conjugate (4 dose schedule), for intramuscular use','Hib (HbOC)',1),(90646,'Hemophilus influenza b vaccine (Hib), PRP-D conjugate, for booster use only, intramuscular use','Hib (PRP-D)',1),(90647,'Haemophilus influenzae type b vaccine (Hib), PRP-OMP conjugate, 3 dose schedule, for intramuscular use','Hib (PRP-OMP)',2),(90648,'Haemophilus influenzae type b vaccine (Hib), PRP-T conjugate, 4 dose schedule, for intramuscular use','Hib (PRP-T)',2),(90649,'Human Papillomavirus vaccine, types 6, 11, 16, 18, quadrivalent (4vHPV), 3 dose schedule, for intramuscular use','HPV, quadrivalent',2),(90650,'Human Papillomavirus vaccine, types 16, 18, bivalent (2vHPV), 3 dose schedule, for intramuscular use','HPV, bivalent',2),(90651,'Human Papillomavirus vaccine types 6, 11, 16, 18, 31, 33, 45, 52, 58, nonavalent (9vHPV), 2 or 3 dose schedule, for intramuscular use','HPV9',2),(90653,'Influenza vaccine, inactivated (IIV), subunit, adjuvanted, for intramuscular use','influenza, trivalent, adjuvanted',4),(90654,'Influenza virus vaccine, trivalent (IIV3), split virus, preservative-free, for intradermal use','influenza, seasonal, intradermal, preservative free',3),(90655,'Influenza virus vaccine, trivalent (IIV3), split virus, preservative free, 0.25 mL dosage, for intramuscular use','Influenza, seasonal, injectable, preservative free',3),(90656,'Influenza virus vaccine, trivalent (IIV3), split virus, preservative free, 0.5 mL dosage, for intramuscular use','Influenza, seasonal, injectable, preservative free',3),(90657,'Influenza virus vaccine, trivalent (IIV3), split virus, 0.25 mL dosage, for intramuscular use','Influenza, seasonal, injectable',3),(90658,'Influenza virus vaccine, trivalent (IIV3), split virus, 0.5 mL dosage, for intramuscular use','Influenza, seasonal, injectable',2),(90659,'Influenza virus vaccine, whole virus, for intramuscular or jet injection use','influenza, whole',3),(90660,'Influenza virus vaccine, trivalent, live (LAIV3), for intranasal use','influenza, live, intranasal',2),(90661,'Influenza virus vaccine, trivalent (ccIIV3), derived from cell cultures, subunit, preservative and antibiotic free, 0.5 mL dosage, for intramuscular use','Influenza, injectable, MDCK, preservative free',5),(90662,'Influenza virus vaccine (IIV), split virus, preservative free, enhanced immunogenicity via increased antigen content, for intramuscular use','Influenza, high dose seasonal',4),(90663,'Influenza virus vaccine, pandemic formulation, H1N1','Novel Influenza-H1N1-09, all formulations',1),(90664,'Influenza virus vaccine, live (LAIV), pandemic formulation, for intranasal use','Novel Influenza-H1N1-09, nasal',3),(90665,'Lyme disease vaccine, adult dosage, for intramuscular use','Lyme disease',2),(90666,'Influenza virus vaccine (IIV), pandemic formulation, split virus, preservative free, for intramuscular use','Novel influenza-H1N1-09, preservative-free',1),(90668,'Influenza virus vaccine (IIV), pandemic formulation, split virus, for intramuscular use','Novel influenza-H1N1-09',1),(90669,'Pneumococcal conjugate vaccine, 7 valent, for intramuscular use','pneumococcal conjugate PCV 7',1),(90670,'Pneumococcal conjugate vaccine, 13 valent (PCV13), for intramuscular use','Pneumococcal conjugate PCV 13',4),(90672,'Influenza virus vaccine, quadrivalent, live (LAIV4), for intranasal use','influenza, live, intranasal, quadrivalent',1),(90673,'Influenza virus vaccine, trivalent (RIV3), derived from recombinant DNA, hemagglutinin (HA) protein only, preservative and antibiotic free, for intramuscular use','influenza, recombinant, injectable, preservative free',3),(90674,'Influenza virus vaccine, quadrivalent (ccIIV4), derived from cell cultures, subunit, preservative and antibiotic free, 0.5 mL dosage, for intramuscular use','Influenza, injectable, MDCK, preservative free, quadrivalent',1),(90675,'Rabies vaccine, for intramuscular use','rabies, unspecified formulation',2),(90676,'Rabies vaccine, for intradermal use','rabies, intradermal injection',1),(90680,'Rotavirus vaccine, pentavalent (RV5), 3 dose schedule, live, for oral use','rotavirus, pentavalent',5),(90681,'Rotavirus vaccine, human, attenuated (RV1), 2 dose schedule, live, for oral use','rotavirus, monovalent',1),(90682,'Influenza virus vaccine, quadrivalent (RIV4), derived from recombinant DNA, hemagglutinin (HA) protein only, preservative and antibiotic free, for intramuscular use','influenza, recombinant, quadrivalent,injectable, preservative free',4),(90685,'Influenza virus vaccine, quadrivalent (IIV4), split virus, preservative free, 0.25 mL dosage, for intramuscular use','Influenza, injectable,quadrivalent, preservative free, pediatric',3),(90686,'Influenza virus vaccine, quadrivalent (IIV4), split virus, preservative free, 0.5 mL dosage, for intramuscular use','influenza, injectable, quadrivalent, preservative free',2),(90687,'Influenza virus vaccine, quadrivalent (IIV4), split virus, 0.25 mL dosage, for intramuscular use','influenza, injectable, quadrivalent',1),(90688,'Influenza virus vaccine, quadrivalent (IIV4), split virus, 0.5 mL dosage, for intramuscular use','influenza, injectable, quadrivalent',2),(90690,'Typhoid vaccine, live, oral','typhoid, oral',1),(90691,'Typhoid vaccine, Vi capsular polysaccharide (ViCPs), for intramuscular use','typhoid, ViCPs',1),(90692,'Typhoid vaccine, heat- and phenol-inactivated (H-P), for subcutaneous or intradermal use','typhoid, parenteral',2),(90693,'Typhoid vaccine, acetone-killed, dried (AKD), for subcutaneous use (U.S. military)','typhoid, parenteral, AKD (U.S. military)',2),(90694,'Influenza virus vaccine, quadrivalent (aIIV4), inactivated, adjuvanted, preservative free, 0.5 mL dosage, for intramuscular use','influenza, injectable, quadrivalent, preservative free',1),(90696,'Diphtheria, tetanus toxoids, acellular pertussis vaccine and inactivated poliovirus vaccine (DTaP-IPV), when administered to children 4 through 6 years of age, for intramuscular use','DTaP-IPV',1),(90697,'Diphtheria, tetanus toxoids, acellular pertussis vaccine, inactivated poliovirus vaccine, Haemophilus influenzae type b PRP-OMP conjugate vaccine, and hepatitis B vaccine (DTaP-IPV-Hib-HepB), for intramuscular use','DTaP,IPV,Hib,HepB',3),(90698,'Diphtheria, tetanus toxoids, acellular pertussis vaccine, Haemophilus influenzae type b, and inactivated poliovirus vaccine, (DTaP-IPV/Hib), for intramuscular use','DTaP-Hib-IPV',2),(90700,'Diphtheria, tetanus toxoids, and acellular pertussis vaccine (DTaP), when administered to individuals younger than 7 years, for intramuscular use','DTaP, unspecified formulation',4),(90701,'Diphtheria, tetanus toxoids, and whole cell pertussis vaccine (DTP), for intramuscular use','DTP',4),(90702,'Diphtheria and tetanus toxoids adsorbed (DT) when administered to individuals younger than 7 years, for intramuscular use','DT (pediatric)',4),(90703,'Tetanus toxoid adsorbed, for intramuscular use','tetanus toxoid, adsorbed',1),(90704,'Mumps virus vaccine, live, for subcutaneous use','mumps',2),(90705,'Measles virus vaccine, live, for subcutaneous use','measles',3),(90706,'Rubella virus vaccine, live, for subcutaneous use','rubella',3),(90707,'Measles, mumps and rubella virus vaccine (MMR), live, for subcutaneous use','MMR',3),(90708,'Measles and rubella virus vaccine, live, for subcutaneous use','M/R',2),(90710,'Measles, mumps, rubella, and varicella vaccine (MMRV), live, for subcutaneous use','MMRV',1),(90712,'Poliovirus vaccine, (any type[s]) (OPV), live, for oral use','OPV, Unspecified',3),(90713,'Poliovirus vaccine, inactivated (IPV), for subcutaneous or intramuscular use','IPV',3),(90714,'Tetanus and diphtheria toxoids adsorbed (Td), preservative free, when administered to individuals 7 years or older, for intramuscular use','Td, adsorbed, preservative free, adult use, Lf unspecified',2),(90715,'Tetanus, diphtheria toxoids and acellular pertussis vaccine (Tdap), when administered to individuals 7 years or older, for intramuscular use','Tdap',3),(90716,'Varicella virus vaccine (VAR), live, for subcutaneous use','varicella',2),(90717,'Yellow fever vaccine, live, for subcutaneous use','Yellow fever, unspecified formulation',2),(90718,'Tetanus and diphtheria toxoids (Td) adsorbed when administered to individuals 7 years or older, for intramuscular use','Td (adult), 2 Lf tetanus toxoid, preservative free, adsorbed',1),(90720,'Diphtheria, tetanus toxoids, and whole cell pertussis vaccine and Hemophilus influenza B vaccine (DTP-Hib), for intramuscular use','DTP-Hib',1),(90721,'Diphtheria, tetanus toxoids, and acellular pertussis vaccine and Hemophilus influenza B vaccine (DTaP/Hib), for intramuscular use','DTaP-Hib',1),(90723,'Diphtheria, tetanus toxoids, acellular pertussis vaccine, hepatitis B, and inactivated poliovirus vaccine (DTaP-HepB-IPV), for intramuscular use','DTaP-Hep B-IPV',2),(90724,'Influenza virus vaccine','influenza, unspecified formulation',3),(90725,'Cholera vaccine for injectable use','cholera, unspecified formulation',5),(90726,'Rabies vaccine','rabies, unspecified formulation',3),(90727,'Plague vaccine, for intramuscular use','plague',2),(90728,'BCG vaccine','BCG',2),(90730,'Hepatitis A vaccine','Hep A, unspecified formulation',2),(90731,'Hepatitis B vaccine','Hep B, unspecified formulation',1),(90732,'Pneumococcal polysaccharide vaccine, 23-valent (PPSV23), adult or immunosuppressed patient dosage, when administered to individuals 2 years or older, for subcutaneous or intramuscular use','pneumococcal polysaccharide PPV23',3),(90733,'Meningococcal polysaccharide vaccine, serogroups A, C, Y, W-135, quadrivalent (MPSV4), for subcutaneous use','meningococcal MPSV4',5),(90734,'Meningococcal conjugate vaccine, serogroups A, C, W, Y, quadrivalent, diphtheria toxoid carrier (MenACWY-D) or CRM197 carrier (MenACWY-CRM), for intramuscular use','meningococcal MCV4, unspecified formulation',4),(90735,'Japanese encephalitis virus vaccine, for subcutaneous use','Japanese encephalitis SC',2),(90736,'Zoster (shingles) vaccine (HZV), live, for subcutaneous injection','zoster live',3),(90737,'Hemophilus influenza B','Hib, unspecified formulation',3),(90738,'Japanese encephalitis virus vaccine, inactivated, for intramuscular use','Japanese Encephalitis IM',2),(90739,'Hepatitis B vaccine (HepB), adult dosage, 2 dose schedule, for intramuscular use','HepB-CpG',1),(90740,'Hepatitis B vaccine (HepB), dialysis or immunosuppressed patient dosage, 3 dose schedule, for intramuscular use','Hep B, dialysis',3),(90741,'Immunization, passive; immune serum globulin, human (ISG)','IG, unspecified formulation',4),(90743,'Hepatitis B vaccine (HepB), adolescent, 2 dose schedule, for intramuscular use','Hep B, adult',3),(90744,'Hepatitis B vaccine (HepB), pediatric/adolescent dosage, 3 dose schedule, for intramuscular use','Hep B, adolescent or pediatric',3),(90745,'Hepatitis B vaccine, adolescent/high risk infant dosage, for intramuscular use','Hep B, adolescent/high risk infant',3),(90746,'Hepatitis B vaccine (HepB), adult dosage, 3 dose schedule, for intramuscular use','Hep B, adult',2),(90747,'Hepatitis B vaccine (HepB), dialysis or immunosuppressed patient dosage, 4 dose schedule, for intramuscular use','Hep B, dialysis',3),(90748,'Hepatitis B and Haemophilus influenzae type b vaccine (Hib-HepB), for intramuscular use','Hib-Hep B',2),(90750,'Zoster (shingles) vaccine (HZV), recombinant, subunit, adjuvanted, for intramuscular use','zoster recombinant',2),(90756,'Influenza virus vaccine, quadrivalent (ccIIV4), derived from cell cultures, subunit, antibiotic free, 0.5 mL dosage, for intramuscular use','Influenza, injectable, MDCK, quadrivalent, preservative',1);
/*!40000 ALTER TABLE `Vaccinations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VaccineCamps`
--

DROP TABLE IF EXISTS `VaccineCamps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VaccineCamps` (
  `CampID` int(11) NOT NULL AUTO_INCREMENT,
  `StartDate` date NOT NULL,
  `EndDate` date NOT NULL,
  `NumberOfPeopleTreated` int(11) NOT NULL DEFAULT '0',
  `VaccineIDs` int(11) NOT NULL,
  `HealthCentreID` int(11) NOT NULL,
  PRIMARY KEY (`CampID`),
  KEY `VaccineCamps_ibfk_1` (`VaccineIDs`),
  KEY `fk_VaccineCamps_healthCentre_idx` (`HealthCentreID`),
  CONSTRAINT `VaccineCamps_ibfk_1` FOREIGN KEY (`VaccineIDs`) REFERENCES `Vaccinations` (`VaccineID`),
  CONSTRAINT `fk_VaccineCamps_healthCentre` FOREIGN KEY (`HealthCentreID`) REFERENCES `PublicHealthCentre` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VaccineCamps`
--

LOCK TABLES `VaccineCamps` WRITE;
/*!40000 ALTER TABLE `VaccineCamps` DISABLE KEYS */;
INSERT INTO `VaccineCamps` VALUES (1,'2020-03-03','2020-03-10',42,90281,5),(2,'2020-01-27','2020-02-04',30,90283,4),(3,'2020-03-15','2020-03-25',36,90287,9),(4,'2020-02-14','2020-02-24',36,90291,6),(5,'2020-01-05','2020-01-16',38,90296,12),(6,'2020-03-28','2020-04-06',43,90371,13),(7,'2020-03-23','2020-03-30',34,90375,14),(8,'2020-03-30','2020-04-08',47,90376,34),(9,'2020-03-17','2020-03-24',37,90378,23),(10,'2020-01-27','2020-02-03',40,90379,24),(11,'2020-03-15','2020-03-23',47,90389,26),(12,'2020-03-09','2020-03-16',43,90393,45),(13,'2020-03-19','2020-03-26',31,90396,34),(14,'2020-03-17','2020-03-24',36,90470,45),(15,'2020-01-10','2020-01-17',46,90476,15),(16,'2020-02-16','2020-02-23',50,90477,19),(17,'2020-01-10','2020-01-24',33,90581,21),(18,'2020-03-17','2020-03-24',35,90585,4),(19,'2020-02-23','2020-03-01',49,90620,1),(20,'2020-03-23','2020-03-30',40,90621,23),(21,'2020-03-31','2020-04-07',43,90625,45),(22,'2020-02-26','2020-03-04',42,90630,9),(23,'2020-04-09','2020-04-16',44,90632,23),(24,'2020-03-29','2020-04-05',46,90633,45),(25,'2020-01-12','2020-01-19',45,90634,48),(26,'2020-02-06','2020-02-13',35,90636,42),(27,'2020-02-23','2020-03-01',41,90644,41),(28,'2020-03-18','2020-03-25',39,90645,28),(29,'2020-02-26','2020-03-04',31,90646,36),(30,'2020-03-01','2020-03-08',30,90647,45),(31,'2020-01-15','2020-01-22',46,90648,19),(32,'2020-01-28','2020-02-04',41,90649,29),(33,'2020-02-10','2020-02-17',32,90650,31),(34,'2020-03-18','2020-03-25',49,90651,47),(35,'2020-02-02','2020-02-09',33,90644,32),(36,'2020-02-08','2020-02-15',31,90645,49),(37,'2020-01-23','2020-01-30',45,90646,16),(38,'2020-04-03','2020-04-10',44,90647,24),(39,'2020-03-30','2020-04-07',47,90648,36),(40,'2020-03-02','2020-03-09',41,90649,47),(41,'2020-02-04','2020-02-11',47,90650,12),(42,'2020-03-18','2020-03-25',36,90651,7),(43,'2020-03-17','2020-03-25',39,90644,34),(44,'2020-01-11','2020-01-19',30,90645,45),(45,'2020-02-08','2020-02-17',48,90646,5),(46,'2020-01-20','2020-01-28',44,90647,23),(47,'2020-02-03','2020-02-11',40,90648,42),(48,'2020-03-05','2020-03-13',31,90649,27),(49,'2020-01-11','2020-01-18',33,90650,16),(50,'2020-01-27','2020-02-03',47,90651,8);
/*!40000 ALTER TABLE `VaccineCamps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VaccineCategories`
--

DROP TABLE IF EXISTS `VaccineCategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VaccineCategories` (
  `SID` int(11) NOT NULL,
  `VaccineCategoryID` varchar(255) NOT NULL,
  `Category Name` varchar(100) NOT NULL,
  `Description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`VaccineCategoryID`),
  UNIQUE KEY `SID_UNIQUE` (`SID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VaccineCategories`
--

LOCK TABLES `VaccineCategories` WRITE;
/*!40000 ALTER TABLE `VaccineCategories` DISABLE KEYS */;
INSERT INTO `VaccineCategories` VALUES (2,'INV','Inactivated vaccines','Inactivated vaccines use the killed version of the germ that causes a disease.'),(1,'LAV','Live-attenuated vaccines','Live vaccines use a weakened (or attenuated) form of the germ that causes a disease.'),(3,'SRPC','Subunit, recombinant, polysaccharide, and conjugate vaccines','Subunit, recombinant, polysaccharide, and conjugate vaccines use specific pieces of the germ — like its protein, sugar, or capsid (a casing around the germ).'),(4,'TXV','Toxoid Vaccines','Toxoid vaccines use a toxin (harmful product) made by the germ that causes a disease. They create immunity to the parts of the germ that cause a disease instead of the germ itself. That means the immune response is targeted to the toxin instead of the whole germ.');
/*!40000 ALTER TABLE `VaccineCategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) NOT NULL,
  `Gender` varchar(10) DEFAULT NULL,
  `DOB` date NOT NULL,
  `emailID` varchar(255) DEFAULT NULL,
  `pincode` int(11) NOT NULL,
  `state` varchar(50) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Contact` varchar(15) NOT NULL,
  `GuardianName` varchar(50) DEFAULT NULL,
  `AadharNumber` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Aadhar Number_UNIQUE` (`AadharNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Stevie Heatly','Male','2009-01-30','cfivey0@mtv.com',668162,'Goa','5254 Warbler Way','562-86-9676','Carlyle Fivey','443-43-1170-3213'),(2,'Hendrik Blevin','Male','2010-06-11','cvarden1@reuters.com',443929,'Delhi','864 Northview Avenue','497-72-2240','Charley Varden','735-97-7875-3214'),(3,'Britt Lyman','Female','2010-05-27','flamberts2@sbwire.com',668162,'U.p','99118 Stoughton Crossing','282-16-2744','Franky Lamberts','484-40-0058-1235'),(4,'Tabby Trengove','Male','2009-04-05','ade3@163.com',668162,'Goa','82 Burrows Pass','747-30-6507','Artair De Haven','550-59-3907-4322'),(5,'Gabbie Garrioch','Female','2010-09-10','scoxhell4@meetup.com',668162,'Delhi','47506 Cambridge Hill','827-23-8731','Stephie Coxhell','424-38-6855-4531'),(6,'Filmore Bruun','Male','2008-09-06','uesgate5@merriam-webster.com',211231,'Bihar','379 Transport Road','176-24-6699','Ulric Esgate','165-44-9180-4565'),(7,'Cyndy Kear','Female','2010-01-20','gfalloon6@macromedia.com',443929,'Punjab','52542 Coleman Hill','307-81-5145','Gunilla Falloon','595-09-8405-4566'),(8,'Sterling Simper','Male','2010-06-30','mpohlke7@dell.com',211231,'Delhi','306 Lotheville Court','572-42-3378','Murvyn Pohlke','803-87-2998-4561'),(9,'Tulley Beedle','Male','2009-02-08','slokier8@adobe.com',222312,'Goa','86 Cody Crossing','423-21-1107','Sim Lokier','324-46-3170-6751'),(10,'Carin Allanby','Female','2009-05-15','lrakes9@house.gov',443929,'Rajasthan','21 Ridgeway Terrace','423-77-5120','Lorry Rakes','292-58-4149-5636'),(11,'Iver Berkley','Male','2008-10-25','lpetchera@cam.ac.uk',183221,'Bihar','3708 Hansons Plaza','717-86-2724','Lalo Petcher','586-81-0818-5436'),(12,'Gottfried Roscamps','Male','2010-05-24','oswinleyb@meetup.com',211231,'Delhi','54 Mesta Lane','608-53-0825','Othello Swinley','540-34-1770-5677'),(13,'Shaina Kleis','Female','2009-07-10','mhurranc@jimdo.com',183221,'Goa','62 Warrior Point','238-19-4492','Mollee Hurran','425-68-2363-8767'),(14,'Chuck Machon','Male','2008-09-14','fshevlind@ucoz.com',211231,'Rajasthan','18 Jana Drive','851-83-7053','Fransisco Shevlin','899-40-8345-2343'),(15,'Gizela Hornbuckle','Female','2008-07-31','blilloe@mlb.com',183221,'Bihar','38544 Kropf Circle','831-06-5552','Bari Lillo','289-15-3696-0984'),(16,'Lorene Peracco','Female','2010-08-22','jchawkleyf@paypal.com',211231,'Punjab','176 Sugar Point','875-05-3134','Johna Chawkley','595-20-3079-4573'),(17,'Alyda Melarkey','Female','2008-04-17','dvedeneevg@noaa.gov',668162,'Delhi','28 Lindbergh Park','620-05-0734','Dian Vedeneev','285-85-6875-7654'),(18,'Herbie Devereux','Male','2008-06-18','tdeavallh@time.com',183221,'M.P','97 Ludington Plaza','407-85-2425','Titus Deavall','603-29-4704-6785'),(19,'Chrissie Lovie','Female','2008-07-10','mzaniolettii@pcworld.com',668162,'Goa','77198 Leroy Place','586-01-4092','Marisa Zanioletti','411-64-68879839'),(20,'Barron Yeeles','Male','2009-09-08','kcamossoj@lulu.com',183221,'Bihar','27 Victoria Trail','429-58-1364','Khalil Camosso','480-12-8977-6483'),(21,'Steffi Kohrding','Female','2009-03-19','abiersk@example.com',668162,'U.p','028 Namekagon Junction','298-76-2717','Adelaide Biers','599-45-9494-6583'),(22,'Maure Woolfenden','Female','2010-06-28','omyttonl@gmpg.org',211231,'M.P','48 Briar Crest Court','754-86-5213','Oralia Mytton','657-57-7737-6758'),(23,'Mattie Boshier','Male','2008-08-15','lthoulessm@artisteer.com',679130,'Delhi','2 Melrose Road','183-14-4042','Lesley Thouless','377-50-0098-6833'),(24,'Tedd Harsnep','Male','2010-11-02','astavesn@ebay.co.uk',443929,'Bihar','7 Montana Crossing','895-53-9748','Arney Staves','707-05-9616-4683'),(25,'Wanda Sainte Paul','Female','2010-11-07','esivyouro@newyorker.com',211231,'Goa','736 Northport Circle','203-69-2256','Eleanore Sivyour','339-80-5810-5638'),(26,'Concettina Oxenford','Female','2008-04-13','astiellp@miibeian.gov.cn',359120,'M.P','0521 Spenser Alley','200-91-1046','Atalanta Stiell','335-58-4089-4678'),(27,'Rozanna Sultan','Female','2009-12-05','mbaudainsq@so-net.ne.jp',443929,'Goa','224 Ridgeway Lane','125-70-7072','Missy Baudains','302-99-2639-4332'),(28,'Melody Wethered','Female','2009-01-14','ghoudmontr@cyberchimps.com',359120,'Rajasthan','4891 Dapin Alley','785-29-7374','Gustie Houdmont','615-49-0470-3425'),(29,'Gian Nortunen','Male','2008-11-25','pblondelles@ocn.ne.jp',359120,'Goa','70207 Dennis Park','741-53-8424','Price Blondelle','171-33-9640-4325'),(30,'Scotty Heavy','Male','2010-07-09','hbrosnant@123-reg.co.uk',443929,'U.p','13781 Summerview Way','210-38-4985','Horacio Brosnan','244-47-0039-4325'),(31,'Barbra Wix','Female','2008-03-01','smcowenu@jiathis.com',359120,'Goa','82 Stephen Pass','459-71-4665','Sandy McOwen','129-87-3788-2748'),(32,'Erick Timberlake','Male','2010-12-19','speacockv@livejournal.com',211231,'M.P','1 Lindbergh Road','309-05-6533','Say Peacock','380-80-6305-4673'),(33,'Winnie Scough','Female','2008-03-29','avalenciaw@nih.gov',211231,'Goa','8 Bartillon Drive','154-47-2473','Antonietta Valencia','270-17-3634-4672'),(34,'Britta Sambrok','Female','2010-05-24','jrubenczykx@mozilla.org',434345,'U.p','3 Old Gate Place','460-22-2360','Jilly Rubenczyk','204-04-6623-5271'),(35,'Rogers Emma','Male','2009-12-18','apeizery@imgur.com',443929,'Rajasthan','59074 Brickson Park Park','475-08-9037','Alphard Peizer','246-19-9960-6483'),(36,'Adena Schiefersten','Female','2009-07-18','edonlonz@stumbleupon.com',183221,'U.p','6119 Riverside Lane','217-04-4796','Elaine Donlon','252-61-0259-4672'),(37,'Shela Mingotti','Female','2009-05-20','sdunhill10@cam.ac.uk',359120,'Rajasthan','43 Darwin Crossing','299-99-0184','Stormy Dunhill','385-55-8240-4672'),(38,'Junette Jeanequin','Female','2010-10-31','bbraams11@uol.com.br',183221,'M.P','4 Dryden Pass','536-17-7912','Brooke Braams','700-04-2712-1132'),(39,'Hannis Sex','Female','2011-02-03','nstarcks12@ucla.edu',183221,'Goa','85561 Stephen Way','755-23-6334','Nessie Starcks','747-48-8405-4733'),(40,'Erika Ubee','Female','2010-07-23','tfarren13@csmonitor.com',211231,'U.p','048 Main Court','648-97-0490','Trescha Farren','659-85-4300-3473'),(41,'Lynn Formigli','Male','2010-02-19','hfenny14@vkontakte.ru',183221,'Punjab','69233 Calypso Plaza','375-04-2480','Hymie Fenny','238-60-7491-4874'),(42,'Waylen Liggett','Male','2009-06-30','kodell15@nytimes.com',359120,'Rajasthan','44 Killdeer Road','267-73-2060','Kellby O\'dell','863-07-1966-4376'),(43,'Ignacio Greenwell','Male','2010-12-23','ephethean16@google.de',183221,'Bihar','41608 Sherman Place','142-75-5587','Ernesto Phethean','364-19-4852-3433'),(44,'Noel O\'Donovan','Male','2009-01-05','gdolle17@google.pl',183221,'Goa','27074 Fair Oaks Hill','147-18-8047','Guilbert Dolle','862-06-9102-3443'),(45,'Brock Yeskin','Male','2008-09-01','rpeddel18@bloglines.com',359120,'Punjab','1 Crowley Parkway','496-05-4938','Rubin Peddel','150-86-4353-3632'),(46,'Sutherlan Briddle','Male','2010-05-30','vdudek19@infoseek.co.jp',211231,'Bihar','679 Ludington Lane','275-88-8210','Vinson Dudek','273-81-2463-2323'),(47,'Arlette Dorward','Female','2010-04-04','ebuard1a@deviantart.com',183221,'Goa','1392 Fisk Lane','241-58-8124','Esme Buard','639-34-5522-4763'),(48,'Aeriel Gerler','Female','2010-12-08','lgartin1b@mtv.com',443929,'Punjab','6 Old Shore Place','152-58-6846','Lindsey Gartin','334-78-2591-3434'),(49,'Bernetta Akett','Female','2009-09-03','kred1c@cornell.edu',211231,'M.P','9659 Graedel Junction','235-70-2786','Kellyann Red','598-60-4710-3643'),(50,'Earle Rugg','Male','2009-02-09','ttregale1d@sphinn.com',359120,'Rajasthan','716 Cherokee Junction','502-57-7606','Tremaine Tregale','322-56-7812-4743'),(51,'Cody Rangle','Male','2009-10-20','bleinster1e@virginia.edu',183221,'U.p','3 Eagan Avenue','224-85-2839','Boyd Leinster','444-93-7450-3333'),(52,'Steffen Hawke','Male','2008-04-19','adudleston1f@naver.com',601294,'Goa','1116 Fordem Parkway','162-46-0887','Abdel Dudleston','452-57-9749-0987'),(53,'Florinda Jeffels','Female','2009-06-04','vgostling1g@github.io',307351,'Punjab','18 Delladonna Point','502-25-2292','Valaria Gostling','449-44-3386-6437'),(54,'Siffre Borham','Male','2010-03-04','dsedge1h@tripadvisor.com',601294,'Rajasthan','55113 Manley Road','719-04-5529','Dani Sedge','598-18-9321-4673'),(55,'Dave Budden','Male','2009-05-24','iadamolli1i@yellowbook.com',211231,'Bihar','6256 Hudson Terrace','345-40-8665','Ingram Adamolli','164-95-2188-4683'),(56,'Fay Blundell','Female','2010-01-27','tbyart1j@deliciousdays.com',359120,'Punjab','62 Heath Place','575-53-7321','Theodora Byart','509-80-9843-4738'),(57,'Weston Dungey','Male','2009-03-17','oclews1k@sourceforge.net',359120,'Goa','48 Lunder Pass','867-51-7479','Odey Clews','395-51-0915-7847'),(58,'Florry Pimlott','Female','2010-03-20','lsaundercock1l@va.gov',183221,'Punjab','05 Packers Junction','142-61-9598','Leonore Saundercock','181-42-7392-8873'),(59,'Harlin Rickcord','Male','2008-12-19','atitman1m@harvard.edu',601294,'U.p','18 Kings Hill','811-57-0945','Alf Titman','243-47-8026-8784'),(60,'Zed Crowest','Male','2009-03-26','cdenkel1n@google.com',211231,'Rajasthan','566 Meadow Ridge Trail','621-98-5019','Currey Denkel','703-28-9884-6473'),(61,'Byram Edgson','Male','2010-06-20','cschenfisch1o@bing.com',359120,'Rajasthan','392 Old Gate Alley','649-72-9362','Corrie Schenfisch','162-38-1113-4734'),(62,'Benny Phalp','Male','2009-02-20','cbocock1p@hubpages.com',183221,'Bihar','80067 Ilene Terrace','242-68-9076','Clare Bocock','272-70-8713-7438'),(63,'Bethina Boarer','Female','2008-04-13','alyness1q@rakuten.co.jp',601294,'Punjab','62 Lake View Parkway','211-98-8265','Aggi Lyness','468-80-4770-8438'),(64,'Addia Moiser','Female','2008-12-01','dniblett1r@shinystat.com',359120,'Goa','0841 Westport Avenue','509-89-4518','Dianemarie Niblett','809-21-3463-7483'),(65,'Alaster Merveille','Male','2009-05-21','ptruss1s@indiegogo.com',601294,'Bihar','63 Anniversary Way','129-07-9205','Peter Truss','118-57-1527-6487'),(66,'Lainey Mayhead','Female','2009-09-03','bwordsley1t@networksolutions.com',183221,'Goa','606 Ronald Regan Hill','333-31-4546','Benedetta Wordsley','773-84-1221-6743'),(67,'Bondon Aynsley','Male','2010-11-30','sdinnage1u@house.gov',601294,'Punjab','73 Dixon Circle','168-80-2654','Somerset Dinnage','127-47-1793-7438'),(68,'Roshelle Thomel','Female','2008-08-27','cclaessens1v@newyorker.com',183221,'Delhi','0998 Duke Plaza','143-85-6170','Catina Claessens','761-47-4998-4673'),(69,'Nolan Hubbold','Male','2010-01-04','cwrassell1w@nbcnews.com',601294,'U.p','32 Summer Ridge Plaza','642-52-3379','Clive Wrassell','311-66-5609-7478'),(70,'Katusha Weatherby','Female','2009-02-03','ilorimer1x@ocn.ne.jp',359120,'U.p','4 Melody Street','791-63-5415','Ianthe Lorimer','186-50-1193-4673'),(71,'Riva Clibbery','Female','2009-01-22','ggavahan1y@mapquest.com',183221,'Punjab','7488 Chive Road','341-31-3073','Gussy Gavahan','648-82-1537-3783'),(72,'Ludovico Yepiskopov','Male','2009-08-28','bdunston1z@ftc.gov',161560,'U.p','6408 Heffernan Place','861-85-4787','Blake Dunston','830-79-1095-7833'),(73,'Tan Dunabie','Male','2009-01-29','smerrell20@cdc.gov',28410,'Bihar','02 Hoepker Park','641-16-2246','Salomo Merrell','862-54-6581-7833'),(74,'Frederico Haensel','Male','2010-10-23','fbadam21@technorati.com',359120,'Rajasthan','779 Michigan Point','884-28-1101','Frederic Badam','590-33-8105-7833'),(75,'Pauly Grief','Male','2010-10-30','gheliet22@blogtalkradio.com',473008,'Punjab','64455 Cardinal Lane','202-11-2520','Gibb Heliet','420-82-2982-7833'),(76,'Shana Digginson','Female','2010-04-01','ymurrish23@cnn.com',601294,'Bihar','9 Darwin Junction','759-38-3893','Yolanthe Murrish','460-77-5861-7833'),(77,'Abbey Feldbaum','Female','2010-11-08','doffen24@odnoklassniki.ru',601294,'Punjab','3656 Clemons Parkway','211-65-5364','Dido Offen','518-62-5144-7833'),(78,'Etheline Lamke','Female','2010-04-05','mqueen25@pinterest.com',211231,'Delhi','030 Forest Dale Alley','705-10-1666','Mavis Queen','290-69-9750-7833'),(79,'Gwenni Furst','Female','2008-11-01','wcharlewood26@icq.com',211231,'Rajasthan','5 Delladonna Junction','855-04-9501','Winni Charlewood','632-31-9720-7833'),(80,'Judye Lanfere','Female','2009-09-14','jwimlet27@indiatimes.com',601294,'Goa','47 Hooker Center','574-14-1478','Jorrie Wimlet','670-68-8873-4683'),(81,'Silvano Leemans','Male','2009-01-24','deberts28@sun.com',443929,'Punjab','389 Sherman Crossing','540-59-6979','Durward Eberts','444-40-6708-4683'),(82,'Alanah Braben','Female','2009-09-30','tbriggs29@gov.uk',601294,'Rajasthan','063 Brentwood Place','770-06-1688','Tina Briggs','137-40-9494-4683'),(83,'Julietta Denisevich','Female','2009-12-02','dmctear2a@t.co',601294,'Delhi','202 Nobel Drive','278-50-3457','Darlleen McTear','103-48-0217-4683'),(84,'Royall Oldam','Male','2008-08-22','dwilliscroft2b@telegraph.co.uk',601294,'U.p','78245 Sunnyside Pass','844-12-6401','Derry Williscroft','741-32-0661-4683'),(85,'Redd Duffit','Male','2009-08-30','avassar2c@sakura.ne.jp',232313,'U.p','07 Doe Crossing Avenue','814-47-9464','Archambault Vassar','615-27-8981-4683'),(86,'Eduardo Kirwood','Male','2010-09-18','gnorthley2d@howstuffworks.com',987321,'Goa','4297 Rowland Trail','660-31-5108','Garik Northley','292-07-3086-4683'),(87,'Ora Fane','Female','2009-08-05','gattwater2e@google.cn',359120,'Bihar','4391 Duke Terrace','166-40-2594','Gabriella Attwater','303-95-4384-4683'),(88,'Corby Crimes','Male','2011-01-18','bsykes2f@google.nl',359120,'Bihar','30020 Myrtle Alley','827-71-3987','Burty Sykes','832-33-6850-4683'),(89,'Temple Hush','Male','2010-07-18','mstrike2g@usa.gov',323213,'Rajasthan','28 Michigan Drive','176-23-6783','Magnum Strike','710-80-1826-4683'),(90,'Kaiser Samms','Male','2008-04-07','smassow2h@rambler.ru',182313,'Punjab','6127 Mallard Crossing','256-63-5087','Scottie Massow','746-12-4089-4683'),(91,'Archibaldo Kaindl','Male','2009-06-03','tfoley2i@berkeley.edu',601294,'Delhi','0695 Pepper Wood Park','302-74-4853','Torre Foley','304-29-5062-4683'),(92,'Cathrin Broyd','Female','2008-04-30','pcoughan2j@bandcamp.com',231121,'U.p','699 Sundown Street','261-96-7335','Perle Coughan','796-66-5431-4683'),(93,'Carolyn McCaighey','Female','2010-07-16','alambricht2k@dagondesign.com',601294,'Bihar','30787 Green Ridge Place','855-47-9206','Ann-marie Lambricht','319-78-7176-4683'),(94,'Erika Forsbey','Female','2009-02-24','mpigney2l@mozilla.com',601221,'Delhi','75118 Scoville Terrace','761-30-5389','Marys Pigney','503-06-3596-4683'),(95,'Emili Le Provost','Female','2010-06-23','nhairsine2m@nasa.gov',213213,'U.p','1985 Del Mar Way','777-32-1840','Nonnah Hairsine','255-51-7142-4683'),(96,'Clemmie Minghella','Female','2010-07-04','gduetsche2n@usnews.com',601294,'Goa','51 Rusk Road','165-15-7960','Giselle Duetsche','830-65-5468-4683'),(97,'Kris Crang','Male','2011-01-24','frisdale2o@naver.com',213421,'Bihar','2 Spenser Plaza','830-21-7847','Fielding Risdale','570-75-4785-4683'),(98,'Leeland Blackbrough','Male','2008-07-19','umakin2p@state.tx.us',120392,'Goa','183 Homewood Crossing','778-02-2161','Udell Makin','127-78-4371-4683'),(99,'Ronni Yaneev','Female','2010-08-09','bfrizzell2q@freewebs.com',220012,'Delhi','19 Armistice Alley','460-58-9105','Beverie Frizzell','680-74-0975-4683'),(100,'Ruthi Woodruffe','Female','2010-08-11','egiggs2r@ow.ly',443929,'Punjab','5 Monterey Road','575-79-7564','Elita Giggs','896-75-2791-4683'),(101,'Horatio Allibone','Male','2008-09-07','tlacaze2s@about.com',211231,'U.p','1 Sherman Hill','620-81-0627','Tynan Lacaze','792-76-0016-4683'),(102,'Shannah Haythorne','Female','2011-01-27','jcowley2t@prlog.org',323213,'Bihar','091 Longview Street','305-46-9200','Jorrie Cowley','188-38-8398-4683'),(103,'Zabrina Henrych','Female','2010-07-22','cerbe2u@home.pl',444632,'Goa','37 Debs Plaza','586-77-5255','Corie Erbe','633-87-9471-4683'),(104,'Ninette Balnaves','Female','2008-10-16','jheinssen2v@123-reg.co.uk',188532,'Delhi','8 Susan Street','304-28-8240','Jennee Heinssen','695-95-4206-4683'),(105,'Ilene Impey','Female','2010-12-12','vchable2w@ezinearticles.com',323234,'U.p','9417 Ruskin Point','112-82-8841','Vitia Chable','434-26-1687-4683'),(106,'Welbie Abella','Male','2011-01-22','gchasmoor2x@shop-pro.jp',222114,'Delhi','10 Delladonna Plaza','388-01-2866','Gabie Chasmoor','100-77-4179-4683'),(107,'Caron Pablo','Female','2011-01-26','iaxelbee2y@squidoo.com',183221,'Bihar','661 Granby Circle','313-19-2858','Ingeborg Axelbee','626-79-5655-4683'),(110,'Vasu Goel','Male','1999-04-06','aaa@ggg.com',110088,NULL,NULL,'9711154348',NULL,NULL),(111,'Vasu Goel','Male','1999-04-06','aaa@ggg.com',110088,NULL,NULL,'9711154348',NULL,NULL),(112,'Vasu Goel','Male','1999-04-06','aaa@ggg.com',110088,NULL,NULL,'9711154348',NULL,NULL),(113,'Sargam','Female','2020-03-16','sargam@mail.com',123123,NULL,NULL,'1321312313',NULL,NULL),(114,'Vasu Goel','Male','1999-06-02','alohanvasu@gmail.com',110088,NULL,NULL,'9711154348',NULL,NULL),(115,'DummyUser','Male','2020-04-04','email@email.com',110055,'Delhi','Somepace','8879879879','','');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`binaryblood`@`localhost`*/ /*!50003 TRIGGER `vaccination_table`.`users_BEFORE_INSERT` BEFORE INSERT ON `users` FOR EACH ROW
BEGIN
	declare msg varchar(128);
    if (Date(new.DOB)>Date(NOW())) then
        set msg = concat('VacciCureError: Trying to insert a date ahead of tomorrow!', cast(new.DOB as char));
        signal sqlstate '45000' set message_text = msg;
    end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`binaryblood`@`localhost`*/ /*!50003 TRIGGER `vaccination_table`.`users_BEFORE_UPDATE` BEFORE UPDATE ON `users` FOR EACH ROW
BEGIN
	declare msg varchar(128);
    if (Date(new.DOB)>Date(NOW())) then
        set msg = concat('VacciCureError: Trying to insert a date ahead of tomorrow!', cast(new.DOB as char));
        signal sqlstate '45000' set message_text = msg;
    end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'vaccination_table'
--

--
-- Dumping routines for database 'vaccination_table'
--
/*!50003 DROP PROCEDURE IF EXISTS `getInfoOnVaccineID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`binaryblood`@`localhost` PROCEDURE `getInfoOnVaccineID`(IN vaccine INT(11))
BEGIN
	SELECT P.state, P.name, S.PublicHealthCentreID, S.Cnt FROM PublicHealthCentre as P, (  
	SELECT PublicHealthCentreID, COUNT(*) as Cnt, VaccineID 
	FROM VaccinationRecords
	WHERE VaccineID=vaccine
	GROUP BY PublicHealthCentreID) AS S
	where P.id=S.PublicHealthCentreID 
	order BY S.CNT desc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `HealthCentrePoints` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`binaryblood`@`localhost` PROCEDURE `HealthCentrePoints`(IN distance int, IN lat double, IN lon double)
BEGIN
	SELECT ST_X(location) as `lat`, ST_Y(location) as `long`, name, id, state FROM vaccination_table.PublicHealthCentre where ST_Distance_Sphere(point(lat, lon), location)/1000 <= distance;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `new_procedure` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`binaryblood`@`localhost` PROCEDURE `new_procedure`(IN distance int, IN lat double, IN lon double)
BEGIN
	SELECT ST_X(location) as `lat`, ST_Y(location) as `long`, name, id, state FROM vaccination_table.PublicHealthCentre where ST_Distance_Sphere(point(lat, lon), location)/1000 <= distance;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `vaccineCountByState` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`binaryblood`@`localhost` PROCEDURE `vaccineCountByState`()
BEGIN
	SELECT P.state as `State Name`, COUNT(*) AS `Number of Vaccines` FROM PublicHealthCentre as P INNER JOIN (  
	SELECT PublicHealthCentreID
	FROM VaccinationRecords) AS S
	ON P.id=S.PublicHealthCentreID 
	GROUP BY P.state
    order by `Number of Vaccines` desc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `CountryWiseRequirements`
--

/*!50001 DROP VIEW IF EXISTS `CountryWiseRequirements`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`binaryblood`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `CountryWiseRequirements` AS select `C`.`CountryName` AS `CountryName`,`C`.`CountryCode` AS `CountryCode`,`D`.`VaccineName` AS `VaccineName`,`D`.`DiseaseName` AS `DiseaseName`,`D`.`SpreadBy` AS `SpreadBy`,`D`.`Complications` AS `Complications` from (`vaccination_table`.`CountryImmunizationRecords` `C` join `vaccination_table`.`DiseaseVaccineMap` `D` on((`D`.`VaccineID` = `C`.`VaccinationID`))) order by `C`.`CountryName` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `DiseaseVaccineMap`
--

/*!50001 DROP VIEW IF EXISTS `DiseaseVaccineMap`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`binaryblood`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `DiseaseVaccineMap` AS select `V`.`VaccineID` AS `VaccineID`,`V`.`purpose` AS `purpose`,`V`.`name` AS `VaccineName`,`V`.`requiredDosages` AS `requiredDosages`,`S`.`ICD10` AS `ICD10`,`S`.`Name` AS `DiseaseName`,`S`.`Symptoms` AS `Symptoms`,`S`.`SpreadBy` AS `SpreadBy`,`S`.`Complications` AS `Complications`,`S`.`VaccinationType` AS `VaccinationType` from (`vaccination_table`.`Vaccinations` `V` join (select `vaccination_table`.`Disease`.`ICD10` AS `ICD10`,`vaccination_table`.`Disease`.`Name` AS `Name`,`vaccination_table`.`Disease`.`Symptoms` AS `Symptoms`,`vaccination_table`.`Disease`.`VaccinationType` AS `VaccinationType`,`vaccination_table`.`Disease`.`SpreadBy` AS `SpreadBy`,`vaccination_table`.`Disease`.`Complications` AS `Complications`,`vaccination_table`.`DiseaseVaccineRelation`.`VaccineID` AS `VaccineID` from (`vaccination_table`.`Disease` left join `vaccination_table`.`DiseaseVaccineRelation` on((`vaccination_table`.`Disease`.`ICD10` = `vaccination_table`.`DiseaseVaccineRelation`.`ICDCode`)))) `S` on((`V`.`VaccineID` = `S`.`VaccineID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-29 14:32:47
