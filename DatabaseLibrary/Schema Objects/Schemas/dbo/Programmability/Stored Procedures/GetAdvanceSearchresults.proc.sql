
-- exec GetAdvanceSearchresults 'NA-201403-00016'
-- Laptop 1 - R400 - Lenovo	ST-092013-000002	17	~/Products/SearchResults.aspx?LoadID=21&LoadValue=1
CREATE proc [dbo].[GetAdvanceSearchresults]
@SearchText varchar(100)
as
begin

/* for barcode item search match*/
if exists(select M_StockID from BarcodefromStockTrans where Barcode=@SearchText)
begin
Select Tbls.* from
(


select Pm.ProductName+' - '+MM.ModelName+' - '+BM.BrandName as EntityName,
BST.Barcode as EntityNameID,
BST.BarcodeID as ModelID, BST.Status as Type,
dbo.getCurrrentStockForModelID(MM.ModelID) as AvailableQty
	/*,case when BST.Status=2 then ('~/Products/ReturnsFromSales.aspx?LoadID=21&LoadValue='+CONVERT(varchar,BST.BarcodeID)) 
	else ('~/Products/SearchResults.aspx?LoadID=21&LoadValue='+CONVERT(varchar,MM.ModelID)) end as UrlWithID*/
from BarcodefromStockTrans BST 
inner join StockMaster SM on SM.M_StockID=BST.M_StockID and BST.Active=1
inner join ModelsMaster MM on MM.ModelID=Sm.ModelID and SM.Active=1
inner join BrandsMaster BM on BM.BrandID=MM.ModelID and BM.Active=1 
inner join ProductsMaster PM on PM.ProductID=MM.ModelID and PM.Active=1
where BST.Active=1 and BST.Barcode=@SearchText

) Tbls
end
else
begin

/*for non barcode item search matches*/
Select Tbls.* from
(select Pm.ProductName+' - '+MM.ModelName+' - '+BM.BrandName as EntityName,
(select StockID from StockMaster SM where SM.ModelID=MM.ModelID) as EntityNameID,
MM.ModelID, 1 as Type,
dbo.getCurrrentStockForModelID(MM.ModelID) as AvailableQty
/*,'~/Products/SearchResults.aspx?LoadID=21&LoadValue='+CONVERT(varchar,MM.ModelID) as UrlWithID*/
 from ModelsMaster MM
inner join BrandsMaster BM on BM.BrandID=MM.ModelID and BM.Active=1 
inner join ProductsMaster PM on PM.ProductID=MM.ModelID and PM.Active=1

Where MM.Active=1
) Tbls

where Tbls.EntityName like '%'+@SearchText+'%' or Tbls.EntityNameID like '%'+@SearchText+'%'
--group by Tbls.EntityName,Tbls.EntityNameID,Tbls.AvailableQty,Tbls.UrlWithID
end

end


