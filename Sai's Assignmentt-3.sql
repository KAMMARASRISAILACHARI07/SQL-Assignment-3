--customers table-1

create table customers_3(customer_number int primary key,first_name varchar(10),last_name varchar(12));
insert into customers_3 (customer_number,first_name,last_name)values
(001,'jane','doe'),
(002,'john','deo'),
(003,'jane','smith'),
(004,'john','smith'),
(005,'jane','jones'),
(006,'john','jones');
select * from customers_3;

-- orders table-1

create table orders_3(order_number int primary key,customer_number int,order_date date,order_total decimal (8,2));

insert into orders_3(order_number,customer_number,order_date,order_total) values
(1001,002,'2009-10-10',250.85),
(1002,002,'2010-02-21',125.89),
(1003,003,'2009-11-15',1567.99),
(1004,004,'2009-11-22',180.92),
(1005,004,'2009-12-15',565.00),
(1006,006,'2009-11-22',25.00),
(1007,006,'2009-10-08',85.00),
(1008,006,'2009-12-29',109.12);

select * from orders_3;

--2. Make an inner join on ‘Customer’ & ‘Order’ tables on the ‘customer_id’ column

select * from customers_3 inner join orders_3 on customers_3.customer_number=orders_3.customer_number;

--3 Make left and right joins on ‘Customer’ & ‘Order’ tables on the ‘customer_id’ column

select * from customers_3 left join orders_3 on customers_3.customer_number=orders_3.customer_number;

select * from customers_3 right join orders_3 on customers_3.customer_number=orders_3.customer_number;

--4. Update the ‘Orders’ table, set the amount to be 100 where ‘customer_id’ is 3.

update orders_3 set customer_number=100 where customer_number=3;

select*from orders_3;

--5. Alter the 'Customers' table to add a new column 'Email' of type VARCHAR(50). Update at least two customer records with their email addresses.

alter table customers_3
add email varchar(50);

select * from customers_3;

update customers_3 set email ='janedoe@gmail.com' where customer_number=1;
update customers_3 set email ='johnsmith@gmail.com' where customer_number=2;

select*from customers_3;

--6.Perform a self-join on the 'Customers' table based on the 'city' column, retrieving customers from the same city.

select * from customers_3 self join customers_3 on customers_3.customer_number=customers_3.customer_number;

--7. Delete all records from the 'Orders' table for customers whose 'customer_id' is not present in the 'Customers' table.

delete from orders_3 where customer_number not in (select customer_number from customers);

select* from orders_3;

--8. Create a new column 'order_status' in the 'Orders' table with default value 'Pending'.

alter table orders_3 add order_status varchar(20) default('pending')not null;
 
select * from orders_3;

--9. Update the 'Customers' table to set the 'country' column to 'Unknown' for customers with no specified country.

alter table customers_3
add country varchar(50) default('unknown')not null;
select* from customers_3;

--10. Find the average order amount from the 'Orders' table.

select avg( order_total) from orders_3;

--11. Explain the significance of foreign keys in the context of the 'customer_id' column in the 'Orders' table.

ALTER TABLE orders_3
ADD CONSTRAINT fk_orders_3_customers_3
FOREIGN KEY (customer_number)
REFERENCES customers_3(customer_number);

select * from orders_3;

--12. How would you retrieve the names of customers who have not placed any orders.

select customers_3.first_name,customers_3.last_name
from customers_3
left join orders_3 on customers_3.customer_number = orders_3.customer_number
where orders_3.customer_number is null;

--13.Write an SQL query to count the number of distinct cities in the 'Customers' table.

select count(distinct first_name) as numberoffirst_name
from customers_3;
select count(distinct last_name) as numberoflast_name
from customers_3;

--14.Explain the purpose of the DELETE statement in SQL and provide an example from the given tasks.
--from delete statement we delete column in the delete 
delete from orders_3 where order_number=1004;
select * from orders_3;

--15. What considerations would you take into account when adding a new column to an existing table in a production database.
--Ans.  After table is used for adding a new column into an existing table.

--16. . If you wanted to find the customer who spent the most on orders, how would you structure your SQL query?
-- Ans: Select max(customer_numb) from order;

--17.  Describe scenarios where using a default value for a column like ‘’Order_status” in the ‘’orders’ table would be beneficial.
-- Ans : By describing an default value of order status (Pending) shows the status of the customer who order is still pending .If the order status doesn't contain any value it defaultly shows the value like pending.

--18.  How would you handle situations where a customer's information needs to be updated in both the 'Customers' and 'Orders' tables simultaneously?
-- Ans: Updating information in the column which is common for both tables , like in the above tables we have customer_numb common if we update customer_numb the information is updated

--19. example 

update customers_3 set email='Sai@gmail.com'
where customer_number=005;
select * from customers_3;
 
--20.  In a left join between 'Customers' and 'Orders,' what records are included in the result set?
--Ans: when we are performing leftjoin between customers and order all the record in the customers table appears with join of order table, but on order table some values appears as NULL.

--21. Explain the purpose and usage of the SQL GROUP BY clause. Provide an example using the 'Orders' table, demonstrating how it can be used to summarize data.
--Ans: The Purpose of the Group by clause in SQL is, it will help to applying the Aggregation functions to the group of rows of the same kind.
--Ex: 
SELECT customer_number, SUM(order_total) AS total_order_amount
FROM Orders_3
GROUP BY customer_number;

-- 22. Describe the role of the SQL HAVING clause. How is it different from the WHERE clause, and in what scenarios would you use HAVING?
--Ans: Having clause is used for the group by functions, where it helps in defining filters on the grouped query based on the aggregation function. 
		--Where clause is used to filter specific rows based on certain condition while having clause is used to filter group of rows where the query based on conditions involving aggregated values

-- 23. In the context of the 'Orders' table, what is a primary key, and why is it important?
--Ans:In orders table the primary key is used for order_numb where the primary key does not allows the duplicate values in rows in the table. It has different unique values for each row in the table

 -- 24. Write an SQL query to find the customer who placed the earliest order based on the 'order_date' in the 'Orders' table.
 --Ans: 
 Select min(order_date) from orders_3;

 -- 25. Explain the concept of indexing in databases. How can it optimize query performance, and when would you consider adding an index to a table
 --Ans: Indexes helps us to retrieve the data from table quickers. 
 --With proper index in place, the database system can then first go through the index to find out where to retrieve the data, and then go to these locations directly to get the needed data
