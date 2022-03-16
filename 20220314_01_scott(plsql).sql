SELECT USER
FROM DUAL;
--==>> SCOTT


--�� TBL_��� ���̺����� ��������� ����(����)�ϴ� ���ν����� �ۼ��Ѵ�.
--   ���ν��� �� : PRC_���_UPDATE()
/*
���� ��)
EXEC PRC_���_UPDATE(�����ȣ, �����Ҽ���);
*/

CREATE OR REPLACE PROCEDURE PRC_���_UPDATE
( -- �� �Ű����� ����
  V_�����ȣ    IN TBL_���.�����ȣ%TYPE
, V_�������    IN TBL_���.�������%TYPE
)
IS
    -- �� �ʿ��� ���� ����
    V_��ǰ�ڵ�       TBL_��ǰ.��ǰ�ڵ�%TYPE;
    V_�����������   TBL_���.�������%TYPE; 
    V_�������       TBL_��ǰ.�������%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN

    -- �� ������ ������ �� ��Ƴ���
    -- �� 
    SELECT ��ǰ�ڵ�, ������� INTO V_��ǰ�ڵ�, V_�����������
    FROM TBL_���
    WHERE �����ȣ = V_�����ȣ;
    
    -- �� ��� ������࿩�� �Ǵ� �ʿ�
    --    ���� ������ ������� �� ������ ������� Ȯ��
    SELECT ������� INTO V_�������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- �� �ľ��� ��������� ���� ������ ���� �ǽ� ���� �Ǵ�
    --    (���������+����������� < ������������� �� ��Ȳ�̶��... ��������ǿ��� �߻�)
    IF (V_������� + V_����������� < V_�������)
        -- ��������� ���� �߻�
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- �� ����� ������ üũ(UPDATE �� TBL_��� / UPDATE �� TBL_��ǰ)
    UPDATE TBL_���
    SET ������� = V_�������
    WHERE �����ȣ = V_�����ȣ;
    
    -- ��
    UPDATE TBL_��ǰ
    SET ������� = ������� + V_����������� - V_�������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- �� Ŀ��
    COMMIT;
    
    -- �� ���� ó��
    EXCEPTION 
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '��� ����~!!!'); 
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
            
END;
--==>> Procedure PRC_���_UPDATE��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------

/*
1. PRC_�԰�_UPDATE(�԰���ȣ, �԰�����)
2. PRC_�԰�_DELETE(�԰���ȣ)
3. PRC_���_DELETE(�����ȣ)
*/

-- 1. PRC_�԰�_UPDATE(�԰���ȣ, �԰�����)
CREATE OR REPLACE PROCEDURE PRC_�԰�_UPDATE
( V_�԰���ȣ    IN TBL_�԰�.�԰���ȣ%TYPE
, V_�԰�����    IN TBL_�԰�.�԰�����%TYPE
)
IS
    V_��ǰ�ڵ�       TBL_��ǰ.��ǰ�ڵ�%TYPE;
    V_�������       TBL_��ǰ.�������%TYPE;
    V_�����԰�����   TBL_�԰�.�԰�����%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    -- V_��ǰ�ڵ�, V_�����԰����� ������ �� ��Ƴ���
    SELECT ��ǰ�ڵ�, �԰����� INTO V_��ǰ�ڵ�, V_�����԰�����
    FROM TBL_�԰�
    WHERE �԰���ȣ = V_�԰���ȣ;
    
    -- V_������� ������ �� ��Ƴ���
    SELECT ������� INTO V_�������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- �԰� ���̺� UPDATE
    UPDATE TBL_�԰�
    SET �԰����� = V_�԰�����
    WHERE �԰���ȣ = V_�԰���ȣ;
    
    -- ��������� ���� �Է��� �԰��������� ���� ���
    IF (V_������� < V_�԰�����)
        -- ��������� ���� �߻�
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- ��ǰ ���̺� �������
    UPDATE TBL_��ǰ
    SET ������� = ������� - V_�����԰����� + V_�԰�����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
     -- Ŀ��
    COMMIT;
    
    -- ���� ó�� 
    EXCEPTION 
       WHEN USER_DEFINE_ERROR
           THEN RAISE_APPLICATION_ERROR(-20002, '��� ����~!!!'); 
                ROLLBACK;
       WHEN OTHERS
           THEN ROLLBACK;        
    
