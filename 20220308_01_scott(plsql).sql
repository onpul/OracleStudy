SELECT USER
FROM DUAL;
--==>> SCOTT

--○ IF 문(조건문)
-- IF ~ THEN ~ ELSE ~ END IF;

-- 1. PL/SQL 의 IF 문장은 다른 언어의 IF 조건문과 거의 유사하다.
--    일치하는 조건에 따라 선택적으로 작업을 수행할 수 있도록 한다.
--    TRUE 이면 THEN 과 ELSE 사이의 문장을 수행하고
--    FALSE 나 NULL 이면 ELSE 와 END IF; 사이의 문장을 수행하게 된다.

-- 2. 형식 및 구조
/*
IF 조건       -- IF 시작했다
    THEN 처리문;
END IF;       -- IF 끝났다
*/

/*
IF 조건
    THEN 처리문;
ELSE 
    처리문;
END IF;
*/

/*
IF 조건
    THEN 처리문;
ELSIF 조건
    THEN 처리문;
ELSIF 조건
    THEN 처리문;
ELSE 
    처리문;
END IF;
*/

SET SERVEROUTPUT ON;

--○ 변수에 임의의 값을 대입하고 출력하는 구문 작성
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


--○ CASE 문 -- 자바에서 사용했던 SWITCH문 생각하기
-- CASE ~ WHEN ~ THEN ~ ELSE ~ END CASE;

-- 1. 형식 및 구조
/*
CASE 변수
    WHEN 값1 THEN 실행문;
    WHEN 값2 THEN 실행문;
    ELSE 실행문;
END CASE;
*/

-- ACCEPT가 나오면 외부 입력값을 받아들이겠다 
-- NUM이라는 임의의 변수로 담아내겠다
-- PROMPT 띄우겠다
ACCEPT NUM PROMPT '남자1 여자2 입력하세요';

DECLARE
    -- 주요 변수 선언
    SEL NUMBER := &NUM; -- NUM에 들어있는 값을 내부로 끌어오는 거 / TEMP면 &TEMP / INPUT이면 &INPUT
    RESULT VARCHAR2(10) := '남자';
BEGIN
    -- 테스트
    --DBMS_OUTPUT.PUT_LINE('SEL : ' || SEL);
    --DBMS_OUTPUT.PUT_LINE('RESULT : ' || RESULT);
    
    -- 연산 및 처리
    /*
    CASE SEL
        WHEN 1
        THEN DBMS_OUTPUT.PUT_LINE('남자입니다.');
        WHEN 2
        THEN DBMS_OUTPUT.PUT_LINE('여자입니다.');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('확인불가');
    END CASE;
    */
    
    CASE SEL
        WHEN 1
        THEN RESULT := '남자';
        WHEN 2
        THEN RESULT := '여자';
        ELSE
            RESULT := '확인불가';
    END CASE;
    
    -- 결과 출력
    DBMS_OUTPUT.PUT_LINE('처리 결과는 ' || RESULT || '입니다.');
END;

--※ 외부 입력 처리
-- ACCEPT 구문
-- ACCEPT 변수명 PROMPT '메세지';
--> 외부 변수로부터 입력받은 데이터를 내부 변수에 전달할 때
-- 『&외부변수명』 형태로 접근하게 된다.

--------------------------------------------------------------------------------

--○ 정수 2개를 외부로부터(사용자로부터) 입력받아
--   이들의 덧셈 결과를 출력하는 PL/SQL 구문을 작성한다.

-- 내 풀이
ACCEPT NUM1 PROMPT '첫 번째 정수 입력하세요';
ACCEPT NUM2 PROMPT '두 번째 정수 입력하세요';

DECLARE
    N1 NUMBER := &NUM1;
    N2 NUMBER := &NUM2;
    RESULT NUMBER;
BEGIN
    RESULT := N1 + N2;
    DBMS_OUTPUT.PUT_LINE('처리 결과는 ' || RESULT || '입니다.');
END;

-- 수업 풀이 
ACCEPT N1 PROMPT '첫 번째 정수를 입력하세요';
ACCEPT N2 PROMPT '첫 번째 정수를 입력하세요';

DECLARE
    -- 주요 변수 선언
    NUM1 NUMBER := &N1;
    NUM2 NUMBER := &N2;
    TOTAL NUMBER := 0;
BEGIN
    -- 테스트
    --DBMS_OUTPUT.PUT_LINE('NUM1 : ' || NUM1);
    --DBMS_OUTPUT.PUT_LINE('NUM2 : ' || NUM2);
    
    -- 연산 및 처리
    TOTAL := NUM1 + NUM2;
    
    -- 결과 출력
    DBMS_OUTPUT.PUT_LINE(NUM1 || ' + ' || NUM2 || ' = ' || TOTAL);
