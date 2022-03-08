SELECT USER
FROM DUAL;
--==>> SCOTT

--�� IF ��(���ǹ�)
-- IF ~ THEN ~ ELSE ~ END IF;

-- 1. PL/SQL �� IF ������ �ٸ� ����� IF ���ǹ��� ���� �����ϴ�.
--    ��ġ�ϴ� ���ǿ� ���� ���������� �۾��� ������ �� �ֵ��� �Ѵ�.
--    TRUE �̸� THEN �� ELSE ������ ������ �����ϰ�
--    FALSE �� NULL �̸� ELSE �� END IF; ������ ������ �����ϰ� �ȴ�.

-- 2. ���� �� ����
/*
IF ����       -- IF �����ߴ�
    THEN ó����;
END IF;       -- IF ������
*/

/*
IF ����
    THEN ó����;
ELSE 
    ó����;
END IF;
*/

/*
IF ����
    THEN ó����;
ELSIF ����
    THEN ó����;
ELSIF ����
    THEN ó����;
ELSE 
    ó����;
END IF;
*/

SET SERVEROUTPUT ON;

--�� ������ ������ ���� �����ϰ� ����ϴ� ���� �ۼ�
DECLARE
    GRADE CHAR;
BEGIN
    GRADE := 'C';
    
    --DBMS_OUTPUT.PUT_LINE(GRADE);
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('EXCELLENT');
    ELSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('BEST');
    ELSIF GRADE = 'C'
        THEN DBMS_OUTPUT.PUT_LINE('COOL');
    ELSE
        DBMS_OUTPUT.PUT_LINE('FAIL');
    END IF;
END;


--�� CASE �� -- �ڹٿ��� ����ߴ� SWITCH�� �����ϱ�
-- CASE ~ WHEN ~ THEN ~ ELSE ~ END CASE;

-- 1. ���� �� ����
/*
CASE ����
    WHEN ��1 THEN ���๮;
    WHEN ��2 THEN ���๮;
    ELSE ���๮;
END CASE;
*/

-- ACCEPT�� ������ �ܺ� �Է°��� �޾Ƶ��̰ڴ� 
-- NUM�̶�� ������ ������ ��Ƴ��ڴ�
-- PROMPT ���ڴ�
ACCEPT NUM PROMPT '����1 ����2 �Է��ϼ���';

DECLARE
    -- �ֿ� ���� ����
    SEL NUMBER := &NUM; -- NUM�� ����ִ� ���� ���η� ������� �� / TEMP�� &TEMP / INPUT�̸� &INPUT
    RESULT VARCHAR2(10) := '����';
BEGIN
    -- �׽�Ʈ
    --DBMS_OUTPUT.PUT_LINE('SEL : ' || SEL);
    --DBMS_OUTPUT.PUT_LINE('RESULT : ' || RESULT);
    
    -- ���� �� ó��
    /*
    CASE SEL
        WHEN 1
        THEN DBMS_OUTPUT.PUT_LINE('�����Դϴ�.');
        WHEN 2
        THEN DBMS_OUTPUT.PUT_LINE('�����Դϴ�.');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('Ȯ�κҰ�');
    END CASE;
    */
    
    CASE SEL
        WHEN 1
        THEN RESULT := '����';
        WHEN 2
        THEN RESULT := '����';
        ELSE
            RESULT := 'Ȯ�κҰ�';
    END CASE;
    
    -- ��� ���
    DBMS_OUTPUT.PUT_LINE('ó�� ����� ' || RESULT || '�Դϴ�.');
END;

--�� �ܺ� �Է� ó��
-- ACCEPT ����
-- ACCEPT ������ PROMPT '�޼���';
--> �ܺ� �����κ��� �Է¹��� �����͸� ���� ������ ������ ��
-- ��&�ܺκ����� ���·� �����ϰ� �ȴ�.

--------------------------------------------------------------------------------

--�� ���� 2���� �ܺηκ���(����ڷκ���) �Է¹޾�
--   �̵��� ���� ����� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.

-- �� Ǯ��
ACCEPT NUM1 PROMPT 'ù ��° ���� �Է��ϼ���';
ACCEPT NUM2 PROMPT '�� ��° ���� �Է��ϼ���';

DECLARE
    N1 NUMBER := &NUM1;
    N2 NUMBER := &NUM2;
    RESULT NUMBER;
BEGIN
    RESULT := N1 + N2;
    DBMS_OUTPUT.PUT_LINE('ó�� ����� ' || RESULT || '�Դϴ�.');
END;

