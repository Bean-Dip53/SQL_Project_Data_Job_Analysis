/*
Question: what are the top skills based on salary?
- look at the average salary associated with each sill for Data Analyst positions.
- Focuses on roles with specified salaries, regarless of location.
- Why? It revels how different skills impact salary levels for Data Analyst and
    helps identify the most financially rewarding to acquire or improve
*/

SELECT
    skills_dim.skills,
    ROUND (AVG (salary_year_avg), 00) AS average_salary
FROM 
    job_postings_fact AS job_postings
INNER JOIN skills_job_dim 
    ON job_postings.job_id = skills_job_dim.job_id
INNER JOIN skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings.job_title_short = 'Data Analyst'
    AND salary_year_avg Is NOT NULL
    AND job_postings.job_work_from_home = True
GROUP BY
    skills_dim.skills
ORDER BY
    average_salary DESC
LIMIT 25

/*
Here's a breakdown of the results for top paying skills
- High demand for Big Data & ML Skills: Top salaries are commanded by analysts skiled in big data technologies (Psyspark, Couchbase), machine learning tools (DataRobot,Jupyter), and Python libraries (Panda,NumPy), reflecting the industry's high valuation processing and predictive modeling capabilities.
- Software development & Deploymnet Proficiency: Knowledge in development and development (github, Kubernetes, Airflow) Indicates a lucrative crossover between data analysis and engineering, with a premium on skills that facilitate automation and effecient data pipline managment.
- Cloud computing Expertise: Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based analystics enviornemts, suggesting that cloud proficiency boots earning potential in data analytics.

[
  {
    "skills": "pyspark",
    "average_salary": "208172"
  },
  {
    "skills": "bitbucket",
    "average_salary": "189155"
  },
  {
    "skills": "couchbase",
    "average_salary": "160515"
  },
  {
    "skills": "watson",
    "average_salary": "160515"
  },
  {
    "skills": "datarobot",
    "average_salary": "155486"
  },
  {
    "skills": "gitlab",
    "average_salary": "154500"
  },
  {
    "skills": "swift",
    "average_salary": "153750"
  },
  {
    "skills": "jupyter",
    "average_salary": "152777"
  },
  {
    "skills": "pandas",
    "average_salary": "151821"
  },
  {
    "skills": "elasticsearch",
    "average_salary": "145000"
  },
  {
    "skills": "golang",
    "average_salary": "145000"
  },
  {
    "skills": "numpy",
    "average_salary": "143513"
  },
  {
    "skills": "databricks",
    "average_salary": "141907"
  },
  {
    "skills": "linux",
    "average_salary": "136508"
  },
  {
    "skills": "kubernetes",
    "average_salary": "132500"
  },
  {
    "skills": "atlassian",
    "average_salary": "131162"
  },
  {
    "skills": "twilio",
    "average_salary": "127000"
  },
  {
    "skills": "airflow",
    "average_salary": "126103"
  },
  {
    "skills": "scikit-learn",
    "average_salary": "125781"
  },
  {
    "skills": "jenkins",
    "average_salary": "125436"
  },
  {
    "skills": "notion",
    "average_salary": "125000"
  },
  {
    "skills": "scala",
    "average_salary": "124903"
  },
  {
    "skills": "postgresql",
    "average_salary": "123879"
  },
  {
    "skills": "gcp",
    "average_salary": "122500"
  },
  {
    "skills": "microstrategy",
    "average_salary": "121619"
  }
]
*/