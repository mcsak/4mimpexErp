CREATE TABLE [dbo].[PurchaseOrders] (
    [ID]               BIGINT        IDENTITY (1, 1) NOT NULL,
    [MasterPurchaseID] BIGINT        NOT NULL,
    [PurchaseID]       VARCHAR (25)  NULL,
    [Description]      VARCHAR (500) NULL,
    [SupplierDetails]  VARCHAR (200) NULL,
    [Remarks]          VARCHAR (500) NULL,
    [CreateBy]         BIGINT        NULL,
    [CreatedDateTime]  DATETIME      NULL,
    [Modifyby]         BIGINT        NULL,
    [ModifiedDateTime] DATETIME      NULL,
    [DeleBy]           BIGINT        NULL,
    [DeletedDateTime]  DATETIME      NULL,
    [Status]           TINYINT       NULL,
    PRIMARY KEY CLUSTERED ([MasterPurchaseID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF)
);

