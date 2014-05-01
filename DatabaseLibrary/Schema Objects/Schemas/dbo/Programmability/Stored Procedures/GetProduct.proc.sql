CREATE PROC [dbo].[GetProduct]
@SearchText VARCHAR(50),
@Flag INT
AS
BEGIN
	SELECT ProductID,ProductName,
	CASE WHEN LEN([Description])>50 THEN LEFT([Description],50)+'...' ELSE [Description] END AS [Description]
	FROM ProductsMaster
	WHERE Active=1 AND
	CASE @Flag WHEN 0 THEN        
	CASE WHEN @searchText='' THEN 1 ELSE 0 END               
	WHEN 1 THEN   CASE WHEN ProductName LIKE '%' + @SearchText + '%' THEN 1 ELSE 0 END               
	WHEN 2 THEN   CASE WHEN [Description] LIKE '%' + @SearchText + '%' THEN 1 ELSE 0 END                  
	END=1
	
END
