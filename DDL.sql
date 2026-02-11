USE BUDT703_Project_0506_13; 
GO 
 
-- Drop table queries
DROP TABLE IF EXISTS Team13.StationCrime; 
DROP TABLE IF EXISTS Team13.StationLine; 
DROP TABLE IF EXISTS Team13.ReportedCrime; 
DROP TABLE IF EXISTS Team13.ServiceIncident; 
DROP TABLE IF EXISTS Team13.OnTimePerformance; 
DROP TABLE IF EXISTS Team13.SystemRidership; 
DROP TABLE IF EXISTS Team13.StationSnapshot; 
DROP TABLE IF EXISTS Team13.CrimeCategory; 
DROP TABLE IF EXISTS Team13.TransitLine; 
DROP TABLE IF EXISTS Team13.MetroStation; 
DROP TABLE IF EXISTS Team13.TimelineReference; 
GO 
 
-- Creating Tables for Schema 
CREATE TABLE Team13.TimelineReference( 
 dateId CHAR(8) PRIMARY KEY, 
 year INT NOT NULL, 
 month INT NOT NULL, 
 periodType VARCHAR(20) NOT NULL 
); 
GO 
 
CREATE TABLE Team13.MetroStation( 
 stationId CHAR(8) PRIMARY KEY, 
 stationCode VARCHAR(10) NOT NULL, 
 stationName VARCHAR(100) NOT NULL 
); 
GO 
 
CREATE TABLE Team13.TransitLine( 
 lineId CHAR(10) PRIMARY KEY, 
 lineCode VARCHAR(10) NOT NULL, 
 lineName VARCHAR(50) NOT NULL, 
 mode VARCHAR(20) NOT NULL 
); 
GO 
 
CREATE TABLE Team13.CrimeCategory( 
 crimeTypeId CHAR(8) PRIMARY KEY, 
 crimeTypeCode VARCHAR(10) NOT NULL, 
 crimeTypeName VARCHAR(100) NOT NULL 
); 
GO 
  
CREATE TABLE Team13.StationSnapshot( 
 snapshotId CHAR(10) PRIMARY KEY, 
 dateId CHAR(8) NOT NULL REFERENCES Team13.TimelineReference(dateId), 
 stationId CHAR(8) NOT NULL REFERENCES Team13.MetroStation(stationId), 
 avgWeekdayBoardings INT, 
 totalEntries INT, 
 totalExits INT 
); 
GO  
 
CREATE TABLE Team13.SystemRidership( 
 ridershipId CHAR(10) PRIMARY KEY, 
 dateId CHAR(8) NOT NULL REFERENCES Team13.TimelineReference(dateId), 
 mode VARCHAR(20), 
 avgWeekdayRidership INT, 
 totalRidership INT 
); 
GO 
 
CREATE TABLE Team13.OnTimePerformance( 
 onTimeId CHAR(10) PRIMARY KEY, 
 dateId CHAR(8) NOT NULL REFERENCES Team13.TimelineReference(dateId), 
 lineId CHAR(10) NOT NULL REFERENCES Team13.TransitLine(lineId), 
 scheduledTrips INT, 
 onTimeTrips INT, 
 onTimePct FLOAT, 
 canceledTrips INT 
); 
GO 
 
CREATE TABLE Team13.ServiceIncident( 
 incidentId CHAR(10) PRIMARY KEY, 
 dateId CHAR(8) NOT NULL REFERENCES Team13.TimelineReference(dateId), 
 lineId CHAR(10) NOT NULL REFERENCES Team13.TransitLine(lineId), 
 stationId CHAR(8) NULL REFERENCES Team13.MetroStation(stationId), 
 incidentCount INT, 
 primaryCause VARCHAR(100) 
); 
GO 
 
 CREATE TABLE Team13.ReportedCrime( 
 crimeId CHAR(10) PRIMARY KEY, 
 dateId CHAR(8) NOT NULL REFERENCES Team13.TimelineReference(dateId), 
 stationId CHAR(8) NULL REFERENCES Team13.MetroStation(stationId), 
 crimeTypeId CHAR(8) NOT NULL REFERENCES Team13.CrimeCategory(crimeTypeId), 
 incidentCount INT, 
 arrestMadeFlag BIT 
); 
GO 
 
CREATE TABLE Team13.StationLine( 
 stationLineId CHAR(10) PRIMARY KEY, 
 stationId CHAR(8) NOT NULL REFERENCES Team13.MetroStation(stationId), 
 lineId CHAR(10) NOT NULL REFERENCES Team13.TransitLine(lineId), 
 openedYear INT 
); 
GO 
 
