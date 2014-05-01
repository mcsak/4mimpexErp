--GET PRODUCT DETAILS OF SELECTED PRODUCT ID

CREATE PROC [dbo].[BindProduct]
@ProductID BIGINT
AS
BEGIN
	SELECT ProductID,ProductName,Description FROM ProductsMaster
	WHERE ProductID=@ProductID AND Active=1
END



