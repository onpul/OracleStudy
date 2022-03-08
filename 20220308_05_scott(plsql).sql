SELECT USER
FROM DUAL;
--==>> SCOTT

SET SERVEROUTPUT ON;

--○ TBL_INSA 테이블의 여러 명의 데이터 여러 개를 변수에 저장하여 출력
--   (반복문 활용)
DECLARE
    V_INSA  TBL_INSA%ROWTYPE;
    V_NUM   TBL_INSA.NUM%TYPE := 1001;
BEGIN
    -- 반복문 구성
    LOOP 
        -- 조회 → 단일 레코드 얻어오기 → 변수에 담아내기
        SELECT NAME, TEL, BUSEO
               INTO V_INSA.NAME, V_INSA.TEL, V_INSA.BUSEO
        FROM TBL_INSA
        WHERE NUM = V_NUM;
        
        -- 출력(변수에 담겨있는 데이터 출력)
        DBMS_OUTPUT.PUT_LINE(V_INSA.NAME || ' - ' || V_INSA.TEL || ' - ' || V_INSA.BUSEO);
        
        V_NUM := V_NUM + 1;
        
        EXIT WHEN V_NUM > 1060;     -- 반복 종료~!!!
        
    END LOOP;
END;
--==>>
/*
홍길동 - 011-2356-4528 - 기획부
이순신 - 010-4758-6532 - 총무부
이순애 - 010-4231-1236 - 개발부
김정훈 - 019-5236-4221 - 영업부
한석봉 - 018-5211-3542 - 총무부
이기자 - 010-3214-5357 - 개발부
장인철 - 011-2345-2525 - 개발부
김영년 - 016-2222-4444 - 홍보부
나윤균 - 019-1111-2222 - 인사부
김종서 - 011-3214-5555 - 영업부
유관순 - 010-8888-4422 - 영업부
정한국 - 018-2222-4242 - 홍보부
조미숙 - 019-6666-4444 - 홍보부
황진이 - 010-3214-5467 - 개발부
이현숙 - 016-2548-3365 - 총무부
이상헌 - 010-4526-1234 - 개발부
엄용수 - 010-3254-2542 - 개발부
이성길 - 018-1333-3333 - 개발부
박문수 - 017-4747-4848 - 인사부
유영희 - 011-9595-8585 - 자재부
홍길남 - 011-9999-7575 - 개발부
이영숙 - 017-5214-5282 - 기획부
김인수 -  - 영업부
김말자 - 011-5248-7789 - 기획부
우재옥 - 010-4563-2587 - 영업부
김숙남 - 010-2112-5225 - 영업부
김영길 - 019-8523-1478 - 총무부
이남신 - 016-1818-4848 - 인사부
김말숙 - 016-3535-3636 - 총무부
정정해 - 019-6564-6752 - 총무부
지재환 - 019-5552-7511 - 기획부
심심해 - 016-8888-7474 - 자재부
김미나 - 011-2444-4444 - 영업부
이정석 - 011-3697-7412 - 기획부
정영희 -  - 개발부
이재영 - 011-9999-9999 - 자재부
최석규 - 011-7777-7777 - 홍보부
손인수 - 010-6542-7412 - 영업부
고순정 - 010-2587-7895 - 영업부
박세열 - 016-4444-7777 - 인사부
문길수 - 016-4444-5555 - 자재부
채정희 - 011-5125-5511 - 개발부
양미옥 - 016-8548-6547 - 영업부
지수환 - 011-5555-7548 - 영업부
홍원신 - 011-7777-7777 - 영업부
허경운 - 017-3333-3333 - 총무부
산마루 - 018-0505-0505 - 영업부
이기상 -  - 개발부
이미성 - 010-6654-8854 - 개발부
이미인 - 011-8585-5252 - 홍보부
권영미 - 011-5555-7548 - 영업부
권옥경 - 010-3644-5577 - 기획부
김싱식 - 011-7585-7474 - 자재부
정상호 - 016-1919-4242 - 홍보부
정한나 - 016-2424-4242 - 영업부
전용재 - 010-7549-8654 - 영업부
이미경 - 016-6542-7546 - 자재부
김신제 - 010-2415-5444 - 기획부
임수봉 - 011-4151-4154 - 개발부
김신애 - 011-4151-4444 - 개발부


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

--------------------------------------------------------------------------------

--■■■ FUNCTION(함수) ■■■--

-- 1. 함수란 하나 이상의 PL/SQL 문으로 구성된 서브루틴으로
--    코드를 다시 사용할 수 있도록 캡슐화 하는 데 사용된다.
--    오라클에서는 오라클에 정의된 기본 제공 함수를 사용하거나
--    직접 스토어드 함수를 만들 수 있다. (→ 사용자 정의 함수)
--    이 사용자 정의 함수는 시스템 함수처럼 쿼리에서 호출하거나
--    저장 프로시저처럼 EXECUTE 문을 통해 실행할 수 있다.

-- 2. 형식 및 구조
/*
CREATE [OR REPLACE] FUNCTION 함수명 -- REPLACE 쓰면 덮어써지는 거
[( 매개변수명1 자료형
 , 매개변수명2 자료형
)]
RETURN 데이터타입         -- 자바에서의 반환자료형처럼
IS                        -- IS 위쪽까지 선언부
    -- 주요 변수 선언
BEGIN
    -- 실행문;
    ...
    RETURN (값);          -- 어떤 값을 RETURN할 건지
    
    [EXCEPTION]
        -- 예외 처리 구문;
END;
*/

