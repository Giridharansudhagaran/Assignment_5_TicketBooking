CREATE DATABASE TicketBooking

CREATE TABLE Venu(
venue_id int primary key,
venue_name varchar(50),
address varchar(50))

INSERT INTO Venu values 
(1, 'Grand Theater', '123 Main Street'),
  (2, 'City Stadium', '456 Elm Street'),
  (3, 'Music Hall', '789 Oak Street'),
  (4, 'Art Gallery', '1011 Pine Street'),
  (5, 'Community Center', '1213 Spruce Street'),
  (6, 'Open Air Theater', '1415 Maple Street'),
  (7, 'Town Hall', '1617 Birch Street, Anytown'),
  (8, 'Movie Theater', '1819 Poplar Street'),
  (9, 'Exhibition Center', '2021 Willow Street'),
  (10, 'Library Auditorium', '2223 Elm Street')

CREATE TABLE Event(
event_id int primary key,
event_name varchar(50),
event_date date,
event_time time(0), --- Eliminates milleseconds seconds
venue_id int ,
FOREIGN KEY(venue_id) REFERENCES Venu(venue_id),
total_seats int ,
available_seats int ,
ticket_price decimal(10,2),
event_type varchar(50) check (event_type in ('Movie','Sports','Concert')),
booking_id int)

INSERT INTO Event(event_id,event_name,event_date,event_time,venue_id,total_seats,available_seats,ticket_price,event_type)
VALUES  (1,'Blockbuster Movie', '2024-03-15', '19:00:00',1, 10000, 8000, 1250, 'Movie'),
  (2,'Rock Concert', '2024-04-20', '20:00:00',2, 15000, 12000, 1750, 'Concert'),
  (3,'XBasketball Game', '2024-05-12', '18:00:00',3, 8000, 6000, 2250, 'Sports'),
  (4,'Art Exhibition', '2024-06-01', '10:00:00',4, 7000, 5000, 2750, 'Movie'),
  (5,'XYZ Play', '2024-07-04', '19:30:00',5, 5000, 4000, 1200, 'Movie'),
  (6,'Independent Film', '2024-08-10', '14:00:00',6, 6000, 0, 3750, 'Movie'),
  (7,'Football Cup', '2024-09-22', '16:00:00', 7,12000, 9000, 4250, 'Sports'),
  (8,'Family Concert', '2024-10-27', '13:00:00',8, 9000, 7000, 4750, 'Concert'),
  (9,'World Cup', '2024-11-17', '11:00:00',9, 5500, 1500, 999, 'Sports'),
  (10,'Holiday Special', '2024-12-25', '20:00:00',10, 20000, 15000, 1500, 'Concert');

UPDATE Event SET venue_id = 3 where event_id = 2UPDATE Event SET venue_id = 7 where event_id = 6
INSERT INTO Event(event_id,event_name,event_date,event_time,venue_id,total_seats,available_seats,ticket_price,event_type) 
values (11,'LanaDelRay Special', '2023-12-25', '20:00:00',10, 100, 50, 1500, 'Concert')
SELECT * FROM Event

CREATE TABLE Customer(
customer_id int primary key,
customer_name varchar(50),
email varchar(50),
phone_number varchar(20),
booking_id int)

INSERT INTO Customer (customer_id, customer_name, email, phone_number) 
VALUES
  (1, 'John Doe', 'john.doe@example.com', 9360043850),
  (2, 'Jane Smith', 'jane.smith@example.com', 9876543000),
  (3, 'Michael Johnson', 'michael.johnson@example.com', 5551234567),
  (4, 'Sarah Lee', 'sarah.lee@example.com', 2223334444),
  (5, 'David Brown', 'david.brown@example.com', 8765432000),
  (6, 'Emily Garcia', 'emily.garcia@example.com', 1112223333),
  (7, 'Daniel Hernandez', 'daniel.hernandez@example.com', 4445556666),
  (8, 'Elizabeth Martinez', 'elizabeth.martinez@example.com', 3332221111),
  (9, 'Robert Wilson', 'robert.wilson@example.com', 7778889999),
  (10, 'Amanda Gonzalez', 'amanda.gonzalez@example.com', 6665554000);


