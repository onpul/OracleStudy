SELECT USER
FROM DUAL;
--==>> SCOTT

DESC TBL_INSA;

SELECT *
FROM TBL_INSA;

--�� TBL_INSA ���̺��� ������� �ű� ������ �Է� ���ν����� �ۼ��Ѵ�.
-- NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
-- ���� ������ �÷� �� NUM �� ������ NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG �� ������ �Է� ��
-- NUM �÷�(�����ȣ)�� ����
-- ���� �ο��� ���  ��ȣ�� ������ ��ȣ �� ���� ��ȣ�� �ڵ����� �Է� ó���� �� �ִ� ���ν����� �����Ѵ�.
-- ���ν��� �� : PRC_INSA_INSERT()
/*
���� ��)
EXEC PRC_INSA_INSERT('������', '970131-2234567', SYSDATE, '����', '010-8624-4533', '���ߺ�', '�븮', 2000000, 2000000);

���ν��� ȣ��� ó���� ���
1061 ������ 970131-2234567 2022-03-11 ���� 010-8624-4533 ���ߺ� �븮 2000000 2000000
�� �����Ͱ� �ű� �Էµ� ��Ȳ
*/

-- �� Ǯ��
CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( V_NAME        IN TBL_INSA.NAME%TYPE 
, V_SSN         IN TBL_INSA.SSN%TYPE
, V_IBSADATE    IN TBL_INSA.IBSADATE%TYPE
, V_CITY        IN TBL_INSA.CITY%TYPE
, V_TEL         IN TBL_INSA.TEL%TYPE
, V_BUSEO       IN TBL_INSA.BUSEO%TYPE
, V_JIKWI       IN TBL_INSA.JIKWI%TYPE
, V_BASICPAY    IN TBL_INSA.BASICPAY%TYPE
, V_SUDANG      IN TBL_INSA.SUDANG%TYPE
)
IS
    V_NUM   TBL_INSA.NUM%TYPE;
    
