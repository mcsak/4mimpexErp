CREATE TABLE [dbo].[BarcodefromStockTrans] (
    [BarcodeID]    BIGINT       IDENTITY (1, 1) NOT NULL,
    [Barcode]      VARCHAR (50) NULL,
    [M_StockID]    BIGINT       NULL,
    [Status]       TINYINT      DEFAULT ((0)) NULL,
    [Active]       TINYINT      DEFAULT ((1)) NULL,
    [ModifiedDate] DATETIME     NULL,
    [ModifiedBy]   INT          NULL,
    [createdDate]  DATETIME     DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([BarcodeID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF),
    FOREIGN KEY ([M_StockID]) REFERENCES [dbo].[StockMaster] ([M_StockID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);

