ALTER DATABASE [$(DatabaseName)]
    ADD FILE (NAME = [FourMImpex], FILENAME = '$(DefaultDataPath)$(DatabaseName).mdf', FILEGROWTH = 1024 KB) TO FILEGROUP [PRIMARY];

