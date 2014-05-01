
create proc [dbo].[IUDCustomers]
@CustomerName VarChar(100),
@CustomerContacts VarChar(100),
@EmailAddress VarChar(50),
@Address VarChar(250),
@Output varchar(10) output
as
begin

if not exists(select CustomerID from Customer where CustomerName=@CustomerName and ContactNumber=@CustomerContacts and EmailID=@EmailAddress and Others=@Address and Active=1)
begin
	Insert into Customer(CustomerID,CustomerName,ContactNumber,EmailID,Others)
	values(ISNULL((Select (MAX(CustomerID)) from Customer),0)+1,@CustomerName,@CustomerContacts,@EmailAddress,@Address)
	set @Output='S'
end
else
set @Output='AEX'

end
