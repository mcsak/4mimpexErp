CREATE TABLE [dbo].[Customer] (
    [ID]            BIGINT        IDENTITY (1, 1) NOT NULL,
    [CustomerID]    BIGINT        NULL,
    [CustomerName]  VARCHAR (200) NULL,
    [ContactNumber] VARCHAR (200) NULL,
    [EmailID]       VARCHAR (200) NULL,
    [Others]        VARCHAR (500) NULL,
    [Active]        TINYINT       DEFAULT ((1)) NULL,
    [IssueID]       BIGINT        NULL
);

