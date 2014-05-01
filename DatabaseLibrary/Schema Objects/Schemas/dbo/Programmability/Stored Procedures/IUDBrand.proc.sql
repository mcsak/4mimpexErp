CREATE PROC [dbo].[IUDBrand]      
@ProductID BIGINT,      
@BrandID BIGINT,      
@Brand VARCHAR(100),      
@BrandDescription VARCHAR(500),      
@UserID BIGINT,      
@Action INT       
AS      
BEGIN      
 DECLARE @MAX BIGINT      
 IF @ACTION=1      
 BEGIN      
  SET @MAX =(SELECT ISNULL(MAX(BrandID),0)+1 FROM BrandsMaster)      
    IF EXISTS(SELECT *  FROM  BrandsMaster  WHERE ProductID=@ProductID and BrandName=@Brand)    
    select 'AEx' as Result    
 else    
  INSERT INTO BrandsMaster (BrandID,BrandName,Description,Active,ProductID,CreateBy,CreatedDateTime) VALUES      
  (@MAX,@Brand,@BrandDescription,1,@ProductID,@UserID,GETDATE())      
  select 'S' as Result    
 END      
 IF @ACTION=2      
 BEGIN      
  IF NOT EXISTS(SELECT * FROM BrandsMaster WHERE BrandID<>@BrandID AND BrandName=@Brand AND Active=1)      
  BEGIN      
   UPDATE BrandsMaster      
   SET BrandName=@Brand,Description=@BrandDescription, Modifyby=@UserID,ModifiedDateTime=GETDATE(),ProductID=@ProductID      
   WHERE BrandID=@BrandID AND Active=1     
   select 'U' as Result     
  END      
 END      
 IF @ACTION=3      
 BEGIN      
 IF NOT EXISTS(SELECT * FROM ModelsMaster WHERE BrandID=@BrandID AND Active=1 )   
 BEGIN  
  UPDATE BrandsMaster      
  SET ACTIVE=0 ,DeleBy=@UserID,DeletedDateTime=GETDATE()      
  WHERE BrandID=@BrandID      
  select 'D' as Result    
  END  
  ELSE  
  BEGIN  
  SELECT 'ND' as Result  
  END  
 END       
END
