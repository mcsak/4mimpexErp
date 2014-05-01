
-- exec GetBarcodeStringAndUpdate 2
CREATE proc [dbo].[GetBarcodeStringAndUpdate]
@UserID int,
@StockID bigint,
@Output varchar(50) output
as
begin
	if Exists(select top 1 BarcodeID from BarcodefromStockTrans where Active=1 and M_StockID=@StockID and Barcode is null)
	begin
		declare @_CountThisMonth int=isnull((select COUNT(*) from BarcodefromStockTrans where Active=1 and DATEPART(MM,GETDATE())=DATEPART(MM,ModifiedDate) and DATEPART(YY,GETDATE())=DATEPART(YY,ModifiedDate)),0)+1
		declare @_Barcode varchar(50)=(select('NA-'+ CONVERT(varchar,DATEPART(YY,GETDATE()))  + RIGHT('0'+CONVERT(varchar,DATEPART(MM,GETDATE())),2) +'-'+
										RIGHT('00000'+CONVERT(varchar,(@_CountThisMonth)),5)	)
										)
		update top (1) BarcodefromStockTrans set Barcode=@_Barcode,ModifiedBy=@UserID,ModifiedDate=GETDATE() where M_StockID=@StockID and Barcode is null 
		set @Output='S,'+@_Barcode
	end
	else
		set @Output='N'
end


