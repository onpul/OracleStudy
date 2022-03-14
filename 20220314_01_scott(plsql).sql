SELECT USER
FROM DUAL;
--==>> SCOTT


--○ TBL_출고 테이블에서 출고수량을 수정(변경)하는 프로시저를 작성한다.
--   프로시저 명 : PRC_출고_UPDATE()
/*
실행 예)
EXEC PRC_출고_UPDATE(출고번호, 변경할수량);
*/

CREATE OR REPLACE PROCEDURE PRC_출고_UPDATE
( -- ① 매개변수 구성
  V_출고번호    IN TBL_출고.출고번호%TYPE
, V_출고수량    IN TBL_출고.출고수량%TYPE
)
IS
    -- ③ 필요한 변수 선언
    V_상품코드       TBL_상품.상품코드%TYPE;
    V_이전출고수량   TBL_출고.출고수량%TYPE; 
    V_재고수량       TBL_상품.재고수량%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN

    -- ④ 선언한 변수에 값 담아내기
    -- ⑥ 
    SELECT 상품코드, 출고수량 INTO V_상품코드, V_이전출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    -- ⑧ 출고 정상수행여부 판단 필요
    --    변경 이전의 출고수량 및 현재의 재고수량 확인
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    -- ⑨ 파악한 재고수량에 따라 데이터 변경 실시 여부 판단
    --    (『재고수량+이전출고수량 < 현재출고수량』 인 상황이라면... 사용자정의예외 발생)
    IF (V_재고수량 + V_이전출고수량 < V_출고수량)
        -- 사용자정의 예외 발생
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- ② 수행될 쿼리문 체크(UPDATE → TBL_출고 / UPDATE → TBL_상품)
    UPDATE TBL_출고
    SET 출고수량 = V_출고수량
    WHERE 출고번호 = V_출고번호;
    
    -- ⑤
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_이전출고수량 - V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    -- ⑦ 커밋
    COMMIT;
    
    -- ⑩ 예외 처리
    EXCEPTION 
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '재고 부족~!!!'); 
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
            
END;
--==>> Procedure PRC_출고_UPDATE이(가) 컴파일되었습니다.

--------------------------------------------------------------------------------

/*
1. PRC_입고_UPDATE(입고번호, 입고수량)
2. PRC_입고_DELETE(입고번호)
3. PRC_출고_DELETE(출고번호)
*/

-- 1. PRC_입고_UPDATE(입고번호, 입고수량)
CREATE OR REPLACE PROCEDURE PRC_입고_UPDATE
( V_입고번호    IN TBL_입고.입고번호%TYPE
, V_입고수량    IN TBL_입고.입고수량%TYPE
)
IS
    V_상품코드       TBL_상품.상품코드%TYPE;
    V_재고수량       TBL_상품.재고수량%TYPE;
    V_이전입고수량   TBL_입고.입고수량%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    -- V_상품코드, V_이전입고수량 변수에 값 담아내기
    SELECT 상품코드, 입고수량 INTO V_상품코드, V_이전입고수량
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    
    -- V_재고수량 변수에 값 담아내기
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    -- 입고 테이블 UPDATE
    UPDATE TBL_입고
    SET 입고수량 = V_입고수량
    WHERE 입고번호 = V_입고번호;
    
    -- 재고수량이 새로 입력한 입고수량보다 적을 경우
    IF (V_재고수량 < V_입고수량)
        -- 사용자정의 예외 발생
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 상품 테이블 재고수량
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 - V_이전입고수량 + V_입고수량
    WHERE 상품코드 = V_상품코드;
    
     -- 커밋
    COMMIT;
    
    -- 예외 처리 
    EXCEPTION 
       WHEN USER_DEFINE_ERROR
           THEN RAISE_APPLICATION_ERROR(-20002, '재고 부족~!!!'); 
                ROLLBACK;
       WHEN OTHERS
           THEN ROLLBACK;        
    
END;
--==>> Procedure PRC_입고_UPDATE이(가) 컴파일되었습니다.


