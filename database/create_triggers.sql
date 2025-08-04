BEGIN TRANSACTION;

-- Trigger for person
CREATE TRIGGER IF NOT EXISTS trigger_update_person_timestamp
AFTER UPDATE ON person
FOR EACH ROW
BEGIN
    UPDATE person
    SET date_updated = CURRENT_TIMESTAMP
    WHERE id = OLD.id;
END;

-- Trigger for employee
CREATE TRIGGER IF NOT EXISTS trigger_update_employee_timestamp
AFTER UPDATE ON employee
FOR EACH ROW
BEGIN
    UPDATE employee
    SET date_updated = CURRENT_TIMESTAMP
    WHERE employee_id = OLD.employee_id;
END;

-- Trigger for users
CREATE TRIGGER IF NOT EXISTS trigger_update_users_timestamp
AFTER UPDATE ON users
FOR EACH ROW
BEGIN
    UPDATE users
    SET date_updated = CURRENT_TIMESTAMP
    WHERE id = OLD.id;
END;

-- Trigger for daily_time_record
CREATE TRIGGER IF NOT EXISTS trigger_update_dtr_timestamp
AFTER UPDATE ON daily_time_record
FOR EACH ROW
BEGIN
    UPDATE daily_time_record
    SET date_updated = CURRENT_TIMESTAMP
    WHERE employee_id = OLD.employee_id AND date = OLD.date;
END;

COMMIT;
