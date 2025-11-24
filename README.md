/* ADD graphs*/ 
# Introduction
Dive into the data job market: Focusing on data analyst roles, this project explores top-paying jobs, in-demand skills, and where high demand meets high salary in data analytics

SQL quries? check them out here: [project_sql folder](/project_sql/)

# Background
Driven by a quest to navigate the data analyst job market more effectivly, this was born from a desire to pinpoint top-paid and in-deand skills, streamlining others workr to find optimal jobs.

Data hails from [SQL Course](https//lukebarousse.com/sql) it's packed with insihgts on job titles, salaries, locations and essentail skills.

## The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst job?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts 
4. which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL** The back bone of my analysis, allowing me to query the database and unearthcritical insights.
- **PostgreSQL** The chosen database managment system, ideal for handling the job posting data
- **Visual Studio Code** My go-to for database management and executing SQL queries
- **Git & GitHub** Essentail for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking
# The Analysis
Each query fro this project aimed at investigating specific aspects of the data analyst job market.
Here's how i approached each question

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the fields. 

``` sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    company_dim.name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
Where 
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL 
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```

![Top Paying Roles](Assets/1_top_paying_roles.png)

*Bar graph visualizing the salary fro the top 10 salaries for data analysts; ChastGPT generated this graph from my SQL results*

Here's a breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range** top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potnetial in the field
- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a hihg diversity in job titles, from Data analyst to director of Analyst, reflecting varied roles and specializations within data analytics.

### 2. Skills for Top Paying Jobs
To undertand what skills are required for the top_paying jobs, I joined postings with the skills data, providing insights into what employers value for high-compensation roles.
```sql
WITH top_paying_jobs AS (
SELECT
    job_id,
    job_title,
    salary_year_avg,
    company_dim.name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
Where 
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL 
ORDER BY
    salary_year_avg DESC
LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills_dim.skills AS skill_name
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    top_paying_jobs.salary_year_avg DESC;
```

![Top Paying Skills](Assets/2_top_roles_skills.png)

*Bar graph visualizing the count of skills for the top 10 paying jobs for data analysts; ChatGPT generated this graph from my SQL results*

Here's the breakdown of the most demanded skills fro the top 10 highest paying data analyst jobs in 2023:
- **SQL** is leading with a bold count of 8.
- **Python** follows closely with a bold count 7.
- **Tableau** is also highly sought after, with a bold count of 6.
other skills like **R**, **Snowflake**, **Panda**, and **Excel** show varying degrees of demand.

### 3. In-demand Skills for Data Analysts

This Query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
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
```

| Skills   | Demand Count |
|----------|--------------|
| SQL      | 7291         |
| Excel    | 4611         |
| Python   | 4330         |
| Tableau  | 3745         |
| Power BI | 2609         |

Here's the breakdown of the most edmanded skills for data analysts in 2023
- **SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- **programming** and **Visualization Tools** like **Python**, **Tableau**, and **Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

*Table of demand for the top 5 skills in data analyst job postings*

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed with skills are the highest paying.

```sql
SELECT
    skills_dim.skills,
    ROUND (AVG (salary_year_avg), 00) AS average_salary
FROM job_postings_fact AS job_postings
INNER JOIN skills_job_dim ON job_postings.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings.job_title_short = 'Data Analyst'
    AND salary_year_avg Is NOT NULL
    AND job_postings.job_work_from_home = True
GROUP BY
    skills_dim.skills
ORDER BY
    average_salary DESC
LIMIT 25;
```

| Skills        |Average Salary ($)  |
|---------------|-------------------:|
| PySpark       |             208,172|
| Bitbucket     |             189,155|
| Couchbase     |             160,515|
| Watson        |             160,515|
| DataRobot     |             155,486|
| Gitlab        |             154,500|
| Swift         |             153,750|
| Jupyter       |             152,777|
| Pandas        |             151,821|
| Elasticserch  |             145,000|

*Table of the average salary for the top 10 paying skills fro data analysts*

Here's a breakdown of the results fro top paying skills for Data Analysts:
- **High deamnd fro Big Data & ML Skills:** Top salaries are commanded by analysts skilled in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy), reflecting the industry's high valuation of data processing and predictive modeling capabilities.
- **Software Development & Deployment Proficiency:** Knowledge in development and deployment tools (GitLab, Kubernetes, Airflow) indicates a lucrative crossover between data analysis and engineering, with a premium on skills that facilitate automation and efficient data pipline management.
- **Cloud ComputingExpertise:** Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing imprtance of cloud-based analytics environments, suggesting that cloud proficiency significantly boosts earning potential in data analystis.

### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salraries, offering a strategic focus fro skill development.

```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

| Skill ID | Skills     | Demand Count | Average Salary ($) |
|----------|------------|--------------|-------------------:|
| 8        | GO         | 27           |             115,320|
| 234      | Confluence | 11           |             114,210|
| 97       | Hadoop     | 22           |             113,193|
| 80       | SnowFlake  | 37           |             112,948|
| 74       | Azure      | 34           |             111,225|
| 77       | BigQuery   | 13           |             109,654|
| 76       | AWS        | 32           |             108,317|
| 4        | Java       | 17           |             106,906|
| 194      | SSIS       | 12           |             106,683|
| 233      | Jira       | 20           |             104,918|

*Table of the most optimal skills fro data analyst srted by salary*

Here's a breakdown of the most optimal skills for Data Analysts in 2023:
- **High-Demand Programming Languages:** Python and R stand out fro their high demand, with demand counts of 236 and 148 respectively. Despite their high demand, their average salaries are around $101,397 fro Python and $100,499 fro R, indicating that proficiency in these languages is highley valued but also widely available.
- **Cloud Tools and Techologies:** Skills in specialized technologies such as Snowflake, Azure, AWS and BigQuery show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis
- **Business Intelligence and Visualization Tools:** Tableau and Looker, with demand counts of 230 and 49 respectively, and waverage salaries around $99,288 and $103,795, highlight the critical role of data visualization and business intelligence in deriving actionable insights from data.
- **Database Technologies:** The demand fro skills in traditional and NoSQL database (Oracel, SQL Server, NoSQL) with average salaries ranging from $97,786 to $104,534, reflects the enduring need for data storage, retriveal, and management expertise.

# What I Learned

Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- **Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH caluses for ninja-level temp table maneuvers.
- **Data Aggregation:** Got Cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- **Analytical Wizardry:** leveled up my real-world puzzle-solving skills, turing questions into actionable, insihgt SQL queries.

# Conclusion

### Insights
From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs fro data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills fro Top-paying JObs**: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it's a critical skill for earning a top salary.
3. **Most In-demand Skills**: SQL is also the most demanded skill in the data analyst job market, ths making it essential for job seekrs.
4. **Skills with Higher salaries**: Specialized skills, such as SVN and Solidity, are associtaedwith the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: SQL Leads in demand and offers for a high avergae salary, positioning it as one of the most optimal skills fro data analysts to learn to maximize their market value.

### Closing Thoughts 

This project enhanced my SQL skills and Provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exporlation highlights the importance to of continous learning and adaptation to emerging trends in the field of data analytics.
