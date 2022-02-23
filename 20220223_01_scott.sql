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

--�� TBL_SAWON ���̺� ������ �߰� �Է�
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

CREATE TABLE TBL_SAWON
-- �� ���̺��� �̹� ������ �� ����µ���???? �ϰ� ������
-- �̹� �����Ѵ�...

CREATE OR REPLACE TABLE TBL_SAWON
-- �̰͵� ������

-- ������ ���ϸ� �������� ����Ǵ� ��, ������ ������ �ƴ϶� �̷� ������ ���� �;�! �ϴ� ��
CREATE OR REPLACE VIEW VIEW_SAWON -- �̹� ������� �ִ��� ����� ��










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








-- �� Ǯ�� ---------------------------------------------------------------------
-- �����ϼ� �����ؾ� ��!!!
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

