CREATE PROC [dbo].[BindModel]
@ModelID BIGINT
AS
BEGIN
	SELECT ProductID,BrandID,ModelName,Description FROM ModelsMaster
	WHERE ModelID=@ModelID AND Active=1
END