SELECT * FROM Customer

CREATE TABLE Booking(
booking_id int primary key,
customer_id int,
FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
event_id int,
FOREIGN KEY (event_id) REFERENCES Event(event_id),
num_tickets int ,
total_cost decimal,
booking_date date)

INSERT INTO Booking(booking_id,customer_id,event_id,num_tickets,booking_date)
VALUES
    (1, 1, 1, 10, '2024-12-25'),
    (2, 2, 2, 15, '2024-05-12'),
    (3, 3, 3, 7, '2024-09-25'),
    (4, 4, 4, 12, '2024-09-30'),
    (5, 5, 5, 2, '2024-08-10'), 
    (6, 6, 6, 18, '2024-06-01'),
    (7, 7, 7, 4, '2024-10-15'),
    (8, 8, 8, 20, '2024-10-20'),
    (9, 9, 9, 12, '2024-10-27'),
    (10, 10, 10, 15, '2024-11-01');

UPDATE Booking SET  customer_id = 3 where booking_id = 2UPDATE Booking SET event_id =7 where booking_id = 6UPDATE Booking SET booking_date = '2024-03-03' where booking_id = 11INSERT INTO Booking (booking_id,customer_id,event_id,num_tickets,booking_date) VALUES (11,10,10,6,'2024-07-15')
INSERT INTO Booking(booking_id,customer_id,event_id,num_tickets,booking_date) VALUES (12, 9, 11, 50, '2024-11-01')

UPDATE BookingSET Booking.total_cost = (Booking.num_tickets * Event.ticket_price)FROM BookingJOIN EVENT ON Booking.event_id = Event.event_id
SELECT * FROM Booking

---ADD FOREIGN KEY

ALTER TABLE Event
ADD FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
ALTER TABLE Customer 
ADD FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)

UPDATE Event 
SET Event.booking_id = Booking.booking_id
FROM Event
JOIN Booking ON Event.event_id = Booking.event_id;

UPDATE Customer
SET Customer.booking_id = Booking.booking_id
FROM Customer
JOIN Booking ON Customer.customer_id = Booking.customer_id
---Task 2
--- 1. QUERY TO INSERT 10 ROWS COMPLETED 
--- 2. Write a SQL query to list all Events
SELECT event_name FROM Event

--- 3. Write a SQL query to select events with available tickets
SELECT event_name,available_seats FROM Event WHERE available_seats > 0;

--- 4. Write a SQL query to select events name partial match with ‘cup’
SELECT event_name FROM Event WHERE event_name LIKE ('%cup%')

--- 5. Write a SQL query to select events with ticket price range is between 1000 to 2500.
SELECT * FROM Event WHERE ticket_price BETWEEN 1000 AND 2500

--- 6. Write a SQL query to retrieve events with dates falling within a specific range.
SELECT * FROM Event WHERE event_date BETWEEN '2024-01-01' AND '2024-08-29'

--- 7. Write a SQL query to retrieve events with available tickets that also have "Concert" in their Name
SELECT * FROM Event WHERE available_seats > 0 AND  event_type = 'Concert'

--- 8. Write a SQL query to retrieve users in batches of 5, starting from the 6th user
SELECT * FROM Customer ORDER BY customer_id OFFSET 5 ROWS  FETCH NEXT 5 ROWS ONLY

--- 9.  Write a SQL query to retrieve bookings details contains booked no of ticket more than 4.
SELECT * FROM Booking WHERE num_tickets > 4 

--- 10. Write a SQL query to retrieve customer information whose phone number end with ‘000’
SELECT * FROM Customer WHERE phone_number LIKE ('%000')

--- 11.  Write a SQL query to retrieve the events in order whose seat capacity more than 15000.
SELECT * FROM Event WHERE total_seats > 15000

--- 12.  Write a SQL query to select events name not start with ‘x’, ‘y’, ‘z’
SELECT event_name FROM Event WHERE event_name NOT LIKE ('X%') AND event_name NOT LIKE ('Y%') AND event_name NOT LIKE ('Z%')
SELECT event_name FROM Event WHERE event_name NOT LIKE '[xyz]%'

---TASK - 3

