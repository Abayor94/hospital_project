Hospital Readmission Analysis & Patient Risk Profiling
A Complete SQL + Tableau Healthcare Analytics Project


Project Overview
This project analyzes 25,000 hospital patient records to answer a key clinical question:

Is diabetes a predictor of hospital readmission?

Using SQL for cleaning and analysis and Tableau for visualization, the project identifies high-risk patient groups, evaluates readmission drivers, and provides clinical recommendations to support better hospital decision-making.


Repository Structure
hospital_readmission_project/
│
├── dataset/
│   └── hp_readm.csv
│
├── sql/
│   └── queries.sql
│
├── tableau/
│   ├── project_screenshots/
│   │    ├── dashboard1.png
│   │    ├── dashboard2.png
│   │    └── dashboard3.png
│   └── tableau_project_link.txt
│
├── report/
│   └── Final Project Report.docx
│
└── README.md


Project Objectives
⦁	Measure hospital readmission rates across patient groups.
⦁	Investigate diabetes-related indicators (A1C, glucose test, diabetes medication).
⦁	Identify high-risk patients using a custom composite risk score.
⦁	Analyze clinical and demographic patterns influencing readmission.
⦁	Create dashboards to support data-driven decision-making.
⦁	Provide actionable clinical recommendations.


Dataset Description
⦁	Source: Kaggle – Predicting Hospital Readmission (https://www.kaggle.com/datasets/dubradave/hospital-readmissions/data)
⦁	Rows: 25,000
⦁	Columns: 17

Key fields:
age_bracket, time_in_hospital, num_lab_procedures, medical_specialty,
glucose_test, A1Ctest, diabetes_med, changes_in_db_med, readmitted

Dataset stored here:
dataset/hp_readm.csv


Technologies Used
⦁	SQL (PostgreSQL) – ETL + analysis
⦁	Tableau Public – dashboards
⦁	Excel – initial cleaning


ETL & Data Preparation Summary
⦁	Cleaned column names in Excel.
⦁	Loaded dataset into PostgreSQL.
⦁	Converted Yes/No fields → Boolean (true/false).
⦁	Checked for nulls in procedures/medications.
⦁	Validated data integrity (row counts matched CSV).
⦁	Created a reproducible database structure using queries.sql.


SQL Analysis Summary

Full SQL scripts available here:
sql/queries.sql

Key Findings
1. Readmission Rate
47.02% of all patients were readmitted.

2. Age & Readmission
Oldest groups have the highest readmission rates:
80–90 → 49.58%
70–80 → 48.79%

3. Glucose & A1C Patterns
High glucose: 52.04% readmission
High A1C: 86.52% on diabetes medication

4. Medical Specialties
Highest readmission counts:
Internal Medicine
Emergency / Trauma
Family / General Practice

5. Risk Score (0–4)
Scoring criteria:
+1 for each: high glucose, high A1C, diabetes_med, changes_in_db_med.
Distribution (verified in SQL):
Score 0 → 5,290 patients

Score 1 → 7,303

Score 2 → 10,300

Score 3 → 2,087

Score 4 → 20

High-risk (Score ≥3): 2,107 patients (8.428%)

6. Diabetes & Readmission
Diabetes patients: 8,788
Readmitted diabetes patients: 4,089
Diabetes readmission rate: 46.53%
34.79% of all readmitted patients had diabetes.


Tableau Dashboards
View the live Tableau project:
https://public.tableau.com/views/Hospitalreadmissionanalysispatientriskprofiling/Dashboard1

Screenshots included in:
tableau/project_screenshots/

Dashboards:
⦁	Dashboard 1 — Patient Profile & Risk Overview

Age distribution

Risk score distribution

Glucose test patterns

High-risk KPI

⦁	Dashboard 2 — Readmission Drivers

Readmission by medical specialty

Glucose & A1C readmission comparisons

Top diagnoses

⦁	Dashboard 3 — Insights & Recommendations

Narrative summary


Clinical recommendations
Clinical Recommendations
⦁	Prioritize elderly patients (70–90) for follow-up.
⦁	Strengthen diabetes and glucose management protocols.
⦁	Use risk scores to flag high-risk patients for early intervention.
⦁	Improve workflows in Internal Medicine & Emergency departments.


Limitations
⦁	Diagnosis fields are broad categories (not detailed ICD codes).
⦁	Missing values for some specialties.
⦁	Rule-based risk score (not a statistical model).


Future Work
⦁	Build a predictive model (Logistic Regression / Random Forest).
⦁	Add comorbidity indices for deeper insight.
⦁	Perform time-to-readmission analysis.
⦁	Include medication dosage & lab timelines.
