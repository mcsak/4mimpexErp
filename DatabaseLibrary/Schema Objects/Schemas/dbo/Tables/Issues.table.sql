CREATE TABLE [dbo].[Issues] (
    [ID]               BIGINT          IDENTITY (1, 1) NOT NULL,
    [IssuesIDMaster]   BIGINT          NOT NULL,
    [IssuesID]         VARCHAR (20)    NULL,
    [Remarks]          VARCHAR (500)   NULL,
    [DespatchStatus]   TINYINT         NULL,
    [PaymentStatus]    TINYINT         NULL,
    [BillPrintStatus]  TINYINT         NULL,
    [CreateBy]         BIGINT          NULL,
    [CreatedDateTime]  DATETIME        NULL,
    [Modifyby]         BIGINT          NULL,
    [ModifiedDateTime] DATETIME        NULL,
    [DeleBy]           BIGINT          NULL,
    [DeletedDateTime]  DATETIME        NULL,
    [Amount]           NUMERIC (18, 2) NULL,
    [CustomerID]       BIGINT          DEFAULT ((0)) NULL,
    PRIMARY KEY CLUSTERED ([IssuesIDMaster] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF)
);

