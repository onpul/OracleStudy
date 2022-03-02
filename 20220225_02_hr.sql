SELECT USER
FROM DUAL;
--==>> HR

--�� �� �� �̻��� ���̺� ����(JOIN)

-- ���� 1. (SQL 1992 CODE)
SELECT ���̺���1.�÷���, ���̺���2.�÷���, ���̺���3.�÷���
FROM ���̺���1, ���̺���2, ���̺���3
WHERE ���̺���1.�÷���1 = ���̺���2.�÷���1
  AND ���̺���2.�÷���2 = ���̺���3.�÷���2;


-- ���� 2. (SQL 1999 CODE)
SELECT ���̺���1. �÷���, ���̺���2.�÷���, ���̺���3.�÷���
FROM ���̺���1 JOIN ���̺���2
ON ���̺���1.�÷���1 = ���̺���2.�÷���2
               JOIN ���̺���3
               ON ���̺���2.�÷���2 = ���̺���3.�÷���2;


--�� HR ���� ������ ���̺� �Ǵ� �� ��� ��ȸ
SELECT *
FROM TAB;
--==>>
/*
COUNTRIES	        TABLE	
DEPARTMENTS	        TABLE	
EMPLOYEES	        TABLE	
EMP_DETAILS_VIEW	VIEW    --	��� �Ű� �� ��� ��
JOBS	            TABLE	
JOB_HISTORY	        TABLE	
LOCATIONS	        TABLE	
REGIONS	            TABLE	
*/

--------------------------------------------------------------------------------

--�� HR.JOBS, HR.EMPLOYEES, HR.DEPARTMENTS ���̺��� ������� �������� �����͸�  -- ����
--   FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME �׸����� ��ȸ�Ѵ�.
--   EMPLOYEES   EMPLOYEES  JOBS       DEPARTMENTS

-- �� Ǯ�� ---------------------------------------------------------------------

-- ���̺� ���� ��ȸ
SELECT *
FROM JOBS;
SELECT *
FROM EMPLOYEES; -- KIMBERELY�� DEPARTMENT_ID�� NULL
SELECT *
FROM DEPARTMENTS;

-- 99 �ڵ��
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM JOBS J JOIN EMPLOYEES E
ON J.JOB_ID = E.JOB_ID
               LEFT JOIN DEPARTMENTS D
               ON D.DEPARTMENT_ID = E.DEPARTMENT_ID; -- LEFT�� ������ ���� �ۿø���.

-- 92 �ڵ��
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM JOBS J, EMPLOYEES E, DEPARTMENTS D
WHERE J.JOB_ID = E.JOB_ID
  AND D.DEPARTMENT_ID(+) = E.DEPARTMENT_ID; -- + ���� ���� ���� �޸𸮿� �ۿø���.

-- ���� Ǯ�� -------------------------------------------------------------------

--�� HR.JOBS, HR.EMPLOYEES, HR.DEPARTMENTS ���̺��� ������� �������� �����͸�  
--   FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME �׸����� ��ȸ�Ѵ�.
--   ----------  ---------  ---------  ---------------
--   EMPLOYEES   EMPLOYEES  JOBS       DEPARTMENTS

SELECT *
FROM DEPARTMENTS;
-- DEPARTMENT_ID        -- ���� �÷�

SELECT *
FROM EMPLOYEES; 
-- JOB_ID               -- ���� �÷�

SELECT *
FROM JOBS; 

SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

SELECT COUNT(*)
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--==>> 106

SELECT COUNT(*)
FROM EMPLOYEES;
--==>> 107
-- OUTER ���� �ؾ� �Ѵ�.

SELECT COUNT(*)
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--==>> 107

SELECT E.FIRST_NAME, E.LAST_NAME, JOB_TITLE, D.DEPARTMENT_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        JOIN JOBS J
          ON E.JOB_ID = J.JOB_ID;

SELECT COUNT(*)
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        JOIN JOBS J
          ON E.JOB_ID = J.JOB_ID;
--==>> 107

SELECT E.FIRST_NAME, E.LAST_NAME, JOB_TITLE, D.DEPARTMENT_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        JOIN JOBS J
          ON E.JOB_ID = J.JOB_ID;

--------------------------------------------------------------------------------

--�� EMPLOYEES, DEPARTMENTS, JOBS, LOCATIONS, COUNTRIES, REGIONS ���̺��� �������
--   �������� �����͸� ������ ���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
--   FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME, CITY,       COUNTRY_NAME, REGION_NAME
--   EMPLOYEES   EMPLOYEES  JOBS       DEPARTMENTS      LOCATIONS   COUNTRIES     REGIONS
--    
SELECT *
FROM EMPLOYEES; -- 0
SELECT *
FROM DEPARTMENTS; -- 1
SELECT *
FROM JOBS; --2
SELECT *
FROM LOCATIONS; -- 3
SELECT *
FROM COUNTRIES; -- 4
SELECT *
FROM REGIONS; -- 5

SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM JOBS J, EMPLOYEES E, DEPARTMENTS D
WHERE J.JOB_ID = E.JOB_ID
  AND D.DEPARTMENT_ID(+) = E.DEPARTMENT_ID;
  
SELECT FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME, CITY, COUNTRY_NAME, REGION_NAME
FROM EMPLOYEES E, JOBS J, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE J.JOB_ID = E.JOB_ID
  AND D.DEPARTMENT_ID(+) = E.DEPARTMENT_ID
  AND D.LOCATION_ID = L.LOCATION_ID(+)
  AND L.COUNTRY_ID = C.COUNTRY_ID(+)
  AND C.REGION_ID = R.REGION_ID(+);
  
SELECT T.* ,CITY
FROM
(
    SELECT FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME
    FROM EMPLOYEES E LEFT JOIN JOBS J
    ON J.JOB_ID = E.JOB_ID
            JOIN DEPARTMENTS D
              ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
)
T JOIN LOCATIONS L
    ON T.D.LOCATION_ID = L.LOCATION_ID;

-- ���� Ǯ�� �� / ���� Ǯ�� �� �Ѵ� �ϼ��� �Ф� ��ȸ�ǽǿ��� �������� ���� ������ �Ϸ