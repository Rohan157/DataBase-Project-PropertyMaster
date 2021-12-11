
select * from PropertyMaster

/*1---------------------------------------------------------------------------------*/

CREATE PROCEDURE Selectbydate @date nvarchar(30)
AS
SELECT * FROM PropertyMaster WHERE Date_added = @date
GO


EXEC Selectbydate @date = '04/07/2019'

/*2---------------------------------------------------------------------------------*/

CREATE PROCEDURE SelectbyPriceRange @max int, @min int
AS
SELECT * FROM PropertyMaster WHERE Total_value between @max and @min
GO

EXEC SelectbyPriceRange @max = 80000000 , @min = 100000000

/*3---------------------------------------------------------------------------------*/

CREATE PROCEDURE SelectbyAvailabilty @available varchar(10)
AS
SELECT * FROM PropertyMaster WHERE Availabilty = @available 
GO

EXEC SelectbyAvailabilty @available = 'Yes'

/*4---------------------------------------------------------------------------------*/

CREATE PROCEDURE SelectbyStatus @status varchar(10)
AS
SELECT * FROM PropertyMaster WHERE Status = @status 
GO

EXEC SelectbyStatus @status = 'Rent'

/*5---------------------------------------------------------------------------------*/

CREATE PROCEDURE SelectbyCity @city varchar(55)
AS
SELECT PropertyMaster.PropertyID, PropertyMaster.ClientID, PropertyMaster.Status, PropertyMaster.Total_value,
	   PropertyMaster.Bathroom,PropertyMaster.Bedroom,PropertyMaster.Furnished,PropertyMaster.Availabilty,PropertyMaster.Area,
	   PropertyMaster.CityID,PropertyMaster.Date_added
FROM PropertyMaster
INNER JOIN City ON PropertyMaster.CityID=City.CityID
where CityName=@city


EXEC SelectbyCity @city = 'Fernie'

/*6---------------------------------------------------------------------------------*/

CREATE PROCEDURE SelectbyProperty_Type @type varchar(55)
AS
SELECT PropertyMaster.PropertyID,PropertyType.Name,PropertyType.PTID, PropertyMaster.ClientID, PropertyMaster.Status, PropertyMaster.Total_value,
	   PropertyMaster.Bathroom,PropertyMaster.Bedroom,PropertyMaster.Furnished,PropertyMaster.Availabilty,PropertyMaster.Area,
	   PropertyMaster.CityID,PropertyMaster.Date_added,PropertyMaster.PTID
FROM PropertyMaster
Inner JOIN PropertyType ON PropertyType.PTID= PropertyMaster.PTID
where PropertyType.Name = @type

/*Commercial
  Residential
  Rural*/
EXEC SelectbyProperty_Type @type = 'Residential'

/*7---------------------------------------------------------------------------------*/

CREATE PROCEDURE SelectMaintainancebyWorker @Worker varchar(55)
AS
SELECT WorkerMaster.WorkerID,Maintainance.MaintainanceID,WorkerMaster.Name,WorkerMaster.Address,
		Maintainance.Start_date,Maintainance.End_date
FROM WorkerMaster
Inner JOIN Maintainance ON Maintainance.WorkerID= WorkerMaster.WorkerID
where WorkerMaster.WorkerID = @Worker



EXEC SelectMaintainancebyWorker @Worker = 1

/*8---------------------------------------------------------------------------------*/

CREATE PROCEDURE InsertProperty
	@PropertyID int ,
    @ClientID int ,
    @Description varchar(255) ,
    @Status char(55) ,
    @Total_value int ,
    @PTID int ,
    @Bedroom int ,
	@Furnished char(55) ,
	@Availabilty varchar(55) ,
	@Bathroom int,
	@Area varchar(55) ,
	@CityID int ,
	@Date_added varchar(155) ,
	@Property_condition varchar(155) 
	AS
	BEGIN 
	INSERT INTO PropertyMaster([PropertyID],[ClientID],[Description],[Status],
	[Total_value],[PTID],[Bedroom],[Furnished],[Availabilty],[Bathroom],[Area],[CityID],[Date_added])
	values(@PropertyID,@ClientID,@Description,@Status,@Total_value,@PTID,@Bedroom,@Furnished,
	@Availabilty,@Bathroom,@Area,@CityID,@Date_added)
	end

	Exec InsertProperty 691,33,'null','sale',33288274,2,5,'Yes','yes',1,'72.14768' ,2,'02/15/2019','well'


/*9---------------------------------------------------------------------------------*/