END;
--==>> Procedure PRC_�԰�_UPDATE��(��) �����ϵǾ����ϴ�.


-- 2. PRC_�԰�_DELETE(�԰���ȣ)
CREATE OR REPLACE PROCEDURE PRC_�԰�_DELETE 
(V_�԰���ȣ IN TBL_�԰�.�԰���ȣ%TYPE)
IS
    V_�������԰�����   TBL_�԰�.�԰�����%TYPE;
    V_��ǰ�ڵ�         TBL_��ǰ.��ǰ�ڵ�%TYPE;
    V_�������         TBL_��ǰ.�������%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    -- V_�������԰����� ������ �� ��Ƴ���
    SELECT �԰����� INTO V_�������԰�����
    FROM TBL_�԰�
    WHERE �԰���ȣ = V_�԰���ȣ;
    
    -- V_��ǰ�ڵ� ������ �� ��Ƴ���
    SELECT ��ǰ�ڵ� INTO V_��ǰ�ڵ�
    FROM TBL_�԰�
    WHERE �԰���ȣ = V_�԰���ȣ;
    
     -- V_������� ������ �� ��Ƴ���
    SELECT ������� INTO V_�������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ������ �԰���ȣ�� �԰������� ������� ũ�� ��������� ���� �߻�  
    IF (V_������� < V_�������԰�����)
        -- ��������� ���� �߻�
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- �԰� ���̺� �ش� �� DELETE
    DELETE
    FROM TBL_�԰�
    WHERE �԰���ȣ = V_�԰���ȣ;
    
    -- ������ ���� �԰� ������ŭ ��ǰ ���� ���� ��
    UPDATE TBL_��ǰ
    SET ������� = V_������� - V_�������԰�����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- Ŀ��
    COMMIT;
    
    -- ���� ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20003, '������ �԰���ȣ�� �԰��������� ���� ��������� �����ϴ�.');
        WHEN OTHERS
            THEN ROLLBACK;

END;
--==>> Procedure PRC_�԰�_DELETE��(��) �����ϵǾ����ϴ�.

-- 3. PRC_���_DELETE(�����ȣ)
CREATE OR REPLACE PROCEDURE PRC_���_DELETE
(V_�����ȣ IN TBL_���.�����ȣ%TYPE)
IS
    V_�������������    TBL_���.�������%TYPE;
    V_��ǰ�ڵ�          TBL_��ǰ.��ǰ�ڵ�%TYPE;
    
BEGIN
    -- V_������������� ������ �� ��Ƴ���
    SELECT ������� INTO V_�������������
    FROM TBL_���
    WHERE �����ȣ = V_�����ȣ;
    
    -- ��� ���̺� �ش� �� ����
    DELETE
    FROM TBL_���
    WHERE �����ȣ = V_�����ȣ;
    
    -- V_��ǰ�ڵ� ������ �� ��Ƴ���
    SELECT ��ǰ�ڵ� INTO V_��ǰ�ڵ�
    FROM TBL_���
    WHERE �����ȣ = V_�����ȣ;
    
    -- ������ ���� ���������ŭ ��������� �ٽ� �־�� ��
    UPDATE TBL_��ǰ
    SET ������� = ������� + V_�������������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- Ŀ��
    COMMIT;
    
    -- ���� ó�� 
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; -- �� �߿� �ϳ��� ������� �� �ѹ�

END;
--==>> Procedure PRC_���_DELETE��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------

