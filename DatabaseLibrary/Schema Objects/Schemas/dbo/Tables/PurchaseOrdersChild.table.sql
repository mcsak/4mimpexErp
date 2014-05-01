CREATE TABLE [dbo].[PurchaseOrdersChild] (
    [ID]               BIGINT   IDENTITY (1, 1) NOT NULL,
    [PurchaseID]       BIGINT   NULL,
    [M_StockID]        BIGINT   NULL,
    [ModelID]          BIGINT   NULL,
    [Qty]              INT      NULL,
    [Status]           TINYINT  NULL,
    [RemainQty]        INT      NULL,
    [CreateBy]         BIGINT   NULL,
    [CreatedDateTime]  DATETIME NULL,
    [Modifyby]         BIGINT   NULL,
    [ModifiedDateTime] DATETIME NULL,
    [DeleBy]           BIGINT   NULL,
    [DeletedDateTime]  DATETIME NULL,
    FOREIGN KEY ([M_StockID]) REFERENCES [dbo].[StockMaster] ([M_StockID]) ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY ([ModelID]) REFERENCES [dbo].[ModelsMaster] ([ModelID]) ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY ([PurchaseID]) REFERENCES [dbo].[PurchaseOrders] ([MasterPurchaseID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);

