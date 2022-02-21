SELECT USER
FROM DUAL;
--==>> SCOTT


--�� BETWEEN �� AND �� �� ��¥��, ������, ������ ������ ��ο� ����ȴ�.
--   ��, �������� ��� �ƽ�Ű�ڵ� ������ ������ ������ (������ �迭)
--   �빮�ڰ� ���ʿ� ��ġ�ϰ� �ҹ��ڰ� ���ʿ� ��ġ�Ѵ�.
--   ����, BETWEEN �� AND �δ� �ش� ������ ����Ǵ� ��������
--   ����Ŭ ���������δ� �ε�ȣ �������� ���·� �ٲ�� ���� ó���ȴ�.

SELECT ASCII('A') "COL1", ASCII('B') "COL2", ASCII('a') "COL3", ASCII('b') "COL4"
FROM DUAL;
--==>> 65	66	97	98


SELECT ENAME, JOB, SAL
FROM TBL_EMP
WHERE JOB = 'SALESMAN'
   OR JOB = 'CLERK';
--==>>
/*
SMITH	CLERK	     800
ALLEN	SALESMAN	1600
WARD	SALESMAN	1250
MARTIN	SALESMAN	1250
TURNER	SALESMAN	1500
ADAMS	CLERK	    1100
JAMES	CLERK	     950
MILLER	CLERK   	1300
ȣ����	SALESMAN	(null)
������	SALESMAN	(null)
*/
   
SELECT ENAME, JOB, SAL
FROM TBL_EMP
WHERE JOB IN('SALESMAN', 'CLERK'); -- �굵 ���������δ� ���� ���� �����
--==>>
/*
SMITH	CLERK	     800
ALLEN	SALESMAN	1600
WARD	SALESMAN	1250
MARTIN	SALESMAN	1250
TURNER	SALESMAN	1500
ADAMS	CLERK	    1100
JAMES	CLERK	     950
MILLER	CLERK   	1300
ȣ����	SALESMAN	(null)
������	SALESMAN	(null)
*/

SELECT ENAME, JOB, SAL
FROM TBL_EMP
WHERE JOB = ANY ('SALESMAN', 'CLERK'); -- ���������δ� OR������ ���·� �ٲ�� ó����
--==>>
/*
SMITH	CLERK	     800
ALLEN	SALESMAN	1600
WARD	SALESMAN	1250
MARTIN	SALESMAN	1250
TURNER	SALESMAN	1500
ADAMS	CLERK	    1100
JAMES	CLERK	     950
MILLER	CLERK   	1300
ȣ����	SALESMAN	(null)
������	SALESMAN	(null)
*/


--�� ���� 3���� ������ �������� ��� ���� ����� ��ȯ�Ѵ�.
--   ������, �� ���� ������(OR) �� ���� ������ ó���ȴ�.
--   ���� �޸𸮿� ���� ������ �ƴ϶� CPU ó���� ���� �����̹Ƿ�
--   �� �κб��� �����Ͽ� �������� �����ϰ� �Ǵ� ���� ���� �ʴ�.
--   �� ��IN�� �� ��=ANY���� ���� ������ ȿ���� ������.
--      �̵� ��δ� ���������� ��OR�� ������ ����Ǿ� ���� ó���ȴ�.

--------------------------------------------------------------------------------

--�� �߰� �ǽ� ���̺� ����(TBL_SAWON)
CREATE TABLE TBL_SAWON
( SANO      NUMBER(4)
, SANAME    VARCHAR2(30)
, JUBUN     CHAR(13)
, HIREDATE  DATE        DEFAULT SYSDATE
, SAL       NUMBER(10)
);
--==>> Table TBL_SAWON��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_SAWON;
--==>> ��ȸ ��� ����

DESC TBL_SAWON;
--==>>
/*
�̸�       ��? ����           
-------- -- ------------ 
SANO        NUMBER(4)    
SANAME      VARCHAR2(30) 
JUBUN       CHAR(13)     
HIREDATE    DATE         
SAL         NUMBER(10)
*/

