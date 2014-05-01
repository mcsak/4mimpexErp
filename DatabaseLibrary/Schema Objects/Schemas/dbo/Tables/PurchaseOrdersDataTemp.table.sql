CREATE TABLE [dbo].[PurchaseOrdersDataTemp] (
    [ID]         BIGINT IDENTITY (1, 1) NOT NULL,
    [ModelID]    BIGINT NULL,
    [OrderedQty] INT    DEFAULT ((0)) NULL,
    [Createdby]  BIGINT NULL
);

