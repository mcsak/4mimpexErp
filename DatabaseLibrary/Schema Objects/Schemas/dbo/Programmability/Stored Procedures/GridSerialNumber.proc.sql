  
  
CREATE PROC [dbo].[GridSerialNumber]   
@SearchText VARCHAR(50),    
@Flag INT    
AS    
BEGIN    
 SELECT SN.SerialID,SN.SerialNo,MM.ModelName    
 FROM SerialNumber SN
 INNER JOIN ModelsMaster MM ON MM.ModelID=SN.ModelID
 WHERE SN.Active=1 AND MM.Active=1 AND    
 CASE @Flag WHEN 0 THEN            
 CASE WHEN @searchText='' THEN 1 ELSE 0 END                   
 WHEN 1 THEN   CASE WHEN SN.SerialNo LIKE '%' + @SearchText + '%' THEN 1 ELSE 0 END                   
 WHEN 2 THEN   CASE WHEN MM.ModelName LIKE '%' + @SearchText + '%' THEN 1 ELSE 0 END                      
 END=1    
     
END
