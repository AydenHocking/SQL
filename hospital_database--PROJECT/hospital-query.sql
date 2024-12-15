-- 3 views
	-- this views shows each patient's assigned physician and room number
	Drop view if exists assignment;
	create view assignment as 
	select patient, Employee.name as physician, RoomNum
	from Employee, (select Patient.name as patient, Physician.PhyNum as phyid, RoomNum
					from Patient, Physician, Room
					where Patient.PhysAssigned = Physician.PhyNum and Patient.RoomAssigned = Room.RoomNum) as base
	where Employee.UniqueID = base.phyid;
	select * from assignment;

	-- this view shows which nurse gave what medicine to what patient 
	Drop view if exists medicineGiven;
	create view medicineGiven as 
	select eventID, Employee.name as nurse, Medication.name, Medication.dose as dose, Patient.Name as patient
	from Employee, Medication, Patient,
		(select am.AdminID as eventID, am.NurseID as nID, am.MedicineID as mID, am.PatientGiven as pID
		from Administers_Medicine as am) as base
	where base.nID = Employee.UniqueID and Medication.ProductNum = base.mID and Patient.PatID = base.pID;
	select * from medicineGiven;

	-- this view is the composition of the invoice payable. The fee is 20% of the instructions cost 
	Drop view if exists invoice;
	create view invoice as 
	select InvoiceID, date, patient, description, roomOccupied, roomPrice, Medication.name as MedicineAdministered, price as MedicineCost, Instructionsamount, 
		   ROUND(0.20*base.Instructionsamount, 2) as fees, ROUND((roomPrice+price+Instructionsamount+(0.20*base.Instructionsamount)), 2) as Total_Payable_Due
	from Medication join
		(select invoiceNum as InvoiceID, p.name as patient, inst.Description, Room.RoomNum as roomOccupied, 
		Room.Price as roomPrice, am.MedicineID as mID, date, inst.Price as Instructionsamount
		from Invoice_payable as ip 
			join Patient p on ip.PatientTreated = p.PatID
			join Room on ip.RoomOccupied = Room.RoomNum 
			join Instructions inst on ip.InstructionsPerformed = inst.UniqueID
			join Administers_Medicine as am on ip.MedicineGiven = am.AdminID) as base
	on Medication.ProductNum = base.mID;
	select * from invoice;

-- 3 Join Queries 
	-- what is the patient's Room Number?
	select name, Room.RoomNum
	from Patient join Room on Patient.RoomAssigned = Room.RoomNum;
	-- how long has the patient been monitored by a physician?
	select Employee.name as Physician, Patient.name as Patient, DurationInHours
	from Physician_Moniters as py join Patient on py.PatientID = Patient.PatID
	join Employee on py.PhysicianID = Employee.UniqueID;
	-- What is Each Patient's diseases?
	select name as patient, Disease
    from Diseases join Patient on Diseases.PID = Patient.PatID;
    
-- 3 Aggregation Queries 
	-- what is the total amount of hospital payables?
    select SUM(Total_Payable_Due) as Total_payables
    from invoice; -- from view created previously
    -- How many patients recieved medication over $20
    select COUNT(*)
    from Medication
    where Medication.Price > 20;
    -- What is the average price spent on rooms with capacity under 5?
    select ROUND(AVG(Price), 2) as AvgPrice_CapUnder5
    from Room
    where capacity < 5;
    -- Show all physicians that monitored more than 1 patient
    select Name as Physician, base.PatientsMonitored
    from Employee join (
    select PhysicianID, Count(PatientID) as PatientsMonitored  
    from Physician_Moniters 
    group by PhysicianID
    having count(PatientID) > 1) as base on UniqueID = PhysicianID;
    
