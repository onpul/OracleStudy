SELECT USER
FROM DUAL;
--==>> SCOTT

SELECT DEPTNO, SAL
FROM EMP
ORDER BY 1;
--==>>
/*
10	2450 ��
10	5000 ��8750
10	1300 ��
20	2975 ��
20	3000 ��
20	1100 ��10875
20	800  ��
20	3000 ��
30	1250 ��
30	1500 ��
30	1600 ��9400
30	950  ��
30	2850 ��
30	1250 ��
*/


SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
ORDER BY 1;
--==>>
/*
10	8750
20	10875
30	9400
*/

SELECT *
FROM EMP;

SELECT *
FROM TBL_EMP;


--�� ������ �����ص� TBL_EMP ���̺� ����
DROP TABLE TBL_EMP;
--==>> Table TBL_EMP��(��) �����Ǿ����ϴ�.


--�� �ٽ� EMP ���̺� �����Ͽ� TBL_EMP ���̺� ����
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>> Table TBL_EMP��(��) �����Ǿ����ϴ�.


--�� �ǽ� ������ �߰� �Է�(TBL_EMP)
SELECT *
FROM TBL_EMP;

INSERT INTO TBL_EMP VALUES
(8001, 'ȫ����', 'CLERK', 7566, SYSDATE, 1500, 10, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP VALUES
(8002, '����', 'CLERK', 7566, SYSDATE, 2000, 10, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP VALUES
(8003, '��ȣ��', 'SALESMAN', 7698, SYSDATE, 1700, NULL, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP VALUES
(8004, '�Ž���', 'SALESMAN', 7698, SYSDATE, 2500, NULL, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP VALUES
(8005, '������', 'SALESMAN', 7698, SYSDATE, 1000, NULL, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


--�� Ȯ��
SELECT *
FROM TBL_EMP;
--==>>
/*
7369	SMITH	CLERK	    7902	1980-12-17	 800   (null)   20
7499	ALLEN	SALESMAN	7698	1981-02-20	1600	 300	30
7521	WARD	SALESMAN	7698	1981-02-22	1250	 500	30
7566	JONES	MANAGER	    7839	1981-04-02	2975   (null)   20
7654	MARTIN	SALESMAN	7698	1981-09-28	1250	1400	30
7698	BLAKE	MANAGER	    7839	1981-05-01	2850   (null)   30
7782	CLARK	MANAGER	    7839	1981-06-09	2450   (null)   10
7788	SCOTT	ANALYST	    7566	1987-07-13	3000   (null)   20
7839	KING	PRESIDENT  (null)   1981-11-17	5000   (null)   10
7844	TURNER	SALESMAN	7698	1981-09-08	1500	   0    30
7876	ADAMS	CLERK	    7788	1987-07-13	1100   (null)   20
7900	JAMES	CLERK	    7698	1981-12-03	 950   (null)   30
7902	FORD	ANALYST	    7566	1981-12-03	3000   (null)   20
7934	MILLER	CLERK	    7782	1982-01-23	1300   (null)   10
8001	ȫ����	CLERK	    7566	2022-02-24	1500	10	
8002	����	CLERK	    7566	2022-02-24	2000	10	
8003	��ȣ��	SALESMAN	7698	2022-02-24	1700		
8004	�Ž���	SALESMAN	7698	2022-02-24	2500		
8005	������	SALESMAN	7698	2022-02-24	1000		
*/


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

SELECT DEPTNO, SAL, COMM
FROM TBL_EMP
ORDER BY COMM DESC;
--==>>
/*
20	     800	(null)
(null)	1700	(null)
(null)	1000	(null)
10	    1300	(null)
20	    2975	(null)
30	    2850	(null)
10	    2450	(null)
20	    3000	(null)
10	    5000	(null)
(null)	2500	(null)
20	    1100	(null)
30	    950	    (null)
20	    3000	(null)
30	    1250	 1400
30	    1250	  500
30	    1600	  300
(null)	1500	   10
(null)	2000	   10
30	    1500	    0
*/

--�� ����Ŭ������ NULL�� ���� ū ���� ���·� �����Ѵ�.
--   (ORACLE 9i ������ NULL �� ���� ���� ���� ���·� �����߾���.)
--   MSSQL�� NULL�� ���� ���� ���� ���·� �����Ѵ�.


--�� TBL_EMP ���̺��� ������� �μ��� �޿��� ��ȸ
-- �μ���ȣ, �޿��� �׸� ��ȸ
SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;
--==>>
/*
    10	 8750
    20	10875
    30	 9400
(null)	 8700   --�μ���ȣ�� NULL�� ������� ��
*/

--�� ROLLUP ���
SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
   10	 8750
   20	10875
   30	 9400
(null)	 8700   -- �μ���ȣ�� ���� ���� �������� �޿���
(null)	37725   -- ���μ� �������� �޿���
*/

SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
   10	 8750
   20	10875
   30	 9400
(null)	29025
*/

--==>>
/*
--------    ------
�μ���ȣ    �޿��� 
--------    ------
10	         8750
20	        10875
30	         9400
���μ�	29025
*/

SELECT NVL(TO_CHAR(DEPTNO), '���μ�') "�μ���ȣ", SUM(SAL) "�޿���"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
���μ�	29025
*/

SELECT NVL2(DEPTNO, TO_CHAR(DEPTNO), '���μ�') "�μ���ȣ", SUM(SAL) "�޿���"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
���μ�	29025
*/

SELECT *
FROM TBL_EMP;

SELECT NVL(TO_CHAR(DEPTNO), '���μ�') "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
���μ�	 8700
���μ�	37725
*/

SELECT NVL2(DEPTNO, TO_CHAR(DEPTNO), '���μ�') "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
���μ�	 8700
���μ�	37725
*/

SELECT GROUPING(DEPTNO) "GROUPING", DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
GROUPING   �μ���ȣ   �޿���
--------   --------   ------
       0         10     8750
       0	     20	   10875
       0	     30	    9400
       0	  (null)    8700     -- ����
       1	  (null)   37725     -- ���μ�
*/

SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	     8750
20	    10875
30	     9400
(null)	 8700
(null)	37725
*/

--�� ������ ��ȸ�� �ش� ������
/*
10	         8750
20	        10875
30	         9400
����	     8700
���μ�	37725
*/
-- �̿� ���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.

--�� ����
SELECT GROUPING(DEPTNO) "GROUPING", DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);

--�� ��Ʈ
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN '���Ϻμ�'
            ELSE '���μ�'
       END "�μ���ȣ"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
���Ϻμ�	8750
���Ϻμ�	10875
���Ϻμ�	9400
���Ϻμ�	8700
���μ�	37725
*/

SELECT CASE WHEN TO_CHAR(GROUPING(DEPTNO)) = '0' THEN NVL(TO_CHAR(DEPTNO), '����') 
            WHEN TO_CHAR(GROUPING(DEPTNO)) = '1' THEN NVL(TO_CHAR(DEPTNO), '���μ�')
            ELSE 'Ȯ�� �Ұ�'
       END  "�μ���ȣ"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
����	     8700
���μ�	37725
*/

SELECT CASE TO_CHAR(GROUPING(DEPTNO)) -- CASE�� ���� ��� CASE�� ���� �� �� ����
            WHEN '0' THEN NVL(TO_CHAR(DEPTNO), '����') 
            WHEN '1' THEN NVL(TO_CHAR(DEPTNO), '���μ�')
            ELSE 'Ȯ�� �Ұ�'
       END  "�μ���ȣ"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
����	     8700
���μ�	37725
*/

-- ���� Ǯ��
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN TO_CHAR(DEPTNO)
            ELSE '���μ�'
       END "�μ���ȣ"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
             8700
���μ�	37725
*/

--==>> ����
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
            ELSE '���μ�'
       END "�μ���ȣ"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
����	     8700
���μ�	37725
*/


--�� TBL_SAWON ���̺��� �������
--   ������ ���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
/*
---------------------------
  ����            �޿���
---------------------------
   ��             XXXXXX
   ��             XXXXXX   
   �����       XXXXXX
---------------------------   
*/
-- �� Ǯ�� ---------------------------------------------------------------------
SELECT *
FROM TBL_SAWON;

SELECT GROUPING(T.����)
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '����'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '����'
                ELSE '����Ȯ�κҰ�'
           END "����" 
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.����);
--==>>
/*
0
0
1
*/

SELECT CASE WHEN GROUPING(T.����) IS NOT NULL THEN NVL(T.����, '�����')
            ELSE 'Ȯ�κҰ�'
       END "����"
     , SUM(T.�޿�) "�޿���"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '����'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '����'
                ELSE '����Ȯ�κҰ�'
           END "����" 
         , SAL "�޿�"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.����);
--==>>
/*
����	    21900
����	    32100
�����	54000
*/

-- ���� Ǯ�� -------------------------------------------------------------------
SELECT T.���� "����"
     , SUM(T.�޿�) "�޿���"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '��'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '��'
                ELSE '����Ȯ�κҰ�'
           END "����"
         , SAL "�޿�"  
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.����);
--==>> 
/*
��	    21900
��	    32100
(null)	54000
*/

SELECT CASE GROUPING(T.����) WHEN 0 THEN T.���� 
                             ELSE '�����' 
       END "����"
     , SUM(T.�޿�) "�޿���"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '��'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '��'
                ELSE '����Ȯ�κҰ�'
           END "����"
         , SAL "�޿�"  
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.����);
--==>>
/*
��	        21900
��	        32100
�����	54000
*/


