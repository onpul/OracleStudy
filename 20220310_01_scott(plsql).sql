SELECT USER
FROM DUAL;
--==>> SCOTT

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

-- 2022.03.10. -----------------------------------------------------------------

--○ TBL_INSA 테이블의 급여 계산 전용 함수를 정의한다.
--   급여는 『(기본급*12)+수당』 기반으로 연산을 수행한다.
--   함수명 : FN_PAY(기본급, 수당)

-- 내 풀이
CREATE OR REPLACE FUNCTION FN_PAY(A NUMBER, B NUMBER)
RETURN NUMBER
IS
    V_RESULT    NUMBER;
BEGIN
    V_RESULT := (A * 12) + B;
    
    RETURN V_RESULT;
END;
--==>> Function FN_PAY이(가) 컴파일되었습니다.

-- 수업 풀이 
CREATE OR REPLACE FUNCTION FN_PAY(VBASICPAY NUMBER, VSUDANG NUMBER)
RETURN NUMBER
IS 
    -- 주요 변수 선언
    VRESULT NUMBER;
BEGIN
    -- 연산 및 처리
    VRESULT := (NVL(VBASICPAY, 0) * 12) + NVL(VSUDANG, 0);
    
    -- 최종 결과값 반환
    RETURN VRESULT;
END;
--==>> Function FN_PAY이(가) 컴파일되었습니다.

--------------------------------------------------------------------------------

--○ TBL_INSA 테이블에서 입사일을 기준으로 현재까지의
--   근무년수를 반환하는 함수를 정의한다.
--   단, 근무년수는 소수점 이하 한자리까지 계산한다.
--   함수명 : FN_WORKYEAR

-- 내 풀이
CREATE OR REPLACE FUNCTION FN_WORKYEAR(VIBSADATE VARCHAR2)
RETURN NUMBER
IS
    VRESULT NUMBER;
BEGIN
    VRESULT := EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(VIBSADATE, 1, 4));
    
    RETURN VRESULT;
END;
--==>> Function FN_WORKYEAR이(가) 컴파일되었습니다.

CREATE OR REPLACE FUNCTION FN_WORKYEAR(VIBSADATE VARCHAR2)
RETURN NUMBER
IS
    VRESULT NUMBER;
BEGIN
    VRESULT := ROUND( ((SYSDATE - TO_DATE(VIBSADATE, 'YYYY-MM-DD')) / 365), 2 );
    
    RETURN VRESULT;
END;
--==>> Function FN_WORKYEAR이(가) 컴파일되었습니다.

-- 수업 풀이

-- 1
SELECT MONTHS_BETWEEN(SYSDATE, '2002-02-11') / 12
FROM DUAL;
--==>> 20.08177618478693747510951812027080844283

-- 2
SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, '2002-02-11') / 12) || '년' ||
       TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, '2002-02-11'), 12)) || '개월'
FROM DUAL;
--==>> 20년0개월

CREATE OR REPLACE FUNCTION FN_WORKYEAR(VIBSADATE DATE)
RETURN VARCHAR2
IS
    VRESULT VARCHAR(20);
BEGIN
    VRESULT := TRUNC(MONTHS_BETWEEN(SYSDATE, VIBSADATE) / 12) || '년' ||
               TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, VIBSADATE), 12)) || '개월';
    
    RETURN VRESULT;
END;
--==>> Function FN_WORKYEAR이(가) 컴파일되었습니다.


CREATE OR REPLACE FUNCTION FN_WORKYEAR(VIBSADATE DATE)
RETURN NUMBER
IS
    VRESULT NUMBER;
BEGIN
    VRESULT := TRUNC(MONTHS_BETWEEN(SYSDATE, VIBSADATE) / 12, 1);
    
    RETURN VRESULT;
END;
--==>> Function FN_WORKYEAR이(가) 컴파일되었습니다.


--------------------------------------------------------------------------------

--※ 참고

-- 1. INSERT, UPDATE, DELETE, (MERGE)
--==>> DML(Data Manipulation Language)
-- COMMIT / ROLLBACK 이 필요하다.

