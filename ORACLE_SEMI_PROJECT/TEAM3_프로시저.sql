-- ■■■ 관리자 로그인 프로시저 ■■■
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

--------------------------------------------------------------------------------

-- ■■■ 교수자 로그인 프로시저 ■■■
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

--------------------------------------------------------------------------------

-- ■■■ 학생 로그인 프로시저 ■■■
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

--■■■ 시퀀스 초기화 프로시저 ■■■
CREATE OR REPLACE PROCEDURE PRC_RESET_SEQ
( V_SEQ_NAME IN VARCHAR2 )
IS
    V_SEQ_VAL NUMBER;
BEGIN
    -- 다음시퀀스 값을 SEQ_VAL 변수에 저장
    EXECUTE IMMEDIATE 'SELECT ' || V_SEQ_NAME || '.NEXTVAL FROM DUAL' INTO V_SEQ_VAL;

    -- 현재의 시퀀스에서 저장된 값(SEQ_VAL)을 빼준다. 그럼 0으로 초기화 됨.
    EXECUTE IMMEDIATE 'ALTER SEQUENCE ' || V_SEQ_NAME || ' INCREMENT BY -' || V_SEQ_VAL || ' MINVALUE 0';

    -- 0으로 초기화 된 시퀀스 값을 확인
    EXECUTE IMMEDIATE 'SELECT ' || V_SEQ_NAME || '.NEXTVAL FROM DUAL' INTO V_SEQ_VAL;

    -- 지금부터는 1씩 증가되도록 시퀀스를 변경함.
    EXECUTE IMMEDIATE 'ALTER SEQUENCE ' || V_SEQ_NAME || ' INCREMENT BY 1 MINVALUE 0';
END PRC_RESET_SEQ;
--==>> Procedure PRC_RESET_SEQ이(가) 컴파일되었습니다.

--■■■ 중도 탈락 사유 입력 프로시저 ■■■--
CREATE OR REPLACE PROCEDURE PRC_REASONS_DROPOUT_INSERT
(V_REASON_DROPOUT   IN REASONS_DROPOUT.REASON_DROPOUT%TYPE)
IS
    COUNTNUM    NUMBER;
BEGIN
    
    SELECT COUNT(*) INTO COUNTNUM
    FROM REASONS_DROPOUT;
    
    -- 첫 레코드 입력이면 시퀀스 초기화
    IF (COUNTNUM = 0)
        THEN PRC_RESET_SEQ('SEQ_REASONS_DROPOUT');
    END IF;
    
    INSERT INTO REASONS_DROPOUT(REASONS_DROPOUT_ID, REASON_DROPOUT)
    VALUES(CONCAT('DR', TO_CHAR(LPAD(SEQ_REASONS_DROPOUT.NEXTVAL, 3, 0))), V_REASON_DROPOUT);  
    
    COMMIT;
END;
--==>> Procedure PRC_REASONS_DROPOUT_INSERT이(가) 컴파일되었습니다.

--------------------------------------------------------------------------------

--■■■ 중도 탈락 사유 수정 프로시저 ■■■--
CREATE OR REPLACE PROCEDURE PRC_REASONS_DROPOUT_UPDATE
( V_REASONS_DROPOUT_ID IN REASONS_DROPOUT.REASONS_DROPOUT_ID%TYPE
, V_REASON_DROPOUT    IN REASONS_DROPOUT.REASON_DROPOUT%TYPE
)
IS
BEGIN
    UPDATE REASONS_DROPOUT
    SET REASON_DROPOUT = V_REASON_DROPOUT
    WHERE REASONS_DROPOUT_ID = V_REASONS_DROPOUT_ID;
    
    COMMIT;
END;
--==>> Procedure PRC_REASONS_DROPOUT_UPDATE이(가) 컴파일되었습니다.

--------------------------------------------------------------------------------

--■■■ 중도 탈락 사유 삭제 프로시저 ■■■--
CREATE OR REPLACE PROCEDURE PRC_REASONS_DROPOUT_DELETE
( V_REASONS_DROPOUT_ID IN REASONS_DROPOUT.REASONS_DROPOUT_ID%TYPE )
IS
BEGIN
    DELETE
    FROM REASONS_DROPOUT
    WHERE REASONS_DROPOUT_ID = V_REASONS_DROPOUT_ID;
    
    COMMIT;
END;
--==>> Procedure PRC_REASONS_DROPOUT_DELETE이(가) 컴파일되었습니다.

--------------------------------------------------------------------------------

EXEC PRC_REASONS_DROPOUT_INSERT ('집안사정');
EXEC PRC_REASONS_DROPOUT_INSERT ('조기취업');
EXEC PRC_REASONS_DROPOUT_INSERT ('진로변경');
EXEC PRC_REASONS_DROPOUT_INSERT ('건강악화');

EXEC PRC_REASONS_DROPOUT_DELETE ('DR001');
EXEC PRC_REASONS_DROPOUT_DELETE ('DR002');
EXEC PRC_REASONS_DROPOUT_DELETE ('DR003');
EXEC PRC_REASONS_DROPOUT_DELETE ('DR004');

SELECT *
FROM REASONS_DROPOUT
ORDER BY REASONS_DROPOUT_ID;
