IF DB_ID('info330_a_24') IS NOT NULL
    DROP DATABASE info330_a_24;

CREATE DATABASE info330_a_24;

SELECT *
FROM sys.databases;

USE info330_a_24;

-- Get a list of tables and views in the current database
SELECT table_catalog [database], table_schema [schema], table_name [name], table_type [type]
FROM INFORMATION_SCHEMA.TABLES
GO

CREATE Table Contact (
	person_id INT PRIMARY KEY,
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) NOT NULL,
	phone_number VARCHAR(10) NOT NULL,
	email_address NVARCHAR(320) NOT NULL
);	

CREATE Table Customer (
	customer_id INT PRIMARY KEY,
	number_of_tickets INT NULL,
    CONSTRAINT FK_ContactCustomer FOREIGN KEY (customer_id)
	    REFERENCES Contact(person_id)
);

CREATE Table Employee (
	employee_id INT PRIMARY KEY,
	job_title VARCHAR(100) NOT NULL,
	hourly_rate TINYINT NOT NULL,
	hiring_date DATE NOT NULL,
	employment_end_date DATE NULL
    CONSTRAINT FK_ContactEmployee FOREIGN KEY (employee_id)
        REFERENCES Contact(person_id)
);

CREATE Table Attraction (
	attraction_id INT PRIMARY KEY,
	attraction_type VARCHAR(100) NOT NULL,
	attraction_cost TINYINT NULL,
	height_requirement TINYINT NULL,
	attraction_capacity TINYINT NULL
);

CREATE Table Ride (
	ride_id INT PRIMARY KEY, 
    attraction_id INT,
	type VARCHAR(50),
	name VARCHAR(50),
	ride_pass BIT,
    CONSTRAINT FK_AttractionRide FOREIGN KEY (attraction_id) 
        REFERENCES Attraction(attraction_id)
);

CREATE TABLE Attraction_Assignment (
	assignment_id INT PRIMARY KEY,
    employee_id INT,
    attraction_id INT,
    num_of_hours TINYINT,
    CONSTRAINT FK_EmployeeAttractionAssignment FOREIGN KEY (employee_id) 
        REFERENCES Employee(employee_id),    
    CONSTRAINT FK_AttractionAttractionAssignment FOREIGN KEY (attraction_id) 
        REFERENCES Attraction(attraction_id)
);

CREATE Table FoodStand (
	foodstand_id INT PRIMARY KEY, 
	attraction_id INT,
	food_stand_name VARCHAR(50),
	allergy_type VARCHAR(50),
    CONSTRAINT FK_AttractionFoodStand FOREIGN KEY (attraction_id) 
        REFERENCES Attraction(attraction_id)
);

CREATE Table Transactions (
	transaction_id INT PRIMARY KEY, 
	total_amount SMALLMONEY,
	payment_method VARCHAR(25),
	transaction_date DATE,
	transaction_time TIME,
    customer_id INT,
    employee_id INT,
    CONSTRAINT FK_CustomerTransactions FOREIGN KEY (customer_id) 
        REFERENCES Customer(customer_id),
    CONSTRAINT FK_EmployeeTransactions FOREIGN KEY (employee_id)
        REFERENCES Employee(employee_id)
);

CREATE TABLE FoodTransaction (
    transaction_id INT,
    foodstand_id INT,
    num_food TINYINT,
    PRIMARY KEY (transaction_id, foodstand_id),
    CONSTRAINT FK_FoodStandFoodStandTransaction FOREIGN KEY (foodstand_id) 
        REFERENCES FoodStand(foodstand_id),
    CONSTRAINT FK_FoodStandTransaction FOREIGN KEY (transaction_id)
        REFERENCES Transactions(transaction_id)
);

CREATE Table RideTransaction ( 
	transaction_id INT,
    ride_id INT,
	ticket_sold TINYINT,
	PRIMARY KEY (transaction_id, ride_id),
	CONSTRAINT FK_TransactionsRide FOREIGN KEY (ride_id) 
        REFERENCES Ride(ride_id),
 	CONSTRAINT FK_TransactionsRideTransaction FOREIGN KEY (transaction_id) 
		REFERENCES Transactions(transaction_id)
);

