# Power BI Dashboard Specification

## Dashboard 1: District Superintendent

Purpose: Executive view of district-wide support operations.

- KPI cards: Total Cases, Open Cases, SLA Compliance, Avg Response Time, Escalation Rate, School Performance Index
- Visuals: Monthly trend, school heatmap, category mix, SLA breach distribution, backlog aging
- Drillthrough: School detail, category detail, SLA breach detail
- Filters: Academic term, region, school level, category, priority
- RLS: District executives can view all schools

## Dashboard 2: School Principal

Purpose: School-level operational accountability.

- KPI cards: Open Cases, Aged Cases, Overdue Follow-ups, Response SLA, Counselor Utilization
- Visuals: Active cases by counselor, aging buckets, status funnel, category trend
- Drillthrough: Case details, counselor workload, overdue follow-up list
- Filters: Status, priority, category, assigned owner, date range
- RLS: Principal can view assigned school only

## Dashboard 3: Operations Director

Purpose: Workflow bottlenecks and process health.

- Visuals: Time in status, triage queue age, assignment lag, escalation backlog, reopen trends
- Advanced: Decomposition tree for SLA breach drivers, what-if staffing scenario
- Drillthrough: Status transition detail and exception lists

## Dashboard 4: Counselor Workspace

Purpose: Actionable individual workload view.

- KPI cards: Active Cases, Due Today, Overdue Follow-ups, SLA At Risk
- Visuals: My cases by priority/status, due date calendar, follow-up queue
- RLS: Counselor can view assigned cases only

## Dashboard 5: Executive Leadership

Purpose: Board-ready reporting.

- Visuals: District performance summary, top 10 schools by workload, SLA trend, investment priority map
- Bookmarks: Current Month, Term-to-Date, Year-to-Date, Board Summary
- Export: PDF and PowerPoint snapshots with anonymized aggregated data

## Semantic model

- Fact tables: fact_case, fact_case_status_event, fact_counselor_workload, fact_notification
- Dimensions: dim_school, dim_category, dim_priority, dim_date, dim_user, dim_status
- Measures: Response SLA %, Resolution SLA %, Avg Response Hours, Active Backlog, Reopen %, Escalation %, Utilization %
