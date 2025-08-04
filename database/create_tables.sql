BEGIN TRANSACTION;

-- Person table
CREATE TABLE IF NOT EXISTS person (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    middle_name TEXT,
    last_name TEXT NOT NULL,
    name_extension TEXT,
    date_of_birth DATE NOT NULL,
    address TEXT NOT NULL,
    phone TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    gender TEXT,
    civil_status TEXT,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by TEXT NOT NULL,
    updated_by TEXT NOT NULL,
    UNIQUE(first_name, middle_name, last_name, name_extension)
);

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    role TEXT DEFAULT 'user',
    is_active BOOLEAN DEFAULT TRUE,
    last_login TIMESTAMP,
    person_id INTEGER,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by TEXT NOT NULL,
    updated_by TEXT NOT NULL,
    UNIQUE(person_id),
    FOREIGN KEY (person_id) REFERENCES person(id) ON DELETE SET NULL
);

-- Employee table
CREATE TABLE IF NOT EXISTS employee (
    employee_id TEXT PRIMARY KEY,
    employer TEXT NOT NULL,
    department TEXT NOT NULL,
    position TEXT NOT NULL,
    daily_rate DECIMAL(10, 2),
    date_hired DATE NOT NULL,
    employment_status TEXT DEFAULT 'active',
    person_id INTEGER NOT NULL,
    users_id INTEGER,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by TEXT NOT NULL,
    updated_by TEXT NOT NULL,
    FOREIGN KEY (person_id) REFERENCES person(id) ON DELETE CASCADE,
    FOREIGN KEY (users_id) REFERENCES users(id) ON DELETE SET NULL
);

-- Daily time record table
CREATE TABLE IF NOT EXISTS daily_time_record (
    employee_id TEXT NOT NULL,
    date DATE NOT NULL,
    morning_time_in TIMESTAMP,
    morning_time_out TIMESTAMP,
    afternoon_time_in TIMESTAMP,
    afternoon_time_out TIMESTAMP,
    total_hours REAL,
    approved_overtime BOOLEAN DEFAULT FALSE,
    approved_overtime_by TEXT,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by TEXT NOT NULL,
    updated_by TEXT NOT NULL,
    PRIMARY KEY (employee_id, date),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id) ON DELETE SET NULL
);

-- Payroll table
CREATE TABLE IF NOT EXISTS payroll (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    employee_id TEXT NOT NULL,
    pay_period_start DATE NOT NULL,
    pay_period_end DATE NOT NULL,
    basic_pay REAL NOT NULL,
    total_overtime_pay REAL DEFAULT 0,
    deductions REAL DEFAULT 0,
    net_pay REAL NOT NULL,
    date_generated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    generated_by TEXT NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id) ON DELETE SET NULL
);

COMMIT;
