  
  
CREATE PROC [dbo].[GridModel]   
@SearchText VARCHAR(50),    
@Flag INT    
AS    
BEGIN    
 SELECT MM.ModelID,MM.ModelName,PM.ProductName,BM.BrandName,    
 CASE WHEN LEN(MM.[Description])>50 THEN LEFT(MM.[Description],50)+'...' ELSE MM.[Description] END AS [Description]    
 FROM ModelsMaster  MM
 INNER JOIN BrandsMaster BM ON BM.BrandID=MM.BrandID
 INNER JOIN ProductsMaster PM ON PM.ProductID=BM.ProductID   
 WHERE MM.Active=1 AND  
 CASE @Flag WHEN 0 THEN            
 CASE WHEN @searchText='' THEN 1 ELSE 0 END                   
 WHEN 1 THEN   CASE WHEN PM.ProductName LIKE '%' + @SearchText + '%' THEN 1 ELSE 0 END   
 WHEN 2 THEN   CASE WHEN BM.BrandName LIKE '%' + @SearchText + '%' THEN 1 ELSE 0 END   
 WHEN 3 THEN   CASE WHEN MM.ModelName LIKE '%' + @SearchText + '%' THEN 1 ELSE 0 END                   
 WHEN 4 THEN   CASE WHEN MM.[Description] LIKE '%' + @SearchText + '%' THEN 1 ELSE 0 END                      
 END=1    
     
END