--�� ������ ���̺� ������ �Է�(TBL_SAWON)
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1001, '��μ�', '9707251234567', TO_DATE('2005-01-03', 'YYYY-MM-DD'), 3000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1002, '������', '9505152234567', TO_DATE('1999-11-23', 'YYYY-MM-DD'), 4000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1003, '������', '9905192234567', TO_DATE('2006-08-10', 'YYYY-MM-DD'), 3000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1004, '�̿���', '9508162234567', TO_DATE('2007-10-10', 'YYYY-MM-DD'), 4000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1005, '���̻�', '9805161234567', TO_DATE('2007-10-10', 'YYYY-MM-DD'), 4000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1006, '������', '8005132234567', TO_DATE('1999-10-10', 'YYYY-MM-DD'), 1000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1007, '������', '0204053234567', TO_DATE('2010-10-10', 'YYYY-MM-DD'), 1000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1008, '������', '6803171234567', TO_DATE('1998-10-10', 'YYYY-MM-DD'), 1500);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1009, '������', '6912232234567', TO_DATE('1998-10-10', 'YYYY-MM-DD'), 1300);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1010, '���켱', '0303044234567', TO_DATE('2010-10-10', 'YYYY-MM-DD'), 1600);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1011, '������', '0506073234567', TO_DATE('2012-10-10', 'YYYY-MM-DD'), 2600);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1012, '���ù�', '0208073234567', TO_DATE('2012-10-10', 'YYYY-MM-DD'), 2600);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1013, '����', '6712121234567', TO_DATE('1998-10-10', 'YYYY-MM-DD'), 2200);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1014, 'ȫ����', '0005044234567', TO_DATE('2015-10-10', 'YYYY-MM-DD'), 5200);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1015, '�Ӽҹ�', '9711232234567', TO_DATE('2007-10-10', 'YYYY-MM-DD'), 5500);

--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 15

--�� Ȯ��
SELECT *
FROM TBL_SAWON;
--==>>
/*
1001	��μ�     	9707251234567	2005-01-03	3000
1002	������	    9505152234567	1999-11-23	4000
1003	������	    9905192234567	2006-08-10	3000
1004	�̿���	    9508162234567	2007-10-10	4000
1005	���̻�	    9805161234567	2007-10-10	4000
1006	������	    8005132234567	1999-10-10	1000
1007	������	    0204053234567	2010-10-10	1000
1008	������	    6803171234567	1998-10-10	1500
1009	������	6912232234567	1998-10-10	1300
1010	���켱	    0303044234567	2010-10-10	1600
1011	������	    0506073234567	2012-10-10	2600
1012	���ù�	    0208073234567	2012-10-10	2600
1013	����	    6712121234567	1998-10-10	2200
1014	ȫ����	    0005044234567	2015-10-10	5200
1015	�Ӽҹ�	    9711232234567	2007-10-10	5500
*/

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

--�� TBL_SAWON ���̺��� '������' ����� �����͸� ��ȸ�Ѵ�.
SELECT *
FROM TBL_SAWON
WHERE SANAME = '������';
--==>> 1003	������	9905192234567	2006-08-10	3000

SELECT *
FROM TBL_SAWON
WHERE SANAME LIKE '������'; -- ~�� ����, ~ó�� LIKE
--==>> 1003	������	9905192234567	2006-08-10	3000

--�� LIKE : ���� �� �����ϴ�
--          �λ� �� ~�� ����, ~ó��    CHECK~!!!

--�� WHILD CARD(CHARACTER) �� ��%��
--   ��LIKE���� �Բ� ���Ǵ� ��%���� ��� ���ڸ� �ǹ��ϰ�
--   ��LIKE���� �Բ� ���Ǵ� ��_���� �ƹ� ���� �� ���� �ǹ��Ѵ�.

--�� TBL_SAWON ���̺��� ������ ���衻���� �����
--   �����, �ֹι�ȣ, �޿� �׸��� ��ȸ�Ѵ�.
SELECT *
FROM TBL_SAWON
WHERE SANAME = '��';
--==>> ��ȸ ��� ����

SELECT *
FROM TBL_SAWON
WHERE SANAME LIKE '��__'; -- ����� ������ �� ����ũ�� ���� ����
--==>> 1001	��μ�	9707251234567	2005-01-03	3000