--���� CURSOR (Ŀ��) ����--
-- Ŀ���� ��� �ִ� ��¦ ���� ���� ��!!!
-- ���� �ȿ� �������� ���� ��� �ΰڴ�~!!!
-- �Ѳ��� ����� Ƣ��´�

-- 1. ����Ŭ������ �ϳ��� ���ڵ尡 �ƴ� ���� ���ڵ�� ������
--    �۾� �������� SQL ���� �����ϰ� �� �������� �߻��� ������
--    �����ϱ� ���� Ŀ��(CURSOR)�� ����ϸ�,
--    Ŀ������ �Ͻ����� Ŀ���� �������� Ŀ���� �ִ�.

-- 2. �Ͻ��� Ŀ���� ��� SQL ������ �����ϸ�
--    SQL �� ���� �� ���� �ϳ��� ��(ROW)�� ����ϰ� �ȴ�.
--    �׷��� SQL ���� ������ �����(RESULT SET)��
--    ���� ��(ROW)���� ������ ���
--    Ŀ��(CURSOR)�� ���������� �����ؾ� ���� ��(ROW)�� �ٷ� �� �ִ�.
--> �츮�� �𸣴� ���̿� �Ͻ������� ó���ȴ�~

--�� Ŀ�� �̿� �� ��Ȳ(���� �� ���� ��)
SET SERVEROUTPUT ON;
--==>> �۾��� �Ϸ�Ǿ����ϴ�.(0.1��)

DECLARE
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME, TEL INTO V_NAME, V_TEL
    FROM TBL_INSA
    WHERE NUM=1001;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
END;
--==>>
/*
ȫ�浿 -- 011-2356-4528


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� Ŀ�� �̿� �� ��Ȳ(���� �� ���� ��)
DECLARE
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME, TEL INTO V_NAME, V_TEL
    FROM TBL_INSA;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
END;
--==>> ���� �߻�
--     (ORA-01422: exact fetch returns more than requested number of rows)


--�� Ŀ�� �̿� �� ��Ȳ(���� �� ���� �� - �ݺ��� Ȱ��)
DECLARE
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
    V_NUM   TBL_INSA.NUM%TYPE := 1001;
BEGIN
    LOOP
        SELECT NAME, TEL INTO V_NAME, V_TEL
        FROM TBL_INSA
        WHERE NUM=V_NUM;        -- WHERE NUM=1001;
    
        DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
        
        V_NUM := V_NUM + 1;
        
        EXIT WHEN V_NUM >= 1061; -- �ڹٿ����� BREAK�� ����
        
    END LOOP;
END;
--==>>
/*
ȫ�浿 -- 011-2356-4528
�̼��� -- 010-4758-6532
�̼��� -- 010-4231-1236
������ -- 019-5236-4221
�Ѽ��� -- 018-5211-3542
�̱��� -- 010-3214-5357
����ö -- 011-2345-2525
�迵�� -- 016-2222-4444
������ -- 019-1111-2222
������ -- 011-3214-5555
������ -- 010-8888-4422
���ѱ� -- 018-2222-4242
���̼� -- 019-6666-4444
Ȳ���� -- 010-3214-5467
������ -- 016-2548-3365
�̻��� -- 010-4526-1234
����� -- 010-3254-2542
�̼��� -- 018-1333-3333
�ڹ��� -- 017-4747-4848
������ -- 011-9595-8585
ȫ�泲 -- 011-9999-7575
�̿��� -- 017-5214-5282
���μ� -- 
�踻�� -- 011-5248-7789
����� -- 010-4563-2587
����� -- 010-2112-5225
�迵�� -- 019-8523-1478
�̳��� -- 016-1818-4848
�踻�� -- 016-3535-3636
������ -- 019-6564-6752
����ȯ -- 019-5552-7511
�ɽ��� -- 016-8888-7474
��̳� -- 011-2444-4444
������ -- 011-3697-7412
������ -- 
���翵 -- 011-9999-9999
�ּ��� -- 011-7777-7777
���μ� -- 010-6542-7412
������ -- 010-2587-7895
�ڼ��� -- 016-4444-7777
����� -- 016-4444-5555
ä���� -- 011-5125-5511
��̿� -- 016-8548-6547
����ȯ -- 011-5555-7548
ȫ���� -- 011-7777-7777
���� -- 017-3333-3333
�긶�� -- 018-0505-0505
�̱�� -- 
�̹̼� -- 010-6654-8854
�̹��� -- 011-8585-5252
�ǿ��� -- 011-5555-7548
�ǿ��� -- 010-3644-5577
��̽� -- 011-7585-7474
����ȣ -- 016-1919-4242
���ѳ� -- 016-2424-4242
������ -- 010-7549-8654
�̹̰� -- 016-6542-7546
����� -- 010-2415-5444
�Ӽ��� -- 011-4151-4154
��ž� -- 011-4151-4444


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

/*
�Ϲ� ���� �� ����
���� ���� �� ����

������ Ÿ��
���ܺ����� Ÿ��
Ŀ���� CURSOR (��)

Ŀ�� �� ����

TABLE ���̺���
INDEX �ε�����
USER ����ڸ�
CURSOR Ŀ���� (��)
*/

