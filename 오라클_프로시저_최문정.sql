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