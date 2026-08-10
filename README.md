dbt + Snowflake Retail Analytics — ELT Pipeline Project

A hands-on data engineering and analytics project demonstrating a production-style ELT pipeline using dbt (data build tool) and Snowflake. Built to showcase modern data stack skills through a real transformation workflow on retail data.

What This Project Does

Processes raw retail data — sales, products, customers, and returns — through a structured Bronze → Silver → Gold layered architecture, transforming messy source data into clean, business-ready analytical models.

Key outcomes:

Clean, tested, analytics-ready data models in Snowflake
Historical change tracking via SCD Type 2 snapshots
Reusable macros eliminating repetitive SQL
Data quality enforced through automated dbt tests
Tech Stack
Tool	Purpose
dbt Core	SQL-based data transformation & modeling
Snowflake	Cloud data warehouse
Jinja	Dynamic SQL templating & macros
Python	Environment & dependency management
Architecture
Raw Source Data (Snowflake)
        ↓
   [Bronze Layer]  → Ingests raw data as-is, single source of truth
        ↓
   [Silver Layer]  → Cleans, joins, and enriches bronze data
        ↓
   [Gold Layer]    → Aggregated, de-duplicated, BI-ready models
Features

Layered Data Modeling
Three-tier Bronze/Silver/Gold architecture for scalable, maintainable transformations. Each layer has a single, well-defined responsibility.

Data Quality Testing

Built-in dbt tests: unique, not_null, accepted_values
Custom singular tests: SQL queries that must return zero rows
Custom generic tests: reusable test definitions applied across models

Slowly Changing Dimensions (SCD Type 2)
Snapshot-based historical tracking on the items table using timestamp strategy — captures every change over time, not just the current state.

Reusable Jinja Macros

multiply.sql — column multiplication macro
generate_schema.sql — dynamic schema generation per environment (dev/prod)

Seed Data
Static lookup tables loaded via dbt seed to support model joins without hardcoding values.

Centralized Source Management
All sources defined in sources.yml for clean data lineage and a single point of change.

Repository Structure
dbt_project/
├── models/
│   ├── bronze/          # Raw ingestion layer
│   ├── silver/          # Cleaning & enrichment layer
│   └── gold/            # Business-ready aggregation layer
├── macros/              # Reusable Jinja macros
├── seeds/               # Static/lookup CSV data
├── snapshots/           # SCD Type 2 historical tracking
├── tests/
│   ├── singular/        # One-off SQL tests
│   └── generic/         # Reusable test definitions
└── analyses/            # Exploratory SQL & Jinja demos
How to Run
bash
# Clone the repo
git clone https://github.com/tanayjujarao-py/dbt-snowflake-data-analytics.git
cd dbt-snowflake-data-analytics

# Install dependencies
pip install -r requirements.txt

# Configure your Snowflake profile in ~/.dbt/profiles.yml
# then navigate into the project
cd dbt_project

# Run everything in one command
dbt build

Or run steps individually:

bash
dbt seed        # Load lookup data
dbt run         # Execute all models
dbt test        # Run data quality tests
dbt snapshot    # Track historical changes
Snowflake Profile Setup

Add the following to ~/.dbt/profiles.yml:

yaml
dbt_project:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: <your_snowflake_account>
      user: <your_user>
      password: <your_password>
      role: <your_role>
      database: <your_database>
      warehouse: <your_warehouse>
      schema: <your_schema>
      threads: 1
      client_session_keep_alive: False
Prerequisites
Python 3.8+
dbt-core
dbt-snowflake
Snowflake account with read/write permissions
