-- Created by Fred Yang. 2016-10-05

-- GHG Schema
USE [ghgdb];

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Scenario')
    DROP TABLE dbo.[Scenario];
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'SourceByDest')
    DROP TABLE dbo.[SourceByDest];
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'SourceByComp')
    DROP TABLE dbo.[SourceByComp];
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'DestByComp')
    DROP TABLE dbo.[DestByComp];
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'CO2EmissionFactor')
    DROP TABLE dbo.[CO2EmissionFactor];
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'ElectConRate')
    DROP TABLE dbo.[ElectConRate];
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'ElectEmissionFactor')
    DROP TABLE dbo.[ElectEmissionFactor];
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'ElectEmissionOption')
    DROP TABLE dbo.[ElectEmissionOption];
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Source')
    DROP TABLE dbo.[Source];
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Destination')
    DROP TABLE dbo.[Destination];
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Composition')
    DROP TABLE dbo.[Composition];
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Vehicle')
    DROP TABLE dbo.[Vehicle];
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'User')
    DROP TABLE dbo.[User];
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Policy')
    DROP TABLE dbo.[Policy];
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Contact')
    DROP TABLE dbo.[Contact];
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'DestinationWaste')
    DROP TABLE dbo.[DestinationWaste];
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'NormalizedEmission')
    DROP TABLE dbo.[NormalizedEmission];
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'History')
    DROP TABLE dbo.[History];

/* User table. Lists the registered customers */
CREATE TABLE dbo.[User] (
    userId      INT         NOT NULL    IDENTITY(1,1),
    email       VARCHAR(30) NOT NULL,
    passwd      VARCHAR(32) NOT NULL,
    firstName   VARCHAR(30) NOT NULL,
    lastName    VARCHAR(30) NOT NULL,
    phone       VARCHAR(15),
    address     VARCHAR(70),
    joinDate    DATETIME,
    level       TINYINT     DEFAULT 1,
    isValid     BIT         DEFAULT 1,
    PRIMARY KEY (userId)
);

/* Policy table. Lists all policies defined by customers */
CREATE TABLE dbo.[Policy] (
    policyNumber    INT         NOT NULL    IDENTITY(1,1),
    worksheetName   VARCHAR(30) NOT NULL,
    scenarioYear    CHAR(4)     NOT NULL,
    description     TEXT,
    isRun           BIT         DEFAULT 1,
    errorCheck      BIT         DEFAULT 0,
    PRIMARY KEY (policyNumber)
);

/* Source table. Lists waste generating sources for GHG */
CREATE TABLE dbo.[Source] (
    sourceId    TINYINT     NOT NULL,
    sourceName  VARCHAR(30) NOT NULL,
    deleted     BIT         DEFAULT 0,
    PRIMARY KEY (sourceId)
);

/* Destination table. Lists all waste treatment facilities for GHG */
CREATE TABLE dbo.[Destination] (
    destinationId       TINYINT     NOT NULL,
    destinationName     VARCHAR(30) NOT NULL,
    distance            INT,
    deleted             BIT         DEFAULT 0,
    PRIMARY KEY (destinationId)
);

/* Composition table. Shows waste composition types for GHG */
CREATE TABLE dbo.[Composition] (
    compositionId   TINYINT NOT NULL,
    compositionName VARCHAR(30) NOT NULL,
    deleted         BIT         DEFAULT 0,
    PRIMARY KEY (compositionId)
);

/* Vehicle table. Vehicles used to transport waste from 
   the source to a facility */
CREATE TABLE dbo.[Vehicle] (
    modelId TINYINT     NOT NULL,
    model               VARCHAR(10) NOT NULL,
    tonnage             INT         NOT NULL,
    emissionFactor      DECIMAL(5,3),
    emissionFactorTonne DECIMAL(3,2),
    PRIMARY KEY (modelId)
);

/* ElectEmissionFactor table. Electricity emission factor (kgCO2e/kWHr) */
CREATE TABLE dbo.[ElectEmissionFactor] (
    emissionFactor  DECIMAL(5,4)
);

/* ElectEmissionOption table. – Electricity emission factors
   per Options (BCMoF, Dowlatabadi, Average) */
CREATE TABLE dbo.[ElectEmissionOption] (
    emissionOption  VARCHAR(30) NOT NULL,
    emissionFactor  DECIMAL(5,4),
    PRIMARY KEY (emissionOption)
);

/* Scenario table. User’s preference set based on policies */
CREATE TABLE dbo.[Scenario] (
    scenarioId      INT    NOT NULL    IDENTITY(1,1),
    userId          INT    NOT NULL,
    policyNumber    INT    NOT NULL,
    PRIMARY KEY (scenarioId),
    FOREIGN KEY (userId) REFERENCES dbo.[User](userId) ON DELETE CASCADE,
    FOREIGN KEY (policyNumber) REFERENCES dbo.[Policy](policyNumber) ON DELETE CASCADE
);

/* CO2EmissionFactor table. Destination CO2e emission factors
   (kg CO2/tonne) per Composition */
CREATE TABLE dbo.[CO2EmissionFactor] (
    compositionId    TINYINT    NOT NULL,
    destinationId    TINYINT    NOT NULL,
    emissionFactor   DECIMAL(6,1),
    FOREIGN KEY (compositionId) REFERENCES dbo.[Composition](compositionId) ON DELETE CASCADE,
    FOREIGN KEY (destinationId) REFERENCES dbo.[Destination](destinationId) ON DELETE CASCADE
);

