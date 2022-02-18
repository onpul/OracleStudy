SELECT USER
FROM DUAL;

--�� EMP ���̺��� �μ���ȣ�� 20���� 30�� �������� �����͵� ��
--   �����ȣ, �����, ������, �޿�, �μ���ȣ �׸��� ��ȸ�Ѵ�.
--   ��, ��Ī(ALIAS)�� ����Ѵ�.
/*
EMP ���̺���                              �� FROM ENP
�μ���ȣ�� 20���� 30��                      �� ����
�����ȣ, �����, ������, �޿�, �μ���ȣ    �� SELECT �÷���
*/
SELECT EMPNO "�����ȣ", ENAME "�����", JOB "������", SAL "�޿�", DEPTNO "�μ���ȣ"  
FROM EMP
WHERE DEPTNO = 20 || DEPTNO = 30; 
--    -----------    -----------  
--==>> ���� �߻�
--     (ORA-00933: SQL command not properly ended)

SELECT EMPNO "�����ȣ", ENAME "�����", JOB "������", SAL "�޿�", DEPTNO "�μ���ȣ"  
FROM EMP
WHERE DEPTNO = 20 OR DEPTNO = 30;    -- ����Ŭ���� OR�� OR!! ��������
--==>>
/*
7369	SMITH	CLERK	     800    20
7499	ALLEN	SALESMAN	1600	30
7521	WARD	SALESMAN	1250	30
7566	JONES	MANAGER 	2975	20
7654	MARTIN	SALESMAN	1250	30
7698	BLAKE	MANAGER	    2850	30
7788	SCOTT	ANALYST	    3000	20
7844	TURNER	SALESMAN	1500	30
7876	ADAMS	CLERK	    1100	20
7900	JAMES	CLERK	     950 	30
7902	FORD	ANALYST	    3000	20
*/

--�� ���� ������ IN �����ڸ� Ȱ���Ͽ�
--   ������ ���� ó���� �� ������
--   �� ������ ó�� ����� ���� ����� ��ȯ�Ѵ�.
SELECT EMPNO "�����ȣ", ENAME "�����", JOB "������", SAL "�޿�", DEPTNO "�μ���ȣ"  
FROM EMP
WHERE DEPTNO IN (20, 30); 
--==>>
/*
7369	SMITH	CLERK	     800    20
7499	ALLEN	SALESMAN	1600	30
7521	WARD	SALESMAN	1250	30
7566	JONES	MANAGER 	2975	20
7654	MARTIN	SALESMAN	1250	30
7698	BLAKE	MANAGER	    2850	30
7788	SCOTT	ANALYST	    3000	20
7844	TURNER	SALESMAN	1500	30
7876	ADAMS	CLERK	    1100	20
7900	JAMES	CLERK	     950 	30
7902	FORD	ANALYST	    3000	20
*/


--�� EMP ���̺��� ������ CLERK �� ������� �����͸� ��� ��ȸ�Ѵ�.
SELECT *
FROM EMP
WHERE JOB = 'CLERK';   -- ����Ŭ���� ���ڿ��� Ȭ����ǥ ' '
--==>>
/*
7369	SMITH	CLERK	7902	1980-12-17	 800		20
7876	ADAMS	CLERK	7788	1987-07-13	1100		20
7900	JAMES	CLERK	7698	1981-12-03	 950		30
7934	MILLER	CLERK	7782	1982-01-23	1300		10
*/

select *
From emp
Where Job = 'clerk'; 
--==>> ��ȸ ��� ����

select *
From emp
Where Job = 'CLERK'; 
--==>> 
/*
7369	SMITH	CLERK	7902	1980-12-17	 800		20
7876	ADAMS	CLERK	7788	1987-07-13	1100		20
7900	JAMES	CLERK	7698	1981-12-03	 950		30
7934	MILLER	CLERK	7782	1982-01-23	1300		10
*/

--�� ����Ŭ����... �Էµ� �������� �� ��ŭ��...
--   ��.��.��. ��ҹ��� ������ �Ѵ�.

--�� EMP ���̺��� ������ CLERK �� ����� ��
--   20�� �μ��� �ٹ��ϴ� ������� 
--   �����ȣ, �����, ������, �޿�, �μ���ȣ �׸��� ��ȸ�Ѵ�.
SELECT EMPNO "�����ȣ", ENAME "�����", JOB "������", SAL "�޿�", DEPTNO "�μ���ȣ"  
FROM EMP
WHERE JOB = 'CLERK' AND DEPTNO = 20; 
--==>>
/*
7369	SMITH	CLERK	800	    20
7876	ADAMS	CLERK	1100	20
*/

