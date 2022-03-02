SELECT USER
FROM DUAL;
--==>> SCOTT

SELECT *
FROM TBL_SAWON;

--�� TBL_SAWON ���̺��� Ȱ���Ͽ� 
--   ������ ���� �׸���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
--   �����ȣ, �����, �ֹι�ȣ, ����, �Ի���

SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '����' 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '����'
            ELSE '����Ȯ�κҰ�' 
       END "����"
     , HIREDATE"�Ի���"
FROM TBL_SAWON;
--==>>
/*
1001	��μ�	    9707251234567	����	2005-01-03
1002	������	    9505152234567	����	1999-11-23
1003	������	    9905192234567	����	2006-08-10
1004	�̿���	    9508162234567	����	2007-10-10
1005	���̻�	    9805161234567	����	2007-10-10
1006	������	    8005132234567	����	1999-10-10
1007	������	    0204053234567	����	2010-10-10
1008	������	    6803171234567	����	1998-10-10
1009	������	6912232234567	����	1998-10-10
1010	���켱	    0303044234567	����	2010-10-10
1011	������	    0506073234567	����	2012-10-10
1012	���ù�	    0208073234567	����	2012-10-10
1013	����	    6712121234567	����	1998-10-10
1014	ȫ����	    0005044234567	����	2015-10-10
1015	�Ӽҹ�	    9711232234567	����	2007-10-10
1016	���̰�	    0603194234567	����	2015-01-20
*/


--�� TBL_SAWON ���̺��� Ȱ���Ͽ� 
--   ������ ���� �׸���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
--   �������ȣ, �����, �ֹι�ȣ, ����, ���糪��, �Ի���, 
--     ����������, �ٹ��ϼ�, �����ϼ�, �޿�, ���ʽ���
--   ��, ���糪�̴� �⺻ �ѱ����� ������ ���� ������ �����Ѵ�.
--   ����, ������������ �ش� ������ ���̰� �ѱ����̷� 60���� �Ǵ� ����
--   �� ������ �Ի� ��, �Ϸ� ������ �����Ѵ�.
--   �׸���, ���ʽ��� 1000�� �̻� 2000�� �̸� �ٹ��� �����
--   �� ����� ���� �޿� ���� 30% ����, 2000�� �̻� �ٹ��� �����
--   �� ����� ���� �޿� ���� 50% ������ �� �� �ֵ��� ó���Ѵ�.

--EX) 1001 ��μ� 9707251234567 ���� 26 2005-01-03 2056-01-03 212121 2232323 3000 1500

-- �� Ǯ�� ---------------------------------------------------------------------
-- �����ϼ� �����ؾ� ��!!!
/*
SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ", 
       CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '����' 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '����'
            ELSE '���� Ȯ�κҰ�' 
       END "����",  
       CASE WHEN TO_NUMBER(SUBSTR(JUBUN, 1, 1)) > 0 
            THEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER('19'||(SUBSTR(JUBUN, 1, 2))) + 1
            WHEN TO_NUMBER(SUBSTR(JUBUN, 1, 1)) = 0 
            THEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER('20'||(SUBSTR(JUBUN, 1, 2))) + 1
            ELSE 0 
       END "���糪��"
       , HIREDATE "�Ի���", 
       CASE WHEN TO_NUMBER(SUBSTR(JUBUN, 1, 1)) > 0 
            THEN TO_CHAR(ADD_MONTHS(SYSDATE, ((60 - (TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER('19'||(SUBSTR(JUBUN, 1, 2))) + 1))*12)), 'YYYY') || '-' || TO_CHAR(HIREDATE, 'MM-DD') 
            WHEN TO_NUMBER(SUBSTR(JUBUN, 1, 1)) = 0 
            THEN TO_CHAR(ADD_MONTHS(SYSDATE, ((60 - (TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER('20'||(SUBSTR(JUBUN, 1, 2))) + 1))*12)), 'YYYY') || '-' || TO_CHAR(HIREDATE, 'MM-DD')
            ELSE '���������� Ȯ�κҰ�' 
       END "����������"
       , TRUNC(SYSDATE - HIREDATE) "�ٹ��ϼ�", 
       CASE WHEN TO_NUMBER(SUBSTR(JUBUN, 1, 1)) > 0 
            THEN TRUNC(ADD_MONTHS(SYSDATE, ((60 - (TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER('19'||(SUBSTR(JUBUN, 1, 2))) + 1))*12)) - SYSDATE)
            WHEN TO_NUMBER(SUBSTR(JUBUN, 1, 1)) = 0 
            THEN TRUNC(ADD_MONTHS(SYSDATE, ((60 - (TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER('20'||(SUBSTR(JUBUN, 1, 2))) + 1))*12)) - SYSDATE)
            ELSE 0 
       END "�����ϼ�", 
       SAL "�޿�", 
       CASE WHEN TRUNC(SYSDATE - HIREDATE) >= 1000 AND TRUNC(SYSDATE - HIREDATE) < 2000
            THEN SAL * 0.3
            WHEN TRUNC(SYSDATE - HIREDATE) >= 2000
            THEN SAL * 0.5
            ELSE 0
       END "���ʽ�"
FROM TBL_SAWON;

-- ���ʽ� ���ϱ�
SELECT CASE WHEN TRUNC(SYSDATE - HIREDATE) >= 1000 AND TRUNC(SYSDATE - HIREDATE) < 2000
            THEN TO_CHAR(SAL * 0.3)
            WHEN TRUNC(SYSDATE - HIREDATE) >= 2000
            THEN TO_CHAR(SAL * 0.5)
            ELSE '���ʽ� �����Ұ�'
       END "���ʽ�"
FROM TBL_SAWON;

-- ���������� ���ϱ�
SELECT TO_CHAR(ADD_MONTHS(SYSDATE, ((60 - (TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER('19'||(SUBSTR(JUBUN, 1, 2))) + 1))*12)), 'YYYY') || '-' || TO_CHAR(HIREDATE, 'MM-DD')
FROM TBL_SAWON
WHERE SANAME = '��μ�';

SELECT (60 - (TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER('19'||(SUBSTR(JUBUN, 1, 2))) + 1)) 
FROM TBL_SAWON
WHERE SANAME = '��μ�';

-- ���糪�� ���ϱ�
SELECT CASE WHEN TO_NUMBER(SUBSTR(JUBUN, 1, 1)) > 0 
            THEN TO_CHAR(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER('19'||(SUBSTR(JUBUN, 1, 2))) + 1)  
            ELSE '����Ȯ�κҰ�' 
       END "���糪��"
FROM TBL_SAWON;

SELECT TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER('19'||(SUBSTR(JUBUN, 1, 2))) + 1   
FROM TBL_SAWON
WHERE SANAME = '��μ�';

SELECT CASE WHEN TO_NUMBER(SUBSTR(JUBUN, 1, 1)) > 0  THEN '1' 
            ELSE '����Ȯ�κҰ�' 
       END "����"
FROM TBL_SAWON
*/

