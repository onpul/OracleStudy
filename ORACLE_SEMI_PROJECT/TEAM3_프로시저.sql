SELECT USER
FROM DUAL;
--==>> TEAM3

-- 프로시저 생성 권한 부여(SYS 계정에서)
GRANT CREATE PROCEDURE TO TEAM3;
--==>> Grant을(를) 성공했습니다.

-- 테스트 용 데이터 입력(테스트 후 삭제 완료)
SELECT * --DELETE
FROM ADMIN;

INSERT INTO ADMIN(ADMIN_ID, ADMIN_NAME, SSN, PASSWORD, REGIST_DATE)
VALUES('1234', 'TEST1', '123456-1234567', '1234567', SYSDATE);

-- 환경변수 설정
SET SERVEROUTPUT ON;

-- 프로시저 테스트
EXEC PRC_LOGIN_ADMIN('0000', '1234567');
--==>> TEST1 관리자님 어서오세요. 

--------------------------------------------------------------------------------

--■■■ 로그인 프로시저 ■■■--

-- 로그인 프로시저 (관리자)
CREATE OR REPLACE PROCEDURE PRC_LOGIN_ADMIN
( V_ID  IN ADMIN.ADMIN_ID%TYPE
, V_PW  IN ADMIN.PASSWORD%TYPE
)

IS
    V_IDCOUNT   NUMBER; -- ID 있는지 카운트한 수 
    V_NAME      ADMIN.ADMIN_NAME%TYPE; -- 이름 변수
    V_PWTEMP    ADMIN.PASSWORD%TYPE;  -- 비밀번호(등록되어 있는 비밀번호)
    
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2  EXCEPTION;
    
BEGIN
    -- 1. ID가 있는지 확인
    SELECT COUNT(*) INTO V_IDCOUNT
    FROM ADMIN
    WHERE ADMIN_ID = V_ID;
    
    -- 입력한 아이디가 테이블에 없으면 에러 발생(등록되지 않은 아이디)
    IF (V_IDCOUNT = 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 2. 아이디와 비밀번호가 일치하는지 확인
    SELECT PASSWORD INTO V_PWTEMP
    FROM ADMIN
    WHERE ADMIN_ID = V_ID;
    
    -- 비밀번호 다르면 에러 발생
    IF (V_PWTEMP != V_PW)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    -- 3. 아이디, 비밀번호 부합 시     
    SELECT ADMIN_NAME INTO V_NAME
    FROM ADMIN
    WHERE ADMIN_ID = V_ID;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' 관리자님 어서오세요.');
    
    -- 4. 에러 처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '등록되지 않은 아이디입니다.');
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20002, '아이디 또는 비밀번호가 일치하지 않습니다.');
END;


-- 로그인 프로시저 (교수)
CREATE OR REPLACE PROCEDURE PRC_LOGIN_PROF
( V_ID  IN PROF.PROF_ID%TYPE
, V_PW  IN PROF.PASSWORD%TYPE
)

IS
    V_IDCOUNT   NUMBER; -- ID 있는지 카운트한 수 
    V_NAME      PROF.PROF_NAME%TYPE; -- 이름 변수
    V_PWTEMP    PROF.PASSWORD%TYPE;  -- 비밀번호(등록되어 있는 비밀번호)
    
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2  EXCEPTION;
    
BEGIN
    -- 1. ID가 있는지 확인
    SELECT COUNT(*) INTO V_IDCOUNT
    FROM PROF
    WHERE PROF_ID = V_ID;
    
    -- 입력한 아이디가 테이블에 없으면 에러 발생(등록되지 않은 아이디)
    IF (V_IDCOUNT = 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 2. 아이디와 비밀번호가 일치하는지 확인
    SELECT PASSWORD INTO V_PWTEMP
    FROM PROF
    WHERE PROF_ID = V_ID;
    
    -- 비밀번호 다르면 에러 발생
    IF (V_PWTEMP != V_PW)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    -- 3. 아이디, 비밀번호 부합 시     
    SELECT PROF_NAME INTO V_NAME
    FROM PROF
    WHERE PROF_ID = V_ID;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' 교수자님 어서오세요.');
    
    -- 4. 에러 처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '등록되지 않은 아이디입니다.');
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20002, '아이디 또는 비밀번호가 일치하지 않습니다.');
END;


-- 로그인 프로시저 (학생)
CREATE OR REPLACE PROCEDURE PRC_LOGIN_STU
( V_ID  IN STU.STU_ID%TYPE
, V_PW  IN STU.PASSWORD%TYPE
)

IS
    V_IDCOUNT   NUMBER; -- ID 있는지 카운트한 수 
    V_NAME      STU.STU_NAME%TYPE; -- 이름 변수
    V_PWTEMP    STU.PASSWORD%TYPE;  -- 비밀번호(등록되어 있는 비밀번호)
    
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2  EXCEPTION;
    
BEGIN
    -- 1. ID가 있는지 확인
    SELECT COUNT(*) INTO V_IDCOUNT
    FROM STU
    WHERE STU_ID = V_ID;
    
    -- 입력한 아이디가 테이블에 없으면 에러 발생(등록되지 않은 아이디)
    IF (V_IDCOUNT = 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 2. 아이디와 비밀번호가 일치하는지 확인
    SELECT PASSWORD INTO V_PWTEMP
    FROM STU
    WHERE STU_ID = V_ID;
    
    -- 비밀번호 다르면 에러 발생
    IF (V_PWTEMP != V_PW)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    -- 3. 아이디, 비밀번호 부합 시     
    SELECT STU_NAME INTO V_NAME
    FROM STU
    WHERE STU_ID = V_ID;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' 학생님 어서오세요.');
    
    -- 4. 에러 처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '등록되지 않은 아이디입니다.');
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20002, '아이디 또는 비밀번호가 일치하지 않습니다.');
END;

--------------------------------------------------------------------------------

--■■■ 중도 탈락 정보 입력 프로시저 ■■■--
CREATE OR REPLACE PROCEDURE PRC_REASONS_DROPOUT_INSERT
( V_REASONS_DROPOUT_ID  IN REASONS_DROPOUT.REASONS_DROPOUT_ID%TYPE
, V_REASON_DROPOUT      IN REASONS_DROPOUT.REASON_DROPOUT%TYPE
)
IS
BEGIN
END;