-- 2. PRC_입고_DELETE(입고번호)
CREATE OR REPLACE PROCEDURE PRC_입고_DELETE 
(V_입고번호 IN TBL_입고.입고번호%TYPE)
IS
    V_삭제할입고수량   TBL_입고.입고수량%TYPE;
    V_상품코드         TBL_상품.상품코드%TYPE;
    V_재고수량         TBL_상품.재고수량%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    -- V_삭제할입고수량 변수에 값 담아내기
    SELECT 입고수량 INTO V_삭제할입고수량
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    
    -- V_상품코드 변수에 값 담아내기
    SELECT 상품코드 INTO V_상품코드
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    
     -- V_재고수량 변수에 값 담아내기
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    -- 삭제할 입고번호의 입고수량이 재고보다 크면 사용자정의 예외 발생  
    IF (V_재고수량 < V_삭제할입고수량)
        -- 사용자정의 예외 발생
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 입고 테이블 해당 행 DELETE
    DELETE
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    
    -- 삭제할 행의 입고 수량만큼 상품 수량 빼야 함
    UPDATE TBL_상품
    SET 재고수량 = V_재고수량 - V_삭제할입고수량
    WHERE 상품코드 = V_상품코드;
    
    -- 커밋
    COMMIT;
    
    -- 예외 처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20003, '삭제할 입고번호의 입고수량보다 현재 재고수량이 적습니다.');
        WHEN OTHERS
            THEN ROLLBACK;

END;
--==>> Procedure PRC_입고_DELETE이(가) 컴파일되었습니다.

-- 3. PRC_출고_DELETE(출고번호)
CREATE OR REPLACE PROCEDURE PRC_출고_DELETE
(V_출고번호 IN TBL_출고.출고번호%TYPE)
IS
    V_삭제할출고수량    TBL_출고.출고수량%TYPE;
    V_상품코드          TBL_상품.상품코드%TYPE;
    
BEGIN
    -- V_삭제할출고수량 변수에 값 담아내기
    SELECT 출고수량 INTO V_삭제할출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    -- 출고 테이블 해당 행 삭제
    DELETE
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    -- V_상품코드 변수에 값 담아내기
    SELECT 상품코드 INTO V_상품코드
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    -- 삭제한 행의 출고수량만큼 재고수량에 다시 넣어야 함
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_삭제할출고수량
    WHERE 상품코드 = V_상품코드;
    
    -- 커밋
    COMMIT;
    
    -- 예외 처리 
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; -- 둘 중에 하나만 수행됐을 때 롤백

END;
--==>> Procedure PRC_출고_DELETE이(가) 컴파일되었습니다.

--------------------------------------------------------------------------------

--■■■ CURSOR (커서) ■■■--
-- 커서는 놀래켜 주는 깜짝 상자 같은 거!!!
-- 상자 안에 차곡차곡 눌러 담아 두겠다~!!!
-- 뚜껑을 열어야 튀어나온다

-- 1. 오라클에서는 하나의 레코드가 아닌 여러 레코드로 구성된
--    작업 영역에서 SQL 문을 실행하고 그 과정에서 발생한 정보를
--    저장하기 위해 커서(CURSOR)를 사용하며,
--    커서에는 암시적인 커서와 명시적인 커서가 있다.

-- 2. 암시적 커서는 모든 SQL 구문에 존재하며
--    SQL 문 실행 후 오직 하나의 행(ROW)만 출력하게 된다.
--    그러나 SQL 문을 실행한 결과물(RESULT SET)이
--    여러 행(ROW)으로 구성된 경우
--    커서(CURSOR)를 명시적으로 선언해야 여러 행(ROW)을 다룰 수 있다.
--> 우리가 모르는 사이에 암시적으로 처리된다~

--○ 커서 이용 전 상황(단일 행 접근 시)
SET SERVEROUTPUT ON;
--==>> 작업이 완료되었습니다.(0.1초)

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
홍길동 -- 011-2356-4528


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ 커서 이용 전 상황(다중 행 접근 시)
DECLARE
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME, TEL INTO V_NAME, V_TEL
    FROM TBL_INSA;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