-- ���� Ǯ�� 
ACCEPT N1 PROMPT 'ù ��° ������ �Է��ϼ���';
ACCEPT N2 PROMPT 'ù ��° ������ �Է��ϼ���';

DECLARE
    -- �ֿ� ���� ����
    NUM1 NUMBER := &N1;
    NUM2 NUMBER := &N2;
    TOTAL NUMBER := 0;
BEGIN
    -- �׽�Ʈ
    --DBMS_OUTPUT.PUT_LINE('NUM1 : ' || NUM1);
    --DBMS_OUTPUT.PUT_LINE('NUM2 : ' || NUM2);
    
    -- ���� �� ó��
    TOTAL := NUM1 + NUM2;
    
    -- ��� ���
    DBMS_OUTPUT.PUT_LINE(NUM1 || ' + ' || NUM2 || ' = ' || TOTAL);
END;
--==>>
/*
60 + 4020 = 4080


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

--�� ����ڷκ��� �Է¹��� �ݾ��� ȭ������� �����Ͽ� ����ϴ� ���α׷��� �ۼ��Ѵ�.
--   ��, ��ȯ �ݾ��� ���ǻ� 1õ�� �̸�, 10�� �̻� �����ϴٰ� �����Ѵ�.
/*
���� ��)
���ε� ���� �Է� ��ȭâ �� �ݾ� �Է� : 990

�Է¹��� �ݾ� �Ѿ� : 990��
ȭ����� : ����� 1, ��� 4, ���ʿ� 1, �ʿ� 4
*/

-- �� Ǯ�� 
ACCEPT N1 PROMPT '�ݾ� �Է�';

DECLARE
    NUM NUMBER := &N1;
    RES1 NUMBER := 0;
    RES2 NUMBER := 0;
    RES3 NUMBER := 0;
    RES4 NUMBER := 0;
BEGIN
    IF NUM / 500 >= 1
        THEN RES1 := NUM / 500;
    ELSIF (NUM % 500) / 100 >= 1 
        THEN RES2 := (NUM % 500) / 100;
    ELSIF ((NUM % 500) % 100) / 50 >= 1 
        THEN RES3 := ((NUM % 500) % 100) / 50;
    ELSIF (((NUM % 500) % 100) & 50) / 10 >= 1 
        THEN RES4 := (((NUM % 500) % 100) & 50) / 10;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Ȯ�� �Ұ�');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('ȭ����� : ����� ' || RES1 || ', ���' || RES2 || ', ���ʿ�' || RES3 || ', �ʿ�' || RES4);
END;


ACCEPT N1 PROMPT '�ݾ� �Է�';

DECLARE
    NUM NUMBER := &N1;
    RES1 NUMBER := 0;
    RES2 NUMBER := 0;
    RES3 NUMBER := 0;
    RES4 NUMBER := 0;
    --TEMP NUMBER := 0;
BEGIN
    IF NUM / 500 >= 1
        THEN RES1 := NUM / 500;
    END IF;
    IF (NUM-500*TRUNC(RES1)) / 100 >= 1
        THEN RES2 := (NUM-500*TRUNC(RES1)) / 100;
    END IF;
    IF (NUM-(500*TRUNC(RES1))-(100*TRUNC(RES2))) / 50 >= 1
        THEN RES3 := (NUM-(500*TRUNC(RES1))-(100*TRUNC(RES2))) / 50;
    END IF;
    DBMS_OUTPUT.PUT_LINE('ȭ����� : ����� ' || TRUNC(RES1) || ', ��� ' || TRUNC(RES2) || ', ���ʿ� ' || TRUNC(RES3));
END;

-- ���� Ǯ�� 
ACCEPT INPUT PROMPT '�ݾ� �Է�';
DECLARE
    -- �� �ֿ� ���� ����
    MONEY   NUMBER := &INPUT;   -- ������ ���� �Է°��� ��Ƶ� ����
    MONEY2  NUMBER := &INPUT;   -- ��� ����� ���� �Է°��� ��Ƶ� ����
                                -- (MONEY ������ ������ ó���ϴ� �������� ���� �޶����� �����̴�.)
    
    M500    NUMBER;             -- 500�� ¥�� ������ ��Ƶ� ����
    M100    NUMBER;             -- 100�� ¥�� ������ ��Ƶ� ����
    M50     NUMBER;             --  50�� ¥�� ������ ��Ƶ� ����
    M10     NUMBER;             --  10�� ¥�� ������ ��Ƶ� ����
