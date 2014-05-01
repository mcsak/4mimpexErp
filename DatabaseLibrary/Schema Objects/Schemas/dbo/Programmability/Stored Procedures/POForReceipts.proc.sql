-- This details should be shown into the Receipts grid with Radio button. Then selct and go ahead for adding receipts
create proc [dbo].[POForReceipts]
as
begin
	select POM.PurchaseID,POM.Description AS DescToolTip,
	case when LEN(POM.Description)>10 then LEFT(POM.Description,7)+'...' else POM.Description end as DescriptionS,
	POM.SupplierDetails,
	POM.Remarks AS RemarksToolTip,
	case when LEN(POM.Remarks)>10 then LEFT(POM.Remarks,7)+'...' else POM.Remarks end as Remarks	
	from PurchaseOrder POM
	Where POM.Status=1 and DeleBy is null and Active=1
	
end