SELECT *
FROM TBL_SAWON;

-- ���� Ǯ��

-- �����ȣ, �����, �ֹι�ȣ, ����, ���糪��, �Ի���, �޿� ... ����
SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
    -- ����
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '����'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '����'
            ELSE '����Ȯ�κҰ�'
       END "����"
    -- ���糪�� = ����⵵ - �¾�⵵ + 1 (1900��� / 2000���)
     , CASE WHEN 1900�����̶�� THEN ����⵵ - (�ֹι�ȣ�յ��ڸ� + 1899) 
            WHEN 1900�����̶�� THEN ����⵵ - (�ֹι�ȣ�յ��ڸ� + 1999) 
            ELSE END "���糪��"
FROM TBL_SAWON;

SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
    -- ����
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '����'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '����'
            ELSE '����Ȯ�κҰ�'
       END "����"
    -- ���糪�� = ����⵵ - �¾�⵵ + 1 (1900��� / 2000���)
     , CASE WHEN �ֹι�ȣ 7��°�ڸ� 1���� '1'�Ǵ� '2' 
            THEN ����⵵ - (�ֹι�ȣ�յ��ڸ� + 1899) 
            WHEN �ֹι�ȣ 7��°�ڸ� 1���� '3'�Ǵ� '4' 
            THEN ����⵵ - (�ֹι�ȣ�յ��ڸ� + 1999) 
            ELSE -1 
       END "���糪��"
       
FROM TBL_SAWON;

SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
    -- ����
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '����'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '����'
            ELSE '����Ȯ�κҰ�'
       END "����"
    -- ���糪�� = ����⵵ - �¾�⵵ + 1 (1900��� / 2000���)
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (�ֹι�ȣ�յ��ڸ� + 1899) 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (�ֹι�ȣ�յ��ڸ� + 1999) 
            ELSE -1 
       END "���糪��"
       
FROM TBL_SAWON;

SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
    -- ����
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '����'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '����'
            ELSE '����Ȯ�κҰ�'
       END "����"
    -- ���糪�� = ����⵵ - �¾�⵵ + 1 (1900��� / 2000���)
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
            ELSE -1 
       END "���糪��"
    -- �Ի���
     , HIREDATE "�Ի���"   
    -- �޿�
     , SAL
FROM TBL_SAWON;

--�� ���� �÷�???? FROM �ȿ� SELECT �� �־� ������!!!

SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM, 0) "����"
FROM EMP;

SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM, 0) "����", ����*2 "�ι迬��"
FROM EMP;
--==> ���� �߻�
--    (ORA-00904: "����": invalid identifier)

SELECT T.EMPNO, T.ENAME, T.SAL, T.����, T.����*2 "�ι迬��"
FROM
(
    SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM, 0) "����"
    FROM EMP
) T;

SELECT T.*
FROM
(
    SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM, 0) "����"
    FROM EMP
) T;


