

-- exec LoadPurchaseOrdersDataForReceipts 0,''

CREATE proc [dbo].[LoadPurchaseOrdersDataForReceipts]

@FilterType tinyint,

@FilterText varchar(100)

as

begin

	

	select PO.MasterPurchaseID,PO.PurchaseID,

	case when LEN(PO.Remarks)>15 then LEFT(PO.Remarks,13)+'...' else PO.Remarks end as Remarks,

	PO.Remarks as RemarksTip,

	PO.CreatedDateTime as PurchaseOrderDate,

	case when PO.Status=1 then 'Not received' when PO.Status=3 then 'Partially received' else 'UnPredicted' end as POStatus,

	(select sum(ISNULL(Qty,0)) from PurchaseOrdersChild where PurchaseID=PO.MasterPurchaseID and DeleBy is null) as Qty,

	(select sum(ISNULL(RemainQty,0)) from PurchaseOrdersChild where PurchaseID=PO.MasterPurchaseID and DeleBy is null) as RemainQty

	from PurchaseOrders PO	

	where PO.Status in (1,3) and PO.DeleBy is null

	and case when @FilterType=0 then 1 

					when @FilterType=1 then case when PO.PurchaseID like '%'+@FilterText+'%' then 1 end

					--when @FilterType=2 then case when POStatus like '%'+@FilterText+'%' then 1 end

					when @FilterType=3 then case when dbo.DateToInteger(PO.CreatedDateTime) like '%'+ dbo.DateToInteger(@FilterText)+'%' then 1 end

					else 0 end=1

end



