SELECT USER
FROM DUAL;
--==>> TEAM3

-- ���ν��� ���� ���� �ο�(SYS ��������)
GRANT CREATE PROCEDURE TO TEAM3;
--==>> Grant��(��) �����߽��ϴ�.

-- �׽�Ʈ �� ������ �Է�(�׽�Ʈ �� ���� �Ϸ�)
SELECT * --DELETE
FROM ADMIN;

INSERT INTO ADMIN(ADMIN_ID, ADMIN_NAME, SSN, PASSWORD, REGIST_DATE)
VALUES('1234', 'TEST1', '123456-1234567', '1234567', SYSDATE);

-- ȯ�溯�� ����
SET SERVEROUTPUT ON;

-- ���ν��� �׽�Ʈ
EXEC PRC_LOGIN_ADMIN('0000', '1234567');
--==>> TEST1 �����ڴ� �������. 

--------------------------------------------------------------------------------

--���� �α��� ���ν��� ����--

-- �α��� ���ν��� (������)
CREATE OR REPLACE PROCEDURE PRC_LOGIN_ADMIN
( V_ID  IN ADMIN.ADMIN_ID%TYPE
, V_PW  IN ADMIN.PASSWORD%TYPE
)

IS
    V_IDCOUNT   NUMBER; -- ID �ִ��� ī��Ʈ�� �� 
    V_NAME      ADMIN.ADMIN_NAME%TYPE; -- �̸� ����
    V_PWTEMP    ADMIN.PASSWORD%TYPE;  -- ��й�ȣ(��ϵǾ� �ִ� ��й�ȣ)
    
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2  EXCEPTION;
    
BEGIN
    -- 1. ID�� �ִ��� Ȯ��
    SELECT COUNT(*) INTO V_IDCOUNT
    FROM ADMIN
    WHERE ADMIN_ID = V_ID;
    
    -- �Է��� ���̵� ���̺� ������ ���� �߻�(��ϵ��� ���� ���̵�)
    IF (V_IDCOUNT = 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 2. ���̵�� ��й�ȣ�� ��ġ�ϴ��� Ȯ��
    SELECT PASSWORD INTO V_PWTEMP
    FROM ADMIN
    WHERE ADMIN_ID = V_ID;
    
    -- ��й�ȣ �ٸ��� ���� �߻�
    IF (V_PWTEMP != V_PW)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    -- 3. ���̵�, ��й�ȣ ���� ��     
    SELECT ADMIN_NAME INTO V_NAME
    FROM ADMIN
    WHERE ADMIN_ID = V_ID;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' �����ڴ� �������.');
    
    -- 4. ���� ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '��ϵ��� ���� ���̵��Դϴ�.');
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20002, '���̵� �Ǵ� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.');
END;


-- �α��� ���ν��� (����)
CREATE OR REPLACE PROCEDURE PRC_LOGIN_PROF
( V_ID  IN PROF.PROF_ID%TYPE
, V_PW  IN PROF.PASSWORD%TYPE
)

IS
    V_IDCOUNT   NUMBER; -- ID �ִ��� ī��Ʈ�� �� 
    V_NAME      PROF.PROF_NAME%TYPE; -- �̸� ����
    V_PWTEMP    PROF.PASSWORD%TYPE;  -- ��й�ȣ(��ϵǾ� �ִ� ��й�ȣ)
    
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2  EXCEPTION;
    
BEGIN
    -- 1. ID�� �ִ��� Ȯ��
    SELECT COUNT(*) INTO V_IDCOUNT
    FROM PROF
    WHERE PROF_ID = V_ID;
    
    -- �Է��� ���̵� ���̺� ������ ���� �߻�(��ϵ��� ���� ���̵�)
    IF (V_IDCOUNT = 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 2. ���̵�� ��й�ȣ�� ��ġ�ϴ��� Ȯ��
    SELECT PASSWORD INTO V_PWTEMP
    FROM PROF
    WHERE PROF_ID = V_ID;
    
    -- ��й�ȣ �ٸ��� ���� �߻�
    IF (V_PWTEMP != V_PW)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    -- 3. ���̵�, ��й�ȣ ���� ��     
    SELECT PROF_NAME INTO V_NAME
    FROM PROF
    WHERE PROF_ID = V_ID;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' �����ڴ� �������.');
    
    -- 4. ���� ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '��ϵ��� ���� ���̵��Դϴ�.');
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20002, '���̵� �Ǵ� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.');
END;


-- �α��� ���ν��� (�л�)
CREATE OR REPLACE PROCEDURE PRC_LOGIN_STU
( V_ID  IN STU.STU_ID%TYPE
, V_PW  IN STU.PASSWORD%TYPE
)

IS
    V_IDCOUNT   NUMBER; -- ID �ִ��� ī��Ʈ�� �� 
    V_NAME      STU.STU_NAME%TYPE; -- �̸� ����
    V_PWTEMP    STU.PASSWORD%TYPE;  -- ��й�ȣ(��ϵǾ� �ִ� ��й�ȣ)
    
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2  EXCEPTION;
    
BEGIN
    -- 1. ID�� �ִ��� Ȯ��
    SELECT COUNT(*) INTO V_IDCOUNT
    FROM STU
    WHERE STU_ID = V_ID;
    
    -- �Է��� ���̵� ���̺� ������ ���� �߻�(��ϵ��� ���� ���̵�)
    IF (V_IDCOUNT = 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 2. ���̵�� ��й�ȣ�� ��ġ�ϴ��� Ȯ��
    SELECT PASSWORD INTO V_PWTEMP
    FROM STU
    WHERE STU_ID = V_ID;
    
    -- ��й�ȣ �ٸ��� ���� �߻�
    IF (V_PWTEMP != V_PW)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    -- 3. ���̵�, ��й�ȣ ���� ��     
    SELECT STU_NAME INTO V_NAME
    FROM STU
    WHERE STU_ID = V_ID;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' �л��� �������.');
    
    -- 4. ���� ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '��ϵ��� ���� ���̵��Դϴ�.');
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20002, '���̵� �Ǵ� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.');
END;

--------------------------------------------------------------------------------

--���� �ߵ� Ż�� ���� �Է� ���ν��� ����--
CREATE OR REPLACE PROCEDURE PRC_REASONS_DROPOUT_INSERT
( V_REASONS_DROPOUT_ID  IN REASONS_DROPOUT.REASONS_DROPOUT_ID%TYPE
, V_REASON_DROPOUT      IN REASONS_DROPOUT.REASON_DROPOUT%TYPE
)
IS
BEGIN
END;




