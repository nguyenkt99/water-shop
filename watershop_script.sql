USE [master]
GO
/****** Object:  Database [WATERSHOP]    Script Date: 1/5/2021 11:37:00 PM ******/
CREATE DATABASE [WATERSHOP]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WATERSHOP', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\WATERSHOP.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'WATERSHOP_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\WATERSHOP_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [WATERSHOP] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WATERSHOP].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WATERSHOP] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WATERSHOP] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WATERSHOP] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WATERSHOP] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WATERSHOP] SET ARITHABORT OFF 
GO
ALTER DATABASE [WATERSHOP] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WATERSHOP] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WATERSHOP] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WATERSHOP] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WATERSHOP] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WATERSHOP] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WATERSHOP] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WATERSHOP] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WATERSHOP] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WATERSHOP] SET  DISABLE_BROKER 
GO
ALTER DATABASE [WATERSHOP] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WATERSHOP] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WATERSHOP] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WATERSHOP] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WATERSHOP] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WATERSHOP] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WATERSHOP] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WATERSHOP] SET RECOVERY FULL 
GO
ALTER DATABASE [WATERSHOP] SET  MULTI_USER 
GO
ALTER DATABASE [WATERSHOP] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WATERSHOP] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WATERSHOP] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WATERSHOP] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [WATERSHOP] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'WATERSHOP', N'ON'
GO
USE [WATERSHOP]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 1/5/2021 11:37:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Id] [nvarchar](20) NOT NULL,
	[Password] [nvarchar](50) NULL,
	[Fullname] [nvarchar](50) NULL,
	[Address] [nvarchar](60) NULL,
	[Phonenumber] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[Photo] [nvarchar](50) NULL,
	[Activated] [bit] NULL,
	[Admin] [bit] NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 1/5/2021 11:37:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NULL,
	[ProductId] [int] NULL,
	[UnitPrice] [int] NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orders]    Script Date: 1/5/2021 11:37:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [nvarchar](20) NULL,
	[OrderDate] [datetime] NULL,
	[Amount] [int] NULL,
	[Description] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Products]    Script Date: 1/5/2021 11:37:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](60) NULL,
	[UnitPrice] [int] NULL,
	[Image] [nvarchar](50) NULL,
	[Available] [bit] NULL,
	[Specification] [nvarchar](50) NULL,
	[Quantity] [int] NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
INSERT [dbo].[Customers] ([Id], [Password], [Fullname], [Address], [Phonenumber], [Email], [Photo], [Activated], [Admin]) VALUES (N'admin', N'admin', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Customers] ([Id], [Password], [Fullname], [Address], [Phonenumber], [Email], [Photo], [Activated], [Admin]) VALUES (N'admin2', N'admin', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Customers] ([Id], [Password], [Fullname], [Address], [Phonenumber], [Email], [Photo], [Activated], [Admin]) VALUES (N'nguyenkt', N'123', N'Kiều Trung Nguyên', N'97 Man Thiện, Quận 9', N'0827115117', N'nguyenkt389@gmail.com', NULL, 1, 0)
INSERT [dbo].[Customers] ([Id], [Password], [Fullname], [Address], [Phonenumber], [Email], [Photo], [Activated], [Admin]) VALUES (N'quandev112', N'123', N'Trần Thị Bích Ngọc', N'Quảng Ngãi', N'0988888888', N'quandev112@gmail.com', NULL, 1, 0)
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 

INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [UnitPrice], [Quantity]) VALUES (84, 46, 33, 200000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [UnitPrice], [Quantity]) VALUES (85, 46, 34, 84000, 3)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [UnitPrice], [Quantity]) VALUES (86, 46, 3, 160000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [UnitPrice], [Quantity]) VALUES (87, 47, 13, 150000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [UnitPrice], [Quantity]) VALUES (88, 47, 3, 160000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [UnitPrice], [Quantity]) VALUES (89, 47, 12, 150000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [UnitPrice], [Quantity]) VALUES (90, 48, 14, 11000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [UnitPrice], [Quantity]) VALUES (91, 48, 30, 108000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [UnitPrice], [Quantity]) VALUES (92, 48, 12, 150000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [UnitPrice], [Quantity]) VALUES (93, 48, 2, 50000, 3)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [UnitPrice], [Quantity]) VALUES (94, 49, 34, 84000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [UnitPrice], [Quantity]) VALUES (95, 49, 3, 160000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [UnitPrice], [Quantity]) VALUES (96, 49, 4, 48000, 1)
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderDate], [Amount], [Description]) VALUES (46, N'nguyenkt', CAST(N'2021-01-05 00:00:00.000' AS DateTime), 812000, NULL)
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderDate], [Amount], [Description]) VALUES (47, N'nguyenkt', CAST(N'2021-01-05 00:00:00.000' AS DateTime), 610000, NULL)
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderDate], [Amount], [Description]) VALUES (48, N'quandev112', CAST(N'2021-01-05 00:00:00.000' AS DateTime), 419000, NULL)
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderDate], [Amount], [Description]) VALUES (49, N'quandev112', CAST(N'2021-01-05 00:00:00.000' AS DateTime), 292000, NULL)
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Name], [UnitPrice], [Image], [Available], [Specification], [Quantity], [Description]) VALUES (2, N'LA VIE 6L', 50000, N'resources/images/products/lavie-6l.jpg', 1, N'2 chai/ thùng', 1000, N'Mỗi chai nước khoáng thiên nhiên La Vie đều được đóng chai tại nguồn & phải trải qua quá trình quản lý chất lượng bao gồm 12 bước nghiêm ngặt theo tiêu chuẩn của tập đoàn Nestle, chúng tôi đảm bảo các quy định vệ sinh và giữ được chất lượng & thành phần khoáng cơ bản của nước. Đó lý do La Vie trở thành thương hiệu nước khoáng thiên nhiên số 1 tại Việt Nam*')
INSERT [dbo].[Products] ([Id], [Name], [UnitPrice], [Image], [Available], [Specification], [Quantity], [Description]) VALUES (3, N'LA VIE SPARKLING MIX VỊ', 160000, N'resources/images/products/Mix-vi-upload.png', 1, N'24 lon/thùng', 97, N'Nước uống vị trái cây có ga La Vie với hương vị tuyệt vời hoàn toàn từ thiên nhiên, đặc biệt sản phẩm chứa ít đường và calo hòa cùng bọt ga sảng khoái, mang đến cho bạn vị ngọt nhẹ tự nhiên và tốt cho sức khỏe, là sự lựa chọn hoàn hảo cho bạn để giải khát và kết hợp cùng các bữa ăn để trở nên ngon hơn.')
INSERT [dbo].[Products] ([Id], [Name], [UnitPrice], [Image], [Available], [Specification], [Quantity], [Description]) VALUES (4, N'NƯỚC UỐNG ĐÓNG BÌNH LA VIE VIVA 18.5L', 48000, N'resources/images/products/viva-18-5l-mien-nam.jpg', 1, N'bình', 99, N'Mỗi bình nước Viva 18.5L đều phải trải qua quá trình quản lý chất lượng bao gồm 12 bước nghiêm ngặt theo tiêu chuẩn của tập đoàn Nestle, đảm bảo các quy định vệ sinh và chất lượng của nước uống.NULL')
INSERT [dbo].[Products] ([Id], [Name], [UnitPrice], [Image], [Available], [Specification], [Quantity], [Description]) VALUES (5, N'LA VIE SPARKLING CHANH BẠC HÀ', 160000, N'resources/images/products/Lemon-Mint-2.jpg', 0, N'24 lon/thùng', 100, N'Nước uống vị trái cây có ga La Vie với hương vị tuyệt vời hoàn toàn từ thiên nhiên, đặc biệt sản phẩm chứa ít đường và calo hòa cùng bọt ga sảng khoái, mang đến cho bạn vị ngọt nhẹ tự nhiên và tốt cho sức khỏe, là sự lựa chọn hoàn hảo cho bạn để giải khát và kết hợp cùng các bữa ăn để trở nên ngon hơn.

Sản phẩm có các loại hương vị sảng khoái: Chanh Bạc Hà, Đào Cam, Dâu Việt Quất hòa cùng bọt ga sảng khoái với vị ngọt nhẹ tự nhiên chiết xuất từ đường mía & cỏ ngọt Stevia.')
INSERT [dbo].[Products] ([Id], [Name], [UnitPrice], [Image], [Available], [Specification], [Quantity], [Description]) VALUES (12, N'LA VIE SPARKLING DÂU VIỆT QUẤT', 150000, N'resources/images/products/Mix-berries-2.jpg', 1, N'24 lon/Thùng', 98, N'Nước uống vị trái cây có ga La Vie với hương vị tuyệt vời hoàn toàn từ thiên nhiên, đặc biệt sản phẩm chứa ít đường và calo hòa cùng bọt ga sảng khoái, mang đến cho bạn vị ngọt nhẹ tự nhiên và tốt cho sức khỏe, là sự lựa chọn hoàn hảo cho bạn để giải khát và kết hợp cùng các bữa ăn để trở nên ngon hơn.

Sản phẩm có các loại hương vị sảng khoái: Chanh Bạc Hà, Đào Cam, Dâu Việt Quất hòa cùng bọt ga sảng khoái với vị ngọt nhẹ tự nhiên chiết xuất từ đường mía & cỏ ngọt Stevia.')
INSERT [dbo].[Products] ([Id], [Name], [UnitPrice], [Image], [Available], [Specification], [Quantity], [Description]) VALUES (13, N'LA VIE SPARKLING ĐÀO CAM', 150000, N'resources/images/products/Peach-orange-2.jpg', 1, N'24 lon/Thùng', 98, N'Nước uống vị trái cây có ga La Vie với hương vị tuyệt vời hoàn toàn từ thiên nhiên, đặc biệt sản phẩm chứa ít đường và calo hòa cùng bọt ga sảng khoái, mang đến cho bạn vị ngọt nhẹ tự nhiên và tốt cho sức khỏe, là sự lựa chọn hoàn hảo cho bạn để giải khát và kết hợp cùng các bữa ăn để trở nên ngon hơn.

Sản phẩm có các loại hương vị sảng khoái: Chanh Bạc Hà, Đào Cam, Dâu Việt Quất hòa cùng bọt ga sảng khoái với vị ngọt nhẹ tự nhiên chiết xuất từ đường mía & cỏ ngọt Stevia.

Điểm Mạnh Sản Phẩm:
- 100% Tự Nhiên: Các loại hương trái cây đều được chiết xuất 100% từ thiên nhiên.
- Ít đường: Mỗi lon sản phẩm chỉ chứa 12g đường trong khi các loại nước ngọt thông thường chứa đến 33g đường. Lưu ý, theo Hiệp Hội Tim Mạch Hoa Kỳ, người trưởng thành trung bình chỉ nên tiêu thụ 37.5g đường đối với nam & 25g đối với nữ.
- Ít Calo: Mỗi lon sản phẩm chỉ chứa 54 kcal, chiếm 2% năng lượng cần thiết mỗi ngày.
- Không chất bảo quản: Sản phẩm hoàn toàn không dùng chất bảo quản
Không chất tạo ngọt nhân tạo: Không như các loại nước ngọt thông thường, sản phẩm chỉ sử dụng các chiết xuất từ thiên nhiên (cây mía & cỏ stevia) để tạo ra vị ngọt tự nhiên')
INSERT [dbo].[Products] ([Id], [Name], [UnitPrice], [Image], [Available], [Specification], [Quantity], [Description]) VALUES (14, N'LA VIE 1.5L', 11000, N'resources/images/products/lavie-1500ml.jpg', 1, N'12 chai/thùng', 99, N'Nước khoáng thiên nhiên La Vie 1.5L là sản phẩm có dung tích phù hợp để bù nước bù khoáng cho cơ thể suốt ngày dài di chuyển hoặc hoạt động ngoài trời. Ngoài ra, bạn cũng có thể trữ La Vie 1.5L trong ngăn mát tủ lạnh để luôn sẵn sàng giải khát khi ở nhà.

Không đường & không calo, nước khoáng thiên nhiên La Vie với 6 khoáng chất thiết yếu là sự lựa chọn hoàn hảo để thay thế các loại nước giải khát chứa nhiều đường, giúp bạn và gia đình duy trì cuộc sống khỏe mạnh.

Mỗi chai nước khoáng thiên nhiên La Vie đều được đóng chai tại nguồn & phải trải qua quá trình quản lý chất lượng bao gồm 12 bước nghiêm ngặt theo tiêu chuẩn của tập đoàn Nestle, chúng tôi đảm bảo các quy định vệ sinh và giữ được chất lượng & thành phần khoáng cơ bản của nước. Đó lý do La Vie trở thành thương hiệu nước khoáng số 1 tại Việt Nam*
*Theo AC Nielsen về sản lượng năm 2019')
INSERT [dbo].[Products] ([Id], [Name], [UnitPrice], [Image], [Available], [Specification], [Quantity], [Description]) VALUES (30, N'LA VIE PRESTIGE 700ML', 108000, N'resources/images/products/La-Vie-Prestige.jpg', 1, N'12 chai/ thùng', 99, N'Với thiết kế hiện đại và độc đáo, nước khoáng thiên nhiên La Vie Prestige 700ml là sản phẩm lý tưởng để giải khát, giúp bù nước bù khoáng suốt ngày dài và thích hợp với mọi phong cách sống năng động.

Không đường & không calo, nước khoáng thiên nhiên La Vie với 6 khoáng chất thiết yếu là sự lựa chọn hoàn hảo để thay thế các loại nước giải khát chứa nhiều đường, giúp bạn duy trì cuộc sống khỏe mạnh.

Mỗi chai nước khoáng thiên nhiên La Vie đều được đóng chai tại nguồn & phải trải qua quá trình quản lý chất lượng bao gồm 12 bước nghiêm ngặt theo tiêu chuẩn của tập đoàn Nestle, đảm bảo các quy định vệ sinh và giữ được chất lượng & thành phần khoáng cơ bản của nước.
Đó lý do La Vie trở thành thương hiệu nước khoáng số 1 tại Việt Nam*
*Theo AC Nielsen về sản lượng năm 2021')
INSERT [dbo].[Products] ([Id], [Name], [UnitPrice], [Image], [Available], [Specification], [Quantity], [Description]) VALUES (33, N'LA VIE PREMIUM 400ML', 200000, N'resources/images/products/lavie-400ml.jpg', 1, N'20 chai/thùng', 98, N'Với thiết kế thanh lịch & cao cấp, nước khoáng thiên nhiên La Vie Premium 400ml là sự lựa chọn hoàn hảo để phối với các món ngon, cho dù bạn đang dùng bữa tại nhà hay tại nhà hàng, quán bar hay khách sạn. Vị khoáng thanh khiết dịu nhẹ, La Vie tôn thêm hương vị món ăn, mang đến cho bạn một trải nghiệm ẩm thực hài hòa và tinh tế.

Không đường & không calo, nước khoáng thiên nhiên La Vie với 6 khoáng chất thiết yếu là sự lựa chọn tuyệt vời để thay thế các loại nước giải khát chứa nhiều đường, giúp bạn duy trì cuộc sống khỏe mạnh.')
INSERT [dbo].[Products] ([Id], [Name], [UnitPrice], [Image], [Available], [Specification], [Quantity], [Description]) VALUES (34, N'LA VIE 350ML', 84000, N'resources/images/products/350ml-blue-2.png', 1, N'24 chai/thùng', 96, N'Nước khoáng thiên nhiên La Vie 350ml với dung tích & thiết kế nhỏ gọn là sản phẩm hoàn hảo để sử dụng tại văn phòng, các sự kiện của công ty hoặc tiếp khách tại nhà. Ngoài ra, sản phẩm cũng phù hợp để bù nước bù khoáng cho cả gia đình và bạn bè trong những chuyến du lịch, dã ngoại.')
INSERT [dbo].[Products] ([Id], [Name], [UnitPrice], [Image], [Available], [Specification], [Quantity], [Description]) VALUES (37, N'NƯỚC CHANH MUỐI LAVIE', 9000, N'resources/images/products/chanhmuoi-revive.jpg', 1, N'Chai', 1000, N'Giải khát và bổ sung vitamin, các chất điện giải khác')
SET IDENTITY_INSERT [dbo].[Products] OFF
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Products]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
USE [master]
GO
ALTER DATABASE [WATERSHOP] SET  READ_WRITE 
GO
