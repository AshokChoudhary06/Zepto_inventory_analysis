# Zepto Inventory Analysis - SQL and Inferential Statistics 
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Jupyter](https://img.shields.io/badge/Jupyter-F37626?style=for-the-badge&logo=jupyter&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-150458?style=for-the-badge&logo=pandas&logoColor=white)
![SciPy](https://img.shields.io/badge/SciPy-8CAAE6?style=for-the-badge&logo=scipy&logoColor=white)

--- 

## Folder Structure 

```
zepto-inventory-analysis/
|
|---Notebook/
      |--zepto_inventory_analysis.ipynb #Inferential Stats in python
|---SQL_file/
      |--sql_project_1.sql  #Sql queries with business insights
|---data/
      |--zepto_1.csv  # raw data 
|---readme.md/
|
```
---

## Project Overview 

### Situation 

Zepto is a quick-commerce platform that promises 10-minute grocery delivery across India. In this business model, **inventory management is everything** - a product going out of stock means instant revenue loss, and incorrect pricing or unplanned discounting directly eats into margins.

The dataset contains **product-level inventory data** across 7 categories including Fruits & Vegetables, Dairy, Beverages, Munchies, Packaged Food, Cooking Essentials, and Bread & Batter - with columns like MRP, discountPercent, available quantity, weight, selling price, and out-of-stock status.

---

## Task 

The goal was to go further then just normal sql quering and finding insights and answer the 3 main business questions using **SQL and Inferential Statistics.**
1. **Availability Problem** - Which products and categories are going out of stock, and what drives stockouts is it pricing or discounting?
2. **Pricing & Discount Problem** - Are discounts applied strategically across categories, or is there no clear pattern?
3. **Revenue Problem** - Which categories generate the most estimated revenue, and which are underperforming?

The key challenge was to prove whether the observed patterns where statistically correct or just random noise.

## Action 

### SQL Analysis 
|#| Query | Business Purpose |
|---|---|---|
|Q1|Top 10 products by discount %|Low selling Produtcs or might be Loss Leaders Products|
|Q2|High MRP products that are OOS (Out of Stock)|Priority for restocking the higher mrp products as they might be high marginal products |
|Q3|Estimated revenue for each category| Guide marketing campaigns |
|Q4|High MRP and low margin products | Identify overpriced, low-offer risk products |
|Q5|Top categories by avg discount percentage | Evaluate discount strategy per category |
|Q6|Price per gram for products > 100g | Find best value-for-money products |
|Q7|Weight-based product classification | Help store managers sort inventory efficiently | 
|Q8|Total inventory weight per category | Warehouse space planning |
|Q9|Top 3 discounted products per category | Identify brand-level discount leaders (Window Function)|
|Q10|Revenue ranking per category |Category-level performance benchmarking (Window Function)|

### Inferential Analysis
**Test1 : Independent T-Test - MRP vs Out of stock status**
**H0 : Mean MRP is the same for Out of stock and in stock products.** 
**Tools : Scipy.stats.ttest_ind** 

| Metric | Value |
|--|--|
|in-stock mean mrp | 151.26|
|out_of_stock mean mrp| 98.78|
|t-statistics| -4.4727|
|p-value| 8.24*10^-6 which is 0.0000|

** Rejected the null hypothesis** 
---
**Test 2: Point-Biseiral Correlation: Discount % vs Out os stock status**

| Metric | Value |
|---|---|
| Correlation Coefficient | -0.0757 |
| P-Value | 0.0020 |

**Significant but weak negative correlation**
---

## Results or Findings
**Finding1-Mrp drives stockout more then the discounts:** Low-to-mid priced products(avg ₹90) go out of stock significantly more than premium products(avg ₹151).This suggests higher demand for affordable products a clear restocking priority signal for Zepto's purchasing team.

**Findings2- Discount percent is not reliable for stock out products:** negative correlation exists between discount % and OOS status (r = -0.07, p < 0.05), the effect size is too weak to conclude that discounting directly controls stockout behavior. Pricing and supply chain factors could be stronger to define it.

**Finding 3 — Revenue concentration:**
Category-wise revenue analysis revealed that certain categories doesn't not contribute to estimated revenue as much as certain categories - useful for the marketing team to prioritize ad spend and promotions.

## Author 
**Ashok**
Data Science Trainer , Analyst 
Mumbai, India  
