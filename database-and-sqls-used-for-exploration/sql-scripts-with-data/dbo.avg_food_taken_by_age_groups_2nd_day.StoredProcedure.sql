USE [mrp_2015_2016_diet_esrd_mortality]
GO
/****** Object:  StoredProcedure [dbo].[avg_food_taken_by_age_groups_2nd_day]    Script Date: 2019-07-03 12:02:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[avg_food_taken_by_age_groups_2nd_day]
AS
BEGIN	
   -- Food groups/subgroups are NOT based on Shift Recommendation
	--use [mrp_2015_2016_diet_esrd_mortality]
	--drop table #2nd_day_total_food_taken_by_age_groups
	-- EXPLORATION
	-- Insert statements for procedure here
	--insert into #total_food_taken_by_age_groups
	select
	--max(demo.[SEQN - Respondent sequence number]) as participant_id
	count(distinct(demo.[SEQN - Respondent sequence number])) as no_of_participants
	,min(demo.[RIDAGEYR - Age in years at screening]) as min_age_for_group
	,max(demo.[RIDAGEYR - Age in years at screening]) as max_age_for_group
	,min(age_groups.id) as age_group_id
	--, food_code.[DRXFCLD]
	,sum(diet.[DR2IKCAL - Energy (kcal)]) as total_calory
	,sum(diet.[DR2IPROT - Protein (gm)]) as total_protein
	, sum(diet.[DR2ISODI - Sodium (mg)]) as total_sodium
	, sum ( diet.[DR2ICARB - Carbohydrate (gm)]  ) as total_carbohydrate
	, sum (  diet.[DR2ISUGR - Total sugars (gm)] ) as total_sugar
	, sum (  diet.[DR2IFIBE - Dietary fiber (gm)] ) as total_fibre
	, sum ( diet.[DR2ITFAT - Total fat (gm)] ) as total_fat
	, sum ( diet.[DR2ISFAT - Total saturated fatty acids (gm)]) as total_saturated_fat
	,sum ( diet.[DR2IMFAT - Total monounsaturated fatty acids (gm)]) as total_mono_fat
	,sum ( diet.[DR2IPFAT - Total polyunsaturated fatty acids (gm)]) as total_poly_fat
	,sum ( diet.[DR2ICHOL - Cholesterol (mg)]) as total_cholesterol
	,sum ( diet.[DR2ICALC - Calcium (mg)]) as total_calcium
	,sum ( diet.[DR2IPHOS - Phosphorus (mg)]) as total_phosphorous
	,sum ( diet.[DR2IMAGN - Magnesium (mg)]) as total_magnesium
	,sum ( diet.[DR2IPOTA - Potassium (mg)]) as total_potassium
	,sum ( diet.[DR2IALCO - Alcohol (gm)]) as total_alcohol
	--, diet.*
	into #2nd_day_total_food_taken_by_age_groups
	from [2015-2016-demographics_data] demo
	inner join [2015-2016-dietary-interview-individual-foods-2nd-day-DR2IFF_I] diet on demo.[SEQN - Respondent sequence number] = diet.[SEQN - Respondent sequence number]
	left join [2015-2016-support-food-codes-DRXFCD_I] food_code on food_code.[DRXFDCD] = diet.[DR2IFDCD - USDA food code]	
	left join age_groups on demo.[RIDAGEYR - Age in years at screening]  <= age_groups.[to] and (demo.[RIDAGEYR - Age in years at screening]  >= age_groups.[from]) 
	--group by diet.[SEQN - Respondent sequence number]
	group by age_groups.id
	--having age_groups.id <= 1
	order by age_group_id

	select 
	age_group_id
	,min_age_for_group
	,max_age_for_group
	,round(total_calory/no_of_participants,2) as avg_calory
	,round(total_protein/no_of_participants,2) as avg_protein
	,round(total_sodium/no_of_participants,2) as avg_sodium
	,round(total_carbohydrate/no_of_participants,2) as avg_carbohydrate
	,round(total_sugar/no_of_participants,2) as avg_sugar
	,round(total_fibre/no_of_participants,2) as avg_fibre
	,round(total_fat/no_of_participants,2) as avg_fat
	,round(total_saturated_fat/no_of_participants,2) as avg_saturated_fat
	,round(total_mono_fat/no_of_participants,2) as avg_mono_fat
	,round(total_poly_fat/no_of_participants,2) as avg_poly_fat
	,round(total_cholesterol/no_of_participants,2) as avg_cholesterol
	,round(total_calcium/no_of_participants,2) as avg_calcium
	,round(total_phosphorous/no_of_participants,2) as avg_phosphorous
	,round(total_magnesium/no_of_participants,2) as avg_magnesium
	,round(total_potassium/no_of_participants,2) as avg_potassium
	,round(total_alcohol/no_of_participants,2) as avg_alcohol
	from #2nd_day_total_food_taken_by_age_groups
	order by age_group_id



END
GO
