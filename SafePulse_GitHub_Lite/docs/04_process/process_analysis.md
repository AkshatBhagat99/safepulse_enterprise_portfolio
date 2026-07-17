# Business Process Analysis

## AS-IS process

```mermaid
flowchart LR
A[Request received by email/form/phone] --> B[Staff manually reviews]
B --> C{Who should own it?}
C --> D[Spreadsheet or email assignment]
D --> E[Counselor follows up]
E --> F[Manual notes]
F --> G[Principal asks for status]
G --> H[Manual reporting]
```

## TO-BE process

```mermaid
flowchart LR
A[Standard intake] --> B[Auto-create case]
B --> C[SLA clock starts]
C --> D[Triage queue]
D --> E[Rules-assisted assignment]
E --> F[Counselor workspace]
F --> G[Follow-up and notes]
G --> H{Escalation needed?}
H -- Yes --> I[Escalate to department]
H -- No --> J[Resolve and close]
I --> F
J --> K[Dashboards and audit history]
```

## Gap analysis

| Area | Current gap | Future capability | Benefit |
|---|---|---|---|
| Intake | Multiple unstructured channels | Standardized intake form and channel capture | Better classification and reporting |
| Assignment | Manual owner selection | Workload-informed assignment | Lower overload and faster ownership |
| SLA | Not consistently tracked | SLA rules by priority and category | Better accountability |
| Follow-up | Calendar/email reminders | System follow-up tasks | Fewer missed actions |
| Reporting | Manual consolidation | Automated dashboards | Faster executive reporting |
| Audit | Incomplete change history | Case status and field audit log | Stronger governance |

## Swimlane overview

```mermaid
flowchart TB
subgraph StudentParentTeacher
A[Submit request]
end
subgraph Coordinator
B[Review triage queue]
C[Assign case]
D[Escalate if needed]
end
subgraph Counselor
E[Review case]
F[Add notes]
G[Create follow-up]
H[Resolve case]
end
subgraph Leadership
I[Monitor dashboard]
J[Review SLA breaches]
K[Plan staffing]
end
A --> B --> C --> E --> F --> G --> H --> I
E --> D --> I
I --> J --> K
```

## State model

```mermaid
stateDiagram-v2
[*] --> New
New --> Triaged
Triaged --> Assigned
Assigned --> InProgress
InProgress --> PendingParent
InProgress --> PendingStudent
InProgress --> Escalated
PendingParent --> InProgress
PendingStudent --> InProgress
Escalated --> InProgress
InProgress --> Resolved
Resolved --> Closed
Closed --> Reopened
Reopened --> InProgress
Closed --> [*]
```

## Optimization opportunities

- Use SLA urgency to sort triage work.
- Use counselor active workload to guide assignment decisions.
- Standardize escalation reasons and target departments.
- Trigger follow-up reminders before due dates.
- Automate monthly school performance reports.
- Create exception reports for missing assignments, missing closure reasons, and aged cases.
