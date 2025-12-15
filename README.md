# DMQL_E_COMMERCE_PROJECT

UB DMQL — End-to-End Data Management & Analytics Project



## Project Overview

This project implements an end-to-end **e-commerce data pipeline** using PostgreSQL, SQL, Docker, dbt, and Streamlit.
It covers database design, data ingestion, analytical querying, query optimization, and a user-facing analytics dashboard.

---

## Technologies Used

* **Database:** PostgreSQL
* **Containerization:** Docker, Docker Compose
* **Data Ingestion:** Python
* **Analytics & Transformation:** SQL, dbt
* **Application Layer:** Streamlit
* **Visualization:** Plotly

---

## Phase Breakdown

### Phase 1 — OLTP Database & Data Ingestion

* Designed normalized OLTP schema for customers, orders, order_items, products, sellers, payments, and reviews
* Implemented schema creation using SQL
* Ingested CSV data into PostgreSQL using Python
* Fully containerized PostgreSQL and ingestion using Docker

---

### Phase 2 — Analytical Queries & Optimization

* Implemented **advanced analytical SQL queries** using:

  * Multi-table joins
  * CTEs and subqueries
  * Aggregations and grouping
* Answered key business questions such as:

  * Which sellers are responsible for the most canceled orders?
  * Which product categories generate the highest revenue?
  * Which customers contribute the highest order value?
* Optimized queries using:

  * Indexing strategies
  * `EXPLAIN ANALYZE` for before/after performance comparison
* Documented optimization results in a detailed report

---

### Bonus (Phase 2) — OLAP & Star Schema

* Designed a **star schema** with:

  * Central fact table (order items)
  * Dimension tables (customers, products, sellers, date)
* Used **dbt** to transform OLTP data into an analytics-ready warehouse schema
* Created staging and mart models following industry best practices

---

### Phase 3 — Application Layer (Streamlit Dashboard)

* Built an **interactive BI dashboard** using Streamlit
* Implemented:

  * Monthly revenue trend visualization
  * Revenue by product category with dropdown filter
  * Seller cancellation analysis
  * Top customers by order value
* Dashboard connects directly to PostgreSQL
* Entire application runs via Docker Compose

---

## Setup & Execution

### Run the Entire Project

```bash
docker compose up --build
```

### Access Services

* **Streamlit Dashboard:** [http://localhost:8501](http://localhost:8501)
* **pgAdmin:** [http://localhost:8080](http://localhost:8080)
* **PostgreSQL:** localhost:5432

---

## Repository Structure

```
DMQL_E_COMMERCE_PROJECT/
├── schema.sql
├── ingest.py
├── docker-compose.yml
├── phase2_clean/
│   ├── phase2_advanced_queries.sql
│   ├── indexes.sql
│   └── Phase2_report.pdf
├── phase3_app/
│   ├── app.py
│   └── Dockerfile
└── README.md