INSERT INTO Contact VALUES
    (1001, 'Jim', 'Carrey', '1234567890', 'j.carrey@email.com'),
    (1002, 'Michael', 'Buble', '8469250371', 'm.buble@email.com'),
    (1003, 'Ariana', 'Grande', '5092847613', 'a.grande@email.com'),
    (1004, 'Will', 'Ferrell', '7253641980', 'w.ferrell@email.com'),
    (1005, 'Tom', 'Hanks', '1392085476', 't.hanks@email.com'),
    (1006, 'Adam', 'Sandler', '6481732059', 'a.sandler@email.com'),
    (1007, 'Eddie', 'Murphy', '9172038564', 'e.murphy@email.com'),
    (1008, 'Miley', 'Cyrus', '3645120987', 'm.cyrus@email.com'),
    (1009, 'Taylor', 'Swift', '5826734190', 't.swift@email.com'),
    (1010, 'Jack', 'Black', '2039581467', 'j.black@email.com'),
    (1011, 'Morgan', 'Freeman', '7918463205', 'm.freeman@email.com'),
    (1012, 'Jackie', 'Chan', '4561320897', 'j.chan@email.com'),
    (1013, 'Dwayne', 'Johnson', '8203456719', 'd.johnson@email.com'),
    (1014, 'Frank', 'Sinatra', '9786104325', 'f.sinatra@email.com'),
    (1015, 'Ed', 'Sheeran', '1357924680', 'e.sheeran@email.com'),
    (1016, 'Harry', 'Styles', '6048192375', 'h.styles@email.com'),
    (1017, 'Billie', 'Eilish', '7520431986', 'b.eilish@email.com'),
    (1018, 'Jennifer', 'Lopez', '2195736840', 'j.lopez@email.com'),
    (1019, 'Sofia', 'Vergara', '4836579021', 's.vergara@email.com'),
    (1020, 'Chris', 'Brown', '3657208941', 'c.brown@email.com'),
    (1021, 'Elton', 'John', '8102574936', 'e.john@email.com'),
    (1022, 'Tom', 'Hiddleston', '2463981750', 't.hiddleston@email.com'),
    (1023, 'Michael', 'Jackson', '9314708256', 'm.jackson@email.com'),
    (1024, 'Mariah', 'Carey', '5790842613', 'm.carey@email.com'),
    (1025, 'Johnny', 'Depp', '3027159864', 'j.depp@email.com'),
    (1026, 'Leonardo', 'Dicaprio', '6942018375', 'l.dicaprio@email.com'),
    (1027, 'Jennifer', 'Lawrence', '1875396420', 'j.lawrence@email.com'),
    (1028, 'Jennifer', 'Aniston', '5403812976', 'j.aniston@email.com'),
    (1029, 'Dua', 'Lipa', '9268570143', 'd.lipa@email.com'),
    (1030, 'Kendrick', 'Lamar', '3745021986', 'k.lamar@email.com');

INSERT INTO Customer VALUES
    (1001, 265),
    (1002, 50),
    (1003, 410),
    (1004, 190),
    (1005, 305),
    (1006, 395),
    (1007, 240),
    (1008, 145),
    (1009, 355),
    (1010, 480),
    (1011, 25),
    (1012, 345),
    (1013, 80),
    (1014, 415),
    (1015, 320);

INSERT INTO Employee VALUES
    (1016, 'Ride Operator', 28, '2022-08-15', '2023-11-15'),
    (1017, 'Food Stand Cook', 19, '2023-06-02', NULL),
    (1018, 'Game Attendant', 17, '2021-12-18', '2024-12-28'),
    (1019, 'Parking Attendant', 19, '2022-03-25', NULL),
    (1020, 'Ride Operator', 28, '2023-01-09', NULL),
    (1021, 'Food Stand Cook', 19, '2021-05-30', NULL),
    (1022, 'Costumed Character', 26, '2022-11-07', '2023-10-18'),
    (1023, 'Game Attendant', 17, '2023-09-14', NULL),
    (1024, 'Ride Operator', 28, '2022-01-20', NULL),
    (1025, 'Parking Attendant', 19, '2023-04-03', NULL),
    (1026, 'Food Stand Cook', 19, '2021-09-12', NULL),
    (1027, 'Ride Operator', 28, '2022-06-28', '2023-05-01'),
    (1028, 'Game Attendant', 17, '2023-10-22', NULL),
    (1029, 'Ride Operator', 28, '2021-03-08', '2023-02-22'),
    (1030, 'Costumed Character', 26, '2022-04-17', NULL);

