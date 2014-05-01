CREATE PROC [dbo].[BindBrandList]
@ProductID BIGINT
AS
BEGIN
	SELECT BrandID,BrandName FROM BrandsMaster
	WHERE ProductID=@ProductID AND Active=1
	
END
