# 🏗️ dbt + Snowflake Retail Analytics — ELT Pipeline Project

![dbt](https://img.shields.io/badge/dbt-FF694B?style=for-the-badge&logo=dbt&logoColor=white)
![Snowflake](https://img.shields.io/badge/Snowflake-29B5E8?style=for-the-badge&logo=snowflake&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=postgresql&logoColor=white)

A hands-on data engineering and analytics project demonstrating a **production-style ELT pipeline** using dbt (data build tool) and Snowflake. Built to showcase modern data stack skills through a real transformation workflow on retail data — including sales, products, customers, and returns.

---

## 📌 Key Outcomes

- ✅ Clean, tested, analytics-ready data models in Snowflake
- ✅ Historical change tracking via **SCD Type 2 snapshots**
- ✅ Reusable **Jinja macros** eliminating repetitive SQL
- ✅ Data quality enforced through **automated dbt tests**
- ✅ Layered **Bronze → Silver → Gold** architecture

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| **dbt Core** | SQL-based data transformation & modeling |
| **Snowflake** | Cloud data warehouse |
| **Jinja** | Dynamic SQL templating & macros |
| **Python** | Environment & dependency management |

---

## 🏛️ Architecture

```
┌─────────────────────────────────────┐
│        Raw Source Data              │
│  (Snowflake — sales, products,      │
│   customers, returns)               │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│          🥉 Bronze Layer            │
│  Ingests raw data as-is             │
│  Single source of truth             │
│  Example: bronze_sales.sql          │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│          🥈 Silver Layer            │
│  Cleans, joins & enriches data      │
│  Handles nulls, type casting,       │
│  deduplication                      │
│  Example: silver_salesinfo.sql      │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│          🥇 Gold Layer              │
│  Aggregated, BI-ready models        │
│  Final output for dashboards        │
│  Example: source_gold_items.sql     │
└─────────────────────────────────────┘
```

---

## ✨ Features

### 🗂️ Layered Data Modeling
Three-tier **Bronze / Silver / Gold** architecture for scalable, maintainable transformations. Each layer has a single, well-defined responsibility — making the pipeline easy to debug, extend, and understand.

### 🧪 Data Quality Testing
Automated tests run at every layer to ensure data integrity:
- **Built-in dbt tests** — `unique`, `not_null`, `accepted_values`
- **Singular tests** — custom SQL queries that must return zero rows to pass (e.g., `non_negative_test.sql`)
- **Generic tests** — reusable test definitions applied across multiple models (e.g., `generic_non_negative.sql`)

### 📸 Slowly Changing Dimensions (SCD Type 2)
Uses **dbt snapshots** to track historical changes in the items table using a timestamp-based strategy — capturing every version of a record over time, not just the latest state.

### ⚙️ Reusable Jinja Macros
Custom macros to keep SQL DRY (Don't Repeat Yourself):
- `multiply.sql` — multiplies two columns dynamically
- `generate_schema.sql` — generates schema names based on target environment (dev/prod)

### 🌱 Seed Data
Static lookup tables loaded via `dbt seed` — supporting model joins without hardcoding values directly in SQL.

### 🔗 Centralized Source Management
All raw data sources defined in a single `sources.yml` file for clean **data lineage**, easier maintenance, and a single point of change.

---

## 📁 Repository Structure

```
dbt-snowflake-data-analytics/
│
├── dbt_project/
│   ├── models/
│   │   ├── bronze/              # 🥉 Raw ingestion layer
│   │   │   └── bronze_sales.sql
│   │   ├── silver/              # 🥈 Cleaning & enrichment layer
│   │   │   └── silver_salesinfo.sql
│   │   ├── gold/                # 🥇 Business-ready aggregation layer
│   │   │   └── source_gold_items.sql
│   │   └── source/
│   │       └── sources.yml      # Centralized source definitions
│   │
│   ├── macros/                  # ⚙️ Reusable Jinja macros
│   │   ├── multiply.sql
│   │   └── generate_schema.sql
│   │
│   ├── seeds/                   # 🌱 Static lookup data
│   │   └── lookup.csv
│   │
│   ├── snapshots/               # 📸 SCD Type 2 tracking
│   │   └── gold_items.yml
│   │
│   ├── tests/                   # 🧪 Data quality tests
│   │   ├── non_negative_test.sql
│   │   └── generic/
│   │       └── generic_non_negative.sql
│   │
│   ├── analyses/                # 🔍 Exploratory SQL & Jinja demos
│   └── dbt_project.yml
│
├── requirements.txt
└── README.md
```

---

## 🚀 How to Run

### 1. Clone the Repository
```bash
git clone https://github.com/tanayjujarao-py/dbt-snowflake-data-analytics.git
cd dbt-snowflake-data-analytics
```

### 2. Install Dependencies
```bash
pip install -r requirements.txt
```

### 3. Configure Snowflake Profile
Create or update `~/.dbt/profiles.yml`:

```yaml
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
```

### 4. Run the Project

**Run everything in one command:**
```bash
cd dbt_project
dbt build
```

**Or run steps individually:**
```bash
dbt seed        # 🌱 Load static lookup data into Snowflake
dbt run         # ⚙️  Execute all transformation models
dbt test        # 🧪 Run all data quality tests
dbt snapshot    # 📸 Track historical changes via SCD Type 2
```

---

## 📋 Prerequisites

- Python 3.8+
- `dbt-core`
- `dbt-snowflake`
- A Snowflake account with read/write permissions on your target database

---

## 💡 What I Learned

- Designing a **layered ELT architecture** (Bronze/Silver/Gold) for maintainable data pipelines
- Writing **modular, reusable SQL** using Jinja templating and dbt macros
- Implementing **SCD Type 2** with dbt snapshots for historical data tracking
- Enforcing **data quality** at scale using dbt's built-in and custom test framework
- Managing **multi-environment deployments** with dynamic schema generation

---

## 🔗 Connect

[![Portfolio](https://img.shields.io/badge/Portfolio-000000?style=for-the-badge&logo=github&logoColor=white)](https://tanayjujarao-py.github.io/)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/tanay-jujarao-8499a8255)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/tanayjujarao-py)