CREATE TABLE Team13.StationCrime( 
 stationCrimeId CHAR(10) PRIMARY KEY, 
 stationId CHAR(8) NOT NULL REFERENCES Team13.MetroStation(stationId), 
 crimeTypeId CHAR(8) NOT NULL REFERENCES Team13.CrimeCategory(crimeTypeId), 
 reportedYear INT, 
 incidentCount INT 
); 
GO 
 
--Inserting Data Into Tables 
INSERT INTO Team13.TransitLine (lineId, lineCode, lineName, mode) VALUES 
('L01','RD','Red Line','Metrorail'), 
('L02','BL','Blue Line','Metrorail'), 
('L03','OR','Orange Line','Metrorail'), 
('L04','SV','Silver Line','Metrorail'), 
('L05','GR','Green Line','Metrorail'), 
('L06','YL','Yellow Line','Metrorail'), 
('L07','BUS','Metrobus Systemwide','Metrobus'), 
('L08','ACC','MetroAccess Service','MetroAccess'); 
GO 
 
-- CrimeCategory 
INSERT INTO Team13.CrimeCategory (crimeTypeId, crimeTypeCode, crimeTypeName) VALUES 
('CR01','AA','Aggravated Assault'), 
('CR02','AR','Arson'), 
('CR03','AMT','Attempt Motor Vehicle Theft'), 
('CR04','BG','Burglary'), 
('CR05','HMTPD','Homicide - MTPD'), 
('CR06','HOTH','Homicide - Other Agencies'), 
('CR07','LR','Larceny'), 
('CR08','LSP','Larceny (Snatch/Pickpocket)'), 
('CR09','MVT','Motor Vehicle Theft'), 
('CR10','RP','Rape'), 
('CR11','RB','Robbery'), 
('CR12','AO','All Other Offenses'), 
('CR13','DV','Destruction/Vandalism'), 
('CR14','DC','Disorderly Conduct'), 
('CR15','DR','Drug/Narcotic Offenses'), 
('CR16','FE','Fare Evasion'), 
('CR17','FD','Fondling'), 
('CR18','IE','Indecent Exposure'), 
('CR19','LL','Liquor Law Violations'), 
('CR20','PH','Panhandling Offenses'), 
('CR21','SA','Simple Assault'), 
('CR22','SP','Stolen Property Offenses'), 
('CR23','TR','Trespass of Real Property'), 
('CR24','WL','Weapon Law Violations'); 
GO 
 
-- MetroStation (Red Line example) 
INSERT INTO Team13.MetroStation (stationId, stationCode, stationName) VALUES 
('ST01','A15','Shady Grove'), 
('ST02','A14','Rockville'), 
('ST03','A13','Twinbrook'), 
('ST04','A12','White Flint'), 
('ST05','A11','Grosvenor-Strathmore'), 
('ST06','A10','Medical Center'), 
('ST07','A09','Bethesda'), 
('ST08','A08','Friendship Heights'), 
('ST09','A07','Tenleytown-AU'), 
('ST10','A06','Van Ness-UDC'), 
('ST11','A05','Cleveland Park'), 
('ST12','A04','Woodley Park-Zoo/Adams Morgan'), 
('ST13','Q01','Dupont Circle'), 
('ST14','A02','Farragut North'), 
('ST15','A01','Metro Center'), 
('ST16','B01','Gallery Pl-Chinatown'), 
('ST17','B02','Judiciary Square'), 
('ST18','B03','Union Station'), 
('ST19','B04','Rhode Island Ave-Brentwood'), 
('ST20','B05','Brookland-CUA'), 
('ST21','B06','Fort Totten'), 
('ST22','B07','Takoma'), 
('ST23','B08','Silver Spring'), 
('ST24','B09','Forest Glen'), 
('ST25','B10','Wheaton'), 
('ST26','B11','Glenmont'); 
GO 
 
--TimelineReference 
INSERT INTO Team13.TimelineReference (dateId, year, month, periodType) VALUES 
('201501',2015,1,'Month'), 
('201502',2015,2,'Month'), 
('201503',2015,3,'Month'), 
('202101',2021,1,'Month'), 
('202102',2021,2,'Month'), 
('202103',2021,3,'Month'), 
('202501',2025,1,'Month'), 
('202502',2025,2,'Month'), 
('202503',2025,3,'Month'); 
GO 
 
-- StationSnapshot 
INSERT INTO Team13.StationSnapshot (snapshotId, dateId, stationId, avgWeekdayBoardings, totalEntries, totalExits) VALUES 
('SS01','201501','ST13',17132,17132,17132), 
('SS02','201501','ST14',23125,23125,23125), 
('SS03','201501','ST15',25429,25429,25429), 
('SS04','201501','ST16',22229,22229,22229), 
('SS05','201501','ST17',7523,7523,7523), 
('SS06','201501','ST18',28634,28634,28634), 
('SS07','201501','ST19',5383,5383,5383), 
('SS08','201501','ST20',5783,5783,5783), 
('SS09','201501','ST21',8297,8297,8297); 
GO 
 
