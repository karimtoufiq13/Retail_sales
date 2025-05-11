# 📊 Retail Sales Dashboard Project (Python + SQL + Tableau)

This project provides a full-stack retail sales analysis pipeline that explores customer orders across 2022 and 2023 using:

- 🐍 Python for data cleaning and transformation
- 🛢️ MySQL for structured business logic using CTEs
- 📈 Tableau for visual storytelling and executive insights


## 🔍 Key Insights & Findings

📌 **Top-Selling Products Overall:**
- The top 10 products by total revenue were identified using `SUM(sale_price)`, helping prioritize inventory and marketing.

📌 **Top 5 Products by Region:**
- A `RANK()` query revealed the top 5 products per region.
- Notably, different regions favor different products — critical for localized campaigns.

📌 **Month-over-Month Comparison (2022 vs. 2023):**
- A CTE with `YEAR(order_date)` and `MONTH(order_date)` highlighted monthly sales growth.
- Most categories showed strong year-over-year growth in Q2 and Q3.

📌 **Best Month by Category:**
- Using `ROW_NUMBER()` and monthly sales, the top-performing month was extracted for each product category.
- This revealed seasonal peaks unique to each category (e.g., Office Supplies peaking in March, Furniture in December).

📌 **Sub-Categories with Highest Growth (YoY):**
- Top 3 fastest-growing sub-categories by sales:
  - Phones
  - Binders
  - Chairs
- These categories more than doubled in revenue from 2022 to 2023, suggesting demand surges or marketing wins.

📌 **Dashboard View:**
Explore all of these insights visually on the [Tableau Dashboard](https://public.tableau.com/views/retail_order_17430096100740/Dashboard1)

---

## 🧰 Tools & Technologies

| Tool      | Purpose                             |
|-----------|-------------------------------------|
| Python    | Data wrangling with `pandas`        |
| MySQL     | Aggregation via CTEs and queries    |
| Tableau   | Dashboard creation                  |
| GitHub    | Project version control & sharing   |

---
