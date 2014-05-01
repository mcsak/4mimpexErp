CREATE TABLE [dbo].[PriceDetails] (
    [ID]               BIGINT          IDENTITY (1, 1) NOT NULL,
    [PriceID]          BIGINT          NOT NULL,
    [Price]            NUMERIC (18, 2) DEFAULT ((0)) NULL,
    [Description]      VARCHAR (500)   NULL,
    [ModelID]          BIGINT          NULL,
    [Active]           TINYINT         NULL,
    [CreateBy]         BIGINT          NULL,
    [CreatedDateTime]  DATETIME        NULL,
    [Modifyby]         BIGINT          NULL,
    [ModifiedDateTime] DATETIME        NULL,
    [DeleBy]           BIGINT          NULL,
    [DeletedDateTime]  DATETIME        NULL,
    [Discount]         TINYINT         DEFAULT ((0)) NULL,
    PRIMARY KEY CLUSTERED ([PriceID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF),
    FOREIGN KEY ([ModelID]) REFERENCES [dbo].[ModelsMaster] ([ModelID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);

