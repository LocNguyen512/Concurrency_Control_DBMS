-- Tạo CSDL
create database QLDPKS
go

-- Kích hoạt CSDL
use QLDPKS
go

-- Tạo bảng Roles
create table Roles (
    id int primary key identity(1,1),
    rolename nvarchar(50)
)
go

-- Tạo bảng Users
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

-- Tạo bảng Room với cột status
create table Room (
    id int primary key identity(1,1),
    room_no nvarchar(20) not null,
    type nvarchar(20),
    max_num int,
    price float,
    status nvarchar(50) -- Trạng thái của phòng (ví dụ: Trống, Đã đặt, Đang dọn phòng, ...)
    booking_time datetime;
)
go

-- Tạo bảng Booking
create table Booking (
    id int primary key identity(1,1),
    staff_id int references Users (id),
    customer_id int references Users (id),
    checkin datetime,
    checkout datetime
)
go

-- Tạo bảng BookingDetail
create table BookingDetail (
    booking_id int references Booking (id),
    room_id int references Room (id),
    price float,
    unit float,
    primary key (booking_id, room_id)
)
go

-- Tạo bảng UserDetail
create table UserDetail (
    booking_id int references Booking (id),
    room_id int rN'Đã đặt');  -- Phòng 104 đã được đặt
