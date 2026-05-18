-- =========================================================================
-- CONFIGURAÇÃO DO AMBIENTE: BANCO DE DADOS PARKS AND RECREATION
-- =========================================================================

-- Garantindo um recomeço limpo: Apaga o banco se ele já existir e cria do zero.
DROP DATABASE IF EXISTS `Parks_and_Recreation`;
CREATE DATABASE `Parks_and_Recreation`;
USE `Parks_and_Recreation`;


-- =========================================================================
-- ESTRUTURAÇÃO DAS TABELAS (DDL)
-- =========================================================================

-- Tabela 1: Informações Pessoais (Demografia)
-- Chave Primária: employee_id
CREATE TABLE employee_demographics (
  employee_id INT NOT NULL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  age INT,
  gender VARCHAR(10),
  birth_date DATE,
  PRIMARY KEY (employee_id)
);

-- Tabela 2: Informações Financeiras e Profissionais (Salários)
-- Nota de estudo: Não definimos Chave Primária aqui para podermos analisar 
-- a relação entre as tabelas usando JOINS posteriormente.
CREATE TABLE employee_salary (
  employee_id INT NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  occupation VARCHAR(50),
  salary INT,
  dept_id INT
);

-- Tabela 3: Departamentos da Cidade
-- Chave Primária: department_id (Gerada automaticamente com AUTO_INCREMENT)
CREATE TABLE parks_departments (
  department_id INT NOT NULL AUTO_INCREMENT,
  department_name VARCHAR(50) NOT NULL,
  PRIMARY KEY (department_id)
);


-- =========================================================================
-- POPULANDO O BANCO DE DADOS (DML)
-- =========================================================================

-- Inserindo dados demográficos:
INSERT INTO employee_demographics (employee_id, first_name, last_name, age, gender, birth_date)
VALUES
(1, 'Leslie', 'Knope', 44, 'Female', '1979-09-25'),
(3, 'Tom', 'Haverford', 36, 'Male', '1987-03-04'),
(4, 'April', 'Ludgate', 29, 'Female', '1994-03-27'),
(5, 'Jerry', 'Gergich', 61, 'Male', '1962-08-28'),
(6, 'Donna', 'Meagle', 46, 'Female', '1977-07-30'),
(7, 'Ann', 'Perkins', 35, 'Female', '1988-12-01'),
(8, 'Chris', 'Traeger', 43, 'Male', '1980-11-11'),
(9, 'Ben', 'Wyatt', 38, 'Male', '1985-07-26'),
(10, 'Andy', 'Dwyer', 34, 'Male', '1989-03-25'),
(11, 'Mark', 'Brendanawicz', 40, 'Male', '1983-06-14'),
(12, 'Craig', 'Middlebrooks', 37, 'Male', '1986-07-27');


-- Inserindo dados salariais:
-- ATENÇÃO PARA OS CASOS ESPECIAIS (Ótimos para testes de INNER, LEFT e RIGHT JOIN):
-- * ID 2 (Ron Swanson): Está aqui com salário, mas NÃO existe na tabela demográfica!
-- * ID 10 (Andy Dwyer): Está aqui, mas o 'dept_id' é NULL (sem departamento)!
INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES
(1, 'Leslie', 'Knope', 'Deputy Director of Parks and Recreation', 75000, 1),
(2, 'Ron', 'Swanson', 'Director of Parks and Recreation', 70000, 1),
(3, 'Tom', 'Haverford', 'Entrepreneur', 50000, 1),
(4, 'April', 'Ludgate', 'Assistant to the Director of Parks and Recreation', 25000, 1),
(5, 'Jerry', 'Gergich', 'Office Manager', 50000, 1),
(6, 'Donna', 'Meagle', 'Office Manager', 60000, 1),
(7, 'Ann', 'Perkins', 'Nurse', 55000, 4),
(8, 'Chris', 'Traeger', 'City Manager', 90000, 3),
(9, 'Ben', 'Wyatt', 'State Auditor', 70000, 6),
(10, 'Andy', 'Dwyer', 'Shoe Shiner and Musician', 20000, NULL),
(11, 'Mark', 'Brendanawicz', 'City Planner', 57000, 3),
(12, 'Craig', 'Middlebrooks', 'Parks Director', 65000, 1);


-- Inserindo os Departamentos oficiais de Pawnee:
INSERT INTO parks_departments (department_name)
VALUES
('Parks and Recreation'), -- ID 1
('Animal Control'),        -- ID 2
('Public Works'),          -- ID 3
('Healthcare'),            -- ID 4
('Library'),               -- ID 5
('Finance');               -- ID 6


-- =========================================================================
-- SEU AMBIENTE ESTÁ PRONTO! 
-- =========================================================================
-- Daqui para a frente, você pode usar as tabelas acima para cruzar dados.
-- Exemplo rápido de teste para verificar se o banco subiu corretamente:
SELECT * FROM employee_demographics;
SELECT * FROM employee_salary;
SELECT * FROM parks_departments;