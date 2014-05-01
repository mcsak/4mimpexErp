--exec GetStockForModel 2
CREATE proc [dbo].[GetStockForModel]
@ModelID bigint
as
begin
	select (
	select ISNULL(SUM(ISNULL(s.Qty,0)),0) from Stock S
	inner join StockMaster SM on SM.M_StockID=s.M_StockID and s.Active=1 and SM.Active=1 and s.DeleBy is null and SM.DeleBy is null
	where SM.ModelID=@ModelID 
	)
	-
	(select ISNULL(SUM(ISNULL(I.Qty,0)),0) from IssuesChild I
	inner join StockMaster S on S.M_StockID=I.M_StockID and S.Active=1 and I.Active=1 and s.DeleBy is null --and i.DeleBy is null
	where s.ModelID=@ModelID
	) as Qty,
	ISNULL((select ISNULL(Price,0) from PriceDetails where ModelID=@ModelID and DeleBy is null),0) as Price
	

end


