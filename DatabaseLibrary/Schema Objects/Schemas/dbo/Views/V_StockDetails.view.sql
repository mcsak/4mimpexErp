
CREATE VIEW [dbo].[V_StockDetails] AS 
SELECT 
	SM.M_StockID AS M_StockID,
	SM.StockID AS StockID,
	SM.ModelID AS ModelID,
	S.Qty AS Quantity
FROM 
	StockMaster AS SM 
		INNER JOIN Stock AS S ON S.M_StockID = SM.M_StockID 