BEGIN
    --�� ���� �� ó��
    -- MOMEY�� 500���� ������ ���� ���ϰ� �������� ������. �� 500���� ����
    M500 := TRUNC(MONEY / 500);
    
    -- MONEY�� 500���� ������ ���� ������ �������� ���Ѵ�. �� 500���� ���� Ȯ���ϰ� ���� �ݾ�
    MONEY := MOD(MONEY, 500);
    
    -- MONEY�� 100���� ������ ���� ���ϰ� �������� ������ �� 100���� ����
    M100 := TRUNC(MONEY / 100);
    
    --MONEY�� 100���� ������ ���� ������ �������� ���Ѵ� �� 100���� ���� Ȯ���ϰ� ���� ���� Ȯ��
    MONEY := MOD(MONEY, 100);
    
    -- MONEY �� 50���� ������ ���� ���ϰ� �������� ������. �� 50���� ����
    M50 := TRUNC(MONEY / 50);
    
    -- MONEY�� 50���� ������ ���� ������ �������� ���Ѵ� �� 50���� ���� Ȯ���ϰ� ���� �ݾ� Ȯ��
    MONEY := MOD(MONEY, 50);
    
    -- MONEY�� 10���� ������ ���� ���ϰ� �������� ������ �� 10���� ����
    M10 := TRUNC(MONEY / 10);
    
    --�� ��� ���
    -- ���յ� ���(ȭ������� ����)�� ���Ŀ� �°� ���� ����Ѵ�.
    --    DBMS_OUTPUT.PUT_LINE('�Է¹��� �ݾ� �Ѿ� :990��');
    DBMS_OUTPUT.PUT_LINE('�Է¹��� �ݾ� �Ѿ� : ' || MONEY2 || '��');
    DBMS_OUTPUT.PUT_LINE('ȭ����� : ����� ' || M500 || ', ��� ' || M100 || ', ���ʿ� ' || M50 || ', �ʿ� ' || M10);
END;


--�� �⺻ �ݺ���
-- LOOP ~ END LOOP;

-- 1. ���ǰ� ������� ������ �ݺ��ϴ� ����.

-- 2. ���� �� ����
/*
LOOP
    -- ���๮
    
    EXIT WHEN ����;   -- ������ ���� ��� �ݺ����� ����������. / BREAK ó��
END LOOP;
*/

-- 1 ���� 10 ������ �� ��� (LOOP �� Ȱ��)
DECLARE 
    N NUMBER;
BEGIN
    N := 1;
    
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        
        EXIT WHEN N>=10;
        
        N := N + 1;             -- ��N++��, ��N+=��;
        
    END LOOP;
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

--�� WHILE �ݺ���
-- WHILE LOOP ~ END LOOP;

-- 1. ���� ������ TRUE �� ���� �Ϸ��� ������ �ݺ��ϱ� ����
--    WHILE LOOP ������ ����Ѵ�.
--    ������ �ݺ��� ���۵Ǵ� ������ üũ�ϰ� �Ǿ�
--    LOOP ���� ������ �� ���� ������� ���� ��쵵 �ִ�.
--    LOOP �� ������ �� ������ FALSE �̸� �ݺ� ������ Ż���ϰ� �ȴ�.

-- 2. ���� �� ����
/*
WHILE ���� LOOP       -- ������ ���� ��� �ݺ� ����
END LOOP;
*/

-- 1 ���� 10 ������ �� ��� (WHILE LOOP �� Ȱ��)
DECLARE
    N NUMBER;
BEGIN
    N := 0;
    WHILE N<10 LOOP
        N := N + 1;
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� FOR �ݺ���
-- FOR LOOP ~ END LOOP;

-- 1. �����ۼ������� 1�� �����Ͽ�
--    ������������ �� ������ �ݺ� �����Ѵ�.

-- 2. ���� �� ����
/*
FOR ī���� IN [REVERSE] ���ۼ� .. ������ LOOP
    -- ���๮;
END LOOP;
*/

-- 1 ���� 10 ������ �� ��� (FOR LOOP �� Ȱ��)
DECLARE
    N   NUMBER;
BEGIN
    FOR N IN 1.. 10 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

--�� ����ڷκ��� ������ ��(������)�� �Է¹޾�
--   �ش� �ܼ��� �������� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.
/*
���� ��)
���ε� ���� �Է� ��ȭâ �� ���� �Է��ϼ��� : 2

2 * 1 = 2
2 * 2 = 4
2 * 3 = 6
    :
2 * 9 = 18
*/

-- 1. LOOP ���� ���
ACCEPT INPUT PROMPT '���� �Է��ϼ���';
DECLARE
    NUM NUMBER := &INPUT;
    N NUMBER;
