
-- exec LoadOpenStockData 0,'Dv4'
CREATE proc [dbo].[LoadOpenStockData]
@FilterType tinyint,
@FilterText varchar(100)
as
begin
	
	Select ProductName + BrandName as Products,ModelName,SerialNo,qty,
	case when len(Remarks)>10 then LEFT(Remarks,10) else Remarks end as RemarksLabel, 
	Remarks,
	Case when Action=1 then 'Imported' when Action=2 then 'No master stock' when Action=3 then 'Imported'  else 'NA' end as Status
	from OpenStockData where Action<>3
	and case when @FilterType=0 then 1 
			when @FilterType=1 then case when ProductName like '%'+@FilterText+'%' then 1 end 
			when @FilterType=2 then case when BrandName like '%'+@FilterText+'%' then 1 end  
			when @FilterType=3 then case when ModelName like '%'+@FilterText+'%' then 1 end  
			when @FilterType=4 then case when SerialNo like '%'+@FilterText+'%' then 1 end  
			else 1 end=1
end
