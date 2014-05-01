CREATE PROC [dbo].[BindBrand]
@BrandID BIGINT
AS
BEGIN
	SELECT ProductID,BrandName,Description FROM BrandsMaster
	WHERE BrandID=@BrandID AND Active=1
END
