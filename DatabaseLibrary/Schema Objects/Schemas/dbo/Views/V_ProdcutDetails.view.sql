CREATE VIEW [dbo].[V_ProdcutDetails] AS 
SELECT 
	MM.ModelID   AS ModelID ,
	MM.ModelName  AS ModelName,
	MM.Description AS ModelDescription,
	BM.BrandID AS BrandID ,
	BM.BrandName  AS BrandName,
	BM.Description  AS BrandDescription,
	PM.ProductID  AS ProductID,
	PM.ProductName AS ProductName,
	PM.Description  AS ProductDescription
FROM 
ProductsMaster AS PM
	INNER JOIN ModelsMaster AS MM 
		ON PM.ProductID = MM.ProductID 
	INNER JOIN BrandsMaster AS BM 
		ON PM.ProductID = BM.ProductID 
		AND MM.BrandID = BM.BrandID 
		
		
