
-- select dbo.getCurrrentStockForModelID(1)
CREATE function [dbo].[getCurrrentStockForModelID]( @ModelID bigint)
returns bigint
as
begin
Declare @Qty bigint=0
	set @Qty=(
		(select ISNULL(SUM(ISNULL(Qty,0)),0) from Stock where M_StockID=(select M_StockID from StockMaster where ModelID=@ModelID and Active=1))
		-
		(select ISNULL(SUM(ISNULL(Qty,0)),0) from IssuesChild where M_StockID=(select M_StockID from StockMaster where ModelID=@ModelID and Active=1))
		)
return @Qty
end
