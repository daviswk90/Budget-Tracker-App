use [master]
create database [MonthlyExpensesTest]
containment = none
on PRIMARY
(NAME = N'MonthlyExpensesTest',  FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\MonthlyExpensesTest.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG on
 ( NAME = N'Doctor_Info_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\MonthlyExpensesTest.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [MonthlyExpensesTest] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MonthlyExpensesTest].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MonthlyExpensesTest] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MonthlyExpensesTest] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MonthlyExpensesTest] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MonthlyExpensesTest] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MonthlyExpensesTest] SET ARITHABORT OFF 
GO
ALTER DATABASE [MonthlyExpensesTest] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MonthlyExpensesTest] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MonthlyExpensesTest] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MonthlyExpensesTest] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MonthlyExpensesTest] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MonthlyExpensesTest] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MonthlyExpensesTest] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MonthlyExpensesTest] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MonthlyExpensesTest] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MonthlyExpensesTest] SET  ENABLE_BROKER 
GO
ALTER DATABASE [MonthlyExpensesTest] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MonthlyExpensesTest] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MonthlyExpensesTest] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MonthlyExpensesTest] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MonthlyExpensesTest] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MonthlyExpensesTest] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MonthlyExpensesTest] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MonthlyExpensesTest] SET RECOVERY FULL 
GO
ALTER DATABASE [MonthlyExpensesTest] SET  MULTI_USER 
GO
ALTER DATABASE [MonthlyExpensesTest] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MonthlyExpensesTest] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MonthlyExpensesTest] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MonthlyExpensesTest] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MonthlyExpensesTest] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MonthlyExpensesTest] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'MonthlyExpensesTest', N'ON'
GO
ALTER DATABASE [MonthlyExpensesTest] SET QUERY_STORE = ON
GO
ALTER DATABASE [MonthlyExpensesTest] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
use [MonthlyExpensesTest]
GO
set QUOTED_IDENTIFIER ON
GO
/*UserInfo Table*/
CREATE TABLE [dbo].[UserInfo](
    [UserID] [int] identity(1,1) NOT NULL,
    [Username] [nvarchar](50) NOT NULL unique,
    [LastName] [nvarchar](50) NOT NULL,
    [Email] [nvarchar](120) NOT NULL,
    [Phone] [nvarchar](10) NOT NULL,
    [PasswordHashes] [varbinary](64) NOT NULL,

    PRIMARY KEY clustered (
        [UserID] asc
    )  
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
)
on [PRIMARY]
/*Categories Table*/
CREATE TABLE [dbo].[Categories](
    [CategoryID] [int] identity(1,1) NOT NULL,
    [CategoryName] [nvarchar](15) NOT NULL,
    [Description] [ntext],
    [CategoryType] [nvarchar](25) NOT NULL,
    [Picture] [image],

    PRIMARY KEY clustered (
        [CategoryID] asc
    )  
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
)
on [PRIMARY]
/*Plans Table*/
CREATE TABLE [dbo].[Plans](
    [PlanID] [int] identity(1,1) NOT NULL,
    [DailyPlan] [tinyint],
    [WeeklyPlan] [tinyint],
    [MonthlyPlan] [tinyint] NOT NULL,
    [CustomPlan] [tinyint],
    [UserID] [int] NOT NULL,
    PRIMARY KEY clustered (
        [PlanID] asc
    )  
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
)
on [PRIMARY]
/*Finances Table*/
CREATE TABLE [dbo].[Finances](
    [CurrentBudget] [money]  NOT NULL,
    [DailySpending] [money] NOT NULL,
    [MonthlyGoal] [money] NOT NULL,
    [WeeklyGoal] [money] NULL,
    [DailyGoal] [money] NULL,
    [AverageMonthlySpending] [money] NOT NULL,
    [MonthlySavings] [money] NOT NULL,
    [UserID] [int] NOT NULL,
    /*USER could have multiple accounts linked to their UserID ex: In a banking app, you can see checking, savings, and other cards you have registered to the UserID*/
    [AccountID] [int] identity(1,1) NOT NULL,


    PRIMARY KEY clustered (
        [AccountID] asc
    )  
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
)
on [PRIMARY]