--�� EMP ���̺��� ������ �����͸� Ȯ���Ͽ�
--   �̿� �Ȱ��� �����Ͱ� ����ִ� ���̺��� ������ �����Ѵ�. (TBL_EMP)

DESCRIBE EMP;
DESC EMP;
--==>>
/*
�̸�       ��?       ����           
-------- -------- ------------ 
EMPNO    NOT NULL NUMBER(4)    
ENAME             VARCHAR2(10) 
JOB               VARCHAR2(9)  
MGR               NUMBER(4)    
HIREDATE          DATE         
SAL               NUMBER(7,2)  
COMM              NUMBER(7,2)  
DEPTNO            NUMBER(2)   
*/

SELECT *
FROM EMP;
/*
CREATE TABLE TBL_EMP
( EMPNO     NUMBER(4)
, ENAME     VARCHAR2(10)
, JOB       VARCHAR2(9)
, MGR       NUMBER(4)
, HIREDATE  DATE
, SAL       NUMBER(7,2)
, COMM      NUMBER(7,2)
, DEPTNO    NUMBER(2)
);
SELECT *
FROM EMP;

INSERT INTO ... * 14
*/

CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>> Table TBL_EMP��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_EMP;

DESC TBL_EMP;

--�� ���̺� ����(DEPT �� TBL_DEPT)
CREATE TABLE TBL_DEPT
AS
SELECT *
FROM DEPT;
--==>> Table TBL_DEPT��(��) �����Ǿ����ϴ�.

--�� ������ ���̺� Ȯ��
SELECT *
FROM TBL_DEPT;

DESC TBL_DEPT;


--�� ���̺��� Ŀ��Ʈ ���� Ȯ��
SELECT *
FROM USER_TAB_COMMENTS;
--==>>
/*
TBL_EXAMPLE1	TABLE	
TBL_EXAMPLE2	TABLE	
SALGRADE	    TABLE	
BONUS	        TABLE	
EMP	            TABLE	
DEPT	        TABLE	
TBL_DEPT	    TABLE	
TBL_EMP     	TABLE	
*/

--�� ���̺� ������ Ŀ��Ʈ ���� �Է�
COMMENT ON TABLE TBL_EMP IS '��� ����';
--==>> Comment��(��) �����Ǿ����ϴ�.

--�� Ŀ��Ʈ ���� �Է� �� �ٽ� Ȯ��
SELECT *
FROM USER_TAB_COMMENTS;
--==>>
/*
TBL_EXAMPLE1	TABLE	
TBL_EXAMPLE2	TABLE	
SALGRADE	    TABLE	
BONUS	        TABLE	
EMP         	TABLE	
DEPT	        TABLE	
TBL_DEPT	    TABLE	
TBL_EMP     	TABLE	��� ����
*/

--�� TBL_DEPT ���̺��� ������� ���̺� ������ Ŀ��Ʈ ������ �Է�
--   �� �μ� ����
COMMENT ON TABLE TBL_DEPT IS '�μ� ����';
--==>> Comment��(��) �����Ǿ����ϴ�.

--�� Ŀ��Ʈ ������ �Է� �� Ȯ��
SELECT *
FROM USER_TAB_COMMENTS;
--==>>
/*
TBL_EXAMPLE1	TABLE	
TBL_EXAMPLE2	TABLE	
SALGRADE	    TABLE	
BONUS	        TABLE	
EMP         	TABLE	
DEPT	        TABLE	
TBL_DEPT    	TABLE	�μ� ����
TBL_EMP     	TABLE	��� ����
*/

--�� �÷� ������ Ŀ��Ʈ ������ Ȯ��
SELECT *
FROM USER_COL_COMMENTS;
--==>>
/*
TBL_EXAMPLE1	ADDR	
TBL_DEPT	    DEPTNO	
EMP         	HIREDATE	
SALGRADE	    HISAL	
BONUS	        JOB	
TBL_EXAMPLE2	ADDR	
EMP	ENAME	
TBL_EXAMPLE2	NO	
EMP	SAL	
SALGRADE	    GRADE	
TBL_EMP	        ENAME	
DEPT	        LOC	
TBL_EMP	        EMPNO	
TBL_EMP	        SAL	
EMP	            COMM	
SALGRADE	    LOSAL	
TBL_EXAMPLE1	NO	
TBL_EMP     	JOB	
TBL_EMP	        COMM	
EMP	JOB	
TBL_EXAMPLE2	NAME	
EMP	DEPTNO	
BONUS	        COMM	
EMP	            EMPNO	
BONUS	        SAL	
TBL_DEPT    	DNAME	
BONUS	        ENAME	
TBL_EXAMPLE1	NAME	
DEPT	        DEPTNO	
TBL_DEPT	    LOC	
DEPT	        DNAME	
TBL_EMP	        HIREDATE	
TBL_EMP     	MGR	
EMP	MGR	
TBL_EMP     	DEPTNO	
*/

