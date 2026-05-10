# 🏦 Bank Loan Analysis | Multi-Tool Analytics Project

**Domain:** Finance & Banking  
**Dataset:** Lending Club Portfolio | 2007–2011 | 39,717 Records  
**Tools Used:** Excel · SQL (MySQL) · Tableau · Power BI

---

## 📌 Project Overview

This project analyzes a real-world bank loan dataset from Lending Club to uncover insights around loan performance, default risk, borrower behavior, and repayment trends. The same dataset and KPIs were implemented across four industry-standard analytics tools to demonstrate end-to-end data analysis capability.

---

## 📂 Dataset

| File | Description |
|------|-------------|
| `Finance_1.csv` | Primary loan data — 39,717 records, 47 columns (loan amount, grade, status, issue date, borrower info) |
| `Finance_2.xlsx` | Secondary financial data — revolving balance, total payments, recovery details |

The two tables were joined on the `id` field using SQL (LEFT JOIN) and Power Query (Merge Queries) for combined analysis.

---

## 🎯 KPIs Analyzed

1. **Year-wise Loan Amount Stats** — Total loans, funded amount, and average loan amount by year (2007–2011)
2. **Grade & Sub-Grade wise Revolving Balance** — Debt distribution across risk grades A through G
3. **Verified vs Non-Verified Total Payment** — Impact of verification status on repayment
4. **State-wise & Month-wise Loan Status** — Geographic and temporal loan performance
5. **Home Ownership vs Last Payment Date** — Payment behavior by ownership type over time

---

## 🛠️ Tool-wise Implementation

### 1. 📊 Excel
- Merged Finance_1 and Finance_2 using **Power Query (LEFT JOIN)**
- Cleaned data and engineered new calculated columns
- Built **KPI cards** using SUM, AVERAGE, and COUNT functions
- Created **Pivot Tables** for each KPI with corresponding charts
- Assembled an **interactive dashboard** with slicers for Year, Status, and Grade
- Visualizations include: stacked bar chart, donut chart, line chart, and US map

**Key Metrics Surfaced:**
- Total Applications: 39,717
- Total Funded Amount: $434.81M
- Avg Loan Amount: $11.22K
- Interest Collected: $89.91M
- Avg DTI Ratio: 13.32%
- Recovery Rate: 5.55%

---

### 2. 🗄️ SQL (MySQL)
- Created and queried a `Bank_Loan` database with two tables: `finance_1` and `finance_2`
- Joined tables using `LEFT JOIN` on the `id` field
- Wrote 5 analytical queries covering all KPIs

```sql
-- Year-wise Loan Amount Stats
SELECT YEAR(issue_d) AS year, COUNT(id) AS total_loans,
       SUM(loan_amnt) AS total_loan_amount, AVG(loan_amnt) AS avg_loan_amount
FROM finance_1
GROUP BY YEAR(issue_d) ORDER BY year;

-- Grade & Subgrade wise Revolving Balance
SELECT f1.grade, f1.sub_grade, SUM(f2.revol_bal) AS total_revol_bal
FROM finance_1 f1 JOIN finance_2 f2 ON f1.id = f2.id
GROUP BY f1.grade, f1.sub_grade ORDER BY f1.grade, f1.sub_grade;

-- Verified vs Non-Verified Total Payment
SELECT f1.verification_status, SUM(f2.total_pymnt) AS total_payment
FROM finance_1 f1 JOIN finance_2 f2 ON f1.id = f2.id
GROUP BY f1.verification_status;

-- State-wise & Month-wise Loan Status
SELECT addr_state, MONTH(issue_d) AS month, loan_status, COUNT(id) AS total_loans
FROM finance_1
GROUP BY addr_state, MONTH(issue_d), loan_status ORDER BY addr_state, month;

-- Home Ownership vs Last Payment Date
SELECT home_ownership, YEAR(last_pymnt_d) AS last_payment_year,
       COUNT(id) AS total_loans, SUM(total_pymnt) AS total_payment
FROM finance_1 f1 JOIN finance_2 f2 ON f1.id = f2.id
GROUP BY home_ownership, YEAR(last_pymnt_d) ORDER BY home_ownership;
```

---

### 3. 📈 Tableau
- Connected and blended both data sources in Tableau Desktop (Public Edition)
- Built individual sheets for each KPI, then assembled into a single interactive dashboard
- Added **descriptive subtitles** to each chart to communicate business insight directly

