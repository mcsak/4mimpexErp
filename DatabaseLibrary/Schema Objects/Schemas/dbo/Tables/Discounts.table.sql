CREATE TABLE [dbo].[Discounts] (
    [ID]               BIGINT          IDENTITY (1, 1) NOT NULL,
    [DiscountID]       BIGINT          NOT NULL,
    [DiscountPrice]    NUMERIC (18, 2) DEFAULT ((0)) NULL,
    [Description]      VARCHAR (500)   NULL,
    [DiscountType]     INT             DEFAULT ((0)) NULL,
    [Active]           INT             NULL,
    [CreateBy]         BIGINT          NULL,
    [CreatedDateTime]  DATETIME        NULL,
    [Modifyby]         BIGINT          NULL,
    [ModifiedDateTime] DATETIME        NULL,
    [DeleBy]           BIGINT          NULL,
    [DeletedDateTime]  DATETIME        NULL,
    PRIMARY KEY CLUSTERED ([DiscountID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF)
);

