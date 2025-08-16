1. Create environment file
2. Create and activate environment : conda env create -f environment.yml
3. Activate env: conda activate venv_dbtlearn
4. Install dbt-snowflake ( dbt ore version not cloud): pip install dbt-snowflake==1.9.0
   1. check dbt --version
      1. It should show dbt core
5. List of pip packages in a separate file : pip freeze > requirements.txt ( please keep updated)
   1. pip install -r requirements.txt
6. Git init for keeping version control
7. Create snowflake datawarehouse and import some public dataset for AIRBNB. Refer Snowflake.md file
8. Initiate dbt project : dbt init dbtlearn
   1. Enter snowflake connection details as required\
   2. dbt debug to validate
