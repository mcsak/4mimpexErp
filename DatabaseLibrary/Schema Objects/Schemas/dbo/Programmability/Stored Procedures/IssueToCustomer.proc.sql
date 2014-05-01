
CREATE proc [dbo].[IssueToCustomer]
@UserID int,
@Remarks varchar(500),
@CustomerName varchar(200),
@ContactNumber varchar(200),
@EmailID varchar(200),
@Others varchar(500),
@Output varchar(50) output
as
begin
	declare @_loop int=1,@_maxloop int=(select ISNULL(MAX(ID),0) from IssueToCustomerTemp)
	Declare @_IssuedIDChar varchar(25),@_M_StockID bigint
	declare @_thismonthCount int=0,@_MasterIssuedID bigint=(select MAX(IssuesIDMaster)+1 from Issues)

	declare @_CustomerID bigint=0
	
		if exists(select CustomerID from Customer where CustomerName=@CustomerName and ContactNumber=@ContactNumber and EmailID=@EmailID AND Active=1)
		begin
			set @_CustomerID =(select CustomerID from Customer where CustomerName=@CustomerName and ContactNumber=@ContactNumber and EmailID=@EmailID)
		end
		else
		begin
			set @_CustomerID=ISNULL((select ISNULL(MAX(CustomerID),0) from Customer),0)+1
			insert into Customer(CustomerID,CustomerName,ContactNumber,EmailID,Others)
			values(@_CustomerID,@CustomerName,@ContactNumber,@EmailID,@Others)
		end


	select @_thismonthCount=COUNT(*)+1 from Issues where 
	DATEPART(MM,CreatedDateTime)=DATEPART(MM,GETDATE()) and  DATEPART(yy,CreatedDateTime)=DATEPART(yy,getdate())
	set @_IssuedIDChar='NKL-'+RIGHT('0'+CONVERT(varchar,datepart(mm,GETDATE())),2) +CONVERT(varchar,DATEPART(yy,getdate()))+'-'+RIGHT('00000'+CONVERT(varchar,@_thismonthCount),5)
	insert into Issues(IssuesIDMaster,IssuesID,Remarks,CreateBy,CreatedDateTime,Amount,CustomerID)
	values(@_MasterIssuedID,@_IssuedIDChar,@Remarks,@UserID,GETDATE(),(select ISNULL(SUM(ISNULL(Amount,0)),0) from IssueToCustomerTemp where UserID=@UserID),@_CustomerID)
	while(@_loop<=@_maxloop)
	begin
		DECLARE @_BarcodeID bigint=0
		set @_M_StockID=(select M_StockID from StockMaster where ModelID=(select ModelID from IssueToCustomerTemp where ID=@_loop))
		set @_BarcodeID=ISNULL((select BarcodeID from BarcodefromStockTrans where Active=1 and M_StockID=@_M_StockID),0)
		insert into IssuesChild(IssuesID,M_StockID,Qty,Active,Amount,BarcodeID)
		select @_MasterIssuedID,@_M_StockID,Qty,1,Amount,@_BarcodeID from IssueToCustomerTemp where ID=@_loop
	set @_loop=@_loop+1
	end

	insert into CashTransactions(TxnID,TransID,TxnType,Amount,ReferenceID,Remarks,Active,CreateBy,CreatedDateTime)
	values(
	(select ISNULL(MAX(ISNULL(TxnID,0)),0)+1 from CashTransactions),null,2,
	(select ISNULL(SUM(ISNULL(Amount,0)),0) from IssueToCustomerTemp where UserID=@UserID),
	@_MasterIssuedID,@Remarks,1,@UserID,GETDATE()
	)

	truncate table IssueToCustomerTemp

	set @Output='S,'+ @_IssuedIDChar
end











