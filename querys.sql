--1.Повернути ПІБ всіх барберів салону.
create view BarbersPIB as
select b.Surname+' '+b.Name+' '+b.Lastname as 'Barbers full name'
from Barbers as b
go
select * from BarbersPIB

--2.Повернути інформацію про всіх синьйор-барберів.
create view SeniorsBarbers as
select *
from Barbers as b
where b.PositionId=2
go
select* from SeniorsBarbers
go

--3.Повернути інформацію про всіх барберів, які можуть надати послугу традиційного гоління бороди.
create view BarbersTraditional as
select b.Surname+' '+b.Name as 'Barbers name',b.PositionId as'Position'
from Barbers as b join BarbersServices as bs on b.Id=bs.BarberId
where bs.ServiceId=12
go
select*from BarbersTraditional
go

--4. Повернути інформацію про всіх барберів, які можуть надати конкретну послугу. Інформація про потрібну послугу надається як параметр.
create proc barbers_service @service nvarchar(60)
as
select b.Surname+' '+b.Name as 'Barbers name',b.PositionId as'Position'
from Barbers as b join BarbersServices as bs on b.Id=bs.BarberId
				  join Services as s on s.Id=bs.ServiceId
where s.Name=@service
go
exec barbers_service @service = 'Маскування сивини бороди'
exec barbers_service @service = 'Чоловіча стрижка'

--5. Повернути інформацію про всіх барберів, які працюють понад зазначену кількість років. Кількість років передається як параметр.
create proc barbers_years @years int
as
select b.Surname+' '+b.Name as 'Barbers name',b.PositionId as'Position', DATEDIFF(year,b.HireDate,GETDATE()) as 'Years of work'
from Barbers as b
where DATEDIFF(year,b.HireDate,GETDATE())>=@years
order by DATEDIFF(year,b.HireDate,GETDATE())
go
exec barbers_years @years =2

-- 6.Повернути кількість синьйор-барберів та кількість джуніор-барберів.
create view count_of_barbers as
select p.Name as 'Position name',COUNT(b.PositionId) as 'Count'
from Barbers as b join Position as p on p.Id=b.PositionId
where b.PositionId=2 or b.PositionId=3
group by p.Name
go
select * from count_of_barbers

-- 7.Повернути інформацію про постійних клієнтів. Критерій постійного клієнта: був у салоні задану кількість разів.Кількість передається як параметр.
create proc regular_customer @times int as
select c.Name+' '+c.Surname as 'Client Name',COUNT(f.ClientId) as 'Number of visits'
from Client as c join Feedbacks as f on f.ClientId=c.Id
group by c.Name+' '+c.Surname
having COUNT(f.ClientId)>=@times
go
exec regular_customer @times=2

-- 8. Заборонити додавати нового чіф-барбера
create trigger not_more_chef
on Barbers
after insert
as
	if exists(select Id
			  from inserted
			  where PositionId = 1)
	begin
		if exists(select Id from Barbers where PositionId = 1)
		raiserror('YOU HAVE A CHEF BARBER!',12,1)
		rollback transaction;
	end
go
insert into Barbers values
('Мищук','Тарас','Васильович','Ч','+38092721231773',' mu2sh2yk@gmail.com','1999-11-2','2022-5-16',1)

-- 9. Заборонити додавати барберів молодше 21 року.
create trigger not_young_barbers
on Barbers
after insert
as
	if exists(select Id
			  from inserted
			  where DATEDIFF(year,DateBirthday,GETDATE())<21)
	begin
		raiserror('NOT YOUNG BARBERS!',12,1)
		rollback transaction;
	end;
go
insert into Barbers values
('Мищук','Тарас','Васильович','Ч','+3809271231773',' mush2yk@gmail.com','2005-11-2','2022-5-16',3)
