/* get corresponding skill and skill type for each job posting in q1
    - Includes those without any skills, too
    -WHY? look at the skills and they type for each job in the first quarter that has a salary> $70,000
*/

SELECT
    job_postings.job_title_short,
    skills.skills,
    skills.type
FROM 
    job_postings_fact AS job_postings
LEFT JOIN 
    skills_job_dim AS skill_job ON
    job_postings.job_id = skill_job.job_id
LEFT JOIN
    skills_dim AS skills ON
    skill_job.skill_id = skills.skill_id
WHERE
    job_posted_date BETWEEN '2023-01-01' AND '2023-03-31' AND
    salary_year_avg > 70000

UNION ALL

SELECT
    job_postings.job_title_short,
    skills.skills,
    skills.type
FROM 
    job_postings_fact AS job_postings
LEFT JOIN 
    skills_job_dim AS skill_job ON
    job_postings.job_id = skill_job.job_id
LEFT JOIN
    skills_dim AS skills ON
    skill_job.skill_id = skills.skill_id
WHERE 
    job_posted_date BETWEEN '2023-01-01' AND '2023-03-31' AND
    salary_year_avg > 70000 AND
    skills.skills IS NULL 
