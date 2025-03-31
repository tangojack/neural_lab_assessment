
-- This SQL script creates a database schema for managing flight arrivals, drivers, and tasks.

-- Flight table stores information about flights. Keeping it normalized to avoid redundancy.
CREATE TABLE flights (
    flight_id VARCHAR(10) PRIMARY KEY,
    aircraft_type VARCHAR(20) NOT NULL
);

-- Arrival table stores information about flight arrivals as a ONE-TO-MANY relationship with the Flights table.
-- It includes the flight_id as a foreign key to link to the Flights table.
CREATE TABLE arrivals (
    arrival_id INT AUTO_INCREMENT PRIMARY KEY,
    flight_id VARCHAR(10) NOT NULL,
    aibt DATETIME NOT NULL, 
    trip_time TIME NOT NULL, 
    earliest_pickup_minutes INT NOT NULL DEFAULT 11, 
    first_bag_on_belt_minutes INT NOT NULL DEFAULT 15,
    status ENUM('In Progress', 'Completed On Time', 'Delayed') DEFAULT 'In Progress',
    FOREIGN KEY (flight_id) REFERENCES flights(flight_id)
);

-- Driver table stores information about drivers. Keeping it normalized to avoid redundancy.
CREATE TABLE drivers (
    driver_id VARCHAR(10) PRIMARY KEY,
    driver_name VARCHAR(50) NOT NULL
);

-- Task table stores information about tasks assigned to drivers for each flight arrival.
-- There will be 4 tasks for each flight arrival. Which is why a ONE-TO-MANY relationship is established with the Arrivals table.
-- It includes the arrival_id as a foreign key to link to the Arrivals table.
-- The task_number is an ENUM to restrict the values to '1', '2', '3', or '4'.
-- The start_time and end_time are DATETIME fields to record the time taken for each task. This will be used
-- to mark if the Arrival is completed on time or delayed.
-- The is_completed column is added to track the completion status of each task.
CREATE TABLE tasks (
    task_id INT AUTO_INCREMENT PRIMARY KEY,
    arrival_id INT NOT NULL,
    driver_id VARCHAR(10) NOT NULL,
    task_number ENUM('1', '2', '3', '4') NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME,
    is_completed BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (arrival_id) REFERENCES arrivals(arrival_id),
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id)
);

-- Insert sample flights
INSERT INTO flights (flight_id, aircraft_type) VALUES
('SQ391', 'Widebody'),
('SQ246', 'Widebody'),
('SQ825', 'Widebody'),
('SQ403', 'A380');

-- Insert sample arrivals
INSERT INTO arrivals (flight_id, aibt, trip_time, earliest_pickup_minutes, first_bag_on_belt_minutes) VALUES
('SQ391', '2023-09-16 05:08:00', '00:02:37', 11, 15),
('SQ246', '2023-09-16 05:11:00', '00:01:31', 11, 15),
('SQ825', '2023-09-16 05:27:00', '00:01:03', 11, 15),
('SQ403', '2023-09-16 05:48:00', '00:01:09', 11, 15);

-- Insert sample drivers
INSERT INTO drivers (driver_id, driver_name) VALUES
('Driver1', 'John Smith'),
('Driver2', 'Emma Johnson'),
('Driver3', 'Michael Brown'),
('Driver4', 'Sarah Davis');

-- We won't insert sample tasks here as they will be generated based on the arrivals and drivers available.
-- Please move on to the ipython notebook to generate tasks for each arrival.
