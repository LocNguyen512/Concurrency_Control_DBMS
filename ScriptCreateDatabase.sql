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



INSERT INTO Roles (rolename) VALUES
('Admin'),
('Staff'),
('Customer');


INSERT INTO Users (fullname, birthday, gender, email, phone_number, address, role_id) VALUES
(N'Nguyễn Văn A', '1990-01-01', N'Nam', 'nguyenvana@example.com', '0123456789', N'Hà Nội', 3), -- Customer
(N'Trần Thị B', '1995-05-10', N'Nữ', 'tranthib@example.com', '0987654321', N'Hồ Chí Minh', 3), -- Customer
(N'Lê Văn C', '1992-03-15', N'Nam', 'levanc@example.com', '0123456780', N'Đà Nẵng', 2),       -- Staff
(N'Phạm Thị D', '1997-07-20', N'Nữ', 'phamthid@example.com', '0912345678', N'Huế', 1);        -- Admin


INSERT INTO Room (room_no, type, max_num, price, status)
VALUES
    ('101', 'Deluxe', 2, 1500000, 'Trống'),        -- Phòng 101 là Deluxe và trống
    ('102', 'Standard', 2, 1000000, 'Đã đặt'),    -- Phòng 102 là Standard và đã đặt
    ('103', 'Suite', 4, 2500000, 'Trống'),        -- Phòng 103 là Suite và trống
    ('104', 'Deluxe', 2, 1500000, 'Đã đặt'),      -- Phòng 104 là Deluxe và đã đặt
    ('106', 'Suite', 4, 2500000, 'Trống');       -- Phòng 106 là Suite và trống

INSERT INTO Category (name) VALUES
('Buffet'),
('Beverage'),
('Room Service');

-- Chèn dữ liệu mẫu vào Product với Category ID tương ứng
INSERT INTO Product (category_id, title, thumbnail, description, price, amount) VALUES
(1, N'Buffet Trưa Hấp Dẫn', NULL, N'Buffet trưa ngon miệng', 300000, 15), -- Buffet
(1, N'Buffet Tối Đặc Biệt', NULL, N'Buffet hải sản cao cấp', 500000, 1), -- Buffet
(2, N'Đồ uống không cồn', NULL, N'Các loại nước giải khát', 20000, 50),   -- Beverage
(3, N'Dọn phòng cao cấp', NULL, N'Dịch vụ dọn phòng sang trọng', 100000, 10); -- Room Service