-- �����ȣ, �����, �ֹι�ȣ, ����, ���糪��, �Ի���, 
-- , ����������, �ٹ��ϼ�, �����ϼ�, �޿�, ���ʽ�
SELECT T.�����ȣ, T.�����, T.�ֹι�ȣ, T.����, T.���糪��, T.�Ի���
    -- ����������
    -- ���������⵵ �� �ش� ������ ���̰� �ѱ����̷� 60���� �Ǵ� ��
    -- ���� ���̰�... 57��...  3�� ��        2022 �� 2025
    -- ���� ���̰�... 28��... 32�� ��        2022 �� 2054
    -- ADD_MONTHS(SYSDATE, �������*12)
    --                     --------
    --                      60 - ���糪��
    -- ADD_MONTHS(SYSDATE, (60 - ���糪��) * 12) �� Ư����¥
    -- TO_CHAR('Ư����¥', 'YYYY')     �� �������� �⵵�� ����Ÿ������ ����
    -- TO_CHAR(�Ի���, 'MM-DD')        �� �Ի� ���ϸ� ����Ÿ������ ����
    -- TO_CHAR('Ư����¥', 'YYYY') || '-' || TO_CHAR(�Ի���, 'MM-DD') "����������"
    -- TO_CHAR(ADD_MONTHS(SYSDATE, (60 - ���糪��) * 12), 'YYYY') || '-' || TO_CHAR(�Ի���, 'MM-DD') "����������"
    , TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.���糪��) * 12), 'YYYY') || '-' || TO_CHAR(T.�Ի���, 'MM-DD') "����������"
    
    -- �ٹ��ϼ�
    -- �ٹ��ϼ� = ������ - �Ի���
     , TRUNC(SYSDATE - T.�Ի���) "�ٹ��ϼ�"
     
    -- �����ϼ�
    -- �����ϼ� = ���������� - ������
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.���糪��) * 12), 'YYYY') || '-' || TO_CHAR(T.�Ի���, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "�����ϼ�"
     
    -- �޿�
    , T.�޿�
    
    -- ���ʽ�
    -- �ٹ��ϼ��� 1000�� �̻� 2000�� �̸� �� ���� �޿��� 30% ����
    -- �ٹ��ϼ��� 2000�� �̻�             �� ���� �޿��� 50% ����
    -- ������                             �� 0     
    -------------------------------------------------------------
    -- �ٹ��ϼ� 2000�� �̻�               �� T.�޿� * 0.5
    -- �ٹ��ϼ� 1000�� �̻�               �� T.�޿� * 0.3
    -- ������                             �� 0     
    -------------------------------------------------------------
    , CASE WHEN TRUNC(SYSDATE - T.�Ի���) >= 2000 THEN T.�޿� * 0.5
           WHEN TRUNC(SYSDATE - T.�Ի���) >= 1000 THEN T.�޿� * 0.3
           ELSE 0
      END "���ʽ�"
FROM 
(
    SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
        -- ����
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '����'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '����'
                ELSE '����Ȯ�κҰ�'
           END "����"
        -- ���糪�� = ����⵵ - �¾�⵵ + 1 (1900��� / 2000���)
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
                ELSE -1 
           END "���糪��"
        -- �Ի���
         , HIREDATE "�Ի���"   
        -- �޿�
         , SAL "�޿�"
    FROM TBL_SAWON
) T;
--==>>
/*
1001	��μ�	    9707251234567	����	26	2005-01-03	2056-01-03	6260	12366	3000	1500
1002	������	    9505152234567	����	28	1999-11-23	2054-11-23	8128	11960	4000	2000
1003	������	    9905192234567	����	24	2006-08-10	2058-08-10	5676	13316	3000	1500
1004	�̿���	    9508162234567	����	28	2007-10-10	2054-10-10	5250	11916	4000	2000
1005	���̻�	    9805161234567	����	25	2007-10-10	2057-10-10	5250	13012	4000	2000
1006	������	    8005132234567	����	43	1999-10-10	2039-10-10	8172	 6437	1000	 500
1007	������	    0204053234567	����	21	2010-10-10	2061-10-10	4154	14473	1000	 500
1008	������	    6803171234567	����	55	1998-10-10	2027-10-10	8537	 2054	1500	 750
1009	������	6912232234567	����	54	1998-10-10	2028-10-10	8537	 2420	1300	 650
1010	���켱	    0303044234567	����	20	2010-10-10	2062-10-10	4154	14838	1600	 800
1011	������	    0506073234567	����	18	2012-10-10	2064-10-10	3423	15569	2600	1300
1012	���ù�	    0208073234567	����	21	2012-10-10	2061-10-10	3423	14473	2600	1300
1013	����	    6712121234567	����	56	1998-10-10	2026-10-10	8537	 1689	2200	1100
1014	ȫ����	    0005044234567	����	23	2015-10-10	2059-10-10	2328	13742	5200	2600
1015	�Ӽҹ�	    9711232234567	����	26	2007-10-10	2056-10-10	5250	12647	5500	2750
1016	���̰�	    0603194234567	����	17	2015-01-20	2065-01-20	2591	15671	1500	 750
*/
--==>> �ζ��� ��!!! ��� �� (FROM ������ ���� ���� ����)

--�� TBL_SAWON ���̺��� ������ �߰� �Է�
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1017, '��ȣ��', '9611121234567', SYSDATE, 5000); 
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_SAWON;

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

