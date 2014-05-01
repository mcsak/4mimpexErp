-- exec GetSinglePurchaseOrderDetailsForReceipt 1
CREATE proc [dbo].[GetSinglePurchaseOrderDetailsForReceipt]
@PurchaseOrderID bigint
as
begin

	select P.PurchaseID,pc.PurchaseID as PurchaseIDMaster,PC.ModelID,
	PC.Qty as OrderQty,PC.RemainQty,(PC.Qty-PC.RemainQty) AS PreviousQty, 0 as CurrentQty,
	p.CreatedDateTime as OrderDate,
	MM.ModelName,BM.BrandName,Pm.ProductName
	
	from PurchaseOrdersChild PC
	inner join PurchaseOrders P on p.MasterPurchaseID=pc.PurchaseID and p.DeleBy is null
	inner join ModelsMaster MM on MM.ModelID=pc.ModelID 
	inner join BrandsMaster BM on BM.BrandID=MM.BrandID
	inner join ProductsMaster Pm on pm.ProductID=MM.ProductID
	where pc.PurchaseID=@PurchaseOrderID and pc.DeleBy is null and RemainQty<>0

end