INSERT INTO Attraction VALUES
    (1, 'Roller Coaster', 12, 48, 12),
    (2, 'Bumper Cars', 8, 36, 24),
    (3, 'Ferris Wheel', 12, 48, 36),
    (4, 'VR Simulation', 20, NULL, NULL),
    (5, 'Water Ride', 12, 48, 8),
    (6, 'Carousel', 8, NULL, 36),
    (7, 'Train Ride', 8, NULL, 18),
    (8, 'Haunted House', 4, NULL, 24),
    (9, 'Spinning Ride', 12, 36, 24),
    (10, 'Drop Tower', 12, 36, 12),
    (11, 'Inflatable Ride', 4, 36, 12),
    (12, 'Beverages', NULL, NULL, NULL),
    (13, 'Sweet Treats', NULL, NULL, NULL),
    (14, 'Specialty Foods', NULL, NULL, NULL),
    (15, 'Classic Food', NULL, NULL, NULL);

INSERT INTO Ride VALUES
    (10, 1, 'Thriller', 'Wild Turns', 1),
    (11, 1, 'Family', 'Whirlwind', 1),
    (12, 1, 'Kiddie', 'Baby Tornado', 1),
    (13, 1, 'Thriller', 'Lost at Sea', 1),
    (14, 1, 'Thriller', 'In the Sky', 1),
    (15, 2, 'Kiddie', 'Bump Another', 1),
    (16, 2, 'Kiddie', 'We Bumpin', 0),
    (17, 2, 'Family', 'Moving Crazy', 1),
    (18, 2, 'Family', 'Quick Attack', 0),
    (19, 3, 'Family', 'The Magnificent', 1),
    (20, 3, 'Family', 'The Big One', 1),
    (21, 3, 'Family', 'Round-And-Round', 0),
    (22, 3, 'Family', 'Over the Moon', 0),
    (23, 4, 'Thriller', 'Zombie Attack', 0),
    (24, 4, 'Kiddie', 'Dance Party', 1),
    (25, 4, 'Extreme', 'Roller Extreme', 0),
    (26, 4, 'Family', 'The Fastest', 1),
    (27, 5, 'Water', 'Slippery Slope', 1),
    (28, 5, 'Water', 'Boat Ride', 1),
    (29, 5, 'Water', 'Splash Mountain', 0),
    (30, 5, 'Water', 'Waterfall', 0),
    (31, 6, 'Spinning', 'Pony', 1),
    (32, 6, 'Spinning', 'Magical Ride', 1),
    (33, 6, 'Spinning', 'Another Dimension', 0),
    (34, 6, 'Spinning', 'Around the World', 0),
    (35, 7, 'Kiddie', 'Choo-Choo', 1),
    (36, 7, 'Family', 'Long Train', 1),
    (37, 7, 'Thriller', 'Fast as Lightning', 0),
    (38, 7, 'Thriller', 'Zoomin', 0),
    (39, 7, 'Family', 'Get Along', 0),
    (40, 7, 'Kiddie', 'Slow Crusing', 1),
    (41, 8, 'Extreme', 'Night Terror', 1),
    (42, 8, 'Extreme', 'Escape the Void', 0),
    (43, 8, 'Family', 'Friendly Ghosts', 1),
    (44, 8, 'Thriller', 'Be Careful', 0),
    (45, 9, 'Spinning', 'Nausea', 1),
    (46, 9, 'Spinning', 'Dizzy Party', 1),
    (47, 9, 'Spinning', 'Close Your Eyes', 0),
    (48, 9, 'Spinning', 'Ring', 0),
    (49, 10, 'Extreme', 'Scream', 1),
    (50, 10, 'Extreme', 'Deep Fall', 1),
    (51, 10, 'Extreme', 'Terror Height', 0),
    (52, 11, 'Kiddie', 'Bouncy Castle', 1),
    (53, 11, 'Kiddie', 'Slippery Slide', 1),
    (54, 11, 'Kiddie', 'Paradise', 1);