SELECT *
FROM VIEW_SAWON;

--�� TBL_SAWON ���̺��� �������
--   ������ ���� ��ȸ�� �� �ֵ��� ���ɴ뺰 �ο����� Ȯ���� �� �ִ�
--   �������� �����Ѵ�.
/*
----------------------
  ���ɴ�      �ο���
----------------------
  10              X
  20              X
  40              X
  50              X
  ��ü           XX
----------------------
*/

-- �� Ǯ�� ---------------------------------------------------------------------

-- ���̺� ��ȸ
SELECT *
FROM TBL_SAWON;

-- ���ɴ�
SELECT (SUBSTR(T.���糪��, 1, 1) || '0') "���ɴ�"
FROM
(
SELECT
     CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
     THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
     WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
     THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
     ELSE -1 
END "���糪��"
FROM TBL_SAWON
) T;

-- ���� 
SELECT CASE GROUPING(T2.���ɴ�) WHEN 0 THEN T2.���ɴ� 
                                ELSE '��ü' 
       END "���ɴ�" 
     , COUNT(T2.���ɴ�) "�ο���"
FROM
(
    SELECT (SUBSTR(T.���糪��, 1, 1) || '0') "���ɴ�"
    FROM
    (
        SELECT
             CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
             THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
             WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
             THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
             ELSE -1 
        END "���糪��"
        FROM TBL_SAWON
    ) T
) T2
GROUP BY ROLLUP(T2.���ɴ�);
--==>>
/*
10	     2
20	    12
40	     1
50	     3
��ü	18
*/

