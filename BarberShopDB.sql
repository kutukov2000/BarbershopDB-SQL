COLLATE Cyrillic_General_100_CI_AS;
create database BarberShop
go
use BarberShop
go
create table Position(
Id int primary key identity(1,1),
Name nvarchar(100) not null unique
)
go
insert into Position(Name) values
('Чіф-барбер'),
('Сенйор-барбер'),
('Джуніор-барбер')
go
select * from Position
go
create table Barbers(
Id int primary key identity(1,1),
Name nvarchar(50) not null,
Surname nvarchar(50) not null,
Lastname nvarchar(25) not null,
Gender nvarchar(1) not null,
Phone nvarchar(15) not null unique,
Email nvarchar(100) not null unique,
DateBirthday date not null,
HireDate date not null,
PositionId int references Position(Id)
)
go
insert into Barbers values
('Дмитро','Дубровський','Миколайович','Ч','+390502102937','dybrovsky@gmail.com','1999-5-12','2020-8-10',1),
('Олег','Петрук','Дмитрович','Ч','+390971288228','petruk@gmail.com','2003-7-12','2021-8-1',2),
('Іван','Максимов','Васильович','Ч','+390985168546','maksimov@gmail.com','1998-6-13','2020-8-10',2),
('Назар','Довжаниця','Віталійович','Ч','+390971221788','dovzhanista@gmail.com','2000-9-12','2021-1-30',3),
('Арарат','Кутуков','Дмитрович','Ч','+390968516471','kutukov@gmail.com','2002-11-16','2022-11-16',3),
('Рашид','Петренко','Михайлович','Ч','+390988516471',' petrenko@gmail.com','1999-11-2','2022-5-16',3)
go
select * from Barbers
go
create table Services(
Id int primary key identity(1,1),
Name nvarchar(max) not null,
Duration nvarchar(10) not null,
Price money not null 
)
go
insert into Services values
('Чоловіча стрижка','1h',450),
('Чоловіча стрижка (довге волосся)','1.5h',650),
('Моделювання бороди','1h',300),
('Чоловіча стрижка + Моделювання бороди','2h',700),
('Дитяча стрижка','1h',350),
('Укладка волосся','1h',400),
('Камуфляж бороди','1.5h',400),
('Стрижка вусів','30m',150),
('Бриття голови','1.5h',500),
('Маскування сивини голови','1.5h',550),
('Маскування сивини бороди','1.5h',550),
('Традиційне гоління бороди','45m',400)
go
select*from Services
go
create table BarbersServices(
Id int primary key identity(1,1),
BarberId int not null foreign key  references Barbers(Id),
ServiceId int not null foreign key  references Services(Id)
)
go
insert into BarbersServices values
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6),
(1,7),
(1,8),
(1,9),
(1,10),
(1,11),

(2,1),
(2,2),
(2,3),
(2,4),
(2,6),
(2,7),
(2,8),
(2,10),

(3,1),
(3,5),
(3,3),
(3,4),
(3,6),
(3,7),
(3,11),

(4,1),
(4,2),
(4,6),
(4,7),
(4,11),

(5,1),
(5,4),
(5,5),
(5,8),
(5,10),

(6,1),
(6,4),
(6,5),
(6,8),
(6,11),
(1,12),
(2,12),
(3,12)
go
select*from BarbersServices
go
create table Client(
Id int primary key identity(1,1),
Name nvarchar(50) not null,
Surname nvarchar(50) not null,
Lastname nvarchar(25) not null,
Phone nvarchar(15) not null unique,
Email nvarchar(100) not null unique
)
go
insert into Client (Name, Surname, Lastname, Phone, Email) values ('Marlee', 'Paolo', 'Chewter', '980-825-1410', 'mchewter0@disqus.com');
insert into Client (Name, Surname, Lastname, Phone, Email) values ('Emmerich', 'Keam', 'Anmore', '108-293-3472', 'eanmore1@bloomberg.com');
insert into Client (Name, Surname, Lastname, Phone, Email) values ('Joellyn', 'Parradye', 'Laybourne', '582-279-3955', 'jlaybourne2@blogtalkradio.com');
insert into Client (Name, Surname, Lastname, Phone, Email) values ('Kally', 'Harrington', 'Bulcock', '258-287-2672', 'kbulcock3@loc.gov');
insert into Client (Name, Surname, Lastname, Phone, Email) values ('Sherlock', 'Offill', 'Wrightson', '228-216-4028', 'swrightson4@nymag.com');
insert into Client (Name, Surname, Lastname, Phone, Email) values ('Reeba', 'Calderbank', 'Michurin', '460-544-0227', 'rmichurin5@youku.com');
insert into Client (Name, Surname, Lastname, Phone, Email) values ('Monro', 'Sells', 'Braxton', '171-643-5627', 'mbraxton6@disqus.com');
insert into Client (Name, Surname, Lastname, Phone, Email) values ('Edik', 'Pedroni', 'Sneller', '448-169-0002', 'esneller7@chron.com');
insert into Client (Name, Surname, Lastname, Phone, Email) values ('Ferguson', 'Puckey', 'Matuska', '816-339-5859', 'fmatuska8@hud.gov');
go
select*from Client
go
create table Marks(
Id int primary key identity(1,1),
Name nvarchar(max) not null
)
go 
insert into Marks values
('Дуже погано'),
('Погано'),
('Нормально'),
('Добре'),
('Чудово')
go
select*from Marks
go
create table Feedbacks(
Id int primary key identity(1,1),
Message nvarchar(max),
ClientId int not null foreign key  references Client(Id),
BarberId int not null foreign key  references Barbers(Id),
MarkId int not null foreign key  references Marks(Id)
)
go 
insert into Feedbacks values
('Dislike this barber!',2,5,1),
('Best haircut!',1,1,5),
('Second time, the best haircut!',1,2,5),
('And third time, the best haircut!',1,2,5),
('The worst shave in my life!',2,6,1),
('The worst haircut in my life!',3,6,2),
('Cool Barber!',4,3,4),
('I realy love this barbershop!',5,3,5)
go
select*from Feedbacks
go
create table Archive(
Id int primary key identity(1,1),
ClientId int not null foreign key  references Client(Id),
BarberId int not null foreign key  references Barbers(Id),
ServiceId int not null foreign key  references Services(Id),
Date date not null,
Price money not null,
FeedbackId int not null foreign key  references Feedbacks(Id)
)
go
insert into Archive values
(1,1,1,GETDATE(),150,1)
go
select *from Archive
