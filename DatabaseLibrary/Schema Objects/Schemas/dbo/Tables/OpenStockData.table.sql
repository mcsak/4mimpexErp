CREATE TABLE [dbo].[OpenStockData] (
    [ID]          BIGINT        IDENTITY (1, 1) NOT NULL,
    [M_StockID]   BIGINT        NULL,
    [ProductID]   BIGINT        NULL,
    [ProductName] VARCHAR (100) NULL,
    [BrandID]     BIGINT        NULL,
    [BrandName]   VARCHAR (100) NULL,
    [ModelID]     BIGINT        NULL,
    [ModelName]   VARCHAR (100) NULL,
    [SerialNo]    VARCHAR (150) NULL,
    [Remarks]     VARCHAR (500) NULL,
    [qty]         INT           NULL,
    [Action]      TINYINT       DEFAULT ((0)) NULL
);

