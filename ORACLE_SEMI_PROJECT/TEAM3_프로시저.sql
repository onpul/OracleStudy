-- ���� ������ �α��� ���ν��� ����
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

--------------------------------------------------------------------------------

-- ���� ������ �α��� ���ν��� ����
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

--------------------------------------------------------------------------------

-- ���� �л� �α��� ���ν��� ����
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

--���� ������ �ʱ�ȭ ���ν��� ����
CREATE OR REPLACE PROCEDURE PRC_RESET_SEQ
( V_SEQ_NAME IN VARCHAR2 )
IS
    V_SEQ_VAL NUMBER;
BEGIN
    -- ���������� ���� SEQ_VAL ������ ����
    EXECUTE IMMEDIATE 'SELECT ' || V_SEQ_NAME || '.NEXTVAL FROM DUAL' INTO V_SEQ_VAL;

    -- ������ ���������� ����� ��(SEQ_VAL)�� ���ش�. �׷� 0���� �ʱ�ȭ ��.
    EXECUTE IMMEDIATE 'ALTER SEQUENCE ' || V_SEQ_NAME || ' INCREMENT BY -' || V_SEQ_VAL || ' MINVALUE 0';

    -- 0���� �ʱ�ȭ �� ������ ���� Ȯ��
    EXECUTE IMMEDIATE 'SELECT ' || V_SEQ_NAME || '.NEXTVAL FROM DUAL' INTO V_SEQ_VAL;

    -- ���ݺ��ʹ� 1�� �����ǵ��� �������� ������.
    EXECUTE IMMEDIATE 'ALTER SEQUENCE ' || V_SEQ_NAME || ' INCREMENT BY 1 MINVALUE 0';
END PRC_RESET_SEQ;
--==>> Procedure PRC_RESET_SEQ��(��) �����ϵǾ����ϴ�.

--���� �ߵ� Ż�� ���� �Է� ���ν��� ����--
CREATE OR REPLACE PROCEDURE PRC_REASONS_DROPOUT_INSERT
(V_REASON_DROPOUT   IN REASONS_DROPOUT.REASON_DROPOUT%TYPE)
IS
    COUNTNUM    NUMBER;
BEGIN
    
    SELECT COUNT(*) INTO COUNTNUM
    FROM REASONS_DROPOUT;
    
    -- ù ���ڵ� �Է��̸� ������ �ʱ�ȭ
    IF (COUNTNUM = 0)
        THEN PRC_RESET_SEQ('SEQ_REASONS_DROPOUT');
    END IF;
    
    INSERT INTO REASONS_DROPOUT(REASONS_DROPOUT_ID, REASON_DROPOUT)
    VALUES(CONCAT('DR', TO_CHAR(LPAD(SEQ_REASONS_DROPOUT.NEXTVAL, 3, 0))), V_REASON_DROPOUT);  
    
    COMMIT;
END;
--==>> Procedure PRC_REASONS_DROPOUT_INSERT��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------

--���� �ߵ� Ż�� ���� ���� ���ν��� ����--
CREATE OR REPLACE PROCEDURE PRC_REASONS_DROPOUT_UPDATE
( V_REASONS_DROPOUT_ID IN REASONS_DROPOUT.REASONS_DROPOUT_ID%TYPE
, V_REASON_DROPOUT    IN REASONS_DROPOUT.REASON_DROPOUT%TYPE
)
IS
BEGIN
    UPDATE REASONS_DROPOUT
    SET REASON_DROPOUT = V_REASON_DROPOUT
    WHERE REASONS_DROPOUT_ID = V_REASONS_DROPOUT_ID;
    
    COMMIT;
END;
--==>> Procedure PRC_REASONS_DROPOUT_UPDATE��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------

--���� �ߵ� Ż�� ���� ���� ���ν��� ����--
CREATE OR REPLACE PROCEDURE PRC_REASONS_DROPOUT_DELETE
( V_REASONS_DROPOUT_ID IN REASONS_DROPOUT.REASONS_DROPOUT_ID%TYPE )
IS
BEGIN
    DELETE
    FROM REASONS_DROPOUT
    WHERE REASONS_DROPOUT_ID = V_REASONS_DROPOUT_ID;
    
    COMMIT;
END;
--==>> Procedure PRC_REASONS_DROPOUT_DELETE��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------

EXEC PRC_REASONS_DROPOUT_INSERT ('���Ȼ���');
EXEC PRC_REASONS_DROPOUT_INSERT ('�������');
EXEC PRC_REASONS_DROPOUT_INSERT ('���κ���');
EXEC PRC_REASONS_DROPOUT_INSERT ('�ǰ���ȭ');

EXEC PRC_REASONS_DROPOUT_DELETE ('DR001');
EXEC PRC_REASONS_DROPOUT_DELETE ('DR002');
EXEC PRC_REASONS_DROPOUT_DELETE ('DR003');
EXEC PRC_REASONS_DROPOUT_DELETE ('DR004');

SELECT *
FROM REASONS_DROPOUT
ORDER BY REASONS_DROPOUT_ID;
