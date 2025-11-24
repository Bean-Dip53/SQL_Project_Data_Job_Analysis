/* 
Question: what are the most in-demand skills for data analyst?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for data analyst.
- Focus on all job postings.
Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providng insight into the most valuable skalls for job seekers.
*/

SELECT
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact AS job_postings
INNER JOIN skills_job_dim ON job_postings.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings.job_title_short = 'Data Analyst'
    AND job_postings.job_work_from_home = TRUE
GROUP BY
    skills_dim.skills
ORDER BY
    demand_count DESC
LIMIT 5;
