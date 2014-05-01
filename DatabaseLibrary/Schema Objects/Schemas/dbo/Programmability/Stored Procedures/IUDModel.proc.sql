CREATE PROC [dbo].[IUDModel]          
@ProductID BIGINT,          
@BrandID BIGINT,          
@ModelID BIGINT,        
@Model VARCHAR(100),          
@ModelDescription VARCHAR(500),          
@UserID BIGINT,          
@Action INT           
AS          
BEGIN          
 DECLARE @MAX BIGINT          
 IF @ACTION=1          
 BEGIN          
  SET @MAX =(SELECT ISNULL(MAX(ModelID),0)+1 FROM ModelsMaster)          
       IF EXISTS(SELECT *  FROM  ModelsMaster  WHERE ProductID=@ProductID and BrandID=@BrandID and ModelName=@Model)      
 select 'AEx' as Result      
 else      
  INSERT INTO ModelsMaster (ModelID,ModelName,Description,Active,ProductID,BrandID,CreateBy,CreatedDateTime) VALUES          
  (@MAX,@Model,@ModelDescription,1,@ProductID,@BrandID,@UserID,GETDATE())     
    
  DECLARE @ModelIDMax BIGINT  
  SET @ModelIDMax=(SELECT TOP 1 ModelID FROM ModelsMaster ORDER BY ModelID DESC)  
  DECLARE @M_StockIDMax BIGINT,@StockID VARCHAR(15)  
  SET @M_StockIDMax=(SELECT ISNULL(MAX(M_StockID),0) FROM StockMaster)
  set @M_StockIDMax=@M_StockIDMax+1  
  SET @StockID=(select ('ST-'+CONVERT(VARCHAR,RIGHT('0' + CONVERT(VARCHAR, DATEPART(MM, GETDATE())), 2))+ CONVERT(VARCHAR,DATEPART(YEAR,GETDATE()))+'-'+CONVERT(VARCHAR,RIGHT('00000'+convert(varchar,@ModelIDMax),6))))  
    
  INSERT INTO StockMaster (M_StockID,StockID,ModelID,Active,CreateBy,CreatedDateTime)VALUES  
  (@M_StockIDMax,@StockID,@ModelIDMax,1,@UserID,GETDATE())  
    
       
  select 'S' as Result        
 END          
 IF @ACTION=2          
 BEGIN          
  IF NOT EXISTS(SELECT * FROM ModelsMaster WHERE ModelID<>@ModelID AND ModelName=@Model AND Active=1)          
  BEGIN          
   UPDATE ModelsMaster          
   SET ModelName=@Model,Description=@ModelDescription, Modifyby=@UserID,ModifiedDateTime=GETDATE(),ProductID=@ProductID,BrandID=@BrandID          
   WHERE ModelID=@ModelID AND Active=1          
   select 'U' as Result      
  END          
 END          
 IF @ACTION=3          
 BEGIN          
   
  UPDATE ModelsMaster          
  SET ACTIVE=0 ,DeleBy=@UserID,DeletedDateTime=GETDATE()          
  WHERE ModelID=@ModelID          
  select 'D' as Result      
   
     
 END           
END


