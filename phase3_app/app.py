

import streamlit as st
import pandas as pd
import psycopg2
import plotly.express as px


# DATABASE CONNECTION

def connect():
    return psycopg2.connect(
        host="db",
        database="olistdb",
        user="postgres",
        password="postgres"
    )

st.set_page_config(page_title="Olist Dashboard", layout="wide")
st.title(" Olist E-Commerce Analytics Dashboard")

conn = connect()


# SECTION 1 — Monthly Revenue Trends

st.header(" Monthly Revenue Trends")

query_revenue = """
SELECT 
    DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
    SUM(oi.price + oi.freight_value) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status IN ('delivered', 'shipped')
GROUP BY 1
ORDER BY 1;
"""

df_rev = pd.read_sql(query_revenue, conn)

fig_rev = px.line(
    df_rev,
    x="month",
    y="total_revenue",
    title="Monthly Revenue",
    markers=True
)

st.plotly_chart(fig_rev, use_container_width=True)

# =
# SECTION 2 — Revenue by Product Category (Interactive)

st.header(" Revenue by Product Category")

query_categories = """
SELECT DISTINCT product_category_name
FROM products
WHERE product_category_name IS NOT NULL
ORDER BY 1;
"""

categories = pd.read_sql(query_categories, conn)
category_list = ["All Categories"] + categories["product_category_name"].tolist()

selected_category = st.selectbox("Select a category:", category_list)

if selected_category == "All Categories":
    query_cat_rev = """
    SELECT 
        p.product_category_name,
        SUM(oi.price + oi.freight_value) AS total_revenue
    FROM products p
    JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY 1
    ORDER BY total_revenue DESC;
    """
else:
    query_cat_rev = f"""
    SELECT 
        p.product_category_name,
        SUM(oi.price + oi.freight_value) AS total_revenue
    FROM products p
    JOIN order_items oi ON p.product_id = oi.product_id
    WHERE p.product_category_name = '{selected_category}'
    GROUP BY 1;
    """

df_cat = pd.read_sql(query_cat_rev, conn)

fig_cat = px.bar(
    df_cat,
    x="product_category_name",
    y="total_revenue",
    title=f"Revenue for {selected_category}"
)

st.plotly_chart(fig_cat, use_container_width=True)


# SECTION 3 — Sellers with Most Canceled Orders (Phase 2)
st.header(" Sellers Responsible for the Most Canceled Orders")

query_canceled = """
WITH canceled_orders AS (
    SELECT order_id
    FROM orders
    WHERE order_status = 'canceled'
)
SELECT 
    s.seller_id,
    COUNT(*) AS canceled_orders
FROM sellers s
JOIN order_items oi ON s.seller_id = oi.seller_id
JOIN canceled_orders co ON oi.order_id = co.order_id
GROUP BY s.seller_id
ORDER BY canceled_orders DESC
LIMIT 10;
"""

df_cancel = pd.read_sql(query_canceled, conn)

fig_cancel = px.bar(
    df_cancel,
    x="canceled_orders",
    y="seller_id",
    orientation="h",
    title="Top 10 Sellers by Canceled Orders"
)

st.plotly_chart(fig_cancel, use_container_width=True)


# SECTION 4 — Top Customers by Total Order Value 

st.header("👥 Top Customers by Total Order Value")

query_customers = """
WITH customer_order_values AS (
    SELECT 
        o.customer_id,
        COUNT(o.order_id) AS total_orders,
        SUM(p.payment_value) AS total_amount_spent
    FROM orders o
    JOIN payments p ON o.order_id = p.order_id
    WHERE o.order_status IN ('delivered', 'shipped')
    GROUP BY o.customer_id
)
SELECT *
FROM customer_order_values
ORDER BY total_amount_spent DESC
LIMIT 10;
"""

df_customers = pd.read_sql(query_customers, conn)

fig_customers = px.bar(
    df_customers,
    x="customer_id",
    y="total_amount_spent",
    title="Top 10 Customers by Total Spend"
)

st.plotly_chart(fig_customers, use_container_width=True)



st.success("Dashboard loaded successfully!")