INSERT INTO Attraction_Assignment VALUES
    (100, 1016, 3, 8),
    (101, 1017, 3, 8),
    (102, 1018, 3, 8),
    (103, 1020, 3, 6),
    (104, 1016, 6, 8),
    (105, 1017, 6, 8),
    (106, 1018, 6, 8),
    (107, 1020, 6, 6),
    (108, 1021, 2, 8),
    (109, 1016, 2, 8),
    (110, 1018, 2, 8),
    (111, 1020, 2, 6),
    (112, 1021, 8, 8),
    (113, 1017, 8, 8),
    (114, 1018, 8, 8),
    (115, 1029, 8, 6),
    (116, 1022, 9, 8),
    (117, 1019, 9, 8),
    (118, 1030, 9, 8),
    (119, 1022, 1, 8),
    (120, 1019, 1, 8),
    (121, 1030, 1, 8),
    (122, 1023, 10, 8),
    (123, 1029, 10, 8),
    (124, 1030, 10, 8),
    (125, 1023, 11, 8),
    (126, 1029, 11, 8),
    (127, 1030, 11, 8),
    (128, 1024, 5, 8),
    (129, 1029, 5, 8),
    (130, 1024, 4, 8),
    (131, 1018, 4, 8),
    (132, 1022, 7, 8),
    (133, 1029, 7, 8),
    (134, 1025, 12, 4),
    (135, 1026, 12, 8),
    (136, 1025, 13, 4),
    (137, 1026, 13, 4),
    (138, 1026, 14, 4),
    (139, 1027, 14, 8),
    (140, 1028, 14, 8),
    (141, 1026, 15, 4),
    (142, 1027, 15, 8),
    (143, 1028, 15, 8),
    (144, 1025, 15, 4);

INSERT INTO FoodStand VALUES
    (90001,12,'Berry Blast!','Dairy-free'),
    (90002,12,'Blissful Blends','Dairy-free'),
    (90003,12,'Drink Depot','Dairy-free'),
    (90004,12,'Fizzy Frenzy','Dairy-free'),
    (90005,13,'Frosty Swirls','Gluten-free'),
    (90006,13,'Sweet Shack','Gluten-free'),
    (90007,13,'Twisted Treats','Gluten-free'),
    (90008,13,'Yummy Gummies','Gluten-free'),
    (90009,14,'Alice''s Dreamland','Gluten-free'),
    (90010,14,'Dan''s Diner','Gluten-free'),
    (90011,14,'Margharet''s Favorites','Gluten-free'),
    (90012,15,'Grilltopia','Gluten-free'),
    (90013,15,'Hot Diggity Dog','Gluten-free'),
    (90014,15,'Potato Paradise','Gluten-free'),
    (90015,15,'Street Bites','Gluten-free');