END;
--==>> 에러 발생
--     (ORA-01422: exact fetch returns more than requested number of rows)


--○ 커서 이용 전 상황(다중 행 접근 시 - 반복문 활용)
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
        
        EXIT WHEN V_NUM >= 1061; -- 자바에서의 BREAK와 같음
        
    END LOOP;
END;
--==>>
/*
홍길동 -- 011-2356-4528
이순신 -- 010-4758-6532
이순애 -- 010-4231-1236
김정훈 -- 019-5236-4221
한석봉 -- 018-5211-3542
이기자 -- 010-3214-5357
장인철 -- 011-2345-2525
김영년 -- 016-2222-4444
나윤균 -- 019-1111-2222
김종서 -- 011-3214-5555
유관순 -- 010-8888-4422
정한국 -- 018-2222-4242
조미숙 -- 019-6666-4444
황진이 -- 010-3214-5467
이현숙 -- 016-2548-3365
이상헌 -- 010-4526-1234
엄용수 -- 010-3254-2542
이성길 -- 018-1333-3333
박문수 -- 017-4747-4848
유영희 -- 011-9595-8585
홍길남 -- 011-9999-7575
이영숙 -- 017-5214-5282
김인수 -- 
김말자 -- 011-5248-7789
우재옥 -- 010-4563-2587
김숙남 -- 010-2112-5225
김영길 -- 019-8523-1478
이남신 -- 016-1818-4848
김말숙 -- 016-3535-3636
정정해 -- 019-6564-6752
지재환 -- 019-5552-7511
심심해 -- 016-8888-7474
김미나 -- 011-2444-4444
이정석 -- 011-3697-7412
정영희 -- 
이재영 -- 011-9999-9999
최석규 -- 011-7777-7777
손인수 -- 010-6542-7412
고순정 -- 010-2587-7895
박세열 -- 016-4444-7777
문길수 -- 016-4444-5555
채정희 -- 011-5125-5511
양미옥 -- 016-8548-6547
지수환 -- 011-5555-7548
홍원신 -- 011-7777-7777
허경운 -- 017-3333-3333
산마루 -- 018-0505-0505
이기상 -- 
이미성 -- 010-6654-8854
이미인 -- 011-8585-5252
권영미 -- 011-5555-7548
권옥경 -- 010-3644-5577
김싱식 -- 011-7585-7474
정상호 -- 016-1919-4242
정한나 -- 016-2424-4242
전용재 -- 010-7549-8654
이미경 -- 016-6542-7546
김신제 -- 010-2415-5444
임수봉 -- 011-4151-4154
김신애 -- 011-4151-4444


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

/*
일반 변수 → 선언
예외 변수 → 선언

변수명 타입
예외변수명 타입
커서명 CURSOR (Ⅹ)

커서 → 정의

TABLE 테이블명
INDEX 인덱스명
USER 사용자명
CURSOR 커서명 (○)
*/

--○ 커서 이용 후 상황
DECLARE
    -- 주요 변수 선언
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
    
    -- 커서 이용을 위한 커서 정의  CHECK~!!!
    CURSOR CUR_INSA_SELECT -- 커서 커서명
    IS 
    SELECT NAME, TEL
    FROM TBL_INSA;
    
BEGIN
    -- 커서 오픈
    OPEN CUR_INSA_SELECT;
    
    -- 커서 오픈 시 쏟아져나오는 데이터들 처리(반복문을 활용하여 처리)
    -- 커서 오픈하면 데이터가 와악!!!!!!!!!!!!!!!!!!!!하고 쏟아져 나온다
    LOOP
        -- 한 행 한 행 받아다가 처리하는 행위 → 가져오다(데려오다) → 『FETCH』
        FETCH CUR_INSA_SELECT INTO V_NAME, V_TEL;
        
        -- 커서에서 더 이상 데이터가 쏟아져 나오지 않는 상태 ... 『NOTFOUND』
        EXIT WHEN CUR_INSA_SELECT%NOTFOUND; -- 들여다 볼 때 % 퍼센트 쓴다 / 참조할 때 / 어깨 너머 컨닝할 때
        
        -- 출력
        DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
        
    END LOOP;
    
    -- 커서 클로즈
    CLOSE CUR_INSA_SELECT;