SELECT *
FROM TBL_SAWON
WHERE SANAME LIKE '��%'; -- �ۼ�Ʈ ������ �� ����ũ�� ���� ����
--==>> 1001	��μ�	9707251234567	2005-01-03	3000


--�� TBL_SAWON ���̺��� ������ ���̡����� �����
--   �����, �ֹι�ȣ, �޿� �׸��� ��ȸ�Ѵ�.
SELECT *
FROM TBL_SAWON
WHERE SANAME LIKE '��__';
-- WHERE SANAME LIKE '��%';
--==>>
/*
1003	������	9905192234567	2006-08-10	3000
1004	�̿���	9508162234567	2007-10-10	4000
1006	������	8005132234567	1999-10-10	1000
*/

--�� TBL_SAWON ���̺��� �̸��� ������ ���ڰ� ���Ρ��� �����
--   �����, �ֹι�ȣ, �޿� �׸��� ��ȸ�Ѵ�.
SELECT SANAME "�����", JUBUN "�ֹι�ȣ", SAL "�޿�"
FROM TBL_SAWON
WHERE SANAME LIKE '%��';
--==>>
/*
���ù�	0208073234567	2600
ȫ����	0005044234567	5200
�Ӽҹ�	9711232234567	5500
*/

SELECT SANAME "�����", JUBUN "�ֹι�ȣ", SAL "�޿�"
FROM TBL_SAWON
WHERE SANAME LIKE '__��';
--==>>
/*
���ù�	0208073234567	2600
ȫ����	0005044234567	5200
�Ӽҹ�	9711232234567	5500
*/

--�� �߰� ������ �Է�(TBL_SAWON)
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1016, '���̰�', '0603194234567', TO_DATE('2015-01-20', 'YYYY-MM-DD'), 1500);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_SAWON;
--==>>
/*
1001	��μ�	    9707251234567	2005-01-03	3000
1002	������	    9505152234567	1999-11-23	4000
1003	������	    9905192234567	2006-08-10	3000
1004	�̿���	    9508162234567	2007-10-10	4000
1005	���̻�	    9805161234567	2007-10-10	4000
1006	������	    8005132234567	1999-10-10	1000
1007	������	    0204053234567	2010-10-10	1000
1008	������	    6803171234567	1998-10-10	1500
1009	������	6912232234567	1998-10-10	1300
1010	���켱	    0303044234567	2010-10-10	1600
1011	������	    0506073234567	2012-10-10	2600
1012	���ù�	    0208073234567	2012-10-10	2600
1013	����	    6712121234567	1998-10-10	2200
1014	ȫ����	    0005044234567	2015-10-10	5200
1015	�Ӽҹ�	    9711232234567	2007-10-10	5500
1016	���̰�	    0603194234567	2015-01-20	1500
*/

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

--�� TBL_SAWON ���̺��� ����� �̸��� ���̡���� ���ڰ�
--   �ϳ��� ���ԵǾ� �ִٸ� �� �����
--   �����ȣ, �����, �޿� �׸��� ��ȸ�Ѵ�.
SELECT SANO "�����ȣ", SANAME "�����", SAL "�޿�"
FROM TBL_SAWON
WHERE SANAME LIKE '%��%'; -- ���� �͵� �ۼ�Ʈ �ȿ� ���ԵǴ±�
--==>>
/*
1003	������	3000
1004	�̿���	4000
1005	���̻�	4000
1006	������	1000
1007	������	1000
1016	���̰�	1500
*/

--�� TBL_SAWON ���̺��� ����� �̸��� ���̡���� ���ڰ�
--   �������� �� �� ����ִ� �����
--   �����ȣ, �����, �޿� �׸��� ��ȸ�Ѵ�.
SELECT SANO "�����ȣ", SANAME "�����", SAL "�޿�"
FROM TBL_SAWON
WHERE SANAME LIKE '%����%';
--==>>1016	���̰�	1500


--�� TBL_SAWON ���̺��� ����� �̸��� ���̡���� ���ڰ� �� �� ����ִ� �����
--   �����ȣ, �����, �޿� �׸��� ��ȸ�Ѵ�.
SELECT SANO "�����ȣ", SANAME "�����", SAL "�޿�"
FROM TBL_SAWON
WHERE SANAME LIKE '%��%��%';
--==>>
/*
1006	������	1000
1016	���̰�	1500
*/

