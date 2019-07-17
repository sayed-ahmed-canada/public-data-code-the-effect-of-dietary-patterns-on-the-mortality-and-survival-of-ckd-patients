USE [mrp_experiment_phase_data_process]
GO
/****** Object:  Table [dbo].[usda_food_groups]    Script Date: 2019-07-03 8:53:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usda_food_groups](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[food_group_name] [varchar](500) NOT NULL,
	[food_group_name_to_use] [nvarchar](500) NULL,
	[description] [varchar](500) NULL,
 CONSTRAINT [PK_food_groups_subgroups] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
