SELECT USER
FROM DUAL;
--==>> SCOTT

--���� FUNCTION(�Լ�) ����--

-- 1. �Լ��� �ϳ� �̻��� PL/SQL ������ ������ �����ƾ����
--    �ڵ带 �ٽ� ����� �� �ֵ��� ĸ��ȭ �ϴ� �� ���ȴ�.
--    ����Ŭ������ ����Ŭ�� ���ǵ� �⺻ ���� �Լ��� ����ϰų�
--    ���� ������ �Լ��� ���� �� �ִ�. (�� ����� ���� �Լ�)
--    �� ����� ���� �Լ��� �ý��� �Լ�ó�� �������� ȣ���ϰų�
--    ���� ���ν���ó�� EXECUTE ���� ���� ������ �� �ִ�.

-- 2. ���� �� ����
/*
CREATE [OR REPLACE] FUNCTION �Լ��� -- REPLACE ���� ��������� ��
[( �Ű�������1 �ڷ���
 , �Ű�������2 �ڷ���
)]
RETURN ������Ÿ��         -- �ڹٿ����� ��ȯ�ڷ���ó��
IS                        -- IS ���ʱ��� �����
    -- �ֿ� ���� ����
BEGIN
    -- ���๮;
    ...
    RETURN (��);          -- � ���� RETURN�� ����
    
    [EXCEPTION]
        -- ���� ó�� ����;
END;
*/

--�� ����� ���� �Լ�(������ �Լ�)��
--   IN �Ķ����(�Է� �Ű�����)�� ����� �� ������
--   �ݵ�� ��ȯ�� ���� ������Ÿ���� RETURN ���� �����ؾ� �ϰ�,
--   FUNCTION �� �ݵ�� ���� ���� ��ȯ�Ѵ�.

-- ���� �̿����� ��ġ�뿡 ��ġ�� ��� ������ --> �Է� �Ķ����(IN) �ѱ� ��
-- �ٽ� ��ġ�뿡 ���� ������ --> OUT 

--�� TBL_INSA ���̺� ���� ���� Ȯ�� �Լ� ����(����)
-- �Լ��� : FN_GENDER()
--                   �� SSN(�ֹε�Ϲ�ȣ) �� '771212-1022432' �� 'YYMMDD-NNNNNNN'

CREATE OR REPLACE FUNCTION FN_GENDER( V_SSN VARCHAR2 )  -- �Ű�����   : �ڸ���(����) ���� �� ��
RETURN VARCHAR2                                         -- ��ȯ�ڷ��� : �ڸ���(����) ���� �� ��
IS
    -- ����� �� �ֿ� ���� ����
    V_RESULT    VARCHAR2(20);
BEGIN
    -- �����(���Ǻ�) �� ���� �� ó��
    IF ( SUBSTR(V_SSN, 8, 1) IN ('1', '3') ) -- ��ȣ�� �ִ� ���� ������(�������� �������� ����)
        THEN V_RESULT := '����';
    ELSIF ( SUBSTR(V_SSN, 8, 1) IN ('2', '4') )
        THEN V_RESULT := '����';
    ELSE -- ELSE���� THEN�� ����~!
        V_RESULT := '����Ȯ�κҰ�';
    END IF;
    
    -- ����� ��ȯ       CHECK~!!
    RETURN V_RESULT;
    
END;
--==>> Function FN_GENDER��(��) �����ϵǾ����ϴ�.


--�� ������ ���� �� ���� �Ű�����(�Է� �Ķ����)�� �Ѱܹ޾� �� (A, B)
--   A �� B ���� ���� ��ȯ�ϴ� ����� ���� �Լ��� �ۼ��Ѵ�.
--   ��, ������ ����Ŭ ���� �Լ��� �̿����� �ʰ�, �ݺ����� Ȱ���Ͽ� �ۼ��Ѵ�.
--   �Լ��� : FN_POW()
/*
��� ��)
SELECT FN_POW(10, 3)
FROM DUAL;
--==>> 1000
*/

/*
FN_POW(10, 3)                �� 1000
       ���� 1 * 10 * 10 * 10 �� 1000
       ���� 0 * 10 * 10 * 10 �� 0
*/

CREATE OR REPLACE FUNCTION FN_POW(A NUMBER, B NUMBER)
RETURN NUMBER
IS
    RESULT NUMBER := 1;
    N      NUMBER := 1;
    
BEGIN
    LOOP
        RESULT := RESULT * A;
        EXIT WHEN N >= B;
        N := N + 1;            
    END LOOP;
    
    RETURN RESULT;
    
END;
--==>> Function FN_POW��(��) �����ϵǾ����ϴ�.