--�� �÷� ������ Ŀ��Ʈ ������ Ȯ��(TBL_DEPT ���̺� �Ҽ��� �÷��鸸 Ȯ��)
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME='TBL_DEPT';    -- ���� �߰�
--==>>
/*
TBL_DEPT	DEPTNO	
TBL_DEPT	DNAME	
TBL_DEPT	LOC	
*/

--�� ���̺� �Ҽӵ�(���Ե�) �÷��� ���� Ŀ��Ʈ ������ ����
COMMENT ON COLUMN TBL_DEPT.DEPTNO IS '�μ� ��ȣ';
--==>> Comment��(��) �����Ǿ����ϴ�.

COMMENT ON COLUMN TBL_DEPT.DNAME IS '�μ���';
--==>> Comment��(��) �����Ǿ����ϴ�.

COMMENT ON COLUMN TBL_DEPT.LOC IS '�μ� ��ġ';
--==>> Comment��(��) �����Ǿ����ϴ�.

--�� Ŀ��Ʈ �����Ͱ� �Էµ� ���̺��� �÷� ���� Ŀ��Ʈ ������ Ȯ��
--   (TBL_DEPT ���̺� �Ҽ��� �÷��鸸 ��ȸ)
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME='TBL_DEPT';
--==>>
/*
TBL_DEPT	DEPTNO	�μ� ��ȣ
TBL_DEPT	DNAME	�μ���
TBL_DEPT	LOC	    �μ� ��ġ
*/

--�� TBL_EMP ���̺��� �������
--   ���̺� �Ҽӵ�(���Ե�) �÷��� ���� Ŀ��Ʈ ������ ����
SELECT *
FROM TBL_EMP; -- TBL_EMP ��ü ��ȸ

COMMENT ON COLUMN TBL_EMP.EMPNO IS '��� ��ȣ';
COMMENT ON COLUMN TBL_EMP.ENAME IS '�����';
COMMENT ON COLUMN TBL_EMP.JOB IS '������';
COMMENT ON COLUMN TBL_EMP.MGR IS '������ �����ȣ';
COMMENT ON COLUMN TBL_EMP.HIREDATE IS '�Ի���';
COMMENT ON COLUMN TBL_EMP.SAL IS '�޿�';
COMMENT ON COLUMN TBL_EMP.COMM IS '����';
COMMENT ON COLUMN TBL_EMP.DEPTNO IS '�μ� ��ȣ';

SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME='TBL_EMP';
--==>>
/*
TBL_EMP	EMPNO	    ��� ��ȣ
TBL_EMP	ENAME	    �����
TBL_EMP	JOB	        ������
TBL_EMP	MGR	        ������ �����ȣ
TBL_EMP	HIREDATE	�Ի���
TBL_EMP	SAL     	�޿�
TBL_EMP	COMM    	����
TBL_EMP	DEPTNO	    �μ� ��ȣ
*/

--���� �÷� ������ �߰� �� ���� ����--
SELECT *
FROM TBL_EMP;
--==>>
/*
7369	SMITH	CLERK	    7902	1980-12-17	800		        20
7499	ALLEN	SALESMAN	7698	1981-02-20	1600	300	    30
7521	WARD	SALESMAN	7698	1981-02-22	1250	500	    30
7566	JONES	MANAGER	    7839	1981-04-02	2975		    20
7654	MARTIN	SALESMAN	7698	1981-09-28	1250	1400	30
7698	BLAKE	MANAGER	    7839	1981-05-01	2850		    30
7782	CLARK	MANAGER	    7839	1981-06-09	2450		    10
7788	SCOTT	ANALYST	    7566	1987-07-13	3000		    20
7839	KING	PRESIDENT		    1981-11-17	5000		    10
7844	TURNER	SALESMAN	7698	1981-09-08	1500	0	    30
7876	ADAMS	CLERK	    7788	1987-07-13	1100		    20
7900	JAMES	CLERK	    7698	1981-12-03	950		        30
7902	FORD	ANALYST	    7566	1981-12-03	3000		    20
7934	MILLER	CLERK	    7782	1982-01-23	1300		    10
*/

