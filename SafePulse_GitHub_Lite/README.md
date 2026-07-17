# SafePulse — School Well-being Operations & Analytics Platform

**Tagline:** Helping schools improve student support operations through workflow intelligence, operational analytics, and executive decision support.

SafePulse is an enterprise Business Analysis and Data Analytics portfolio project modeled as a multi-month consulting implementation for a school district. The platform improves **case management, staffing visibility, SLA monitoring, workload balancing, executive reporting, and operational planning** for student support operations.

> SafePulse is not a diagnosis, clinical prediction, or medical risk-scoring system. All analytics are operational and process-focused.

## What this repository contains

- Enterprise discovery documentation, BRD, FRD, stakeholder analysis, process analysis, and governance artifacts
- Production-grade relational data model, dimensional analytics model, data dictionary, lineage, and metadata controls
- Lightweight sample dataset included for GitHub; the full 250,000+ row dataset can be regenerated locally
- 100+ SQL queries for KPI reporting, data quality, trend analysis, executive dashboards, optimization, and validation
- Power BI dashboard design specification with RLS, drillthrough, bookmarks, filters, tooltips, and KPI definitions
- UX wireframe specifications for case portal, counselor workspace, school overview, executive dashboards, and admin screens
- Testing package with UAT, regression, performance, security, accessibility, defect log, and RTM
- Portfolio package with resume bullets, STAR stories, LinkedIn post, GitHub structure, and interview talking points

## Repository map

| Folder | Purpose |
|---|---|
| `docs/01_business_discovery` | Business case, discovery, competitive analysis, SWOT, PESTLE, KPI strategy |
| `docs/02_stakeholder_analysis` | Stakeholders, personas, RACI/RASCI, comms, matrices, workshops |
| `docs/03_requirements` | BRD, FRD, backlog, user stories, RTM, prioritization |
| `docs/04_process` | AS-IS/TO-BE, gap analysis, BPMN-style flows, use cases |
| `docs/05_data_architecture` | ERD, dimensional model, data dictionary, lineage, governance |
| `docs/06_analytics` | KPI logic, dashboard specs, product analytics, recommendations |
| `docs/07_testing` | Test plan, UAT, defect log, test case mapping |
| `docs/08_project_management` | Charter, roadmap, sprint plan, RAID, status reports |
| `sql` | Schema, views, procedures, materialized views, 100+ queries |
| `data/sample_dataset_csv` | GitHub-friendly sample CSVs; use `scripts/generate_dataset.py` to regenerate the full dataset |
| `excel` | Excel-based delivery workbook exported separately |
| `presentation` | Executive PowerPoint deck exported separately |

## How to use this for a portfolio

1. Put this repository on GitHub with the README as the homepage.
2. Use the executive deck in interviews to walk through business problem, solution, data model, KPI framework, and impact.
3. Use the Excel workbook to demonstrate BA traceability: requirements → stories → test cases → KPIs.
4. Use SQL files to demonstrate DA depth: joins, window functions, validation queries, executive reporting, and performance tuning.
5. Add the resume bullets from `resume/resume_bullets.md` under a **Projects** section.

## Browser upload compatibility

This lightweight repository is designed for browser upload. It includes sample CSVs instead of the full generated dataset. Run `scripts/generate_dataset.py` locally when you need the complete 250,000+ row dataset.
