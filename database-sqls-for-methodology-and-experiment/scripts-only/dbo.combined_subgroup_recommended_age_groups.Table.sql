USE [mrp_experiment_phase_data_process]
GO
/****** Object:  Table [dbo].[combined_subgroup_recommended_age_groups]    Script Date: 2019-07-17 5:27:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[combined_subgroup_recommended_age_groups](
	[age_from] [int] NOT NULL,
	[age_to] [int] NOT NULL,
	[subgroup] [nvarchar](50) NOT NULL,
	[food_subgroup] [nvarchar](50) NOT NULL,
	[average_taken] [float] NOT NULL,
	[recommended_low] [float] NOT NULL,
	[recommended_high] [float] NOT NULL
) ON [PRIMARY]
GO