INSERT INTO Transactions VALUES 
    (8000001,42.00,'Card','2023-11-30','10:01:05',1002,1029),
    (8000002,40.00,'Cash','2023-11-30','10:45:00',1011,1024),
    (8000003,0.00,'Pass','2023-11-30','11:30:00',1010,1030),
    (8000004,0.00,'Pass','2023-11-30','12:14:00',1001,1018),
    (8000005,34.00,'Card','2023-11-30','12:20:00',1010,1027),
    (8000006,20.00,'Card','2023-11-30','13:45:00',1001,1026),
    (8000007,0.00,'Pass','2023-11-30','14:25:00',1010,1017),
    (8000008,0.00,'Pass','2023-11-30','14:50:00',1010,1018),
    (8000009,24.00,'Card','2023-11-30','15:20:00',1010,1028),
    (8000010,0.00,'Pass','2023-11-30','15:40:00',1010,1016),
    (8000011,4.00,'Cash','2023-11-30','16:15:00',1010,1025),
    (8000012,0.00,'Pass','2023-12-01','09:04:00',1014,1018),
    (8000013,24.00,'Cash','2023-12-01','09:15:00',1014,1027),
    (8000014,24.00,'Card','2023-12-01','09:45:00',1008,1025),
    (8000015,48.00,'Card','2023-12-01','09:50:00',1008,1022),
    (8000016,36.00,'Card','2023-12-01','10:05:00',1013,1029),
    (8000017,20.00,'Card','2023-12-01','10:10:00',1013,1025),
    (8000018,0.00,'Pass','2023-12-01','10:20:00',1014,1023),
    (8000019,36.00,'Card','2023-12-01','10:35:00',1008,1028),
    (8000020,10.00,'Cash','2023-12-01','10:50:00',1014,1025),
    (8000021,20.00,'Cash','2023-12-01','11:20:00',1014,1025),
    (8000022,34.00,'Card','2023-12-01','11:35:00',1013,1027),
    (8000023,0.00,'Pass','2023-12-01','11:50:00',1014,1030),
    (8000024,48.00,'Card','2023-12-01','12:25:00',1008,1024),
    (8000025,36.00,'Card','2023-12-01','12:55:00',1013,1030),
    (8000026,12.00,'Cash','2023-12-01','13:15:00',1008,1018),
    (8000027,0.00,'Pass','2023-12-01','13:25:00',1014,1029),
    (8000028,0.00,'Pass','2023-12-01','13:55:00',1015,1030),
    (8000029,40.00,'Card','2023-12-01','14:25:00',1013,1024),
    (8000030,0.00,'Pass','2023-12-01','14:45:00',1015,1022),
    (8000031,16.00,'Cash','2023-12-01','15:30:00',1011,1022),
    (8000032,12.00,'Card','2023-12-01','15:50:00',1015,1026),
    (8000033,17.00,'Card','2023-12-01','16:25:00',1015,1027),
    (8000034,16.00,'Card','2023-12-02','09:10:00',1007,1020),
    (8000035,32.00,'Card','2023-12-02','09:13:00',1004,1020),
    (8000036,12.00,'Card','2023-12-02','09:25:00',1007,1026),
    (8000037,10.00,'Card','2023-12-02','09:40:00',1004,1025),
    (8000038,12.00,'Card','2023-12-02','10:06:00',1004,1025),
    (8000039,40.00,'Card','2023-12-02','10:17:00',1012,1016),
    (8000040,12.00,'Card','2023-12-02','10:24:00',1009,1021),
    (8000041,0.00,'Pass','2023-12-02','10:36:00',1012,1017),
    (8000042,10.00,'Cash','2023-12-02','10:52:00',1009,1025),
    (8000043,32.00,'Card','2023-12-02','11:19:00',1012,1025),
    (8000044,12.00,'Card','2023-12-02','11:27:00',1012,1027),
    (8000045,0.00,'Pass','2023-12-02','11:48:00',1009,1029),
    (8000046,0.00,'Pass','2023-12-02','12:13:00',1012,1020),
    (8000047,16.00,'Cash','2023-12-02','12:47:00',1009,1030),
    (8000048,0.00,'Pass','2023-12-02','13:01:00',1012,1024),
    (8000049,0.00,'Pass','2023-12-02','13:33:00',1009,1022),
    (8000050,0.00,'Pass','2023-12-02','13:53:00',1012,1029),
    (8000051,15.00,'Card','2023-12-02','14:26:00',1009,1026),
    (8000052,15.00,'Cash','2023-12-02','15:00:00',1012,1026),
    (8000053,34.00,'Card','2023-12-02','15:20:00',1012,1027),
    (8000054,24.00,'Card','2023-12-02','15:45:00',1012,1017),
    (8000055,16.00,'Card','2023-12-02','16:20:00',1012,1026),
    (8000056,24.00,'Cash','2023-12-02','16:35:00',1012,1027),
    (8000057,24.00,'Card','2023-12-03','09:05:00',1003,1023),
    (8000058,17.00,'Card','2023-12-03','09:18:00',1003,1028),
    (8000059,12.00,'Card','2023-12-03','09:36:00',1006,1028),
    (8000060,4.00,'Cash','2023-12-03','09:44:00',1007,1025),
    (8000061,51.00,'Card','2023-12-03','09:59:00',1003,1028),
    (8000062,16.00,'Card','2023-12-03','10:03:00',1002,1018),
    (8000063,0.00,'Pass','2023-12-03','10:11:00',1006,1029),
    (8000064,40.00,'Cash','2023-12-03','10:26:00',1011,1018),
    (8000065,5.00,'Cash','2023-12-03','10:48:00',1002,1025),
    (8000066,0.00,'Pass','2023-12-03','10:57:00',1007,1030),
    (8000067,0.00,'Pass','2023-12-03','11:00:00',1003,1019),
    (8000068,24.00,'Card','2023-12-03','11:06:00',1002,1026),
    (8000069,12.00,'Card','2023-12-03','11:23:00',1003,1025),
    (8000070,0.00,'Pass','2023-12-03','11:36:00',1007,1019),
    (8000071,15.00,'Card','2023-12-03','11:43:00',1006,1025),
    (8000072,8.00,'Card','2023-12-03','12:03:00',1011,1025),
    (8000073,36.00,'Card','2023-12-03','12:12:00',1002,1029),
    (8000074,20.00,'Card','2023-12-03','12:32:00',1007,1025),
    (8000075,24.00,'Card','2023-12-03','12:46:00',1011,1022),
    (8000076,48.00,'Card','2023-12-03','12:54:00',1003,1026),
    (8000077,16.00,'Cash','2023-12-03','13:13:00',1003,1016),
    (8000078,34.00,'Card','2023-12-03','13:30:00',1011,1028),
    (8000079,0.00,'Pass','2023-12-03','13:41:00',1003,1018),
    (8000080,51.00,'Card','2023-12-03','13:56:00',1003,1028),
    (8000081,24.00,'Card','2023-12-03','14:07:00',1011,1028),
    (8000082,17.00,'Cash','2023-12-03','14:21:00',1007,1028),
    (8000083,48.00,'Card','2023-12-03','14:32:00',1007,1028),
    (8000084,0.00,'Pass','2023-12-03','14:47:00',1007,1019),
    (8000085,85.00,'Card','2023-12-03','14:58:00',1003,1028),
    (8000086,12.00,'Card','2023-12-03','15:02:00',1011,1026),
    (8000087,16.00,'Card','2023-12-03','15:19:00',1003,1022),
    (8000088,8.00,'Card','2023-12-03','15:46:00',1007,1026),
    (8000089,5.00,'Cash','2023-12-03','16:09:00',1011,1026),
    (8000090,36.00,'Card','2023-12-03','16:40:00',1003,1028);


