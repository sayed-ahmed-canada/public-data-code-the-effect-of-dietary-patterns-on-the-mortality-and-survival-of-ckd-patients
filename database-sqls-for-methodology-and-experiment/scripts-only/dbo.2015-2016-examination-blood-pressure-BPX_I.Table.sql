USE [mrp_experiment_phase_data_process]
GO
/****** Object:  Table [dbo].[2015-2016-examination-blood-pressure-BPX_I]    Script Date: 2019-07-03 8:53:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[2015-2016-examination-blood-pressure-BPX_I](
	[SEQN - Respondent sequence number] [float] NULL,
	[PEASCCT1 - Blood Pressure Comment] [nvarchar](255) NULL,
	[BPXCHR - 60 sec HR (30 sec HR * 2)] [nvarchar](255) NULL,
	[BPAARM - Arm selected] [float] NULL,
	[BPACSZ - Coded cuff size] [float] NULL,
	[BPXPLS - 60 sec# pulse (30 sec# pulse * 2)] [float] NULL,
	[BPXPULS - Pulse regular or irregular?] [float] NULL,
	[BPXPTY - Pulse type] [float] NULL,
	[BPXML1 - MIL: maximum inflation levels (mm Hg)] [float] NULL,
	[BPXSY1 - Systolic: Blood pres (1st rdg) mm Hg] [float] NULL,
	[BPXDI1 - Diastolic: Blood pres (1st rdg) mm Hg] [float] NULL,
	[BPAEN1 - Enhancement used first reading] [float] NULL,
	[BPXSY2 - Systolic: Blood pres (2nd rdg) mm Hg] [float] NULL,
	[BPXDI2 - Diastolic: Blood pres (2nd rdg) mm Hg] [float] NULL,
	[BPAEN2 - Enhancement used second reading] [float] NULL,
	[BPXSY3 - Systolic: Blood pres (3rd rdg) mm Hg] [float] NULL,
	[BPXDI3 - Diastolic: Blood pres (3rd rdg) mm Hg] [float] NULL,
	[BPAEN3 - Enhancement used third reading] [float] NULL,
	[BPXSY4 - Systolic: Blood pres (4th rdg) mm Hg] [nvarchar](255) NULL,
	[BPXDI4 - Diastolic: Blood pres (4th rdg) mm Hg] [nvarchar](255) NULL,
	[BPAEN4 - Enhancement used fourth reading] [nvarchar](255) NULL
) ON [PRIMARY]
GO
