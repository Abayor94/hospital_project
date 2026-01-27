# Hospital Readmission Analysis & Patient Risk Profiling  
*SQL · Excel · Tableau · Healthcare Analytics*

## Project Overview
This repository contains a complete **end-to-end healthcare analytics project** analyzing hospital readmissions using a real-world patient dataset of over **25,000 records**.

The objective is to uncover **clinical and demographic patterns** that drive readmissions and translate complex patient data into **actionable insights** that support hospital decision-making, patient prioritization, and resource planning.

---

## Problem Statement
Hospital readmissions are a key indicator of care quality and operational efficiency. This analysis focuses on:
- Measuring overall readmission rates  
- Examining how clinical indicators (A1C, glucose tests, diabetes medication) relate to readmissions  
- Identifying high-risk patient groups  
- Producing insights that can inform clinical prioritization and follow-up strategies  

---

## Key Insights
- **Overall readmission rate:** ~47.02% of patients were readmitted  
- **Age effects:** Highest readmission rates observed among elderly patients aged 70–90  
- **Glucose / A1C patterns:**  
  - High glucose → 52.04% readmission rate  
  - High A1C → 86.52% of patients on diabetes medication  
- **Risk scoring:** A custom risk score (0–4) identified **2,107 high-risk patients (~8.43%)**  
- **Diabetes subgroup:** Diabetes patients accounted for **34.79% of readmissions** with a **46.53%** readmission rate  

**Clinical value:** These insights help healthcare teams identify vulnerable patient segments, improve follow-up care, and allocate monitoring resources more effectively.

---

## Tools & Technologies

| Category | Tools |
|--------|------|
| Data cleaning & preprocessing | Excel |
| Data processing & analysis | PostgreSQL / SQL |
| Visualization | Tableau |
| Reporting | Word / Notion / Markdown |

All analysis queries are available in the `sql/queries.sql` file.

---

## Tableau Dashboards
Interactive dashboards were created to visualize:
- Patient demographics and clinical profiles  
- Readmission drivers across age groups and departments  
- Risk distribution and clinical recommendations  

🔗 **Live dashboards:**  
https://public.tableau.com/views/Hospitalreadmissionanalysispatientriskprofiling/Dashboard1

---

## How to Run the Project
1. Download the dataset from `dataset/hp_readm.csv`  
2. Load the data into PostgreSQL (or any compatible SQL environment)  
3. Execute the queries in `sql/queries.sql` to reproduce the analysis  
4. Open the Tableau files in the `tableau/` folder to explore visualizations  
5. Review the detailed findings in `report/Final Project Report.docx`  

---

## Limitations
- Diagnosis fields are broad categories rather than detailed ICD codes  
- Some specialty categories contain missing values  
- The risk score is rule-based and not a predictive statistical model  

---

## Future Work
- Develop predictive models (logistic regression, random forest)  
- Integrate comorbidity indices for deeper risk assessment  
- Perform time-to-readmission analysis  
- Incorporate lab result timelines and medication dosage data  

---

## Repository Structure
```text
hospital_project/
├── dataset/
│   └── hp_readm.csv
├── sql/
│   └── queries.sql
├── tableau/
│   ├── project_screenshots/
│   │   ├── dashboard1.png
│   │   ├── dashboard2.png
│   │   └── dashboard3.png
│   └── tableau_project_link.txt
├── report/
│   └── Final Project Report.docx
└── README.md

