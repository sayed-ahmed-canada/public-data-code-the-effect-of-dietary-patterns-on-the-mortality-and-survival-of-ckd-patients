USE [mrp_experiment_phase_data_process]
GO
/****** Object:  StoredProcedure [dbo].[load_all_individual_food_intake_into_one_table]    Script Date: 2019-07-04 9:37:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[load_all_individual_food_intake_into_one_table]
AS
BEGIN

    ----- Most Important Parts:
	--- 2nd Option for Consolidated Data
	--- Then the last part where food groups are determined
	
	-- table where merged data from dietary food intake from multiple days will be kept
	-- the data will be averaged
	truncate table [multi-day-dietary-interview-individual-foods]

	----------------------Row count to verify with merged table
	--result: 121481
	select count(*)
	from  [2015-2016-dietary-interview-individual-foods-first-day-DR1IFF_I]
	
	-- 100680
	select count(*)
	from  [2015-2016-dietary-interview-individual-foods-2nd-day-DR2IFF_I]

	--- Total number of rows 222161
	select 121481 + 100680

   ----------------------------------------------------------

   -- distict participant id in the interviews

	-- First day: 8505
	select count(distinct([SEQN - Respondent sequence number]))
	from  [2015-2016-dietary-interview-individual-foods-first-day-DR1IFF_I]

	--2nd day: 7027
	select count(distinct([SEQN - Respondent sequence number]))
	from  [2015-2016-dietary-interview-individual-foods-2nd-day-DR2IFF_I]

	--There will be significant overlaps between  two days. Apparently: all 2nd day participants belong to first day though on 2nd day
	--some participants are missing

	---------------------------



	insert into [multi-day-dietary-interview-individual-foods] 
	select *, 1, '2015-2016', '2015', '2016'
	from [2015-2016-dietary-interview-individual-foods-first-day-DR1IFF_I]

	union all 
	
	select *, 2, '2015-2016', '2015', '2016'
	from [2015-2016-dietary-interview-individual-foods-2nd-day-DR2IFF_I]

	select count(*)
	from [multi-day-dietary-interview-individual-foods]

	select top(10) *
	from [multi-day-dietary-interview-individual-foods]


	---------------------------------

	--result: 222161 that matches with the sum of individual table row counts
	select count(*)
	from  [multi-day-dietary-interview-individual-foods]


	--result: 8505
	-- Apparently: all 2nd day participants belong to first day though on 2nd day some 1st day participants are missing
	select count(distinct([SEQN - Respondent sequence number]))
	from  [multi-day-dietary-interview-individual-foods]

	-----------------

	----START : THIS BLOCK IS NOT Required or important ---------------------
	---Was brought here from older code/sql as a reference ----------
	-- calculate average intake from two days
	-- at this point not taking average rather considering each response to be different data points
	-- might take average, at that point only relevant columns will be kept (otherwise too many colums to deal with)
	select top (1000)
	  max(demo.[SEQN - Respondent sequence number]) as participant_id
	, max([day]) as max_day
	, max(demo.[RIDAGEYR - Age in years at screening]) as participant_age
	--, food_code.[DRXFCLD] as food_taken
	--, max(map.group_id) as food_group_id
	--, max(map.food_name) as food_name_a_sample
	--, max(map.group_name) as food_group_name
	--, max(recom.food_group_name) as food_group_name
	, avg([DR1IGRMS - Grams]) as food_weight_in_gms
	--, [DR1IFDCD - USDA food code] as usda_food_code
	--, diet.*
	from [2015-2016-demographics_data] demo
	--inner join [2015-2016-dietary-interview-individual-foods-first-day-DR1IFF_I] diet on demo.[SEQN - Respondent sequence number] = diet.[SEQN - Respondent sequence number]
	inner join [multi-day-dietary-interview-individual-foods] diet on demo.[SEQN - Respondent sequence number] = diet.[SEQN - Respondent sequence number]
	inner join [2015-2016-support-food-codes-DRXFCD_I] food_code on food_code.[DRXFDCD] = diet.[DR1IFDCD - USDA food code]
	--inner join [map_food_to_groups_sub_groups] map on map.usda_food_code = diet.[DR1IFDCD - USDA food code]
	--left join age_groups on demo.[RIDAGEYR - Age in years at screening]  <= age_groups.[to] and (demo.[RIDAGEYR - Age in years at screening]  >= age_groups.[from]) 
	--inner join food_groups_shift_recommendation recom on recom.id = map.group_id
	group by demo.[SEQN - Respondent sequence number]--, [day]--, group_id
	order by demo.[SEQN - Respondent sequence number]--, [day]

	--END: Block not important-----------------------------------------------------



	---------------------------Data Consolidation-------------------------------------------

	--Option 1: --combine individual food intake data with demographics data ------
	--this data might miss ACR information for some participants; hence, will not use this data as is

	-- combine food intake -- demographics -- ACR -- kidney condition -- blood pressure -- data
	-- not filtering out any data irrespective ACR or Kidney or Blood pressure is there or not
	-- demographics information is a must
	-- produces 222161 rows	 i.e. all rows from dietary food intake tables are retained

	select *
	--into #[nhanes-xlsx-data-1999-2016-demographics-food-taken-nutrients-blood-pressure-albumin-creatinine]
	from [multi-day-dietary-interview-individual-foods] survey	
	inner join [2015-2016-demographics_data] demo on demo.[SEQN - Respondent sequence number] = survey.[SEQN - Respondent sequence number]
	left join [2015-2016-laboratory-albumin-creatinine-data-ALB_CR_I] acr on acr.[SEQN - Respondent sequence number] = demo.[SEQN - Respondent sequence number]
	left join [2015-2016-examinations-kidney-condition-KIQ_U_I] kidney on kidney.[SEQN - Respondent sequence number] = demo.[SEQN - Respondent sequence number]
	left join [2015-2016-examination-blood-pressure-BPX_I] blood on demo.[SEQN - Respondent sequence number] = blood.[SEQN - Respondent sequence number]
		
	-- Option 2: -- combine food item intake -- demographics -- ACR -- kidney condition -- blood pressure -- data
	--- THIS data can be seen as the most relevant for the analysis as ACR data is must
	-- keep data that has ACR : i.e. ACR is a must: demographics must have
	-- produces 202758 rows of data
	select *
	from [multi-day-dietary-interview-individual-foods] survey
	inner join [2015-2016-demographics_data] demo on demo.[SEQN - Respondent sequence number] = survey.[SEQN - Respondent sequence number]
	inner join [2015-2016-laboratory-albumin-creatinine-data-ALB_CR_I] acr on acr.[SEQN - Respondent sequence number] = demo.[SEQN - Respondent sequence number]
	left join [2015-2016-examinations-kidney-condition-KIQ_U_I] kidney on kidney.[SEQN - Respondent sequence number] = demo.[SEQN - Respondent sequence number]
	left join [2015-2016-examination-blood-pressure-BPX_I] blood on demo.[SEQN - Respondent sequence number] = blood.[SEQN - Respondent sequence number]


	--Option 3 -- combine food intake -- demographics -- ACR -- kidney condition -- blood pressure -- data
	-- keep data that has ACR and kidney data : i.e. ACR and kidney data must : demographics also must
	-- produces 140083 rows of data
	select *
	from [multi-day-dietary-interview-individual-foods] survey
	inner join [2015-2016-demographics_data] demo on demo.[SEQN - Respondent sequence number] = survey.[SEQN - Respondent sequence number]
	inner join [2015-2016-laboratory-albumin-creatinine-data-ALB_CR_I] acr on acr.[SEQN - Respondent sequence number] = demo.[SEQN - Respondent sequence number]
	inner join [2015-2016-examinations-kidney-condition-KIQ_U_I] kidney on kidney.[SEQN - Respondent sequence number] = demo.[SEQN - Respondent sequence number]
	left join [2015-2016-examination-blood-pressure-BPX_I] blood on demo.[SEQN - Respondent sequence number] = blood.[SEQN - Respondent sequence number]


	--Option 4
	-- combine food intake -- demographics -- ACR -- kidney condition -- blood pressure -- data
	-- keep data that has ACR and kidney data : i.e. ACR and kidney data must : demographics also muat : blood pressure data must
	-- produces 140083 rows of data
	-- probably generates the same data like above
	select *
	from [multi-day-dietary-interview-individual-foods] survey
	inner join [2015-2016-demographics_data] demo on demo.[SEQN - Respondent sequence number] = survey.[SEQN - Respondent sequence number]
	inner join [2015-2016-laboratory-albumin-creatinine-data-ALB_CR_I] acr on acr.[SEQN - Respondent sequence number] = demo.[SEQN - Respondent sequence number]
	inner join [2015-2016-examinations-kidney-condition-KIQ_U_I] kidney on kidney.[SEQN - Respondent sequence number] = demo.[SEQN - Respondent sequence number]
	inner join [2015-2016-examination-blood-pressure-BPX_I] blood on demo.[SEQN - Respondent sequence number] = blood.[SEQN - Respondent sequence number]

	-- Option 2: can be seen as the most appropriate. ACR can be the primary measure for CKD, Kidney condition data does not say much for CKD
	-- Combine food intake -- demographics -- ACR -- kidney condition -- blood pressure -- data
	-- Keep data that has ACR : i.e. ACR is a must: demographics must have
	-- Produces 202758 rows of data

	---------------------------End Data Consolidation-------Option 2 from above is the most important------------------------------------

	-- Explore Data : not a very important section
	-- all columns
	select top(10)
	demo.[SEQN - Respondent sequence number]
	, demo.[RIDAGEYR - Age in years at screening] as participant_age
	, food_code.[DRXFCLD] as food_taken
	, [DR1IGRMS - Grams] as food_weight_in_gms
	, acr.*
	, kidney.*
	, blood.*
	, demo.*
	from [multi-day-dietary-interview-individual-foods] survey
	inner join [2015-2016-demographics_data] demo on demo.[SEQN - Respondent sequence number] = survey.[SEQN - Respondent sequence number]
	inner join [2015-2016-laboratory-albumin-creatinine-data-ALB_CR_I] acr on acr.[SEQN - Respondent sequence number] = demo.[SEQN - Respondent sequence number]
	left join  [2015-2016-examinations-kidney-condition-KIQ_U_I] kidney on kidney.[SEQN - Respondent sequence number] = demo.[SEQN - Respondent sequence number]
	left join  [2015-2016-examination-blood-pressure-BPX_I] blood on demo.[SEQN - Respondent sequence number] = blood.[SEQN - Respondent sequence number]

	inner join [2015-2016-support-food-codes-DRXFCD_I] food_code on food_code.[DRXFDCD] = survey.[DR1IFDCD - USDA food code]
	--inner join [map_food_to_groups_sub_groups] map on map.usda_food_code = diet.[DR1IFDCD - USDA food code]
	--left join age_groups on demo.[RIDAGEYR - Age in years at screening]  <= age_groups.[to] and (demo.[RIDAGEYR - Age in years at screening]  >= age_groups.[from]) 
	--inner join food_groups_shift_recommendation recom on recom.id = map.group_id
	--group by demo.[SEQN - Respondent sequence number]--, [day]--, group_id
	order by demo.[SEQN - Respondent sequence number], [day]

	

	--Explore data -- just trying to find out the most relevant columns
	-- important columns
	select top(1000)
	demo.[SEQN - Respondent sequence number]
	,demo.[RIDAGEYR - Age in years at screening] as participant_age
	,demo.[RIAGENDR - Gender]
	,food_code.[DRXFCLD] as food_taken
	,[day]
	,[DR1IGRMS - Grams] as food_weight_in_gms
	,acr.[URDACT - Albumin creatinine ratio (mg/g)]	as acr
	,kidney.[KIQ022 - Ever told you had weak/failing kidneys] as kidney_failed
	,blood.[BPXSY1 - Systolic: Blood pres (1st rdg) mm Hg] as systolic_pressure
	,blood.[BPXDI1 - Diastolic: Blood pres (1st rdg) mm Hg] as diastolic_pressure	
	,survey.[DR1IKCAL - Energy (kcal)] as calorie
	,survey.[DR1IPROT - Protein (gm)] as protein
	,survey.[DR1ISODI - Sodium (mg)] as sodium
	,survey.[DR1ICARB - Carbohydrate (gm)]   as carbohydrate
	,survey.[DR1ISUGR - Total sugars (gm)]  as sugar
	,survey.[DR1IFIBE - Dietary fiber (gm)]  as fibre
	,survey.[DR1ITFAT - Total fat (gm)]  as fat
	,survey.[DR1ISFAT - Total saturated fatty acids (gm)] as saturated_fat
	,survey.[DR1IMFAT - Total monounsaturated fatty acids (gm)] as mono_fat
	,survey.[DR1IPFAT - Total polyunsaturated fatty acids (gm)] as poly_fat
	,survey.[DR1ICHOL - Cholesterol (mg)] as cholesterol
	,survey.[DR1ICALC - Calcium (mg)] as calcium
	,survey.[DR1IPHOS - Phosphorus (mg)] as phosphorous
	,survey.[DR1IMAGN - Magnesium (mg)] as magnesium
	,survey.[DR1IPOTA - Potassium (mg)] as potassium
	,survey.[DR1IALCO - Alcohol (gm)] as alcohol
	--, survey.*
	from [multi-day-dietary-interview-individual-foods] survey
	inner join [2015-2016-demographics_data] demo on demo.[SEQN - Respondent sequence number] = survey.[SEQN - Respondent sequence number]
	inner join [2015-2016-laboratory-albumin-creatinine-data-ALB_CR_I] acr on acr.[SEQN - Respondent sequence number] = demo.[SEQN - Respondent sequence number]
	left join  [2015-2016-examinations-kidney-condition-KIQ_U_I] kidney on kidney.[SEQN - Respondent sequence number] = demo.[SEQN - Respondent sequence number]
	left join  [2015-2016-examination-blood-pressure-BPX_I] blood on demo.[SEQN - Respondent sequence number] = blood.[SEQN - Respondent sequence number]

	inner join [2015-2016-support-food-codes-DRXFCD_I] food_code on food_code.[DRXFDCD] = survey.[DR1IFDCD - USDA food code]
	--inner join [map_food_to_groups_sub_groups] map on map.usda_food_code = diet.[DR1IFDCD - USDA food code]
	--left join age_groups on demo.[RIDAGEYR - Age in years at screening]  <= age_groups.[to] and (demo.[RIDAGEYR - Age in years at screening]  >= age_groups.[from]) 
	--inner join food_groups_shift_recommendation recom on recom.id = map.group_id
	--group by demo.[SEQN - Respondent sequence number]--, [day]--, group_id
	where demo.[SEQN - Respondent sequence number] = 83732
	order by demo.[SEQN - Respondent sequence number], food_code.[DRXFCLD], [day]


	--- create a temporary table with important columns, and calculating averages for food items
	-- important columns
	--average of intake amount

	drop table #albumin_creatinine_and_demographics
	drop table #albumin_creatinine_and_demographics_food_items

	--result: 154837 rows
	select /*top(10)*/
	max(demo.[SEQN - Respondent sequence number]) as participant_id
	,max(demo.[RIDAGEYR - Age in years at screening]) as participant_age
	,max(food_code.[DRXFCLD]) as food_taken
	, max (survey.[DR1IFDCD - USDA food code]) as usda_food_code
	,avg([DR1IGRMS - Grams]) as food_weight_in_gms

	--, max(map.group_id) as food_group_id
	--, max(map.food_name) as food_name_a_sample
	--, max(map.group_name) as food_group_name
	--, max(recom.food_group_name) as food_group_name

	,avg(acr.[URDACT - Albumin creatinine ratio (mg/g)]) as acr
	,max(kidney.[KIQ022 - Ever told you had weak/failing kidneys]) as kidney_failed
	,avg(blood.[BPXSY1 - Systolic: Blood pres (1st rdg) mm Hg]) as systolic_pressure
	,avg(blood.[BPXDI1 - Diastolic: Blood pres (1st rdg) mm Hg]) as diastolic_pressure
	,max(demo.[RIAGENDR - Gender]) as gender
	,avg(survey.[DR1IKCAL - Energy (kcal)]) as calorie
	,avg(survey.[DR1IPROT - Protein (gm)]) as protein
	,avg(survey.[DR1ISODI - Sodium (mg)]) as sodium
	,avg(survey.[DR1ICARB - Carbohydrate (gm)])   as carbohydrate
	,avg(survey.[DR1ISUGR - Total sugars (gm)])  as sugar
	,avg(survey.[DR1IFIBE - Dietary fiber (gm)])  as fibre
	,avg(survey.[DR1ITFAT - Total fat (gm)])  as fat
	,avg(survey.[DR1ISFAT - Total saturated fatty acids (gm)]) as saturated_fat
	,avg(survey.[DR1IMFAT - Total monounsaturated fatty acids (gm)]) as mono_fat
	,avg(survey.[DR1IPFAT - Total polyunsaturated fatty acids (gm)]) as poly_fat
	,avg(survey.[DR1ICHOL - Cholesterol (mg)]) as cholesterol
	,avg(survey.[DR1ICALC - Calcium (mg)]) as calcium
	,avg(survey.[DR1IPHOS - Phosphorus (mg)]) as phosphorous
	,avg(survey.[DR1IMAGN - Magnesium (mg)]) as magnesium
	,avg(survey.[DR1IPOTA - Potassium (mg)]) as potassium
	,avg(survey.[DR1IALCO - Alcohol (gm)]) as alcohol
	
	,max(acr.[URXUMA - Albumin, urine (ug/mL)]) as albumin_urine_mu_g
	,max(acr.[URXUMS - Albumin, urine (mg/L)]) as albumin_urine_mg
	,max(acr.[URXCRS - Creatinine, urine (umol/L)]) as creatinine_mu_mol
	,max(acr.[URXUCR - Creatinine, urine (mg/dL)]) as creatinine_mg
	
	,max(kidney.[KIQ025 - Received dialysis in past 12 months]) as received_dialysis_in_12_months
	,max(kidney.[KIQ026 - Ever had kidney stones?]) as kidney_stones
	,max(kidney.[KIQ029 - Pass kidney stone in past 12 months?]) as passed_kidney_stones_12_months
			
	,max(kidney.[KIQ005 - How often have urinary leakage]) as urinary_leakage_frequency	
	,max(kidney.[KIQ010 - How much urine lose each time?]) as urine_lose_each_time	
	,max(kidney.[KIQ042 - Leak urine during physical activities]) as leak_during_activities	
	,max(kidney.[KIQ430 - How frequently does this occur?]) as how_frequent_leak_occurs	
	,max(kidney.[KIQ044 - Urinated before reaching the toilet]) as urinated_before_reaching_toilet	
	,max(kidney.[KIQ450 - How frequently does this occur?]) as how_frequent	
	,max(kidney.[KIQ046 - Leak urine during nonphysical activities]) as leak_during_nonphysical_activities	
	,max(kidney.[KIQ470 - How frequently does this occur?]) as how_frequest_leak_nonphysical	
	,max(kidney.[KIQ050 - How much did urine leakage bother you]) as how_much_leak_bothering
	,max(kidney.[KIQ052 - How much were daily activities affected]) as how_much_daily_activities_affected
	,max(kidney.[KIQ480 - How many times urinate in night?]) as count_night_time_urinate

	--, survey.*
	--into #albumin_creatinine_and_demographics
	into #albumin_creatinine_and_demographics_food_items
	from [multi-day-dietary-interview-individual-foods] survey
	inner join [2015-2016-demographics_data] demo on demo.[SEQN - Respondent sequence number] = survey.[SEQN - Respondent sequence number]
	inner join [2015-2016-laboratory-albumin-creatinine-data-ALB_CR_I] acr on acr.[SEQN - Respondent sequence number] = demo.[SEQN - Respondent sequence number]
	left join  [2015-2016-examinations-kidney-condition-KIQ_U_I] kidney on kidney.[SEQN - Respondent sequence number] = demo.[SEQN - Respondent sequence number]
	left join  [2015-2016-examination-blood-pressure-BPX_I] blood on demo.[SEQN - Respondent sequence number] = blood.[SEQN - Respondent sequence number]
	inner join [2015-2016-support-food-codes-DRXFCD_I] food_code on food_code.[DRXFDCD] = survey.[DR1IFDCD - USDA food code]
	--inner join [map_food_to_groups_sub_groups] map on map.usda_food_code = survey.[DR1IFDCD - USDA food code]
	-- not required left join age_groups on demo.[RIDAGEYR - Age in years at screening]  <= age_groups.[to] and (demo.[RIDAGEYR - Age in years at screening]  >= age_groups.[from]) 
	--inner join food_groups_shift_recommendation recom on recom.id = map.group_id
	--where demo.[SEQN - Respondent sequence number] = 83732
	group by demo.[SEQN - Respondent sequence number],  food_code.[DRXFCLD] --, [day] --, group_id
	order by demo.[SEQN - Respondent sequence number], food_taken   --, [day]

	
	--test

	select count(*)
	from  [multi-day-dietary-interview-individual-foods]
	--

	select count(*)
	from #albumin_creatinine_and_demographics

	select top(1000) *
	from #albumin_creatinine_and_demographics
	order by participant_id

	select top(1000) *
	from #albumin_creatinine_and_demographics_food_items
	order by participant_id

	-- map food groups and subgroups
	select top(1000)
	acrd.*, map.food_name, map.group_id, map.group_name, recom.food_group_name
	--from #albumin_creatinine_and_demographics acrd
	from #albumin_creatinine_and_demographics_food_items acrd
	inner join [map_food_to_groups_sub_groups] map on map.usda_food_code = acrd.usda_food_code
	inner join food_groups_shift_recommendation recom on recom.id = map.group_id
	order by participant_id, map.group_name

	-- average intake amount by food groups
	-- result: 45419 rows
	drop table #average_intake_by_food_groups

	select /*top(1000)*/
	  max(acrd.participant_id) as participant_id
	, max(acrd.participant_age) as participant_age
	, max(acrd.gender) as gender	
	, max(recom.food_group_name) as food_group_name
	, round(avg(acrd.food_weight_in_gms),2) as avg_food_weight_in_gms
	, max(acrd.acr) as acr
	, max(acrd.kidney_failed) as kidney_failed	
	, max(acrd.systolic_pressure)  as systolic_pressure
	, max (acrd.diastolic_pressure)  as diastolic_pressure


	, max(acrd.calorie)  as calorie
	, max(acrd.protein)  as protein
	, max(acrd.sodium)  as sodium
	, max(acrd.carbohydrate)  as carbohydrate
	, max(acrd.sugar)  as sugar
	, max(acrd.fibre)  as fibre
	, max(acrd.fat)  as fat
	, max(acrd.saturated_fat)  as saturated_fat
	, max(acrd.mono_fat)  as mono_fat
	, max(acrd.poly_fat)  as poly_fat
	, max(acrd.cholesterol)  as cholesterol
	, max(acrd.calcium)  as calcium
	, max(acrd.phosphorous)  as phosphorous
	, max(acrd.magnesium)  as magnesium
	, max(acrd.potassium)  as potassium
	, max(acrd.alcohol) as alcohol
	, max(map.group_name) as m_food_group_name
	, max(acrd.usda_food_code) as a_sample_food_code
	, max(acrd.food_taken) as a_sample_food
	, max(map.food_name) as a_sample_food_name
	, max(map.group_id) as food_group_id

	, max(acrd.albumin_urine_mu_g) as albumin_urine_mu_g
	, max(acrd.albumin_urine_mg) as albumin_urine_mg
	, max(acrd.creatinine_mu_mol) as creatinine_mu_mol
	, max(acrd.creatinine_mg) as creatinine_mg

	,max(acrd.received_dialysis_in_12_months) as received_dialysis_in_12_months
	,max(acrd.[kidney_stones]) as kidney_stones
	,max(acrd.[passed_kidney_stones_12_months]) as passed_kidney_stones_12_months
			
	,max(acrd.[urinary_leakage_frequency]) as urinary_leakage_frequency	
	,max(acrd.[urine_lose_each_time]) as urine_lose_each_time	
	,max(acrd.[leak_during_activities]) as leak_during_activities	
	,max(acrd.[how_frequent_leak_occurs]) as how_frequent_leak_occurs	
	,max(acrd.[urinated_before_reaching_toilet]) as urinated_before_reaching_toilet	
	,max(acrd.[how_frequent]) as how_frequent	
	,max(acrd.[leak_during_nonphysical_activities]) as leak_during_nonphysical_activities	
	,max(acrd.[how_frequest_leak_nonphysical]) as how_frequest_leak_nonphysical	
	,max(acrd.[how_much_leak_bothering]) as how_much_leak_bothering
	,max(acrd.[how_much_daily_activities_affected]) as how_much_daily_activities_affected
	,max(acrd.[count_night_time_urinate]) as count_night_time_urinate



	--from #albumin_creatinine_and_demographics acrd
	into #average_intake_by_food_groups
	from #albumin_creatinine_and_demographics_food_items acrd
	inner join [map_food_to_groups_sub_groups] map on map.usda_food_code = acrd.usda_food_code
	inner join food_groups_shift_recommendation recom on recom.id = map.group_id
	group by participant_id, recom.food_group_name
	order by participant_id, recom.food_group_name



	select *
	from #average_intake_by_food_groups
	order by participant_id, food_group_name

	--result 973  total: 8505
	select count(distinct(participant_id))
	from #albumin_creatinine_and_demographics_food_items
	where acr >= 30


	/*
	select 973*100/8505
	select 973*100/7766
	select 973*100/7027

	select 1156*100/7766

	select (8505+7027)/2
	*/

END
GO
