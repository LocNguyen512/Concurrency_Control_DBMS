use QLDPKS
go

-- Đặt mức cô lập giao dịch là Read Committed
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
-- Giao dịch 2: Khách B
BEGIN TRANSACTION;  -- Bắt đầu giao dịch


UPDATE Room 
-- Khóa độc quyền (Exclusive Lock)
SET status = N'Đã đặt'
WHERE room_no = '104' 
AND status = N'Trống';  -- Phòng phải còn trống để đặt


COMMIT TRANSACTION;
