CREATE TABLE [dbo].[Roles] (
    [ID]          INT           IDENTITY (1, 1) NOT NULL,
    [RoleID]      TINYINT       NOT NULL,
    [RoleName]    VARCHAR (50)  NULL,
    [Description] VARCHAR (500) NULL,
    [Active]      TINYINT       NULL,
    PRIMARY KEY CLUSTERED ([RoleID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF)
);

