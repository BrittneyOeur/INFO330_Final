# INFO 330: Database Systems and Data Modeling (FINAL)
## Group Project
### Team:
- Brittney Oeur
- Maisara Mackeen
- Nessa Choi
  
### Purpose
The purpose of this project is to give you hands-on experience in database development. The process of database development goes through phases from conceptual design to implementation and maintenance of the database. The design phase can particularly be very challenging since it is less structured. Specifically, the project will reinforce the following learning objectives:
- Evaluate the information needs of the target organization, and effectively model the data using the entity-relationship model and the relational model.
- Design and implement a physical model based on principles of relational database design, and the organization’s needs regarding data, data organization, and data storage.
- Develop working SQL statements for simple and intermediate queries to create and modify data and database objects to store, manipulate, and analyze company data.

## Fictitious Carnival Business Model

## Description of The Business/Organization

Our business is similar to the familiar seasonal attraction in Washington State, the Washington State Fair. It takes place in a 165-acre venue that consists of a plethora of attractions: amusement rides, food stands, merchandise stands, recreational events, conventions, and petting zoos. Thousands of people prepare for these types of festivals, which means there will be a large number of customers, employees, transactions, and potential issues.

Having a large number of people within a confined area can cause crowding and long wait times for popular attractions within the venue. When wait times increase, customer experiences decrease dramatically. So, we aim to create a database for a mobile application that can be useful for managers and customers alike, to inform them about the wait times and crowd zones so they can plan their actions accordingly.  It will also allow managers to accurately place employees where necessary and track the sales of merchandising.

Not only should the mobile application address problem areas of the state fair, but also provide general information to customers, such as amusement ride restrictions, store inventory, ticket pricing, and allergy concerns. This will bring transparency and convenience to our customers and elevate their experience at our carnival.

## Identification of the Information Needs

With the elevation of customer experience as our main focus, a mobile application equipped with everything about our carnival would benefit both the patrons and our staff. For the rides we offer, waiting times are crucial information. Knowing the wait times for each of our attractions to update them in real-time in our mobile application would let customers estimate and plan their rides accordingly. We also need to identify capacity limits per ride to help us control the number of people per ride to ensure operational efficiency and rider satisfaction. With the waiting times and capacity limits in our grip, the employees will also have a better idea of ways to manage the attractions more effectively.

Another useful piece of information for us to know is the sales from each food stall and merchandise store for inventory purposes. Knowing the average spending from each group of customers could also help us set our prices accordingly. All the information above, along with restrictions and allergy concerns, will also be displayed in our application so customers can plan.

We also will have to keep track of the transactions during ticket reservations and in our carnival shops. Records of transactions will be convenient in cases of refunds and our business’ financial records.

## Entities List
### Main Entities
- **Customer:** PK FK: Customer_ID, Number_of_Tickets
- **Employee:** PK FK: Employee_ID, Job_Title, Hourly_Rate, Hiring_Date, Employment_End_Date 
- **Attraction:** PK: Attraction_ID, Attraction_Type, Attraction_Cost, Height_Requirement, Attraction_Capacity
- **Attraction_Assignment:** PK: Assignment_ID, FK: Employee_ID, FK: Attraction_ID, Num_of_Hours
- **Transaction:** PK: Transaction_ID, FK: Customer_ID, FK: Employee_ID, Total_Amount, Payment_Method, Transaction_Date, Transaction_Time

### Sub Entities
- **Contact:** PK: Person_ID, First_Name, Last_Name. Phone_Number. Email_Address
- **Ride:** PK: Ride_ID, FK: Attraction_ID, Type, Name, Ride_Pass
- **FoodStand:** PK: FoodStand_ID, FK: Attraction_ID, Food_Stand_Name, Allergy_Type
- **Food_Transaction:** PK FK: Transaction_ID, PK FK: FoodStand_ID, Num_Food
- **Ride Transaction:** PK FK: Transaction_ID, PK FK: Ride_ID, Ticket_Sold

## Business Rules
- A customer can generate many invoices (engage in multiple transactions, such as buying tickets for rides and food)
- Many customers visit and interact with many attractions, and attractions can have multiple customers
- Employees can facilitate multiple transactions (ex: Selling tickets to multiple customers)
- Only one employee can facilitate a single transaction
- Many customers can interact with many employees
- Employees can operate and manage multiple attractions, and attractions may require the presence of multiple employees
- Transaction can occur at any type of attractions
- Each attraction may be associated with multiple transactions, as multiple customers may use transactions to access it (such as going on rides and buying food at stands)
- Different attractions can encompass various sub-entities (such as various rides and food stands)
- Transactions can involve multiple sub-entities, and each sub-entity can be part of multiple transactions (such as a single transaction may include tickets for a ride and food).
- Each employee typically has one set of contact information

## Preliminary Conceptual Model:
![unnamed (1)](https://github.com/BrittneyOeur/INFO330_Final/assets/72583051/599d16f7-d280-4614-81b0-94762ea2b719)

## Logical Data Modeling:
![unnamed (2)](https://github.com/BrittneyOeur/INFO330_Final/assets/72583051/99bea506-2982-4931-a2a4-1f018c0924c0)