SELECT T.�����ȣ, T.�����, T.�ֹι�ȣ, T.����, T.���糪��, T.�Ի���
    , TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.���糪��) * 12), 'YYYY') || '-' || TO_CHAR(T.�Ի���, 'MM-DD') "����������"
     , TRUNC(SYSDATE - T.�Ի���) "�ٹ��ϼ�"
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.���糪��) * 12), 'YYYY') || '-' || TO_CHAR(T.�Ի���, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "�����ϼ�"
    , T.�޿�
    , CASE WHEN TRUNC(SYSDATE - T.�Ի���) >= 2000 THEN T.�޿� * 0.5
           WHEN TRUNC(SYSDATE - T.�Ի���) >= 1000 THEN T.�޿� * 0.3
           ELSE 0
      END "���ʽ�"
FROM 
(
    SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '����'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '����'
                ELSE '����Ȯ�κҰ�'
           END "����"
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
                ELSE -1 
           END "���糪��"
         , HIREDATE "�Ի���"   
         , SAL "�޿�"
    FROM TBL_SAWON
) T;
--==>>
/*
1001	��μ�	    9707251234567	����	26	2005-01-03	2056-01-03	6260	12366	3000	1500
1002	������	    9505152234567	����	28	1999-11-23	2054-11-23	8128	11960	4000	2000
1003	������	    9905192234567	����	24	2006-08-10	2058-08-10	5676	13316	3000	1500
1004	�̿���	    9508162234567	����	28	2007-10-10	2054-10-10	5250	11916	4000	2000
1005	���̻�	    9805161234567	����	25	2007-10-10	2057-10-10	5250	13012	4000	2000
1006	������	    8005132234567	����	43	1999-10-10	2039-10-10	8172	 6437	1000	 500
1007	������     	0204053234567	����	21	2010-10-10	2061-10-10	4154	14473	1000	 500
1008	������	    6803171234567	����	55	1998-10-10	2027-10-10	8537	 2054	1500	 750
1009	������	6912232234567	����	54	1998-10-10	2028-10-10	8537	 2420	1300	 650
1010	���켱	    0303044234567	����	20	2010-10-10	2062-10-10	4154	14838	1600	 800
1011	������	    0506073234567	����	18	2012-10-10	2064-10-10	3423	15569	2600	1300
1012	���ù�	    0208073234567	����	21	2012-10-10	2061-10-10	3423	14473	2600	1300
1013	����	    6712121234567	����	56	1998-10-10	2026-10-10	8537	 1689	2200	1100
1014	ȫ����	    0005044234567	����	23	2015-10-10	2059-10-10	2328	13742	5200	2600
1015	�Ӽҹ�	    9711232234567	����	26	2007-10-10	2056-10-10	5250	12647	5500	2750
1016	���̰�	    0603194234567	����	17	2015-01-20	2065-01-20	2591	15671	1500	 750
1017	��ȣ��	    9611121234567	����	27	2022-02-23	2055-02-23	   0	12052	5000	   0
*/


-- ������ ó���� ������ ������� 
-- Ư�� �ٹ��ϼ��� ����� Ȯ���ؾ� �Ѵٰų�...
-- Ư�� ���ʽ� �ݾ��� �޴� ����� Ȯ���ؾ� �� ��찡 �߻��� �� �ִ�.
-- �̿� ���� ���... �ش� �������� �ٽ� �����ؾ� �ϴ� ���ŷο��� ���� �� �ֵ���
-- ��(VIEW)�� ����� ������ �� �� �ִ�.

CREATE TABLE TBL_SAWON;
-- �� ���̺��� �̹� ������ �� ����µ���???? �ϰ� ������
-- �̹� �����Ѵ�...

CREATE OR REPLACE TABLE TBL_SAWON;
-- �̰͵� ������

-- ������ ���ϸ� �������� ����Ǵ� ��, ������ ������ �ƴ϶� �̷� ������ ���� �;�! �ϴ� ��
CREATE OR REPLACE VIEW VIEW_SAWON -- �̹� ������� �ִ��� ����� ��
AS
SELECT T.�����ȣ, T.�����, T.�ֹι�ȣ, T.����, T.���糪��, T.�Ի���
    , TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.���糪��) * 12), 'YYYY') || '-' || TO_CHAR(T.�Ի���, 'MM-DD') "����������"
     , TRUNC(SYSDATE - T.�Ի���) "�ٹ��ϼ�"
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.���糪��) * 12), 'YYYY') || '-' || TO_CHAR(T.�Ի���, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "�����ϼ�"
    , T.�޿�
    , CASE WHEN TRUNC(SYSDATE - T.�Ի���) >= 2000 THEN T.�޿� * 0.5
           WHEN TRUNC(SYSDATE - T.�Ի���) >= 1000 THEN T.�޿� * 0.3
           ELSE 0
      END "���ʽ�"
FROM 
(
    SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '����'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '����'
                ELSE '����Ȯ�κҰ�'
           END "����"
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
                ELSE -1 
           END "���糪��"
         , HIREDATE "�Ի���"   
         , SAL "�޿�"
    FROM TBL_SAWON
) T;
--==>> ���� �߻�
--     (ORA-01031: insufficient privileges)

--�� SYS�� ���� CREATE VIEW ������ �ο����� ���� �ٽ� ����
--==>> View VIEW_SAWON��(��) �����Ǿ����ϴ�.

SELECT *
FROM VIEW_SAWON;

SELECT *
FROM VIEW_SAWON
WHERE �ٹ��ϼ� >= 6000;

SELECT *
FROM VIEW_SAWON
WHERE �����ϼ� >= 15000;

SELECT *
FROM VIEW_SAWON
WHERE ���ʽ� >= 2000;


--�� VIEW ���� ���� TBL_SAWON ���̺��� ������ �߰� �Է�
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1018, '�Ž���', '9910312234567', SYSDATE, 5000); 
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

