
create proc [dbo].[GetDDLCustomers]
as
begin
	select CustomerID,CustomerName  from Customer where Active=1
	
end
