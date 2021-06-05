This is to create storage integration between Snowlfake and an S3 bucket.
The process can be done in two steps because Snowflake s3 integration needs an existing role and bucket and the role needs cross account access.
In order to create the role you will need snowflake_iam_user and aws_external_id which you get once the integration is created in Snowlflake.
Therefore, here are the steps to fllow:

0) You need to create a remote storage for terraform state and lock it.
To do that, initialise terraform in 0_remote_resources and apply.

OPTION 1 - set up S3 ingestion with S3 integration

1) You need to initialise terraform in 1_snowflake_integration and apply.
This will create the bucket and a generic role for cross account access.

Once done, you need to set up the Snowflake integration.
To do that, execute the snowlfake.sql scripts on your Snowflake account.
This will create the integration between Snowflake and your bucket. Please note that only account admin can create such integration in Snowflake.
Finally, take a note of the snowflake_iam_user and aws_external_id for the next step.

2) You need to submit your snowflake_iam_user and aws_external_id as variables to 2_provision_infra.
You can do that by e.g. adding the entries to terraform.tfvars. For var templates use the terraform.tfvars.backup file.
You need to initialise terraform in 2_provision_infra and apply.

You now can create external stage or directly point Snowlfake commands to your S3 bucket.
For example, please follow snowflake-s3.sql.

OPTON 2 - set up S3 ingestion with dbt

3)
Set snowflake username & password and AWS credentials as argument for the docker build:

docker build \
-t python/dbt \
--build-arg SNOWFLAKE_AWS_ACCESS_KEY_ID=KeyIDHere \
--build-arg SNOWFLAKE_AWS_SECRET_ACCESS_KEY=SecretKeyHere \
--build-arg SNOWFLAKE_USER_NAME=userNameHere \
--build-arg SNOWFLAKE_PASSWORD=P4S5wordher3 \
--no-cache .

optionally you can set python and DBT version for your container:

...
--build-arg PYTHON_VERSION=yourPythonversionHere
--build-arg DBT_VERSION=yourDBTversionHere
...

To start and enter into the container run the following:
docker run -it python/dbt bin/bash

Also it's recommended to activate your venv in the container if you want to interact with Python and DBT:
. dbt-env/bin/activate