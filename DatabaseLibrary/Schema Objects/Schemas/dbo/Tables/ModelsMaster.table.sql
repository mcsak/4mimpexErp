CREATE TABLE [dbo].[ModelsMaster] (
    [ID]               BIGINT        IDENTITY (1, 1) NOT NULL,
    [ModelID]          BIGINT        NOT NULL,
    [ModelName]        VARCHAR (100) NULL,
    [Description]      VARCHAR (500) NULL,
    [Active]           TINYINT       NULL,
    [ProductID]        BIGINT        NULL,
    [BrandID]          BIGINT        NULL,
    [CreateBy]         BIGINT        NULL,
    [CreatedDateTime]  DATETIME      NULL,
    [Modifyby]         BIGINT        NULL,
    [ModifiedDateTime] DATETIME      NULL,
    [DeleBy]           BIGINT        NULL,
    [DeletedDateTime]  DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([ModelID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF),
    FOREIGN KEY ([BrandID]) REFERENCES [dbo].[BrandsMaster] ([BrandID]) ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY ([ProductID]) REFERENCES [dbo].[ProductsMaster] ([ProductID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);