END;
--==>>
/*
양윤정 -- 010-8624-4533
홍길동 -- 011-2356-4528
이순신 -- 010-4758-6532
이순애 -- 010-4231-1236
김정훈 -- 019-5236-4221
한석봉 -- 018-5211-3542
이기자 -- 010-3214-5357
장인철 -- 011-2345-2525
김영년 -- 016-2222-4444
나윤균 -- 019-1111-2222
김종서 -- 011-3214-5555
유관순 -- 010-8888-4422
정한국 -- 018-2222-4242
조미숙 -- 019-6666-4444
황진이 -- 010-3214-5467
이현숙 -- 016-2548-3365
이상헌 -- 010-4526-1234
엄용수 -- 010-3254-2542
이성길 -- 018-1333-3333
박문수 -- 017-4747-4848
유영희 -- 011-9595-8585
홍길남 -- 011-9999-7575
이영숙 -- 017-5214-5282
김인수 -- 
김말자 -- 011-5248-7789
우재옥 -- 010-4563-2587
김숙남 -- 010-2112-5225
김영길 -- 019-8523-1478
이남신 -- 016-1818-4848
김말숙 -- 016-3535-3636
정정해 -- 019-6564-6752
지재환 -- 019-5552-7511
심심해 -- 016-8888-7474
김미나 -- 011-2444-4444
이정석 -- 011-3697-7412
정영희 -- 
이재영 -- 011-9999-9999
최석규 -- 011-7777-7777
손인수 -- 010-6542-7412
고순정 -- 010-2587-7895
박세열 -- 016-4444-7777
문길수 -- 016-4444-5555
채정희 -- 011-5125-5511
양미옥 -- 016-8548-6547
지수환 -- 011-5555-7548
홍원신 -- 011-7777-7777
허경운 -- 017-3333-3333
산마루 -- 018-0505-0505
이기상 -- 
이미성 -- 010-6654-8854
이미인 -- 011-8585-5252
권영미 -- 011-5555-7548
권옥경 -- 010-3644-5577
김싱식 -- 011-7585-7474
정상호 -- 016-1919-4242
정한나 -- 016-2424-4242
전용재 -- 010-7549-8654
이미경 -- 016-6542-7546
김신제 -- 010-2415-5444
임수봉 -- 011-4151-4154
김신애 -- 011-4151-4444


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- 처음과 끝 값을 직접 입력하지 않아도 된다.

--------------------------------------------------------------------------------

--■■■ TRIGGER(트리거) ■■■--
-- 트리거는 금고 같은 데 붙여 놓는 부비트랩 같은 거!!!
-- 특정한 상황이 됐을 때 터지도록 만드는 거
-- 장착해서 쓰는 것 -> 시퀀스와 테이블이 별개인 것처럼

-- 사전적인 의미 : 방아쇠, 촉발시키다, 야기하다, 유발하다.

-- 1. TRIGGER(트리거)란 DML 작업 즉, INSERT, UPDATE, DELETE 작업이 일어날 때
--    자동적으로 실행되는(유발되는, 촉발되는) 객체로
--    이와 같은 특징을 강조하여 DML TRIGGER 라고 부르기도 한다.
--    TRIGGER 는 무결성 뿐 아니라
--    다음과 같은 작업에도 널리 사용된다.

--  자동으로 파생된 열 값 생성 --> 반장(트리거)이 떠든 애들 이름 적어놓은 거
--  잘못된 트랜잭션 방지 --> INSERT로 넣는 거?
--  복잡한 보안 권한 강제 수행 --> 근무 시간에는 주식 사이트 못 하게 네트워크 처리
--  분산 데이터베이스 노드 상에서 참조 무결성 강제 수행 --> EMP는 내 PC에, DEPT는 대전에  
--  복잡한 업무 규칙 강제 적용 --> (잘못된 트랜잭션 방지)
--  투명한 이벤트 로깅 제공 --> 우리 성 사람이면 다리를 내려 준다 --> 다리가 로그 / 어떤 일이 일어났는지 모두 기록
--  복잡한 감사 제공 
--  동기 테이블 복제 유지관리 --> 맛동산 맛동산 맛동산 세 개 똑같이 INSERT 되도록
--  테이블 액세스 통계 수집 --> 이벤트 로깅...과 비슷한 내용

-- 2. TRIGGER(트리거) 내에서는 COMMIT, ROLLBACK 문을 사용할 수 없다.
--> 왜? --> INSERT DELETE UPDATE를 사용자가 직접 쓰는 거  

-- 3. 특징 및 종류
--    - BEFORE STATEMENT -- INSERT 시킬 수 없게 미리 막기 --> 한 줄만
--    - BEFORE ROW 
--    - AFTER STATEMENT -- 떠든 후에 이름을 적을 수 있다
--    - AFTER ROW

-- 4. 형식 및 구조
/*
CREATE [OR REPLACE] TRIGGER 트리거명
    [BEFORE | AFTER]
    이벤트1 [OR 이벤트2 [OR 이벤트 3]] ON 테이블명
    [FOR EACH ROW [WHEN TRIGGER 조건]]
[DECLARE]
    -- 선언 구문;
BEGIN
    -- 실행 구문;
END;
*/

