CREATE PROC [dbo].[BindPricing]  
@PriceID BIGINT  
AS  
BEGIN  
 SELECT PD.Price,PD.Description,PD.ModelID,BM.BrandID,PM.ProductID,PD.Discount FROM PriceDetails PD  
 INNER JOIN ModelsMaster MM ON MM.ModelID=PD.ModelID  
 INNER JOIN BrandsMaster BM ON BM.BrandID=MM.BrandID  
 INNER JOIN ProductsMaster PM ON PM.ProductID=BM.ProductID  
 WHERE PD.PriceID=@PriceID AND PD.Active=1 AND MM.Active=1 AND BM.Active=1 AND PM.Active=1  
END

select * from pricedetails
