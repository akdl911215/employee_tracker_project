CREATE SCHEMA hr;

SET search_path TO hr;

CREATE TABLE regions (
                         region_id SERIAL PRIMARY KEY,
                         region_name VARCHAR(25)
);

CREATE TABLE countries (
                           country_id CHAR(2) PRIMARY KEY,
                           country_name VARCHAR(40),
                           region_id INT NOT NULL REFERENCES regions(region_id)
);

CREATE TABLE locations (
                           location_id SERIAL PRIMARY KEY,
                           street_address VARCHAR(40),
                           postal_code VARCHAR(12),
                           city VARCHAR(30) NOT NULL,
                           state_province VARCHAR(25),
                           country_id CHAR(2) NOT NULL REFERENCES countries(country_id)
);

CREATE TABLE departments (
                             department_id SERIAL PRIMARY KEY,
                             department_name VARCHAR(30) NOT NULL,
                             manager_id INT,
                             location_id INT REFERENCES locations(location_id)
);

CREATE TABLE jobs (
                      job_id VARCHAR(10) PRIMARY KEY,
                      job_title VARCHAR(35) NOT NULL,
                      min_salary NUMERIC(8, 0),
                      max_salary NUMERIC(8, 0)
);

CREATE TABLE employees (
                           employee_id SERIAL PRIMARY KEY,
                           first_name VARCHAR(20),
                           last_name VARCHAR(25) NOT NULL,
                           email VARCHAR(25) NOT NULL,
                           phone_number VARCHAR(20),
                           hire_date DATE NOT NULL,
                           job_id VARCHAR(10) NOT NULL REFERENCES jobs(job_id),
                           salary NUMERIC(8, 2) NOT NULL,
                           commission_pct NUMERIC(3, 2),
                           manager_id INT REFERENCES employees(employee_id),
                           department_id INT REFERENCES departments(department_id)
);

CREATE TABLE job_history (
                             employee_id INT NOT NULL REFERENCES employees(employee_id),
                             start_date DATE NOT NULL,
                             end_date DATE NOT NULL,
                             job_id VARCHAR(10) NOT NULL REFERENCES jobs(job_id),
                             department_id INT NOT NULL REFERENCES departments(department_id),
                             PRIMARY KEY (employee_id, start_date)
);

-- 뷰 생성
CREATE VIEW emp_details_view AS
SELECT
    e.employee_id,
    e.job_id,
    e.manager_id,
    e.department_id,
    d.location_id,
    l.country_id,
    e.first_name,
    e.last_name,
    e.salary,
    e.commission_pct,
    d.department_name,
    j.job_title,
    l.city,
    l.state_province,
    c.country_name,
    r.region_name
FROM employees e
         JOIN departments d ON e.department_id = d.department_id
         JOIN locations l ON d.location_id = l.location_id
         JOIN countries c ON l.country_id = c.country_id
         JOIN regions r ON c.region_id = r.region_id
         JOIN jobs j ON e.job_id = j.job_id;

-- 데이터 삽입
INSERT INTO regions
VALUES (
           1,
           'Europe'
       );

INSERT INTO regions
VALUES (
           2,
           'Americas'
       );

INSERT INTO regions
VALUES (
           3,
           'Asia'
       );

INSERT INTO regions
VALUES (
           4,
           'Middle East and Africa'
       );

COMMIT;

INSERT INTO countries
VALUES (
           'IT',
           'Italy',
           1
       );

INSERT INTO countries
VALUES (
           'JP',
           'Japan',
           3
       );

INSERT INTO countries
VALUES (
           'US',
           'United States of America',
           2
       );

INSERT INTO countries
VALUES (
           'CA',
           'Canada',
           2
       );

INSERT INTO countries
VALUES (
           'CN',
           'China',
           3
       );

INSERT INTO countries
VALUES (
           'IN',
           'India',
           3
       );

INSERT INTO countries
VALUES (
           'AU',
           'Australia',
           3
       );

INSERT INTO countries
VALUES (
           'ZW',
           'Zimbabwe',
           4
       );

INSERT INTO countries
VALUES (
           'SG',
           'Singapore',
           3
       );

INSERT INTO countries
VALUES (
           'UK',
           'United Kingdom',
           1
       );

INSERT INTO countries
VALUES (
           'FR',
           'France',
           1
       );

INSERT INTO countries
VALUES (
           'DE',
           'Germany',
           1
       );

INSERT INTO countries
VALUES (
           'ZM',
           'Zambia',
           4
       );

INSERT INTO countries
VALUES (
           'EG',
           'Egypt',
           4
       );

INSERT INTO countries
VALUES (
           'BR',
           'Brazil',
           2
       );

INSERT INTO countries
VALUES (
           'CH',
           'Switzerland',
           1
       );

INSERT INTO countries
VALUES (
           'NL',
           'Netherlands',
           1
       );

INSERT INTO countries
VALUES (
           'MX',
           'Mexico',
           2
       );

INSERT INTO countries
VALUES (
           'KW',
           'Kuwait',
           4
       );

INSERT INTO countries
VALUES (
           'IL',
           'Israel',
           4
       );

INSERT INTO countries
VALUES (
           'DK',
           'Denmark',
           1
       );

INSERT INTO countries
VALUES (
           'HK',
           'HongKong',
           3
       );

INSERT INTO countries
VALUES (
           'NG',
           'Nigeria',
           4
       );

INSERT INTO countries
VALUES (
           'AR',
           'Argentina',
           2
       );

INSERT INTO countries
VALUES (
           'BE',
           'Belgium',
           1
       );

COMMIT;

INSERT INTO locations
VALUES (
           1000,
           '1297 Via Cola di Rie',
           '00989',
           'Roma',
           NULL,
           'IT'
       );

INSERT INTO locations
VALUES (
           1100,
           '93091 Calle della Testa',
           '10934',
           'Venice',
           NULL,
           'IT'
       );

INSERT INTO locations
VALUES (
           1200,
           '2017 Shinjuku-ku',
           '1689',
           'Tokyo',
           'Tokyo Prefecture',
           'JP'
       );

INSERT INTO locations
VALUES (
           1300,
           '9450 Kamiya-cho',
           '6823',
           'Hiroshima',
           NULL,
           'JP'
       );

INSERT INTO locations
VALUES (
           1400,
           '2014 Jabberwocky Rd',
           '26192',
           'Southlake',
           'Texas',
           'US'
       );

INSERT INTO locations
VALUES (
           1500,
           '2011 Interiors Blvd',
           '99236',
           'South San Francisco',
           'California',
           'US'
       );

INSERT INTO locations
VALUES (
           1600,
           '2007 Zagora St',
           '50090',
           'South Brunswick',
           'New Jersey',
           'US'
       );

INSERT INTO locations
VALUES (
           1700,
           '2004 Charade Rd',
           '98199',
           'Seattle',
           'Washington',
           'US'
       );

INSERT INTO locations
VALUES (
           1800,
           '147 Spadina Ave',
           'M5V 2L7',
           'Toronto',
           'Ontario',
           'CA'
       );

INSERT INTO locations
VALUES (
           1900,
           '6092 Boxwood St',
           'YSW 9T2',
           'Whitehorse',
           'Yukon',
           'CA'
       );

INSERT INTO locations
VALUES (
           2000,
           '40-5-12 Laogianggen',
           '190518',
           'Beijing',
           NULL,
           'CN'
       );

INSERT INTO locations
VALUES (
           2100,
           '1298 Vileparle (E)',
           '490231',
           'Bombay',
           'Maharashtra',
           'IN'
       );

INSERT INTO locations
VALUES (
           2200,
           '12-98 Victoria Street',
           '2901',
           'Sydney',
           'New South Wales',
           'AU'
       );

INSERT INTO locations
VALUES (
           2300,
           '198 Clementi North',
           '540198',
           'Singapore',
           NULL,
           'SG'
       );

INSERT INTO locations
VALUES (
           2400,
           '8204 Arthur St',
           NULL,
           'London',
           NULL,
           'UK'
       );

INSERT INTO locations
VALUES (
           2500,
           'Magdalen Centre, The Oxford Science Park',
           'OX9 9ZB',
           'Oxford',
           'Oxford',
           'UK'
       );

INSERT INTO locations
VALUES (
           2600,
           '9702 Chester Road',
           '09629850293',
           'Stretford',
           'Manchester',
           'UK'
       );

INSERT INTO locations
VALUES (
           2700,
           'Schwanthalerstr. 7031',
           '80925',
           'Munich',
           'Bavaria',
           'DE'
       );

INSERT INTO locations
VALUES (
           2800,
           'Rua Frei Caneca 1360 ',
           '01307-002',
           'Sao Paulo',
           'Sao Paulo',
           'BR'
       );

INSERT INTO locations
VALUES (
           2900,
           '20 Rue des Corps-Saints',
           '1730',
           'Geneva',
           'Geneve',
           'CH'
       );

INSERT INTO locations
VALUES (
           3000,
           'Murtenstrasse 921',
           '3095',
           'Bern',
           'BE',
           'CH'
       );

INSERT INTO locations
VALUES (
           3100,
           'Pieter Breughelstraat 837',
           '3029SK',
           'Utrecht',
           'Utrecht',
           'NL'
       );

INSERT INTO locations
VALUES (
           3200,
           'Mariano Escobedo 9991',
           '11932',
           'Mexico City',
           'Distrito Federal,',
           'MX'
       );

INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id)
VALUES
    (1000, '1297 Via Cola di Rie', '00989', 'Roma', NULL, 'IT'),
    (1100, '93091 Calle della Testa', '10934', 'Venice', NULL, 'IT'),
    (1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP'),
    (1300, '9450 Kamiya-cho', '6823', 'Hiroshima', NULL, 'JP'),
    (1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US'),
    (1500, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US'),
    (1600, '2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 'US'),
    (1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US'),
    (1800, '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA'),
    (1900, '6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 'CA'),
    (2000, '40-5-12 Laogianggen', '190518', 'Beijing', NULL, 'CN'),
    (2100, '1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', 'IN'),
    (2200, '12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', 'AU'),
    (2300, '198 Clementi North', '540198', 'Singapore', NULL, 'SG'),
    (2400, '8204 Arthur St', NULL, 'London', NULL, 'UK'),
    (2500, 'Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford', 'UK'),
    (2600, '9702 Chester Road', '09629850293', 'Stretford', 'Manchester', 'UK'),
    (2700, 'Schwanthalerstr. 7031', '80925', 'Munich', 'Bavaria', 'DE'),
    (2800, 'Rua Frei Caneca 1360 ', '01307-002', 'Sao Paulo', 'Sao Paulo', 'BR'),
    (2900, '20 Rue des Corps-Saints', '1730', 'Geneva', 'Geneve', 'CH'),
    (3000, 'Murtenstrasse 921', '3095', 'Bern', 'BE', 'CH'),
    (3100, 'Pieter Breughelstraat 837', '3029SK', 'Utrecht', 'Utrecht', 'NL'),
    (3200, 'Mariano Escobedo 9991', '11932', 'Mexico City', 'Distrito Federal,', 'MX');


COMMIT;

SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO departments
VALUES (
           10,
           'Administration',
           200,
           1700
       );

INSERT INTO departments
VALUES (
           20,
           'Marketing',
           201,
           1800
       );

INSERT INTO departments
VALUES (
           30,
           'Purchasing',
           114,
           1700
       );

INSERT INTO departments
VALUES (
           40,
           'Human Resources',
           203,
           2400
       );

INSERT INTO departments
VALUES (
           50,
           'Shipping',
           121,
           1500
       );

INSERT INTO departments
VALUES (
           60,
           'IT',
           103,
           1400
       );

INSERT INTO departments
VALUES (
           70,
           'Public Relations',
           204,
           2700
       );

INSERT INTO departments
VALUES (
           80,
           'Sales',
           145,
           2500
       );

INSERT INTO departments
VALUES (
           90,
           'Executive',
           100,
           1700
       );

INSERT INTO departments
VALUES (
           100,
           'Finance',
           108,
           1700
       );

INSERT INTO departments
VALUES (
           110,
           'Accounting',
           205,
           1700
       );

INSERT INTO departments
VALUES (
           120,
           'Treasury',
           NULL,
           1700
       );

INSERT INTO departments
VALUES (
           130,
           'Corporate Tax',
           NULL,
           1700
       );

INSERT INTO departments
VALUES (
           140,
           'Control And Credit',
           NULL,
           1700
       );

INSERT INTO departments
VALUES (
           150,
           'Shareholder Services',
           NULL,
           1700
       );

INSERT INTO departments
VALUES (
           160,
           'Benefits',
           NULL,
           1700
       );

INSERT INTO departments
VALUES (
           170,
           'Manufacturing',
           NULL,
           1700
       );

INSERT INTO departments
VALUES (
           180,
           'Construction',
           NULL,
           1700
       );

INSERT INTO departments
VALUES (
           190,
           'Contracting',
           NULL,
           1700
       );

INSERT INTO departments
VALUES (
           200,
           'Operations',
           NULL,
           1700
       );

INSERT INTO departments
VALUES (
           210,
           'IT Support',
           NULL,
           1700
       );

INSERT INTO departments
VALUES (
           220,
           'NOC',
           NULL,
           1700
       );

INSERT INTO departments
VALUES (
           230,
           'IT Helpdesk',
           NULL,
           1700
       );

INSERT INTO departments
VALUES (
           240,
           'Government Sales',
           NULL,
           1700
       );

INSERT INTO departments
VALUES (
           250,
           'Retail Sales',
           NULL,
           1700
       );

INSERT INTO departments
VALUES (
           260,
           'Recruiting',
           NULL,
           1700
       );

INSERT INTO departments
VALUES (
           270,
           'Payroll',
           NULL,
           1700
       );

SET FOREIGN_KEY_CHECKS = 1;

COMMIT;

INSERT INTO jobs
VALUES (
           'AD_PRES',
           'President',
           20000,
           40000
       );

INSERT INTO jobs
VALUES (
           'AD_VP',
           'Administration Vice President',
           15000,
           30000
       );

INSERT INTO jobs
VALUES (
           'AD_ASST',
           'Administration Assistant',
           3000,
           6000
       );

INSERT INTO jobs
VALUES (
           'FI_MGR',
           'Finance Manager',
           8200,
           16000
       );

INSERT INTO jobs
VALUES (
           'FI_ACCOUNT',
           'Accountant',
           4200,
           9000
       );

INSERT INTO jobs
VALUES (
           'AC_MGR',
           'Accounting Manager',
           8200,
           16000
       );

INSERT INTO jobs
VALUES (
           'AC_ACCOUNT',
           'Public Accountant',
           4200,
           9000
       );

INSERT INTO jobs
VALUES (
           'SA_MAN',
           'Sales Manager',
           10000,
           20000
       );

INSERT INTO jobs
VALUES (
           'SA_REP',
           'Sales Representative',
           6000,
           12000
       );

INSERT INTO jobs
VALUES (
           'PU_MAN',
           'Purchasing Manager',
           8000,
           15000
       );

INSERT INTO jobs
VALUES (
           'PU_CLERK',
           'Purchasing Clerk',
           2500,
           5500
       );

INSERT INTO jobs
VALUES (
           'ST_MAN',
           'Stock Manager',
           5500,
           8500
       );

INSERT INTO jobs
VALUES (
           'ST_CLERK',
           'Stock Clerk',
           2000,
           5000
       );

INSERT INTO jobs
VALUES (
           'SH_CLERK',
           'Shipping Clerk',
           2500,
           5500
       );

INSERT INTO jobs
VALUES (
           'IT_PROG',
           'Programmer',
           4000,
           10000
       );

INSERT INTO jobs
VALUES (
           'MK_MAN',
           'Marketing Manager',
           9000,
           15000
       );

INSERT INTO jobs
VALUES (
           'MK_REP',
           'Marketing Representative',
           4000,
           9000
       );

INSERT INTO jobs
VALUES (
           'HR_REP',
           'Human Resources Representative',
           4000,
           9000
       );

INSERT INTO jobs
VALUES (
           'PR_REP',
           'Public Relations Representative',
           4500,
           10500
       );

INSERT INTO jobs (job_id, job_title, min_salary, max_salary)
VALUES
    ('AD_PRES', 'President', 20000, 40000),
    ('AD_VP', 'Administration Vice President', 15000, 30000),
    ('AD_ASST', 'Administration Assistant', 3000, 6000),
    ('FI_MGR', 'Finance Manager', 8200, 16000),
    ('FI_ACCOUNT', 'Accountant', 4200, 9000),
    ('AC_MGR', 'Accounting Manager', 8200, 16000),
    ('AC_ACCOUNT', 'Public Accountant', 4200, 9000),
    ('SA_MAN', 'Sales Manager', 10000, 20000),
    ('SA_REP', 'Sales Representative', 6000, 12000),
    ('PU_MAN', 'Purchasing Manager', 8000, 15000),
    ('PU_CLERK', 'Purchasing Clerk', 2500, 5500),
    ('ST_MAN', 'Stock Manager', 5500, 8500),
    ('ST_CLERK', 'Stock Clerk', 2000, 5000),
    ('SH_CLERK', 'Shipping Clerk', 2500, 5500),
    ('IT_PROG', 'Programmer', 4000, 10000),
    ('MK_MAN', 'Marketing Manager', 9000, 15000),
    ('MK_REP', 'Marketing Representative', 4000, 9000),
    ('HR_REP', 'Human Resources Representative', 4000, 9000),
    ('PR_REP', 'Public Relations Representative', 4500, 10500);



COMMIT;


INSERT INTO employees
VALUES (
           100,
           'Steven',
           'King',
           'SKING',
           '515.123.4567',
           TO_DATE('17-JUN-1987', 'DD-MON-YYYY'),
           'AD_PRES',
           24000,
           NULL,
           NULL,
           90
       );

INSERT INTO employees
VALUES (
           101,
           'Neena',
           'Kochhar',
           'NKOCHHAR',
           '515.123.4568',
           TO_DATE('21-SEP-1989', 'DD-MON-YYYY'),
           'AD_VP',
           17000,
           NULL,
           100,
           90
       );

INSERT INTO employees
VALUES (
           102,
           'Lex',
           'De Haan',
           'LDEHAAN',
           '515.123.4569',
           TO_DATE('13-JAN-1993', 'DD-MON-YYYY'),
           'AD_VP',
           17000,
           NULL,
           100,
           90
       );

INSERT INTO employees
VALUES (
           103,
           'Alexander',
           'Hunold',
           'AHUNOLD',
           '590.423.4567',
           TO_DATE('03-JAN-1990', 'DD-MON-YYYY'),
           'IT_PROG',
           9000,
           NULL,
           102,
           60
       );

INSERT INTO employees
VALUES (
           104,
           'Bruce',
           'Ernst',
           'BERNST',
           '590.423.4568',
           TO_DATE('21-MAY-1991', 'DD-MON-YYYY'),
           'IT_PROG',
           6000,
           NULL,
           103,
           60
       );

INSERT INTO employees
VALUES (
           105,
           'David',
           'Austin',
           'DAUSTIN',
           '590.423.4569',
           TO_DATE('25-JUN-1997', 'DD-MON-YYYY'),
           'IT_PROG',
           4800,
           NULL,
           103,
           60
       );

INSERT INTO employees
VALUES (
           106,
           'Valli',
           'Pataballa',
           'VPATABAL',
           '590.423.4560',
           TO_DATE('05-FEB-1998', 'DD-MON-YYYY'),
           'IT_PROG',
           4800,
           NULL,
           103,
           60
       );

INSERT INTO employees
VALUES (
           107,
           'Diana',
           'Lorentz',
           'DLORENTZ',
           '590.423.5567',
           TO_DATE('07-FEB-1999', 'DD-MON-YYYY'),
           'IT_PROG',
           4200,
           NULL,
           103,
           60
       );

INSERT INTO employees
VALUES (
           108,
           'Nancy',
           'Greenberg',
           'NGREENBE',
           '515.124.4569',
           TO_DATE('17-AUG-1994', 'DD-MON-YYYY'),
           'FI_MGR',
           12000,
           NULL,
           101,
           100
       );

INSERT INTO employees
VALUES (
           109,
           'Daniel',
           'Faviet',
           'DFAVIET',
           '515.124.4169',
           TO_DATE('16-AUG-1994', 'DD-MON-YYYY'),
           'FI_ACCOUNT',
           9000,
           NULL,
           108,
           100
       );

INSERT INTO employees
VALUES (
           110,
           'John',
           'Chen',
           'JCHEN',
           '515.124.4269',
           TO_DATE('28-SEP-1997', 'DD-MON-YYYY'),
           'FI_ACCOUNT',
           8200,
           NULL,
           108,
           100
       );

INSERT INTO employees
VALUES (
           111,
           'Ismael',
           'Sciarra',
           'ISCIARRA',
           '515.124.4369',
           TO_DATE('30-SEP-1997', 'DD-MON-YYYY'),
           'FI_ACCOUNT',
           7700,
           NULL,
           108,
           100
       );

INSERT INTO employees
VALUES (
           112,
           'Jose Manuel',
           'Urman',
           'JMURMAN',
           '515.124.4469',
           TO_DATE('07-MAR-1998', 'DD-MON-YYYY'),
           'FI_ACCOUNT',
           7800,
           NULL,
           108,
           100
       );

INSERT INTO employees
VALUES (
           113,
           'Luis',
           'Popp',
           'LPOPP',
           '515.124.4567',
           TO_DATE('07-DEC-1999', 'DD-MON-YYYY'),
           'FI_ACCOUNT',
           6900,
           NULL,
           108,
           100
       );

INSERT INTO employees
VALUES (
           114,
           'Den',
           'Raphaely',
           'DRAPHEAL',
           '515.127.4561',
           TO_DATE('07-DEC-1994', 'DD-MON-YYYY'),
           'PU_MAN',
           11000,
           NULL,
           100,
           30
       );

INSERT INTO employees
VALUES (
           115,
           'Alexander',
           'Khoo',
           'AKHOO',
           '515.127.4562',
           TO_DATE('18-MAY-1995', 'DD-MON-YYYY'),
           'PU_CLERK',
           3100,
           NULL,
           114,
           30
       );

INSERT INTO employees
VALUES (
           116,
           'Shelli',
           'Baida',
           'SBAIDA',
           '515.127.4563',
           TO_DATE('24-DEC-1997', 'DD-MON-YYYY'),
           'PU_CLERK',
           2900,
           NULL,
           114,
           30
       );

INSERT INTO employees
VALUES (
           117,
           'Sigal',
           'Tobias',
           'STOBIAS',
           '515.127.4564',
           TO_DATE('24-JUL-1997', 'DD-MON-YYYY'),
           'PU_CLERK',
           2800,
           NULL,
           114,
           30
       );

INSERT INTO employees
VALUES (
           118,
           'Guy',
           'Himuro',
           'GHIMURO',
           '515.127.4565',
           TO_DATE('15-NOV-1998', 'DD-MON-YYYY'),
           'PU_CLERK',
           2600,
           NULL,
           114,
           30
       );

INSERT INTO employees
VALUES (
           119,
           'Karen',
           'Colmenares',
           'KCOLMENA',
           '515.127.4566',
           TO_DATE('10-AUG-1999', 'DD-MON-YYYY'),
           'PU_CLERK',
           2500,
           NULL,
           114,
           30
       );

INSERT INTO employees
VALUES (
           120,
           'Matthew',
           'Weiss',
           'MWEISS',
           '650.123.1234',
           TO_DATE('18-JUL-1996', 'DD-MON-YYYY'),
           'ST_MAN',
           8000,
           NULL,
           100,
           50
       );

INSERT INTO employees
VALUES (
           121,
           'Adam',
           'Fripp',
           'AFRIPP',
           '650.123.2234',
           TO_DATE('10-APR-1997', 'DD-MON-YYYY'),
           'ST_MAN',
           8200,
           NULL,
           100,
           50
       );

INSERT INTO employees
VALUES (
           122,
           'Payam',
           'Kaufling',
           'PKAUFLIN',
           '650.123.3234',
           TO_DATE('01-MAY-1995', 'DD-MON-YYYY'),
           'ST_MAN',
           7900,
           NULL,
           100,
           50
       );

INSERT INTO employees
VALUES (
           123,
           'Shanta',
           'Vollman',
           'SVOLLMAN',
           '650.123.4234',
           TO_DATE('10-OCT-1997', 'DD-MON-YYYY'),
           'ST_MAN',
           6500,
           NULL,
           100,
           50
       );

INSERT INTO employees
VALUES (
           124,
           'Kevin',
           'Mourgos',
           'KMOURGOS',
           '650.123.5234',
           TO_DATE('16-NOV-1999', 'DD-MON-YYYY'),
           'ST_MAN',
           5800,
           NULL,
           100,
           50
       );

INSERT INTO employees
VALUES (
           125,
           'Julia',
           'Nayer',
           'JNAYER',
           '650.124.1214',
           TO_DATE('16-JUL-1997', 'DD-MON-YYYY'),
           'ST_CLERK',
           3200,
           NULL,
           120,
           50
       );

INSERT INTO employees
VALUES (
           126,
           'Irene',
           'Mikkilineni',
           'IMIKKILI',
           '650.124.1224',
           TO_DATE('28-SEP-1998', 'DD-MON-YYYY'),
           'ST_CLERK',
           2700,
           NULL,
           120,
           50
       );

INSERT INTO employees
VALUES (
           127,
           'James',
           'Landry',
           'JLANDRY',
           '650.124.1334',
           TO_DATE('14-JAN-1999', 'DD-MON-YYYY'),
           'ST_CLERK',
           2400,
           NULL,
           120,
           50
       );

INSERT INTO employees
VALUES (
           128,
           'Steven',
           'Markle',
           'SMARKLE',
           '650.124.1434',
           TO_DATE('08-MAR-2000', 'DD-MON-YYYY'),
           'ST_CLERK',
           2200,
           NULL,
           120,
           50
       );

INSERT INTO employees
VALUES (
           129,
           'Laura',
           'Bissot',
           'LBISSOT',
           '650.124.5234',
           TO_DATE('20-AUG-1997', 'DD-MON-YYYY'),
           'ST_CLERK',
           3300,
           NULL,
           121,
           50
       );

INSERT INTO employees
VALUES (
           130,
           'Mozhe',
           'Atkinson',
           'MATKINSO',
           '650.124.6234',
           TO_DATE('30-OCT-1997', 'DD-MON-YYYY'),
           'ST_CLERK',
           2800,
           NULL,
           121,
           50
       );

INSERT INTO employees
VALUES (
           131,
           'James',
           'Marlow',
           'JAMRLOW',
           '650.124.7234',
           TO_DATE('16-FEB-1997', 'DD-MON-YYYY'),
           'ST_CLERK',
           2500,
           NULL,
           121,
           50
       );

INSERT INTO employees
VALUES (
           132,
           'TJ',
           'Olson',
           'TJOLSON',
           '650.124.8234',
           TO_DATE('10-APR-1999', 'DD-MON-YYYY'),
           'ST_CLERK',
           2100,
           NULL,
           121,
           50
       );

INSERT INTO employees
VALUES (
           133,
           'Jason',
           'Mallin',
           'JMALLIN',
           '650.127.1934',
           TO_DATE('14-JUN-1996', 'DD-MON-YYYY'),
           'ST_CLERK',
           3300,
           NULL,
           122,
           50
       );

INSERT INTO employees
VALUES (
           134,
           'Michael',
           'Rogers',
           'MROGERS',
           '650.127.1834',
           TO_DATE('26-AUG-1998', 'DD-MON-YYYY'),
           'ST_CLERK',
           2900,
           NULL,
           122,
           50
       );

INSERT INTO employees
VALUES (
           135,
           'Ki',
           'Gee',
           'KGEE',
           '650.127.1734',
           TO_DATE('12-DEC-1999', 'DD-MON-YYYY'),
           'ST_CLERK',
           2400,
           NULL,
           122,
           50
       );

INSERT INTO employees
VALUES (
           136,
           'Hazel',
           'Philtanker',
           'HPHILTAN',
           '650.127.1634',
           TO_DATE('06-FEB-2000', 'DD-MON-YYYY'),
           'ST_CLERK',
           2200,
           NULL,
           122,
           50
       );

INSERT INTO employees
VALUES (
           137,
           'Renske',
           'Ladwig',
           'RLADWIG',
           '650.121.1234',
           TO_DATE('14-JUL-1995', 'DD-MON-YYYY'),
           'ST_CLERK',
           3600,
           NULL,
           123,
           50
       );

INSERT INTO employees
VALUES (
           138,
           'Stephen',
           'Stiles',
           'SSTILES',
           '650.121.2034',
           TO_DATE('26-OCT-1997', 'DD-MON-YYYY'),
           'ST_CLERK',
           3200,
           NULL,
           123,
           50
       );

INSERT INTO employees
VALUES (
           139,
           'John',
           'Seo',
           'JSEO',
           '650.121.2019',
           TO_DATE('12-FEB-1998', 'DD-MON-YYYY'),
           'ST_CLERK',
           2700,
           NULL,
           123,
           50
       );

INSERT INTO employees
VALUES (
           140,
           'Joshua',
           'Patel',
           'JPATEL',
           '650.121.1834',
           TO_DATE('06-APR-1998', 'DD-MON-YYYY'),
           'ST_CLERK',
           2500,
           NULL,
           123,
           50
       );

INSERT INTO employees
VALUES (
           141,
           'Trenna',
           'Rajs',
           'TRAJS',
           '650.121.8009',
           TO_DATE('17-OCT-1995', 'DD-MON-YYYY'),
           'ST_CLERK',
           3500,
           NULL,
           124,
           50
       );

INSERT INTO employees
VALUES (
           142,
           'Curtis',
           'Davies',
           'CDAVIES',
           '650.121.2994',
           TO_DATE('29-JAN-1997', 'DD-MON-YYYY'),
           'ST_CLERK',
           3100,
           NULL,
           124,
           50
       );

INSERT INTO employees
VALUES (
           143,
           'Randall',
           'Matos',
           'RMATOS',
           '650.121.2874',
           TO_DATE('15-MAR-1998', 'DD-MON-YYYY'),
           'ST_CLERK',
           2600,
           NULL,
           124,
           50
       );

INSERT INTO employees
VALUES (
           144,
           'Peter',
           'Vargas',
           'PVARGAS',
           '650.121.2004',
           TO_DATE('09-JUL-1998', 'DD-MON-YYYY'),
           'ST_CLERK',
           2500,
           NULL,
           124,
           50
       );

INSERT INTO employees
VALUES (
           145,
           'John',
           'Russell',
           'JRUSSEL',
           '011.44.1344.429268',
           TO_DATE('01-OCT-1996', 'DD-MON-YYYY'),
           'SA_MAN',
           14000,
           0.4,
           100,
           80
       );

INSERT INTO employees
VALUES (
           146,
           'Karen',
           'Partners',
           'KPARTNER',
           '011.44.1344.467268',
           TO_DATE('05-JAN-1997', 'DD-MON-YYYY'),
           'SA_MAN',
           13500,
           0.3,
           100,
           80
       );

INSERT INTO employees
VALUES (
           147,
           'Alberto',
           'Errazuriz',
           'AERRAZUR',
           '011.44.1344.429278',
           TO_DATE('10-MAR-1997', 'DD-MON-YYYY'),
           'SA_MAN',
           12000,
           0.3,
           100,
           80
       );

INSERT INTO employees
VALUES (
           148,
           'Gerald',
           'Cambrault',
           'GCAMBRAU',
           '011.44.1344.619268',
           TO_DATE('15-OCT-1999', 'DD-MON-YYYY'),
           'SA_MAN',
           11000,
           0.3,
           100,
           80
       );

INSERT INTO employees
VALUES (
           149,
           'Eleni',
           'Zlotkey',
           'EZLOTKEY',
           '011.44.1344.429018',
           TO_DATE('29-JAN-2000', 'DD-MON-YYYY'),
           'SA_MAN',
           10500,
           0.2,
           100,
           80
       );

INSERT INTO employees
VALUES (
           150,
           'Peter',
           'Tucker',
           'PTUCKER',
           '011.44.1344.129268',
           TO_DATE('30-JAN-1997', 'DD-MON-YYYY'),
           'SA_REP',
           10000,
           0.3,
           145,
           80
       );

INSERT INTO employees
VALUES (
           151,
           'David',
           'Bernstein',
           'DBERNSTE',
           '011.44.1344.345268',
           TO_DATE('24-MAR-1997', 'DD-MON-YYYY'),
           'SA_REP',
           9500,
           0.25,
           145,
           80
       );

INSERT INTO employees
VALUES (
           152,
           'Peter',
           'Hall',
           'PHALL',
           '011.44.1344.478968',
           TO_DATE('20-AUG-1997', 'DD-MON-YYYY'),
           'SA_REP',
           9000,
           0.25,
           145,
           80
       );

INSERT INTO employees
VALUES (
           153,
           'Christopher',
           'Olsen',
           'COLSEN',
           '011.44.1344.498718',
           TO_DATE('30-MAR-1998', 'DD-MON-YYYY'),
           'SA_REP',
           8000,
           0.2,
           145,
           80
       );

INSERT INTO employees
VALUES (
           154,
           'Nanette',
           'Cambrault',
           'NCAMBRAU',
           '011.44.1344.987668',
           TO_DATE('09-DEC-1998', 'DD-MON-YYYY'),
           'SA_REP',
           7500,
           0.2,
           145,
           80
       );

INSERT INTO employees
VALUES (
           155,
           'Oliver',
           'Tuvault',
           'OTUVAULT',
           '011.44.1344.486508',
           TO_DATE('23-NOV-1999', 'DD-MON-YYYY'),
           'SA_REP',
           7000,
           0.15,
           145,
           80
       );

INSERT INTO employees
VALUES (
           156,
           'Janette',
           'King',
           'JKING',
           '011.44.1345.429268',
           TO_DATE('30-JAN-1996', 'DD-MON-YYYY'),
           'SA_REP',
           10000,
           0.35,
           146,
           80
       );

INSERT INTO employees
VALUES (
           157,
           'Patrick',
           'Sully',
           'PSULLY',
           '011.44.1345.929268',
           TO_DATE('04-MAR-1996', 'DD-MON-YYYY'),
           'SA_REP',
           9500,
           0.35,
           146,
           80
       );

INSERT INTO employees
VALUES (
           158,
           'Allan',
           'McEwen',
           'AMCEWEN',
           '011.44.1345.829268',
           TO_DATE('01-AUG-1996', 'DD-MON-YYYY'),
           'SA_REP',
           9000,
           0.35,
           146,
           80
       );

INSERT INTO employees
VALUES (
           159,
           'Lindsey',
           'Smith',
           'LSMITH',
           '011.44.1345.729268',
           TO_DATE('10-MAR-1997', 'DD-MON-YYYY'),
           'SA_REP',
           8000,
           0.3,
           146,
           80
       );

INSERT INTO employees
VALUES (
           160,
           'Louise',
           'Doran',
           'LDORAN',
           '011.44.1345.629268',
           TO_DATE('15-DEC-1997', 'DD-MON-YYYY'),
           'SA_REP',
           7500,
           0.3,
           146,
           80
       );

INSERT INTO employees
VALUES (
           161,
           'Sarath',
           'Sewall',
           'SSEWALL',
           '011.44.1345.529268',
           TO_DATE('03-NOV-1998', 'DD-MON-YYYY'),
           'SA_REP',
           7000,
           0.25,
           146,
           80
       );

INSERT INTO employees
VALUES (
           162,
           'Clara',
           'Vishney',
           'CVISHNEY',
           '011.44.1346.129268',
           TO_DATE('11-NOV-1997', 'DD-MON-YYYY'),
           'SA_REP',
           10500,
           0.25,
           147,
           80
       );

INSERT INTO employees
VALUES (
           163,
           'Danielle',
           'Greene',
           'DGREENE',
           '011.44.1346.229268',
           TO_DATE('19-MAR-1999', 'DD-MON-YYYY'),
           'SA_REP',
           9500,
           0.15,
           147,
           80
       );

INSERT INTO employees
VALUES (
           164,
           'Mattea',
           'Marvins',
           'MMARVINS',
           '011.44.1346.329268',
           TO_DATE('24-JAN-2000', 'DD-MON-YYYY'),
           'SA_REP',
           7200,
           0.1,
           147,
           80
       );

INSERT INTO employees
VALUES (
           165,
           'David',
           'Lee',
           'DLEE',
           '011.44.1346.529268',
           TO_DATE('23-FEB-2000', 'DD-MON-YYYY'),
           'SA_REP',
           6800,
           0.1,
           147,
           80
       );

INSERT INTO employees
VALUES (
           166,
           'Sundar',
           'Ande',
           'SANDE',
           '011.44.1346.629268',
           TO_DATE('24-MAR-2000', 'DD-MON-YYYY'),
           'SA_REP',
           6400,
           0.1,
           147,
           80
       );

INSERT INTO employees
VALUES (
           167,
           'Amit',
           'Banda',
           'ABANDA',
           '011.44.1346.729268',
           TO_DATE('21-APR-2000', 'DD-MON-YYYY'),
           'SA_REP',
           6200,
           0.1,
           147,
           80
       );

INSERT INTO employees
VALUES (
           168,
           'Lisa',
           'Ozer',
           'LOZER',
           '011.44.1343.929268',
           TO_DATE('11-MAR-1997', 'DD-MON-YYYY'),
           'SA_REP',
           11500,
           0.25,
           148,
           80
       );

INSERT INTO employees
VALUES (
           169,
           'Harrison',
           'Bloom',
           'HBLOOM',
           '011.44.1343.829268',
           TO_DATE('23-MAR-1998', 'DD-MON-YYYY'),
           'SA_REP',
           10000,
           0.2,
           148,
           80
       );

INSERT INTO employees
VALUES (
           170,
           'Tayler',
           'Fox',
           'TFOX',
           '011.44.1343.729268',
           TO_DATE('24-JAN-1998', 'DD-MON-YYYY'),
           'SA_REP',
           9600,
           0.2,
           148,
           80
       );

INSERT INTO employees
VALUES (
           171,
           'William',
           'Smith',
           'WSMITH',
           '011.44.1343.629268',
           TO_DATE('23-FEB-1999', 'DD-MON-YYYY'),
           'SA_REP',
           7400,
           0.15,
           148,
           80
       );

INSERT INTO employees
VALUES (
           172,
           'Elizabeth',
           'Bates',
           'EBATES',
           '011.44.1343.529268',
           TO_DATE('24-MAR-1999', 'DD-MON-YYYY'),
           'SA_REP',
           7300,
           0.15,
           148,
           80
       );

INSERT INTO employees
VALUES (
           173,
           'Sundita',
           'Kumar',
           'SKUMAR',
           '011.44.1343.329268',
           TO_DATE('21-APR-2000', 'DD-MON-YYYY'),
           'SA_REP',
           6100,
           0.1,
           148,
           80
       );

INSERT INTO employees
VALUES (
           174,
           'Ellen',
           'Abel',
           'EABEL',
           '011.44.1644.429267',
           TO_DATE('11-MAY-1996', 'DD-MON-YYYY'),
           'SA_REP',
           11000,
           0.3,
           149,
           80
       );

INSERT INTO employees
VALUES (
           175,
           'Alyssa',
           'Hutton',
           'AHUTTON',
           '011.44.1644.429266',
           TO_DATE('19-MAR-1997', 'DD-MON-YYYY'),
           'SA_REP',
           8800,
           0.25,
           149,
           80
       );

INSERT INTO employees
VALUES (
           176,
           'Jonathon',
           'Taylor',
           'JTAYLOR',
           '011.44.1644.429265',
           TO_DATE('24-MAR-1998', 'DD-MON-YYYY'),
           'SA_REP',
           8600,
           0.2,
           149,
           80
       );

INSERT INTO employees
VALUES (
           177,
           'Jack',
           'Livingston',
           'JLIVINGS',
           '011.44.1644.429264',
           TO_DATE('23-APR-1998', 'DD-MON-YYYY'),
           'SA_REP',
           8400,
           0.2,
           149,
           80
       );

INSERT INTO employees
VALUES (
           178,
           'Kimberely',
           'Grant',
           'KGRANT',
           '011.44.1644.429263',
           TO_DATE('24-MAY-1999', 'DD-MON-YYYY'),
           'SA_REP',
           7000,
           0.15,
           149,
           NULL
       );

INSERT INTO employees
VALUES (
           179,
           'Charles',
           'Johnson',
           'CJOHNSON',
           '011.44.1644.429262',
           TO_DATE('04-JAN-2000', 'DD-MON-YYYY'),
           'SA_REP',
           6200,
           0.1,
           149,
           80
       );

INSERT INTO employees
VALUES (
           180,
           'Winston',
           'Taylor',
           'WTAYLOR',
           '650.507.9876',
           TO_DATE('24-JAN-1998', 'DD-MON-YYYY'),
           'SH_CLERK',
           3200,
           NULL,
           120,
           50
       );

INSERT INTO employees
VALUES (
           181,
           'Jean',
           'Fleaur',
           'JFLEAUR',
           '650.507.9877',
           TO_DATE('23-FEB-1998', 'DD-MON-YYYY'),
           'SH_CLERK',
           3100,
           NULL,
           120,
           50
       );

INSERT INTO employees
VALUES (
           182,
           'Martha',
           'Sullivan',
           'MSULLIVA',
           '650.507.9878',
           TO_DATE('21-JUN-1999', 'DD-MON-YYYY'),
           'SH_CLERK',
           2500,
           NULL,
           120,
           50
       );

INSERT INTO employees
VALUES (
           183,
           'Girard',
           'Geoni',
           'GGEONI',
           '650.507.9879',
           TO_DATE('03-FEB-2000', 'DD-MON-YYYY'),
           'SH_CLERK',
           2800,
           NULL,
           120,
           50
       );

INSERT INTO employees
VALUES (
           184,
           'Nandita',
           'Sarchand',
           'NSARCHAN',
           '650.509.1876',
           TO_DATE('27-JAN-1996', 'DD-MON-YYYY'),
           'SH_CLERK',
           4200,
           NULL,
           121,
           50
       );

INSERT INTO employees
VALUES (
           185,
           'Alexis',
           'Bull',
           'ABULL',
           '650.509.2876',
           TO_DATE('20-FEB-1997', 'DD-MON-YYYY'),
           'SH_CLERK',
           4100,
           NULL,
           121,
           50
       );

INSERT INTO employees
VALUES (
           186,
           'Julia',
           'Dellinger',
           'JDELLING',
           '650.509.3876',
           TO_DATE('24-JUN-1998', 'DD-MON-YYYY'),
           'SH_CLERK',
           3400,
           NULL,
           121,
           50
       );

INSERT INTO employees
VALUES (
           187,
           'Anthony',
           'Cabrio',
           'ACABRIO',
           '650.509.4876',
           TO_DATE('07-FEB-1999', 'DD-MON-YYYY'),
           'SH_CLERK',
           3000,
           NULL,
           121,
           50
       );

INSERT INTO employees
VALUES (
           188,
           'Kelly',
           'Chung',
           'KCHUNG',
           '650.505.1876',
           TO_DATE('14-JUN-1997', 'DD-MON-YYYY'),
           'SH_CLERK',
           3800,
           NULL,
           122,
           50
       );

INSERT INTO employees
VALUES (
           189,
           'Jennifer',
           'Dilly',
           'JDILLY',
           '650.505.2876',
           TO_DATE('13-AUG-1997', 'DD-MON-YYYY'),
           'SH_CLERK',
           3600,
           NULL,
           122,
           50
       );

INSERT INTO employees
VALUES (
           190,
           'Timothy',
           'Gates',
           'TGATES',
           '650.505.3876',
           TO_DATE('11-JUL-1998', 'DD-MON-YYYY'),
           'SH_CLERK',
           2900,
           NULL,
           122,
           50
       );

INSERT INTO employees
VALUES (
           191,
           'Randall',
           'Perkins',
           'RPERKINS',
           '650.505.4876',
           TO_DATE('19-DEC-1999', 'DD-MON-YYYY'),
           'SH_CLERK',
           2500,
           NULL,
           122,
           50
       );

INSERT INTO employees
VALUES (
           192,
           'Sarah',
           'Bell',
           'SBELL',
           '650.501.1876',
           TO_DATE('04-FEB-1996', 'DD-MON-YYYY'),
           'SH_CLERK',
           4000,
           NULL,
           123,
           50
       );

INSERT INTO employees
VALUES (
           193,
           'Britney',
           'Everett',
           'BEVERETT',
           '650.501.2876',
           TO_DATE('03-MAR-1997', 'DD-MON-YYYY'),
           'SH_CLERK',
           3900,
           NULL,
           123,
           50
       );

INSERT INTO employees
VALUES (
           194,
           'Samuel',
           'McCain',
           'SMCCAIN',
           '650.501.3876',
           TO_DATE('01-JUL-1998', 'DD-MON-YYYY'),
           'SH_CLERK',
           3200,
           NULL,
           123,
           50
       );

INSERT INTO employees
VALUES (
           195,
           'Vance',
           'Jones',
           'VJONES',
           '650.501.4876',
           TO_DATE('17-MAR-1999', 'DD-MON-YYYY'),
           'SH_CLERK',
           2800,
           NULL,
           123,
           50
       );

INSERT INTO employees
VALUES (
           196,
           'Alana',
           'Walsh',
           'AWALSH',
           '650.507.9811',
           TO_DATE('24-APR-1998', 'DD-MON-YYYY'),
           'SH_CLERK',
           3100,
           NULL,
           124,
           50
       );

INSERT INTO employees
VALUES (
           197,
           'Kevin',
           'Feeney',
           'KFEENEY',
           '650.507.9822',
           TO_DATE('23-MAY-1998', 'DD-MON-YYYY'),
           'SH_CLERK',
           3000,
           NULL,
           124,
           50
       );

INSERT INTO employees
VALUES (
           198,
           'Donald',
           'OConnell',
           'DOCONNEL',
           '650.507.9833',
           TO_DATE('21-JUN-1999', 'DD-MON-YYYY'),
           'SH_CLERK',
           2600,
           NULL,
           124,
           50
       );

INSERT INTO employees
VALUES (
           199,
           'Douglas',
           'Grant',
           'DGRANT',
           '650.507.9844',
           TO_DATE('13-JAN-2000', 'DD-MON-YYYY'),
           'SH_CLERK',
           2600,
           NULL,
           124,
           50
       );

INSERT INTO employees
VALUES (
           200,
           'Jennifer',
           'Whalen',
           'JWHALEN',
           '515.123.4444',
           TO_DATE('17-SEP-1987', 'DD-MON-YYYY'),
           'AD_ASST',
           4400,
           NULL,
           101,
           10
       );

INSERT INTO employees
VALUES (
           201,
           'Michael',
           'Hartstein',
           'MHARTSTE',
           '515.123.5555',
           TO_DATE('17-FEB-1996', 'DD-MON-YYYY'),
           'MK_MAN',
           13000,
           NULL,
           100,
           20
       );

INSERT INTO employees
VALUES (
           202,
           'Pat',
           'Fay',
           'PFAY',
           '603.123.6666',
           TO_DATE('17-AUG-1997', 'DD-MON-YYYY'),
           'MK_REP',
           6000,
           NULL,
           201,
           20
       );

INSERT INTO employees
VALUES (
           203,
           'Susan',
           'Mavris',
           'SMAVRIS',
           '515.123.7777',
           TO_DATE('07-JUN-1994', 'DD-MON-YYYY'),
           'HR_REP',
           6500,
           NULL,
           101,
           40
       );

INSERT INTO employees
VALUES (
           204,
           'Hermann',
           'Baer',
           'HBAER',
           '515.123.8888',
           TO_DATE('07-JUN-1994', 'DD-MON-YYYY'),
           'PR_REP',
           10000,
           NULL,
           101,
           70
       );

INSERT INTO employees
VALUES (
           205,
           'Shelley',
           'Higgins',
           'SHIGGINS',
           '515.123.8080',
           TO_DATE('07-JUN-1994', 'DD-MON-YYYY'),
           'AC_MGR',
           12000,
           NULL,
           101,
           110
       );

INSERT INTO employees
VALUES (
           206,
           'William',
           'Gietz',
           'WGIETZ',
           '515.123.8181',
           TO_DATE('07-JUN-1994', 'DD-MON-YYYY'),
           'AC_ACCOUNT',
           8300,
           NULL,
           205,
           110
       );

INSERT INTO employees (
    employee_id, first_name, last_name, email, phone_number, hire_date,
    job_id, salary, commission_pct, manager_id, department_id
)
VALUES
    (100, 'Steven', 'King', 'SKING', '515.123.4567', TO_DATE('17-JUN-1987', 'DD-MON-YYYY'), 'AD_PRES', 24000, NULL, NULL, 90),
    (101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', TO_DATE('21-SEP-1989', 'DD-MON-YYYY'), 'AD_VP', 17000, NULL, 100, 90),
    (102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', TO_DATE('13-JAN-1993', 'DD-MON-YYYY'), 'AD_VP', 17000, NULL, 100, 90),
    (103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', TO_DATE('03-JAN-1990', 'DD-MON-YYYY'), 'IT_PROG', 9000, NULL, 102, 60),
    (104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', TO_DATE('21-MAY-1991', 'DD-MON-YYYY'), 'IT_PROG', 6000, NULL, 103, 60),
    (105, 'David', 'Austin', 'DAUSTIN', '590.423.4569', TO_DATE('25-JUN-1997', 'DD-MON-YYYY'), 'IT_PROG', 4800, NULL, 103, 60),
    (106, 'Valli', 'Pataballa', 'VPATABAL', '590.423.4560', TO_DATE('05-FEB-1998', 'DD-MON-YYYY'), 'IT_PROG', 4800, NULL, 103, 60),
    (107, 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', TO_DATE('07-FEB-1999', 'DD-MON-YYYY'), 'IT_PROG', 4200, NULL, 103, 60),
    (108, 'Nancy', 'Greenberg', 'NGREENBE', '515.124.4569', TO_DATE('17-AUG-1994', 'DD-MON-YYYY'), 'FI_MGR', 12000, NULL, 101, 100),
    (109, 'Daniel', 'Faviet', 'DFAVIET', '515.124.4169', TO_DATE('16-AUG-1994', 'DD-MON-YYYY'), 'FI_ACCOUNT', 9000, NULL, 108, 100),
    (110, 'John', 'Chen', 'JCHEN', '515.124.4269', TO_DATE('28-SEP-1997', 'DD-MON-YYYY'), 'FI_ACCOUNT', 8200, NULL, 108, 100),
    (111, 'Ismael', 'Sciarra', 'ISCIARRA', '515.124.4369', TO_DATE('30-SEP-1997', 'DD-MON-YYYY'), 'FI_ACCOUNT', 7700, NULL, 108, 100),
    (112, 'Jose Manuel', 'Urman', 'JMURMAN', '515.124.4469', TO_DATE('07-MAR-1998', 'DD-MON-YYYY'), 'FI_ACCOUNT', 7800, NULL, 108, 100),
    (113, 'Luis', 'Popp', 'LPOPP', '515.124.4567', TO_DATE('07-DEC-1999', 'DD-MON-YYYY'), 'FI_ACCOUNT', 6900, NULL, 108, 100),
    (114, 'Den', 'Raphaely', 'DRAPHEAL', '515.127.4561', TO_DATE('07-DEC-1994', 'DD-MON-YYYY'), 'PU_MAN', 11000, NULL, 100, 30),
    (115, 'Alexander', 'Khoo', 'AKHOO', '515.127.4562', TO_DATE('18-MAY-1995', 'DD-MON-YYYY'), 'PU_CLERK', 3100, NULL, 114, 30),
    (116, 'Shelli', 'Baida', 'SBAIDA', '515.127.4563', TO_DATE('24-DEC-1997', 'DD-MON-YYYY'), 'PU_CLERK', 2900, NULL, 114, 30),
    (117, 'Sigal', 'Tobias', 'STOBIAS', '515.127.4564', TO_DATE('24-JUL-1997', 'DD-MON-YYYY'), 'PU_CLERK', 2800, NULL, 114, 30),
    (118, 'Guy', 'Himuro', 'GHIMURO', '515.127.4565', TO_DATE('15-NOV-1998', 'DD-MON-YYYY'), 'PU_CLERK', 2600, NULL, 114, 30),
    (119, 'Karen', 'Colmenares', 'KCOLMENA', '515.127.4566', TO_DATE('10-AUG-1999', 'DD-MON-YYYY'), 'PU_CLERK', 2500, NULL, 114, 30),
    (120, 'Matthew', 'Weiss', 'MWEISS', '650.123.1234', TO_DATE('18-JUL-1996', 'DD-MON-YYYY'), 'ST_MAN', 8000, NULL, 100, 50),
    (121, 'Adam', 'Fripp', 'AFRIPP', '650.123.2234', TO_DATE('10-APR-1997', 'DD-MON-YYYY'), 'ST_MAN', 8200, NULL, 100, 50),
    (122, 'Payam', 'Kaufling', 'PKAUFLIN', '650.123.3234', TO_DATE('01-MAY-1995', 'DD-MON-YYYY'), 'ST_MAN', 7900, NULL, 100, 50),
    (123, 'Shanta', 'Vollman', 'SVOLLMAN', '650.123.4234', TO_DATE('10-OCT-1997', 'DD-MON-YYYY'), 'ST_MAN', 6500, NULL, 100, 50),
    (124, 'Kevin', 'Mourgos', 'KMOURGOS', '650.123.5234', TO_DATE('16-NOV-1999', 'DD-MON-YYYY'), 'ST_MAN', 5800, NULL, 100, 50),
    (125, 'Julia', 'Nayer', 'JNAYER', '650.124.1214', TO_DATE('16-JUL-1997', 'DD-MON-YYYY'), 'ST_CLERK', 3200, NULL, 120, 50),
    (126, 'Irene', 'Mikkilineni', 'IMIKKILI', '650.124.1224', TO_DATE('28-SEP-1998', 'DD-MON-YYYY'), 'ST_CLERK', 2700, NULL, 120, 50),
    (127, 'James', 'Landry', 'JLANDRY', '650.124.1334', TO_DATE('14-JAN-1999', 'DD-MON-YYYY'), 'ST_CLERK', 2400, NULL, 120, 50),
    (128, 'Steven', 'Markle', 'SMARKLE', '650.124.1434', TO_DATE('08-MAR-2000', 'DD-MON-YYYY'), 'ST_CLERK', 2200, NULL, 120, 50),
    (129, 'Laura', 'Bissot', 'LBISSOT', '650.124.5234', TO_DATE('20-AUG-1997', 'DD-MON-YYYY'), 'ST_CLERK', 3300, NULL, 121, 50),
    (130, 'Mozhe', 'Atkinson', 'MATKINSO', '650.124.6234', TO_DATE('30-OCT-1997', 'DD-MON-YYYY'), 'ST_CLERK', 2800, NULL, 121, 50),
    (131, 'James', 'Marlow', 'JAMRLOW', '650.124.7234', TO_DATE('16-FEB-1997', 'DD-MON-YYYY'), 'ST_CLERK', 2500, NULL, 121, 50),
    (132, 'TJ', 'Olson', 'TJOLSON', '650.124.8234', TO_DATE('10-APR-1999', 'DD-MON-YYYY'), 'ST_CLERK', 2100, NULL, 121, 50),
    (133, 'Jason', 'Mallin', 'JMALLIN', '650.127.1934', TO_DATE('14-JUN-1996', 'DD-MON-YYYY'), 'ST_CLERK', 3300, NULL, 122, 50),
    (134, 'Michael', 'Rogers', 'MROGERS', '650.127.1834', TO_DATE('26-AUG-1998', 'DD-MON-YYYY'), 'ST_CLERK', 2900, NULL, 122, 50),
    (135, 'Ki', 'Gee', 'KGEE', '650.127.1734', TO_DATE('12-DEC-1999', 'DD-MON-YYYY'), 'ST_CLERK', 2400, NULL, 122, 50),
    (136, 'Hazel', 'Philtanker', 'HPHILTAN', '650.127.1634', TO_DATE('06-FEB-2000', 'DD-MON-YYYY'), 'ST_CLERK', 2200, NULL, 122, 50),
    (137, 'Renske', 'Ladwig', 'RLADWIG', '650.121.1234', TO_DATE('14-JUL-1995', 'DD-MON-YYYY'), 'ST_CLERK', 3600, NULL, 123, 50),
    (138, 'Stephen', 'Stiles', 'SSTILES', '650.121.2034', TO_DATE('26-OCT-1997', 'DD-MON-YYYY'), 'ST_CLERK', 3200, NULL, 123, 50),
    (139, 'John', 'Seo', 'JSEO', '650.121.2019', TO_DATE('12-FEB-1998', 'DD-MON-YYYY'), 'ST_CLERK', 2700, NULL, 123, 50),
    (140, 'Joshua', 'Patel', 'JPATEL', '650.121.1834', TO_DATE('06-APR-1998', 'DD-MON-YYYY'), 'ST_CLERK', 2500, NULL, 123, 50),
    (141, 'Trenna', 'Rajs', 'TRAJS', '650.121.8009', TO_DATE('17-OCT-1995', 'DD-MON-YYYY'), 'ST_CLERK', 3500, NULL, 124, 50),
    (142, 'Curtis', 'Davies', 'CDAVIES', '650.121.2994', TO_DATE('29-JAN-1997', 'DD-MON-YYYY'), 'ST_CLERK', 3100, NULL, 124, 50),
    (143, 'Randall', 'Matos', 'RMATOS', '650.121.2874', TO_DATE('15-MAR-1998', 'DD-MON-YYYY'), 'ST_CLERK', 2600, NULL, 124, 50),
    (144, 'Peter', 'Vargas', 'PVARGAS', '650.121.2004', TO_DATE('09-JUL-1998', 'DD-MON-YYYY'), 'ST_CLERK', 2500, NULL, 124, 50),
    (145, 'John', 'Russell', 'JRUSSEL', '011.44.1344.429268', TO_DATE('01-OCT-1996', 'DD-MON-YYYY'), 'SA_MAN', 14000, 0.4, 100, 80),
    (146, 'Karen', 'Partners', 'KPARTNER', '011.44.1344.467268', TO_DATE('05-JAN-1997', 'DD-MON-YYYY'), 'SA_MAN', 13500, 0.3, 100, 80),
    (147, 'Alberto', 'Errazuriz', 'AERRAZUR', '011.44.1344.429278', TO_DATE('10-MAR-1997', 'DD-MON-YYYY'), 'SA_MAN', 12000, 0.3, 100, 80),
    (148, 'Gerald', 'Cambrault', 'GCAMBRAU', '011.44.1344.619268', TO_DATE('15-OCT-1999', 'DD-MON-YYYY'), 'SA_MAN', 11000, 0.3, 100, 80),
    (149, 'Eleni', 'Zlotkey', 'EZLOTKEY', '011.44.1344.429018', TO_DATE('29-JAN-2000', 'DD-MON-YYYY'), 'SA_MAN', 10500, 0.2, 100, 80),
    (150, 'Peter', 'Tucker', 'PTUCKER', '011.44.1344.129268', TO_DATE('30-JAN-1997', 'DD-MON-YYYY'), 'SA_REP', 10000, 0.3, 145, 80),
    (151, 'David', 'Bernstein', 'DBERNSTE', '011.44.1344.345268', TO_DATE('24-MAR-1997', 'DD-MON-YYYY'), 'SA_REP', 9500, 0.25, 145, 80),
    (152, 'Peter', 'Hall', 'PHALL', '011.44.1344.478968', TO_DATE('20-AUG-1997', 'DD-MON-YYYY'), 'SA_REP', 9000, 0.25, 145, 80),
    (153, 'Christopher', 'Olsen', 'COLSEN', '011.44.1344.498718', TO_DATE('30-MAR-1998', 'DD-MON-YYYY'), 'SA_REP', 8000, 0.2, 145, 80),
    (154, 'Nanette', 'Cambrault', 'NCAMBRAU', '011.44.1344.987668', TO_DATE('09-DEC-1998', 'DD-MON-YYYY'), 'SA_REP', 7500, 0.2, 145, 80),
    (155, 'Oliver', 'Tuvault', 'OTUVAULT', '011.44.1344.486508', TO_DATE('23-NOV-1999', 'DD-MON-YYYY'), 'SA_REP', 7000, 0.15, 145, 80),
    (156, 'Janette', 'King', 'JKING', '011.44.1345.429268', TO_DATE('30-JAN-1996', 'DD-MON-YYYY'), 'SA_REP', 10000, 0.35, 146, 80),
    (157, 'Patrick', 'Sully', 'PSULLY', '011.44.1345.929268', TO_DATE('04-MAR-1996', 'DD-MON-YYYY'), 'SA_REP', 9500, 0.35, 146, 80),
    (158, 'Allan', 'McEwen', 'AMCEWEN', '011.44.1345.829268', TO_DATE('01-AUG-1996', 'DD-MON-YYYY'), 'SA_REP', 9000, 0.35, 146, 80),
    (159, 'Lindsey', 'Smith', 'LSMITH', '011.44.1345.729268', TO_DATE('10-MAR-1997', 'DD-MON-YYYY'), 'SA_REP', 8000, 0.3, 146, 80),
    (160, 'Louise', 'Doran', 'LDORAN', '011.44.1345.629268', TO_DATE('15-DEC-1997', 'DD-MON-YYYY'), 'SA_REP', 7500, 0.3, 146, 80),
    (161, 'Sarath', 'Sewall', 'SSEWALL', '011.44.1345.529268', TO_DATE('03-NOV-1998', 'DD-MON-YYYY'), 'SA_REP', 7000, 0.25, 146, 80),
    (162, 'Clara', 'Vishney', 'CVISHNEY', '011.44.1346.129268', TO_DATE('11-NOV-1997', 'DD-MON-YYYY'), 'SA_REP', 10500, 0.25, 147, 80),
    (163, 'Danielle', 'Greene', 'DGREENE', '011.44.1346.229268', TO_DATE('19-MAR-1999', 'DD-MON-YYYY'), 'SA_REP', 9500, 0.15, 147, 80),
    (164, 'Mattea', 'Marvins', 'MMARVINS', '011.44.1346.329268', TO_DATE('24-JAN-2000', 'DD-MON-YYYY'), 'SA_REP', 7200, 0.1, 147, 80),
    (165, 'David', 'Lee', 'DLEE', '011.44.1346.529268', TO_DATE('23-FEB-2000', 'DD-MON-YYYY'), 'SA_REP', 6800, 0.1, 147, 80),
    (166, 'Sundar', 'Ande', 'SANDE', '011.44.1346.629268', TO_DATE('24-MAR-2000', 'DD-MON-YYYY'), 'SA_REP', 6400, 0.1, 147, 80),
    (167, 'Amit', 'Banda', 'ABANDA', '011.44.1346.729268', TO_DATE('21-APR-2000', 'DD-MON-YYYY'), 'SA_REP', 6200, 0.1, 147, 80),
    (168, 'Lisa', 'Ozer', 'LOZER', '011.44.1343.929268', TO_DATE('11-MAR-1997', 'DD-MON-YYYY'), 'SA_REP', 11500, 0.25, 148, 80),
    (169, 'Harrison', 'Bloom', 'HBLOOM', '011.44.1343.829268', TO_DATE('23-MAR-1998', 'DD-MON-YYYY'), 'SA_REP', 10000, 0.2, 148, 80),
    (170, 'Tayler', 'Fox', 'TFOX', '011.44.1343.729268', TO_DATE('24-JAN-1998', 'DD-MON-YYYY'), 'SA_REP', 9600, 0.2, 148, 80),
    (171, 'William', 'Smith', 'WSMITH', '011.44.1343.629268', TO_DATE('23-FEB-1999', 'DD-MON-YYYY'), 'SA_REP', 7400, 0.15, 148, 80),
    (172, 'Elizabeth', 'Bates', 'EBATES', '011.44.1343.529268', TO_DATE('24-MAR-1999', 'DD-MON-YYYY'), 'SA_REP', 7300, 0.15, 148, 80),
    (173, 'Sundita', 'Kumar', 'SKUMAR', '011.44.1343.329268', TO_DATE('21-APR-2000', 'DD-MON-YYYY'), 'SA_REP', 6100, 0.1, 148, 80),
    (174, 'Ellen', 'Abel', 'EABEL', '011.44.1644.429267', TO_DATE('11-MAY-1996', 'DD-MON-YYYY'), 'SA_REP', 11000, 0.3, 149, 80),
    (175, 'Alyssa', 'Hutton', 'AHUTTON', '011.44.1644.429266', TO_DATE('19-MAR-1997', 'DD-MON-YYYY'), 'SA_REP', 8800, 0.25, 149, 80),
    (176, 'Jonathon', 'Taylor', 'JTAYLOR', '011.44.1644.429265', TO_DATE('24-MAR-1998', 'DD-MON-YYYY'), 'SA_REP', 8600, 0.2, 149, 80),
    (177, 'Jack', 'Livingston', 'JLIVINGS', '011.44.1644.429264', TO_DATE('23-APR-1998', 'DD-MON-YYYY'), 'SA_REP', 8400, 0.2, 149, 80),
    (178, 'Kimberely', 'Grant', 'KGRANT', '011.44.1644.429263', TO_DATE('24-MAY-1999', 'DD-MON-YYYY'), 'SA_REP', 7000, 0.15, 149, NULL),
    (179, 'Charles', 'Johnson', 'CJOHNSON', '011.44.1644.429262', TO_DATE('04-JAN-2000', 'DD-MON-YYYY'), 'SA_REP', 6200, 0.1, 149, 80),
    (180, 'Winston', 'Taylor', 'WTAYLOR', '650.507.9876', TO_DATE('24-JAN-1998', 'DD-MON-YYYY'), 'SH_CLERK', 3200, NULL, 120, 50),
    (181, 'Jean', 'Fleaur', 'JFLEAUR', '650.507.9877', TO_DATE('23-FEB-1998', 'DD-MON-YYYY'), 'SH_CLERK', 3100, NULL, 120, 50),
    (182, 'Martha', 'Sullivan', 'MSULLIVA', '650.507.9878', TO_DATE('21-JUN-1999', 'DD-MON-YYYY'), 'SH_CLERK', 2500, NULL, 120, 50),
    (183, 'Girard', 'Geoni', 'GGEONI', '650.507.9879', TO_DATE('03-FEB-2000', 'DD-MON-YYYY'), 'SH_CLERK', 2800, NULL, 120, 50),
    (184, 'Nandita', 'Sarchand', 'NSARCHAN', '650.509.1876', TO_DATE('27-JAN-1996', 'DD-MON-YYYY'), 'SH_CLERK', 4200, NULL, 121, 50),
    (185, 'Alexis', 'Bull', 'ABULL', '650.509.2876', TO_DATE('20-FEB-1997', 'DD-MON-YYYY'), 'SH_CLERK', 4100, NULL, 121, 50),
    (186, 'Julia', 'Dellinger', 'JDELLING', '650.509.3876', TO_DATE('24-JUN-1998', 'DD-MON-YYYY'), 'SH_CLERK', 3400, NULL, 121, 50),
    (187, 'Anthony', 'Cabrio', 'ACABRIO', '650.509.4876', TO_DATE('07-FEB-1999', 'DD-MON-YYYY'), 'SH_CLERK', 3000, NULL, 121, 50),
    (188, 'Kelly', 'Chung', 'KCHUNG', '650.505.1876', TO_DATE('14-JUN-1997', 'DD-MON-YYYY'), 'SH_CLERK', 3800, NULL, 122, 50),
    (189, 'Jennifer', 'Dilly', 'JDILLY', '650.505.2876', TO_DATE('13-AUG-1997', 'DD-MON-YYYY'), 'SH_CLERK', 3600, NULL, 122, 50),
    (190, 'Timothy', 'Gates', 'TGATES', '650.505.3876', TO_DATE('11-JUL-1998', 'DD-MON-YYYY'), 'SH_CLERK', 2900, NULL, 122, 50),
    (191, 'Randall', 'Perkins', 'RPERKINS', '650.505.4876', TO_DATE('19-DEC-1999', 'DD-MON-YYYY'), 'SH_CLERK', 2500, NULL, 122, 50),
    (192, 'Sarah', 'Bell', 'SBELL', '650.501.1876', TO_DATE('04-FEB-1996', 'DD-MON-YYYY'), 'SH_CLERK', 4000, NULL, 123, 50),
    (193, 'Britney', 'Everett', 'BEVERETT', '650.501.2876', TO_DATE('03-MAR-1997', 'DD-MON-YYYY'), 'SH_CLERK', 3900, NULL, 123, 50),
    (194, 'Samuel', 'McCain', 'SMCCAIN', '650.501.3876', TO_DATE('01-JUL-1998', 'DD-MON-YYYY'), 'SH_CLERK', 3200, NULL, 123, 50),
    (195, 'Vance', 'Jones', 'VJONES', '650.501.4876', TO_DATE('17-MAR-1999', 'DD-MON-YYYY'), 'SH_CLERK', 2800, NULL, 123, 50),
    (196, 'Alana', 'Walsh', 'AWALSH', '650.507.9811', TO_DATE('24-APR-1998', 'DD-MON-YYYY'), 'SH_CLERK', 3100, NULL, 124, 50),
    (197, 'Kevin', 'Feeney', 'KFEENEY', '650.507.9822', TO_DATE('23-MAY-1998', 'DD-MON-YYYY'), 'SH_CLERK', 3000, NULL, 124, 50),
    (198, 'Donald', 'OConnell', 'DOCONNEL', '650.507.9833', TO_DATE('21-JUN-1999', 'DD-MON-YYYY'), 'SH_CLERK', 2600, NULL, 124, 50),
    (199, 'Douglas', 'Grant', 'DGRANT', '650.507.9844', TO_DATE('13-JAN-2000', 'DD-MON-YYYY'), 'SH_CLERK', 2600, NULL, 124, 50),
    (200, 'Jennifer', 'Whalen', 'JWHALEN', '515.123.4444', TO_DATE('17-SEP-1987', 'DD-MON-YYYY'), 'AD_ASST', 4400, NULL, 101, 10),
    (201, 'Michael', 'Hartstein', 'MHARTSTE', '515.123.5555', TO_DATE('17-FEB-1996', 'DD-MON-YYYY'), 'MK_MAN', 13000, NULL, 100, 20),
    (202, 'Pat', 'Fay', 'PFAY', '603.123.6666', TO_DATE('17-AUG-1997', 'DD-MON-YYYY'), 'MK_REP', 6000, NULL, 201, 20),
    (203, 'Susan', 'Mavris', 'SMAVRIS', '515.123.7777', TO_DATE('07-JUN-1994', 'DD-MON-YYYY'), 'HR_REP', 6500, NULL, 101, 40),
    (204, 'Hermann', 'Baer', 'HBAER', '515.123.8888', TO_DATE('07-JUN-1994', 'DD-MON-YYYY'), 'PR_REP', 10000, NULL, 101, 70),
    (205, 'Shelley', 'Higgins', 'SHIGGINS', '515.123.8080', TO_DATE('07-JUN-1994', 'DD-MON-YYYY'), 'AC_MGR', 12000, NULL, 101, 110),
    (206, 'William', 'Gietz', 'WGIETZ', '515.123.8181', TO_DATE('07-JUN-1994', 'DD-MON-YYYY'), 'AC_ACCOUNT', 8300, NULL, 205, 110);



COMMIT;

INSERT INTO job_history
VALUES (
           102,
           STR_TO_DATE('13-Jan-1993', '%d-%M-%Y'),
           STR_TO_DATE('24-Jul-1998', '%d-%M-%Y'),
           'IT_PROG',
           60
       );

INSERT INTO job_history
VALUES (
           101,
           STR_TO_DATE('21-Sep-1989', '%d-%M-%Y'),
           STR_TO_DATE('27-Oct-1993', '%d-%M-%Y'),
           'AC_ACCOUNT',
           110
       );

INSERT INTO job_history
VALUES (
           101,
           STR_TO_DATE('28-Oct-1993','%d-%M-%Y'),
           STR_TO_DATE('15-Mar-1997','%d-%M-%Y'),
           'AC_MGR',
           110
       );

INSERT INTO job_history
VALUES (
           201,
           STR_TO_DATE('27-Feb-1996','%d-%M-%Y'),
           STR_TO_DATE('19-Dec-1999','%d-%M-%Y'),
           'MK_REP',
           20
       );

INSERT INTO job_history
VALUES (
           114,
           STR_TO_DATE('24-Mar-1998','%d-%M-%Y'),
           STR_TO_DATE('31-Dec-1999','%d-%M-%Y'),
           'ST_CLERK',
           50
       );

INSERT INTO job_history
VALUES (
           122,
           STR_TO_DATE('01-Jan-1999','%d-%M-%Y'),
           STR_TO_DATE('31-Dec-1999','%d-%M-%Y'),
           'ST_CLERK',
           50
       );

INSERT INTO job_history
VALUES (
           200,
           STR_TO_DATE('17-Sep-1987','%d-%M-%Y'),
           STR_TO_DATE('17-Jun-1993','%d-%M-%Y'),
           'AD_ASST',
           90
       );

INSERT INTO job_history
VALUES (
           176,
           STR_TO_DATE('24-Mar-1998','%d-%M-%Y'),
           STR_TO_DATE('31-Dec-1998','%d-%M-%Y'),
           'SA_REP',
           80
       );

INSERT INTO job_history
VALUES (
           176,
           STR_TO_DATE('01-Jan-1999','%d-%M-%Y'),
           STR_TO_DATE('31-Dec-1999','%d-%M-%Y'),
           'SA_MAN',
           80
       );

INSERT INTO job_history
VALUES (
           200,
           STR_TO_DATE('01-Jul-1994','%d-%M-%Y'),
           STR_TO_DATE('31-Dec-1998','%d-%M-%Y'),
           'AC_ACCOUNT',
           90
       );

INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id)
VALUES
    (102, TO_DATE('13-Jan-1993', 'DD-Mon-YYYY'), TO_DATE('24-Jul-1998', 'DD-Mon-YYYY'), 'IT_PROG', 60),
    (101, TO_DATE('21-Sep-1989', 'DD-Mon-YYYY'), TO_DATE('27-Oct-1993', 'DD-Mon-YYYY'), 'AC_ACCOUNT', 110),
    (101, TO_DATE('28-Oct-1993', 'DD-Mon-YYYY'), TO_DATE('15-Mar-1997', 'DD-Mon-YYYY'), 'AC_MGR', 110),
    (201, TO_DATE('27-Feb-1996', 'DD-Mon-YYYY'), TO_DATE('19-Dec-1999', 'DD-Mon-YYYY'), 'MK_REP', 20),
    (114, TO_DATE('24-Mar-1998', 'DD-Mon-YYYY'), TO_DATE('31-Dec-1999', 'DD-Mon-YYYY'), 'ST_CLERK', 50),
    (122, TO_DATE('01-Jan-1999', 'DD-Mon-YYYY'), TO_DATE('31-Dec-1999', 'DD-Mon-YYYY'), 'ST_CLERK', 50),
    (200, TO_DATE('17-Sep-1987', 'DD-Mon-YYYY'), TO_DATE('17-Jun-1993', 'DD-Mon-YYYY'), 'AD_ASST', 90),
    (176, TO_DATE('24-Mar-1998', 'DD-Mon-YYYY'), TO_DATE('31-Dec-1998', 'DD-Mon-YYYY'), 'SA_REP', 80),
    (176, TO_DATE('01-Jan-1999', 'DD-Mon-YYYY'), TO_DATE('31-Dec-1999', 'DD-Mon-YYYY'), 'SA_MAN', 80),
    (200, TO_DATE('01-Jul-1994', 'DD-Mon-YYYY'), TO_DATE('31-Dec-1998', 'DD-Mon-YYYY'), 'AC_ACCOUNT', 90);



COMMIT;