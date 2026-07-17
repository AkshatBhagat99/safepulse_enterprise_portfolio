# Power BI Measure Catalog (DAX Examples)

```DAX
Total Cases = COUNTROWS(fact_case)
Open Cases = CALCULATE([Total Cases], NOT dim_status[status] IN {"Closed", "Resolved"})
Average Response Hours = AVERAGE(fact_case[response_hours])
Response SLA % = DIVIDE(SUM(fact_case[response_sla_met_flag]), COUNTROWS(fact_case))
Resolution SLA % = DIVIDE(SUM(fact_case[resolution_sla_met_flag]), COUNTROWS(fact_case))
Escalation Rate = DIVIDE(DISTINCTCOUNT(fact_escalation[request_id]), [Total Cases])
Reopen Rate = DIVIDE(CALCULATE([Total Cases], fact_case[reopened_flag] = TRUE()), CALCULATE([Total Cases], dim_status[is_terminal] = TRUE()))
Aged Backlog = CALCULATE([Open Cases], fact_case[case_age_days] > 15)
Counselor Utilization % = DIVIDE(SUM(fact_counselor_workload[weighted_active_cases]), SUM(dim_counselor[max_active_cases]))
```
