# Functional Requirements Document (FRD)

## Functional requirements

| ID | Capability | Requirement | Priority | Acceptance criteria |
|---|---|---|---|---|
| FR-001 | Intake | Users can submit support requests with school, category, priority, channel, and description. | Must | Request is saved with unique ID, timestamp, status New, and audit log. |
| FR-002 | Triage queue | Coordinators can view unassigned requests by SLA urgency. | Must | Queue supports school, priority, category, age, and channel filters. |
| FR-003 | Assignment | Coordinators can assign a case to an eligible counselor. | Must | Assignment creates case assignment row, updates status, and logs audit event. |
| FR-004 | SLA tracking | System calculates response and resolution SLA status. | Must | SLA indicator displays On Track, At Risk, Breached. |
| FR-005 | Follow-up | Counselors can create follow-up tasks with due dates. | Must | Overdue follow-ups appear in counselor workspace and principal dashboard. |
| FR-006 | Escalation | Authorized users can escalate cases to departments. | Must | Escalation reason, target department, timestamp, and owner are captured. |
| FR-007 | Case notes | Counselors can add notes with role-restricted visibility. | Must | Notes show author, timestamp, note type, and visibility level. |
| FR-008 | Search | Users can search by case ID, category, school, status, date, and assigned owner. | Should | Search results return within 3 seconds for common filters. |
| FR-009 | Export | Authorized users can export dashboard data. | Should | Exports respect row-level security and anonymization rules. |
| FR-010 | Notifications | Users receive reminders for assignments, SLA risk, overdue follow-ups, and escalations. | Should | Notifications are logged and dismissible. |

## Non-functional requirements

| ID | Category | Requirement | Target |
|---|---|---|---|
| NFR-001 | Performance | Dashboard KPI tiles load within 5 seconds for district users. | 95th percentile |
| NFR-002 | Availability | Platform availability during school business hours. | 99.5% monthly |
| NFR-003 | Security | Role-based access control must restrict school-level data. | 100% enforced |
| NFR-004 | Audit | Critical field changes must be logged. | 100% coverage |
| NFR-005 | Accessibility | User interfaces meet WCAG-aligned design rules. | AA target |
| NFR-006 | Recovery | Recovery point objective for operational data. | 4 hours |
| NFR-007 | Recovery | Recovery time objective for platform service. | 8 hours |

## Error messages

| Scenario | Error message |
|---|---|
| Required field missing | Complete all required fields before submitting the request. |
| Unauthorized access | You do not have permission to view this case. |
| Invalid assignment | Selected user is not eligible for this school or case category. |
| Closed case update | This case is closed. Reopen the case before making changes. |
| Export blocked | Export is not allowed for this role or filter selection. |

## API integrations

| Integration | Direction | Purpose |
|---|---|---|
| Student Information System | Inbound | School, grade band, anonymized student reference |
| Identity Provider | Inbound | SSO, roles, user lifecycle |
| Email/SMS gateway | Outbound | Notifications and reminders |
| BI platform | Outbound | Semantic model refresh and dashboard publishing |
| Data warehouse | Outbound | Historical reporting and trend analysis |
