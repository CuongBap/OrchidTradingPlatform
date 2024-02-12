CREATE DATABASE [OrchidTradingManagement]
GO
USE [OrchidTradingManagement]
GO


CREATE TABLE [dbo].[Orchid](
	[OrchidId] [uniqueidentifier] DEFAULT NEWID() PRIMARY KEY NOT NULL,
	[OrchidName] [nvarchar](100) NOT NULL,
	[Characteristic] [nvarchar](100) NOT NULL,
	[UnitPrice] Money NOT NULL,
	[Quantity] [int] NOT NULL,
	[Status] [nvarchar](50) NOT NULL
	)
GO

CREATE TABLE [dbo].[UserRole](
	[RoleId] [uniqueidentifier] DEFAULT NEWID() PRIMARY KEY NOT NULL,
	[RoleName] [nvarchar](100) NOT NULL,

)
GO

CREATE TABLE [dbo].[User](
	[UserId] [uniqueidentifier] DEFAULT NEWID() PRIMARY KEY NOT NULL,
	[Username] [nvarchar](100) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
	[WalletBalance] [money] NULL,
	[Phonenumber] [varchar](50) NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,

	FOREIGN KEY (RoleId) REFERENCES [dbo].[UserRole](RoleId)
 )
GO

CREATE TABLE [dbo].[Auction](
	[AuctionId] [uniqueidentifier] DEFAULT NEWID() PRIMARY KEY NOT NULL,
	[AuctionName] [nvarchar](100) NOT NULL,
	[Deposit] [money] NULL,
	[startingBid] [Money] NOT NULL,
	[OpenDate] [datetime] NOT NULL,
	[CloseDate] [datetime] NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
 )
GO

CREATE TABLE [dbo].[ListInformation](
	[InforId] [uniqueidentifier] DEFAULT NEWID() PRIMARY KEY NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](100) NOT NULL,
	[Image] [nvarchar](max) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[OrchidId] [uniqueidentifier] NULL,
	[AuctionId] [uniqueidentifier] NULL,
	[UserId] [uniqueidentifier] NULL,

	FOREIGN KEY (OrchidId) REFERENCES [dbo].[Orchid](OrchidId),
	FOREIGN KEY (AuctionId) REFERENCES [dbo].[Auction](AuctionId),
	FOREIGN KEY (UserId) REFERENCES [dbo].[User](UserId)	
)
GO

CREATE TABLE [dbo].[Comment](
	[CommentId] [uniqueidentifier] DEFAULT NEWID() PRIMARY KEY NOT NULL,
	[CommentMessage] [nvarchar](100) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UserId] [uniqueidentifier] NULL,
	[InforId] [uniqueidentifier] NULL,

	FOREIGN KEY (UserId) REFERENCES [dbo].[User](UserId),
	FOREIGN KEY (InforId) REFERENCES [dbo].[ListInformation](InforId)

)
GO


CREATE TABLE [dbo].[Order](
	[OrderId] [uniqueidentifier] DEFAULT NEWID() PRIMARY KEY NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[Total] [money] NOT NULL,
	[BuyerId] [uniqueidentifier] NULL,
	[SellerId] [uniqueidentifier] NULL,
	[AuctionId] [uniqueidentifier] NULL,

	FOREIGN KEY (BuyerId) REFERENCES [dbo].[User](UserId),
	FOREIGN KEY (SellerId) REFERENCES [dbo].[User](UserId),
	FOREIGN KEY (AuctionId) REFERENCES [dbo].[Auction](AuctionId)
)
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderDetailId] [uniqueidentifier] DEFAULT NEWID() PRIMARY KEY NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[Quantity] [int] NOT NULL,
	[OrchidId] [uniqueidentifier] NULL,
	[OrderId] [uniqueidentifier] NULL,

	FOREIGN KEY (OrchidId) REFERENCES [dbo].[Orchid](OrchidId),
	FOREIGN KEY (OrderId) REFERENCES [dbo].[Order](OrderId)
)
GO

CREATE TABLE [dbo].[RegisterAuction](
	[RegisterId] [uniqueidentifier] DEFAULT NEWID() PRIMARY KEY NOT NULL,
	[price] [money] NULL,
	[UserId] [uniqueidentifier] NULL,
	FOREIGN KEY (UserId) REFERENCES [dbo].[User](UserId),
 )
GO


CREATE TABLE [dbo].[Biddings](
	[BidId] [uniqueidentifier] DEFAULT NEWID() PRIMARY KEY NOT NULL,
	[TotalBid] [money] NULL,
	[AuctionId] [uniqueidentifier] NULL,
	[RegisterId] [uniqueidentifier] NULL,

	FOREIGN KEY (AuctionId) REFERENCES [dbo].[Auction](AuctionId),
	FOREIGN KEY (RegisterId) REFERENCES [dbo].[RegisterAuction](RegisterId)

 )
GO


CREATE TABLE [dbo].[Transaction](
	[TransactionId] [uniqueidentifier] DEFAULT NEWID() PRIMARY KEY NOT NULL,
	[OrderId] [uniqueidentifier] NOT NULL,
	FOREIGN KEY (OrderId) REFERENCES [dbo].[Order](OrderId)

)
GO