**Charts Built:**
| Chart | Insight Highlighted |
|-------|-------------------|
| Year-wise Loan Status (Stacked Bar) | Loan volume grew 5x from 2007 to 2011 |
| Payment by Verification Status (Donut) | $482.70M total — 45.55% Not Verified |
| Default Rate by Grade (Bar) | Grade G default rate (31.96%) vs Grade A (5.97%) |
| Grade & Sub-Grade Revolving Balance | B/C grades carry the highest revolving debt (bell curve) |
| Home Ownership vs Payment Trends (Line) | Mortgage holders dominate payments — peak in 2014 |
| Top 10 States (Bar) | California leads with 7,099 loans |
| State-wise Distribution (Map) | Darker teal = higher loan concentration |

---

### 4. 📉 Power BI
- Built a **3-page report** with navigation panel for Summary, Overview, and Details
- Created **DAX measures** for MTD (Month-to-Date) and MoM (Month-over-Month) calculations
- Implemented **Good Loan vs Bad Loan** segmentation as a key risk metric

**Page 1 — Summary:**
- Good Loan: 86.2% (33K applications, $370.2M funded)
- Bad Loan: 13.8% (5K applications, $65.5M funded)
- Loan status breakdown table with Avg Interest Rate and Avg DTI per status

**Page 2 — Overview:**
- Monthly trend of total amount received
- Loan breakdown by Employee Length, Purpose, Home Ownership, and Term (36 vs 60 months)
- State-wise map with dynamic filters

**Page 3 — Details:**
- Full drill-through table with loan-level data (Purpose, Grade, Sub-Grade, Issue Date, Funded Amount, Installments, Amount Received)
- Filterable by State, Grade, and Good vs Bad Loan

---

## 💡 Key Business Insights

- **Loan volume grew significantly** from 2007 to 2011, with 2011 being the peak year
- **Grade G borrowers default at 5x the rate** of Grade A borrowers (31.96% vs 5.97%), confirming grade as a strong risk predictor
- **86.2% of loans are "Good Loans"** (Fully Paid or Current), but the 13.8% bad loan rate represents $65.5M in risk exposure
- **Debt consolidation is the #1 loan purpose**, accounting for the largest share of total amount received
- **California, New York, and Texas** are the top 3 states by loan volume, driving the majority of portfolio value
- **Mortgage holders** show the highest and most sustained payment activity, peaking in 2014
- **Verified borrowers** do not always show better repayment — an insight worth investigating further

---

## 📁 Project Structure

```
Bank-Loan-Analysis/
│
├── data/
│   ├── Finance_1.csv
│   └── Finance_2.xlsx
│
├── sql/
│   └── bank_loan.sql
│
├── excel/
│   └── Bank_Analytics_Excel.xlsx
│
├── tableau/
│   └── Bank_Analytics.twbx
│
├── powerbi/
│   └── Bank_Loan_Analysis.pbix
│
└── README.md
```

---

## 🚀 How to Use

1. **SQL** — Import `Finance_1.csv` and `Finance_2.xlsx` into MySQL as `finance_1` and `finance_2` tables, then run `bank_loan.sql`
2. **Excel** — Open `Bank_Analytics_Excel.xlsx` and use the slicers to filter the dashboard
3. **Tableau** — Open `Bank_Analytics.twbx` in Tableau Desktop (Public Edition is free)
4. **Power BI** — Open `Bank_Loan_Analysis.pbix` in Power BI Desktop (free download from Microsoft)

---
## 📸 Dashboard Screenshots

### 📊 Excel Dashboard
![Excel Dashboard](Screenshot%202026-05-11%20010437.png)

### 📈 Tableau Dashboard
![Tableau Dashboard 1](Screenshot%202026-05-11%20005532.png)
![Tableau Dashboard 2](Screenshot%202026-05-11%20005549.png)

### 📉 Power BI Dashboard
![Power BI Summary](Screenshot%202026-05-11%20011740.png)
![Power BI Overview](Screenshot%202026-05-11%20011813.png)
![Power BI Details](Screenshot%202026-05-11%20011838.png)
## 👤 Author

**Sarthak Bhambri**  
Aspiring Data Analyst | Excel · SQL · Tableau · Power BI  
[GitHub](https://github.com/Sarthak1-6) · [LinkedIn](#)
