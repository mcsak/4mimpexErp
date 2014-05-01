Create proc [dbo].[UserAndPasswdVerify]
@username varchar(200),
@password varchar(200)
as
begin
select * from Users where EmailID=@username and Password=@password
end
