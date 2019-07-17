USE [mrp_experiment_phase_data_process]
GO
/****** Object:  Table [dbo].[usda_food_group_subgroup_relations]    Script Date: 2019-07-17 5:28:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usda_food_group_subgroup_relations](
	[entry_id] [float] NULL,
	[usda_food_group_id] [float] NULL,
	[food_group_name] [nvarchar](255) NULL,
	[food_group_name_to_use] [nvarchar](255) NULL,
	[usda_subgroup_id] [float] NULL,
	[usda_subgroup_name] [nvarchar](255) NULL,
	[usda_subgroup_name_to_use] [nvarchar](255) NULL
) ON [PRIMARY]
GO
