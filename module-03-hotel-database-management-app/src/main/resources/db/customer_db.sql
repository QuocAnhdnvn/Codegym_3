create database customer_db;

use customer_db;

create table customers(
                          id int auto_increment primary key,
                          name varchar(100) not null,
                          position varchar(45) not null,
                          office varchar(45) not null,
                          age int not null,
                          start_date date not null,
                          salary decimal not null
);

insert into customers(name, position, office, age, start_date, salary) values
        ('Le Trang Ty', 'Frontend Developer', 'HN', 18, '2025-01-01', 10000),
        ('Dinh Thi Suu', 'Backend Developer', 'DN', 20, '2025-01-01', 10000),
        ('Nguyen Van Dan', 'Backend Developer', 'HCM', 19, '2025-01-01', 10000);

insert into customers(name, position, office, age, start_date, salary) values
        ('Tran Thi Bich', 'QA Engineer', 'HN', 22, '2025-02-15', 12000),
        ('Pham Van Minh', 'Project Manager', 'DN', 32, '2024-09-10', 20000),
        ('Nguyen Thi Hoa', 'UI/UX Designer', 'HCM', 25, '2024-11-20', 14000),
        ('Le Van Tien', 'DevOps Engineer', 'HN', 28, '2025-03-05', 16000),
                                                                           ('Hoang Thi Cam', 'Business Analyst', 'DN', 30, '2024-12-01', 18000),
                                                                           ('Phan Van Duc', 'Frontend Developer', 'HCM', 21, '2025-01-20', 11000),
                                                                           ('Do Thi Mai', 'Backend Developer', 'HN', 23, '2024-10-15', 11500),
                                                                           ('Vo Van Khoa', 'QA Engineer', 'DN', 27, '2025-04-12', 13500),
                                                                           ('Nguyen Quoc Toan', 'Product Owner', 'HCM', 35, '2024-08-25', 22000),
                                                                           ('Tran Van An', 'Scrum Master', 'HN', 29, '2025-02-01', 17000),
                                                                           ('Bui Thi Thu', 'Data Analyst', 'DN', 26, '2025-01-18', 14500),
                                                                           ('Nguyen Van Duong', 'Backend Developer', 'HCM', 24, '2024-12-22', 11800),
                                                                           ('Le Thi Kim', 'Frontend Developer', 'HN', 22, '2024-11-30', 11200),
                                                                           ('Pham Thi Dao', 'HR Specialist', 'DN', 31, '2024-10-05', 13000),
                                                                           ('Hoang Van Hieu', 'Backend Developer', 'HCM', 20, '2025-02-20', 10500),
                                                                           ('Tran Thi Duyen', 'UI/UX Designer', 'HN', 27, '2024-09-14', 14200),
                                                                           ('Nguyen Minh Chau', 'QA Engineer', 'DN', 23, '2025-03-10', 13700);
