CREATE PROC [dbo].[BindProductList]
AS
BEGIN
	SELECT ProductID,ProductName FROM ProductsMaster WHERE Active=1
END