---1. Write a SQL query to List Events and Their Average Ticket Prices
SELECT event_type,FORMAT(ROUND(AVG(ticket_price),2),'N2') as AVERAGE FROM Event GROUP BY event_type

---2. 2. Write a SQL query to Calculate the Total Revenue Generated by Events.SELECT Event.event_type ,SUM(Booking.num_tickets * Event.ticket_price) as total_revenuefrom BookingJOIN Event ON Booking.booking_id = Event.booking_idGROUP BY event_type---3. Write a SQL query to find the event with the highest ticket salesSELECT Event.event_type,SUM(Booking.num_tickets) as total_ticketsFROM EventJOIN Booking ON Event.event_id = Booking.event_idGROUP BY event_typeORDER BY total_tickets DESCOFFSET 0 ROWSFETCH NEXT 1 ROW ONLY---4. Write a SQL query to Calculate the Total Number of Tickets Sold for Each Event.SELECT Event.event_name,SUM(Booking.num_tickets) as total_ticketsFROM Event JOIN Booking ON Event.event_id = Booking.event_idGROUP BY Event.event_name---5. Write a SQL query to Find Events with No Ticket Sales.SELECT Event.event_name
FROM Event
LEFT JOIN Booking ON Event.event_id = Booking.event_id
WHERE Booking.event_id IS NULL;---6. Write a SQL query to Find the User Who Has Booked the Most Tickets.SELECT Customer.customer_name,SUM(Booking.num_tickets) as total_ticketsFROM CustomerJOIN Booking ON Customer.customer_id = Booking.customer_idGROUP BY Customer.customer_nameORDER BY total_tickets DESCOFFSET 0 ROWS FETCH NEXT 1 ROW ONLY---7. Write a SQL query to List Events and the total number of tickets sold for each monthSELECT Event.event_name,DATENAME(MONTH,Event.event_date) as [Month_list],SUM(Booking.num_tickets) as total_ticketsFROM EventJOIN Booking ON Event.event_id = Booking.event_id GROUP BY Event.event_name,DATENAME(MONTH,Event.event_date)---8. Write a SQL query to calculate the average Ticket Price for Events in Each Venue.SELECT Venu.venue_name,AVG(Event.ticket_price) as Average FROM VenuJOIN Event ON Venu.venue_id = Event.venue_idGROUP BY Venu.venue_name---9. Write a SQL query to calculate the total Number of Tickets Sold for Each Event TypeSELECT Event.event_type,SUM(Booking.num_tickets) as Tickets_soldFROM Event JOIN Booking ON Event.event_id = Booking.event_idGROUP BY Event.event_type---10. Write a SQL query to calculate the total Revenue Generated by Events in Each YearSELECT Event.event_name,DATENAME(YEAR,Booking.booking_date) as YearList ,SUM(Booking.total_cost) as total_revenue FROM EventJOIN Booking ON Event.event_id = Booking.event_idGROUP BY Event.event_name,DATENAME(YEAR,Booking.booking_date)---11. Write a SQL query to list users who have booked tickets for multiple events.SELECT Customer.customer_name,COUNT(Booking.customer_id) as booked_ticketsFROM CustomerJOIN Booking ON Customer.customer_id = Booking.customer_idGROUP BY Customer.customer_nameHAVING COUNT(Booking.customer_id) > 1---12. Write a SQL query to calculate the Total Revenue Generated by Events for Each User.SELECT Event.event_name,Customer.customer_name,SUM(Booking.total_cost) as total_revenueFROM CustomerJOIN Booking ON Customer.customer_id = Booking.customer_idJOIN Event ON Event.event_id = Booking.event_idGROUP BY Event.event_name,Customer.customer_name---13. Write a SQL query to calculate the Average Ticket Price for Events in Each Category and Venue.SELECT Venu.venue_name,Event.event_type,SUM(Event.ticket_price) as average_priceFrom EventJOIN Venu ON Event.venue_id = Venu.venue_idGROUP BY Venu.venue_name,Event.event_type---14. Write a SQL query to list Users and the Total Number of Tickets They've Purchased in the Last 30 DaysSELECT Customer.customer_name ,Booking.booking_date ,SUM(Booking.num_tickets) AS tickets_bookedFROM CustomerJOIN Booking ON Customer.customer_id = Booking.customer_idWHERE Booking.booking_date BETWEEN DATEADD(DAY, -30, GETDATE()) AND GETDATE()GROUP BY Customer.customer_name, Booking.booking_date---Task 4---1. Calculate the Average Ticket Price for Events in Each Venue Using a SubquerySELECT venue_name,(SELECT AVG(ticket_price) from Event where Event.venue_id = Venu.venue_id ) as Average_priceFROM Venu---2 Find Events with More Than 50% of Tickets Sold using subquerySELECT event_name,(SELECT SUM(num_tickets) from Booking where Booking.event_id = Event.event_id ) AS tickets_sold FROM EventWHERE (SELECT SUM(num_tickets) from Booking where Booking.event_id = Event.event_id ) >= (Event.total_seats * 0.5)---3. Calculate the Total Number of Tickets Sold for Each Event.
SELECT event_name,ISNULL((SELECT SUM(num_tickets) from Booking where Booking.event_id = Event.event_id),0) AS Tickets_sold FROM Event---4. Find Users Who Have Not Booked Any Tickets Using a NOT EXISTS Subquery.
Select customer_id,customer_name from Customer WHERE NOT EXISTS 
(SELECT customer_id From Booking where Booking.customer_id = Customer.customer_id)

