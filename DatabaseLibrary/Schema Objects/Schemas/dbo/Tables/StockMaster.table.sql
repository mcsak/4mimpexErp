CREATE TABLE [dbo].[StockMaster] (
    [ID]               BIGINT       IDENTITY (1, 1) NOT NULL,
    [M_StockID]        BIGINT       NOT NULL,
    [StockID]          VARCHAR (20) NULL,
    [ModelID]          BIGINT       NULL,
    [Active]           INT          NULL,
    [CreateBy]         BIGINT       NULL,
    [CreatedDateTime]  DATETIME     NULL,
    [Modifyby]         BIGINT       NULL,
    [ModifiedDateTime] DATETIME     NULL,
    [DeleBy]           BIGINT       NULL,
    [DeletedDateTime]  DATETIME     NULL,
    PRIMARY KEY CLUSTERED ([M_StockID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF),
    FOREIGN KEY ([ModelID]) REFERENCES [dbo].[ModelsMaster] ([ModelID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);

