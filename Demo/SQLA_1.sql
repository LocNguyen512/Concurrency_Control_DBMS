use QLDPKS
go

-- Đặt mức cô lập giao dịch là Read Committed
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Giao dịch 1: Khách A
BEGIN TRANSACTION;  -- Bắt đầu giao dịch

-- Khách A đọc thông tin các phòng còn trống
SELECT * 
FROM Room r
WITH (UPDLOCK)  -- Khóa chia sẻ (Share Lock) trong khi đọc
WHERE r.status = N'Trống'


-- Hệ thống đặt khóa XLOCK lên dữ liệu trong khi chờ khách A hoàn tất thủ tục
SELECT * 
FROM Room 
WITH (XLOCK)  -- Khóa chia sẻ (Share Lock) trong khi đọc
WHERE room_no = '101' 
AND status = N'Trống'

-- Khách A đọc thông tin các phòng còn trống
if (exists(
SELECT 1 
FROM Room r  -- Khóa chia sẻ (Share Lock) trong khi đọc
WHERE r.status = N'Trống'
AND room_no = '101' ))
BEGIN
UPDATE Room 
-- Khóa độc quyền (Exclusive Lock)
SET status = N'Đã đặt'
WHERE room_no = '101' 
AND status = N'Trống';  -- Phòng phải còn trống để đặt
END

-- Cam kết giao dịch
COMMIT TRANSACTION;



-- Đặt mức cô lập giao dịch là Repeatable Read
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Giao dịch 1: Khách A
BEGIN TRANSACTION;  -- Bắt đầu giao dịch

-- Khách A đọc thông tin các phòng còn trống
SELECT * 
FROM Room r
WITH (UPDLOCK)  -- Khóa chia sẻ (Share Lock) trong khi đọc
WHERE r.status = N'Trống'


-- Khách A đọc thông tin các phòng còn trống
if (exists(
SELECT 1 
FROM Room r  -- Khóa chia sẻ (Share Lock) trong khi đọc
WHERE r.status = N'Trống'
AND room_no = '104' ))
BEGIN
UPDATE Room 
-- Khóa độc quyền (Exclusive Lock)
SET status = N'Đã đặt'
WHERE room_no = '104' 
AND status = N'Trống';  -- Phòng phải còn trống để đặt
END
-- Hệ thống cập nhật lại trạng thái phòng và kết thúc giao tác


-- Cam kết giao dịch
COMMIT TRANSACTION;

