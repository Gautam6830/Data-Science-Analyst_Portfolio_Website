select * from customer; 
select * from new_sales;
select * from date;
select * from product;
select * from productcategory;
select * from productsubcategory;
select * from geography;
select * from internetsales;
select * from salesbudget;
select * from dates;

----Create salesbudget date table-------- salesbudget table-----
create table salesbudget(date date,Budget int);

copy salesbudget from 'C:\Program Files\PostgreSQL\16\data\salesbudget.csv' csv header;

----- sales table-----
create table new_sales as
select productkey,orderdatekey,customerkey,totalproductcost,salesamount,salesordernumber,orderdate,shipdate ,Duedate , Shipdatekey,currencykey,PromotionKey
from internetsales 
where orderdatekey between '2021-01-01' and '2023-01-31';

----- extract the essential data ----

---- Create newcustomer data using join operation on customer.csv and geography.csv file---
select Birthdate,Commutedistance,customeralternatekey,customerkey,Firstname,Lastname, geographykey,firstname||' '||middlename||' '||lastname as Customername,gender,yearlyincome from customer;

---- geography data----
select geographykey,city,stateprovincename as state,englishcountryregionname as country ,salesterritorykey from geography;

---- left join between customer and geography data  to create a newcustomer data Table----
select
 a.birthdate,a.customeralternatekey,a.firstname||' '||a.middlename||' '||a.lastname as Customername,a.Firstname,a.gender,a.Lastname, a.Yearlyincome ,a.customerkey, 
b.city,b.stateprovincename as state,b.englishcountryregionname as country ,b.salesterritorykey  
from customer as a
 left join
 geography as b
 on a.geographykey=b.geographykey


-- new product is form with product category and product subcategory via sqljoin ----
select distinct productkey from product  order by productkey asc;

select 
distinct c.productkey,c.productalternatekey,c.englishproductname as products,c.color,c.modelname,
a.productsubcategorykey,a.englishproductsubcategoryname as productsubcategory,
b.englishproductcategoryname as productcategory ,b.productcategorykey
from productsubcategory as a
left join productcategory as b
on
a.productcategorykey=b.productcategorykey
right join product as c
on
a.productsubcategorykey=c.productsubcategorykey
order by  productkey asc	;



create table dates as
select DISTINCT datekey ,fulldatealternatekey,englishmonthname as month,calendaryear as year from date
where calendaryear between '2021' and '2023' ;




