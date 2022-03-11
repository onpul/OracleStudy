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

--�� TBL_INSA ���̺����� �Ի����� �������� ���������                           -- ����
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
    -- TBL_IDPW ���̺��� ������ �Է�(INSERT)
    INSERT INTO TBL_IDPW(ID, PW)
    VALUES(V_ID, V_PW);
    
    -- TBL_STUDENTS ���̺��� ������ �Է�(INSERT)
    INSERT INTO TBL_STUDENTS(ID, NAME, TEL, ADDR)
    VALUES(V_ID, V_NAME, V_TEL, V_ADDR);
    
    -- Ŀ��
    COMMIT;
    
END;
--==>>  Procedure PRC_STUDENT_INSERT��(��) �����ϵǾ����ϴ�.



--�� ���ν��� �ǽ��� ���� ���̺� ������
--   ��20220310_02_scott.sql�� ���� ����~!!!

--------------------------------------------------------------------------------

--�� ������ �Է� �� Ư�� �׸��� �����͸� �Է��ϸ�                               -- ����
--                  ---------
--                  (�й�, �̸�, ��������, ��������, ��������)
--   ���������� �ٸ� �߰��׸� ���� ó���� �Բ� �̷���� �� �ֵ��� �ϴ�
--                   --------
--                   (����, ���, ���)
--   ���ν����� �ۼ��Ѵ�.(�����Ѵ�.)
--   ���ν��� �� : PRC_SUNGJUK_INSERT()

/*
���� ��)
EXEC PRC_SUNGJUK_INSERT(1, '�ּ���', 90, 80, 70);

���ν��� ȣ��� ó���� ���
�й� �̸� �������� �������� �������� ���� ��� ���
1   �ּ���   90      80        70    240   80   B
*/

-- �� Ǯ�� 
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( V_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME    IN TBL_SUNGJUK.NAME%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
--, V_TOT     IN TBL_SUNGJUK.TOT%TYPE
--, V_AVG     IN TBL_SUNGJUK.AVG%TYPE
--, V_GRADE   IN TBL_SUNGJUK.GRADE%TYPE
)
IS
    V_TOT     TBL_SUNGJUK.TOT%TYPE;
    V_AVG     TBL_SUNGJUK.AVG%TYPE;
    V_GRADE   TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := (V_TOT) / 3;
    
    V_GRADE := 
    CASE TRUNC(V_AVG, -1)
        WHEN 100 THEN 'A'
        WHEN 90 THEN 'A'
        WHEN 80 THEN 'B'
        WHEN 70 THEN 'C'
        WHEN 60 THEN 'D'
        ELSE 'F'
    END; -- END CASE �ƴ�
    
    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT, V_TOT, V_AVG, V_GRADE);  

END;

-- ���� Ǯ��
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( �й�
, ����
, ��������
, ��������
, ��������
)
IS
BEGIN
END;

CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( V_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME    IN TBL_SUNGJUK.NAME%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS
BEGIN
END;


CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( V_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME    IN TBL_SUNGJUK.NAME%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS
    -- �����
    -- INSERT ������ ������ �ϱ� ���� �ʿ��� �߰� ���� ����
    V_TOT   TBL_SUNGJUK.TOT%TYPE;
    V_AVG   TBL_SUNGJUK.AVG%TYPE;   
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- �����
    -- �߰��� ������ �ֿ� �����鿡 ���� ��Ƴ��� �Ѵ�.
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := (V_TOT) / 3;
    
    IF  (V_AVG >= 90) -- ���ǹ� �������̸� ��ȣ ����� �ּ���
        THEN V_GRADE := 'A';
    ELSIF (V_AVG >= 80)
        THEN V_GRADE := 'B';
    ELSIF (V_AVG >= 70)
        THEN V_GRADE := 'C';
    ELSIF (V_GRADE >= 60)
        THEN V_GRADE := 'D';
    ELSE
        V_GRADE := 'F';
    END IF;
    
    -- INSERT ������ ����
    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT, V_TOT, V_AVG, V_GRADE); 
    
    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_INSERT��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------

--�� TBL_SUNGJUK ���̺����� Ư�� �л��� ����                                    -- ����
--   (�й�, ��������, ��������, ��������) ������ ���� ��
--   ����, ���, ��ޱ��� �Բ� �����Ǵ� ���ν����� �����Ѵ�.
--   ���ν��� �� : PRC_SUNGJUK_UPDATE()

/*
���� ��)
EXEC PRC_SUNGJUK_UPDATE(2, 50, 50, 50);

���ν��� ȣ��� ó���� ���
�й� �̸� �������� �������� �������� ���� ��� ���
1   �ּ���   90      80        70    240   80   B
2   ������   50      50        50    150   50   F
*/

-- �� Ǯ��
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( V_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS
    -- �����
    -- INSERT ������ ������ �ϱ� ���� �ʿ��� �߰� ���� ����
    --V_NAME  TBL_SUNGJUK.NAME%TYPE
    V_TOT   TBL_SUNGJUK.TOT%TYPE;
    V_AVG   TBL_SUNGJUK.AVG%TYPE;   
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- �����
    -- �߰��� ������ �ֿ� �����鿡 ���� ��Ƴ��� �Ѵ�.
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := (V_TOT) / 3;
    
    IF  (V_AVG >= 90) -- ���ǹ� �������̸� ��ȣ ����� �ּ���
        THEN V_GRADE := 'A';
    ELSIF (V_AVG >= 80)
        THEN V_GRADE := 'B';
    ELSIF (V_AVG >= 70)
        THEN V_GRADE := 'C';
    ELSIF (V_GRADE >= 60)
        THEN V_GRADE := 'D';
    ELSE
        V_GRADE := 'F';
    END IF;
    
    -- ������Ʈ
    UPDATE TBL_SUNGJUK
    SET KOR = V_KOR, ENG = V_ENG, MAT = V_MAT, TOT = V_TOT, AVG = V_AVG, GRADE = V_GRADE
    WHERE HAKBUN = V_HAKBUN;
    
    -- Ŀ��
    COMMIT;
END;

-- ���� Ǯ��
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( �й�
, ��������
, ��������
, ��������
)
IS
BEGIN
END;

CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( V_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS
    -- �����
    -- UPDATE �������� �����ϱ� ���� �ʿ��� ����
    V_TOT   TBL_SUNGJUK.TOT%TYPE;
    V_AVG   TBL_SUNGJUK.AVG%TYPE;   
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- �����
     -- �߰��� ������ �ֿ� �����鿡 ���� ��Ƴ��� �Ѵ�.
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := (V_TOT) / 3;
    
    IF  (V_AVG >= 90) -- ���ǹ� �������̸� ��ȣ ����� �ּ���
        THEN V_GRADE := 'A';
    ELSIF (V_AVG >= 80)
        THEN V_GRADE := 'B';
    ELSIF (V_AVG >= 70)
        THEN V_GRADE := 'C';
    ELSIF (V_GRADE >= 60)
        THEN V_GRADE := 'D';
    ELSE
        V_GRADE := 'F';
    END IF;
    
    -- UPDATE ������ ����
    UPDATE TBL_SUNGJUK
    SET KOR = V_KOR, ENG = V_ENG, MAT = V_MAT
      , TOT = V_TOT, AVG = V_AVG, GRADE = V_GRADE
    WHERE HAKBUN = V_HAKBUN;
    
    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_UPDATE��(��) �����ϵǾ����ϴ�.


--�� TBL_STUDENTS ���̺����� ��ȭ��ȣ�� �ּ� �����͸� �����ϴ�(�����ϴ�)
--   ���ν����� �ۼ��Ѵ�.
--   ��, ID �� PW �� ��ġ�ϴ� ��쿡�� ������ ������ �� �ֵ��� ó���Ѵ�.
--   ���ν��� �� : PRC_STUDENTS_UPDATE()

/*
���� ��)
EXEC PRC_STUDENTS_UPDATE('happy', 'java006', '010-9999-9999', '������ Ⱦ��');
--==>> ������ ���� ��

EXEC PRC_STUDENTS_UPDATE('happy', 'java006$', '010-9999-9999', '������ Ⱦ��');
--==>> ������ ���� ��
*/

CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( V_ID      IN TBL_IDPW.ID%TYPE     
, V_PW      IN TBL_IDPW.PW%TYPE
--, V_NAME    IN TBL_STUDENTS.NAME%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS     
BEGIN
    
    -- UPDATE ������ ����
    UPDATE TBL_STUDENTS
    SET TEL = V_TEL, ADDR = V_ADDR
    WHERE ID = V_ID AND 
              ( SELECT PW
                FROM TBL_IDPW
                WHERE ID = V_ID ) = V_PW;
    
    -- Ŀ��
    COMMIT;
    
END;
--==>> Procedure PRC_STUDENTS_UPDATE��(��) �����ϵǾ����ϴ�.

-- ���� Ǯ��
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( ���̵�
, �н�����
, ��ȭ��ȣ
, �ּ�
)
IS 
BEGIN
END;

-- ��� 1.
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( V_ID      IN TBL_IDPW.ID%TYPE     
, V_PW      IN TBL_IDPW.PW%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS 
    V_PW2 TBL_IDPW.PW%TYPE;
    V_FLAG NUMBER := 0;
BEGIN
    SELECT PW INTO V_PW2
    FROM TBL_IDPW
    WHERE ID = V_ID;
    
    IF (V_PW = V_PW2)
        THEN V_FLAG := 1;
    ELSE
        V_FLAG = 2;
    END IF;
    
    UPDATE TBL_STUDENTS
    SET TEL = V_TEL, ADDR = V_ADDR
    WHERE ID = V_ID
      AND V_FLAG = 1;
      
    COMMIT;
    
END;

-- ��� 2.
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( V_ID      IN TBL_IDPW.ID%TYPE     
, V_PW      IN TBL_IDPW.PW%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS 
BEGIN
    UPDATE (SELECT T1.ID, T1.PW, T2.TEL, T2.ADDR
            FROM TBL_IDPW T1 JOIN TBL_STUDENTS T2
            ON T1.ID = T2.ID) T
    SET T.TEL = V_TEL, T.ADDR = V_ADDR
    WHERE T.ID = V_ID
      AND T.PW = V_PW;
      
    COMMIT;
END;
--==>> Procedure PRC_STUDENTS_UPDATE��(��) �����ϵǾ����ϴ�.