CREATE DATABASE cursor_1;
USE cursor_1;

CREATE TABLE IF NOT EXISTS employees (
    emp_id INT,
    emp_name VARCHAR(30),
    age INT
);

INSERT INTO employees (emp_id, emp_name, age) VALUES
(1, 'ARSHAD BAVA', 22),
(2, 'RIZWAN', 25),
(3, 'THAJU', 28),
(4, 'ANBU', 24);

DELIMITER $$

CREATE PROCEDURE display_employee_info()
BEGIN
    DECLARE v_name VARCHAR(30);
    DECLARE v_age INT;
    DECLARE done INT DEFAULT FALSE;  -- Declare 'done' to track when cursor is finished
    DECLARE output_string TEXT DEFAULT '';  -- Variable to accumulate output
    DECLARE emp_cursor CURSOR FOR 
        SELECT emp_name, age FROM employees;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN emp_cursor;
    read_loop: LOOP
        FETCH emp_cursor INTO v_name, v_age;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SET output_string = CONCAT(output_string, 
                                   'Employee Name: ', v_name, 
                                   ', Age: ', v_age, 
                                   '\n');
    END LOOP;
    CLOSE emp_cursor;
    SELECT output_string AS All_Employee_Info;
END $$

DELIMITER ;
CALL display_employee_info();