-- ���� Ǯ��
CREATE OR REPLACE FUNCTION FN_POW(A NUMBER, B NUMBER) -- �����ݷ� ������ �� ��
RETURN NUMBER
IS  
    V_RESULT    NUMBER := 1;            -- ��ȯ ����� ���� �� CHECK~!!! 1�� �ʱ�ȭ~!!!
    V_NUM       NUMBER;                 -- ���� ����
BEGIN
    -- �ݺ��� ����
    FOR V_NUM IN 1 .. B LOOP
        V_RESULT := V_RESULT * A;       -- V_RESULT *= A; / �ڹٷ� ġ�ڸ�~
    END LOOP;
    
    -- ���� ����� ��ȯ
    RETURN V_RESULT;
END;
--==>> Function FN_POW��(��) �����ϵǾ����ϴ�.

-- 2022.03.10. -----------------------------------------------------------------

--�� TBL_INSA ���̺��� �޿� ��� ���� �Լ��� �����Ѵ�.
--   �޿��� ��(�⺻��*12)+���硻 ������� ������ �����Ѵ�.
--   �Լ��� : FN_PAY(�⺻��, ����)

-- �� Ǯ��
CREATE OR REPLACE FUNCTION FN_PAY(A NUMBER, B NUMBER)
RETURN NUMBER
IS
    V_RESULT    NUMBER;
BEGIN
    V_RESULT := (A * 12) + B;
    
    RETURN V_RESULT;
END;
--==>> Function FN_PAY��(��) �����ϵǾ����ϴ�.

-- ���� Ǯ�� 
CREATE OR REPLACE FUNCTION FN_PAY(VBASICPAY NUMBER, VSUDANG NUMBER)
RETURN NUMBER
IS 
    -- �ֿ� ���� ����
    VRESULT NUMBER;
BEGIN
    -- ���� �� ó��
    VRESULT := (NVL(VBASICPAY, 0) * 12) + NVL(VSUDANG, 0);
    
    -- ���� ����� ��ȯ
    RETURN VRESULT;
END;
--==>> Function FN_PAY��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------

--�� TBL_INSA ���̺��� �Ի����� �������� ���������
--   �ٹ������ ��ȯ�ϴ� �Լ��� �����Ѵ�.
--   ��, �ٹ������ �Ҽ��� ���� ���ڸ����� ����Ѵ�.
--   �Լ��� : FN_WORKYEAR

-- �� Ǯ��
CREATE OR REPLACE FUNCTION FN_WORKYEAR(VIBSADATE VARCHAR2)
RETURN NUMBER
IS
    VRESULT NUMBER;
BEGIN
    VRESULT := EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(VIBSADATE, 1, 4));
    
    RETURN VRESULT;
END;
--==>> Function FN_WORKYEAR��(��) �����ϵǾ����ϴ�.

CREATE OR REPLACE FUNCTION FN_WORKYEAR(VIBSADATE VARCHAR2)
RETURN NUMBER
IS
    VRESULT NUMBER;
BEGIN
    VRESULT := ROUND( ((SYSDATE - TO_DATE(VIBSADATE, 'YYYY-MM-DD')) / 365), 2 );
    
    RETURN VRESULT;
END;
--==>> Function FN_WORKYEAR��(��) �����ϵǾ����ϴ�.

-- ���� Ǯ��

-- 1
SELECT MONTHS_BETWEEN(SYSDATE, '2002-02-11') / 12
FROM DUAL;
--==>> 20.08177618478693747510951812027080844283

-- 2
SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, '2002-02-11') / 12) || '��' ||
       TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, '2002-02-11'), 12)) || '����'
FROM DUAL;
--==>> 20��0����

CREATE OR REPLACE FUNCTION FN_WORKYEAR(VIBSADATE DATE)
RETURN VARCHAR2
IS
    VRESULT VARCHAR(20);
BEGIN
    VRESULT := TRUNC(MONTHS_BETWEEN(SYSDATE, VIBSADATE) / 12) || '��' ||
               TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, VIBSADATE), 12)) || '����';
    
    RETURN VRESULT;
END;
--==>> Function FN_WORKYEAR��(��) �����ϵǾ����ϴ�.


CREATE OR REPLACE FUNCTION FN_WORKYEAR(VIBSADATE DATE)
RETURN NUMBER
IS
    VRESULT NUMBER;
BEGIN
    VRESULT := TRUNC(MONTHS_BETWEEN(SYSDATE, VIBSADATE) / 12, 1);
    
    RETURN VRESULT;
END;
--==>> Function FN_WORKYEAR��(��) �����ϵǾ����ϴ�.


--------------------------------------------------------------------------------

--�� ����

