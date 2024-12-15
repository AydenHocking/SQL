DROP DATABASE IF EXISTS hospital;
CREATE DATABASE hospital;
USE hospital;

DROP TABLE IF EXISTS Employee CASCADE;
	-- multivalued attributes for Employee
	DROP TABLE IF EXISTS EmployeePhoneNums CASCADE;
	DROP TABLE IF EXISTS EmployeeAddresses CASCADE;
DROP TABLE IF EXISTS Nurse CASCADE;
DROP TABLE IF EXISTS Physician CASCADE;
DROP TABLE IF EXISTS Room CASCADE;
DROP TABLE IF EXISTS Patient CASCADE;
	-- multivalued attributes for Patient 
    DROP TABLE IF EXISTS PatientPhoneNums CASCADE;
	DROP TABLE IF EXISTS PatientAddresses CASCADE;
    DROP TABLE IF EXISTS Diseases CASCADE;
DROP TABLE IF EXISTS Instructions CASCADE;
DROP TABLE IF EXISTS Orders CASCADE;
DROP TABLE IF EXISTS Medication CASCADE;
DROP TABLE IF EXISTS Administers_Medicine CASCADE;
DROP TABLE IF EXISTS Health_Record CASCADE;
DROP TABLE IF EXISTS Invoice_Payable CASCADE;
DROP TABLE IF EXISTS Nurse_Executes_Instructions CASCADE;
DROP TABLE IF EXISTS Physician_Moniters CASCADE;


