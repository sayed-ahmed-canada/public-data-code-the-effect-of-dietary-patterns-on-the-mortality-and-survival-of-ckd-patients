USE [mrp_2015_2016_diet_esrd_mortality]
GO
/****** Object:  Table [dbo].[food_groups_shift_recommendation]    Script Date: 2019-07-03 11:40:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[food_groups_shift_recommendation](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[id_to_use] [tinyint] NULL,
	[food_group_name] [varchar](500) NOT NULL,
	[name_to_use] [varchar](100) NULL,
	[is_parent] [tinyint] NULL,
	[is_in_usda] [smallint] NULL,
	[is_shift_subgroup] [tinyint] NULL,
	[parent_group_id] [smallint] NULL,
	[usda_group_id] [smallint] NULL,
	[usda_subgroup_code_1] [bigint] NULL,
	[usda_subgroup_code_2] [bigint] NULL,
	[usda_subgroup_code_3] [bigint] NULL,
	[usda_subgroup_code_4] [bigint] NULL,
	[usda_subgroup_code_5] [bigint] NULL,
	[usda_subgroup_code_6] [bigint] NULL,
	[usda_subgroup_code_7] [bigint] NULL,
	[usda_subgroup_code_8] [bigint] NULL,
	[note] [varchar](max) NULL,
 CONSTRAINT [PK_food_groups_shift_recommendation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[food_groups_shift_recommendation] ADD  CONSTRAINT [DF_food_groups_shift_recommendation_is_in_usda]  DEFAULT ((0)) FOR [is_in_usda]
GO
ALTER TABLE [dbo].[food_groups_shift_recommendation] ADD  CONSTRAINT [DF_food_groups_shift_recommendation_is_shift_subgroup]  DEFAULT ((0)) FOR [is_shift_subgroup]
GO