--�� Ŀ�� �̿� �� ��Ȳ
DECLARE
    -- �ֿ� ���� ����
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
    
    -- Ŀ�� �̿��� ���� Ŀ�� ����  CHECK~!!!
    CURSOR CUR_INSA_SELECT -- Ŀ�� Ŀ����
    IS 
    SELECT NAME, TEL
    FROM TBL_INSA;
    
BEGIN
    -- Ŀ�� ����
    OPEN CUR_INSA_SELECT;
    
    -- Ŀ�� ���� �� ����������� �����͵� ó��(�ݺ����� Ȱ���Ͽ� ó��)
    -- Ŀ�� �����ϸ� �����Ͱ� �;�!!!!!!!!!!!!!!!!!!!!�ϰ� ����� ���´�
    LOOP
        -- �� �� �� �� �޾ƴٰ� ó���ϴ� ���� �� ��������(��������) �� ��FETCH��
        FETCH CUR_INSA_SELECT INTO V_NAME, V_TEL;
        
        -- Ŀ������ �� �̻� �����Ͱ� ����� ������ �ʴ� ���� ... ��NOTFOUND��
        EXIT WHEN CUR_INSA_SELECT%NOTFOUND; -- �鿩�� �� �� % �ۼ�Ʈ ���� / ������ �� / ��� �ʸ� ������ ��
        
        -- ���
        DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
        
    END LOOP;
    
    -- Ŀ�� Ŭ����
    CLOSE CUR_INSA_SELECT;