END;
--==>>
/*
60 + 4020 = 4080


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

--○ 사용자로부터 입력받은 금액을 화폐단위로 구분하여 출력하는 프로그램을 작성한다.
--   단, 반환 금액은 편의상 1천원 미만, 10원 이상만 가능하다고 가정한다.
/*
실행 예)
바인딩 변수 입력 대화창 → 금액 입력 : 990

입력받은 금액 총액 : 990원
화폐단위 : 오백원 1, 백원 4, 오십원 1, 십원 4
*/

-- 내 풀이 
ACCEPT N1 PROMPT '금액 입력';

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
        DBMS_OUTPUT.PUT_LINE('확인 불가');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('화폐단위 : 오백원 ' || RES1 || ', 백원' || RES2 || ', 오십원' || RES3 || ', 십원' || RES4);
END;


ACCEPT N1 PROMPT '금액 입력';

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
    DBMS_OUTPUT.PUT_LINE('화폐단위 : 오백원 ' || TRUNC(RES1) || ', 백원 ' || TRUNC(RES2) || ', 오십원 ' || TRUNC(RES3));
END;

-- 수업 풀이 
ACCEPT INPUT PROMPT '금액 입력';
DECLARE
    -- ○ 주요 변수 선언
    MONEY   NUMBER := &INPUT;   -- 연산을 위해 입력값을 담아둘 변수
    MONEY2  NUMBER := &INPUT;   -- 결과 출력을 위해 입력값을 담아둘 변수
                                -- (MONEY 변수가 연산을 처리하는 과정에서 값이 달라지기 때문이다.)
    
    M500    NUMBER;             -- 500원 짜리 갯수를 담아둘 변수
    M100    NUMBER;             -- 100원 짜리 갯수를 담아둘 변수
    M50     NUMBER;             --  50원 짜리 갯수를 담아둘 변수
    M10     NUMBER;             --  10원 짜리 갯수를 담아둘 변수
BEGIN
    --○ 연산 및 처리
    -- MOMEY를 500으로 나눠서 몫을 취하고 나머지는 버린다. → 500원의 갯수
    M500 := TRUNC(MONEY / 500);
    
    -- MONEY를 500으로 나눠서 몫은 버리고 나머지를 취한다. → 500원의 갯수 확인하고 남은 금액
    MONEY := MOD(MONEY, 500);
    
    -- MONEY를 100으로 나눠서 몫을 취하고 나머지는 버린다 → 100원의 갯수
    M100 := TRUNC(MONEY / 100);
    
    --MONEY를 100으로 나눠서 몫은 버리고 나머지를 취한다 → 100원의 갯수 확인하고 남은 갯수 확인
    MONEY := MOD(MONEY, 100);
    
    -- MONEY 를 50으로 나눠서 몫을 취하고 나머지는 버린다. → 50원의 갯수
    M50 := TRUNC(MONEY / 50);
    
    -- MONEY를 50으로 나눠서 몫은 버리고 나머지를 취한다 → 50원의 갯수 확인하고 남은 금액 확인
    MONEY := MOD(MONEY, 50);
    
    -- MONEY를 10으로 나눠서 몫을 취하고 나머지는 버린다 → 10원의 갯수
    M10 := TRUNC(MONEY / 10);
    
    --○ 결과 출력
    -- 취합된 결과(화폐단위별 갯수)를 형식에 맞게 최종 출력한다.
    --    DBMS_OUTPUT.PUT_LINE('입력받은 금액 총액 :990원');
    DBMS_OUTPUT.PUT_LINE('입력받은 금액 총액 : ' || MONEY2 || '원');
    DBMS_OUTPUT.PUT_LINE('화폐단위 : 오백원 ' || M500 || ', 백원 ' || M100 || ', 오십원 ' || M50 || ', 십원 ' || M10);
END;


--○ 기본 반복문
-- LOOP ~ END LOOP;

-- 1. 조건과 상관없이 무조건 반복하는 구문.

-- 2. 형식 및 구조
/*
LOOP
    -- 실행문
    
    EXIT WHEN 조건;   -- 조건이 참인 경우 반복문을 빠져나간다. / BREAK 처럼
END LOOP;
*/

-- 1 부터 10 까지의 수 출력 (LOOP 문 활용)
DECLARE 
    N NUMBER;
BEGIN
    N := 1;
    
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        
        EXIT WHEN N>=10;
        
        N := N + 1;             -- 『N++』, 『N+=』;
        
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


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

--○ WHILE 반복문
-- WHILE LOOP ~ END LOOP;

-- 1. 제어 조건이 TRUE 인 동안 일련의 문장을 반복하기 위해
--    WHILE LOOP 구문을 사용한다.
--    조건은 반복이 시작되는 시점에 체크하게 되어
--    LOOP 내의 문장이 한 번도 수행되지 않을 경우도 있다.
--    LOOP 를 시작할 때 조건이 FALSE 이면 반복 문장을 탈출하게 된다.

