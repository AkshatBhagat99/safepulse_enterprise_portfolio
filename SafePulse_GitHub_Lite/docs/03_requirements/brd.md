# Business Requirements Document (BRD)

## Document control

| Field | Value |
|---|---|
| Project | SafePulse |
| Version | 1.0 |
| Owner | Business Analysis Lead |
| Status | Portfolio baseline |
| Approval groups | Superintendent Office, Operations, Counseling, IT Security, BI |

## Business scope

In scope:

- District-wide student support request intake
- Case triage, assignment, escalation, follow-up, and closure
- Counselor workload and utilization analytics
- SLA monitoring and operational alerts
- Role-based dashboards for district, school, operations, and counselor users
- Audit logs and status history
- Dimensional reporting model for Power BI and Tableau

Out of scope:

- Medical diagnosis or clinical risk prediction
- Student mental health scoring
- Automated disciplinary decisions
- Replacement of student information system master records
- Real-time emergency dispatch

## Business rules

| Rule ID | Rule |
|---|---|
| BR-001 | Every support request must have one school, category, priority, status, and submitted timestamp. |
| BR-002 | A request cannot move to Assigned until an active counselor or support coordinator owns it. |
| BR-003 | Critical priority requests must be triaged within 4 business hours. |
| BR-004 | High priority requests must be triaged within 1 business day. |
| BR-005 | Medium priority requests must be triaged within 2 business days. |
| BR-006 | Low priority requests must be triaged within 3 business days. |
| BR-007 | Any case exceeding response SLA must be visible on principal and operations dashboards. |
| BR-008 | Closed cases can be reopened only by authorized users. |
| BR-009 | All assignment, status, priority, and closure changes must generate audit log records. |
| BR-010 | Executive dashboards must display anonymized student-level data only. |

## Business requirements

| ID | Requirement | Priority | KPI supported |
|---|---|---|---|
| BREQ-001 | Provide a standardized intake process across all schools. | Must | Intake Volume, Open Cases |
| BREQ-002 | Enable rules-based triage and assignment by school, category, priority, and capacity. | Must | Response Time, Counselor Utilization |
| BREQ-003 | Track SLA compliance from request submission to first response and closure. | Must | SLA Compliance |
| BREQ-004 | Provide school-level and district-level dashboards. | Must | School Performance Index |
| BREQ-005 | Identify aged backlog and overdue follow-ups. | Must | Case Aging, Backlog |
| BREQ-006 | Support executive trend reporting by month, term, school, and category. | Should | Seasonality, Monthly Trends |
| BREQ-007 | Provide audit-ready change history for critical fields. | Must | Audit Completeness |
| BREQ-008 | Support exportable reports for board and district reviews. | Should | Reporting Cycle Time |

## Compliance and accessibility

- Role-based access by school, district role, and department
- Audit trail for status, priority, assignment, and closure changes
- Data minimization for executive analytics
- WCAG-aligned color contrast and keyboard navigation
- Export controls for sensitive operational reports

## Dependencies

| Dependency | Owner | Impact |
|---|---|---|
| School roster feed | District IT | Required for school and student linkage |
| User directory integration | IT Security | Required for SSO and role assignment |
| District SLA policy | Operations | Required for KPI calculations |
| Historical case data | School teams | Required for trend baselines |
| BI platform workspace | BI Lead | Required for dashboard deployment |
