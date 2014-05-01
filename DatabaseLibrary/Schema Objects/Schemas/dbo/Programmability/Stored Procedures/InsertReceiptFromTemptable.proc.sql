
/*
This stored procedure will get data from temp table of receipt, and will stoore it into stock table.
after that purchase order will get upadtes based on Qty. 
*/
CREATE proc [dbo].[InsertReceiptFromTemptable]
@UserID int,
@Remarks varchar(500)
as
begin
	Declare @_maxLoop int=(Select COUNT(*) from ReceiptDataTemp)
	Declare @_Loop int=1,@_MaxReceiptID bigint=(select ISNULL(MAX(ReceiptIDMaster),0)+1 from Receipts),@_ReceiptIDChar varchar(25),@_StockID bigint
	declare @_thismonthCount int=0,@_RemainQty int=0
	select @_thismonthCount=COUNT(*)+1 from Receipts where 
	DATEPART(MM,CreatedDateTime)=DATEPART(MM,GETDATE()) and  DATEPART(yy,CreatedDateTime)=DATEPART(yy,getdate())

	set @_ReceiptIDChar='RCP-'+RIGHT('0'+CONVERT(varchar,datepart(mm,GETDATE())),2) +CONVERT(varchar,DATEPART(yy,getdate()))+'-'+RIGHT('00000'+CONVERT(varchar,@_thismonthCount),5)
	insert into Receipts(ReceiptIDMaster,ReceiptID,PurchaseID,Type,Remarks,CreateBy,CreatedDateTime)
	values(@_MaxReceiptID,@_ReceiptIDChar,(Select top 1 PurchaseID from ReceiptDataTemp),3,@Remarks,@UserID,GETDATE())
	declare @_MinStock int,@_MaxStock int
	while(@_Loop<=@_maxLoop)
	begin
		set @_StockID=(select M_StockID from StockMaster where ModelID=(select ModelID from ReceiptDataTemp where ID=@_Loop))
		insert into Stock(M_StockID,Qty,ReceiptID,ReciptType,Active,SerialNo,CreateBy,CreatedDateTime)
		select @_StockID,Qty,@_MaxReceiptID,3,1,SerialNo,@UserID,GETDATE() from ReceiptDataTemp where ID=@_Loop
		
		set @_MinStock =1 set @_MaxStock =isnull((select Qty from ReceiptDataTemp where ID=@_Loop),0)
		-- Below will insert data to barcode tables
		while(@_MinStock<=@_MaxStock)
		begin
			insert into BarcodefromStockTrans (M_StockID) values(@_StockID)
			set @_MinStock=@_MinStock+1
		end
		set @_RemainQty=(
		(select ISNULL(RemainQty,0) from PurchaseOrdersChild where PurchaseID=(select PurchaseID from ReceiptDataTemp where ID=@_Loop)and 
		ModelID=(select ModelID from ReceiptDataTemp where ID=@_Loop) ) -
		(select Qty from ReceiptDataTemp where ID=@_Loop)
		)
				
		update PurchaseOrdersChild set status=3 ,RemainQty=@_RemainQty
		where PurchaseID=(select PurchaseID from ReceiptDataTemp where ID=@_Loop) 
		and ModelID=(select ModelID from ReceiptDataTemp where ID=@_Loop)

		if(@_RemainQty=0)
		begin
			update PurchaseOrdersChild set status=2 
		where PurchaseID=(select PurchaseID from ReceiptDataTemp where ID=@_Loop) 
		and ModelID=(select ModelID from ReceiptDataTemp where ID=@_Loop)
		end
						
	set @_Loop=@_Loop+1
	end

	if((select ISNULL(SUM(ISNULL(RemainQty,0)),0) from PurchaseOrdersChild where PurchaseID=(select top 1 PurchaseID from ReceiptDataTemp))=0)
		begin
			update PurchaseOrders set Status=2,ModifiedDateTime=GETDATE(),Modifyby=@UserID where MasterPurchaseID=(select top 1 PurchaseID from ReceiptDataTemp)
		end
		else 
		begin
			update PurchaseOrders set Status=3,ModifiedDateTime=GETDATE(),Modifyby=@UserID where MasterPurchaseID=(select top 1 PurchaseID from ReceiptDataTemp)
		end
	truncate table ReceiptDataTemp
end



