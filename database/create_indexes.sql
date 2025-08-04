BEGIN TRANSACTION;

-- Person indexes
CREATE INDEX IF NOT EXISTS idx_person_lastname ON person(last_name);
CREATE INDEX IF NOT EXISTS idx_person_email ON person(email);

-- Employee indexes
CREATE INDEX IF NOT EXISTS idx_employee_id ON employee(employee_id);
CREATE INDEX IF NOT EXISTS idx_employee_person_id ON employee(person_id);
CREATE INDEX IF NOT EXISTS idx_employee_status ON employee(employment_status);

-- Users indexes
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);
CREATE INDEX IF NOT EXISTS idx_users_person_id ON users(person_id);

-- DTR indexes
CREATE INDEX IF NOT EXISTS idx_dtr_employee_date ON daily_time_record(employee_id, date);
CREATE INDEX IF NOT EXISTS idx_dtr_date ON daily_time_record(date);

-- Payroll index
CREATE INDEX IF NOT EXISTS idx_payroll_employee_period
ON payroll(employee_id, pay_period_start, pay_period_end);

COMMIT;
