  
  
CREATE PROC [dbo].[GetBrand]    
@SearchText VARCHAR(50),    
@Flag INT    
AS    
BEGIN    
 SELECT BM.BrandID,BM.BrandName,PM.ProductName,  
 CASE WHEN LEN(BM.Description)>50 THEN LEFT(BM.Description,50)+'...' ELSE BM.Description END AS [Description]    
 FROM BrandsMaster BM
 INNER JOIN  ProductsMaster PM ON PM.ProductID=BM.ProductID  
 WHERE BM.Active=1 AND  
 CASE @Flag WHEN 0 THEN            
 CASE WHEN @searchText='' THEN 1 ELSE 0 END    
 WHEN 1 THEN   CASE WHEN PM.ProductName LIKE '%' + @SearchText + '%' THEN 1 ELSE 0 END                
 WHEN 2 THEN   CASE WHEN BM.BrandName LIKE '%' + @SearchText + '%' THEN 1 ELSE 0 END                   
 WHEN 3 THEN   CASE WHEN BM.Description LIKE '%' + @SearchText + '%' THEN 1 ELSE 0 END                      
 END=1    
     
END
