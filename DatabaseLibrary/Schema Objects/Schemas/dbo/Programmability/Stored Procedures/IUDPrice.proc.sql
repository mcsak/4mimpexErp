CREATE PROC [dbo].[IUDPrice]     
@ProductID BIGINT,        
@BrandID BIGINT,        
@ModelID BIGINT,      
@PriceID BIGINT,    
@Price VARCHAR(100),        
@Description VARCHAR(500),        
@Discount TINYINT,    
@UserID BIGINT,        
@Action INT         
AS        
BEGIN        
 DECLARE @MAX BIGINT        
 IF @ACTION=1        
 BEGIN        
  SET @MAX =(SELECT ISNULL(MAX(PriceID),0)+1 FROM PriceDetails)        
    
  IF  EXISTS(SELECT * FROM PriceDetails WHERE PriceID=@PriceID AND Price=@Price AND ModelID=@ModelID AND Active=1)    
  select 'AEx' as Result     
  ELSE      
  INSERT INTO PriceDetails (PriceID,Price,Description,ModelID,Active,CreateBy,CreatedDateTime,Discount) VALUES        
  (@MAX,@Price,@Description,@ModelID,1,@UserID,GETDATE(),@Discount)     
     select 'S' as Result   
 END        
 IF @ACTION=2        
 BEGIN        
  IF NOT EXISTS(SELECT * FROM PriceDetails WHERE PriceID<>@PriceID AND Price=@Price AND Active=1)        
  BEGIN        
   UPDATE PriceDetails        
   SET Price=@Price,Description=@Description,ModelID=@ModelID, Modifyby=@UserID,ModifiedDateTime=GETDATE(),Discount=@Discount        
   WHERE PriceID=@PriceID AND Active=1        
    select 'U' as Result    
  END        
 END        
 IF @ACTION=3        
 BEGIN        
  UPDATE PriceDetails        
  SET ACTIVE=0 ,DeleBy=@UserID,DeletedDateTime=GETDATE()        
  WHERE PriceID=@PriceID    
   select 'D' as Result        
 END         
END