CREATE TABLE Employee(
	UniqueID INTEGER NOT NULL,
    Name VARCHAR(100),
    CertificationNum VARCHAR(10),
    PRIMARY KEY(UniqueID)    
);
CREATE TABLE EmployeePhoneNums(
	EmpID INTEGER NOT NULL,
	Phone CHAR(12) NOT NULL,
	PRIMARY KEY(EmpID, Phone),
	FOREIGN KEY(EmpID) REFERENCES Employee(UniqueID)        
);
CREATE TABLE EmployeeAddresses(
	EmpID INTEGER NOT NULL,
	Address VARCHAR(100) NOT NULL,
	PRIMARY KEY(EmpID, Address),
	FOREIGN KEY(EmpID) REFERENCES Employee(UniqueID)        
);
CREATE TABLE Nurse(
	NurNum INTEGER NOT NULL,
    PRIMARY KEY(NurNum),
    FOREIGN KEY(NurNum) REFERENCES Employee(UniqueID)
);
CREATE TABLE Physician(
	PhyNum INTEGER NOT NULL,
    FieldOfExperience VARCHAR(50),
    PRIMARY KEY(PhyNum),
    FOREIGN KEY(PhyNum) REFERENCES Employee(UniqueID)
);
CREATE TABLE Room(
	RoomNum CHAR(5) NOT NULL,
    Capacity INTEGER,
    Price double,
    PRIMARY KEY(RoomNum)
);
CREATE TABLE Patient(
	PatID INTEGER NOT NULL,
    PhysAssigned INTEGER,
    RoomAssigned CHAR(5),
    Name VARCHAR(100),
    PRIMARY KEY(PatID),
    FOREIGN KEY (PhysAssigned) REFERENCES Physician(PhyNum),
    FOREIGN KEY (RoomAssigned) REFERENCES Room(RoomNum)
);
CREATE TABLE PatientPhoneNums(
	PID INTEGER NOT NULL,
    Phone CHAR(12) NOT NULL,
    PRIMARY KEY(PID, Phone),
    FOREIGN KEY(PID) REFERENCES Patient(PatID)
);
CREATE TABLE PatientAddresses(
	PID INTEGER NOT NULL,
    Address VARCHAR(100) NOT NULL,
    PRIMARY KEY(PID, Address),
    FOREIGN KEY(PID) REFERENCES Patient(PatID)
);
CREATE TABLE Diseases(
	PID INTEGER NOT NULL,
    Disease VARCHAR(50) NOT NULL,
    PRIMARY KEY(PID, Disease),
    FOREIGN KEY(PID) REFERENCES Patient(PatID)
);
CREATE TABLE Instructions(
	UniqueID INTEGER NOT NULL,
    PhysPrescribed INTEGER,
    Price DOUBLE,
    Description VARCHAR(1000),
    Date_ordered date,
    PRIMARY KEY(UniqueID),
    FOREIGN KEY(PhysPrescribed) REFERENCES Physician(PhyNum)
);
CREATE TABLE Orders(
	PhysicianID INTEGER,
    PatientID INTEGER,
    InstructionID INTEGER,
    Date date,    
    PRIMARY KEY(PhysicianID, PatientID, InstructionID),
    FOREIGN KEY(PhysicianID) REFERENCES Physician(PhyNum),
    FOREIGN KEY(PatientID) REFERENCES Patient(PatID),
    FOREIGN KEY(InstructionID) REFERENCES Instructions(UniqueID)
);
CREATE TABLE Medication(
	ProductNum INTEGER NOT NULL,
    Dose DOUBLE,
    Name VARCHAR(50),
    Price DOUBLE,
    PRIMARY KEY(ProductNum)
);
CREATE TABLE Administers_Medicine(
	AdminID CHAR(10) NOT NULL, 		-- the same nurse can give the same medicine to multiple or the same patient(s)
	NurseID INTEGER NOT NULL,
    MedicineID INTEGER NOT NULL,
    PatientGiven INTEGER NOT NULL,
    PRIMARY KEY(AdminID, NurseID, MedicineID, PatientGiven),
    FOREIGN KEY(NurseID) REFERENCES Nurse(NurNum),
    FOREIGN KEY(MedicineID) REFERENCES Medication(ProductNum),
    FOREIGN KEY(PatientGiven) REFERENCES Patient(PatID)
);
CREATE TABLE Health_Record(
    RecordID INTEGER NOT NULL auto_increment, -- auto_increment because created with trigger
	PatientID INTEGER NOT NULL,
	Status VARCHAR(20),
	Date date,
    Description VARCHAR(1000),
    PRIMARY KEY(RecordID, PatientID),
    FOREIGN KEY(PatientID) REFERENCES Patient(PatID)
);
CREATE TABLE Invoice_Payable(
	InvoiceNum INTEGER NOT NULL,
    PatientTreated INTEGER,
    RoomOccupied CHAR(5),
    InstructionsPerformed INTEGER,
    MedicineGiven CHAR(10),
    Date date, 
    Amount double, 
    Fees double,
    PRIMARY KEY(InvoiceNum),
    FOREIGN KEY(PatientTreated) REFERENCES Patient(PatID),
    FOREIGN KEY(RoomOccupied) REFERENCES Room(RoomNum),
    FOREIGN KEY(InstructionsPerformed) REFERENCES Instructions(UniqueID),
    FOREIGN KEY(MedicineGiven) REFERENCES Administers_Medicine(AdminID)
);
CREATE TABLE Nurse_Executes_Instructions(
	NurseID INTEGER NOT NULL,
    InstructionID INTEGER NOT NULL,
    PatientID INTEGER NOT NULL,
    Date date,
    Status VARCHAR(50),
    PRIMARY KEY(NurseID, PatientID),
    FOREIGN KEY(NurseID) REFERENCES Nurse(NurNum),
    FOREIGN KEY(InstructionID) REFERENCES Instructions(UniqueID),
    FOREIGN KEY(PatientID) REFERENCES Patient(PatID)
);
CREATE TABLE Physician_Moniters(
	PhysicianID INTEGER NOT NULL,
    PatientID INTEGER NOT NULL,
    DurationInHours double,
    PRIMARY KEY(PhysicianID, PatientID),
    FOREIGN KEY(PhysicianID) REFERENCES Physician(PhyNum),
    FOREIGN KEY(PatientID) REFERENCES Patient(PatID)
);
