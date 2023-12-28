USE info330_a_24;

-- BRITTNEY'S PART --
-- Question 1:
-- Write a query that lists the sum of all transactions for a customer’s purchase history.
-- (Use JOIN operation)
SELECT c.customer_id, SUM(t.total_amount) AS total_purchase_amount
FROM Customer c
JOIN Transactions t ON c.customer_id = t.customer_id
GROUP BY c.customer_id;

-- Question 2:
-- Write a query to retrieve the contact details of customers who have purchased the highest number of tickets.
-- (Use subquery)
SELECT C.person_id, C.first_name, C.last_name, C.phone_number, C.email_address, CU.number_of_tickets
FROM Contact C
JOIN Customer CU ON C.person_id = CU.customer_id
WHERE CU.number_of_tickets = (
    SELECT MAX(number_of_tickets)
    FROM Customer
);

-- Question 3:
-- Write a query to retrieve employees with the most number of assignments across different attractions.
-- (Use Common Table Expressions (CTE))
WITH AssignmentsCount AS (
    SELECT
        employee_id,
        COUNT(DISTINCT attraction_id) AS num_assignments
    FROM Attraction_Assignment
    GROUP BY employee_id
)

SELECT
    E.employee_id,
    E.job_title,
    E.hourly_rate,
    E.hiring_date,
    E.employment_end_date,
    AC.num_assignments
FROM Employee E
JOIN AssignmentsCount AC ON E.employee_id = AC.employee_id
WHERE AC.num_assignments = (
    SELECT MAX(num_assignments)
    FROM AssignmentsCount
);

-- Question 4:
-- Write a query that retrieve the name of every employee who are assigned to attractions and corresponding ride names.
-- (Use Common Table Expressions (CTE))
WITH EmployeeAttraction AS (
    SELECT e.employee_id, c.first_name, c.last_name, aa.attraction_id
    FROM Employee e
    JOIN Contact c ON e.employee_id = c.person_id
    JOIN Attraction_Assignment aa ON e.employee_id = aa.employee_id
)
SELECT ea.first_name, ea.last_name, r.name AS ride_name
FROM EmployeeAttraction ea
JOIN Ride r ON ea.attraction_id = r.attraction_id;

-- Question 5:
-- Write a query to retrieve a list of food stands with their names, allergy types, and a categorized label based on their allergy type.
-- (Use derived (computed) attributes)
SELECT foodstand_id, food_stand_name, allergy_type,
    CASE 
        WHEN allergy_type = 'Gluten-free' THEN 'Healthy Choice'
        WHEN allergy_type = 'Dairy-free' THEN 'Dairy Alternative'
        ELSE 'Regular'
    END AS food_category
FROM FoodStand;

-- NESSA'S PART --
-- Question 6:
-- Write a query to get full names, email addresses, and hours worked of all employees who are currently still employed for payroll purposes.
-- (Use common table expressions (CTEs))
WITH EmployeeContact AS (
   SELECT E.employee_id, C.first_name, C.last_name, C.email_address, E.employment_end_date
   FROM Contact C
   JOIN Employee E ON C.person_id = E.employee_id
)

SELECT EC.first_name, EC.last_name, EC.email_address, SUM(AA.num_of_hours) AS hours_worked
FROM EmployeeContact EC
JOIN Attraction_Assignment AA ON EC.employee_id = AA.employee_id
WHERE EC.employment_end_date IS NULL
GROUP BY EC.first_name, EC.last_name, EC.email_address, EC.employee_id
HAVING SUM(AA.num_of_hours) > 0
ORDER BY hours_worked DESC;

-- Question 7:
-- Write a query to get an ordered list of rides and the number of ride transactions to see which ride attraction is the most popular.
-- (Use aggregate functions (SUM, AVG, COUNT, MAX, MIN))
SELECT A.attraction_type, COUNT(RT.transaction_id) AS ride_count
FROM Attraction A
JOIN Ride R ON A.attraction_id = R.attraction_id
JOIN RideTransaction RT ON R.ride_id = RT.ride_id
GROUP BY attraction_type
ORDER BY ride_count DESC;

-- Question 8:
-- Write a query to get the list of the highest-spending customer’s transactions.
-- (Use Common Table Expressions (CTEs))
WITH HighestSpender AS (
   SELECT TOP 1 T.customer_id, SUM(T.total_amount) as total_spent
   FROM Transactions T
   GROUP BY T.customer_id
   ORDER BY total_spent DESC
),
TransactionHistory AS (
   SELECT T.customer_id, T.payment_method, T.total_amount, FS.food_stand_name AS 'location', T.transaction_date, T.transaction_time
   FROM FoodStand FS
   JOIN FoodTransaction FT ON FS.foodstand_id = FT.foodstand_id
   JOIN Transactions T ON FT.transaction_id = T.transaction_id
   UNION
   SELECT T.customer_id, T.payment_method, T.total_amount, R.name AS 'location', T.transaction_date, T.transaction_time
   FROM Ride R
   JOIN RideTransaction RT ON R.ride_id = RT.ride_id
   JOIN Transactions T ON RT.transaction_id = T.transaction_id
   WHERE T.payment_method != 'Pass'
)
SELECT C.first_name, C.last_name, HS.customer_id, TH.payment_method, TH.total_amount, TH.location, TH.transaction_date, TH.transaction_time
FROM Contact C
JOIN HighestSpender HS ON C.person_id = HS.customer_id
JOIN TransactionHistory TH ON TH.customer_id = HS.customer_id
ORDER BY TH.transaction_date ASC, TH.transaction_time ASC;

