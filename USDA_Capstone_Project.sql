-- 1. Return the food groups with average nutrition value of fat being more than 15g?
SELECT fd_group.fdgrp_cd, fddrp_desc, tagname, nutrdesc, 
       AVG(nutr_val) AS avg_nutrition, units
FROM fd_group
JOIN food_des
USING(fdgrp_cd)
JOIN nut_data
USING(ndb_no)
JOIN nutr_def
USING(nutr_no)
GROUP BY fd_group.fdgrp_cd, fddrp_desc,tagname, nutrdesc, units
HAVING AVG(nutr_val) > 15 AND tagname = 'FAT';

/* 2. Which food item manufacturer has the highest median nutrition value of sugar? Return the manufacturer’s name 
and the median nutrition value of sugar. */

SELECT manufacname, tagname, PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY nutr_val) 
       AS Median_nut_val
FROM food_des
JOIN nut_data
USING (ndb_no)
JOIN nutr_def
USING(nutr_no)
GROUP BY manufacname, tagname
HAVING tagname = 'SUGAR'
ORDER BY Median_nut_val DESC
LIMIT 1;

-- 3. Which year was the most number of nutrition value of caffeine published?

SELECT year, COUNT(nutr_val) AS nut_val_caffeine, nutrdesc AS nut_desc_caffeine
FROM nut_data 
JOIN nutr_def
USING (nutr_no)
JOIN datsrcln
USING(nutr_no)
JOIN data_src
USING(datasrc_id)
GROUP BY year, nutrdesc
HAVING nutrdesc = 'Caffeine'
ORDER BY COUNT(nutr_val) DESC
LIMIT 1;

/* 4. Find the nutrient(s) and food item(s) whose publications have the highest number of pages. Return the food description, 
nutrient description, author, title, year of publication, and number of pages*/

SELECT long_desc, nutrdesc, authors, title, year, COUNT(end_page) AS num_of_pages 
FROM food_des
JOIN nut_data
USING(ndb_no)
JOIN nutr_def
USING (nutr_no)
JOIN datsrcln
USING(nutr_no)
JOIN data_src
USING(datasrc_id)
GROUP BY long_desc, nutrdesc, authors, title, year
ORDER BY num_of_pages DESC;

/* 5. Which type of data was mostly used in finding nutrition value? Return the data type and the number of times it was used.*/

SELECT deriv_cd, COUNT(nutr_val) AS data_typ_no
FROM nut_data
GROUP BY deriv_cd
ORDER BY data_typ_no DESC
LIMIT 1;

/* 6. Which nutrient has the highest total number of studies? Return the nutrient’s tagname, description and 
total number of studies.*/
SELECT tagname, nutrdesc, SUM(num_studies) AS total_num_studies
FROM nutr_def
JOIN nut_data
USING(nutr_no)
WHERE num_studies IS NOT Null
GROUP BY tagname, nutrdesc
ORDER BY total_num_studies DESC
LIMIT 1;

-- 7. Find the top 10 food groups with the highest average protein factor?

SELECT fg.fdgrp_cd, fddrp_desc, ROUND(AVG(pro_factor):: numeric, 2)
       AS Average_pro_factor
FROM fd_group AS fg
JOIN food_des AS fd
USING(fdgrp_cd)
WHERE pro_factor IS NOT NULL
GROUP BY fg.fdgrp_cd, fddrp_desc
ORDER BY Average_pro_factor DESC
LIMIT 10;

/* 8. Find the food item with the highest percentage of refuse. Return the food name, group, percentage of refuse and 
refuse description.*/

SELECT fdg.fdgrp_cd, fddrp_desc, ref_desc, SUM(refuse) AS percentage_refuse 
FROM fd_group AS fdg
JOIN food_des AS fds
USING (fdgrp_cd)
WHERE refuse IS NOT NULL
GROUP BY fdg.fdgrp_cd, fddrp_desc, ref_desc
ORDER BY percentage_refuse DESC
LIMIT 1;

/* 9. Which data derivation method has the lowest average standard error greater than 0? Return the derivation method 
and its average standard error. */

SELECT deriv_cd, ROUND(AVG(std_error):: numeric, 2) AS avg_std_error
FROM nut_data 
GROUP BY deriv_cd
HAVING AVG(std_error) > 0
ORDER BY avg_std_error ASC
LIMIT 1;

/* 10. Which food group has the highest number of food items that do not have scientific names? Return the group name 
and number of food items without scientific name.*/

SELECT fdg.fdgrp_cd, fddrp_desc, COUNT(sciname) AS Food_no_sci_name
FROM fd_group AS fdg
JOIN food_des AS fds
USING (fdgrp_cd)
WHERE sciname = ''
GROUP BY fdg.fdgrp_cd, fddrp_desc
ORDER BY Food_no_sci_name DESC
LIMIT 1;

-- 11. Find the second top 10 food items with the highest gram per cup. Consider only food items which have cup as a measure.

SELECT fdg.fdgrp_cd, fddrp_desc, msre_desc AS measure, SUM(gm_wgt) AS gram
FROM fd_group AS fdg
JOIN food_des AS fds
USING(fdgrp_cd)
JOIN weight AS wg
USING (ndb_no)
WHERE msre_desc = 'cup' AND fddrp_desc IN ('Fats and Oils')
GROUP BY fdg.fdgrp_cd, fddrp_desc, msre_desc
ORDER BY gram DESC
LIMIT 10;

-- 12. Find the top 3 food groups with the lowest average Carbohydrate factor?

SELECT fg.fdgrp_cd, fddrp_desc, ROUND(AVG(cho_factor):: numeric, 2)
       AS Avg_cho_factor
FROM fd_group AS fg
JOIN food_des AS fd
USING(fdgrp_cd)
WHERE cho_factor IS NOT NULL
GROUP BY fg.fdgrp_cd, fddrp_desc
ORDER BY Avg_cho_factor ASC
LIMIT 3;



