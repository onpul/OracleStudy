SELECT USER
FROM DUAL;
--==>> HR

--�� EMPLOYEES ���̺��� ������ SALARY �� 10% �λ��Ѵ�.
--   ��, �μ����� 'IT' �� �����鸸 �����Ѵ�.
--   (����, ���濡 ���� ��� Ȯ�� �� ROLLBACK �����Ѵ�~!!!)
SELECT *
FROM EMPLOYEES;

SELECT *
FROM DEPARTMENTS;

SELECT *
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

SELECT *
FROM EMPLOYEES
WHERE �μ����� 'IT';