-- 2. 형식 및 구조
/*
WHILE 조건 LOOP       -- 조건이 참인 경우 반복 수행
END LOOP;
*/

-- 1 부터 10 까지의 수 출력 (WHILE LOOP 문 활용)
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


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ FOR 반복문
-- FOR LOOP ~ END LOOP;

-- 1. 『시작수』에서 1씩 증가하여
--    『끝냄수』가 될 때까지 반복 수행한다.

-- 2. 형식 및 구조
/*
FOR 카운터 IN [REVERSE] 시작수 .. 끝남수 LOOP
    -- 실행문;
END LOOP;
*/

-- 1 부터 10 까지의 수 출력 (FOR LOOP 문 활용)
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


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

--○ 사용자로부터 임의의 단(구구단)을 입력받아
--   해당 단수의 구구단을 출력하는 PL/SQL 구문을 작성한다.
/*
실행 예)
바인딩 변수 입력 대화창 → 단을 입력하세요 : 2

2 * 1 = 2
2 * 2 = 4
2 * 3 = 6
    :
2 * 9 = 18
*/

-- 1. LOOP 문의 경우
ACCEPT INPUT PROMPT '단을 입력하세요';
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


-- 2. WHILE LOOP 문의 경우
ACCEPT INPUT PROMPT '단을 입력하세요';
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

-- 3. FOR LOOP 문의 경우
ACCEPT INPUT PROMPT '단을 입력하세요';
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


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ 구구단 전체(2단 ~ 9단)를 출력하는 PL/SQL 구문을 작성한다.
--   단, 이중 반복문(반복문의 중첩) 구문을 활용한다.
/*
실행 예)

==[ 2단 ]==
2 * 1 = 2
    :
==[ 3단 ]==
    :
9 * 9 = 81
*/

-- 내 풀이
DECLARE
    I NUMBER;
    J NUMBER;
BEGIN
    I := 2;
    J := 1;
    
    FOR I IN 2 .. 9
    LOOP
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('==[ ' || I || '단 ]==');
        -- 반복문 중첩
        FOR J IN 1 .. 9
        LOOP
            DBMS_OUTPUT.PUT_LINE(I || ' * ' || J || ' = ' || I * J);
        END LOOP;
    END LOOP;
END;


-- 수업 풀이
DECLARE
    N NUMBER;
    M NUMBER;
BEGIN
    FOR N IN 2 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('==[ ' || N || '단 ]==');
        
        FOR M IN 1 .. 9 LOOP
            DBMS_OUTPUT.PUT_LINE(N || ' * ' || M || ' = ' || N * M);
        END LOOP;
        
    END LOOP;
END;
--==>>
/*
==[ 2단 ]==
2 * 1 = 2
2 * 2 = 4
2 * 3 = 6
2 * 4 = 8
2 * 5 = 10
2 * 6 = 12
2 * 7 = 14
2 * 8 = 16
2 * 9 = 18

==[ 3단 ]==
3 * 1 = 3
3 * 2 = 6
3 * 3 = 9
3 * 4 = 12
3 * 5 = 15
3 * 6 = 18
3 * 7 = 21
3 * 8 = 24
3 * 9 = 27

==[ 4단 ]==
4 * 1 = 4
4 * 2 = 8
4 * 3 = 12
4 * 4 = 16
4 * 5 = 20
4 * 6 = 24
4 * 7 = 28
4 * 8 = 32
4 * 9 = 36

==[ 5단 ]==
5 * 1 = 5
5 * 2 = 10
5 * 3 = 15
5 * 4 = 20
5 * 5 = 25
5 * 6 = 30
5 * 7 = 35
5 * 8 = 40
5 * 9 = 45

==[ 6단 ]==
6 * 1 = 6
6 * 2 = 12
6 * 3 = 18
6 * 4 = 24
6 * 5 = 30
6 * 6 = 36
6 * 7 = 42
6 * 8 = 48
6 * 9 = 54

==[ 7단 ]==
7 * 1 = 7
7 * 2 = 14
7 * 3 = 21
7 * 4 = 28
7 * 5 = 35
7 * 6 = 42
7 * 7 = 49
7 * 8 = 56
7 * 9 = 63

==[ 8단 ]==
8 * 1 = 8
8 * 2 = 16
8 * 3 = 24
8 * 4 = 32
8 * 5 = 40
8 * 6 = 48
8 * 7 = 56
8 * 8 = 64
8 * 9 = 72

==[ 9단 ]==
9 * 1 = 9
9 * 2 = 18
9 * 3 = 27
9 * 4 = 36
9 * 5 = 45
9 * 6 = 54
9 * 7 = 63
9 * 8 = 72
9 * 9 = 81


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/





















