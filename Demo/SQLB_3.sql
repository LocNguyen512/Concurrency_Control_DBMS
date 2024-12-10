use QLDPKS
go

-- Giao dịch của khách hàng B
--Đặt mức cô lập cho giao tác
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRANSACTION;

SELECT * 
FROM Room 
WHERE room_no = '103' 

--Nếu khách hàng A rollback thì B có thể tiến hành đặt phòng
-- Khách hàng B Tiến hành đặt phòng 103
UPDATE Room
SET status = N'Đã đặt', booking_time = GETDATE()
WHERE room_no = '103' AND status = N'Trống';

--Giao tác của B được commit nếu hoàn thành thanh toán
COMMIT

