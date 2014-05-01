CREATE TABLE [dbo].[CashTransactions] (
    [ID]               BIGINT          IDENTITY (1, 1) NOT NULL,
    [TxnID]            BIGINT          NOT NULL,
    [TransID]          VARCHAR (20)    NULL,
    [TxnType]          TINYINT         NULL,
    [Amount]           DECIMAL (18, 2) DEFAULT ((0)) NULL,
    [Discount]         DECIMAL (18, 2) DEFAULT ((0)) NULL,
    [ReferenceID]      BIGINT          NULL,
    [Remarks]          VARCHAR (500)   NULL,
    [Active]           INT             NULL,
    [CreateBy]         BIGINT          NULL,
    [CreatedDateTime]  DATETIME        NULL,
    [Modifyby]         BIGINT          NULL,
    [ModifiedDateTime] DATETIME        NULL,
    [DeleBy]           BIGINT          NULL,
    [DeletedDateTime]  DATETIME        NULL,
    PRIMARY KEY CLUSTERED ([TxnID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF)
);