--■■■ AFTER STATEMENT TRIGGER 상황 실습 ■■■--
-- ※ DML 작업에 대한 이벤트 기록

--○ TRIGGER(트리거) 생성 → TRG_EVENTLOG
CREATE OR REPLACE TRIGGER TRG_EVENTLOG
    AFTER 
    INSERT OR UPDATE OR DELETE ON TBL_TEST1 -- 감시 대상 
-- DECLARE --> 생략
BEGIN
    -- 이벤트 종류 구분(조건문을 통한 분기)
    IF (INSERTING) -- 정의되어 있는 용어임
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
             VALUES('INSERT 쿼리가 실행되었습니다.');
    ELSIF (UPDATING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
             VALUES('UPDATE 쿼리가 실행되었습니다.');
    ELSIF (DELETING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
             VALUES('DELETE 쿼리가 실행되었습니다.');
    END IF;
    
    -- COMMIT;
    -- ※ TRIGGER 내에서는 COMMIT / ROLLBACK 구문 사용 불가~!!! CHECK~!!!
END;
--==>> Trigger TRG_EVENTLOG이(가) 컴파일되었습니다.


--■■■ BEFORE STATEMENT TRIGGER 상황 실습 ■■■--
--※ DML 작업 수행 전에 작업에 대한 가능 여부 확인

--○ TRIGGER(트리거) 생성 → TRG_TEST1_DML
CREATE OR REPLACE TRIGGER TRG_TEST1_DML
        BEFORE 
        INSERT OR UPDATE OR DELETE ON TBL_TEST1 -- 감시 대상
--DECLARE --> 생략
BEGIN
    IF ( 작업시간이 오전 9시 이전이거나... 오후 6시 이후라면... )
        THEN 작업을 수행하지 못하도록 처리하겠다.
    END IF;
END;


CREATE OR REPLACE TRIGGER TRG_TEST1_DML
        BEFORE 
        INSERT OR UPDATE OR DELETE ON TBL_TEST1 -- 감시 대상
--DECLARE --> 생략
BEGIN
    IF ( TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) < 9 이거나... TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) > 17 라면... )
        THEN 작업을 수행하지 못하도록 처리하겠다.
    END IF;
END;        
       
        
CREATE OR REPLACE TRIGGER TRG_TEST1_DML
        BEFORE 
        INSERT OR UPDATE OR DELETE ON TBL_TEST1 -- 감시 대상
--DECLARE --> 생략
BEGIN
    IF ( TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) < 9 OR TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) > 17 )
        THEN 사용자 정의 예외를 발생시킬 수 있도록 하겠다.
    END IF;
END; 


CREATE OR REPLACE TRIGGER TRG_TEST1_DML
        BEFORE 
        INSERT OR UPDATE OR DELETE ON TBL_TEST1 -- 감시 대상
