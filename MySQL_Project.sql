CREATE DATABASE EMS_Project;
USE EMS_Project;
-- Table 1: Job Department
CREATE TABLE JobDepartment (
    Job_ID INT PRIMARY KEY,
    jobdept VARCHAR(50),
    name VARCHAR(100),
    description TEXT,
    salaryrange VARCHAR(50)
);
SHOW TABLES;

-- Table 2: Salary/Bonus
CREATE TABLE SalaryBonus (
    salary_ID INT PRIMARY KEY,
    Job_ID INT,
    amount DECIMAL(10,2),
    annual DECIMAL(10,2),
    bonus DECIMAL(10,2),
    CONSTRAINT fk_salary_job FOREIGN KEY (job_ID) REFERENCES JobDepartment(Job_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table 3: Employee
CREATE TABLE Employee (
    emp_ID INT PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    contact_add VARCHAR(100),
    emp_email VARCHAR(100) UNIQUE,
    emp_pass VARCHAR(50),
    Job_ID INT,
    CONSTRAINT fk_employee_job FOREIGN KEY (Job_ID)
        REFERENCES JobDepartment(Job_ID)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- Table 4: Qualification
CREATE TABLE Qualification (
    QualID INT PRIMARY KEY,
    Emp_ID INT,
    Position VARCHAR(50),
    Requirements VARCHAR(255),
    Date_In DATE,
    CONSTRAINT fk_qualification_emp FOREIGN KEY (Emp_ID)
        REFERENCES Employee(emp_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Table 5: Leaves
CREATE TABLE Leaves (
    leave_ID INT PRIMARY KEY,
    emp_ID INT,
    date DATE,
    reason TEXT,
    CONSTRAINT fk_leave_emp FOREIGN KEY (emp_ID) REFERENCES Employee(emp_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table 6: Payroll
CREATE TABLE Payroll (
    payroll_ID INT PRIMARY KEY,
    emp_ID INT,
    job_ID INT,
    salary_ID INT,
    leave_ID INT,
    date DATE,
    report TEXT,
    total_amount DECIMAL(10,2),
    CONSTRAINT fk_payroll_emp FOREIGN KEY (emp_ID) REFERENCES Employee(emp_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_payroll_job FOREIGN KEY (job_ID) REFERENCES JobDepartment(job_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_payroll_salary FOREIGN KEY (salary_ID) REFERENCES SalaryBonus(salary_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_payroll_leave FOREIGN KEY (leave_ID) REFERENCES Leaves(leave_ID)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- Insert departments and jobs
INSERT INTO JobDepartment VALUES
(1,'IT','Software Developer','Develops applications','40000-80000'), 
(2,'HR','HR Executive','Handles recruitment','30000-60000'),
(3,'Finance','Accountant','Manages accounts','35000-70000'),
(4,'IT','Data Analyst','Analyzes company data','45000-90000'),
(5,'Admin','Office Admin','Manages office operations','25000-50000');
 
-- Insert salary details
INSERT INTO SalaryBonus VALUES 
(101,1,60000,720000,5000), 
(102,2,40000,480000,3000), 
(103,3,50000,600000,4000), 
(104,4,70000,840000,6000), 
(105,5,30000,360000,2000);

-- Insert employees
INSERT INTO Employee VALUES
(1,'Sushmitha','Rajavolu','Female',21,'Badvel','sushmitha@gmail.com','pass123',1),
(2,'Ravi','Kumar','Male',28,'Hyderabad','ravi@gmail.com','pass234',4),
(3,'Anjali','Reddy','Female',25,'Kurnool','anjali@gmail.com','pass345',2),
(4,'Karthik','Varma','Male',30,'Vijayawada','karthik@gmail.com','pass456',3),
(5,'Meena','Naik','Female',27,'Tirupati','meena@gmail.com','pass567',5);

-- Insert qualifications
INSERT INTO Qualification VALUES
(1,1,'Software Developer','Python, SQL','2025-01-10'),
(2,2,'Data Analyst','Python, Power BI','2024-12-05'),
(3,3,'HR Executive','Communication, Recruitment','2024-11-15'),
(4,4,'Accountant','Tally, Excel','2025-02-20'),
(5,1,'Software Developer','Git, OOPs','2025-03-01');

-- Insert leave records
INSERT INTO Leaves VALUES 
(1,1,'2025-06-10','Sick Leave'), 
(2,2,'2025-06-15','Personal Work'), 
(3,3,'2025-07-01','Vacation'), 
(4,1,'2025-07-05','Family Function');

-- Insert payroll records
INSERT INTO Payroll VALUES
(1,1,1,101,1,'2025-07-31','Monthly Salary',58000),
(2,2,4,104,2,'2025-07-31','Monthly Salary',68000),
(3,3,2,102,3,'2025-07-31','Monthly Salary',39000),
(4,4,3,103,NULL,'2025-07-31','Monthly Salary',50000),
(5,5,5,105,NULL,'2025-07-31','Monthly Salary',30000);
SELECT * FROM JobDepartment;
SELECT * FROM Employee;
SELECT * FROM Payroll;

/*Problem Statement:
The objective of this project is to design and implement an Employee Management System that efficiently stores and manages employee-related data within an organization. 
The system needs to track various aspects of employee information, including personal details, job roles, salary structures, qualifications, leave records, and payroll data. 
The system should ensure the integrity and consistency of data by using relational tables with appropriate foreign keys and cascading actions.
The system should allow for easy management and querying of employee data, providing insights such as payroll calculation, leave tracking, and department-specific job roles. 
The goal is to streamline HR operations, ensuring that all relevant employee data is accessible and accurately updated across different modules.*/

-- Analysis Questions
-- 1. EMPLOYEE INSIGHTS
/*How many unique employees are currently in the system?*/
SELECT COUNT(*) AS TOTALEMPLOYEES FROM EMPLOYEE;

/*Which departments have the highest number of employees?*/
SELECT JD.JOBDEPT, COUNT(E.EMP_ID) AS EMPLOYEECOUNT
FROM JOBDEPARTMENT JD
JOIN EMPLOYEE E ON JD.JOB_ID = E.JOB_ID
GROUP BY JD.JOBDEPT;

/*What is the average salary per department?*/
SELECT jd.jobdept, AVG(sb.amount) AS AvgSalary 
FROM JobDepartment jd 
JOIN SalaryBonus sb ON jd.Job_ID = sb.Job_ID 
GROUP BY jd.jobdept;

/*Who are the top 5 highest-paid employees?*/
SELECT e.firstname, e.lastname, sb.amount 
FROM Employee e 
JOIN SalaryBonus sb ON e.Job_ID = sb.Job_ID 
ORDER BY sb.amount DESC 
LIMIT 5;

/*What is the total salary expenditure across the company?*/
SELECT SUM(AMOUNT) AS TOTALSALARY
FROM SALARYBONUS;

-- 2. JOB ROLE AND DEPARTMENT ANALYSIS
/*How many different job roles exist in each department?*/
SELECT jobdept, COUNT(name) AS TotalJobRoles
FROM JobDepartment
GROUP BY jobdept;

/*What is the average salary range per department?*/
SELECT jobdept, AVG(sb.amount) AS AvgSalary
FROM JobDepartment jd
JOIN SalaryBonus sb ON jd.Job_ID = sb.Job_ID
GROUP BY jobdept;

/*Which job roles offer the highest salary?*/
SELECT jd.name, sb.amount
FROM JobDepartment jd
JOIN SalaryBonus sb ON jd.Job_ID = sb.Job_ID
ORDER BY sb.amount DESC;

/*Which departments have the highest total salary allocation?*/
SELECT jd.jobdept, SUM(sb.amount) AS TotalSalary
FROM JobDepartment jd
JOIN SalaryBonus sb ON jd.Job_ID = sb.Job_ID
GROUP BY jd.jobdept
ORDER BY TotalSalary DESC;



