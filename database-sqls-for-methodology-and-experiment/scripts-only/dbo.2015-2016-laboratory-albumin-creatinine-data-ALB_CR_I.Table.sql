USE [mrp_experiment_phase_data_process]
GO
/****** Object:  Table [dbo].[2015-2016-laboratory-albumin-creatinine-data-ALB_CR_I]    Script Date: 2019-07-17 5:27:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[2015-2016-laboratory-albumin-creatinine-data-ALB_CR_I](
	[SEQN - Respondent sequence number] [float] NULL,
	[URXUMA - Albumin, urine (ug/mL)] [float] NULL,
	[URDUMALC - Albumin, urine comment code] [float] NULL,
	[URXUMS - Albumin, urine (mg/L)] [float] NULL,
	[URXUCR - Creatinine, urine (mg/dL)] [float] NULL,
	[URDUCRLC - Creatinine, urine comment code] [float] NULL,
	[URXCRS - Creatinine, urine (umol/L)] [float] NULL,
	[URDACT - Albumin creatinine ratio (mg/g)] [float] NULL
) ON [PRIMARY]
GO
