# Neural Lab Baggage Efficiency

This project is designed to simulate baggage assignment.

# Notes about future Add-ons

All of the utility functions can be written as REST endpoints. I have used Django Rest Framwework in the past and a simple web app can be written for the above.

Using Django's models features, and authentication (for drivers), we can ensure this software is fully tested, is safe as works as expected in an efficient way. 

# Notes about Design

The reason I opted for a simulator rather than an analyzer, is to setup tidy data and clean code for analysis to take place in a reproducible manner (DRY: Don't repeat yourself)

Future insights and optimizations can be derived efficiently once the structure is in place in a server and all the functions have been tested.

# Notes about Models

Like every business solution, I start of with creating simple models to understand the different entities in the problem.

It can be more normalized in the future to include reports for delayed flights, priority flights etc.

![alt text](<Neural Lab.drawio.png>)

## Installation

To set up the MySQL engine and execute the `run.sql` file, follow these steps:

1. Install MySQL and ensure it is running on your system.
2. Create a MySQL database and user with appropriate permissions.
3. Update the connection details in your configuration file if required.
4. Run the following command to execute the `run.sql` file:

```bash
mysql -u <username> -p <database_name> < run.sql
```

To get started, install the required dependencies:

```bash
pip install -r requirements.txt
```

## Usage

Run the `run.ipynb` jupyter notebook in your local shell