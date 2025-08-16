Snowflake user creation
Copy these SQL statements into a Snowflake Worksheet, select all and execute them (i.e. pressing the play button).

If you see a Grant partially executed: privileges [REFERENCE_USAGE] not granted. message when you execute GRANT ALL ON DATABASE AIRBNB to ROLE transform, that's just an info message and you can ignore it.

-- Use an admin role
USE ROLE ACCOUNTADMIN;

-- Create the `transform` role
CREATE ROLE IF NOT EXISTS TRANSFORM;
GRANT ROLE TRANSFORM TO ROLE ACCOUNTADMIN;

-- Create the default warehouse if necessary
CREATE WAREHOUSE IF NOT EXISTS COMPUTE_WH;
GRANT OPERATE ON WAREHOUSE COMPUTE_WH TO ROLE TRANSFORM;

-- Create the `dbt` user and assign to role
CREATE USER IF NOT EXISTS dbt
PASSWORD='dbtPassword123'
LOGIN_NAME='dbt'
MUST_CHANGE_PASSWORD=FALSE
DEFAULT_WAREHOUSE='COMPUTE_WH'
DEFAULT_ROLE=TRANSFORM
DEFAULT_NAMESPACE='AIRBNB.RAW'
COMMENT='DBT user used for data transformation';
ALTER USER dbt SET TYPE = LEGACY_SERVICE;
GRANT ROLE TRANSFORM to USER dbt;

-- Create our database and schemas
CREATE DATABASE IF NOT EXISTS AIRBNB;
CREATE SCHEMA IF NOT EXISTS AIRBNB.RAW;

-- Set up permissions to role `transform`
GRANT ALL ON WAREHOUSE COMPUTE_WH TO ROLE TRANSFORM;
GRANT ALL ON DATABASE AIRBNB to ROLE TRANSFORM;
GRANT ALL ON ALL SCHEMAS IN DATABASE AIRBNB to ROLE TRANSFORM;
GRANT ALL ON FUTURE SCHEMAS IN DATABASE AIRBNB to ROLE TRANSFORM;
GRANT ALL ON ALL TABLES IN SCHEMA AIRBNB.RAW to ROLE TRANSFORM;
GRANT ALL ON FUTURE TABLES IN SCHEMA AIRBNB.RAW to ROLE TRANSFORM;

Snowflake data import
Copy these SQL statements into a Snowflake Worksheet, select all and execute them (i.e. pressing the play button).

-- Set up the defaults
USE WAREHOUSE COMPUTE_WH;
USE DATABASE airbnb;
USE SCHEMA RAW;

-- Create our three tables and import the data from S3
CREATE OR REPLACE TABLE raw_listings
(id integer,
listing_url string,
name string,
room_type string,
minimum_nights integer,
host_id integer,
price string,
created_at datetime,
updated_at datetime);

COPY INTO raw_listings (id,
listing_url,
name,
room_type,
minimum_nights,
host_id,
price,
created_at,
updated_at)
from 's3://dbtlearn/listings.csv'
FILE_FORMAT = (type = 'CSV' skip_header = 1
FIELD_OPTIONALLY_ENCLOSED_BY = '"');

CREATE OR REPLACE TABLE raw_reviews
(listing_id integer,
date datetime,
reviewer_name string,
comments string,
sentiment string);

COPY INTO raw_reviews (listing_id, date, reviewer_name, comments, sentiment)
from 's3://dbtlearn/reviews.csv'
FILE_FORMAT = (type = 'CSV' skip_header = 1
FIELD_OPTIONALLY_ENCLOSED_BY = '"');

CREATE OR REPLACE TABLE raw_hosts
(id integer,
name string,
is_superhost string,
created_at datetime,
updated_at datetime);

COPY INTO raw_hosts (id, name, is_superhost, created_at, updated_at)
from 's3://dbtlearn/hosts.csv'
FILE_FORMAT = (type = 'CSV' skip_header = 1
FIELD_OPTIONALLY_ENCLOSED_BY = '"');

snowflake -dbt connections
Enter a number: 1
account (https://<this_value>.snowflakecomputing.com): GSIIRUE-FT69783
user (dev username): dbt
[1] password
[2] keypair
[3] sso
Desired authentication type option (enter a number): 1
password (dev password):
role (dev role): TRANSFORM
warehouse (warehouse name): COMPUTE_WH
database (default database that dbt will build objects in): AIRBNB
schema (default schema that dbt will build objects in): DEV
threads (1 or more) [1]: 1
