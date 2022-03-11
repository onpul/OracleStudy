SELECT USER
FROM DUAL;
--==>> SCOTT

DESC TBL_INSA;

SELECT *
FROM TBL_INSA;

--○ TBL_INSA 테이블을 대상으로 신규 데이터 입력 프로시저를 작성한다.
-- NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
-- 으로 구성된 컬럼 중 NUM 을 제외한 NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG 의 데이터 입력 시
-- NUM 컬럼(사원번호)의 값은
-- 기존 부여된 사원  번호의 마지막 번호 그 다음 번호를 자동으로 입력 처리할 수 있는 프로시저로 구성한다.
-- 프로시저 명 : PRC_INSA_INSERT()
/*
실행 예)
EXEC PRC_INSA_INSERT('양윤정', '970131-2234567', SYSDATE, '서울', '010-8624-4533', '개발부', '대리', 2000000, 2000000);

프로시저 호출로 처리된 결과
1061 양윤정 970131-2234567 2022-03-11 서울 010-8624-4533 개발부 대리 2000000 2000000
의 데이터가 신규 입력된 상황
*/

-- 내 풀이
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
    
    -- TBL_INSA 테이블에 데이터 입력(INSERT)
    INSERT INTO TBL_INSA(NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES(V_NUM, V_NAME, V_SSN, V_IBSADATE, V_CITY, V_TEL, V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG);
    
    -- 커밋
    COMMIT;
    
END;
--==>> Procedure PRC_INSA_INSERT이(가) 컴파일되었습니다.

-- 수업 풀이
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
    V_NUM   TBL_INSA.NUM%TYPE; -- 세미콜론 확인
    
BEGIN
    SELECT MAX(NVL(NUM, 0)) + 1 INTO V_NUM -- MAX, MIN, SUM 이런 애들은 다 NULL을 제외하고 연산 --> NVL 처리
    FROM TBL_INSA;
    
    INSERT INTO TBL_INSA(NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES(V_NUM, V_NAME, V_SSN, V_IBSADATE, V_CITY, V_TEL, V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG);
    
    COMMIT; -- 커밋, 롤백 확인
    
END;
--==>> Procedure PRC_INSA_INSERT이(가) 컴파일되었습니다.


--○ TBL_상품, TBL_입고 테이블을 대상으로
--   TBL_입고 테이블에 데이터 입력 시(즉, 입고 이벤트 발생 시)
--   TBL_상품 테이블의 재고수량이 함께 변동될 수 있는 기능을 가진 프로시저를 작성한다.
--   단, 이 과정에서 입고번호는 자동 증가 처리한다. (시퀀스 사용 Ⅹ)
--   TBL_입고 테이블 구성 컬럼
--   : 입고번호, 상품코드, 입고일자, 입고수량, 입고단가
--   프로시저 명 : PRC_입고_INSERT(상품코드, 입고수량, 입고단가)

-- 'H001', 30, 400
-- → 입고테이블의 데이터 입력(프로시저 매개변수로 전달받지 못한 나머지 값 → 자동 입력)
-- → 상품테이블의 바밤바 재고수량 30개

-- 내 풀이
CREATE OR REPLACE PROCEDURE PRC_입고_INSERT
( V_상품코드    IN TBL_입고.상품코드%TYPE
, V_입고수량    IN TBL_입고.입고수량%TYPE
, V_입고단가    IN TBL_입고.입고단가%TYPE
)
IS
    V_입고번호    TBL_입고.입고번호%TYPE;
    V_입고일자    TBL_입고.입고일자%TYPE;
BEGIN
    -- 입고번호
    SELECT 입고번호 MAX(NVL(입고번호, 0)) + 1 INTO V_입고번호
    FROM TBL_입고;
    
    V_입고일자 := SYSDATE;
    
    -- 입고 테이블 데이터 입력
    INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)  
    VALUES(V_입고번호, V_상품코드, V_입고일자, V_입고수량, V_입고단가);
    
    -- 상품 테이블 재고 수량 업데이트
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_입고수량
    WHERE 상품코드 = V_상품코드;
    
    COMMIT;
END;
--==>> Procedure PRC_입고_INSERT이(가) 컴파일되었습니다.


-- 수업 풀이
CREATE OR REPLACE PROCEDURE PRC_입고_INSERT
( V_상품코드    IN TBL_상품.상품코드%TYPE -- 중복된 컬럼의 값 쓸 때 가급적이면 부모테이블 것으로...
, V_입고수량    IN TBL_입고.입고수량%TYPE
, V_입고단가    IN TBL_입고.입고단가%TYPE
)
IS
    -- 선언부
    -- 아래의 쿼리문을 수행하기 위해 필요한 변수 추가 선언
    V_입고번호  TBL_입고.입고번호%TYPE;
    
BEGIN
    -- 선언한 변수에 값 담아내기
    -- SELECT 쿼리문 수행
    SELECT NVL(MAX(입고번호), 0) INTO V_입고번호 -- 쿼리문에서 얻은 값 넣을 땐 이렇게
    FROM TBL_입고;

    -- INSERT 쿼리문 수행
    INSERT INTO TBL_입고(입고번호, 상품코드, 입고수량, 입고단가)
    VALUES((V_입고번호+1), V_상품코드, V_입고수량, V_입고단가);
    
    -- UPDATE 쿼리문 수행
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_입고수량
    WHERE 상품코드 = V_상품코드;
    
    -- 예외 처리 / 자바에서 TRY CATCH 한 것처럼
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; -- 둘 중에 하나만 수행됐을 때 롤백
    
    -- 커밋
    COMMIT; 
    
    -- 커밋이 필요한 DML 구문이 두 개.
    -- 두 개 다 일괄적으로 처리되게.
    -- 트랜잭션
END;
--==>> Procedure PRC_입고_INSERT이(가) 컴파일되었습니다.

--------------------------------------------------------------------------------

--■■■ 프로시저 내에서의 예외 처리 ■■■--




















