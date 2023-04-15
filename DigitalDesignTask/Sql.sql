--MS SQL
--Сотрудник с максимальной заработной платой.
SELECT * FROM EMPLOYEE WHERE Salary = (SELECT MAX(Salary) FROM EMPLOYEE);
--Максимальная длина цепочки руководителей по таблице сотрудников (вычисление глубины дерева).
WITH manager_tree (ID, Chief_Id, depth) AS (
    SELECT ID, Chief_Id, 1 AS depth
    FROM EMPLOYEE
    WHERE Chief_Id IS NULL
    UNION ALL
    SELECT e.ID, e.Chief_Id, depth + 1
    FROM EMPLOYEE e
             JOIN manager_tree m ON e.Chief_Id = m.ID
)
SELECT MAX(depth) as max_depth
FROM manager_tree;
--Отдел, с максимальной суммарной зарплатой сотрудников.
SELECT TOP 1 d.Name, SUM(e.Salary) AS total_salary
FROM DEPARTMENT d
         JOIN EMPLOYEE e ON d.ID = e.Department_id
GROUP BY d.Name
ORDER BY total_salary DESC;
--Сотрудник, чье имя начинается на «Р» и заканчивается на «н».
SELECT * FROM EMPLOYEE WHERE Name LIKE 'Р%н';