CREATE PROCEDURE SelectbyWorkerID @id nvarchar(30)
AS
SELECT * FROM WorkerMaster WHERE WorkerID = @id
GO


EXEC SelectbyWorkerID @id = 5



/*10---------------------------------------------------------------------------------*/

CREATE PROCEDURE Property_Against_Times_It_Rented
	AS
	Begin
	SELECT PropertyID,   Count(PropertyID)Times_It_Is_Rented 
	FROM RentMaster 
	GROUP BY PropertyID;



Exec Property_Against_Times_It_Rented

/*11---------------------------------------------------------------------------------*/

CREATE PROCEDURE Agents_and_bookings @agents int
	AS
	BEGIN 

	Select Agents.AgentID,Agents.Agent_name,Agents.Agent_cnic,
	BookingMaster.BookingID
	from Agents
	Inner JOIN BookingMaster ON BookingMaster.AgentID= Agents.AgentID
	where Agents.AgentID = @agents
	end

Exec Agents_and_bookings @agents=2

/*12---------------------------------------------------------------------------------*/

	
CREATE PROCEDURE Agents_and_Comission @ags int
	AS
	BEGIN 

	Select Agents.AgentID,AgentCommission.CommissionID,Agents.Agent_name,Agents.Address,
	AgentCommission.Comission_paid,AgentCommission.Remaining_comission
	from AgentCommission
	Inner JOIN Agents ON Agents.AgentID=AgentCommission.AgentID
	where Agents.AgentID=@ags
	end


Exec Agents_and_Comission @ags=2
	
/*13---------------------------------------------------------------------------------*/

CREATE PROCEDURE Delete_from_PropertyMaster @id int
	AS
	BEGIN 

	DELETE FROM PropertyMaster WHERE PropertyID=@id
	end

EXEC Delete_from_PropertyMaster @id=690

/*14---------------------------------------------------------------------------------*/

CREATE PROCEDURE Delete_from_RentMaster @id int
	AS
	BEGIN 

	DELETE FROM RentMaster WHERE RentID=@id
	end

EXEC Delete_from_RentMaster @id=690


/*15---------------------------------------------------------------------------------*/

CREATE PROCEDURE Delete_from_WorkerMAster @id int
	AS
	BEGIN 

	DELETE FROM WorkerMaster WHERE WorkerID=@id
	end

EXEC Delete_from_WorkerMaster @id=690


/*16---------------------------------------------------------------------------------*/

CREATE PROCEDURE Delete_Agents @id int
	AS
	BEGIN 

	DELETE FROM Agents WHERE AgentID=@id
	end

EXEC Delete_from_WorkerMAster @id=690


/*17---------------------------------------------------------------------------------*/



  create view Invoice
  as
  select BookingMaster.BookingID,
         BookingMaster.PropertyID,
		 BookingMaster.OwnerID,
		 BookingMaster.AgentID,
		 PaymentMaster.PaymentID,
		 PaymentMaster.Payment_received
		  from BookingMaster
	Inner JOIN PaymentMaster ON PaymentMaster.BookingID=BookingMaster.BookingID 
 
/*18---------------------------------------------------------------------------------*/

  

CREATE PROCEDURE PaymentbyProperty @id int
	AS
	BEGIN 
	select * from PaymentMaster Invoice
  where PaymentID = @id
	 
end

EXEC PaymentbyProperty @id=6



/*19---------------------------------------------------------------------------------*/


create procedure gledger 
@startdate date,
@enddate date
as
select 


/*20---------------------------------------------------------------------------------*/

create view Service_Done
as 
select m.MaintainanceID,
       m.End_date,
       wm.ServiceID,
	   s.Service_name,
	   s.Service_charges
from Maintainance m
join WorkerMaster wm on m.WorkerID=wm.WorkerID
join Services S ON wm.ServiceID=s.ServiceID

select * from Service_Done

/*21---------------------------------------------------------------------------------*/

Create Procedure gledger @sdate date,@edate date
as
begin
declare @inflow1 BIGint
declare @inflow2 BIGint
declare @inflow BIGINT
declare @outflow BIGint
select @inflow1=sum(Service_charges) from Service_Done where End_date>=@sdate and End_date<=@edate 
select @inflow2=sum(Payment_received) from PaymentMaster
select @outflow=sum(Comission_paid)  from AgentCommission
set @inflow2=(@inflow2/100)
set @inflow=@inflow2+@inflow1
select @inflow2 as Inflow,@outflow as Outflow
end
exec gledger '2020-09-09','2021-09-09'