USE [mrp_2015_2016_diet_esrd_mortality]
GO
/****** Object:  Table [dbo].[recommended_for_each_age]    Script Date: 2019-07-03 11:40:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[recommended_for_each_age](
	[age_from] [int] NOT NULL,
	[age_to] [int] NOT NULL,
	[vegetables_from] [float] NOT NULL,
	[vegetables_to] [float] NOT NULL,
	[protein_from] [float] NOT NULL,
	[protein_to] [float] NOT NULL,
	[dairy_from] [int] NOT NULL,
	[dairy_to] [int] NOT NULL,
	[fruits_from] [float] NOT NULL,
	[fruits_to] [float] NOT NULL,
	[grains_from] [int] NOT NULL,
	[grains_to] [int] NOT NULL
) ON [PRIMARY]
GO
