use QLDPKS
go
-- Thiết lập mức độ cô lập là SERIALIZABLE
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

BEGIN TRANSACTION;

    -- Nhân viên A đọc và khóa bản ghi với XLOCK
    SELECT max_num
    FROM Room WITH (XLOCK)
    WHERE type = 'Deluxe';


    -- Cập nhật số lượng phòng trống
    UPDATE Room
    SET max_num = max_num - 1
    WHERE type = 'Deluxe';

    DECLARE @current_available_B INT;
    SELECT @current_available_B = max_num
    FROM Room WITH (XLOCK)
    WHERE type = 'Deluxe';

    -- In ra kết quả
    PRINT N'Nhân viên A: Cập nhật thành công. Số lượng phòng hiện tại là ' + CAST(@current_available_B AS NVARCHAR);

    -- Hoàn tất giao dịch
    COMMIT TRANSACTION;
	
BEGIN CATCH
    -- Xử lý lỗi: Rollback giao dịch
    ROLLBACK TRANSACTION;
    PRINT ERROR_MESSAGE();
END CATCH;
-- Thiết lập mức độ cô lập là SERIALIZABLE
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

BEGIN TRANSACTION;

BEGIN TRY
    -- Nhân viên B đọc và khóa bản ghi với XLOCK
    SELECT max_num
    FROM Room WITH (XLOCK)
    WHERE type = 'Deluxe';

 
    -- Giảm số lượng phòng trống
    UPDATE Room
    SET max_num = max_num - 1
    WHERE type = 'Deluxe';

    -- In ra kết quả
    PRINT 'Nhân viên B: Cập nhật thành công. Số lượng phòng hiện tại là ' + CAST(@current_available_B - 1 AS NVARCHAR);

    -- Hoàn tất giao dịch
    COMMIT TRANSACTION;

END TRY
BEGIN CATCH
    -- Xử lý lỗi: Rollback giao dịch
    ROLLBACK TRANSACTION;
    PRINT ERROR_MESSAGE();
END CATCH;