/* ElectConRate table. Facility electricity consumption rate (kWHr/tonne) */
CREATE TABLE dbo.[ElectConRate] (
    destinationId    TINYINT    NOT NULL,
    consumptionRate  INT,
    FOREIGN KEY (destinationId) REFERENCES dbo.[Destination](destinationId) ON DELETE CASCADE
);

/* SourceByDest table. Source CO2 emissions per destination */
CREATE TABLE dbo.[SourceByDest] (
    sourceId        TINYINT    NOT NULL,
    destinationId   TINYINT    NOT NULL,
	historyId		INT		   NOT NULL,
    scenarioYear    CHAR(4)    NOT NULL,
    tonnageWT       INT        NOT NULL,
    tonnageTO       INT        NOT NULL,
    FOREIGN KEY (sourceId) REFERENCES dbo.[Source](sourceId) ON DELETE CASCADE,
    FOREIGN KEY (destinationId) REFERENCES dbo.[Destination](destinationId) ON DELETE CASCADE,
	FOREIGN KEY (historyId) REFERENCES dbo.[History](historyId) ON DELETE CASCADE
);

/* SourceByComp table. Source CO2 emissions per Composition*/
CREATE TABLE dbo.[SourceByComp] (
    sourceId         TINYINT    NOT NULL,
    compositionId    TINYINT    NOT NULL,
	historyId		 INT		NOT NULL,
    scenarioYear     CHAR(4)    NOT NULL,
    tonnageWT        INT        NOT NULL,
    tonnageTO        INT        NOT NULL,
    FOREIGN KEY (sourceId) REFERENCES dbo.[Source](sourceId) ON DELETE CASCADE,
    FOREIGN KEY (compositionId) REFERENCES dbo.[Composition](compositionId) ON DELETE CASCADE,
	FOREIGN KEY (historyId) REFERENCES dbo.[History](historyId) ON DELETE CASCADE
);

/* DestByComp table. Destination CO2 emissions per Composition */
CREATE TABLE dbo.[DestByComp] (
    destinationId    TINYINT    NOT NULL,
    compositionId    TINYINT    NOT NULL,
	historyId		 INT		NOT NULL,
    scenarioYear     CHAR(4)    NOT NULL,
    tonnageWT        INT        NOT NULL,
    tonnageTO        INT        NOT NULL,
    FOREIGN KEY (destinationId) REFERENCES dbo.[Destination](destinationId) ON DELETE CASCADE,
    FOREIGN KEY (compositionId) REFERENCES dbo.[Composition](compositionId) ON DELETE CASCADE,
	FOREIGN KEY (historyId) REFERENCES dbo.[History](historyId) ON DELETE CASCADE
);

/* DestinationWaste table.*/
CREATE TABLE dbo.[DestinationWaste] (
    destinationId    TINYINT    NOT NULL,
	historyId		 INT		NOT NULL,
    scenarioYear     CHAR(4)    NOT NULL,
    waste        	 INT,
    transportation   INT,
	electricity      INT,
    FOREIGN KEY (destinationId) REFERENCES dbo.[Destination](destinationId) ON DELETE CASCADE,
	FOREIGN KEY (historyId) REFERENCES dbo.[History](historyId) ON DELETE CASCADE
);

/* NormalizedEmission */
CREATE TABLE dbo.[NormalizedEmission] (
	sourceId		TINYINT		NOT NULL,
	scenarioYear    CHAR(4)     NOT NULL,
	tonnageWT		INT			NOT NULL,
	tonnageTO		INT			NOT NULL,
	FOREIGN KEY (sourceId) REFERENCES dbo.[Source](sourceId) ON DELETE CASCADE
);

/* History */
CREATE TABLE dbo.[History] (
	historyId	INT			NOT NULL  IDENTITY(1,1),
	historyName	VARCHAR(30)	NOT NULL,
	userId		INT			NOT NULL,
	createDate	DATETIME,
	PRIMARY KEY (historyId),
	FOREIGN KEY (userId) REFERENCES dbo.[User](userId) ON DELETE CASCADE
);

/*Contact table, stores users contact info*/
CREATE TABLE dbo.[Contact] (
	contactId 	INT			NOT NULL  IDENTITY(1,1), 
	contactName VARCHAR(30)	NOT NULL,
	email		VARCHAR(30)	NOT NULL,
	subject 	VARCHAR(50)	NOT NULL,
	message		TEXT		NOT NULL,
	contactDate DATETIME	DEFAULT GETDATE(), 
	isReplied 	BIT			DEFAULT 1,
	PRIMARY KEY (contactId)
);

/*
ALTER TABLE dbo.[Source] ADD deleted BIT NULL DEFAULT(0);
ALTER TABLE dbo.[Destination] ADD deleted BIT NULL DEFAULT(0);
ALTER TABLE dbo.[Composition] ADD deleted BIT NULL DEFAULT(0);
UPDATE dbo.[Source] SET deleted = 0;
UPDATE dbo.[Destination] SET deleted = 0;
UPDATE dbo.[Composition] SET deleted = 0;*/