--�� TBL_SAWON ���̺��� ��� �̸��� �� ��° ���ڰ� ���̡��� �����
--   �����ȣ, �����, �޿� �׸��� ��ȸ�Ѵ�.
SELECT SANO "�����ȣ", SANAME "�����", SAL "�޿�"
FROM TBL_SAWON
WHERE SANAME LIKE '_��%';
--==>>
/*
1005	���̻�	4000
1016	���̰�	1500
*/


--�� TBL_SAWON ���̺��� ����� ������ ���������� �����
--   �����, �ֹι�ȣ, �޿� �׸��� ��ȸ�Ѵ�.
--   �� �Ұ�!!!!!!
SELECT SANAME "�����", JUBUN "�ֹι�ȣ", SAL "�޿�"
FROM TBL_SAWON
WHERE SANAME LIKE '��%';

SELECT SANAME "�����", JUBUN "�ֹι�ȣ", SAL "�޿�"
FROM TBL_SAWON
WHERE SANAME LIKE '��%';
--==>> ������ ��������, ������ �𸣰� / �������� ������ ��...

--�� �����ͺ��̽� ���� ��������
--   ���� �̸��� �и��Ͽ� ó���ؾ� �� ���� ��ȹ�� �ִٸ�
--   (���� ������ �ƴϴ���...)
--   ���̺��� �� �÷��� �̸� �÷��� �и��Ͽ� �����ؾ� �Ѵ�.


--�� TBL_SAWON ���̺��� ����������
--   �����, �ֹι�ȣ, �޿� �׸��� ��ȸ�Ѵ�.
DESC TBL_SAWON;
--==>>
/*
�̸�       ��? ����           
-------- -- ------------ 
SANO        NUMBER(4)    
SANAME      VARCHAR2(30) 
JUBUN       CHAR(13)     
HIREDATE    DATE         
SAL         NUMBER(10)
*/

SELECT SANAME "�����", JUBUN "�ֹι�ȣ", SAL "�޿�"
FROM TBL_SAWON
WHERE JUBUN LIKE '______2______' OR JUBUN LIKE '______4______';
--==>>
/*
������	    9505152234567	4000
������	    9905192234567	3000
�̿���	    9508162234567	4000
������     	8005132234567	1000
������	6912232234567	1300
���켱     	0303044234567	1600
ȫ����	    0005044234567	5200
�Ӽҹ�	    9711232234567	5500
���̰�	    0603194234567	1500
*/


--�� ���̺� ����(TBL_WATCH)
CREATE TABLE TBL_WATCH
( WATCH_NAME    VARCHAR2(20)
, BIGO          VARCHAR2(100)
);
--==>> Table TBL_WATCH��(��) �����Ǿ����ϴ�.

--�� ������ �Է�(TBL_WATCH)
INSERT INTO TBL_WATCH(WATCH_NAME, BIGO)
VALUES('�ݽð�', '���� 99.99% ������ �ְ�� �ð�');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_WATCH(WATCH_NAME, BIGO)
VALUES('���ð�', '�� ������ 99.99���� ȹ���� ���� �ð�');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_WATCH;
--==>>
/*
�ݽð�	���� 99.99% ������ �ְ�� �ð�
���ð�	�� ������ 99.99���� ȹ���� ���� �ð�
*/

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� TBL_WATCH ���̺��� BIGO(���) �÷���
--   ��99.99%����� ���ڰ� ���Ե�(����ִ�) ��(���ڵ�)��
--   �����͸� ��ȸ�Ѵ�.
SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '99.99%';
--==>> ��ȸ ��� ����

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99%%';
--==>>
/*
�ݽð�	���� 99.99% ������ �ְ�� �ð�
���ð�	�� ������ 99.99���� ȹ���� ���� �ð�
*/

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99%%%';
--==>>
/*
�ݽð�	���� 99.99% ������ �ְ�� �ð�
���ð�	�� ������ 99.99���� ȹ���� ���� �ð�
*/

-------��ESCAPE ����

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99\%%' ESCAPE '\';
--==>> �ݽð�	���� 99.99% ������ �ְ�� �ð�

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99$%%' ESCAPE '$';
--==>> �ݽð�	���� 99.99% ������ �ְ�� �ð�

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99@%%' ESCAPE '@';
--==>> �ݽð�	���� 99.99% ������ �ְ�� �ð�

