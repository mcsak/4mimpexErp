-- exec GetOpenStockTemplate '',0

CREATE proc [dbo].[GetOpenStockTemplate]
@SearchText varchar(50), 
@Flag tinyint
as
begin
select ROW_NUMBER() over (order by tbl.StockID) as ID, tbl.* from
	(select distinct SM.M_StockID as StockID,pm.ProductID,pm.ProductName,BM.BrandID,BM.BrandName,MM.ModelID,MM.ModelName,'' as SerialNo,'Open Stock' as Remarks,0 as Qty

	 from StockMaster SM 

	--Left join Stock S on S.M_StockID=SM.M_StockID and Sm.DeleBy is null

	inner join ModelsMaster MM on MM.ModelID=SM.ModelID and SM.DeleBy is null

	inner join BrandsMaster BM on BM.BrandID=MM.BrandID and BM.DeleBy is null

	inner join ProductsMaster Pm on Pm.ProductID=MM.ProductID and Pm.DeleBy is null

	where 
 CASE @Flag WHEN 0 THEN            

 CASE WHEN @searchText='' THEN 1 ELSE 0 END                   

 WHEN 1 THEN   CASE WHEN PM.ProductName LIKE '%' + @SearchText + '%' THEN 1 ELSE 0 END   

 WHEN 2 THEN   CASE WHEN BM.BrandName LIKE '%' + @SearchText + '%' THEN 1 ELSE 0 END   

 WHEN 3 THEN   CASE WHEN MM.ModelName LIKE '%' + @SearchText + '%' THEN 1 ELSE 0 END                   

 WHEN 4 THEN   CASE WHEN MM.[Description] LIKE '%' + @SearchText + '%' THEN 1 ELSE 0 END                      

 END=1  )Tbl  

end



