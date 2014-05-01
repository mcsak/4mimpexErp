-- LoadListItems 1,1,0,3

CREATE proc [dbo].[LoadListItems]
@ProductID bigint,
@BrandID bigint, 
@Action int
as
begin

	if(@Action=1)
	begin
		select ProductID,ProductName from ProductsMaster where Active=1
	end
	else if(@Action=2)
	begin
		select BrandID,BrandName from BrandsMaster where Active=1 and ProductID=@ProductID
	end
	else if (@Action=3)
	begin
		select ModelID,ModelName from ModelsMaster where Active=1 and BrandID=@BrandID and ProductID=@ProductID
	end

end
