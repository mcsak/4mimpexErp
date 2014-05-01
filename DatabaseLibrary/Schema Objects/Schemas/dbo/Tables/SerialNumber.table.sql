CREATE TABLE [dbo].[SerialNumber] (
    [ID]               BIGINT        IDENTITY (1, 1) NOT NULL,
    [SerialID]         BIGINT        NULL,
    [SerialNo]         VARCHAR (100) NULL,
    [ModelID]          BIGINT        NULL,
    [BrandID]          BIGINT        NULL,
    [Active]           INT           NULL,
    [CreateBy]         BIGINT        NULL,
    [CreatedDateTime]  DATETIME      NULL,
    [Modifyby]         BIGINT        NULL,
    [ModifiedDateTime] DATETIME      NULL,
    [DeleBy]           BIGINT        NULL,
    [DeletedDateTime]  DATETIME      NULL
);

