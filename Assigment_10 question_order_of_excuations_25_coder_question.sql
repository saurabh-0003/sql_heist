--Q1. Calculate the total revenue (SUM(RevenueLastMonth)) for influencers in the "Gaming"category.
select sum(revenuelastmonth) as total_revenue 
from youtube
where channeltype= 'Gaming';

--other_method
select channeltype, sum(revenuelastmonth) as total_revenue 
from youtube
group by channeltype
having channeltype ='Gaming';

--Q2. Find the total revenue for each Country.
select country, sum(revenuelastmonth) as total_revenue 
from youtube
group by country;

--Q3. Calculate the total revenue for each country, but only include rows where ChannelType is "Gaming".
select country, sum(revenuelastmonth) as total_revenue 
from youtube
where channeltype ='Gaming'
group by country;

--Q4. Find countries where the total revenue exceeds $200,000.
Select country, sum(revenuelastmonth) as total_revenue
From youtube
Group by country
Having sum(revenuelastmonth)> 200000;

--Q5. Find countries with influencers in the "Gaming" category, where the total revenue for gaming channels exceeds $30,000.
select country, SUM(revenuelastmonth) AS total_revenue
from youtube
where channeltype ='Gaming'
group by country
having SUM(revenuelastmonth) >30000;

--Q6. For each Country, calculate the total number of influencers (COUNT(*)), total revenue (SUM), and average revenue (AVG).

select country,count(*), sum(revenuelastmonth) as total_revenue, avg(revenuelastmonth) as average_revenue
from youtube
group by country;

--Q7.Find countries where the total revenue exceeds $150,000 and the average revenue per influencer exceeds $20,000.
select country, sum(revenuelastmonth) as total_revenue, avg(revenuelastmonth) as average_revenue
from youtube 
group by country
having sum(revenuelastmonth) > 150000 
and avg(revenuelastmonth) >20000;

-- Q8. Find the ChannelType with the highest total evenue.
select channeltype, max(revenuelastmonth) as highest_total_revenue
from youtube 
group by channeltype;

--Q9. Identify ChannelType groups where the average revenue per influencer 
--(AVG(RevenueLastMonth)) is greater than 50% of the maximum revenue among all influencers.

select channeltype, (AVG(RevenueLastMonth)) as average_revenue
from youtube
group by channeltype 
having (AVG(RevenueLastMonth)) >(.5* (max(revenuelastmonth)));

--Q10. Identify ChannelType groups where the total views (SUM(AvgViewsPerVideo))
--contribute more than 10% of the overall views across all influencers in the dataset.

select channeltype, (SUM(AvgViewsPerVideo)) as avg_view 
from youtube
group by channeltype
having (SUM(AvgViewsPerVideo)) > 0.1*(Select SUM(AvgViewsPerVideo) as total_view from youtube ); 

-- 20 practise question from datasense platform

--1.Write a SQL Query to retrieve the Festival_Name, Country, and Ticket_Type for all festivals.
select  Festival_Name, Country, Ticket_Type
from festivaldata;

--2. Write a SQL Query to retrieve all festivals held in the USA.
select FESTIVAL_NAME, CITY, DATE 
FROM festivaldata
where COUNTRY = 'USA';

--3.Write a SQL Query to retrieve festivals in India with ticket prices greater than $100.
SELECT Festival_Name, Ticket_Type,Price
FROM festivaldata
where Country ='INDIA' AND PRICE >100;

--4. Write a SQL Query to retrieve festivals held in India or the USA.
SELECT Festival_Name, COUNTRY, TICKET_TYPE
FROM festivaldata
WHERE country in ('india', 'USA');

--5. Write a SQL Query to calculate the total revenue for each ticket type.
SELECT Ticket_Type, sum(price) as Total_Revenue
FROM festivaldata
group by Ticket_Type;

--6.Write a SQL Query to retrieve the top 5 festivals with the highest ticket prices.
select festival_name, MAX (price) AS PRICE 
from festivaldata
GROUP BY festival_name
order by max(price) desc
limit 5 ;

