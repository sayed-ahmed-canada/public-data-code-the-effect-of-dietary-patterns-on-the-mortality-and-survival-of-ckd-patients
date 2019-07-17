USE [mrp_experiment_phase_data_process]
GO
/****** Object:  Table [dbo].[usda_average_intake_by_food_subgroups_demo_acr_kidney_blood_pressure]    Script Date: 2019-07-03 8:53:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usda_average_intake_by_food_subgroups_demo_acr_kidney_blood_pressure](
	[participant_id] [float] NULL,
	[participant_age] [float] NULL,
	[gender] [float] NULL,
	[food_group_name] [nvarchar](255) NULL,
	[food_subgroup_name] [nvarchar](255) NULL,
	[avg_food_weight_in_gms] [float] NULL,
	[acr] [float] NULL,
	[kidney_failed] [float] NULL,
	[systolic_pressure] [float] NULL,
	[diastolic_pressure] [float] NULL,
	[calorie] [float] NULL,
	[protein] [float] NULL,
	[sodium] [float] NULL,
	[carbohydrate] [float] NULL,
	[sugar] [float] NULL,
	[fibre] [float] NULL,
	[fat] [float] NULL,
	[saturated_fat] [float] NULL,
	[mono_fat] [float] NULL,
	[poly_fat] [float] NULL,
	[cholesterol] [float] NULL,
	[calcium] [float] NULL,
	[phosphorous] [float] NULL,
	[magnesium] [float] NULL,
	[potassium] [float] NULL,
	[alcohol] [float] NULL,
	[m_food_group_name] [varchar](500) NULL,
	[a_sample_food_code] [float] NULL,
	[a_sample_food] [nvarchar](255) NULL,
	[a_sample_food_name] [varchar](300) NULL,
	[food_group_id] [smallint] NULL,
	[albumin_urine_mu_g] [float] NULL,
	[albumin_urine_mg] [float] NULL,
	[creatinine_mu_mol] [float] NULL,
	[creatinine_mg] [float] NULL,
	[received_dialysis_in_12_months] [nvarchar](255) NULL,
	[kidney_stones] [float] NULL,
	[passed_kidney_stones_12_months] [nvarchar](255) NULL,
	[urinary_leakage_frequency] [float] NULL,
	[urine_lose_each_time] [nvarchar](255) NULL,
	[leak_during_activities] [float] NULL,
	[how_frequent_leak_occurs] [nvarchar](255) NULL,
	[urinated_before_reaching_toilet] [float] NULL,
	[how_frequent] [nvarchar](255) NULL,
	[leak_during_nonphysical_activities] [float] NULL,
	[how_frequest_leak_nonphysical] [nvarchar](255) NULL,
	[how_much_leak_bothering] [nvarchar](255) NULL,
	[how_much_daily_activities_affected] [float] NULL,
	[count_night_time_urinate] [nvarchar](255) NULL
) ON [PRIMARY]
GO
