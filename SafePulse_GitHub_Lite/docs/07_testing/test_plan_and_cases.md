# Test Plan

## Test scope

- Intake submission
- Triage queue filtering and sorting
- Case assignment and reassignment
- SLA calculation
- Follow-up creation and completion
- Escalation workflow
- Case closure and reopening
- Audit logging
- Role-based access control
- Dashboard metrics and drillthrough
- Export controls
- Accessibility checks

## Test cases

| Test ID | Requirement | Scenario | Expected result | Type |
|---|---|---|---|---|
| TC-INTAKE-001 | FR-001 | Submit valid request | Case created with New status and audit log | Functional |
| TC-INTAKE-002 | FR-001 | Missing category | Submission blocked with validation message | Negative |
| TC-ASSIGN-001 | FR-003 | Assign case to eligible counselor | Assignment row created and status updated | Functional |
| TC-ASSIGN-002 | FR-003 | Assign to ineligible user | Assignment blocked | Negative |
| TC-SLA-001 | FR-004 | Critical case first response within 4 hours | SLA met flag = true | Functional |
| TC-SLA-002 | FR-004 | High case first response after due time | SLA breach visible on dashboard | Functional |
| TC-FOLLOWUP-001 | FR-005 | Create follow-up due tomorrow | Follow-up appears in workspace | Functional |
| TC-FOLLOWUP-002 | FR-005 | Follow-up overdue | Overdue flag appears in dashboard | Functional |
| TC-ESC-001 | FR-006 | Escalate to department | Escalation logged and notification sent | Functional |
| TC-AUDIT-001 | FR-007 | Change priority | Old/new values written to audit log | Audit |
| TC-RLS-001 | NFR-003 | Principal views another school | Access denied | Security |
| TC-EXPORT-001 | FR-009 | Counselor exports district data | Export blocked | Security |
| TC-DASH-001 | BREQ-004 | Compare dashboard open cases to SQL count | Counts match | Data validation |

## UAT approach

- UAT participants: 3 principals, 5 counselors, 2 support coordinators, 1 operations director, 1 BI lead
- Entry criteria: test environment loaded with sample data, roles configured, dashboard dataset refreshed
- Exit criteria: no critical defects, high defects remediated or accepted, UAT sign-off received

## Defect log template

| Defect ID | Title | Severity | Status | Requirement | Owner | Resolution notes |
|---|---|---|---|---|---|---|
| DEF-001 | SLA tile mismatch for school filter | High | Open | FR-004 | BI Lead | Measure filter context under review |
| DEF-002 | Assignment dropdown includes inactive users | Medium | Open | FR-003 | Product | Add active flag filter |
