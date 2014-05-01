
create proc [dbo].[GetDDLCustomersdetails]
@CustomerID bigint
as
begin
	select CustomerID,CustomerName,ContactNumber,EmailID as EmailAddress,Others as [Address] from Customer where Active=1 and CustomerID=@CustomerID
end
