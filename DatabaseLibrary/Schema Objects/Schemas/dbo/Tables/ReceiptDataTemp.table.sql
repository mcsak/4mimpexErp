CREATE TABLE [dbo].[ReceiptDataTemp] (
    [ID]         BIGINT       IDENTITY (1, 1) NOT NULL,
    [PurchaseID] BIGINT       NULL,
    [ModelID]    BIGINT       NULL,
    [SerialNo]   VARCHAR (50) NULL,
    [Qty]        INT          NULL
);

