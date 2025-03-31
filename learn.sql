CREATE TABLE Flights (
    flight_id VARCHAR(10) PRIMARY KEY,
    aircraft_type VARCHAR(20) NOT NULL
);

CREATE TABLE FlightArrivals (
    arrival_id INT AUTO_INCREMENT PRIMARY KEY,
    flight_id VARCHAR(10) NOT NULL,
    aibt DATETIME NOT NULL,  -- Actual In-Block Time
    trip_time TIME NOT NULL,  -- Time from arrival to baggage claim
    earliest_pickup_minutes INT NOT NULL DEFAULT 11, 
    first_bag_on_belt_minutes INT NOT NULL DEFAULT 15, -- aibt + first_bag_on_belt_minutes = deadline
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);

CREATE TABLE Drivers (
    driver_id VARCHAR(10) PRIMARY KEY,
    driver_name VARCHAR(50) NOT NULL
);

CREATE TABLE Tasks (
    task_id INT AUTO_INCREMENT PRIMARY KEY,
    arrival_id INT NOT NULL,
    driver_id VARCHAR(10) NOT NULL,
    task_number ENUM('1', '2', '3', '4') NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    FOREIGN KEY (arrival_id) REFERENCES FlightArrivals(arrival_id),
    FOREIGN KEY (driver_id) REFERENCES Drivers(driver_id)
);

-- Insert sample flights
INSERT INTO Flights (flight_id, aircraft_type) VALUES
('SQ391', 'Widebody'),
('SQ246', 'Widebody'),
('SQ825', 'Widebody'),
('SQ403', 'A380');

-- Insert sample arrivals
INSERT INTO FlightArrivals (flight_id, aibt, trip_time, earliest_pickup_minutes, first_bag_on_belt_minutes) VALUES
('SQ391', '2023-09-16 05:08:00', '00:02:37', 11, 15),
('SQ246', '2023-09-16 05:11:00', '00:01:31', 11, 15),
('SQ825', '2023-09-16 05:27:00', '00:01:03', 11, 15),
('SQ403', '2023-09-16 05:48:00', '00:01:09', 11, 15);

-- Insert sample drivers
INSERT INTO Drivers (driver_id, driver_name) VALUES
('Driver1', 'John Smith'),
('Driver2', 'Emma Johnson'),
('Driver3', 'Michael Brown'),
('Driver4', 'Sarah Davis');

-- Insert sample tasks (get arrival_id from FlightArrivals)
INSERT INTO Tasks (arrival_id, driver_id, task_number, start_time, end_time) VALUES
(1, 'Driver1', '1', '2023-09-16 05:19:00', '2023-09-16 05:23:37'),
(1, 'Driver1', '2', '2023-09-16 05:23:00', '2023-09-16 05:27:37'),
(2, 'Driver2', '1', '2023-09-16 05:22:00', '2023-09-16 05:25:31'),
(3, 'Driver3', '1', '2023-09-16 05:38:00', '2023-09-16 05:41:03'),
(4, 'Driver4', '1', '2023-09-16 05:59:00', '2023-09-16 06:02:09'),
(4, 'Driver4', '2', '2023-09-16 06:07:24', '2023-09-16 06:10:33');



ALTER TABLE `Tasks` ADD COLUMN `is_completed` BOOLEAN DEFAULT FALSE;


TRUNCATE TABLE `Tasks`;