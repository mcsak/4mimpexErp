
-- exec [GetDetailsForReturnedQty] '14'
CREATE PROCEDURE [dbo].[GetDetailsForReturnedQty]
	@EntityID varchar(100),
	@Type tinyint = 0
AS
begin	
	select Pm.ProductName, BM.BrandName, MM.ModelName, 0 as AvailableStock,BST.Barcode,sM.ModelID,IC.Amount as Price
	,IC.ID,IC.M_StockID,IC.Qty,IC.CustomerID,Ic.BarcodeID,IC.IssuesID,I.PaymentStatus 
	from IssuesChild IC 
	inner join Issues I on I.IssuesIDMaster=IC.IssuesID and I.DeleBy is null and IC.Active=1
	inner join StockMaster Sm on Sm.M_StockID=IC.M_StockID 
	inner join ModelsMaster MM on MM.ModelID=Sm.ModelID
	inner join BrandsMaster BM on BM.BrandID=MM.BrandID
	inner join ProductsMaster PM on Pm.ProductID=BM.BrandID
	inner join BarcodefromStockTrans BST on BST.BarcodeID=IC.BarcodeID and BST.Active=1 
	where IC.BarcodeID=CONVERT(bigint,@EntityID)


end
