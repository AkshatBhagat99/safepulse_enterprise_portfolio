-- SafePulse SQL Schema - PostgreSQL oriented with SQL Server notes in comments
CREATE TABLE district (
    district_id INT PRIMARY KEY,
    district_name VARCHAR(150) NOT NULL,
    state_code CHAR(2) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE schools (
    school_id INT PRIMARY KEY,
    district_id INT NOT NULL REFERENCES district(district_id),
    school_name VARCHAR(150) NOT NULL,
    region VARCHAR(50) NOT NULL,
    school_level VARCHAR(50) NOT NULL,
    active_flag BOOLEAN NOT NULL DEFAULT TRUE
);
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    active_flag BOOLEAN NOT NULL DEFAULT TRUE
);
CREATE TABLE academic_terms (
    term_id INT PRIMARY KEY,
    term_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);
CREATE TABLE students_anonymized (
    student_id INT PRIMARY KEY,
    school_id INT NOT NULL REFERENCES schools(school_id),
    grade_band VARCHAR(20) NOT NULL,
    anonymized_student_key VARCHAR(64) NOT NULL UNIQUE,
    active_flag BOOLEAN NOT NULL DEFAULT TRUE
);
CREATE TABLE roles (
    role_id INT PRIMARY KEY,
    role_name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE permissions (
    permission_id INT PRIMARY KEY,
    permission_name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE role_permissions (
    role_id INT REFERENCES roles(role_id),
    permission_id INT REFERENCES permissions(permission_id),
    PRIMARY KEY(role_id, permission_id)
);
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    school_id INT NULL REFERENCES schools(school_id),
    department_id INT NULL REFERENCES departments(department_id),
    display_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    active_flag BOOLEAN NOT NULL DEFAULT TRUE
);
CREATE TABLE user_roles (
    user_id INT REFERENCES users(user_id),
    role_id INT REFERENCES roles(role_id),
    PRIMARY KEY(user_id, role_id)
);
CREATE TABLE counselors (
    counselor_id INT PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id),
    max_active_cases INT NOT NULL DEFAULT 35,
    specialty VARCHAR(100) NULL
);
CREATE TABLE case_categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    category_group VARCHAR(100) NOT NULL,
    active_flag BOOLEAN NOT NULL DEFAULT TRUE
);
CREATE TABLE sla_policy (
    sla_policy_id INT PRIMARY KEY,
    priority VARCHAR(20) NOT NULL,
    category_id INT NOT NULL REFERENCES case_categories(category_id),
    response_due_hours INT NOT NULL,
    resolution_due_days INT NOT NULL,
    active_flag BOOLEAN NOT NULL DEFAULT TRUE
);
CREATE TABLE support_requests (
    request_id BIGINT PRIMARY KEY,
    school_id INT NOT NULL REFERENCES schools(school_id),
    student_id INT NULL REFERENCES students_anonymized(student_id),
    category_id INT NOT NULL REFERENCES case_categories(category_id),
    term_id INT NOT NULL REFERENCES academic_terms(term_id),
    priority VARCHAR(20) NOT NULL,
    intake_channel VARCHAR(50) NOT NULL,
    current_status VARCHAR(50) NOT NULL,
    submitted_at TIMESTAMP NOT NULL,
    first_response_at TIMESTAMP NULL,
    resolved_at TIMESTAMP NULL,
    closed_at TIMESTAMP NULL,
    reopened_flag BOOLEAN NOT NULL DEFAULT FALSE,
    sla_policy_id INT NOT NULL REFERENCES sla_policy(sla_policy_id)
);
CREATE TABLE case_assignments (
    assignment_id BIGINT PRIMARY KEY,
    request_id BIGINT NOT NULL REFERENCES support_requests(request_id),
    assigned_user_id INT NOT NULL REFERENCES users(user_id),
    assigned_at TIMESTAMP NOT NULL,
    unassigned_at TIMESTAMP NULL,
    assignment_reason VARCHAR(200) NULL
);
CREATE TABLE case_notes (
    note_id BIGINT PRIMARY KEY,
    request_id BIGINT NOT NULL REFERENCES support_requests(request_id),
    author_user_id INT NOT NULL REFERENCES users(user_id),
    note_type VARCHAR(50) NOT NULL,
    visibility_level VARCHAR(50) NOT NULL,
    note_text VARCHAR(2000) NOT NULL,
    created_at TIMESTAMP NOT NULL
);
CREATE TABLE follow_ups (
    follow_up_id BIGINT PRIMARY KEY,
    request_id BIGINT NOT NULL REFERENCES support_requests(request_id),
    owner_user_id INT NOT NULL REFERENCES users(user_id),
    due_at TIMESTAMP NOT NULL,
    completed_at TIMESTAMP NULL,
    follow_up_status VARCHAR(50) NOT NULL
);
CREATE TABLE escalations (
    escalation_id BIGINT PRIMARY KEY,
    request_id BIGINT NOT NULL REFERENCES support_requests(request_id),
    from_user_id INT NOT NULL REFERENCES users(user_id),
    to_department_id INT NOT NULL REFERENCES departments(department_id),
    escalation_reason VARCHAR(200) NOT NULL,
    escalated_at TIMESTAMP NOT NULL,
    resolved_at TIMESTAMP NULL
);
CREATE TABLE interventions (
    intervention_id BIGINT PRIMARY KEY,
    request_id BIGINT NOT NULL REFERENCES support_requests(request_id),
    intervention_type VARCHAR(100) NOT NULL,
    intervention_date DATE NOT NULL,
    recorded_by_user_id INT NOT NULL REFERENCES users(user_id)
);
CREATE TABLE status_history (
    status_history_id BIGINT PRIMARY KEY,
    request_id BIGINT NOT NULL REFERENCES support_requests(request_id),
    previous_status VARCHAR(50) NULL,
    new_status VARCHAR(50) NOT NULL,
    changed_by_user_id INT NOT NULL REFERENCES users(user_id),
    changed_at TIMESTAMP NOT NULL
);
CREATE TABLE notifications (
    notification_id BIGINT PRIMARY KEY,
    request_id BIGINT NULL REFERENCES support_requests(request_id),
    recipient_user_id INT NOT NULL REFERENCES users(user_id),
    notification_type VARCHAR(50) NOT NULL,
    sent_at TIMESTAMP NOT NULL,
    read_at TIMESTAMP NULL
);
CREATE TABLE audit_logs (
    audit_log_id BIGINT PRIMARY KEY,
    entity_type VARCHAR(100) NOT NULL,
    entity_id BIGINT NOT NULL,
    field_name VARCHAR(100) NOT NULL,
    old_value VARCHAR(500) NULL,
    new_value VARCHAR(500) NULL,
    changed_by_user_id INT NOT NULL REFERENCES users(user_id),
    changed_at TIMESTAMP NOT NULL
);
CREATE TABLE holiday_calendar (
    holiday_date DATE PRIMARY KEY,
    holiday_name VARCHAR(100) NOT NULL,
    district_id INT NOT NULL REFERENCES district(district_id)
);

CREATE INDEX idx_support_school_date ON support_requests(school_id, submitted_at);
CREATE INDEX idx_support_status_priority ON support_requests(current_status, priority);
CREATE INDEX idx_assign_request_user ON case_assignments(request_id, assigned_user_id);
CREATE INDEX idx_status_request_time ON status_history(request_id, changed_at);
CREATE INDEX idx_follow_due_complete ON follow_ups(due_at, completed_at);
CREATE INDEX idx_audit_entity_time ON audit_logs(entity_type, entity_id, changed_at);
