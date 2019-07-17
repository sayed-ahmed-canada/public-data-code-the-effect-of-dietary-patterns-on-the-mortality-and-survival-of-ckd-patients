USE [mrp_2015_2016_diet_esrd_mortality]
GO
/****** Object:  StoredProcedure [dbo].[new_assign_group_subgroup_to_food_items]    Script Date: 2019-07-03 11:40:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[new_assign_group_subgroup_to_food_items]
AS
BEGIN

    -- this is not used any more and not useful at all
	truncate table map_food_to_groups_sub_groups

	insert into map_food_to_groups_sub_groups (usda_food_code, food_name)
	SELECT cast([DRXFDCD] as int), cast([DRXFCSD] as varchar)
	from [2015-2016-support-food-codes-DRXFCD_I]

	select * 
	from map_food_to_groups_sub_groups

	-- if food name has vegetable in it, assign group id = 1 = vegetables

	select * 
	from map_food_to_groups_sub_groups
	where food_name like 'vegetable%'
	
	update map_food_to_groups_sub_groups
	set group_id = 1
	where food_name like 'vegetable%'


	select * 
	from map_food_to_groups_sub_groups
	where food_name like 'bean%'
	
	update map_food_to_groups_sub_groups
	set group_id = 1, sub_group_id=8
	where food_name like 'bean%'




	-- if food name has chicken, turkey in it, assign group id = 5 = protein
	select * 
	from map_food_to_groups_sub_groups
	where food_name like '%chicken%'
	or food_name like '%turkey%'

	
	update map_food_to_groups_sub_groups
	set group_id = 5
	where food_name like '%chicken%'
	or food_name like '%turkey%'
	or food_name like 'beef%'





	-- if food name has grain bread,  in it, assign group id = 3 = total grain
	select * 
	from map_food_to_groups_sub_groups
	where food_name like '%grain%'
	or food_name like '%bread%'

	
	update map_food_to_groups_sub_groups
	set group_id = 3
	where food_name like '%grain%'
	or food_name like '%bread%'


	-- if food name has MILK Dairy,  in it, assign group id = 4 = dairy
	select * 
	from map_food_to_groups_sub_groups
	where food_name like '%milk%'
	or food_name like '%dairy%'

	
	update map_food_to_groups_sub_groups
	set group_id = 4
	where food_name like '%milk%'
	or food_name like '%dairy%'


	-- assign 100 for others
	select * from map_food_to_groups_sub_groups
	where group_id = 100

	update map_food_to_groups_sub_groups
	set group_id = 14
	where group_id = 100




END
GO
