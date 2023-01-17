use database demo_database2;
CREATE OR REPLACE TABLE  AS_SALES_DATA_FINAL_data AS
SELECT * FROM AS_SALES_DATA_FINAL;
select * from AS_SALES_DATA_FINAL_data;
drop table AS_SALES_DATA_FINAL_copy;

--1. Load the given dataset into snowflake with a primary key to Order Date column.--
alter table AS_SALES_DATA_FINAL_data
ADD PRIMARY KEY (ORDER_DATE);

ALTER TABLE AS_SALES_DATA_FINAL_data
DROP PRIMARY KEY;

--2. Change the Primary key to Order Id Column.--
alter table AS_SALES_DATA_FINAL_data
ADD PRIMARY KEY (ORDER_ID);

--3. Check the data type for Order date and Ship date and mention in what data type--
--it should be--



--4. Create a new column called order_extract and extract the number after the last--
--‘–‘from Order ID column--

alter table AS_SALES_DATA_FINAL_data
add column order_extract varchar(30);

select  split_part(ORDER_ID, '-', 3) as order_extract
from AS_SALES_DATA_FINAL_data;

update AS_SALES_DATA_FINAL_data
set order_extract = split_part(ORDER_ID, '-', 3);

--5. Create a new column called Discount Flag and categorize it based on discount.--
--Use ‘Yes’ if the discount is greater than zero else ‘No’--

alter table AS_SALES_DATA_FINAL_data
add column Discount_Flag varchar(40);

select *,
         case when DISCOUNT > '0' then 'yes'
              else 'No'
end as Discount_Flag
from AS_SALES_DATA_FINAL_data;

update AS_SALES_DATA_FINAL_data
set Discount_Flag = case when DISCOUNT > '0' then 'yes'
              else 'No'
              end;

--6. Create a new column called process days and calculate how many days it takes--
--for each order id to process from the order to its shipment--

alter table AS_SALES_DATA_FINAL_data
add column process_days varchar (50);

alter table AS_SALES_DATA_FINAL_data
drop column process_days;


select datediff('month',to_date(ORDER_DATE,'yyyy-mm-dd'),
                to_date(SHIP_DATE, 'yyyy-mm-dd')) 
from AS_SALES_DATA_FINAL_data;

update AS_SALES_DATA_FINAL_data
set process_days = datediff('month',to_date(ORDER_DATE,'yyyy-mm-dd'),
                to_date(SHIP_DATE, 'yyyy-mm-dd'));
select *,
         (order_date - ship_date) as XYZ
         from AS_SALES_DATA_FINAL_data;
         
--7. Create a new column called Rating and then based on the Process dates give--
--rating like given below.--

alter table AS_SALES_DATA_FINAL_data
add column Rating varchar(50);

update AS_SALES_DATA_FINAL_data
set Rating = case
                 when process_days <= 3 then '5'
                 when process_days >3 and process_days <= 6 then '4'
                 when process_days > 6 and process_days <= 10 then '3'
                 when process_days >10 then '2'
                 end;


