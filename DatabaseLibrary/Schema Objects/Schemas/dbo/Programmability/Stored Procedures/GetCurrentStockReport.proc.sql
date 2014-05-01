
-- GetCurrentStockReport '',0
CREATE proc [dbo].[GetCurrentStockReport]
@SearchText varchar(50), 
@Flag tinyint
as
begin
	declare @_STockAvailable table(ID bigint identity(1,1),ProductName varchar(50),BrandName varchar(50),ModelName varchar(50),M_StockID bigint, Qty int)
	insert into @_STockAvailable(ProductName,BrandName,ModelName,M_StockID,Qty)
	select distinct pm.ProductName,BM.BrandName,MM.ModelName,
	SM.M_StockID,0
	 from Stock S 
	inner join StockMaster SM on SM.M_StockID=s.M_StockID
	inner join ModelsMaster MM on MM.ModelID=SM.ModelID
	inner join BrandsMaster BM on BM.BrandID=MM.BrandID
	inner join ProductsMaster Pm on Pm.ProductID=MM.ProductID

	declare @_loop int=1,@_maxloop int=(select COUNT(*) from @_STockAvailable)
	while(@_loop<=@_maxloop)
	begin
		update @_STockAvailable set Qty=(
		(select ISNULL(SUM(ISNULL(Qty,0)),0) from Stock where M_StockID=(select M_StockID from @_STockAvailable where ID=@_loop))
		-
		(select ISNULL(SUM(ISNULL(Qty,0)),0) from IssuesChild where M_StockID=(select M_StockID from @_STockAvailable where ID=@_loop))
		)
		where ID=@_loop
	set @_loop=@_loop+1
	end

	select * from @_STockAvailable
end

