CREATE TABLE [dbo].[Stock] (
    [ID]               BIGINT        IDENTITY (1, 1) NOT NULL,
    [M_StockID]        BIGINT        NULL,
    [Qty]              INT           NULL,
    [ReceiptID]        BIGINT        NULL,
    [ReciptType]       TINYINT       NULL,
    [Active]           INT           NULL,
    [SerialNo]         VARCHAR (50)  NULL,
    [Remarks]          VARCHAR (500) NULL,
    [CreateBy]         BIGINT        NULL,
    [CreatedDateTime]  DATETIME      NULL,
    [Modifyby]         BIGINT        NULL,
    [ModifiedDateTime] DATETIME      NULL,
    [DeleBy]           BIGINT        NULL,
    [DeletedDateTime]  DATETIME      NULL,
    FOREIGN KEY ([M_StockID]) REFERENCES [dbo].[StockMaster] ([M_StockID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);

