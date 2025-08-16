1. Create .dbt folder in "C:\Users\<username>" for dbt first time installation
2. Create environment file
3. Create and activate environment : conda env create -f environment.yml
4. Activate env: conda activate venv_dbtlearn
5. Install dbt-snowflake ( dbt ore version not cloud): pip install dbt-snowflake==1.9.0
   1. check dbt --version
      1. It should show dbt core
6. List of pip packages in a separate file : pip freeze > requirements.txt ( please keep updated)
   1. pip install -r requirements.txt
7. Git init for keeping version control
8. Create snowflake datawarehouse and import some public dataset for AIRBNB. Refer Snowflake.md file
9. Initiate dbt project : dbt init dbtlearn
   1. Enter snowflake connection details as required\
   2. dbt debug to validate
10. Install extension: Power User for dbt
    1. Setup extension
    2. Create a packages.yml file in your project root and add dbt-utils package
11.
