CREATE TABLE [dbo].[IssueToCustomerTemp] (
    [ID]      BIGINT          IDENTITY (1, 1) NOT NULL,
    [ModelID] BIGINT          NULL,
    [Qty]     INT             NULL,
    [UserID]  BIGINT          NULL,
    [Amount]  NUMERIC (18, 2) NULL
);