SELECT *
FROM VIEW_SAWON;
--==>>
/*
1001	��μ�	    9707251234567	����	26	2005-01-03	2056-01-03	6260	12366	3000	1500
1002	������	    9505152234567	����	28	1999-11-23	2054-11-23	8128	11960	4000	2000
1003	������	    9905192234567	����	24	2006-08-10	2058-08-10	5676	13316	3000	1500
1004	�̿���	    9508162234567	����	28	2007-10-10	2054-10-10	5250	11916	4000	2000
1005	���̻�	    9805161234567	����	25	2007-10-10	2057-10-10	5250	13012	4000	2000
1006	������	    8005132234567	����	43	1999-10-10	2039-10-10	8172	 6437	1000	 500
1007	������	    0204053234567	����	21	2010-10-10	2061-10-10	4154	14473	1000	 500
1008	������	    6803171234567	����	55	1998-10-10	2027-10-10	8537	 2054	1500	 750
1009	������	6912232234567	����	54	1998-10-10	2028-10-10	8537	 2420	1300	 650
1010	���켱	    0303044234567	����	20	2010-10-10	2062-10-10	4154	14838	1600	 800
1011	������	    0506073234567	����	18	2012-10-10	2064-10-10	3423	15569	2600	1300
1012	���ù�	    0208073234567	����	21	2012-10-10	2061-10-10	3423	14473	2600	1300
1013	����	    6712121234567	����	56	1998-10-10	2026-10-10	8537	 1689	2200	1100
1014	ȫ����	    0005044234567	����	23	2015-10-10	2059-10-10	2328	13742	5200	2600
1015	�Ӽҹ�	    9711232234567	����	26	2007-10-10	2056-10-10	5250	12647	5500	2750
1016	���̰�	    0603194234567	����	17	2015-01-20	2065-01-20	2591	15671	1500	 750
1017	��ȣ��	    9611121234567	����	27	2022-02-23	2055-02-23	   0	12052	5000	   0  �� CHECK~!!!
1018	�Ž���	    9910312234567	����	24	2022-02-23	2058-02-23	   0	13148	5000	   0  �� CHECK~!!!
*/

--------------------------------------------------------------------------------
--�� ���������� Ȱ���Ͽ�
--   TBL_SAWON ���̺��� ������ ���� ��ȸ�� �� �ֵ��� �Ѵ�.
/*
-------------------------------------
����� ���� ���糪�� �޿� ���̺��ʽ�
-------------------------------------

��, ���� ���ʽ��� ���� ���̰� 50�� �̻��̸� �޿��� 70%
    40�� �̻� 50�� �̸��̸� �޿��� 50%
    20�� �̻� 40�� �̸��̸� �޿��� 30% �� �Ѵ�.

����, �ϼ��� ��ȸ ������ ����
VIEW_SAWON2 ��� �̸��� ��(VIEW) �� �����Ѵ�.
*/

-- �� Ǯ��
-- TBL_SAWON ���̺� ��ȸ
SELECT *
FROM TBL_SAWON;

SELECT T.*
     , CASE WHEN T.���糪�� >= 50 THEN T.�޿� * 0.7 
            WHEN T.���糪�� >= 40 THEN T.�޿� * 0.5
            WHEN T.���糪�� >= 20 THEN T.�޿� * 0.3 
            ELSE 0
       END "���̺��ʽ�"
FROM 
(
    SELECT SANAME "�����" 
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '����'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '����'
                ELSE '����Ȯ�κҰ�'
           END "����" 
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
                ELSE -1 
           END "���糪��" 
         , SAL "�޿�" 
    FROM TBL_SAWON -- ���� �����ݷ� ���� ��������!!!!!
) T;
--==>>
/*
��μ�	    ����	26	3000	 900
������	    ����	28	4000	1200
������	    ����	24	3000	 900
�̿���	    ����	28	4000	1200
���̻�	    ����	25	4000	1200
������	    ����	43	1000	 500
������	    ����	21	1000	 300
������	    ����	55	1500	1050
������	����	54	1300	 910
���켱	    ����	20	1600	 480
������	    ����	18	2600	   0
���ù�	    ����	21	2600	 780
����	    ����	56	2200	1540
ȫ����	    ����	23	5200	1560
�Ӽҹ�	    ����	26	5500	1650
���̰�	    ����	17	1500	   0
��ȣ��	    ����	27	5000	1500
�Ž���	    ����	24	5000	1500
*/

-- VIEW_SAWON2 �� ����
CREATE OR REPLACE VIEW VIEW_SAWON2 
AS
SELECT T.*
     , CASE WHEN T.���糪�� >= 50 THEN T.�޿� * 0.7 
            WHEN T.���糪�� >= 40 THEN T.�޿� * 0.5
            WHEN T.���糪�� >= 20 THEN T.�޿� * 0.3 
            ELSE 0
       END "���̺��ʽ�"