-- 1. INSERT, UPDATE, DELETE, (MERGE)
--==>> DML(Data Manipulation Language)
-- COMMIT / ROLLBACK �� �ʿ��ϴ�.

-- 2. CREATE, DROP, ALTER, (TRUNCATE)
--==>> DDL(Data Definition Language)
-- �����ϸ� �ڵ����� COMMIT �ȴ�.

-- 3. GRANT, REVOKE
--==>> DCL(Data Control Language)
-- �����ϸ� �ڵ����� COMMIT �ȴ�.

-- 4. COMMIT, ROLLBACK
--==>> TCL(Transaction Control Language)

-- ���� PL/SQL �� �� DML��, TCL���� ��� �����ϴ�.
-- ���� PL/SQL �� �� DML��, DDL��, DCL��, TCL�� ��� �����ϴ�. 

--------------------------------------------------------------------------------

--���� PROCEDURE(���ν���) ����--

-- 1. PL/SQL ���� ���� ��ǥ���� ������ ������ ���ν����� -- �̰� ������ PL/SQL�� ����Ѵٰ� �ص� ������ �ƴҸ�ŭ..
--    �����ڰ� ���� �ۼ��ؾ� �ϴ� ������ �帧��
--    �̸� �ۼ��Ͽ� �����ͺ��̽� ���� ������ �ξ��ٰ�
--    �ʿ��� ������ ȣ���Ͽ� ������ �� �ֵ��� ó���� �ִ� �����̴�.

-- 2. ���� �� ����
/*
CREATE [OR REPLACE] PROCEDURE ���ν�����
[( �Ű����� IN ������Ÿ�� -- �Է� �Ű����� / ��ġ��ħ�� �ǳ��ֱ⸸ �Ұ�
 , �Ű����� OUT ������Ÿ�� -- ��� �Ű����� / ���� �� �� ���״ϱ� ���� ��ħ���� ��Ƽ� �ְڴ�?
 , �Ű����� INOUT ������Ÿ�� -- ����� �Ű����� / ��ġ��ħ�� ��ġ�뿡 ��Ƽ� ���״ϱ� �ʵ� ���������� �׷� �� �����
)]
IS
    [-- �ֿ� ���� ����]
BEGIN
    -- ���� ����;
    ...
    
    [EXCEPTION
        -- ���� ó�� ����;]
END;
*/

--�� FUNCTION �� ������ �� ��RETURN ��ȯ�ڷ����� �κ��� �������� ������,
--   ��RETURN���� ��ü�� �������� ������,
--   ���ν��� ���� �� �Ѱ��ְ� �Ǵ� �Ű������� ������
--   IN(�Է�), OUT(���), INOUT(�����)���� ���еȴ�.

-- 3. ����(ȣ��)
/*
EXEC[UTE] ���ν�����[(�μ�1, �μ�2, ...)];
*/

--�� ���ν��� �ǽ��� ���� ���̺� ������
--   ��20220310_02_scott.sql�� ���� ����~!!!


--�� ���ν��� ����
CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT
( ���̵�
, �н�����
, �̸�
, ��ȭ
, �ּ�
)
IS 
BEGIN
END;

CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT
( V_ID      IN TBL_IDPW.ID%TYPE     -- �Լ����� IN�� ������ ��
, V_PW      IN TBL_IDPW.PW%TYPE
, V_NAME    IN TBL_STUDENTS.NAME%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS 
BEGIN
    -- TBL_IDPW ���̺� ������ �Է�(INSERT)
    INSERT INTO TBL_IDPW(ID, PW)
    VALUES(V_ID, V_PW);
    
    -- TBL_STUDENTS ���̺� ������ �Է�(INSERT)
    INSERT INTO TBL_STUDENTS(ID, NAME, TEL, ADDR)
    VALUES(V_ID, V_NAME, V_TEL, V_ADDR);
    
    -- Ŀ��
    COMMIT;
    
END;
--==>>  Procedure PRC_STUDENT_INSERT��(��) �����ϵǾ����ϴ�.



--�� ���ν��� �ǽ��� ���� ���̺� ������
--   ��20220310_02_scott.sql�� ���� ����~!!!


--�� ������ �Է� �� Ư�� �׸��� �����͸� �Է��ϸ�
--                  ---------
--                  (�й�, �̸�, ��������, ��������, ��������)
--   ���������� �ٸ� �߰��׸� ���� ó���� �Բ� �̷���� �� �ֵ��� �ϴ�
--                   --------
--                   (����, ���, ���)
--   ���ν����� �ۼ��Ѵ�.(�����Ѵ�.)
--   ���ν��� �� : PRC_SUNGJUK_INSERT()

