---5. List Events with No Ticket Sales Using a NOT IN Subquery.
SELECT event_name From Event WHERE event_id NOT IN 
(SELECT event_id From Booking where Booking.event_id = Event.event_id)
---6. Calculate the Total Number of Tickets Sold for Each Event Type Using a Subquery in the FROM Clause.SELECT event_type,SUM(E.tickets_sold) FROM(SELECT event_type,(SELECT SUM(num_tickets) From Booking where Booking.event_id = Event.event_id) as tickets_sold FROM Event GROUP BY event_type,Event.event_Id) AS EGROUP BY event_type---7. Find Events with Ticket Prices Higher Than the Average Ticket Price Using a Subquery in the WHERE Clause.SELECT event_name,ticket_price from Eventwhere ticket_price > (SELECT AVG(ticket_price) FROM Event) ---8. Calculate the Total Revenue Generated by Events for Each User Using a Correlated Subquery.
SELECT Customer.customer_id, Customer.customer_name,
     (
        SELECT SUM(Booking.num_tickets * Event.ticket_price) 
        FROM Booking 
        JOIN Event ON Booking.event_id = Event.event_id 
        WHERE Booking.customer_id = Customer.customer_id
    ) AS total_revenue FROM Customer;

---9. List Users Who Have Booked Tickets for Events in a Given Venue Using a Subquery in the WHERE Clause.DECLARE @venueid int = 3SELECT Customer_name
FROM Customer
WHERE Customer.customer_id IN (
    SELECT DISTINCT Booking.customer_id
    FROM Booking
    JOIN Event ON Booking.event_id = Event.event_id
    WHERE Event.venue_id = @venueid
)
---10. Calculate the Total Number of Tickets Sold for Each Event Category Using a Subquery with GROUP BY.
SELECT E.event_type,SUM(E.tickets_sold) 
FROM (SELECT event_type ,
(SELECT SUM(num_tickets) FROM Booking where Booking.event_id = Event.event_id) as tickets_sold
FROM Event 
GROUP BY Event.event_type,Event.event_id) AS E
GROUP BY E.event_type

---11. Find Users Who Have Booked Tickets for Events in each Month Using a Subquery with DATE_FORMAT
SELECT DISTINCT
    c.customer_id,
    c.customer_name,
    DATENAME (month, b.booking_date) AS booking_month
FROM Customer c
INNER JOIN Booking b ON c.customer_id = b.customer_id
GROUP BY
    c.customer_id,
    c.customer_name,
	DATENAME (month, b.booking_date)


---12. Calculate the Average Ticket Price for Events in Each Venue Using a Subquery
SELECT venue_name,(SELECT AVG(ticket_price) from Event where Event.venue_id = Venu.venue_id ) as Average_priceFROM Venu