FROM 
(
    SELECT SANAME "�����" 
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '����'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '����'
                ELSE '����Ȯ�κҰ�'
           END "����" 
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
                ELSE -1 
           END "���糪��" 
         , SAL "�޿�" 
    FROM TBL_SAWON -- ���� �����ݷ� ���� ��������!!!!!
) T;
--==>> View VIEW_SAWON2��(��) �����Ǿ����ϴ�.

--�� ������ ��(VIEW) Ȯ��(��ȸ)
SELECT *
FROM VIEW_SAWON2;

--------------------------------------------------------------------------------

--�� RANK() �� ���(����)�� ��ȯ�ϴ� �Լ� -- �м� �Լ� / �Ķ���� ���� OVER()�ȿ�
SELECT EMPNO "�����ȣ", ENAME "�����", DEPTNO "�μ���ȣ", SAL "�޿�"
     , RANK() OVER(ORDER BY SAL DESC) "��ü�޿�����"
FROM EMP;
--==>>
/*
7839	KING	10	5000	 1
7902	FORD	20	3000	 2
7788	SCOTT	20	3000	 2
7566	JONES	20	2975	 4
7698	BLAKE	30	2850	 5
7782	CLARK	10	2450	 6
7499	ALLEN	30	1600	 7
7844	TURNER	30	1500	 8
7934	MILLER	10	1300	 9
7521	WARD	30	1250	10
7654	MARTIN	30	1250	10
7876	ADAMS	20	1100	12
7900	JAMES	30	 950	13
7369	SMITH	20	 800	14
*/

SELECT EMPNO "�����ȣ", ENAME "�����", DEPTNO "�μ���ȣ", SAL "�޿�"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "�μ����޿�����" --��Ƽ�� -> ������ ��, ���� --> ������ �����ϰڴ�
     , RANK() OVER(ORDER BY SAL DESC) "��ü�޿�����"
FROM EMP;
--==>>
/*
7839	KING	10	5000	1	 1
7902	FORD	20	3000	1	 2
7788	SCOTT	20	3000	1	 2
7566	JONES	20	2975	3	 4
7698	BLAKE	30	2850	1	 5
7782	CLARK	10	2450	2	 6
7499	ALLEN	30	1600	2	 7
7844	TURNER	30	1500	3	 8
7934	MILLER	10	1300	3	 9
7521	WARD	30	1250	4	10
7654	MARTIN	30	1250	4	10
7876	ADAMS	20	1100	4	12
7900	JAMES	30	 950	6	13
7369	SMITH	20	 800	5	14
*/

SELECT EMPNO "�����ȣ", ENAME "�����", DEPTNO "�μ���ȣ", SAL "�޿�"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "�μ����޿�����" --��Ƽ�� -> ������ ��, ���� --> ������ �����ϰڴ�
     , RANK() OVER(ORDER BY SAL DESC) "��ü�޿�����"
FROM EMP
ORDER BY DEPTNO;
--==>>
/*
7839	KING	10	5000	1	 1
7782	CLARK	10	2450	2	 6
7934	MILLER	10	1300	3	 9
7902	FORD	20	3000	1	 2
7788	SCOTT	20	3000	1	 2
7566	JONES	20	2975	3	 4
7876	ADAMS	20	1100	4	12
7369	SMITH	20	 800 	5	14
7698	BLAKE	30	2850	1	 5
7499	ALLEN	30	1600	2	 7
7844	TURNER	30	1500	3	 8
7654	MARTIN	30	1250	4	10
7521	WARD	30	1250	4	10
7900	JAMES	30	 950    6	13
*/

--�� DENSE_RANK() �� ������ ��ȯ�ϴ� �Լ� -- ������ ���� 1���� �ִµ� ��� �׳� ������� ...
SELECT EMPNO "�����ȣ", ENAME "�����", DEPTNO "�μ���ȣ", SAL "�޿�"
     , DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "�μ����޿�����" 
     , DENSE_RANK() OVER(ORDER BY SAL DESC) "��ü�޿�����"
FROM EMP
ORDER BY DEPTNO;
--==>>
/*
7839	KING	10	5000	1	 1
7782	CLARK	10	2450	2	 5
7934	MILLER	10	1300	3	 8
7902	FORD	20	3000	1	 2
7788	SCOTT	20	3000	1	 2
7566	JONES	20	2975	2	 3
7876	ADAMS	20	1100	3	10
7369	SMITH	20	 800	4	12
7698	BLAKE	30	2850	1	 4
7499	ALLEN	30	1600	2	 6
7844	TURNER	30	1500	3	 7
7654	MARTIN	30	1250	4	 9
7521	WARD	30	1250	4	 9
7900	JAMES	30	 950	5	11
*/

--�� EMP ���̺��� ��� �����͸�
--   �����, �μ���ȣ, ����, �μ�����������, ��ü�������� �׸����� ��ȸ�Ѵ�.
SELECT *
FROM TBL_EMP;

SELECT T.*, RANK() OVER(PARTITION BY T.�μ���ȣ ORDER BY T.���� DESC) "�μ�����������"
          , RANK() OVER(ORDER BY T.���� DESC) "��ü��������"