BEGIN
    N := 1;
    
    LOOP
        DBMS_OUTPUT.PUT_LINE(NUM || ' * ' || N || ' = ' || NUM * N);
        
        EXIT WHEN N >= 9;
        
        N := N + 1;            
        
    END LOOP;
END;


-- 2. WHILE LOOP ���� ���
ACCEPT INPUT PROMPT '���� �Է��ϼ���';
DECLARE
    NUM NUMBER := &INPUT;
    N NUMBER;
BEGIN
    N := 0;
    WHILE N < 9 LOOP
        N := N + 1;
        DBMS_OUTPUT.PUT_LINE(NUM || ' * ' || N || ' = ' || NUM * N);
    END LOOP;
END;

-- 3. FOR LOOP ���� ���
ACCEPT INPUT PROMPT '���� �Է��ϼ���';
DECLARE
    NUM NUMBER := &INPUT;
    N NUMBER;
BEGIN
    FOR N IN 1.. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(NUM || ' * ' || N || ' = ' || NUM * N);
    END LOOP;
END;

--==>>
/*
3 * 1 = 3
3 * 2 = 6
3 * 3 = 9
3 * 4 = 12
3 * 5 = 15
3 * 6 = 18
3 * 7 = 21
3 * 8 = 24
3 * 9 = 27


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� ������ ��ü(2�� ~ 9��)�� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.
--   ��, ���� �ݺ���(�ݺ����� ��ø) ������ Ȱ���Ѵ�.
/*
���� ��)

==[ 2�� ]==
2 * 1 = 2
    :
==[ 3�� ]==
    :
9 * 9 = 81
*/

-- �� Ǯ��
DECLARE
    I NUMBER;
    J NUMBER;
BEGIN
    I := 2;
    J := 1;
    
    FOR I IN 2 .. 9
    LOOP
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('==[ ' || I || '�� ]==');
        -- �ݺ��� ��ø
        FOR J IN 1 .. 9
        LOOP
            DBMS_OUTPUT.PUT_LINE(I || ' * ' || J || ' = ' || I * J);
        END LOOP;
    END LOOP;
END;


-- ���� Ǯ��
DECLARE
    N NUMBER;
    M NUMBER;
BEGIN
    FOR N IN 2 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('==[ ' || N || '�� ]==');
        
        FOR M IN 1 .. 9 LOOP
            DBMS_OUTPUT.PUT_LINE(N || ' * ' || M || ' = ' || N * M);
        END LOOP;
        
    END LOOP;
END;
--==>>
/*
==[ 2�� ]==
2 * 1 = 2
2 * 2 = 4
2 * 3 = 6
2 * 4 = 8
2 * 5 = 10
2 * 6 = 12
2 * 7 = 14
2 * 8 = 16
2 * 9 = 18

==[ 3�� ]==
3 * 1 = 3
3 * 2 = 6
3 * 3 = 9
3 * 4 = 12
3 * 5 = 15
3 * 6 = 18
3 * 7 = 21
3 * 8 = 24
3 * 9 = 27

==[ 4�� ]==
4 * 1 = 4
4 * 2 = 8
4 * 3 = 12
4 * 4 = 16
4 * 5 = 20
4 * 6 = 24
4 * 7 = 28
4 * 8 = 32
4 * 9 = 36

==[ 5�� ]==
5 * 1 = 5
5 * 2 = 10
5 * 3 = 15
5 * 4 = 20
5 * 5 = 25
5 * 6 = 30
5 * 7 = 35
5 * 8 = 40
5 * 9 = 45

==[ 6�� ]==
6 * 1 = 6
6 * 2 = 12
6 * 3 = 18
6 * 4 = 24
6 * 5 = 30
6 * 6 = 36
6 * 7 = 42
6 * 8 = 48
6 * 9 = 54

==[ 7�� ]==
7 * 1 = 7
7 * 2 = 14
7 * 3 = 21
7 * 4 = 28
7 * 5 = 35
7 * 6 = 42
7 * 7 = 49
7 * 8 = 56
7 * 9 = 63

==[ 8�� ]==
8 * 1 = 8
8 * 2 = 16
8 * 3 = 24
8 * 4 = 32
8 * 5 = 40
8 * 6 = 48
8 * 7 = 56
8 * 8 = 64
8 * 9 = 72

==[ 9�� ]==
9 * 1 = 9
9 * 2 = 18
9 * 3 = 27
9 * 4 = 36
9 * 5 = 45
9 * 6 = 54
9 * 7 = 63
9 * 8 = 72
9 * 9 = 81


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/





















