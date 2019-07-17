USE [mrp_experiment_phase_data_process]
GO
/****** Object:  Table [dbo].[age_food_group_recommended_amount_adjusted]    Script Date: 2019-07-17 5:27:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[age_food_group_recommended_amount_adjusted](
	[age] [float] NULL,
	[food_group] [nvarchar](255) NULL,
	[average_taken] [float] NULL,
	[recommended_low] [float] NULL,
	[recommended_high] [float] NULL
) ON [PRIMARY]
GO
