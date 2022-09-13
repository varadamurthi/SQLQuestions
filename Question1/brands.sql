/*
-->> Problem Statement:
Write a query to fetch the record of brand whose amount is increasing every year.

create table brands(year integer,
                    brand varchar(20),
                    amount integer);
                    
insert into brands (year,brand,amount) values 
(2018,'Apple',45000),(2019,'Apple',35000),(2020,'Apple',75000),
(2018,'Nokia',21000),(2019,'Nokia',17000),(2020,'Nokia',14000),
(2018,'Samsung',15000),(2019,'Samsung',20000),(2020,'Samsung',25000);                    
*/                    
                    
select * from brands;

with cte as 
    (select *, 
        (case when amount < lead(amount,1,amount+1) over(partition by brand order by year) 
              then 1 
              else 0 
         end) as flag
     from brands)

select * from brands where brand not in (select brand from cte where flag= 0);