-- SafePulse reporting views
CREATE VIEW vw_case_kpi_base AS
SELECT
    sr.request_id,
    sr.school_id,
    sc.school_name,
    sc.region,
    sc.school_level,
    sr.category_id,
    cc.category_name,
    sr.priority,
    sr.intake_channel,
    sr.current_status,
    sr.submitted_at,
    sr.first_response_at,
    sr.resolved_at,
    sr.closed_at,
    sr.reopened_flag,
    sp.response_due_hours,
    sp.resolution_due_days,
    EXTRACT(EPOCH FROM (sr.first_response_at - sr.submitted_at))/3600.0 AS response_hours,
    EXTRACT(EPOCH FROM (COALESCE(sr.resolved_at, CURRENT_TIMESTAMP) - sr.submitted_at))/86400.0 AS resolution_days,
    CASE WHEN sr.first_response_at IS NOT NULL AND EXTRACT(EPOCH FROM (sr.first_response_at - sr.submitted_at))/3600.0 <= sp.response_due_hours THEN 1 ELSE 0 END AS response_sla_met_flag,
    CASE WHEN sr.resolved_at IS NOT NULL AND EXTRACT(EPOCH FROM (sr.resolved_at - sr.submitted_at))/86400.0 <= sp.resolution_due_days THEN 1 ELSE 0 END AS resolution_sla_met_flag
FROM support_requests sr
JOIN schools sc ON sr.school_id = sc.school_id
JOIN case_categories cc ON sr.category_id = cc.category_id
JOIN sla_policy sp ON sr.sla_policy_id = sp.sla_policy_id;

CREATE VIEW vw_open_case_backlog AS
SELECT *
FROM vw_case_kpi_base
WHERE current_status NOT IN ('Closed','Resolved');

CREATE MATERIALIZED VIEW mv_monthly_school_kpis AS
SELECT
    school_id,
    school_name,
    DATE_TRUNC('month', submitted_at) AS month_start,
    COUNT(*) AS total_cases,
    SUM(CASE WHEN current_status NOT IN ('Closed','Resolved') THEN 1 ELSE 0 END) AS open_cases,
    AVG(response_hours) AS avg_response_hours,
    AVG(resolution_days) AS avg_resolution_days,
    AVG(response_sla_met_flag::NUMERIC) AS response_sla_rate,
    AVG(resolution_sla_met_flag::NUMERIC) AS resolution_sla_rate,
    AVG(CASE WHEN reopened_flag THEN 1 ELSE 0 END::NUMERIC) AS reopen_rate
FROM vw_case_kpi_base
GROUP BY school_id, school_name, DATE_TRUNC('month', submitted_at);