--※ 사용자 정의 함수(스토어드 함수)는
--   IN 파라미터(입력 매개변수)만 사용할 수 있으며
--   반드시 반환될 값의 데이터타입을 RETURN 문에 선언해야 하고,
--   FUNCTION 은 반드시 단일 값만 반환한다.

-- 내가 이웃한테 김치통에 김치를 담아 줬으면 --> 입력 파라미터(IN) 넘긴 거
-- 다시 김치통에 무얼 담아줬다 --> OUT 

--○ TBL_INSA 테이블 전용 성별 확인 함수 정의(생성)
-- 함수명 : FN_GENDER()
--                   ↑ SSN(주민등록번호) → '771212-1022432' → 'YYMMDD-NNNNNNN'

CREATE OR REPLACE FUNCTION FN_GENDER( V_SSN VARCHAR2 )  -- 매개변수   : 자릿수(길이) 지정 안 함
RETURN VARCHAR2                                         -- 반환자료형 : 자릿수(길이) 지정 안 함
IS
    -- 선언부 → 주요 변수 선언
    V_RESULT    VARCHAR2(20);
BEGIN
    -- 실행부(정의부) → 연산 및 처리
    IF ( SUBSTR(V_SSN, 8, 1) IN ('1', '3') ) -- 괄호를 넣는 것을 권장함(선생님의 개인적인 권장)
        THEN V_RESULT := '남자';
    ELSIF ( SUBSTR(V_SSN, 8, 1) IN ('2', '4') )
        THEN V_RESULT := '여자';
    ELSE -- ELSE에는 THEN이 없다~!
        V_RESULT := '성별확인불가';
    END IF;
    
    -- 결과값 반환       CHECK~!!
    RETURN V_RESULT;
    
END;
--==>> Function FN_GENDER이(가) 컴파일되었습니다.


--○ 임의의 정수 두 개를 매개변수(입력 파라미터)로 넘겨받아 → (A, B)
--   A 의 B 승의 값을 반환하는 사용자 정의 함수를 작성한다.
--   단, 기존의 오라클 내장 함수를 이용하지 않고, 반복문을 활용하여 작성한다.
--   함수명 : FN_POW()
/*
사용 예)
SELECT FN_POW(10, 3)
FROM DUAL;
--==>> 1000
*/

/*
FN_POW(10, 3)                → 1000
       기준 1 * 10 * 10 * 10 → 1000
       기준 0 * 10 * 10 * 10 → 0
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
--==>> Function FN_POW이(가) 컴파일되었습니다.

-- 수업 풀이
CREATE OR REPLACE FUNCTION FN_POW(A NUMBER, B NUMBER) -- 세미콜론 찍으면 안 돼
RETURN NUMBER
IS  
    V_RESULT    NUMBER := 1;            -- 반환 결과값 변수 → CHECK~!!! 1로 초기화~!!!
    V_NUM       NUMBER;                 -- 루프 변수
BEGIN
    -- 반복문 구성
    FOR V_NUM IN 1 .. B LOOP
        V_RESULT := V_RESULT * A;       -- V_RESULT *= A; / 자바로 치자면~
    END LOOP;
    
    -- 최종 결과값 반환
    RETURN V_RESULT;
END;
--==>> Function FN_POW이(가) 컴파일되었습니다.






