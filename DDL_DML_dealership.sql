-- create a table for the customer
CREATE TABLE IF NOT EXISTS customer(
	customer_id serial PRIMARY KEY,
	first_name varchar(25) NOT NULL,
	last_name varchar(25) NOT NULL
);

-- create table for the sales employees
CREATE TABLE IF NOT EXISTS sales(
	sales_id serial PRIMARY KEY,
	first_name varchar(25) NOT NULL,
	last_name varchar(25) NOT NULL
);

-- create a table for the mechanics
CREATE TABLE IF NOT EXISTS mechanic(
	mechanic_id serial PRIMARY KEY,
	first_name varchar(25) NOT NULL,
	last_name varchar(25) NOT NULL
);

-- create a table for the cars
CREATE TABLE IF NOT EXISTS car(
	car_id serial PRIMARY KEY,
	make varchar NOT NULL,
	model varchar NOT NULL,
	price numeric(7,2) NOT NULL,
	car_serial bigint NOT NULL
);

-- create servicing table
CREATE TABLE IF NOT EXISTS service(
	service_id serial PRIMARY KEY,
	service_type varchar NOT NULL,
	car_serial bigint NOT NULL,
	customer_id integer NOT NULL,
	mechanic_id integer NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY(mechanic_id) REFERENCES mechanic(mechanic_id)
);


-- create invoice table
CREATE TABLE invoice(
	invoice_id serial PRIMARY KEY,
	amount NUMERIC(7,2) NOT NULL,
	date_created date NOT NULL,
	paid boolean NOT NULL,
	car_id integer null,
	customer_id integer NOT NULL,
	mechanic_id integer null,
	service_id integer null,
	sales_id integer null,
	FOREIGN KEY(car_id) REFERENCES car(car_id),
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY(mechanic_id) REFERENCES mechanic(mechanic_id),
	FOREIGN KEY(service_id) REFERENCES service(service_id),
	FOREIGN KEY(sales_id) REFERENCES sales(sales_id)
);
SELECT * FROM invoice;
--stored procedure to add car
DROP PROCEDURE IF EXISTS add_car;

CREATE OR REPLACE PROCEDURE add_car(
	make varchar,
	model varchar,
	price numeric(7,2),
	car_serial bigint
)
LANGUAGE plpgsql
AS $$
BEGIN 
	INSERT INTO car(make, model, price, car_serial)
	VALUES(make, model, price, car_serial);
END;
$$;


CALL add_car('Tesla', 'Model X', 69999.99, 01234567890123456); 
CALL add_car('Ford', 'Mach-E', 89999.99, 00000000000000001); 

SELECT * FROM car;

--stored procedure to add sales employee

CREATE OR REPLACE PROCEDURE add_sales(
	first_name varchar,
	last_name varchar
)
LANGUAGE plpgsql
AS $$
BEGIN 
	INSERT INTO sales(first_name, last_name)
	VALUES(first_name, last_name);
END;
$$;

CALL add_sales('Sahd', 'Guru'); 
CALL add_sales('Ram', 'Das'); 

SELECT * FROM sales;

--stored procedure to add mechanic

CREATE OR REPLACE PROCEDURE add_mechanic(
	first_name varchar,
	last_name varchar
)
LANGUAGE plpgsql
AS $$
BEGIN 
	INSERT INTO mechanic(first_name, last_name)
	VALUES(first_name, last_name);
END;
$$;

CALL add_mechanic('Paramahansa', 'Yogananda'); 
CALL add_mechanic('Sage', 'Patanjali'); 
SELECT * FROM mechanic;

--stored procedure to add customer

CREATE OR REPLACE PROCEDURE add_customer(
	first_name varchar,
	last_name varchar
)
LANGUAGE plpgsql
AS $$
BEGIN 
	INSERT INTO customer(first_name, last_name)
	VALUES(first_name, last_name);
END;
$$;

CALL add_customer('Adonai', 'Romero'); 
CALL add_customer('Sri', 'Aurobindo'); 
SELECT * FROM customer;

--stored procedure to add service

CREATE OR REPLACE PROCEDURE add_service(
	service_type varchar,
	car_serial bigint,
	customer_id integer,
	mechanic_id integer
)
LANGUAGE plpgsql
AS $$
BEGIN 
	INSERT INTO service(service_type, car_serial, customer_id, mechanic_id)
	VALUES(service_type, car_serial, customer_id, mechanic_id);
END;
$$;

CALL add_service('Oil Change', 00000000000000002, 1, 2); 
CALL add_service('Full Service', 00000000000000003, 2, 1); 
SELECT * FROM service;

--stored procedure to add invoice

CREATE OR REPLACE PROCEDURE add_invoice(
	amount NUMERIC(7,2),
	date_created date,
	paid boolean,
	car_id integer,
	customer_id integer,
	mechanic_id integer,
	service_id integer,
	sales_id integer
)
LANGUAGE plpgsql
AS $$
BEGIN 
	INSERT INTO invoice(amount, date_created, paid, car_id, customer_id, machanic_id, service_id, sales_id)
	VALUES(amount, date_created, paid, car_id, customer_id, machanic_id, service_id, sales_id);
END;
$$;

CALL add_invoice(69999.99, 2024-03-24, False, 1, 2, null, null, 1); 
CALL add_invoice(00050.00, 2024-03-24, TRUE, NULL, 1, 1, 2, null);

SELECT * FROM invoice;