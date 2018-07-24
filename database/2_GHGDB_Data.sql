-- Created by Fred Yang. 2016-10-05

-- GHGDB Data
USE [ghgdb];

INSERT INTO dbo.[User](email, passwd, firstName, lastName, phone, address, joinDate, level)
VALUES('guest@ghgtools.com','698D51A19D8A121CE581499D7B701668','guest','guest','6041234567','515 Ontario St, Vancouver, BC V4X 1A7', GETDATE(), 0);
INSERT INTO dbo.[User](email, passwd, firstName, lastName, phone, address, joinDate, level)
VALUES('admin@ghgtools.com','698D51A19D8A121CE581499D7B701668','admin','admin','6041234569','510 Ontario St, Vancouver, BC V4X 1A6', GETDATE(), 2);
INSERT INTO dbo.[User](email, passwd, firstName, lastName, phone, address, joinDate)
VALUES('test@ghgtools.com','698D51A19D8A121CE581499D7B701668','test','test','6041234568','511 Ontario St, Vancouver, BC V3X 1A2', GETDATE());

INSERT INTO dbo.[Policy](worksheetName, scenarioYear, description)
VALUES('TV-P1','2015','Committed Policies: All policies that are underway');
INSERT INTO dbo.[Policy](worksheetName, scenarioYear, description)
VALUES('TV-P2','2015','Uncommitted Policies: Existing policies and targets lacking detailed implementation or financial plans');
INSERT INTO dbo.[Policy](worksheetName, scenarioYear, description)
VALUES('TV-P3','2015','Potential Policy and Technology Futures: Speculative policies');

INSERT INTO dbo.[Source](sourceId, sourceName) VALUES(1,'Single Family');
INSERT INTO dbo.[Source](sourceId, sourceName) VALUES(2,'Organic');
INSERT INTO dbo.[Source](sourceId, sourceName) VALUES(3,'Non-Organic');
INSERT INTO dbo.[Source](sourceId, sourceName) VALUES(4,'Multi Family');
INSERT INTO dbo.[Source](sourceId, sourceName) VALUES(5,'Commercial(ICI)');
INSERT INTO dbo.[Source](sourceId, sourceName) VALUES(6,'DLC');
INSERT INTO dbo.[Source](sourceId, sourceName) VALUES(7,'Farm');

INSERT INTO dbo.[Destination](destinationId, destinationName, distance) VALUES(1,'Vancouver Landfill',25);
INSERT INTO dbo.[Destination](destinationId, destinationName, distance) VALUES(2,'Cache Creek Landfill',250);
INSERT INTO dbo.[Destination](destinationId, destinationName, distance) VALUES(3,'Burnaby WtE',20);
INSERT INTO dbo.[Destination](destinationId, destinationName, distance) VALUES(4,'Richmond Harvest Power',20);
INSERT INTO dbo.[Destination](destinationId, destinationName, distance) VALUES(5,'New Technology',20);
INSERT INTO dbo.[Destination](destinationId, destinationName, distance) VALUES(6,'Leakage',200);

INSERT INTO dbo.[Composition](compositionId, compositionName) VALUES(1,'Organic');
INSERT INTO dbo.[Composition](compositionId, compositionName) VALUES(2,'Paper');
INSERT INTO dbo.[Composition](compositionId, compositionName) VALUES(3,'Wood');
INSERT INTO dbo.[Composition](compositionId, compositionName) VALUES(4,'Plastic');
INSERT INTO dbo.[Composition](compositionId, compositionName) VALUES(5,'Other');

INSERT INTO dbo.[Vehicle](modelId, model, tonnage, emissionFactor, emissionFactorTonne) 
VALUES(1,'Truck A',5,3.221,0.64);
INSERT INTO dbo.[Vehicle](modelId, model, tonnage, emissionFactor, emissionFactorTonne) 
VALUES(2,'Truck B',10,3.865,0.39);
INSERT INTO dbo.[Vehicle](modelId, model, tonnage, emissionFactor, emissionFactorTonne) 
VALUES(3,'Truck C',15,4.639,0.31);
INSERT INTO dbo.[Vehicle](modelId, model, tonnage, emissionFactor, emissionFactorTonne) 
VALUES(4,'Truck D',20,5.566,0.28);

