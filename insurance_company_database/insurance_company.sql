DROP DATABASE IF EXISTS insurance_company;
CREATE DATABASE insurance_company;
USE insurance_company;

DROP TABLE IF EXISTS car CASCADE;
DROP TABLE IF EXISTS customer CASCADE;
DROP TABLE IF EXISTS accident CASCADE;
DROP TABLE IF EXISTS participates CASCADE;

CREATE TABLE customer (
    name VARCHAR(20),
    driverid CHAR(16) NOT NULL,
    address VARCHAR(50),
    PRIMARY KEY(driverid)

);
CREATE TABLE car (
	dID CHAR(16) NOT NULL,
    model VARCHAR(20),
    license CHAR(7) NOT NULL,
    year CHAR(4),
    PRIMARY KEY(license,dID),
    FOREIGN KEY(dID) REFERENCES customer(driverid)
);
CREATE TABLE accident (
	driverid CHAR(16) NOT NULL,
	license CHAR(7) NOT NULL,
    location VARCHAR(50),
    reportnumber VARCHAR(10) NOT NULL,
    date DATE,
    PRIMARY KEY(reportnumber)
);
CREATE TABLE participates (
	reportnum VARCHAR(10) NOT NULL,
    licensenumber CHAR(7) NOT NULL,
    dID CHAR(16) NOT NULL, 
    damagereport double NOT NULL,
    PRIMARY KEY(reportnum,licensenumber,dID),
	FOREIGN KEY(reportnum) REFERENCES accident(reportnumber),
    FOREIGN KEY(licensenumber) REFERENCES car(license),
    FOREIGN KEY(dID) REFERENCES customer(driverid)
);
