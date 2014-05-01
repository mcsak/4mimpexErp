CREATE TABLE [dbo].[ProductsMaster] (
    [ID]               BIGINT        IDENTITY (1, 1) NOT NULL,
    [ProductID]        BIGINT        NOT NULL,
    [ProductName]      VARCHAR (100) NULL,
    [Description]      VARCHAR (500) NULL,
    [Active]           TINYINT       NULL,
    [CreateBy]         BIGINT        NULL,
    [CreatedDateTime]  DATETIME      NULL,
    [Modifyby]         BIGINT        NULL,
    [ModifiedDateTime] DATETIME      NULL,
    [DeleBy]           BIGINT        NULL,
    [DeletedDateTime]  DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([ProductID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF)
);

