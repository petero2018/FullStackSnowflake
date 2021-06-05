#!/bin/bash

ARG PYTHON_VERSION=3.8.5
FROM python:$PYTHON_VERSION

ARG DBT_VERSION=0.17.2
ARG dbt_project_name=demo_dbt

ARG SNOWFLAKE_USER_NAME
ARG SNOWFLAKE_PASSWORD
ARG SNOWFLAKE_AWS_ACCESS_KEY_ID
ARG SNOWFLAKE_AWS_SECRET_ACCESS_KEY

# Update and install system packages
RUN apt-get update -y && \
  apt-get install --no-install-recommends -y -q \
  git sudo vim libpq-dev python-dev python3-pip python3 python3-venv && \
  apt-get clean && \
  apt-get remove python-cffi && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create and activate env & install dependencies, DBT and initiate a DBT project
RUN python3 -m venv dbt-env          
RUN . dbt-env/bin/activate && \
  pip install --upgrade pip && \
  pip install --upgrade cffi && \
  pip install cryptography~=3.4 && \
  pip install dbt==$DBT_VERSION && \    
  dbt init $dbt_project_name && \
  rm -r $dbt_project_name/models/example

COPY profiles.yml root/.dbt/profiles.yml
COPY dbt_project.yml /$dbt_project_name/dbt_project.yml
COPY models/ /$dbt_project_name/models
COPY macros/ /$dbt_project_name/macros

ENV SNOWFLAKE_AWS_ACCESS_KEY_ID=$SNOWFLAKE_AWS_ACCESS_KEY_ID
ENV SNOWFLAKE_AWS_SECRET_ACCESS_KEY=$SNOWFLAKE_AWS_SECRET_ACCESS_KEY
ENV SNOWFLAKE_USER_NAME=$SNOWFLAKE_USER_NAME
ENV SNOWFLAKE_PASSWORD=$SNOWFLAKE_PASSWORD