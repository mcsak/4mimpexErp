


CREATE PROC [dbo].[GridPrice] 
@SearchText VARCHAR(50),  
@Flag INT  
AS  
BEGIN  
 SELECT PM.PriceID,PM.Price,MM.ModelName,  
 CASE WHEN LEN(PM.Description)>50 THEN LEFT(PM.Description,50)+'...' ELSE PM.Description END AS Description  
 FROM PriceDetails PM
 INNER JOIN ModelsMaster MM ON MM.ModelID=PM.ModelID  
 WHERE PM.Active=1 AND MM.Active=1 AND  
 CASE @Flag WHEN 0 THEN          
 CASE WHEN @searchText='' THEN 1 ELSE 0 END                 
 WHEN 1 THEN   CASE WHEN MM.ModelName LIKE '%' + @SearchText + '%' THEN 1 ELSE 0 END  
  WHEN 2 THEN   CASE WHEN PM.Price LIKE '%' + @SearchText + '%' THEN 1 ELSE 0 END                  
 WHEN 3 THEN   CASE WHEN PM.Description LIKE '%' + @SearchText + '%' THEN 1 ELSE 0 END                    
 END=1  
   
END

select * from Pricedetails
