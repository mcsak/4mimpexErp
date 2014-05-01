/*

The below SP is for to get PO(Purchase Orders) data from temp table and stored to purchaseorderChild table accordingly.

*/

 CREATE proc [dbo].[InsertPurchaseOrdersFromTemptable]

 @UserID bigint,

 @Remarks varchar(500)

 as

 begin

	Declare @_maxLoop int=(Select COUNT(*) from PurchaseOrdersDataTemp)

	Declare @_Loop int=1,@_MaxPurchaseID bigint=(select ISNULL(MAX(MasterPurchaseID),0)+1 from PurchaseOrders),@_PurchaseIDChar varchar(25)

	declare @_thismonthCount int=0

	select @_thismonthCount=COUNT(*)+1 from PurchaseOrders where 

	DATEPART(MM,CreatedDateTime)=DATEPART(MM,GETDATE()) and  DATEPART(yy,CreatedDateTime)=DATEPART(yy,getdate())



	set @_PurchaseIDChar='PO-'+RIGHT('0'+CONVERT(varchar,datepart(mm,GETDATE())),2) +CONVERT(varchar,DATEPART(yy,getdate()))+'-'+RIGHT('00000'+CONVERT(varchar,@_thismonthCount),5)

	insert into PurchaseOrders(MasterPurchaseID,PurchaseID,Remarks,CreateBy,CreatedDateTime,Status)

	values(@_MaxPurchaseID,@_PurchaseIDChar,@Remarks,@UserID,GETDATE(),1)

	while(@_Loop<=@_maxLoop)

	begin

		insert into PurchaseOrdersChild(PurchaseID,ModelID,Qty,RemainQty,Status,CreateBy,CreatedDateTime) 		

		select @_MaxPurchaseID,ModelID,OrderedQty,OrderedQty,1,@UserID,GETDATE() from PurchaseOrdersDataTemp where id=@_Loop
				

	set @_Loop=@_Loop+1

	end



	truncate table PurchaseOrdersDataTemp

 end