-- SystemRidership 
INSERT INTO Team13.SystemRidership (ridershipId, dateId, mode, avgWeekdayRidership, totalRidership) VALUES 
('SR01','201501','Metrorail',420000,420000), 
('SR02','201501','Metrobus',290000,290000), 
('SR03','201501','MetroAccess',30000,30000), 
('SR04','201502','Metrorail',440000,440000), 
('SR05','201502','Metrobus',310000,310000), 
('SR06','201502','MetroAccess',32000,32000), 
('SR07','201503','Metrorail',460000,460000), 
('SR08','201503','Metrobus',330000,330000), 
('SR09','201503','MetroAccess',34000,34000); 
GO 
 
-- OnTimePerformance 
INSERT INTO Team13.OnTimePerformance (onTimeId, dateId, lineId, scheduledTrips, onTimeTrips, onTimePct, canceledTrips) VALUES 
('OT01','201501','L01',12500,11125,88.9,240), 
('OT02','201501','L02',8300,7369,88.7,170), 
('OT03','201501','L03',8700,7809,89.8,160), 
('OT04','201501','L04',6900,6258,90.7,140), 
('OT05','201501','L05',7100,6451,90.8,135), 
('OT06','201501','L06',6800,6048,89.0,150); 
GO 
 
-- ServiceIncident 
INSERT INTO Team13.ServiceIncident (incidentId, dateId, lineId, stationId, incidentCount, primaryCause) VALUES 
('IN01','201501','L01',NULL,215,'Track Maintenance'), 
('IN02','201501','L02',NULL,132,'Mechanical Failure'), 
('IN03','201501','L03',NULL,148,'Signal Malfunction'), 
('IN04','201501','L04',NULL,117,'Equipment Issue'), 
('IN05','201501','L05',NULL,126,'Operator Delay'), 
('IN06','201501','L06',NULL,112,'Police Activity'); 
GO 
 
-- ReportedCrime 
INSERT INTO Team13.ReportedCrime (crimeId, dateId, stationId, crimeTypeId, incidentCount, arrestMadeFlag) VALUES 
('RC01','201501','ST16','CR07',12,1), 
('RC02','201501','ST15','CR21',5,0), 
('RC03','201501','ST18','CR11',2,1), 
('RC04','201501','ST13','CR09',1,0), 
('RC05','201501','ST14','CR01',1,0), 
('RC06','201501','ST17','CR02',0,0), 
('RC07','201501','ST19','CR24',1,1); 
GO 
 
-- StationLine 
INSERT INTO Team13.StationLine (stationLineId, stationId, lineId, openedYear) VALUES 
('SL01','ST01','L01',NULL), 
('SL02','ST02','L01',NULL), 
('SL03','ST03','L01',NULL), 
('SL04','ST04','L01',NULL), 
('SL05','ST05','L01',NULL), 
('SL06','ST06','L01',NULL), 
('SL07','ST07','L01',NULL), 
('SL08','ST08','L01',NULL), 
('SL09','ST09','L01',NULL), 
('SL10','ST10','L01',NULL), 
('SL11','ST11','L01',NULL), 
('SL12','ST12','L01',NULL), 
('SL13','ST13','L01',NULL), 
('SL14','ST14','L01',NULL), 
('SL15','ST15','L01',NULL), 
('SL16','ST16','L01',NULL), 
('SL17','ST17','L01',NULL), 
('SL18','ST18','L01',NULL), 
('SL19','ST19','L01',NULL), 
('SL20','ST20','L01',NULL), 
('SL21','ST21','L01',NULL), 
('SL22','ST22','L01',NULL), 
('SL23','ST23','L01',NULL), 
('SL24','ST24','L01',NULL), 
('SL25','ST25','L01',NULL), 
('SL26','ST26','L01',NULL); 
GO 
 
-- StationCrime 
INSERT INTO Team13.StationCrime (stationCrimeId, stationId, crimeTypeId, reportedYear, incidentCount) VALUES 
('SC01','ST16','CR07',2015,12), 
('SC02','ST15','CR21',2015,5), 
('SC03','ST18','CR11',2015,2), 
('SC04','ST13','CR09',2015,1), 
('SC05','ST14','CR01',2015,1), 
('SC06','ST17','CR02',2015,0), 
('SC07','ST19','CR24',2015,1); 
GO 
--Views for Schemas  
-- TimelineReference – quarter 
DROP VIEW IF EXISTS Team13.vw_TimelineQuarter; 
GO 
CREATE VIEW Team13.vw_TimelineQuarter AS 
SELECT dateId, year, month, (month + 2) / 3 AS quarter, periodType 
FROM Team13.TimelineReference; 
GO   