END;
--==>>
/*
������ -- 010-8624-4533
ȫ�浿 -- 011-2356-4528
�̼��� -- 010-4758-6532
�̼��� -- 010-4231-1236
������ -- 019-5236-4221
�Ѽ��� -- 018-5211-3542
�̱��� -- 010-3214-5357
����ö -- 011-2345-2525
�迵�� -- 016-2222-4444
������ -- 019-1111-2222
������ -- 011-3214-5555
������ -- 010-8888-4422
���ѱ� -- 018-2222-4242
���̼� -- 019-6666-4444
Ȳ���� -- 010-3214-5467
������ -- 016-2548-3365
�̻��� -- 010-4526-1234
����� -- 010-3254-2542
�̼��� -- 018-1333-3333
�ڹ��� -- 017-4747-4848
������ -- 011-9595-8585
ȫ�泲 -- 011-9999-7575
�̿��� -- 017-5214-5282
���μ� -- 
�踻�� -- 011-5248-7789
����� -- 010-4563-2587
����� -- 010-2112-5225
�迵�� -- 019-8523-1478
�̳��� -- 016-1818-4848
�踻�� -- 016-3535-3636
������ -- 019-6564-6752
����ȯ -- 019-5552-7511
�ɽ��� -- 016-8888-7474
��̳� -- 011-2444-4444
������ -- 011-3697-7412
������ -- 
���翵 -- 011-9999-9999
�ּ��� -- 011-7777-7777
���μ� -- 010-6542-7412
������ -- 010-2587-7895
�ڼ��� -- 016-4444-7777
����� -- 016-4444-5555
ä���� -- 011-5125-5511
��̿� -- 016-8548-6547
����ȯ -- 011-5555-7548
ȫ���� -- 011-7777-7777
���� -- 017-3333-3333
�긶�� -- 018-0505-0505
�̱�� -- 
�̹̼� -- 010-6654-8854
�̹��� -- 011-8585-5252
�ǿ��� -- 011-5555-7548
�ǿ��� -- 010-3644-5577
��̽� -- 011-7585-7474
����ȣ -- 016-1919-4242
���ѳ� -- 016-2424-4242
������ -- 010-7549-8654
�̹̰� -- 016-6542-7546
����� -- 010-2415-5444
�Ӽ��� -- 011-4151-4154
��ž� -- 011-4151-4444


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

-- ó���� �� ���� ���� �Է����� �ʾƵ� �ȴ�.

--------------------------------------------------------------------------------

--���� TRIGGER(Ʈ����) ����--
-- Ʈ���Ŵ� �ݰ� ���� �� �ٿ� ���� �κ�Ʈ�� ���� ��!!!
-- Ư���� ��Ȳ�� ���� �� �������� ����� ��
-- �����ؼ� ���� �� -> �������� ���̺��� ������ ��ó��

-- �������� �ǹ� : ��Ƽ�, �˹߽�Ű��, �߱��ϴ�, �����ϴ�.

-- 1. TRIGGER(Ʈ����)�� DML �۾� ��, INSERT, UPDATE, DELETE �۾��� �Ͼ ��
--    �ڵ������� ����Ǵ�(���ߵǴ�, �˹ߵǴ�) ��ü��
--    �̿� ���� Ư¡�� �����Ͽ� DML TRIGGER ��� �θ��⵵ �Ѵ�.
--    TRIGGER �� ���Ἲ �� �ƴ϶�
--    ������ ���� �۾����� �θ� ���ȴ�.

--  �ڵ����� �Ļ��� �� �� ���� --> ����(Ʈ����)�� ���� �ֵ� �̸� ������� ��
--  �߸��� Ʈ����� ���� --> INSERT�� �ִ� ��?
--  ������ ���� ���� ���� ���� --> �ٹ� �ð����� �ֽ� ����Ʈ �� �ϰ� ��Ʈ��ũ ó��
--  �л� �����ͺ��̽� ��� �󿡼� ���� ���Ἲ ���� ���� --> EMP�� �� PC��, DEPT�� ������  
--  ������ ���� ��Ģ ���� ���� --> (�߸��� Ʈ����� ����)
--  ������ �̺�Ʈ �α� ���� --> �츮 �� ����̸� �ٸ��� ���� �ش� --> �ٸ��� �α� / � ���� �Ͼ���� ��� ���
--  ������ ���� ���� 
--  ���� ���̺� ���� �������� --> ������ ������ ������ �� �� �Ȱ��� INSERT �ǵ���
--  ���̺� �׼��� ��� ���� --> �̺�Ʈ �α�...�� ����� ����

-- 2. TRIGGER(Ʈ����) �������� COMMIT, ROLLBACK ���� ����� �� ����.
--> ��? --> INSERT DELETE UPDATE�� ����ڰ� ���� ���� ��  

-- 3. Ư¡ �� ����
--    - BEFORE STATEMENT -- INSERT ��ų �� ���� �̸� ���� --> �� �ٸ�
--    - BEFORE ROW 
--    - AFTER STATEMENT -- ���� �Ŀ� �̸��� ���� �� �ִ�
--    - AFTER ROW

-- 4. ���� �� ����
/*
CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
    [BEFORE | AFTER]
    �̺�Ʈ1 [OR �̺�Ʈ2 [OR �̺�Ʈ 3]] ON ���̺���
    [FOR EACH ROW [WHEN TRIGGER ����]]
[DECLARE]
    -- ���� ����;
BEGIN
    -- ���� ����;
END;
*/

