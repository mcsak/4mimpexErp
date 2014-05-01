CREATE PROC [dbo].[GetUserandPass]
@UserID VARCHAR(50),
@Password VARCHAR(50)
AS
BEGIN
	IF EXISTS (SELECT * FROM USERS WHERE EmailID=@UserID AND Password=@Password AND Active=1)
	SELECT UserID,'S' AS Result  FROM USERS WHERE EmailID=@UserID AND Password=@Password AND Active=1
	
END
