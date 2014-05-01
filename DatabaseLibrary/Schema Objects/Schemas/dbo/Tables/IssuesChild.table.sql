CREATE TABLE [dbo].[IssuesChild] (
    [ID]         BIGINT          IDENTITY (1, 1) NOT NULL,
    [IssuesID]   BIGINT          NULL,
    [M_StockID]  BIGINT          NULL,
    [Qty]        INT             NULL,
    [CustomerID] BIGINT          NULL,
    [Active]     INT             NULL,
    [Amount]     NUMERIC (18, 2) NULL,
    [BarcodeID]  BIGINT          NULL,
    FOREIGN KEY ([BarcodeID]) REFERENCES [dbo].[BarcodefromStockTrans] ([BarcodeID]) ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY ([IssuesID]) REFERENCES [dbo].[Issues] ([IssuesIDMaster]) ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY ([M_StockID]) REFERENCES [dbo].[StockMaster] ([M_StockID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);

