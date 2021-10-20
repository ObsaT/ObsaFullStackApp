IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20210923105324_initial')
BEGIN
    CREATE TABLE [companies] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NULL,
        [Address] nvarchar(max) NULL,
        [PhoneNumber] int NOT NULL,
        CONSTRAINT [PK_companies] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20210923105324_initial')
BEGIN
    CREATE TABLE [missions] (
        [Id] int NOT NULL IDENTITY,
        [MissionName] nvarchar(max) NULL,
        [Date] datetime2 NOT NULL,
        [CompanyId] int NULL,
        [VehicleId] int NOT NULL,
        [Radius] int NOT NULL,
        [StartTime] datetime2 NOT NULL,
        [EndTime] datetime2 NOT NULL,
        [CenterLatitude] float NOT NULL,
        [CenterLongitude] float NOT NULL,
        CONSTRAINT [PK_missions] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20210923105324_initial')
BEGIN
    CREATE TABLE [users] (
        [Userid] int NOT NULL IDENTITY,
        [userName] nvarchar(max) NULL,
        [passwordHash] varbinary(max) NULL,
        [passwordSalt] varbinary(max) NULL,
        [Gender] nvarchar(max) NULL,
        [Age] int NOT NULL,
        [DateOfBirth] datetime2 NOT NULL,
        [KnownAs] nvarchar(max) NULL,
        [Created] datetime2 NOT NULL,
        [LastActive] datetime2 NOT NULL,
        [Introduction] nvarchar(max) NULL,
        [LookingFor] nvarchar(max) NULL,
        [Interests] nvarchar(max) NULL,
        [City] nvarchar(max) NULL,
        [Country] nvarchar(max) NULL,
        [PhotoUrl] nvarchar(max) NULL,
        CONSTRAINT [PK_users] PRIMARY KEY ([Userid])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20210923105324_initial')
BEGIN
    CREATE TABLE [wayPoints] (
        [Id] int NOT NULL IDENTITY,
        [MissionId] int NOT NULL,
        [Latitude] float NOT NULL,
        [Altitude] float NOT NULL,
        [Longitude] float NOT NULL,
        CONSTRAINT [PK_wayPoints] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_wayPoints_missions_MissionId] FOREIGN KEY ([MissionId]) REFERENCES [missions] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20210923105324_initial')
BEGIN
    CREATE TABLE [photos] (
        [Id] int NOT NULL IDENTITY,
        [Url] nvarchar(max) NULL,
        [Idesciption] nvarchar(max) NULL,
        [DateAdded] datetime2 NOT NULL,
        [PublicId] nvarchar(max) NULL,
        [Ismain] bit NOT NULL,
        [UserId] int NOT NULL,
        CONSTRAINT [PK_photos] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_photos_users_UserId] FOREIGN KEY ([UserId]) REFERENCES [users] ([Userid]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20210923105324_initial')
BEGIN
    CREATE INDEX [IX_photos_UserId] ON [photos] ([UserId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20210923105324_initial')
BEGIN
    CREATE INDEX [IX_wayPoints_MissionId] ON [wayPoints] ([MissionId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20210923105324_initial')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20210923105324_initial', N'5.0.7');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20210929071804_LIKEADDED')
BEGIN
    CREATE TABLE [Likes] (
        [LikerId] int NOT NULL,
        [LikeeId] int NOT NULL,
        CONSTRAINT [PK_Likes] PRIMARY KEY ([LikerId], [LikeeId]),
        CONSTRAINT [FK_Likes_users_LikeeId] FOREIGN KEY ([LikeeId]) REFERENCES [users] ([Userid]) ON DELETE NO ACTION,
        CONSTRAINT [FK_Likes_users_LikerId] FOREIGN KEY ([LikerId]) REFERENCES [users] ([Userid]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20210929071804_LIKEADDED')
BEGIN
    CREATE INDEX [IX_Likes_LikeeId] ON [Likes] ([LikeeId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20210929071804_LIKEADDED')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20210929071804_LIKEADDED', N'5.0.7');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211001061921_message-ntity-added')
BEGIN
    CREATE TABLE [Messages] (
        [Id] int NOT NULL IDENTITY,
        [SenderId] int NOT NULL,
        [RecipientId] int NOT NULL,
        [Content] nvarchar(max) NULL,
        [IsreaRead] bit NOT NULL,
        [DateRead] datetime2 NULL,
        [MessageSent] datetime2 NULL,
        [SenderDeleted] bit NOT NULL,
        [RecipientDeleted] bit NOT NULL,
        CONSTRAINT [PK_Messages] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Messages_users_RecipientId] FOREIGN KEY ([RecipientId]) REFERENCES [users] ([Userid]) ON DELETE NO ACTION,
        CONSTRAINT [FK_Messages_users_SenderId] FOREIGN KEY ([SenderId]) REFERENCES [users] ([Userid]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211001061921_message-ntity-added')
BEGIN
    CREATE INDEX [IX_Messages_RecipientId] ON [Messages] ([RecipientId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211001061921_message-ntity-added')
BEGIN
    CREATE INDEX [IX_Messages_SenderId] ON [Messages] ([SenderId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20211001061921_message-ntity-added')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20211001061921_message-ntity-added', N'5.0.7');
END;
GO

COMMIT;
GO

