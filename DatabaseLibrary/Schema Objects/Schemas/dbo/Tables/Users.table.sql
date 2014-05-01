CREATE TABLE [dbo].[Users] (
    [ID]               BIGINT         IDENTITY (1, 1) NOT NULL,
    [UserID]           BIGINT         NOT NULL,
    [FirstName]        VARCHAR (25)   NULL,
    [LastName]         VARCHAR (25)   NULL,
    [DOB]              DATE           NULL,
    [LoginSession]     DATETIME       NULL,
    [Password]         VARCHAR (100)  NULL,
    [Active]           TINYINT        NULL,
    [CreateBy]         BIGINT         NULL,
    [CreatedDateTime]  DATETIME       NULL,
    [Modifyby]         BIGINT         NULL,
    [ModifiedDateTime] DATETIME       NULL,
    [DeleBy]           BIGINT         NULL,
    [DeletedDateTime]  DATETIME       NULL,
    [OriginalName]     VARCHAR (200)  NULL,
    [ImagePath]        VARCHAR (1000) NULL,
    [EmailID]          VARCHAR (100)  NULL,
    PRIMARY KEY CLUSTERED ([UserID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF)
);

