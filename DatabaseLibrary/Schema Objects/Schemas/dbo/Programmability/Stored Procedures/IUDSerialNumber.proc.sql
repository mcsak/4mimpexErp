CREATE PROC [dbo].[IUDSerialNumber]      
@ProductID BIGINT,      
@BrandID BIGINT,      
@ModelID BIGINT, 
@SerialID BIGINT,   
@SerialNumber VARCHAR(100),    
@UserID BIGINT,      
@Action INT       
AS      
BEGIN      
 DECLARE @MAX BIGINT      
 IF @ACTION=1      
 BEGIN      
  SET @MAX =(SELECT ISNULL(MAX(SerialID),0)+1 FROM SerialNumber)      
       IF EXISTS(SELECT *  FROM  SerialNumber  WHERE SerialNo=@SerialNumber and BrandID=@BrandID and ModelID=@ModelID)  
 select 'AEx' as Result  
 else  
  INSERT INTO SerialNumber (SerialID,SerialNo,ModelID,BrandID,Active,CreateBy,CreatedDateTime) VALUES      
  (@MAX,@SerialNumber,@ModelID,@BrandID,1,@UserID,GETDATE())    
  select 'S' as Result    
 END      
 IF @ACTION=2      
 BEGIN      
  IF NOT EXISTS(SELECT * FROM SerialNumber WHERE SerialID<>@SerialID AND SerialNo=@SerialNumber AND Active=1)      
  BEGIN      
   UPDATE SerialNumber      
   SET SerialNo=@SerialNumber, Modifyby=@UserID,ModifiedDateTime=GETDATE(),ModelID=@ModelID,BrandID=@BrandID      
   WHERE SerialID=@SerialID AND Active=1      
   select 'U' as Result  
  END      
 END      
 IF @ACTION=3      
 BEGIN      
  UPDATE SerialNumber      
  SET ACTIVE=0 ,DeleBy=@UserID,DeletedDateTime=GETDATE()      
  WHERE SerialID=@SerialID      
  select 'D' as Result  
 END       
END
