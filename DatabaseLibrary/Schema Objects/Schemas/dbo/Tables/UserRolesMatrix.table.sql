CREATE TABLE [dbo].[UserRolesMatrix] (
    [ID]               BIGINT   IDENTITY (1, 1) NOT NULL,
    [UserID]           BIGINT   NULL,
    [RoleID]           BIGINT   NULL,
    [Active]           TINYINT  NULL,
    [CreateBy]         BIGINT   NULL,
    [CreatedDateTime]  DATETIME NULL,
    [Modifyby]         BIGINT   NULL,
    [ModifiedDateTime] DATETIME NULL,
    [DeleBy]           BIGINT   NULL,
    [DeletedDateTime]  DATETIME NULL,
    FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);

