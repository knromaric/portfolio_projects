# eShop Analytics — E-commerce Data Warehouse (dbt + Databricks)

A medallion-architecture data warehouse that gives an e-commerce client one governed source of truth for analytics — built with **dbt** for transformation and **Databricks (Unity Catalog + SQL Warehouse)** as the compute/storage engine, deployed with **Databricks Asset Bundles** and **GitHub Actions** CI/CD.

## Problem Statement

The client had data scattered across raw exports with no single, trusted place to answer basic but critical business questions:

- What's our revenue, and how is it trending?
- Which products and categories sell best?
- Who are our best customers?

This project builds a governed dimensional warehouse on Databricks so those questions can be answered directly from clean, tested Gold tables — not from ad hoc spreadsheet joins.

## Data Modeling

**Domain entities:** `customers`, `orders`, `order_items`, `products`

**Grain — two fact tables, chosen deliberately for two different analysis needs:**

| Fact Table | Grain | Answers |
|---|---|---|
| `fact_orders` | One row per order | Revenue per order, average order value, orders per week |
| `fact_order_items` | One row per order line | Revenue by product/category, units sold per product |

Supporting dimensions:
- `dim_products` — one row per product, surrogate-keyed
- `scd_customers` — a **Type 2 slowly changing dimension** (dbt snapshot) tracking historical changes to customer name, email, and country

## Architecture: Medallion on Databricks

```
Raw CSVs
   │  dbt seed
   ▼
🥉 Bronze  (raw_customers, raw_orders, raw_order_items, raw_products)
   │  cleaning, type casting, standardization
   ▼
🥈 Silver  (silver_orders, silver_products, silver_order_items,
            silver_int_orders_enriched, silver_int_order_items_with_product)
   │  aggregation, surrogate keys, incremental merge
   ▼
🥇 Gold    (fact_orders, fact_order_items, dim_products, scd_customers)
```

- **Bronze** — raw CSVs loaded as dbt seeds into Unity Catalog–governed tables (no transformation, source fidelity preserved).
- **Silver** — nulls handled, types standardized (dates, decimals), orders enriched with customer and order-item aggregates via joins.
- **Gold** — business-ready fact and dimension tables. Both fact tables are `materialized='incremental'` with `merge_update_columns`, so daily runs only process and merge new/changed orders instead of rebuilding the warehouse from scratch.

<img src="https://github.com/knromaric/ecommerce-dbt-databricks-dwh/blob/main/models_and_lineage/lineage_graph_eshop.png" width=900>    

<img src="https://github.com/knromaric/ecommerce-dbt-databricks-dwh/blob/main/models_and_lineage/data_modeling_eshop.png" width=800>


## Tech Stack

| Layer | Tool |
|---|---|
| Transformation | dbt-core, dbt-databricks adapter, dbt_utils |
| Compute / Storage | Databricks SQL Warehouse, Unity Catalog |
| Deployment | Databricks Asset Bundles (`databricks.yml`) |
| Orchestration | Databricks Jobs (`dbt deps → seed → snapshot → run → test`) |
| CI/CD | GitHub Actions (separate `dev` and `prod` targets) |
| Data Quality | dbt schema tests + custom singular tests |

## Data Quality

Enforced with dbt schema tests plus custom singular tests, including:
- `assert_customer_has_valid_email`
- `assert_no_future_order_dates`
- `assert_product_price_positive`
- `assert_quantity_positive`
- `assert_fact_orders_revenue_non_negative`

## CI/CD

Two GitHub Actions workflows deploy the Databricks Asset Bundle automatically:

| Workflow | Trigger | Target |
|---|---|---|
| `deploy-bundle-dev.yml` | push to `dev` | `databricks bundle deploy -t dev` |
| `deploy-bundle-prod.yml` | push to `main` | `databricks bundle deploy -t prod` |

Both validate the bundle (`databricks bundle validate`) before deploying, so a broken configuration never reaches a Databricks workspace.

## Repository Structure

```
eshop_dbt/
├── databricks.yml            # Asset Bundle definition (dev/prod targets)
├── dbt_project.yml           # dbt project & materialization config
├── resources/                # Databricks Job definition (dbt task)
├── seeds/                    # Raw CSVs → Bronze
├── models/
│   ├── silver/                # Cleaned, conformed models
│   └── gold/                  # Fact & dimension models
├── snapshots/                 # Type 2 SCD (scd_customers)
├── tests/                     # Custom data quality tests
└── exploratory_analysis/      # EDA notebook
.github/workflows/             # CI/CD pipelines
```

## Running Locally

```bash
cd eshop_dbt
dbt deps
dbt seed
dbt snapshot
dbt run
dbt test
```

## Deploying to Databricks

```bash
cd eshop_dbt
databricks bundle validate -t dev
databricks bundle deploy -t dev
```

## What This Demonstrates

- Dimensional modeling: choosing fact grain deliberately based on the business questions each grain must answer
- Medallion architecture end-to-end on Databricks + Unity Catalog
- Incremental processing with merge strategies, not full-refresh rebuilds
- Slowly Changing Dimensions (Type 2) for historical customer tracking
- Data quality enforcement as code (dbt tests)
- Infrastructure-as-code deployment (Databricks Asset Bundles) with automated CI/CD across environments
