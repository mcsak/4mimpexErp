
-- exec GetAdvanceSearchresults 'ST-092013-000002'
-- Laptop 1 - R400 - Lenovo	ST-092013-000002	17	~/Products/SearchResults.aspx?LoadID=21&LoadValue=1
CREATE proc [dbo].[GetAdvanceSearchresults]
@SearchText varchar(100)
as
begin

Select Tbls.* from
(select Pm.ProductName+' - '+MM.ModelName+' - '+BM.BrandName as EntityName,
(select StockID from StockMaster SM where SM.ModelID=MM.ModelID) as EntityNameID,
MM.ModelID,
dbo.getCurrrentStockForModelID(MM.ModelID) as AvailableQty,
'~/Products/SearchResults.aspx?LoadID=21&LoadValue='+CONVERT(varchar,MM.ModelID) as UrlWithID
 from ModelsMaster MM
inner join BrandsMaster BM on BM.BrandID=MM.ModelID and BM.Active=1 
inner join ProductsMaster PM on PM.ProductID=MM.ModelID and PM.Active=1
Where MM.Active=1
) Tbls

where Tbls.EntityName like '%'+@SearchText+'%' or Tbls.EntityNameID like '%'+@SearchText+'%'
--group by Tbls.EntityName,Tbls.EntityNameID,Tbls.AvailableQty,Tbls.UrlWithID


end


