# MySQL Employee Management System

## 📌 Project Overview

The Employee Management System is a MySQL database project developed to manage employee-related information such as personal details, job departments, salary and bonus details, qualifications, leaves, and payroll.

The project uses a relational database structure with primary keys and foreign keys to establish relationships between different tables.

## 🎯 Objectives

- Manage employee information
- Store job and department details
- Manage salary and bonus information
- Maintain employee qualification records
- Track employee leave details
- Manage payroll information
- Perform SQL-based data analysis

## 🛠️ Technologies Used

- MySQL
- SQL
- Relational Database Management System (RDBMS)

## 🗄️ Database Tables

The database consists of six tables:

### 1. JobDepartment
Stores job and department information such as job ID, department, job name, description, and salary range.

### 2. SalaryBonus
Stores salary, annual salary, and bonus information associated with job departments.

### 3. Employee
Stores employee personal and professional details, including name, gender, age, contact, email, and job information.

### 4. Qualification
Stores employee qualification, position, requirements, and joining-date information.

### 5. Leaves
Stores employee leave records, including leave date and reason.

### 6. Payroll
Stores payroll information including employee, job, salary, leave, date, report, and total amount.

## 🔗 Database Relationships

The project uses foreign keys to establish relationships between the tables.

- SalaryBonus → JobDepartment
- Employee → JobDepartment
- Qualification → Employee
- Leaves → Employee
- Payroll → Employee
- Payroll → JobDepartment
- Payroll → SalaryBonus
- Payroll → Leaves

## 📊 SQL Analysis

The project includes SQL queries to analyze:

- Total number of employees
- Departments with the highest number of employees
- Average salary by department
- Top 5 highest-paid employees
- Total salary expenditure
- Job roles available in each department
- Highest salary job roles
- Total salary allocation by department

## 📁 Project Files

```text
MySQL-Employee-Management-System
│
├── Rajavolu_Sushmitha_EMS_Project.sql
└── README.md
