use QLDPKS
go

-- Đặt mức cô lập giao dịch là Repeatable Read
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Giao dịch B
BEGIN TRANSACTION;
    -- Yêu cầu cập nhật số lượng buffet
    UPDATE Product
    SET amount = amount - 1
    WHERE id = 2
      AND amount >= 1; -- Đảm bảo cập nhật chỉ khi còn đủ số lượng

    PRINT 'Khách hàng B đã đặt buffet thành công.';

-- Cam kết giao dịch
COMMIT TRANSACTION;
