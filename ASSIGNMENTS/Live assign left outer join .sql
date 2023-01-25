USE DATABASE DEMO_DATABASE2;

CREATE OR REPLACE TABLE AS_COMPLAIN
(
 ID	INT ,
 ComplainDate VARCHAR(10),
 CompletionDate	VARCHAR(10),
 CustomerID	INT,
 BrokerID	INT,
 ProductID	INT,
 ComplainPriorityID	INT,
 ComplainTypeID	INT,
 ComplainSourceID	INT,
 ComplainCategoryID	INT,
 ComplainStatusID	INT,
 AdministratorID	STRING,
 ClientSatisfaction	VARCHAR(20),
 ExpectedReimbursement INT
);

select * from AS_COMPLAIN;

select distinct * from AS_COMPLAIN; --13,846
---------------------------------------------------------------------------------------------------------


CREATE OR REPLACE TABLE AS_CUSTOMER
(
CustomerID	INT,
LastName VARCHAR(60),
FirstName VARCHAR(60),
BirthDate VARCHAR(20) ,
Gender VARCHAR(20),
ParticipantType	VARCHAR(20),
RegionID	INT,
MaritalStatus VARCHAR(30));

select distinct * from as_customer;--12,305
---------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE AS_BROKER
(
  BrokerID	INT,
  BrokerCode VARCHAR(70),
  BrokerFullName	VARCHAR(60),
  DistributionNetwork	VARCHAR(60),
  DistributionChannel	VARCHAR(60),
  CommissionScheme VARCHAR(50)

);

select * from AS_BROKER; --707
---------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE AS_CATAGORIES
(
ID	INT,
Description_Categories VARCHAR2(200),
Active INT
);

select * from AS_CATAGORIES; --56 rows
---------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TABLE AS_PRIORITIES
(
ID	INT,
Description_Priorities VARCHAR(10)
);

select * from AS_PRIORITIES; --2 rows
---------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE AS_PRODUCT
(
ProductID	INT,
ProductCategory	VARCHAR(60),
ProductSubCategory	VARCHAR(60),
Product VARCHAR(30)
);

select distinct * from AS_PRODUCT; -- 77rows
---------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE AS_REGION
(
  id INT,
  name	VARCHAR(50) ,
  county	VARCHAR(100),
  state_code	CHAR(5),
  state	VARCHAR (60),
  type	VARCHAR(50),
  latitude	NUMBER(11,4),
  longitude	NUMBER(11,4),
  area_code	INT,
  population	INT,
  Households	INT,
  median_income	INT,
  land_area	INT,
  water_area	INT,
  time_zone VARCHAR(70)
);

select distinct * from AS_REGION; --994 ROWS
---------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE AS_SOURCES
(
ID	INT,
Description_Source VARCHAR(20)
);

select distinct * from AS_SOURCES; -- 9 rows
---------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE AS_STATE_REGION
(
  State_Code VARCHAR(20),	
  State	 VARCHAR(20),
  Region VARCHAR(20)
);

select * from AS_STATE_REGION; --48 rows
---------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE AS_STATUSES
(
  ID	INT,
  Description_Status VARCHAR(40));
  
  select * from AS_STATUSES; -- 7 rows
---------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE AS_TYPE
(
  ID INT	,
  Description_Type VARCHAR(20)
);

select * from as_type; -- 10 rows
---------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TABLE AS_STATUS_HISTORY
(
   ID INT	,
   ComplaintID	INT,
   ComplaintStatusID INT,
   StatusDate VARCHAR(10)
);

select * from AS_STATUS_HISTORY; --11,558



-------------------------------------------------------------------------------------------------------
SELECT * FROM AS_COMPLAIN; -- id is pk
select count(distinct id) from AS_COMPLAIN; --13,846

SELECT * FROM AS_CUSTOMER; -- CUSTOMERID is pk
select count(distinct CUSTOMERID) from AS_CUSTOMER; --12,305
SELECT * FROM AS_BROKER; -- broker id is pk
SELECT * FROM AS_CATAGORIES; --id is pk
SELECT * FROM AS_PRIORITIES; -- id is pkj
SELECT * FROM AS_PRODUCT; -- product id
SELECT * FROM AS_REGION;-- id is pk
SELECT * FROM AS_SOURCES; -- id 
SELECT * FROM AS_STATE_REGION; --STATE_CODE
SELECT * FROM AS_STATUSES;-- ID
SELECT * FROM AS_TYPE; -- ID
SELECT * FROM AS_STATUS_HISTORY; -- ID
SELECT * FROM AS_CUST_MASTER; -- ID

CREATE OR REPLACE TABLE AS_CUST_MASTER AS
SELECT COM.ID,COM.ComplainDate,COM.CompletionDate,CUS.LastName,CUS.FirstName,
       CUS.Gender,BR.BrokerFullName,BR.CommissionScheme,
       CAT.Description_Categories,SR.Region,ST.Description_Status,REG.state,PR.Product,
       PRI.Description_Priorities,SUR.Description_Source,TY.Description_Type
--COM.*,CUS.*,SH.*,REG.*,SR.*,BR.*,CAT.*,PRI.*,PR.*,SUR.*,ST.*,TY.*
FROM AS_COMPLAIN COM 
LEFT OUTER JOIN AS_CUSTOMER CUS ON COM.CustomerID = CUS.CustomerID
LEFT OUTER JOIN AS_STATUS_HISTORY SH ON COM.ID = SH.ID
LEFT OUTER JOIN AS_REGION REG ON CUS.RegionID = REG.id
LEFT OUTER JOIN AS_STATE_REGION SR ON REG.state_code = SR.State_Code
LEFT OUTER JOIN AS_BROKER BR ON COM.BrokerID = BR.BrokerID
LEFT OUTER JOIN AS_CATAGORIES CAT ON COM.ComplainCategoryID = CAT.ID
LEFT OUTER JOIN AS_PRIORITIES PRI ON COM.ComplainPriorityID = PRI.ID
LEFT OUTER JOIN AS_PRODUCT PR ON COM.ProductID = PR.ProductID
LEFT OUTER JOIN AS_SOURCES SUR ON COM.ComplainSourceID = SUR.ID
LEFT OUTER JOIN AS_STATUSES ST ON COM.ComplainStatusID = ST.ID
LEFT OUTER JOIN AS_TYPE TY ON COM.ComplainTypeID = TY.ID;

DESCRIBE TABLE AS_CUST_MASTER;

SELECT * FROM AS_CUST_MASTER;

SELECT * FROM AS_CUST_MASTER WHERE COMPLETIONDATE = 'NULL';

