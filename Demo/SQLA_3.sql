
use QLDPKS
go

-- Giao dịch của khách hàng A
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRANSACTION;

-- Khách hàng A đọc trạng thái phòng 103
SELECT *
FROM Room 
WHERE room_no = '103';

--Khách hàng A tiến hành đặt phòng 103
-- Đặt trạng thái phòng 103 tạm thời là "Đã đặt"
UPDATE Room
SET status = N'Đã đặt', booking_time = GETDATE()
WHERE room_no = '103' AND status = N'Trống'

--Giao tác A kiểm tra lại trạng thái phòng hiện tại
SELECT*
from room
where room_no = '103'

-- Tiến hành giao dịch thanh toán, nhưng trạng thái phòng sẽ chưa được "Đã đặt" vĩnh viễn nếu chưa commit
--Nếu khách hàng A hủy giao dịch, roll back
ROLLBACK 
-- Nếu khách hàng A hoàn tất giao dịch, commit
COMMIT;