INSERT INTO dbo.[ElectEmissionFactor](emissionFactor) VALUES(0.0545);
INSERT INTO dbo.[ElectEmissionOption](emissionOption, emissionFactor) VALUES('BCMoF(2012)',0.025);
INSERT INTO dbo.[ElectEmissionOption](emissionOption, emissionFactor) VALUES('Dowlatabadi(2011)',0.084);
INSERT INTO dbo.[ElectEmissionOption](emissionOption, emissionFactor) VALUES('Average',0.0545);

INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(1,1,570);
INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(1,2,570);
INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(1,3,21);
INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(1,4,6);
INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(1,5,6);
INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(1,6,570);

INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(2,1,553);
INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(2,2,553);
INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(2,3,21);
INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(2,4,21);
INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(2,5,21);
INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(2,6,553);

INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(3,1,851);
INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(3,2,851);
INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(3,3,21);
INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(3,4,21);
INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(3,5,21);
INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(3,6,851);

INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(4,1,34);
INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(4,2,34);
INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(4,3,21);
INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(4,4,0.1);
INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(4,5,0.1);
INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(4,6,34);

INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(5,1,290);
INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(5,2,290);
INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(5,3,21);
INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(5,4,12);
INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(5,5,12);
INSERT INTO dbo.[CO2EmissionFactor](compositionId, destinationId, emissionFactor) VALUES(5,6,290);

INSERT INTO dbo.[ElectConRate](destinationId, consumptionRate) VALUES(1,30);
INSERT INTO dbo.[ElectConRate](destinationId, consumptionRate) VALUES(2,30);
INSERT INTO dbo.[ElectConRate](destinationId, consumptionRate) VALUES(3,0);
INSERT INTO dbo.[ElectConRate](destinationId, consumptionRate) VALUES(4,45);
INSERT INTO dbo.[ElectConRate](destinationId, consumptionRate) VALUES(5,45);
INSERT INTO dbo.[ElectConRate](destinationId, consumptionRate) VALUES(6,0);

INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(1,1,1,2015,4073,161);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(1,2,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(1,3,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(1,4,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(1,5,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(1,6,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(2,1,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(2,2,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(2,3,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(2,4,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(2,5,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(2,6,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(3,1,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(3,2,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(3,3,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(3,4,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(3,5,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(3,6,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(4,1,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(4,2,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(4,3,1,2015,168,103);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(4,4,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(4,5,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(4,6,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(5,1,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(5,2,1,2015,2028,805);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(5,3,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(5,4,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(5,5,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(5,6,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(6,1,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(6,2,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(6,3,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(6,4,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(6,5,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(6,6,1,2015,2392,515);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(7,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(7,2,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(7,3,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(7,4,1,2015,17,26);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(7,5,1,2015,0,0);
INSERT INTO dbo.[SourceByDest](sourceId, destinationId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(7,6,1,2015,0,0);

INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(1,1,1,2015,3135,89);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(1,2,1,2015,553,16);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(1,3,1,2015,170,3);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(1,4,1,2015,99,47);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(1,5,1,2015,116,6);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(2,1,1,2015,0,0);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(2,2,1,2015,0,0);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(2,3,1,2015,0,0);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(2,4,1,2015,0,0);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(2,5,1,2015,0,0);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(3,1,1,2015,0,0);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(3,2,1,2015,0,0);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(3,3,1,2015,0,0);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(3,4,1,2015,0,0);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(3,5,1,2015,0,0);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(4,1,1,2015,92,57);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(4,2,1,2015,17,10);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(4,3,1,2015,3,2);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(4,4,1,2015,49,30);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(4,5,1,2015,7,4);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(5,1,1,2015,1283,362);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(5,2,1,2015,553,161);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(5,3,1,2015,85,16);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(5,4,1,2015,49,234);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(5,5,1,2015,58,32);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(6,1,1,2015,114,26);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(6,2,1,2015,221,52);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(6,3,1,2015,1702,258);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(6,4,1,2015,7,26);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(6,5,1,2015,348,155);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(7,1,1,2015,10,21);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(7,2,1,2015,1,1);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(7,3,1,2015,6,4);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(7,4,1,2015,0,1);
INSERT INTO dbo.[SourceByComp](sourceId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(7,5,1,2015,0,1);

INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(1,1,1,2015,3135,89);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(1,2,1,2015,553,16);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(1,3,1,2015,170,3);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(1,4,1,2015,99,47);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(1,5,1,2015,116,6);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(2,1,1,2015,1283,362);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(2,2,1,2015,553,161);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(2,3,1,2015,85,16);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(2,4,1,2015,49,234);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(2,5,1,2015,58,32);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(3,1,1,2015,92,57);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(3,2,1,2015,17,10);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(3,3,1,2015,3,2);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(3,4,1,2015,49,30);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(3,5,1,2015,7,4);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(4,1,1,2015,10,21);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(4,2,1,2015,1,1);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(4,3,1,2015,6,4);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(4,4,1,2015,0,1);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(4,5,1,2015,0,1);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(5,1,1,2015,0,0);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(5,2,1,2015,0,0);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(5,3,1,2015,0,0);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(5,4,1,2015,0,0);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(5,5,1,2015,0,0);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(6,1,1,2015,114,26);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(6,2,1,2015,221,52);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(6,3,1,2015,1702,258);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(6,4,1,2015,7,26);
INSERT INTO dbo.[DestByComp](destinationId, compositionId, historyId, scenarioYear, tonnageWT, tonnageTO)
VALUES(6,5,1,2015,348,155);

INSERT INTO dbo.[DestinationWaste](destinationId, historyId, scenarioYear, waste, transportation, electricity)
VALUES(1,1,2015,4073,161,16);
INSERT INTO dbo.[DestinationWaste](destinationId, historyId, scenarioYear, waste, transportation, electricity)
VALUES(2,1,2015,2028,805,8);
INSERT INTO dbo.[DestinationWaste](destinationId, historyId, scenarioYear, waste, transportation, electricity)
VALUES(3,1,2015,168,103,0);
INSERT INTO dbo.[DestinationWaste](destinationId, historyId, scenarioYear, waste, transportation, electricity)
VALUES(4,1,2015,17,26,5);
INSERT INTO dbo.[DestinationWaste](destinationId, historyId, scenarioYear, waste, transportation, electricity)
VALUES(5,1,2015,0,0,0);
INSERT INTO dbo.[DestinationWaste](destinationId, historyId, scenarioYear, waste, transportation, electricity)
VALUES(6,1,2015,2392,515,0);

INSERT INTO dbo.[NormalizedEmission](sourceId, scenarioYear, tonnageWT, tonnageTO)
VALUES(1,2015,407,16);
INSERT INTO dbo.[NormalizedEmission](sourceId, scenarioYear, tonnageWT, tonnageTO)
VALUES(2,2015,0,0);
INSERT INTO dbo.[NormalizedEmission](sourceId, scenarioYear, tonnageWT, tonnageTO)
VALUES(3,2015,0,0);
INSERT INTO dbo.[NormalizedEmission](sourceId, scenarioYear, tonnageWT, tonnageTO)
VALUES(4,2015,21,13);
INSERT INTO dbo.[NormalizedEmission](sourceId, scenarioYear, tonnageWT, tonnageTO)
VALUES(5,2015,406,161);
INSERT INTO dbo.[NormalizedEmission](sourceId, scenarioYear, tonnageWT, tonnageTO)
VALUES(6,2015,598,129);
INSERT INTO dbo.[NormalizedEmission](sourceId, scenarioYear, tonnageWT, tonnageTO)
VALUES(7,2015,8,13);

INSERT INTO dbo.[History](HistoryName, userId, createDate)
VALUES('pietest01',2,GETDATE());
/*INSERT INTO dbo.[History](HistoryName, userId, createDate)
VALUES('pietest02',2,GETDATE());*/

