USE [mrp_2015_2016_diet_esrd_mortality]
GO
/****** Object:  StoredProcedure [dbo].[recom_groups_usda_groups]    Script Date: 2019-07-03 12:02:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[recom_groups_usda_groups]
AS
BEGIN
-- mapping shift recommendation groups with USDA food groups
-- Legumes and cheese might need to be kept in mind
SELECT *
FROM [food_groups_shift_recommendation] map
left join usda_food_groups usda on usda.id = map.usda_group_id 

END
GO
