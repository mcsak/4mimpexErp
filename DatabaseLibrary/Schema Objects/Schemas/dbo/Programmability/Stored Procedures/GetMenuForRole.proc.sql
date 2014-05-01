CREATE PROC [dbo].[GetMenuForRole]
@RoleID BIGINT
AS
BEGIN
	SELECT RoleID,MenuID FROM MenuMatrix 
	WHERE RoleID=@RoleID AND Active=1
END
