# Business Analytics and KPI Framework

## Executive questions and KPI mapping

| Executive question | KPI | Drill path |
|---|---|---|
| Which schools need additional counselors? | Counselor Utilization, Open Cases, Case Aging | District → Region → School → Counselor |
| Which schools have the highest workload? | Open Cases, Monthly Volume, Backlog | District → School → Category |
| How many cases exceed SLA? | Response SLA Compliance, Resolution SLA Compliance | District → School → Priority → Case |
| Where are operational bottlenecks? | Status Duration, Queue Age, Time to Assignment | Process step → School → Department |
| Which departments are overloaded? | Department Utilization, Escalation Backlog | Department → Escalation reason → School |
| What trends exist across semesters? | Monthly Trends, Seasonality, Category Mix | Term → Month → Category |
| Which workflows create delays? | Time in Status, Reopen Rate, Overdue Follow-ups | Status → Category → Owner |

## KPI logic summary

| KPI | Calculation |
|---|---|
| Average Response Time | AVG(first_response_at - submitted_at) in hours |
| Average Resolution Time | AVG(resolved_at - submitted_at) in days |
| Case Backlog | Count of open cases older than defined threshold |
| SLA Compliance | Cases meeting SLA / cases eligible for SLA |
| Escalation Rate | Distinct escalated cases / total cases |
| Repeat Incident Rate | Students with >1 case in term / students with cases |
| Counselor Utilization | Weighted active cases / counselor capacity |
| School Performance Index | Weighted composite of SLA, backlog, reopen rate, and response time |
| Case Reopen Rate | Reopened cases / closed cases |

## Insight examples

- High school locations show higher case volume during October, February, and May, requiring term-aware staffing plans.
- SLA breach risk is concentrated in cases waiting in New or Triaged status for more than one business day.
- Counselor utilization is uneven across schools even when district-level staffing appears sufficient.
- Escalation volume is driven more by handoff delays than by total case volume in several schools.
- Cases with overdue follow-ups have materially higher reopen rates, suggesting follow-up governance is a key quality lever.

## Business recommendations

1. Implement daily triage queue review with SLA-at-risk filters.
2. Create counselor capacity thresholds and assignment warnings.
3. Require closure reason and follow-up completion before case closure.
4. Establish monthly school performance reviews using the executive dashboard.
5. Use category seasonality to plan counselor coverage by term.
6. Create escalation reason governance to identify systemic process gaps.