--���� AFTER STATEMENT TRIGGER ��Ȳ �ǽ� ����--
-- �� DML �۾��� ���� �̺�Ʈ ���

--�� TRIGGER(Ʈ����) ���� �� TRG_EVENTLOG
CREATE OR REPLACE TRIGGER TRG_EVENTLOG
    AFTER 
    INSERT OR UPDATE OR DELETE ON TBL_TEST1 -- ���� ��� 
-- DECLARE --> ����
BEGIN
    -- �̺�Ʈ ���� ����(���ǹ��� ���� �б�)
    IF (INSERTING) -- ���ǵǾ� �ִ� �����
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
             VALUES('INSERT ������ ����Ǿ����ϴ�.');
    ELSIF (UPDATING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
             VALUES('UPDATE ������ ����Ǿ����ϴ�.');
    ELSIF (DELETING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
             VALUES('DELETE ������ ����Ǿ����ϴ�.');
    END IF;
    
    -- COMMIT;
    -- �� TRIGGER �������� COMMIT / ROLLBACK ���� ��� �Ұ�~!!! CHECK~!!!
END;
--==>> Trigger TRG_EVENTLOG��(��) �����ϵǾ����ϴ�.


--���� BEFORE STATEMENT TRIGGER ��Ȳ �ǽ� ����--
--�� DML �۾� ���� ���� �۾��� ���� ���� ���� Ȯ��

--�� TRIGGER(Ʈ����) ���� �� TRG_TEST1_DML
CREATE OR REPLACE TRIGGER TRG_TEST1_DML
        BEFORE 
        INSERT OR UPDATE OR DELETE ON TBL_TEST1 -- ���� ���
--DECLARE --> ����
BEGIN
    IF ( �۾��ð��� ���� 9�� �����̰ų�... ���� 6�� ���Ķ��... )
        THEN �۾��� �������� ���ϵ��� ó���ϰڴ�.
    END IF;
END;


CREATE OR REPLACE TRIGGER TRG_TEST1_DML
        BEFORE 
        INSERT OR UPDATE OR DELETE ON TBL_TEST1 -- ���� ���
--DECLARE --> ����
BEGIN
    IF ( TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) < 9 �̰ų�... TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) > 17 ���... )
        THEN �۾��� �������� ���ϵ��� ó���ϰڴ�.
    END IF;
END;        
       
        
CREATE OR REPLACE TRIGGER TRG_TEST1_DML
        BEFORE 
        INSERT OR UPDATE OR DELETE ON TBL_TEST1 -- ���� ���
--DECLARE --> ����
BEGIN
    IF ( TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) < 9 OR TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) > 17 )
        THEN ����� ���� ���ܸ� �߻���ų �� �ֵ��� �ϰڴ�.
    END IF;
END; 


CREATE OR REPLACE TRIGGER TRG_TEST1_DML
        BEFORE 
        INSERT OR UPDATE OR DELETE ON TBL_TEST1 -- ���� ���
--DECLARE --> ����
BEGIN
    IF ( TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) < 9 OR TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) > 17 ) -- ����Ŭ ������ �ð�
        THEN RAISE_APPLICATION_ERROR(-20003, '�۾��� 09:00 ~ 18:00 ������ �����մϴ�.');
    END IF;
END; 
--==>> Trigger TRG_TEST1_DML��(��) �����ϵǾ����ϴ�.