-- 2. CREATE, DROP, ALTER, (TRUNCATE)
--==>> DDL(Data Definition Language)
-- 실행하면 자동으로 COMMIT 된다.

-- 3. GRANT, REVOKE
--==>> DCL(Data Control Language)
-- 실행하면 자동으로 COMMIT 된다.

-- 4. COMMIT, ROLLBACK
--==>> TCL(Transaction Control Language)

-- 정적 PL/SQL 문 → DML문, TCL문만 사용 가능하다.
-- 동적 PL/SQL 문 → DML문, DDL문, DCL문, TCL문 사용 가능하다. 

--------------------------------------------------------------------------------

--■■■ PROCEDURE(프로시저) ■■■--

-- 1. PL/SQL 에서 가장 대표적인 구조인 스토어드 프로시저는 -- 이것 때문에 PL/SQL을 사용한다고 해도 과언이 아닐만큼..
--    개발자가 자주 작성해야 하는 업무의 흐름을
--    미리 작성하여 데이터베이스 내에 저장해 두었다가
--    필요할 때마다 호출하여 실행할 수 있도록 처리해 주는 구문이다.

-- 2. 형식 및 구조
/*
CREATE [OR REPLACE] PROCEDURE 프로시저명
[( 매개변수 IN 데이터타입 -- 입력 매개변수 / 김치부침개 건네주기만 할게
 , 매개변수 OUT 데이터타입 -- 출력 매개변수 / 내가 빈 통 줄테니까 부추 부침개를 담아서 주겠니?
 , 매개변수 INOUT 데이터타입 -- 입출력 매개변수 / 김치부침개 김치통에 담아서 줄테니까 너도 간장종지랑 그런 거 담아줘
)]
IS
    [-- 주요 변수 선언]
BEGIN
    -- 실행 구문;
    ...
    
    [EXCEPTION
        -- 예외 처리 구문;]
END;
*/

--※ FUNCTION 과 비교했을 때 『RETURN 반환자료형』 부분이 존재하지 않으며,
--   『RETURN』문 자체도 존재하지 않으며,
--   프로시저 실행 시 넘겨주게 되는 매개변수의 종류는
--   IN(입력), OUT(출력), INOUT(입출력)으로 구분된다.

-- 3. 실행(호출)
/*
EXEC[UTE] 프로시저명[(인수1, 인수2, ...)];
*/

--※ 프로시저 실습을 위한 테이블 생성은
--   『20220310_02_scott.sql』 파일 참조~!!!


--○ 프로시저 생성
CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT
( 아이디
, 패스워드
, 이름
, 전화
, 주소
)
IS 
BEGIN
END;

CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT
( V_ID      IN TBL_IDPW.ID%TYPE     -- 함수에선 IN이 생략된 것
, V_PW      IN TBL_IDPW.PW%TYPE
, V_NAME    IN TBL_STUDENTS.NAME%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS 
BEGIN
    -- TBL_IDPW 테이블에 데이터 입력(INSERT)
    INSERT INTO TBL_IDPW(ID, PW)
    VALUES(V_ID, V_PW);
    
    -- TBL_STUDENTS 테이블에 데이터 입력(INSERT)
    INSERT INTO TBL_STUDENTS(ID, NAME, TEL, ADDR)
    VALUES(V_ID, V_NAME, V_TEL, V_ADDR);
    
    -- 커밋
    COMMIT;
    
END;
--==>>  Procedure PRC_STUDENT_INSERT이(가) 컴파일되었습니다.



--※ 프로시저 실습을 위한 테이블 생성은
--   『20220310_02_scott.sql』 파일 참조~!!!


--○ 데이터 입력 시 특정 항목의 데이터만 입력하면
--                  ---------
--                  (학번, 이름, 국어점수, 영어점수, 수학점수)
--   내부적으로 다른 추가항목에 대한 처리가 함께 이루어질 수 있도록 하는
--                   --------
--                   (총점, 평균, 등급)
--   프로시저를 작성한다.(생성한다.)
--   프로시저 명 : PRC_SUNGJUK_INSERT()

















