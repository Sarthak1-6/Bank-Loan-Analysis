Create Database Bank_Loan;
use Bank_Loan;

-- 1. Year-wise Loan Amount Stats
SELECT 
    YEAR(issue_d) AS year,
    COUNT(id) AS total_loans,
    SUM(loan_amnt) AS total_loan_amount,
    AVG(loan_amnt) AS avg_loan_amount
FROM finance_1
GROUP BY YEAR(issue_d)
ORDER BY year;

-- 2. Grade & Subgrade-wise Revolving Balance
SELECT 
    f1.grade,
    f1.sub_grade,
    SUM(f2.revol_bal) AS total_revol_bal
FROM finance_1 f1
JOIN finance_2 f2 
    ON f1.id = f2.ï»¿id
GROUP BY f1.grade, f1.sub_grade
ORDER BY f1.grade, f1.sub_grade;

-- 3. Verified vs Non-Verified Total Payment
SELECT 
    f1.verification_status,
    SUM(f2.total_pymnt) AS total_payment
FROM finance_1 f1
JOIN finance_2 f2 
    ON f1.id = f2.ï»¿id   -- use correct key
GROUP BY f1.verification_status;

-- 4. State-wise & Month-wise Loan Status
SELECT 
    addr_state,
    MONTH(issue_d) AS month,
    loan_status,
    COUNT(id) AS total_loans
FROM finance_1
GROUP BY addr_state, MONTH(issue_d), loan_status
ORDER BY addr_state, month;

-- 5. Home Ownership vs Last Payment Date Stats
SELECT 
    home_ownership,
    YEAR(last_pymnt_d) AS last_payment_year,
    MONTH(last_pymnt_d) AS last_payment_month,
    COUNT(id) AS total_loans,
    SUM(total_pymnt) AS total_payment
FROM finance_1 f1
JOIN finance_2 f2 
    ON f1.id = f2.ï»¿id
GROUP BY home_ownership, YEAR(last_pymnt_d), MONTH(last_pymnt_d)
ORDER BY home_ownership;

select * from finance_1;
select * from finance_2;