CREATE TABLE [dbo].[Receipts] (
    [ID]               BIGINT        IDENTITY (1, 1) NOT NULL,
    [ReceiptIDMaster]  BIGINT        NOT NULL,
    [ReceiptID]        VARCHAR (20)  NULL,
    [PurchaseID]       BIGINT        NULL,
    [Type]             TINYINT       NULL,
    [Remarks]          VARCHAR (500) NULL,
    [CreateBy]         BIGINT        NULL,
    [CreatedDateTime]  DATETIME      NULL,
    [Modifyby]         BIGINT        NULL,
    [ModifiedDateTime] DATETIME      NULL,
    [DeleBy]           BIGINT        NULL,
    [DeletedDateTime]  DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([ReceiptIDMaster] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF)
);

