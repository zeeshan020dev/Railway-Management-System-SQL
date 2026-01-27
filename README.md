# Railway Management System (Database Project)

This repository contains the SQL database schema for a comprehensive Railway Management System. This project is designed to handle various aspects of a railway network, including passenger information, ticket booking, train scheduling, and staff management. It utilizes advanced SQL features like triggers, stored procedures, views, and functions to maintain data integrity and automate processes.

## Project Overview

The core of this project is a relational database built with SQL Server. It's designed to serve as the backend for a railway management application. The system efficiently manages the relationships between passengers, their tickets, the trains they travel on, and the routes they take.

## Features

* **Passenger Management:** Stores and manages personal and contact information for passengers.
* **Dynamic Ticket Pricing:** Calculates ticket prices based on travel class, route, and number of tickets.
* **Train and Route Management:** Manages train details, capacities, and the routes they operate on.
* **Scheduling:** Handles departure and arrival times for all trips.
* **Staff & Salary Information:** Manages staff details and their corresponding salary structures.
* **Automated Data Entry:** Uses a central `ENTRY` table and triggers to automatically populate the `Passenger` and `Ticket` tables.
* **Data Auditing:** Triggers are used to create backups of records before they are updated or inserted.
* **Data Deletion Procedure:** A stored procedure to safely delete a booking and all related passenger and ticket information.
* **Informational Views:** A view is created to provide a simplified and combined look at staff and salary information.

## Database Schema

The database consists of the following tables:

| Table Name | Description |
| :--- | :--- |
| **Passenger** | Stores details of each passenger. |
| **TicketPricing** | A fixed table that stores the price multiplier for each ticket class (Economy, Business, etc.). |
| **Train** | Contains information about each train, including its name and capacity. |
| **T_Route** | Defines the various routes, linking departure and arrival stations with a base price. |
| **TripSchedule** | Stores the departure and arrival times for different schedules. |
| **Station** | Contains information about all the railway stations. |
| **Staff** | Stores information about all employees. |
| **SalaryInfo** | Stores salary details based on staff rank. |
| **Ticket** | The main transaction table, storing details for each booked ticket. |
| **ENTRY** | A staging table for new bookings. Data inserted here is automatically moved to the `Passenger` and `Ticket` tables by triggers. |
| **BI_... & BU_...** | Backup tables that log insertions and updates on critical tables like `Passenger`, `Ticket`, etc. |

### Entity-Relationship Diagram Concept


[Passenger] --< [Ticket] >-- [T_Route]
[Ticket] >-- [TicketPricing]
[Ticket] >-- [TripSchedule]
[T_Route] >-- [Train]
[Staff] >-- [SalaryInfo]


## SQL Features Used

This project demonstrates proficiency in several key database concepts:

* **Triggers:**
    * `P` and `TIC` on the `ENTRY` table to automate the process of creating a new passenger and a corresponding ticket when a new record is inserted.
    * Triggers on `Passenger`, `T_Route`, `TripSchedule`, `Staff`, and `Ticket` tables to log the `BEFORE UPDATE` and `AFTER INSERT` states of the data into backup tables.
* **Stored Procedures:**
    * `DELETE_ENTRY`: A procedure that takes a `TicketID` and deletes the corresponding records from the `Ticket`, `Passenger`, and `ENTRY` tables, ensuring data consistency.
* **Functions:**
    * `CLASS`: Returns the price multiplier for a given ticket class.
    * `GET_ROUTEID`: Fetches the `RouteID` for a given departure and arrival station.
    * `GET_PRICE`: Fetches the base price for a given route.
    * `TOTAL_PRICE`: A comprehensive function that calculates the final ticket price by combining the results of the other functions with the number of tickets.
* **Views:**
    * `StaffInfo`: A view that joins the `Staff` and `SalaryInfo` tables to present a clean, consolidated view of staff details along with their rank and salary.
* **Joins:**
    * Used extensively in views and select queries to retrieve comprehensive information, such as the complete details of a ticket booking.

## How to Use

1.  **Setup the Database:**
    * Create a new database named `RAILWAY`.
    * Execute the entire `Railway Management System (DBS Project).sql` script. This will create all the tables, views, functions, triggers, and stored procedures.

2.  **Book a Ticket (Insert Data):**
    * To create a new booking, you only need to insert a record into the `ENTRY` table.
    * The triggers `P` and `TIC` will automatically handle the rest, creating a new `Passenger` and a new `Ticket` with all the calculated details.

    ```sql
    -- Example of booking a single ticket from Lahore to Karachi in Economy class
    INSERT INTO ENTRY (PassengerID, Name, Age, Address, AccountNo, Phone, Email, ClassName, DepartureStation, ArrivalStation, NumberOfTickets)
    VALUES (1, 'Ali', 20, 'Bhobatian', 'Meezan1001', '03011019187', 'ali@gmail.com', 'Economy', 'Lahore', 'Karachi', 1);
    ```

3.  **Delete a Booking:**
    * To cancel or delete a booking, use the `DELETE_ENTRY` stored procedure with the corresponding `ID` (which is the same for `PassengerID` and `TicketID`).

    ```sql
    -- Example of deleting the booking with ID = 2
    EXEC DELETE_ENTRY @ID = 2;
    ```

4.  **Querying Information:**
    * You can use the predefined views or write your own `JOIN` queries to get detailed reports.

    ```sql
    -- Get a complete overview of all booked tickets
    SELECT T.TicketID, P.Name, TP.ClassName, TR.DepartureStation, TR.ArrivalStation, TS.DepartureTime, TS.ArrivalTime, T.NumberOfTickets, T.TotalPrice
    FROM Ticket T
    INNER JOIN Passenger P ON T.PassengerID = P.PassengerID
    INNER JOIN TicketPricing TP ON T.ClassName = TP.ClassName
    INNER JOIN TripSchedule TS ON T.TicketID = TS.ScheduleID
    INNER JOIN T_Route TR ON T.RouteID = TR.RouteID;

    -- Get consolidated staff information using the view
    SELECT * FROM StaffInfo;
    ```

---

## 👤 Authors

**[Muhammad Zeeshan Islam](https://github.com/zeeshan020dev)**

[![GitHub](https://img.shields.io/badge/GitHub-zeeshan020dev-black?logo=github)](https://github.com/zeeshan020dev)

**[Rana Ali Husnain](https://github.com/AliHusnain05)**

[![GitHub](https://img.shields.io/badge/GitHub-AliHusnain05-black?logo=github)](https://github.com/AliHusnain05)

---
