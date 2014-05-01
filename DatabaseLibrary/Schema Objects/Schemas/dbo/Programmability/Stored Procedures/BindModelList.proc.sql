CREATE PROC [dbo].[BindModelList]
@BrandID BIGINT
AS
BEGIN
	SELECT ModelID,ModelName FROM ModelsMaster
	WHERE BrandID=@BrandID AND Active=1
	
END
