CREATE PROC [dbo].[BindSerial]
@SerialID BIGINT
AS
BEGIN
	SELECT SN.SerialID,SN.SerialNo,SN.ModelID,SN.BrandID,BM.ProductID FROM SerialNumber SN
	INNER JOIN BrandsMaster BM ON BM.BrandID=SN.BrandID 
	WHERE SN.SerialID=@SerialID
	
END
