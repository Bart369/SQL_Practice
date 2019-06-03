SELECT
    `employee`.`id` AS employee_id, 
    CONCAT(`employee`.`first_name`, ' ', `employee`.`last_name`) AS employee_full_name, 
    `department`.`id` AS department_id, 
    `department`.`name` AS last_department_name
FROM `sample_staff`.`employee` 
/* Do not shorten table name aliases SO I left this simply as employee 
    Also sample_staff is the name of the database. */

INNER JOIN ( /* Subquery starts in the next line */
    SELECT
        `department_employee_rel`.`employee_id`, 
        MAX(`department_employee_rel`.`id`) AS max_id
    FROM department_employee_rel 
    WHERE 1=1 /* Use 1=1  */
        AND `department_employee_rel`.`deleted_flag` = 0
    GROUP BY `department_employee_rel`.`employee_id` 
    ) 
    AS department_employee_rel_max ON `department_employee_rel_max`.`employee_id` = `employee`.`id` 
-- Space between Multiple Joins
INNER JOIN department_employee_rel ON 1=1
    AND `department_employee_rel`.`id` = `department_employee_rel_max`.`max_id`  /* Abusing AND because it's awesome */
    AND `department_employee_rel`.`deleted_flag` = 0 

INNER JOIN department ON 1=1 
    AND `department`.`id` = `department_employee_rel`.`department_id`
    AND `department`.`deleted_flag` = 0
WHERE 1=1
    AND `employee`.`id` IN(10010, 10040, 10050, 91050, 205357) 
    AND `employee`.`deleted_flag` = 0
LIMIT 100; 