-- Question 9:
-- Write a query to get the list of ride types and their popularity overall.
-- (Use JOINs)
SELECT R.type, COUNT(RT.transaction_id) AS transaction_count, RC.ride_count
FROM Ride R
JOIN RideTransaction RT ON R.ride_id = RT.ride_id
JOIN (
   Select R2.type, COUNT(R2.ride_id) AS ride_count
   FROM Ride R2
   GROUP BY R2.type
) AS RC ON RC.type = R.type
GROUP BY R.type, RC.ride_count
ORDER BY transaction_count DESC;

-- Question 10:
-- Write a query to get an ordered list of food stands based on popularity using transaction count and total of units sold.
-- (Use JOINs)
SELECT FS.food_stand_name, COUNT(FT.transaction_id) AS transaction_count, SUM(FT.num_food) AS units_sold
FROM FoodTransaction FT
JOIN Foodstand FS ON FT.foodstand_id = FS.foodstand_id
GROUP BY FS.food_stand_name
ORDER BY transaction_count DESC, units_sold DESC;

-- MAI'S PART -- 
-- Question 11:
-- Write a query that gets the average money a customer spends in the carnival for customers who didn't use passes for rides from most to least money spent.
-- (Use JOINs, filtering, aggregate functions, subquery, CTEs)
WITH spent_money
AS
(SELECT customer_id, SUM(total_amount) AS total_spent
FROM Transactions
GROUP BY customer_id)

SELECT sm.customer_id, AVG(sm.total_spent) AS avg_money_spent
FROM spent_money sm
WHERE sm.customer_id NOT IN (
    SELECT t.customer_id
    FROM Transactions t
    WHERE t.payment_method = 'Pass')
GROUP BY sm.customer_id
ORDER BY avg_money_spent DESC;

-- Question 12:
-- Write a query that gets the contact information of customers who only have less than 50 ride passes left.
-- (Use JOINs, derived attributes, filtering, aggregate functions, CTEs)
WITH used_tickets
AS (
    SELECT c.customer_id, (c.number_of_tickets - SUM(rt.ticket_sold)) AS remaining_tickets
    FROM Customer c JOIN Transactions t ON c.customer_id = t.customer_id
    JOIN RideTransaction rt ON t.transaction_id = rt.transaction_id
    GROUP BY c.customer_id, c.number_of_tickets
    HAVING (c.number_of_tickets - SUM(rt.ticket_sold)) < 50)

SELECT ct.person_id, ct.first_name, ct.last_name, ct.phone_number, ct.email_address, ut.remaining_tickets
FROM Contact ct CROSS JOIN used_tickets ut
WHERE ct.person_id = ut.customer_id
GROUP BY ct.person_id, ct.first_name, ct.last_name, ct.phone_number, ct.email_address, ut.remaining_tickets;

-- Question 13:
-- Write a query that gets the contact information of customers who have not enjoyed the carnival yet.
-- (Use filtering, subquery)
SELECT ct.person_id, ct.first_name, ct.last_name, ct.phone_number, ct.email_address
FROM Contact ct
WHERE ct.person_id NOT IN (
    SELECT t.customer_id
    FROM Transactions t)
    AND ct.person_id NOT IN (
        SELECT e.employee_id
        FROM Employee e)
GROUP BY ct.person_id, ct.first_name, ct.last_name, ct.phone_number, ct.email_address;

-- Question 14:
-- Write a query that gets employees who have served the same customer more than once.
-- (Use filtering, aggregate functions)
SELECT employee_id, customer_id, COUNT(customer_id) AS served
FROM Transactions
GROUP BY employee_id, customer_id
HAVING COUNT(customer_id) > 1
ORDER BY served DESC, employee_id, customer_id;

-- Question 15:
-- Write a query that gets the number of payment methods done in transactions.
-- (Use JOINs, filtering, aggregate functions, CTEss)
WITH pass_ct
AS
(SELECT COUNT(transaction_id) AS pass_count
FROM Transactions
WHERE payment_method = 'Pass'),
card_ct
AS
(SELECT COUNT(transaction_id) AS card_count
FROM Transactions
WHERE payment_method = 'Card'),
cash_ct
AS
(SELECT COUNT(transaction_id) AS cash_count
FROM Transactions
WHERE payment_method = 'Cash')

SELECT pc.pass_count, cd.card_count, ch.cash_count
FROM pass_ct pc
CROSS JOIN card_ct cd
CROSS JOIN cash_ct ch;