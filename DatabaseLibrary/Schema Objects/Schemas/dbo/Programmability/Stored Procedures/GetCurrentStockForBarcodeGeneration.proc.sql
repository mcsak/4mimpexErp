
-- GetCurrentStockForBarcodeGeneration 'R40',1
CREATE proc [dbo].[GetCurrentStockForBarcodeGeneration]
@SearchText varchar(50), 
@Flag tinyint
as
begin

Declare @_minLoop int=1 ,@_maxLoop int=isnull((Select COUNT(*) from BarcodefromStockTrans where Active=1 and Barcode is null),0)
while(@_minLoop<=@_maxLoop)
begin
	declare @_CountThisMonth int=isnull((select COUNT(*) from BarcodefromStockTrans where Active=1 and DATEPART(MM,GETDATE())=DATEPART(MM,ModifiedDate) and DATEPART(YY,GETDATE())=DATEPART(YY,ModifiedDate)),0)+1
		declare @_Barcode varchar(50)=(select('NA-'+ CONVERT(varchar,DATEPART(YY,GETDATE()))  + RIGHT('0'+CONVERT(varchar,DATEPART(MM,GETDATE())),2) +'-'+
										RIGHT('00000'+CONVERT(varchar,(@_CountThisMonth)),5)	)
										)
		update top (1) BarcodefromStockTrans set Barcode=@_Barcode,ModifiedBy=2,ModifiedDate=GETDATE() where Active=1 and Barcode is null 
	set @_minLoop=@_minLoop+1	
end
	
	select PM.ProductName,BM.BrandName,MM.ModelName,SM.M_StockID,BC.Barcode from BarcodefromStockTrans BC 
	inner join StockMaster SM on SM.M_StockID=bc.M_StockID and SM.Active=1
	inner join ModelsMaster MM on MM.ModelID=SM.ModelID and MM.Active=1
	inner join BrandsMaster BM on BM.BrandID=MM.BrandID and BM.Active=1
	inner join ProductsMaster PM on PM.ProductID=MM.ProductID and PM.Active=1
	where BC.Active=1 and --BC.Barcode is null and 
	case @Flag when 0 then 1
		when 1 then case when MM.ModelName like '%'+@SearchText+'%' then 1 else 0 end
		end=1

	order by Pm.ProductName,BM.BrandName,MM.ModelName



	
end