-- 3 Nested Queries
	-- Return every Patient's that paid Instructions that cost over $5000
	select 
		(select name from Patient where PatID = Orders.PatientID) as PatientNames,
        (select price from Instructions where Instructions.UniqueID = Orders.InstructionID) as Price
    from Orders 
    where Orders.InstructionID in (
		select UniqueID
        from Instructions 
        where price > 5000
    );
    -- Return patient(s) that were monitored by Joseph Abdulwahab
    select name as patient
    from Patient
    where PatID in (
		select PatientID
		from Physician_Moniters
		where PhysicianID in (
			select PhyNum
			from Physician
			where PhyNum in (
				select UniqueID
                from Employee
                where Name like "Joseph Abdulwahab"
				)
			)
		);
	-- What patients were monitored for over 10 hours by physician and how many hours were they monitored?
    select Employee.name as Physician, Patient.name as Patient, base.DurationInHours
    from Employee join
    (select PhysicianID, PatientID, DurationInHours
    from Physician_Moniters
    where DurationInHours > 10) as base on Employee.UniqueID = PhysicianID 
    join Patient on Patient.PatID = base.PatientID; 

-- 3 triggers 
	-- insert a patient health record once the patient is admitted to the hospital today.
	DROP TRIGGER IF EXISTS insert_patient_record;
	DELIMITER //
	CREATE TRIGGER insert_patient_record 
	AFTER INSERT ON patient 
	FOR EACH ROW BEGIN 
		INSERT INTO Health_Record (PatientID, Status, Date, description) 
		VALUES (NEW.PatID, 'Admitted', Now(), 'New patient record created');
	END; //
	DELIMITER ; 
	select * from Health_Record; -- do an insert statement after the trigger to see the effects. 
								 -- Ideally, run schema, trigger, then insert data, then finally view the relation.
 
	-- After records are inserted in the orders relations today, update instructions to have today's date_ordered.
    DROP TRIGGER IF EXISTS Modify_date;
	DELIMITER //
	CREATE TRIGGER Modify_date 
	AFTER INSERT ON Orders 
	FOR EACH ROW BEGIN 
		Update Instructions set Date_ordered = NOW()
        Where Instructions.UniqueID = NEW.InstructionID; -- new InstructionID b/c this is after creating order records. cannot do Orders.InstructionID
	END; //
	DELIMITER ; 
	select * from Instructions;
    
    -- Update the room capacity by -1 each time a patient is admited to the room.
	DROP TRIGGER IF EXISTS updateRoomCapacity;
	DELIMITER //
	CREATE TRIGGER assign_nurse_to_instruction
	AFTER INSERT ON Patient
	FOR EACH ROW
	BEGIN
		UPDATE Room set Capacity = Capacity - 1
		where New.RoomAssigned = RoomNum;
	END;//
	DELIMITER ;
	select * from room;

-- 3 transactions 
SET autocommit = 0;
	-- Add a record transaction with commit
    START TRANSACTION;
	INSERT INTO Employee VALUES (657420098, "Jake Okra", "GJYTY65&9");
	COMMIT; 		
    -- delete from employee where UniqueID = 657420098;
    select * from employee;
	-- ROLLBACK
	START TRANSACTION;
	INSERT INTO Room VALUES('T65', 8, 999.843); 
	select * from Room;
	ROLLBACK;
	select * from Room; 
    -- All or Nothing 
    DROP PROCEDURE IF EXISTS insert_all;
	DELIMITER //
	CREATE PROCEDURE insert_all()
	BEGIN
		DECLARE rollback_ bool DEFAULT 0; 			-- define and initialize the variable rollback_ to 0 
		DECLARE CONTINUE HANDLER FOR SQLEXCEPTION	-- define a handler method that sets rollback_ to 1 whenver 
		BEGIN										-- we face SQLEXCEPTION as a result of running the statements. 
			SET @rollback_ = 1;
		END; 

		START TRANSACTION;
		INSERT INTO Room VALUES('AAA', 8, 999.843); 
        INSERT INTO Room VALUES('AAA', 9, 32.23); -- should not be added because breaks primary key

		IF @rollback_ THEN 
			ROLLBACK;
			SELECT 'Error occccccured' as message;
		ELSE
			COMMIT;
			select 'committtted' as message;
		END IF;
	END // 
	DELIMITER ; 

SET autocommit = 1;