SELECT * FROM Team13.vw_TimelineQuarter; 

--  TimelineReference – periodEndDate 
DROP VIEW IF EXISTS Team13.vw_TimelinePeriodEnd; 
GO 
CREATE VIEW Team13.vw_TimelinePeriodEnd AS 
SELECT dateId, year, month, periodType, 
EOMONTH(CAST(CONCAT(year,'-',month,'-01') AS DATE)) AS periodEndDate 
FROM Team13.TimelineReference; 
GO 

SELECT * FROM Team13.vw_TimelinePeriodEnd; 
 

--  StationSnapshot – pctChangeYoY 
DROP VIEW IF EXISTS Team13.vw_StationPctChangeYoY; 
GO 
CREATE VIEW Team13.vw_StationPctChangeYoY AS 
SELECT S.stationId, S.dateId, S.avgWeekdayBoardings, 
  LAG(S.avgWeekdayBoardings, 12) OVER (PARTITION BY S.stationId ORDER BY S.dateId) AS prevYearBoardings, 
  ROUND( 
	100.0 * (S.avgWeekdayBoardings - 
             LAG(S.avgWeekdayBoardings, 12) OVER (PARTITION BY S.stationId ORDER BY S.dateId)) 
	/ NULLIF(LAG(S.avgWeekdayBoardings, 12) OVER (PARTITION BY S.stationId ORDER BY S.dateId), 0),2 ) AS pctChangeYoY 
FROM Team13.StationSnapshot S; 
GO 

SELECT * FROM Team13.vw_StationPctChangeYoY; 

  
--  SystemRidership – percentChangePrevMonth 
DROP VIEW IF EXISTS Team13.vw_RidershipChange; 
GO 
CREATE VIEW Team13.vw_RidershipChange AS 
SELECT R.mode, R.dateId, 
  R.totalRidership, 
  LAG(R.totalRidership) OVER (PARTITION BY R.mode ORDER BY R.dateId) AS prevMonthRidership, 
  ROUND( 
	100.0 * (R.totalRidership - 
         	LAG(R.totalRidership) OVER (PARTITION BY R.mode ORDER BY R.dateId)) 
	/ NULLIF(LAG(R.totalRidership) OVER (PARTITION BY R.mode ORDER BY R.dateId), 0), 
	2 
  ) AS percentChangePrevMonth 
FROM Team13.SystemRidership R; 
GO 
 
SELECT * FROM Team13.vw_RidershipChange; 
  
-- OnTimePerformance – onTimePct 
DROP VIEW IF EXISTS Team13.vw_OnTimePerformanceCalc; 
GO 
CREATE VIEW Team13.vw_OnTimePerformanceCalc AS 
SELECT 
  onTimeId, 
  dateId, 
  lineId, 
  scheduledTrips, 
  onTimeTrips, 
  ROUND(100.0 * onTimeTrips / NULLIF(scheduledTrips, 0), 2) AS onTimePct 
FROM Team13.OnTimePerformance; 
GO 
 
SELECT * FROM Team13.vw_OnTimePerformanceCalc; 

-- StationCrime – avgMonthlyIncidents (derived from total per year) 
DROP VIEW IF EXISTS Team13.vw_StationCrimeMonthly; 
GO 
CREATE VIEW Team13.vw_StationCrimeMonthly AS 
SELECT 
  stationCrimeId, 
  stationId, 
  crimeTypeId, 
  reportedYear, 
  incidentCount, 
  ROUND(incidentCount / 12.0, 2) AS avgMonthlyIncidents 
FROM Team13.StationCrime; 
GO 
 
SELECT * FROM Team13.vw_StationCrimeMonthly; 

-- ReportedCrime – crimeRatePerMillion (join to SystemRidership for the month) 
DROP VIEW IF EXISTS Team13.vw_CrimeRatePerMillion; 
GO 
CREATE VIEW Team13.vw_CrimeRatePerMillion AS 
SELECT 
  C.crimeId, 
  C.dateId, 
  C.stationId, 
  C.crimeTypeId, 
  C.incidentCount, 
  ROUND(1000000.0 * C.incidentCount / NULLIF(R.totalRidership, 0), 2) AS crimeRatePerMillion 
FROM Team13.ReportedCrime C 
JOIN Team13.SystemRidership R 
  ON C.dateId = R.dateId 
AND R.mode = 'Metrorail'; 
GO 

SELECT * FROM Team13.vw_CrimeRatePerMillion; 
 