--�� ESCAPE�� ���� ������ ���� �� ���ڸ� ���ϵ�ī�忡�� Ż����Ѷ�...
--   �Ϲ������� ��� �󵵰� ���� Ư������(Ư����ȣ)�� ����Ѵ�.

--------------------------------------------------------------------------------

--���� COMMIT / ROLLBACK ����--

SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*/

--�� ������ �Է�
INSERT INTO TBL_DEPT VALUES(50, '���ߺ�', '����');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES   	CHICAGO
40	OPERATIONS	BOSTON
50	���ߺ�     	����
*/

-- 50�� ���ߺ� ����...
-- �� �����ʹ� TBL_DEPT ���̺��� ����Ǿ� �ִ�
-- �ϵ��ũ�� ���������� ����Ǿ� ����� ���� �ƴϴ�.
-- �޸�(RAM)�� �Էµ� ���̴�.

--�� �ѹ�
ROLLBACK; --CTRL+Z ó��... �޸𸮿� �ִ� ���� ��� �������
--==>> �ѹ� �Ϸ�.

--�� �ٽ� Ȯ��
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*/
--> 50�� ���ߺ� ����... �� ���� �����Ͱ� �ҽǵǾ����� Ȯ��(�������� ����)

--�� �ٽ� ������ �Է�
INSERT INTO TBL_DEPT VALUES(50, '���ߺ�', '����');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

-- 50�� ���ߺ� ����...
-- �� �����ʹ� TBL_DEPT ���̺��� ����Ǿ� �ִ� �ϵ��ũ�� ����� ���� �ƴ϶�
-- �޸�(RAM) �� �Էµ� ���̴�.
-- �̸� ���� �ϵ��ũ�� ���������� �����ϱ� ���ؼ���
-- COMMIT�� �����ؾ� �Ѵ�.

--�� Ȯ��
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	���ߺ�	    ����
*/

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

--�� Ŀ�� ���� �ٽ� Ȯ��
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	���ߺ�	    ����
*/

--�� Ŀ���� ������ ���� �ѹ�
ROLLBACK;
--==>> �ѹ� �Ϸ�.

--�� �ѹ� ���� �ٽ� Ȯ��
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	���ߺ�	    ����
*/
--> �ѹ�(ROLLBACK)�� ������������ �ұ��ϰ�
--  50�� ���ߺ� ����... �� �� �����ʹ� �ҽǵ��� �ʾ����� Ȯ��

--�� COMMIT �� ������ ���ķ� DML ����(INSERT, UPDATE, DELETE)�� ����
--   ����� �����͸� ����� �� �ִ� ���� ��...
--   DML ������ ����� �� COMMIT �� �ϰ� ���� ROLLBACK�� ������ ����
--   �ƹ��� �ҿ��� ����.


--�� ������ ����(UPDATE �� TBL_DEPT)
UPDATE TBL_DEPT
SET DNAME='������', LOC='���'
WHERE DEPTNO = 50; -- ����� ����
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS 	BOSTON
50	������	    ���
*/

--�� �ѹ�
ROLLBACK;
--==>> �ѹ� �Ϸ�.

--�� �ѹ� ���� �� �ٽ� Ȯ��
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	CHICAGO
40	OPERATIONS	BOSTON
50	���ߺ�	����
*/

--�� ������ ����(DELETE �� TBL_DEPT)
DELETE TBL_DEPT
WHERE DEPTNO=50;  -- �̷��� ����

SELECT * -- ���� ������ ������ ��ȸ ��, ��ȸ ���� Ȯ�� �� �� ����Ʈ�� �ٲٱ�
FROM TBL_DEPT 
WHERE DEPTNO=50;

DELETE  -- �̷��� ����!
FROM TBL_DEPT  -- FROM �� �����ϸ� ����!
WHERE DEPTNO=50;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*/

--�� �ѹ�
ROLLBACK;
--==>> �ѹ� �Ϸ�.

--�� �ѹ� ���� �ٽ� Ȯ��
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	���ߺ�	    ����
*/