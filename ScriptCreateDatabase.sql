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
    room_id int references Room (id),
    customer_id int references Users (id),
    primary key (booking_id, room_id, customer_id)
)
go

-- Tạo bảng Category
create table Category (
    id int primary key identity(1,1),
    name nvarchar(50)
)
go

-- Tạo bảng Product
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

-- Tạo bảng Services
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


INSERT INTO Room (room_no, status)
VALUES 
    ('101', 'Trống'),  -- Phòng 101 là trống
    ('102', 'Đã đặt'),  -- Phòng 102 đã được đặt
    ('103', 'Trống'),  -- Phòng 103 là trống
    ('104', 'Đã đặt');  -- Phòng 104 đã được đặt
DELETE from Room;
-- Dữ liệu ban đầu của bảng Room
INSERT INTO Room (room_no, type, max_num, price, status)
VALUES
('Deluxe101', 'Deluxe', 10, 1000, 'Trống');