BEGIN
    SELECT MAX(NUM)+1 INTO V_NUM
    FROM TBL_INSA;
    
    -- TBL_INSA ���̺� ������ �Է�(INSERT)
    INSERT INTO TBL_INSA(NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES(V_NUM, V_NAME, V_SSN, V_IBSADATE, V_CITY, V_TEL, V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG);
    
    -- Ŀ��
    COMMIT;
    
END;
--==>> Procedure PRC_INSA_INSERT��(��) �����ϵǾ����ϴ�.

-- ���� Ǯ��
CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( V_NAME        IN TBL_INSA.NAME%TYPE 
, V_SSN         IN TBL_INSA.SSN%TYPE
, V_IBSADATE    IN TBL_INSA.IBSADATE%TYPE
, V_CITY        IN TBL_INSA.CITY%TYPE
, V_TEL         IN TBL_INSA.TEL%TYPE
, V_BUSEO       IN TBL_INSA.BUSEO%TYPE
, V_JIKWI       IN TBL_INSA.JIKWI%TYPE
, V_BASICPAY    IN TBL_INSA.BASICPAY%TYPE
, V_SUDANG      IN TBL_INSA.SUDANG%TYPE
)
IS
    V_NUM   TBL_INSA.NUM%TYPE; -- �����ݷ� Ȯ��
    
BEGIN
    SELECT MAX(NVL(NUM, 0)) + 1 INTO V_NUM -- MAX, MIN, SUM �̷� �ֵ��� �� NULL�� �����ϰ� ���� --> NVL ó��
    FROM TBL_INSA;
    
    INSERT INTO TBL_INSA(NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES(V_NUM, V_NAME, V_SSN, V_IBSADATE, V_CITY, V_TEL, V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG);
    
    COMMIT; -- Ŀ��, �ѹ� Ȯ��
    
END;
--==>> Procedure PRC_INSA_INSERT��(��) �����ϵǾ����ϴ�.


--�� TBL_��ǰ, TBL_�԰� ���̺��� �������
--   TBL_�԰� ���̺� ������ �Է� ��(��, �԰� �̺�Ʈ �߻� ��)
--   TBL_��ǰ ���̺��� �������� �Բ� ������ �� �ִ� ����� ���� ���ν����� �ۼ��Ѵ�.
--   ��, �� �������� �԰��ȣ�� �ڵ� ���� ó���Ѵ�. (������ ��� ��)
--   TBL_�԰� ���̺� ���� �÷�
--   : �԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�
--   ���ν��� �� : PRC_�԰�_INSERT(��ǰ�ڵ�, �԰����, �԰�ܰ�)

-- 'H001', 30, 400
-- �� �԰����̺��� ������ �Է�(���ν��� �Ű������� ���޹��� ���� ������ �� �� �ڵ� �Է�)
-- �� ��ǰ���̺��� �ٹ�� ������ 30��

-- �� Ǯ��
CREATE OR REPLACE PROCEDURE PRC_�԰�_INSERT
( V_��ǰ�ڵ�    IN TBL_�԰�.��ǰ�ڵ�%TYPE
, V_�԰����    IN TBL_�԰�.�԰����%TYPE
, V_�԰�ܰ�    IN TBL_�԰�.�԰�ܰ�%TYPE
)
IS
    V_�԰��ȣ    TBL_�԰�.�԰��ȣ%TYPE;
    V_�԰�����    TBL_�԰�.�԰�����%TYPE;
BEGIN
    -- �԰��ȣ
    SELECT �԰��ȣ MAX(NVL(�԰��ȣ, 0)) + 1 INTO V_�԰��ȣ
    FROM TBL_�԰�;
    
    V_�԰����� := SYSDATE;
    
    -- �԰� ���̺� ������ �Է�
    INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)  
    VALUES(V_�԰��ȣ, V_��ǰ�ڵ�, V_�԰�����, V_�԰����, V_�԰�ܰ�);
    
    -- ��ǰ ���̺� ��� ���� ������Ʈ
    UPDATE TBL_��ǰ
    SET ������ = ������ + V_�԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    COMMIT;
END;
--==>> Procedure PRC_�԰�_INSERT��(��) �����ϵǾ����ϴ�.


-- ���� Ǯ��
CREATE OR REPLACE PROCEDURE PRC_�԰�_INSERT
( V_��ǰ�ڵ�    IN TBL_��ǰ.��ǰ�ڵ�%TYPE -- �ߺ��� �÷��� �� �� �� �������̸� �θ����̺� ������...
, V_�԰����    IN TBL_�԰�.�԰����%TYPE
, V_�԰�ܰ�    IN TBL_�԰�.�԰�ܰ�%TYPE
)
IS
    -- �����
    -- �Ʒ��� �������� �����ϱ� ���� �ʿ��� ���� �߰� ����
    V_�԰��ȣ  TBL_�԰�.�԰��ȣ%TYPE;
    
BEGIN
    -- ������ ������ �� ��Ƴ���
    -- SELECT ������ ����
    SELECT NVL(MAX(�԰��ȣ), 0) INTO V_�԰��ȣ -- ���������� ���� �� ���� �� �̷���
    FROM TBL_�԰�;

    -- INSERT ������ ����
    INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰����, �԰�ܰ�)
    VALUES((V_�԰��ȣ+1), V_��ǰ�ڵ�, V_�԰����, V_�԰�ܰ�);
    
    -- UPDATE ������ ����
    UPDATE TBL_��ǰ
    SET ������ = ������ + V_�԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ���� ó�� / �ڹٿ��� TRY CATCH �� ��ó��
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; -- �� �߿� �ϳ��� ������� �� �ѹ�
    
    -- Ŀ��
    COMMIT; 
    
    -- Ŀ���� �ʿ��� DML ������ �� ��.
    -- �� �� �� �ϰ������� ó���ǰ�.
    -- Ʈ�����
END;
--==>> Procedure PRC_�԰�_INSERT��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------

--���� ���ν��� �������� ���� ó�� ����--




