FROM
(
    SELECT ENAME "�����", DEPTNO "�μ���ȣ", COALESCE(SAL*12+COMM, SAL*12, COMM, 0) "����"
    FROM TBL_EMP
    ORDER BY DEPTNO
) T;

-- ���� Ǯ��
SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM, 0) "����"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY (SAL*12+NVL(COMM, 0)) DESC) "�μ�����������"
     , RANK() OVER(ORDER BY (SAL*12+NVL(COMM, 0)) DESC) "��ü��������"
FROM EMP;

SELECT T.*
     , RANK() OVER(PARTITION BY T.�μ���ȣ ORDER BY T.����) "�μ�����������"
     , RANK() OVER(ORDER BY T.���� DESC) "��ü��������"
FROM
(
    SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM, 0) "����"
    FROM EMP
) T;
--==>>
/*
KING	10	60000	3	 1
SCOTT	20	36000	4	 2
FORD	20	36000	4	 2
JONES	20	35700	3	 4
BLAKE	30	34200	6	 5
CLARK	10	29400	2	 6
ALLEN	30	19500	5	 7
TURNER	30	18000	4	 8
MARTIN	30	16400	3	 9
MILLER	10	15600	1	10
WARD	30	15500	2	11
ADAMS	20	13200	2	12
JAMES	30	11400	1	13
SMITH	20	9600	1	14
*/


--�� EMP ���̺����� ��ü ���� ���(����)�� 1����� 5�������...
--   �����, �μ���ȣ, ����, ��ü�������� �׸����� ��ȸ�Ѵ�.
SELECT T.*
FROM
(
    SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM, 0) "����"
         , RANK() OVER(ORDER BY (SAL*12+NVL(COMM, 0)) DESC) "��ü��������"
    FROM EMP
) T
WHERE T.��ü�������� >= 1 AND T.��ü�������� <= 5
ORDER BY T.��ü��������;

-- ���� Ǯ��--------------------------------------------------------------------
SELECT �����, �μ���ȣ, ����, ��ü��������
FROM EMP
WHERE ��ü ���� ���(����)�� 1����� 5��;

SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM, 0) "����"
     , RANK() OVER(ORDER BY (����) DESC) "��ü��������"
FROM EMP
WHERE ��ü ���� ���(����)�� 1����� 5��;

SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM, 0) "����"
     , RANK() OVER(ORDER BY (SAL*12+NVL(COMM, 0)) DESC) "��ü��������"
FROM EMP
WHERE RANK() OVER(ORDER BY (SAL*12+NVL(COMM, 0)) DESC) <= 5;
--==> ���� �߻�
--    (ORA-30483: window  functions are not allowed here)
-- �� �ָ��ؾ� �� ���� 
-- ������ �Լ��� ���⼭ ����� �� ����! --> ������ �Լ� -> �м� �Լ�!!!
-- �м��Լ��� WHERE ������ �� ��

--�� ���� ������ RANK() OVER() �� ���� �м� �Լ��� WHERE ������ ����� ����̸�...
--   �� �Լ��� WHERE ���������� ����� �� ���� ������ �߻��ϴ� �����̴�.
--   �� ���, �츮�� INLINE VIEW�� Ȱ���ؼ� Ǯ���ؾ� �Ѵ�.
SELECT T.*
FROM
(
    SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM, 0) "����"
         , RANK() OVER(ORDER BY (SAL*12+NVL(COMM, 0)) DESC) "��ü��������"
    FROM EMP
) T
WHERE T.��ü�������� <= 5;
--==>>
/*
KING	10	60000	1
SCOTT	20	36000	2
FORD	20	36000	2
JONES	20	35700	4
BLAKE	30	34200	5
*/

--�� EMP ���̺����� �� �μ����� ��������� 1����� 2������� ��ȸ�Ѵ�.
--   �����, �μ���ȣ, ����, �μ����������, ��ü������� 
--   �׸��� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
SELECT *
FROM EMP;

SELECT �����, �μ���ȣ, ����, �μ����������, ��ü�������
FROM EMP
WHERE �μ����� ��������� 1����� 2��;

SELECT T.*
FROM
(
    SELECT ENAME "�����", DEPTNO "�μ���ȣ", (SAL*12+NVL(COMM, 0)) "����"
         , RANK() OVER(PARTITION BY DEPTNO ORDER BY (SAL*12+NVL(COMM, 0)) DESC) "�μ����������"
         , RANK() OVER(ORDER BY (SAL*12+NVL(COMM, 0)) DESC) "��ü�������" 
    FROM EMP
) T
WHERE T.�μ���������� <= 2
ORDER BY T.�μ���ȣ;
--==>>
/*
KING	10	60000	1	1
CLARK	10	29400	2	6
FORD	20	36000	1	2
SCOTT	20	36000	1	2
BLAKE	30	34200	1	5
ALLEN	30	19500	2	7
*/