--7.Write a SQL Query to retrieve festivals ranked 6th to 10th based on ticket prices.
select festival_name, PRICE 
from festivaldata
order by price desc
limit 5 offset 5;
--8.Write a SQL Query to calculate the total profit for festivals in India where the average ticket price exceeds $100.
select festival_name, sum(Organizer_Profit) as Total_Profit
from festivaldata 
where COUNTRY ='INDIA'
group by festival_name
having sum(Organizer_Profit)> 100
ORDER BY festival_name DESC
LIMIT 1 ;

--9.Profitable Festivals with Ticket Type Analysis
select country, max(Organizer_Profit) as MAX_PROFIT
from festivaldata
group by country;

--10.Write a SQL Query to find the top 3 ticket types based on total profit for festivals held in India or the USA, 
--where the average ticket price is greater than $50.
SELECT TICKET_TYPE, sum(Organizer_Profit) as Total_Profit
FROM festivaldata
WHERE COUNTRY in ('INDIA', 'USA')
GROUP BY TICKET_TYPE
HAVING sum(Organizer_Profit) >50
ORDER BY TICKET_TYPE DESC
LIMIT 3;

--11.Write a SQL query to retrieve movies ranked 4th to 8th by average rating (without using Rank Function).
select MOVIE_NAME, avg(rating) as avg_rating
from user_watch_activity
group by MOVIE_NAME
order by avg(rating) desc
limit 5 OFFSET 3 ;

--12.Write a SQL query to find users with total watch time between 100 and 150 minutes, sorted by watch time in ascending order.
SELECT USER_NAME , watch_time_minutes
FROM user_watch_activity
WHERE watch_time_minutes BETWEEN 100 AND 150
ORDER BY watch_time_minutes ;

--13.Write a SQL query to retrieve the second-best user by watch time for Sci-Fi movies.
select user_name, watch_time_minutes as total_watch_time
from user_watch_activity
where genre ='Sci-Fi' 
order by watch_time_minutes desc
limit 1 offset 1;

--14.Write a SQL query to find the top genre by total watch time in Japan.
select genre , sum (watch_time_minutes) as total_watch_time
from user_watch_activity
where country = 'Japan'
group by genre
order by sum (watch_time_minutes) desc
limit 1;

--15.Write a SQL query to retrieve the top 5 Premium users who have watched the most movies.
select user_name, total_movies_watched
from user_watch_activity
where subscription_type	='Premium'
order by total_movies_watched desc
limit 5;

--16.Write a SQL query to find the top 5 transactions based on transaction value across all categories.
select transaction_id,customer_name,transaction_value
from payment_transactions
order by transaction_value desc 
limit 5;

--17.Write a SQL query to calculate the total revenue generated before and after discounts for each product category.
--Ensure the output includes the product category,revenue before discount, and revenue after discount.

select  (product_category),
sum (quantity_purchased*price_per_unit)	as revenue_before_discount,
sum (transaction_value)as revenue_after_discount
from payment_transactions
group by product_category;

--18.Write a SQL query to find the payment method that generates the highest average transaction value. 
--Ensure the output includes the payment method and the average transaction value.

select payment_method,avg(transaction_value)as avg_transaction_value
from payment_transactions 
group by payment_method
order by avg(transaction_value) desc
limit 1;

--19.Classify customers into segments based on total spending: 
--High Spend: Spending > $2000
--Medium Spend: Spending between $1000 and $2000 
--Low Spend: Spending < $1000
--Return the customer name, total spending, and their respective segment.

select customer_name, 
sum (transaction_value) as total_spending,
case 
when sum (transaction_value)> 2000 then 'High Spend'
when sum (transaction_value) between 1000 and 2000 then 'Medium Spend'
else 'Low Spend'
end as spending_segment
from payment_transactions
group by customer_name ;

--20.Write a SQL query to find customers who have given an average rating of less than 4 across all transactions. 
--Return the customer name and their average rating.

select customer_name, avg(customer_rating) as avg_rating
from payment_transactions
group by customer_name
having avg(customer_rating) < 4;






