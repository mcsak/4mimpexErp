

-- exec OpenStockToStockMaster 1
CREATE proc [dbo].[OpenStockToStockMaster]
@UserID bigint=0
as
begin
	Declare @_MStockID bigint
	Declare @TableID bigint, @M_StockID bigint,@ProductID bigint,@BrandID bigint,@ModelID bigint,@SerialNo varchar(50),@qty bigint,@Remarks varchar(500)
	Declare OpenStock_Cur Cursor for select ID,M_StockID,ProductID,BrandID,ModelID,SerialNo,qty,Remarks from OpenStockData Where Action in (0,1,2)
	declare @_MinStock int,@_MaxStock int
	if ((Select COUNT(*) from OpenStockData where Action in (0,1,2))>0)
	begin
		open OpenStock_Cur
			fetch next from OpenStock_Cur into @TableID,@M_StockID,@ProductID,@BrandID,@ModelID,@SerialNo,@qty,@Remarks 
			While @@FETCH_STATUS=0
			begin			
				if exists(select M_StockID from StockMaster where ModelID=@ModelID and Active=1)
				begin
					set @_MStockID=(select M_StockID from StockMaster where ModelID=@ModelID and Active=1)
					insert into Stock(M_StockID,Qty,ReceiptID,ReciptType,Active,SerialNo,Remarks,CreateBy,CreatedDateTime)
					values(@_MStockID,@qty,@TableID,0,1,@SerialNo,@Remarks,@UserID,GETDATE())
					update OpenStockData set Action=3 where ID=@TableID
					set @_MinStock =1 set @_MaxStock =isnull(@qty,0)
						-- Below will insert data to barcode tables
						while(@_MinStock<=@_MaxStock)
						begin
							insert into BarcodefromStockTrans (M_StockID) values(@_MStockID)
							set @_MinStock=@_MinStock+1
						end
				end
				else
				begin
					-- for this stock does not have master ID so this record will process later based on user input
					update OpenStockData set Action=2 where ID=@TableID
				end

				fetch next from OpenStock_Cur into @TableID,@M_StockID,@ProductID,@BrandID,@ModelID,@SerialNo,@qty,@Remarks 
			end
		close OpenStock_Cur
		
	end
	Deallocate OpenStock_Cur
end