-- ���� Ǯ�� -------------------------------------------------------------------

-- ��� 1. �� INLINE VIEW�� �� �� ��ø

-- ����
SELECT NVL(TO_CHAR(T2.���ɴ�), '��ü') "���ɴ�"
     , COUNT(*) "�ο���"
FROM 
(
    -- ���ɴ�
    SELECT CASE WHEN T1.���� >= 50 THEN 50 
                WHEN T1.���� >= 40 THEN 40 
                WHEN T1.���� >= 30 THEN 30
                WHEN T1.���� >= 20 THEN 20
                WHEN T1.���� >= 10 THEN 10
                ELSE 0 
           END "���ɴ�"
    FROM
    (
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
                    WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)  
                    ELSE -1
               END "����"
        FROM TBL_SAWON  
    ) T1
)T2
GROUP BY ROLLUP(T2.���ɴ�);
--==>>
/*
10	     2
20	    12
40	     1
50	     3
��ü	18
*/

SELECT CASE GROUPING(T2.���ɴ�) WHEN 0 THEN TO_CHAR(T2.���ɴ�)
            ELSE '��ü' END "���ɴ�"
     , COUNT(*) "�ο���"
FROM 
(
    -- ���ɴ�
    SELECT CASE WHEN T1.���� >= 50 THEN 50 
                WHEN T1.���� >= 40 THEN 40 
                WHEN T1.���� >= 30 THEN 30
                WHEN T1.���� >= 20 THEN 20
                WHEN T1.���� >= 10 THEN 10
                ELSE 0 
           END "���ɴ�"
    FROM
    (
        SELECT SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
                    WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)  
                    ELSE -1
               END "����"
        FROM TBL_SAWON  
    ) T1
)T2
GROUP BY ROLLUP(T2.���ɴ�);