SELECT T.*
FROM
(
    SELECT ENAME "�����", DEPTNO "�μ���ȣ", (SAL*12+NVL(COMM, 0)) "����"
         , DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY (SAL*12+NVL(COMM, 0)) DESC) "�μ����������"
         , DENSE_RANK() OVER(ORDER BY (SAL*12+NVL(COMM, 0)) DESC) "��ü�������" 
    FROM EMP
) T
WHERE T.�μ���������� <= 2
ORDER BY T.�μ���ȣ;
--==>>
/*
KING	10	60000	1	1
CLARK	10	29400	2	5
FORD	20	36000	1	2
SCOTT	20	36000	1	2
JONES	20	35700	2	3
BLAKE	30	34200	1	4
ALLEN	30	19500	2	6
*/

--------------------------------------------------------------------------------

--���� �׷� �Լ� ����--

-- SUM() ��, AVG() ���, COUNT() ī��Ʈ, MAX() �ִ밪, MIN() �ּڰ�
-- , VERIENCE() �л�, STDDEV() ǥ������

--�� �׷� �Լ��� ���� ū Ư¡
--   ó���ؾ� �� �����͵� �� NULL �� �����Ѵٸ�(���ԵǾ� �ִٸ�)
--   �� NULL �� ������ ���·� ������ �����Ѵٴ� ���̴�.
--   ��, �׷� �Լ��� �۵��ϴ� �������� NULL �� ������ ��󿡼� ���ܵȴ�.

--�� SUM() ��
-- EMP ���̺��� ������� ��ü ������� �޿� ������ ��ȸ�Ѵ�.
SELECT SAL
FROM EMP;
--==>>
/*
800
1600
1250
2975
1250
2850
2450
3000
5000
1500
1100
950
3000
1300
*/

SELECT SUM(SAL)
FROM EMP;
--==>> 29025

SELECT ENAME, SUM(SAL)
FROM EMP;
--==>> ���� �߻�
--     (ORA-00937: not a single-group group function)

SELECT SUM(SAL) -- 800 + 1600 + 1250 + ... + 1300
FROM EMP;
--==>> 29025

SELECT COMM
FROM EMP;
--==>>
/*
(null)
300
500
(null)
1400
(null)
(null)
(null)
(null)
0
(null)
(null)
(null)
(null)
*/

SELECT SUM(COMM)   -- (null) + 300 + 500 + ... + (null)
FROM EMP;
--==>> 2200


--�� COUNT() ��(���ڵ�)�� ���� ��ȸ �� �����Ͱ� �� ������ Ȯ��...
SELECT COUNT(ENAME)
FROM EMP;
--==>> 14

SELECT COUNT(COMM) -- COMM �÷� ���� ���� ��ȸ �� NULL�� ����~!!!
FROM EMP;
--==>> 4

SELECT COUNT(*)
FROM EMP;
--==>> 14
-- �Ϲ������δ� ���� ������ ���� �Ǳ� ������ ���� �̷��� ���


--�� AVG() ��� ��ȯ
SELECT SUM(SAL) / COUNT(SAL) "RESULT1" -- 2073.214285714285714285714285714285714286
     , AVG(SAL) "RESULT2"              -- 2073.214285714285714285714285714285714286
FROM EMP;

SELECT SUM(COMM) / COUNT(COMM) "RESULT1" -- 550
     , AVG(COMM) "RESULT2"               -- 550  
FROM EMP;
-- ����� �� �� �ƴ� ���� 14�� ��������

SELECT SUM(COMM) / COUNT(*) "RESULT"
FROM EMP;
--==>> 157.142857142857142857142857142857142857

--�� �����Ͱ� NULL�� �÷��� ���ڵ�� ���� ��󿡼� ���ܵǱ� ������
--   �����Ͽ� ���� ó���ؾ� �Ѵ�.


--�� VARIANCE(), STDDEV() 
--   �� ǥ�������� ������ �л�, �л��� �������� ǥ������

SELECT VARIANCE(SAL), STDDEV(SAL)
FROM EMP;
--==>> 1398313.87362637362637362637362637362637 	
--     1182.503223516271699458653359613061928508

SELECT POWER(STDDEV(SAL), 2) "RESULT1"
     , VARIANCE(SAL) "RESULT2"
FROM EMP;
--==>> 1398313.87362637362637362637362637362637	    
--     1398313.87362637362637362637362637362637

SELECT SQRT(VARIANCE(SAL)) "RESULT1"
     , STDDEV(SAL) "RESULT2"
FROM EMP;
--==>> 1182.503223516271699458653359613061928508	
--     1182.503223516271699458653359613061928508

--�� MAX() / MIN()
--  �ִ밪 / �ּҰ�
SELECT MAX(SAL) "RESULT1"
     , MIN(SAL) "RESULT2"
FROM EMP;
--==>> 5000	800

--�� ����
SELECT ENAME, SUM(SAL)
FROM EMP;
--==>> ���� �߻�
--     (ORA-00937: not a single-group group function)

SELECT DEPTNO, SUM(SAL)
FROM EMP;
--==>> ���� �߻�
--     (ORA-00937: not a single-group group function)

SELECT DEPTNO, SUM(SAL) -- ���� �ſ��� �갡 ����ż� ���� �� ��
FROM EMP
GROUP BY DEPTNO; -- ����ó���� ���� ����
--==>>
/*
30	9400
20	10875
10	8750
*/

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