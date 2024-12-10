use QLDPKS
go

-- Đặt mức cô lập giao dịch là Repeatable Read
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Giao dịch A
BEGIN TRANSACTION;

-- Khách hàng yêu cầu đọc số lượng những buffet hải sản còn lại
SELECT *
FROM Product
WHERE id = 2 -- ID buffet hải sản
    AND amount >= 1 -- Đảm bảo còn ít nhất 1 suất buffet
-- A tiến hành hoàn thành thủ tục trên website

-- Hệ thống kiểm tra lại số lượng buffet để chắc chắn còn suất
IF EXISTS (
    SELECT *
    FROM Product
    WHERE id = 2 -- ID buffet hải sản
      AND amount >= 1 -- Đảm bảo còn ít nhất 1 suất buffet
)
BEGIN
    -- Cập nhật số lượng buffet
    UPDATE Product
    SET amount = amount - 1
	WHERE id = 2
    PRINT N'Khách hàng A đã đặt buffet thành công.';
END


-- Cam kết giao dịch
COMMIT TRANSACTION;