INSERT INTO FoodTransaction VALUES
    (8000005,90010,2),
    (8000006,90003,4),
    (8000009,90013,2),
    (8000011,90003,1),
    (8000013,90012,2),
    (8000014,90003,6),
    (8000017,90008,4),
    (8000019,90015,3),
    (8000020,90006,2),
    (8000021,90001,5),
    (8000022,90011,2),
    (8000032,90002,6),
    (8000033,90010,1),
    (8000036,90014,1),
    (8000037,90005,2),
    (8000038,90001,3),
    (8000042,90007,2),
    (8000043,90003,8),
    (8000044,90012,1),
    (8000051,90008,3),
    (8000052,90006,3),
    (8000053,90009,2),
    (8000055,90002,4),
    (8000056,90014,2),
    (8000058,90010,1),
    (8000059,90013,2),
    (8000060,90004,1),
    (8000061,90011,3),
    (8000065,90005,1),
    (8000068,90015,2),
    (8000069,90001,3),
    (8000071,90008,3),
    (8000072,90003,2),
    (8000074,90006,4),
    (8000076,90014,4),
    (8000078,90009,2),
    (8000080,90009,3),
    (8000081,90012,2),
    (8000082,90011,1),
    (8000083,90013,4),
    (8000085,90010,5),
    (8000086,90002,3),
    (8000088,90004,2),
    (8000089,90005,1),
    (8000090,90015,3);

INSERT INTO RideTransaction VALUES
    (8000001,36,6),
    (8000002,23,2),
    (8000003,50,8),
    (8000004,26,8),
    (8000007,43,5),
    (8000008,32,8),
    (8000010,19,4),
    (8000012,41,7),
    (8000015,11,4),
    (8000016,30,3),
    (8000018,52,2),
    (8000023,13,2),
    (8000024,28,4),
    (8000025,48,3),
    (8000026,21,1),
    (8000027,49,5),
    (8000028,14,8),
    (8000029,25,2),
    (8000030,46,2),
    (8000031,38,2),
    (8000034,18,2),
    (8000035,34,4),
    (8000039,16,5),
    (8000040,42,3),
    (8000041,31,3),
    (8000045,53,1),
    (8000046,20,8),
    (8000047,44,4),
    (8000048,27,4),
    (8000049,12,2),
    (8000050,35,2),
    (8000054,22,2),
    (8000057,51,2),
    (8000062,17,2),
    (8000063,40,2),
    (8000064,26,2),
    (8000066,54,1),
    (8000067,45,1),
    (8000070,45,4),
    (8000073,29,3),
    (8000075,39,3),
    (8000077,33,2),
    (8000079,24,2),
    (8000084,45,5),
    (8000087,37,2);