-- ��� 2. �� INLINE VIEW�� �� ����

--���ɴ�
SELECT CASE GROUPING(T.���ɴ�) WHEN 0 THEN TO_CHAR(T.���ɴ�)
                               ELSE '��ü' 
       END "���ɴ�"
     , COUNT(*) "�ο���"

FROM
(
    SELECT TRUNC(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                      THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
                      WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                      THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)  
                      ELSE -1
                 END, -1) "���ɴ�"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.���ɴ�);
--==>>
/*
10	     2
20	    12
40	     1
50	     3
��ü	18
*/

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY 1, 2;
--==>>
/*
10	CLERK	    1300
10	MANAGER	    2450
10	PRESIDENT	5000
20	ANALYST	    6000
20	CLERK	    1900
20	MANAGER	    2975
30	CLERK	     950
30	MANAGER	    2850
30	SALESMAN	5600
*/

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	     1300   -- 10�� �μ� CLERK ������ �޿���
10	    MANAGER	     2450   -- 10�� �μ� MANAGER ������ �޿���
10	    PRESIDENT	 5000   -- 10�� �μ� PRESIDENT ������ �޿���
10	    (null)       8750   -- 10�� �μ� ��� ������ �޿���        -- CHECK~!!!
20	    ANALYST	     6000   -- 20�� �μ� ANALYST ������ �޿���
20	    CLERK	     1900   -- 20�� �μ� CLERK ������ �޿���
20	    MANAGER	     2975   -- 20�� �μ� MANAGER ������ �޿���
20	    (null)      10875   -- 20�� �μ� ��� ������ �޿���        -- CHECK~!!!
30	    CLERK	      950   -- 30�� �μ� CLERK ������ �޿���
30	    MANAGER	     2850   -- 30�� �μ� MANAGER ������ �޿���
30	    SALESMAN	 5600   -- 30�� �μ� SALESMAN ������ �޿���
30	    (null)       9400   -- 30�� �μ� ��� ������ �޿���        -- CHECK~!!!
(null)  (null)      29025   -- ��� �μ� ��� ������ �޿���        -- CHECK~!!!
*/


--�� CUBE() �� ROLLUP() ���� �� �ڼ��� ����� ��ȯ�޴´�.
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	     1300
10	    MANAGER	     2450
10	    PRESIDENT	 5000
10	    (null)	     8750
20	    ANALYST	     6000
20	    CLERK	     1900
20	    MANAGER	     2975
20	    (null)	    10875
30	    CLERK	      950
30	    MANAGER	     2850
30	    SALESMAN	 5600
30	    (null)	     9400
(null)	ANALYST	     6000   -- ��� �μ� ANALYST ������ �޿���
(null)	CLERK	     4150   -- ��� �μ� CLERK ������ �޿���
(null)	MANAGER	     8275   -- ��� �μ� MANAGER ������ �޿���
(null)	PRESIDENT	 5000   -- ��� �μ� PRESIDENT ������ �޿���
(null)	SALESMAN	 5600   -- ��� �μ� SALESMAN ������ �޿���
(null)  (null)      29025
*/

