-- Tao CSDL
create database QLDPKS
go

-- Kich hoat CSDL
use QLDPKS
go

-- Tao Tables
create table Roles (
	id int primary key identity(1,1),
	rolename nvarchar(50)
)
go

create table Users (
	id int primary key identity(1,1),
	fullname nvarchar(50),
	birthday date,
	gender nvarchar(20),
	email nvarchar(150),
	phone_number nvarchar(20),
	address nvarchar(200),
	role_id int references Roles (id)
)
go

create table Room (
	id int primary key identity(1,1),
	room_no nvarchar(20) not null,
	type nvarchar(20),
	max_num int,
	price float
)
go

create table Booking (
	id int primary key identity(1,1),
	staff_id int references Users (id),
	customer_id int references Users (id),
	checkin datetime,
	checkout datetime
)
go

create table BookingDetail (
	booking_id int references Booking (id),
	room_id int references Room (id),
	price float,
	unit float,
	primary key (booking_id, room_id)
)
go

create table UserDetail (
	booking_id int references Booking (id),
	room_id int references Room (id),
	customer_id int references Users (id),
	primary key (booking_id, room_id, customer_id)
)

create table Category (
	id int primary key identity(1,1),
	name nvarchar(50)
)
go

create table Product (
	id int primary key identity(1,1),
	category_id int references Category (id),
	title nvarchar(150),
	thumbnail nvarchar(500),
	description ntext,
	price float,
	amount int
)
go

create table Services (
	id int primary key identity(1,1),
	booking_id int references Booking (id),
	customer_id int references Users (id),
	product_id int references Product (id),
	price float,
	amount int,
	buy_date datetime
)
go