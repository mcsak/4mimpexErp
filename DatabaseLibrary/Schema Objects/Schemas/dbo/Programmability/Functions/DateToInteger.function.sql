CREATE FUNCTION [dbo].[DateToInteger] (@Date datetime)    
RETURNS int    
WITH SCHEMABINDING    
AS    
BEGIN    
    
RETURN CAST(CONVERT(varchar,@Date,112) AS int)     
   
END