--�� TBL_EMP ���̺� �ֹε�Ϲ�ȣ �����͸� ���� �� �ִ� �÷� �߰�
--   �� SSN  CHAR(13)
--   �տ� 0�� ���� �� ������ ���ڿ��� ...
ALTER TABLE TBL_EMP 
ADD SSN CHAR(13);
--==>> Table TBL_EMP��(��) ����Ǿ����ϴ�.

SELECT 01012341234
FROM DUAL;
--==>> 1012341234

SELECT '01012341234'
FROM DUAL;
--==>> 01012341234


--�� Ȯ��
SELECT *
FROM TBL_EMP;

SELECT EMPNO, SSN
FROM TBL_EMP;

DESC TBL_EMP;

SELECT EMPNO, ENAME, SSN, JOB
FROM TBL_EMP;

--> SSN(�ֹε�Ϲ�ȣ) �÷��� ���������� ����(�߰�)�� ������ Ȯ��

--�� ���̺� ������ �÷��� ������ ���������� �ǹ� ����.


--�� TBL_EMP ���̺� �߰��� SSN(�ֹε�Ϲ�ȣ) �÷� ���������� ����
ALTER TABLE TBL_EMP
DROP COLUMN SSN;
--==>> Table TBL_EMP��(��) ����Ǿ����ϴ�.

SELECT *
FROM TBL_EMP;

DESC TBL_EMP;

--> SSN(�ֹε�Ϲ�ȣ) �÷��� ���������� �����Ǿ����� Ȯ��.

DELETE TBL_EMP;
--==>> 14�� �� ��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_EMP;
--> ���� �߻� �� ��
--  ������ ����.
--  ���̺��� ����(����, Ʋ)�� �״�� �����ִ� ���¿���
--  �����͸� ��� �ҽ�(����)�� ��Ȳ���� Ȯ��.

DESC TBL_EMP;

DROP TABLE TBL_EMP;
--==>> Table TBL_EMP��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_EMP;
--==>> ���� �߻�
--     (ORA-00942: table or view does not exist)

DESC TBL_EMP;
--==>> ���� �߻�
--     (ORA-04043: TBL_EMP ��ü�� �������� �ʽ��ϴ�.)

--�� ���̺� �ٽ� ����(����)

CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>> Table TBL_EMP��(��) �����Ǿ����ϴ�.

--�� NULL�� ó��

SELECT 2, 10+2, 10-2, 10*2, 10/2
FROM DUAL;
--==>> 2	12	8	20	5


SELECT NULL, NULL+2, 10-NULL, NULL*2, 2/NULL
FROM DUAL;
--==>> (NULL) (NULL) (NULL) (NULL) (NULL) 

--�� ������ ���
--   NULL�� ������ ���� �ǹ��ϸ�, ���������δ� ���� �������� �ʴ� ���̱� ������
--   �� NULL �� ���꿡 ���Ե� ���...
--   �� ����� ������ NULL �̴�.

--�� TBL_EMP ���̺��� Ŀ�̼�(COMM, ����)�� NULL�� ������
--   �����, ������, �޿�, Ŀ�̼� �׸��� ��ȸ�Ѵ�.
SELECT *
FROM TBL_EMP;

SELECT ENAME "�����", JOB "������", SAL "�޿�", COMM "Ŀ�̼�"  
FROM TBL_EMP
WHERE COMM = NULL;
--==>> ���� �߻����� ����
--     ��ȸ ��� ����

SELECT ENAME "�����", JOB "������", SAL "�޿�", COMM "Ŀ�̼�"  
FROM TBL_EMP
WHERE COMM = 'NULL';
--==>> ���� �߻�
--     (ORA-01722: invalid number)

SELECT ENAME "�����", JOB "������", SAL "�޿�", COMM "Ŀ�̼�"  
FROM TBL_EMP
WHERE COMM IS NULL;
--==>>
/*
SMITH	CLERK	     800     (NULL)
JONES	MANAGER 	2975	 (NULL)
BLAKE	MANAGER	    2850	 (NULL)
CLARK	MANAGER	    2450	 (NULL)
SCOTT	ANALYST	    3000	 (NULL)
KING	PRESIDENT	5000	 (NULL)
ADAMS	CLERK	    1100	 (NULL)
JAMES	CLERK	     950	 (NULL)
FORD	ANALYST	    3000	 (NULL)
MILLER	CLERK	    1300	 (NULL)
*/

