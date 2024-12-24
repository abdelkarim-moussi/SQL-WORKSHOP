-- crate data base query
create database dbcentre-medical;

--create users tables

create table users (
id_user int primary key auto_increment not null,
firstname varchar(50) not nul,
lastname varchar(50) not nul,
user_type enum('patient','doctor') not null

);
--create table for doctor extra info

--appointment table
create table appointment (
   id _apoin int primary key auto_increment not null,
   id_patient int not null,
   id_doctor int not null,
   date_apoin date not null,
   status enum('confirm','not-confirm')
   foreign Key (id_patient) references users(id_user),
   foreign Key (id_doctor) references users(id_user)
);

--create invoices table

create table invoices(
   id_invoice int primary key auto_increment not null,
   id_rdv int not null,
   amount float not null,
   invoice_date date not null,
   foreign key(id_apoin) references appointment(id_apoin)
   );

   -- select appoitments of the patient with id = 2;
select * from appointment where id_patient = 2;

-- select all appointment
select * from appointment;

-- display appointment details using join

select firstname , lastname, date_apoin , status 
from users 
inner join appointment 
where users.id_user = appointment.id_patient and appointment.id_doctor = 1; 

-- EXERCICE 4

-- change status of an appointment
UPDATE appointment
SET status = 'not-confirm'
where id_patient = 6;

-- delete an appointment or a user
delete from appointment
where id_patient = 6;

-- EXERCICE 6

-- calcul the sum of appointment for each patient
select id_patient, count(*) nb_ap from appointment 
group by id_patient;

-- invoices sum
select sum(amount) 
from invoices 
group by id_apoin;

-- average of amount with status confirm
select avg(amount) 
from invoices 
inner join appointment 
where appointment.status = 'confirm';

-- latest and oldest appointments

select date_apoin from appointment
where id_apoin = (select min(id_apoin) from appointment)
;
select DISTINCT date_apoin from appointment
where id_apoin = (select max(id_apoin) from appointment)
;

-- top des medecins 
select id_doctor ,count(*) nb from users inner join appointment 
where users.id_user = appointment.id_doctor
and status = 'confirm'
group by id_doctor 
order by nb desc
limit 1
