/*
Question: what are the most optimal skills to learn (aka its in high demand and a high-paying skill?)
- Identify skills in high demand and associated with high average salaries for Data Analyst roles.
- Conncentrate on remote positions with specified salaries.
- Why? Targets skills that  offer job security (high demand) and financial beefits (high salaries),
    Offering strategic insight fro carrer development in data analysis.
*/

--put this into a CTE 
SELECT
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM 
    job_postings_fact AS job_postings
INNER JOIN skills_job_dim 
    ON job_postings.job_id = skills_job_dim.job_id
INNER JOIN skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings.job_title_short = 'Data Analyst' AND
    job_postings.job_work_from_home = TRUE
GROUP BY
    skills_dim.skills
ORDER BY
    demand_count DESC
LIMIT 5
