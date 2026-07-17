-- Stored procedure examples
CREATE OR REPLACE FUNCTION refresh_monthly_school_kpis()
RETURNS VOID AS $$
BEGIN
    REFRESH MATERIALIZED VIEW mv_monthly_school_kpis;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_school_kpi_snapshot(p_school_id INT)
RETURNS TABLE(total_cases BIGINT, open_cases BIGINT, avg_response_hours NUMERIC, response_sla_rate NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT
        COUNT(*) AS total_cases,
        SUM(CASE WHEN current_status NOT IN ('Closed','Resolved') THEN 1 ELSE 0 END) AS open_cases,
        AVG(response_hours)::NUMERIC AS avg_response_hours,
        AVG(response_sla_met_flag::NUMERIC)::NUMERIC AS response_sla_rate
    FROM vw_case_kpi_base
    WHERE school_id = p_school_id;
END;
$$ LANGUAGE plpgsql;
