select * from RentMaster
alter table RentMaster
drop column Starting_date
alter table RentMaster
drop column Ending_date


alter table RentMaster
add Starting_date date
alter table RentMaster
add Ending_date date



update  RentMaster
set Starting_date = '2017-11-08'

update  RentMaster
set Ending_date = '2017-12-10'