--�� NULL �� ���� �����ϴ� ���� �ƴϱ� ������
--   �Ϲ����� �����ڸ� Ȱ���Ͽ� ���� �� ����.
--   NULL �� ������� ����� �� ���� �����ڵ�...
--   >=, <=, =, >, <, !=, ^=, <>
--                    ----------���� �ʴ�!

--�� TBL_EMP ���̺��� 20�� �μ��� �ٹ����� �ʴ� �������� 
--   �����, ������, �μ� ��ȣ �׸��� ��ȸ�Ѵ�.
SELECT *
FROM TBL_EMP;

SELECT ENAME "�����", JOB "������", DEPTNO "�μ� ��ȣ"
FROM TBL_EMP
WHERE DEPTNO <> 20;
--WHERE DEPTNO != 20;   -- ���� �ǹ�
--WHERE DEPTNO ^= 20;   -- ���� �ǹ�
--==>>
/*
ALLEN	SALESMAN	30
WARD	SALESMAN	30
MARTIN	SALESMAN	30
BLAKE	MANAGER 	30
CLARK	MANAGER	    10
KING	PRESIDENT	10
TURNER	SALESMAN	30
JAMES	CLERK	    30
MILLER	CLERK	    10
*/

--�� TBL_EMP ���̺��� Ŀ�̼��� NULL�� �ƴ� ��������
--   �����, ������, �޿�, Ŀ�̼� �׸��� ��ȸ�Ѵ�.
SELECT ENAME "�����", JOB "������", COMM "Ŀ�̼�"
FROM TBL_EMP
WHERE COMM IS NOT NULL;       -- NOT
--==>>
/*
ALLEN	SALESMAN	300
WARD	SALESMAN	500
MARTIN	SALESMAN	1400
TURNER	SALESMAN	0
*/

SELECT ENAME "�����", JOB "������", COMM "Ŀ�̼�"
FROM TBL_EMP
WHERE NOT COMM IS NULL;       -- NOT 
--==>>
/*
ALLEN	SALESMAN	300
WARD	SALESMAN	500
MARTIN	SALESMAN	1400
TURNER	SALESMAN	0
*/

--�� TBL_EMP ���̺��� ��� �������
--   �����ȣ, �����, �޿�, Ŀ�̼�, ���� �׸��� ��ȸ�Ѵ�.
--   ��, �޿�(SAL)�� �ſ� �����Ѵ�.
--   ����, ����(COMM)�� �� 1ȸ �����ϸ�(�ų� ����), ���� ������ ���Եȴ�.
SELECT *
FROM TBL_EMP;

-- ANNSAL "����" = SAL * 12 + COMM
SELECT EMPNO "�����ȣ", ENAME "�����", SAL "�޿�", COMM "Ŀ�̼�", SAL * 12 "����"
FROM TBL_EMP;
-- COMM�� ��� ����? NULL �� ���� NULL

-- �� �̷���

SELECT �����ȣ, �����, �޿�, Ŀ�̼�, ����
FROM TBL_EMP;

SELECT EMPNO "�����ȣ", ENAME "�����", SAL "�޿�", COMM "Ŀ�̼�", SAL * 12 "����"
FROM TBL_EMP;

SELECT EMPNO "�����ȣ", ENAME "�����", SAL "�޿�", COMM "Ŀ�̼�", SAL * 12 + COMM "����"
FROM TBL_EMP;
--> COMM�� NULL�̸� ���� ���� ����� NULL�� ��

--�� NVL()
SELECT NULL "COL1", NVL(NULL, 10) "COL2", NVL(5, 10) "COL3"
FROM DUAL;
--==>>(null)    10  5
-- ù ��° �Ķ���� ���� NULL �̸�, �� ��° �Ķ���� ���� ��ȯ�Ѵ�.
-- ù ��° �Ķ���� ���� NULL �� �ƴϸ�, �� ���� �״�� ��ȯ�Ѵ�.

SELECT ENAME "�����", COMM "����"
FROM TBL_EMP;

SELECT ENAME "�����", NVL(COMM, 1234) "����"
FROM TBL_EMP;

SELECT EMPNO "�����ȣ", ENAME "�����", SAL "�޿�", COMM "Ŀ�̼�", NVL(COMM, 0) "����"
FROM TBL_EMP;