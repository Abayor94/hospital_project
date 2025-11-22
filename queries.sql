-- PROJECT TITLE: Hospital Readmission Analysis & Patient Risk Profiling --

CREATE TABLE hp_readm (
   id BIGSERIAL PRIMARY KEY,
    age_bracket                  VARCHAR(20),
    time_in_hospital             INTEGER,
    num_lab_procedures           INTEGER,
    num_procedures               INTEGER,
    num_of_medications           INTEGER,
    num_of_outpatient            INTEGER,
    num_of_inpatient             INTEGER,
    num_of_emergency             INTEGER,

    medical_specialty            VARCHAR(100),
    primary_diagnosis            VARCHAR(100),
    secondary_diagnosis          VARCHAR(100),
    additional_secondary_diagnosis VARCHAR(100),

    glucose_test                 VARCHAR(20),
    A1Ctest                      VARCHAR(20),

    changes_in_db_med            BOOLEAN,
    diabetes_med                 BOOLEAN,

    readmitted                   BOOLEAN
);

-- test run
SELECT * FROM hp_readm;

-- data cleaning (if a patient does not receive the medication initially then 
-- there can never be a change in medication)
SELECT id
FROM hp_readm
WHERE changes_in_db_med = 'true' AND diabetes_med = 'false';

-- Q1. What percentage of patients were readmitted?
SELECT
    COUNT(*) AS total_patients,
    SUM(CASE WHEN readmitted = true THEN 1 ELSE 0 END) AS total_readmission,
    ROUND(
        (SUM(CASE WHEN readmitted = true THEN 1 ELSE 0 END)::decimal 
        / COUNT(*)) * 100,
        2
    ) AS readmission_rate
FROM hp_readm;

-- Q2. what age bracket has the highest readmission rate
SELECT 
    age_bracket,
    COUNT(*) AS number_of_patients,
    SUM(CASE WHEN readmitted = true THEN 1 ELSE 0 END) AS number_of_readmitted_patients,
    ROUND(
        SUM(CASE WHEN readmitted = true THEN 1 ELSE 0 END)::decimal
        / COUNT(*) * 100, 
        2
    ) AS readmission_rate
FROM hp_readm
GROUP BY 1
ORDER BY 4 DESC;

-- Q3. What is the average hospital stay (time_in_hospital) for readmitted vs not readmitted patients?
SELECT 
    readmitted,
    ROUND(AVG(time_in_hospital), 2) AS avg_stay
FROM hp_readm
GROUP BY 1;

-- Q4. What are the top 10 most common primary diagnoses?
SELECT 
    primary_diagnosis,
    COUNT(*) AS total_patients
FROM hp_readm
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

-- Q5. Do patients with high glucose tests get readmitted more often?
SELECT 
    glucose_test,
	COUNT (*) AS total_patients,
	SUM(CASE WHEN readmitted = true THEN 1 ELSE 0 END) AS number_of_readmitted_patients,
    ROUND(
        AVG(CASE WHEN readmitted = true THEN 1 ELSE 0 END) * 100,
        2
    ) AS readmission_rate
FROM hp_readm
GROUP BY 1
ORDER BY 4 DESC;

-- Q6. How often do patients with a high A1C test get diabetes medication?
SELECT 
    A1Ctest,
	COUNT (*) AS total_patients,
	SUM(CASE WHEN diabetes_med = true THEN 1 ELSE 0 END) AS patients_that_received_db_med,
    ROUND(
        SUM(CASE WHEN diabetes_med = true THEN 1 ELSE 0 END)::decimal 
        / COUNT(*) * 100,
        2
    ) AS pct_on_diabetes_med
FROM hp_readm
GROUP BY 1
ORDER BY 4 DESC;

-- Q7. Is there a relationship between number of procedures and number of medications?
SELECT 
    num_procedures,
    ROUND(AVG(num_of_medications), 2) AS avg_medications
FROM hp_readm
GROUP BY 1
ORDER BY 1;

-- Q8. Which medical specialty has the highest readmission count?
SELECT 
    medical_specialty,
    COUNT(*) AS readmission_count
FROM hp_readm
WHERE readmitted = true
GROUP BY 1
ORDER BY 2 DESC;

-- Q9. Create a risk score to calculate the number of patients using:
-- high glucose, high A1C, diabetes medication, change in medication
SELECT 
    (CASE WHEN glucose_test = 'high' THEN 1 ELSE 0 END
     + CASE WHEN A1Ctest = 'high' THEN 1 ELSE 0 END
     + CASE WHEN diabetes_med = true THEN 1 ELSE 0 END
     + CASE WHEN changes_in_db_med = true THEN 1 ELSE 0 END
    ) AS risk_score,
    COUNT(id) AS count_patients
FROM hp_readm
GROUP BY risk_score
ORDER BY risk_score DESC;

-- Q10. Which patients have diabetes in ALL three diagnosis fields?
SELECT 
    id
FROM hp_readm
WHERE 
      LOWER(primary_diagnosis) = 'diabetes'
  AND LOWER(secondary_diagnosis) = 'diabetes'
  AND LOWER(additional_secondary_diagnosis) = 'diabetes';


-- Q11. What is the readmission rate among all patients diagnosed with diabetes (in any diagnosis field)?
SELECT 
    COUNT(*) AS diabetes_patients,
    SUM(CASE WHEN readmitted = true THEN 1 ELSE 0 END) AS diabetes_patients_readmitted,
    ROUND(
        SUM(CASE WHEN readmitted = true THEN 1 ELSE 0 END)::decimal 
        / COUNT(*) * 100,
        2
    ) AS readmission_rate
FROM hp_readm
WHERE 
      LOWER(primary_diagnosis) = 'diabetes'
   OR LOWER(secondary_diagnosis) = 'diabetes'
   OR LOWER(additional_secondary_diagnosis) = 'diabetes';


-- Q12. What percentage of all readmitted patients were diabetes patients?
SELECT
    SUM(
        CASE 
            WHEN (
                LOWER(primary_diagnosis) = 'diabetes'
                OR LOWER(secondary_diagnosis) = 'diabetes'
                OR LOWER(additional_secondary_diagnosis) = 'diabetes'
            ) 
            AND readmitted = TRUE 
        THEN 1 ELSE 0 
        END
    ) AS diabetes_readmitted,

    (SELECT COUNT(*) FROM hp_readm WHERE readmitted = TRUE) AS total_readmitted,

    ROUND(
        SUM(
            CASE 
                WHEN (
                    LOWER(primary_diagnosis) = 'diabetes'
                    OR LOWER(secondary_diagnosis) = 'diabetes'
                    OR LOWER(additional_secondary_diagnosis) = 'diabetes'
                ) 
                AND readmitted = TRUE 
            THEN 1 ELSE 0 
            END
        )::DECIMAL
        / (SELECT COUNT(*) FROM hp_readm WHERE readmitted = TRUE)
        * 100,
        2
    ) AS pct_of_all_readmitted
FROM hp_readm;










