
CREATE TABLE AdminMaster (
    AdminID int NOT NULL,
    Name varchar(55) NOT NULL,
    EmailID varchar(55),
    ContactNo varchar(55),
    Address varchar(155) NOT NULL,
    PRIMARY KEY (AdminID)
);

CREATE TABLE City(
	CityID int NOT NULL,
	CityName varchar(55) NOT NULL,
	PRIMARY KEY (CityID)
);

CREATE TABLE ClientMaster (
    ClientID int NOT NULL,
    Name varchar(55) NOT NULL,
    ContactNo varchar(55),
    Address varchar(155) NOT NULL,
    CityID int NOT NULL,
	Cnic varchar(55),
	PRIMARY KEY (ClientID),
    FOREIGN KEY (CityID) REFERENCES City(CityID)
	);

CREATE TABLE PropertyType(
	PTID int NOT NULL,
	Name varchar(55) NOT NULL,
	PRIMARY KEY (PTID)
);


CREATE TABLE PropertyMaster (
    PropertyID int NOT NULL,
    ClientID int NOT NULL,
    Description varchar(255) ,
    Status char(55) ,
    Total_value int ,
    PTID int NOT NULL,
    Bedroom int ,
	Furnished char(55) ,
	Availabilty varchar(55) NOT NULL,
	Bathroom int,
	Area varchar(55) ,
	CityID int NOT NULL,
	Date_added varchar(155) ,
	Property_condition varchar(155) ,
	PRIMARY KEY (PropertyID),
    FOREIGN KEY (CityID) REFERENCES City(CityID),
	FOREIGN KEY (PTID) REFERENCES PropertyType(PTID),
	FOREIGN KEY (ClientID) REFERENCES ClientMaster(ClientID)
	);

CREATE TABLE Agents (
    AgentID int NOT NULL,
    Agent_name varchar(55) NOT NULL,
	CityID int NOT NULL,
    Agent_cnic varchar(55) NOT NULL,
	Address varchar(155) NOT NULL,
	ContactNo int,
    PRIMARY KEY (AgentID),
	FOREIGN KEY (CityID) REFERENCES City(CityID),
);

CREATE TABLE BookingMaster (

    BookingID int NOT NULL,
	PropertyID int NOT NULL,
	OwnerID int NOT NULL,
    ClientID int NOT NULL,
	Booking_status varchar(155),
	AgentID int NOT NULL,
    CityID int NOT NULL,
    Agreement_date varchar(155),
	Agreement_end varchar(155),
	Paperwork_status varchar(155),
    PRIMARY KEY (BookingID),
    FOREIGN KEY (AgentID) REFERENCES Agents(AgentID),
	FOREIGN KEY (PropertyID) REFERENCES PropertyMaster(PropertyID),
	FOREIGN KEY (CityID) REFERENCES City(CityID),
);
ALTER TABLE BookingMaster
ADD FOREIGN KEY (OwnerID) REFERENCES ClientMaster(ClientID);

ALTER TABLE BookingMaster
DROP COLUMN ClientID;

CREATE TABLE AgentCommission (
    CommissionID int NOT NULL,
    AgentID int NOT NULL,
    Comission_paid varchar(55) ,
	Remaining_comission varchar(55) ,
	PRIMARY KEY (CommissionID),
	FOREIGN KEY (AgentID) REFERENCES Agents(AgentID),
);


CREATE TABLE Services(
	ServiceID int NOT NULL,
	Service_name varchar(155) ,
	Service_charges int,
	PRIMARY KEY (ServiceID)
);


CREATE TABLE WorkerMaster (
    WorkerID int NOT NULL,
    Name varchar(55) NOT NULL,
    ServiceID int NOT NULL,
    ContactNo varchar(55),
    Address varchar(155) NOT NULL,
    CityID int NOT NULL,
	PRIMARY KEY (WorkerID),
	FOREIGN KEY (CityID) REFERENCES City(CityID),
	FOREIGN KEY (ServiceID) REFERENCES Services(ServiceID),
);


CREATE TABLE PaymentMaster (
    PaymentID int NOT NULL,
    BookingID int NOT NULL,
    Payment_type varchar(55) ,
    Purchase_date varchar(155) ,
    Payment_received varchar(155),
    PRIMARY KEY (PaymentID),
    FOREIGN KEY (BookingID) REFERENCES BookingMaster(BookingID)
	);


CREATE TABLE RentMaster (
    RentID int NOT NULL,
    PropertyID int NOT NULL,
	ClientID int NOT NULL,
	Starting_date varchar(155) ,
    Ending_date varchar(155) ,
    Rent_price varchar(55),
    PRIMARY KEY (RentID),
    FOREIGN KEY (PropertyID) REFERENCES PropertyMaster(PropertyID),
	FOREIGN KEY (ClientID) REFERENCES ClientMaster(ClientID),
	);

CREATE TABLE Maintainance (
    MaintainanceID int NOT NULL,
    RentID int NOT NULL,
    WorkerID int NOT NULL,
	Iscomplete varchar(55) ,
    Start_date varchar(155) ,
    End_date varchar(155),
    PRIMARY KEY (MaintainanceID),
    FOREIGN KEY (RentID) REFERENCES RentMaster(RentID),
	FOREIGN KEY (WorkerID) REFERENCES WorkerMaster(WorkerID)
	);

ALTER TABLE Maintainance
DROP COLUMN Iscomplete;
