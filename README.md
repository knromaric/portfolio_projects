# Data & Analytics Portfolio — Romaric Nzekeng

A collection of hands-on data projects spanning the full analytics stack — from raw data to governed data warehouses to executive dashboards. Each project was built independently to develop and demonstrate practical skills in SQL, Python, dbt, Databricks, and Power BI, applied to realistic business scenarios (e-commerce, supply chain, retail, customer analytics).

**Background:** IT Business Analyst with certifications in Scrum (PSM I, PSPO I), Power BI, Lean Six Sigma Black Belt, and the Databricks Certified Data Engineer Associate. These projects reflect a deliberate move to pair business analysis skills with hands-on data engineering — not just gathering requirements for a data pipeline, but building one.

GitHub: [github.com/knromaric](https://github.com/knromaric)

---

## Projects

| # | Project | Focus | Stack |
|---|---|---|---|
| 1 | [SQL Data Warehouse Project](./sql-data-warehouse-project) | Medallion-architecture warehouse, built with T-SQL alone | SQL Server, T-SQL, star schema |
| 2 | [E-commerce Data Warehouse](./eshop_dwh_analytics) | dbt + Databricks warehouse with dual-grain facts & SCD Type 2 | dbt, Databricks, Unity Catalog, GitHub Actions CI/CD |
| 3 | [Supply Chain Analytics Platform](./supply_chain_dwh_analytics) | Multi-source warehouse feeding an executive dashboard | dbt, Databricks, Power BI |
| 4 | [Customer Shopping Behavior Analysis](./customer_analysis_python_sql_powerBI) | End-to-end analysis: Python cleaning → SQL → BI dashboard | Python, SQL Server, Power BI |

---

### 1. SQL Data Warehouse Project

A data warehouse built with **plain T-SQL**, no external transformation tool — the goal was to prove out the medallion architecture (Bronze → Silver → Gold) using nothing but SQL Server: stored procedures for ETL, a star schema in Gold, and a full suite of data quality tests (null/duplicate key checks, referential integrity, business-rule validation) written by hand.

**What it demonstrates:** ETL logic and data quality testing without relying on a transformation framework — understanding what tools like dbt automate under the hood.

📁 [`/sql-data-warehouse-project`](./sql-data-warehouse-project)

---

### 2. E-commerce Data Warehouse (dbt + Databricks)

A governed e-commerce warehouse solving a concrete problem: one source of truth to answer "what's our revenue," "what sells best," and "who are our best customers." Built with **dbt on Databricks**, following the medallion architecture, with two fact tables at different grains (order-level and order-line-level) chosen deliberately for the different questions each answers, a Type 2 slowly changing dimension for customer history, and automated dev/prod deployment via **Databricks Asset Bundles + GitHub Actions**.

**What it demonstrates:** dimensional modeling (grain selection), incremental processing, SCD handling, and infrastructure-as-code deployment with CI/CD — the production-grade version of what the SQL-only project sketches out manually.

📁 [`/eshop_dwh_analytics`](./eshop_dwh_analytics)

---

### 3. Supply Chain Analytics Platform (dbt + Databricks + Power BI)

A warehouse consolidating seven fragmented operational feeds (suppliers, purchase orders, logistics, production, inventory, sales forecasts, calendar) into a single star schema, with real business KPIs — forecast accuracy and bias, delivery lead time and delay, inventory reorder status — computed in SQL rather than left to the BI layer. Surfaced through a **Power BI executive dashboard** with SKU/year/supplier filters, KPI cards, trend lines, and a supplier scorecard.

**What it demonstrates:** consolidating a genuinely multi-source domain, deriving business logic in the warehouse layer, and connecting a governed data model directly to a decision-making tool for non-technical stakeholders.

📁 [`/supply_chain_dwh_analytics`](./supply_chain_dwh_analytics)

---

### 4. Customer Shopping Behavior Analysis (Python + SQL + Power BI)

A full analytics workflow on 3,900 customer transaction records: data cleaning and feature engineering in **Python** (Pandas), loaded into **SQL Server** and analyzed through 10 structured business questions (customer segmentation, discount effectiveness, top products, repeat-buyer behavior), then visualized in an interactive **Power BI** dashboard and summarized in a PDF report and stakeholder presentation.

**What it demonstrates:** the analyst-facing side of the stack — EDA, data cleaning, and translating SQL analysis into a dashboard and report a business stakeholder can act on directly.

📁 [`/customer_analysis_python_sql_powerBI`](./customer_analysis_python_sql_powerBI)

---

## How These Projects Connect

Read top to bottom, the four projects trace one continuous skill progression:

1. **SQL Data Warehouse Project** — the fundamentals of warehousing, done manually in T-SQL
2. **E-commerce Data Warehouse** — the same fundamentals, rebuilt on a modern stack (dbt + Databricks) with production practices (CI/CD, incremental loads, SCDs)
3. **Supply Chain Analytics Platform** — the same stack applied to a messier, more realistic multi-source domain, extended all the way to an executive-facing dashboard
4. **Customer Shopping Behavior Analysis** — the analyst's-eye view of the same pipeline: starting from raw data in Python rather than a warehouse, and ending in the same place — a dashboard a business user can act on

## Getting Started

Each project folder is self-contained with its own README, setup instructions, and (where applicable) sample data. Start with the project's own README for exact setup steps — prerequisites and run instructions differ by stack (SQL Server vs. Databricks).

## Contact

**Romaric Nzekeng** — IT Business Analyst · Databricks Certified Data Engineer Associate
[GitHub](https://github.com/knromaric)