--DECLARE --> 생략
BEGIN
    IF ( TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) < 9 OR TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) > 17 ) -- 오라클 서버의 시간
        THEN RAISE_APPLICATION_ERROR(-20003, '작업은 09:00 ~ 18:00 까지만 가능합니다.');
    END IF;
END; 
--==>> Trigger TRG_TEST1_DML이(가) 컴파일되었습니다.


--■■■ BEFORE ROW TRIGGER 상황 실습 ■■■--
-- ※ 참조 관계가 설정된 데이터(자식) 삭제를 먼저 수행하는 모델

-- 부모 테이블의 레코드를 제거하는 게 현재라면
-- 자식 테이블의 참조하는 레코드를 조금 전에 과거에 삭제해야 하니까 비포
-- 자식 테이블을 모두 삭제가 아니라 레코드 삭제니까 로우
--○ TRIGGER(트리거) 생성 → TRG_TEST2_DELETE
CREATE OR REPLACE TRIGGER TRG_TEST2_DELETE
        BEFORE -- 액션보다 한 발 앞서서 수행
        DELETE ON TBL_TEST2 -- 부모테이블에 DELETE 액션을 수행했을 때
        FOR EACH ROW -- 이 옵션이 있어야 ROW 트리거 / 각각의 행에 대해서 처리
BEGIN -- 수행하는 영역
    DELETE 
    FROM TBL_TEST3 -- 자식 테이블
    WHERE CODE = :OLD.CODE; -- 현재 시점에서 과거로 가서 어떤 코드인지 확인하고 오는 거 / 삭제하기 이전 자료(삭제할 자료)
END;
--==>> Trigger TRG_TEST2_DELETE이(가) 컴파일되었습니다.


--※ 『:OLD』
--   참조 전 열의 값
--   (INSERT : 입력하기 이전 자료, DELETE : 삭제하기 이전 자료 즉, 삭제할 자료)

-- 충격적인 소식!!!!!! 오라클 내부적으로는 UPDATE가 없다!!!! UPDATE는 내부적으로
-- DELETE하고 INSERT하는 것이다!!! 충격적!!!

--※ UPDATE : 내부적으로 DELETE 그리고 INSERT 가 결합된 형태
--            UPDATE 하기 이전의 데이터는 『:OLD』
--            UPDATE 수행한 이후의 데이터는 『:NEW』


--------------------------------------------------------------------------------

--■■■ AFTER ROW TRIGGER 상황 실습 ■■■--
--※ 참조 테이블 관련 트랜잭션 처리

-- TBL_입고, TBL_상품, TBL_출고

--○ TBL_입고 테이블의 데이터 입력 시(즉, 입고 이벤트 발생 시)
--   TBL_상품 테이블의 재고수량 변동 트리거 작성
--   트리거 명 : TRG_IBGO

CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER 
        INSERT ON TBL_입고
        FOR EACH ROW -- 행 트리거
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + 새로입고되는입고수량
             WHERE 상품코드 = 새로입고되는상품코드;
    END IF;
END;


CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER 
        INSERT ON TBL_입고
        FOR EACH ROW -- 행 트리거
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + :NEW.입고수량
             WHERE 상품코드 = :NEW.상품코드;
    END IF;
END;
--==>> Trigger TRG_IBGO이(가) 컴파일되었습니다.


--○ TBL_입고 테이블의 데이터 입력, 수정, 삭제 시
--   TBL_상품 테이블의 재고수량 변동 트리거 작성
--   트리거 명 : TRG_IBGO
CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER 
        INSERT OR UPDATE OR DELETE ON TBL_입고
        FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + :NEW.입고수량
             WHERE 상품코드 = :NEW.상품코드;
    ELSIF (UPDATING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 - :OLD.입고수량 + :NEW.입고수량
             WHERE 상품코드 = :NEW.상품코드;
    ELSIF (DELETING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 - :OLD.입고수량
             WHERE 상품코드 = :NEW.상품코드;
    END IF;
END;


