--���� BEFORE ROW TRIGGER ��Ȳ �ǽ� ����--
-- �� ���� ���谡 ������ ������(�ڽ�) ������ ���� �����ϴ� ��

-- �θ� ���̺��� ���ڵ带 �����ϴ� �� ������
-- �ڽ� ���̺��� �����ϴ� ���ڵ带 ���� ���� ���ſ� �����ؾ� �ϴϱ� ����
-- �ڽ� ���̺��� ��� ������ �ƴ϶� ���ڵ� �����ϱ� �ο�
--�� TRIGGER(Ʈ����) ���� �� TRG_TEST2_DELETE
CREATE OR REPLACE TRIGGER TRG_TEST2_DELETE
        BEFORE -- �׼Ǻ��� �� �� �ռ��� ����
        DELETE ON TBL_TEST2 -- �θ����̺��� DELETE �׼��� �������� ��
        FOR EACH ROW -- �� �ɼ��� �־�� ROW Ʈ���� / ������ �࿡ ���ؼ� ó��
BEGIN -- �����ϴ� ����
    DELETE 
    FROM TBL_TEST3 -- �ڽ� ���̺�
    WHERE CODE = :OLD.CODE; -- ���� �������� ���ŷ� ���� � �ڵ����� Ȯ���ϰ� ���� �� / �����ϱ� ���� �ڷ�(������ �ڷ�)
END;
--==>> Trigger TRG_TEST2_DELETE��(��) �����ϵǾ����ϴ�.


--�� ��:OLD��
--   ���� �� ���� ��
--   (INSERT : �Է��ϱ� ���� �ڷ�, DELETE : �����ϱ� ���� �ڷ� ��, ������ �ڷ�)

-- ������� �ҽ�!!!!!! ����Ŭ ���������δ� UPDATE�� ����!!!! UPDATE�� ����������
-- DELETE�ϰ� INSERT�ϴ� ���̴�!!! �����!!!

--�� UPDATE : ���������� DELETE �׸��� INSERT �� ���յ� ����
--            UPDATE �ϱ� ������ �����ʹ� ��:OLD��
--            UPDATE ������ ������ �����ʹ� ��:NEW��


--------------------------------------------------------------------------------

--���� AFTER ROW TRIGGER ��Ȳ �ǽ� ����--
--�� ���� ���̺� ���� Ʈ����� ó��

-- TBL_�԰�, TBL_��ǰ, TBL_���

--�� TBL_�԰� ���̺��� ������ �Է� ��(��, �԰� �̺�Ʈ �߻� ��)
--   TBL_��ǰ ���̺��� ������� ���� Ʈ���� �ۼ�
--   Ʈ���� �� : TRG_IBGO

CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER 
        INSERT ON TBL_�԰�
        FOR EACH ROW -- �� Ʈ����
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������� = ������� + �����԰��Ǵ��԰�����
             WHERE ��ǰ�ڵ� = �����԰��Ǵ»�ǰ�ڵ�;
    END IF;
END;


CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER 
        INSERT ON TBL_�԰�
        FOR EACH ROW -- �� Ʈ����
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������� = ������� + :NEW.�԰�����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    END IF;
END;
--==>> Trigger TRG_IBGO��(��) �����ϵǾ����ϴ�.


--�� TBL_�԰� ���̺��� ������ �Է�, ����, ���� ��
--   TBL_��ǰ ���̺��� ������� ���� Ʈ���� �ۼ�
--   Ʈ���� �� : TRG_IBGO
CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER 
        INSERT OR UPDATE OR DELETE ON TBL_�԰�
        FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������� = ������� + :NEW.�԰�����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    ELSIF (UPDATING)
        THEN UPDATE TBL_��ǰ
             SET ������� = ������� - :OLD.�԰����� + :NEW.�԰�����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    ELSIF (DELETING)
        THEN UPDATE TBL_��ǰ
             SET ������� = ������� - :OLD.�԰�����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    END IF;
END;

















