    
--FOR PRODUCT ADD/MODIFY/DELETE    
    
CREATE PROC [dbo].[IUDProduct]    
@ProductID BIGINT,    
@Product VARCHAR(100),    
@ProductDescription VARCHAR(500),    
@UserID BIGINT,  
@Action INT    
AS    
BEGIN     
 DECLARE @MAX BIGINT   
 declare @Output varchar  
  
  IF @ACTION=1    
 BEGIN    
  SET @MAX =(SELECT ISNULL(MAX(ProductID),0)+1 FROM ProductsMaster)    
    IF EXISTS(SELECT *  FROM  ProductsMaster  WHERE ProductName=@Product )  
    select 'AEx' as Result  
 else  
  INSERT INTO ProductsMaster (ProductID,ProductName,Description,Active,CreateBy,CreatedDateTime) VALUES    
  (@MAX,@Product,@ProductDescription,1,@UserID,GETDATE())    
  select 'S' as Result  
 END    
 IF @ACTION=2    
 BEGIN    
  IF NOT EXISTS(SELECT * FROM ProductsMaster WHERE ProductID<>@ProductID AND ProductName=@Product AND Active=1)    
  BEGIN    
   UPDATE ProductsMaster    
   SET ProductName=@Product,Description=@ProductDescription, Modifyby=@UserID,ModifiedDateTime=GETDATE()    
   WHERE ProductID=@ProductID AND Active=1    
   select 'U' as Result  
  END    
 END    
 IF @ACTION=3    
 BEGIN    
 IF NOT EXISTS (SELECT * FROM BrandsMaster WHERE ProductID=@ProductID AND Active=1)
 BEGIN
   UPDATE ProductsMaster    
  SET ACTIVE=0 ,DeleBy=@UserID,DeletedDateTime=GETDATE()    
  WHERE ProductID=@ProductID    
  select 'D' as Result 
 END
 ELSE
 BEGIN
	 select 'ND' as Result 
 END
 
 END    
     
     
END