-- �� ROLLUP() �� CUBE() ��
--    �׷��� �����ִ� ����� �ٸ���. (����)

-- ex.
-- ROLLUP(A, B, C)
-- �� (A, B, C) / (A, B) / (A) / ()

-- CUBE(A, B, C)
-- �� (A, B, C) / (A, B) / (A, C) / (B, C) / (A) / (B) / (C) / ()

--==>> ������ ����� ��(ROLLUP())�� ���� ����� �ټ� ���ڶ��
--     �Ʒ����� ����� ��(CUBE())�� ���� ����� �ټ� ����ġ�� ������
--     ������ ���� ����� ���� ���¸� �� ���� ����Ѵ�.
--     ���� �ۼ��ϴ� ������ ��ȸ�ϰ��� �ϴ� �׷츸 ��GROUPING SETS����
--     �̿��Ͽ� �����ִ� ����̴�.
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����') 
            ELSE '��ü�μ�'
       END "�μ���ȣ"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '��ü����'
       END "����"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	        CLERK	     1300
10	        MANAGER	     2450
10	        PRESIDENT	 5000
10	        ��ü����	 8750
20	        ANALYST	     6000
20	        CLERK	     1900
20	        MANAGER	     2975
20	        ��ü����	10875
30	        CLERK	      950
30	        MANAGER	     2850
30	        SALESMAN	 5600
30	        ��ü����	 9400
����	    CLERK	     3500
����	    SALESMAN	 5200
����	    ��ü����	 8700
��ü�μ�	��ü����	37725
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����') 
            ELSE '��ü�μ�'
       END "�μ���ȣ"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '��ü����'
       END "����"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	        CLERK	     1300
10	        MANAGER	     2450
10	        PRESIDENT	 5000
10	        ��ü����	 8750
20	        ANALYST 	 6000
20	        CLERK	     1900
20	        MANAGER	     2975
20	        ��ü����	10875
30	        CLERK	      950
30	        MANAGER	     2850
30	        SALESMAN	 5600
30	        ��ü����	 9400
����	    CLERK	     3500
����	    SALESMAN	 5200
����	    ��ü����	 8700
��ü�μ�	ANALYST	     6000
��ü�μ�	CLERK	     7650
��ü�μ�	MANAGER	     8275
��ü�μ�	PRESIDENT	 5000
��ü�μ�	SALESMAN	10800
��ü�μ�	��ü����	37725
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����') 
            ELSE '��ü�μ�'
       END "�μ���ȣ"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '��ü����'
       END "����"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), (JOB), ())
ORDER BY 1, 2;
--> CUBE() �� ����� ����� ���� ��ȸ ���

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����') 
            ELSE '��ü�μ�'
       END "�μ���ȣ"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '��ü����'
       END "����"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), ())
ORDER BY 1, 2;
--> ROLLUP() �� ����� ����� ���� ��ȸ ���

SELECT *
FROM TBL_EMP
ORDER BY HIREDATE;


--�� TBL_EMP ���̺��� �������
--   �Ի�⵵�� �ο����� ��ȸ�Ѵ�.
--   �ο��� ���յ�!

-- �� Ǯ�� ---------------------------------------------------------------------
SELECT *
FROM TBL_EMP
ORDER BY HIREDATE;

SELECT T.*, COUNT(T.�Ի�⵵) "�ο���"
FROM
(
    SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
    FROM TBL_EMP
) T GROUP BY GROUPING SETS((T.�Ի�⵵), ());
--==>>
/*
1980	 1
1981	10
1982	 1
1987	 2
2022	 5
(null)  19
*/






   


