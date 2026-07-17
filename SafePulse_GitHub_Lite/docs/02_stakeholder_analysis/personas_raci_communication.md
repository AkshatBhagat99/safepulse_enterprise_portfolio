# Personas, RACI, and Communication Plan

## Personas

### Persona 1: School Counselor

- Goal: Manage assigned cases, document follow-ups, and avoid missing next steps.
- Pain points: Too many open items, manual reminders, fragmented notes, limited visibility into previous actions.
- Success measure: Reduced overdue follow-ups and lower active workload ambiguity.

### Persona 2: Support Coordinator

- Goal: Triage new requests, assign work fairly, and identify urgent operational blockers.
- Pain points: Manual queue monitoring, unclear ownership, inconsistent assignment rules.
- Success measure: Faster triage and fewer unassigned cases.

### Persona 3: Principal

- Goal: Understand school workload, SLA breaches, categories driving volume, and staffing concerns.
- Pain points: Limited school-level reporting, delayed updates, manual escalation tracking.
- Success measure: Daily visibility into backlog and operational risk.

### Persona 4: Superintendent

- Goal: Compare schools, monitor district performance, and plan staffing/resource allocation.
- Pain points: Slow executive reporting and inconsistent definitions across schools.
- Success measure: Reliable executive dashboard with district-wide KPIs.

## RACI

| Deliverable / Process | Superintendent | Operations Director | Counseling Director | Principal | Counselor | BI Lead | IT Security |
|---|---|---|---|---|---|---|---|
| Business case | A | R | C | C | I | C | I |
| Case workflow design | I | A/R | R | C | C | C | C |
| SLA policy | A | R | R | C | I | C | C |
| Data model | I | C | C | I | I | A/R | C |
| Access control | I | C | C | I | I | C | A/R |
| UAT | I | A | C | R | R | C | C |
| Dashboard sign-off | A | R | R | C | I | R | C |

## Communication matrix

| Meeting | Audience | Frequency | Purpose | Output |
|---|---|---|---|---|
| Steering committee | Executive sponsor, business owner, PM | Monthly | Decisions, risks, funding, scope | Status deck and decision log |
| Requirements workshop | Ops, counseling, principals, BA | Weekly during discovery | Elicit business and functional requirements | BRD/FRD updates |
| Data working session | BI, IT, BA, product | Weekly | Define source-to-target mapping and KPI logic | Data dictionary and lineage |
| Sprint review | Business users, product, delivery | Every 2 weeks | Demo completed features | Feedback and backlog changes |
| UAT triage | UAT users, QA, BA, product | 3x weekly during UAT | Defect review and prioritization | Defect log updates |

## Workshop agenda example

1. Review current intake and assignment workflow
2. Identify handoff points, bottlenecks, and rework loops
3. Validate proposed status lifecycle
4. Define SLA by priority and category
5. Confirm role-based permissions
6. Review reporting questions and KPI definitions
7. Capture open decisions and action items
