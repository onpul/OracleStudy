SELECT USER
FROM DUAL;
--==>> SCOTT

SELECT *
FROM TBL_SAWON;

--○ TBL_SAWON 테이블을 활용하여 
--   다음과 같은 항목들을 조회할 수 있도록 쿼리문을 구성한다.
--   사원번호, 사원명, 주민번호, 성별, 입사일

SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남성' 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여성'
            ELSE '성별확인불가' 
       END "성별"
     , HIREDATE"입사일"
FROM TBL_SAWON;
--==>>
/*
1001	김민성	    9707251234567	남성	2005-01-03
1002	서민지	    9505152234567	여성	1999-11-23
1003	이지연	    9905192234567	여성	2006-08-10
1004	이연주	    9508162234567	여성	2007-10-10
1005	오이삭	    9805161234567	남성	2007-10-10
1006	이현이	    8005132234567	여성	1999-10-10
1007	박한이	    0204053234567	남성	2010-10-10
1008	선동렬	    6803171234567	남성	1998-10-10
1009	선우용녀	6912232234567	여성	1998-10-10
1010	선우선	    0303044234567	여성	2010-10-10
1011	남주혁	    0506073234567	남성	2012-10-10
1012	남궁민	    0208073234567	남성	2012-10-10
1013	남진	    6712121234567	남성	1998-10-10
1014	홍수민	    0005044234567	여성	2015-10-10
1015	임소민	    9711232234567	여성	2007-10-10
1016	이이경	    0603194234567	여성	2015-01-20
*/


--○ TBL_SAWON 테이블을 활용하여 
--   다음과 같은 항목들을 조회할 수 있도록 쿼리문을 구성한다.
--   『사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일, 
--     정년퇴직일, 근무일수, 남은일수, 급여, 보너스』
--   단, 현재나이는 기본 한국나이 계산법에 따라 연산을 수행한다.
--   또한, 정년퇴직일은 해당 직원의 나이가 한국나이로 60세가 되는 해의
--   그 직원의 입사 월, 일로 연산을 수행한다.
--   그리고, 보너스는 1000일 이상 2000일 미만 근무한 사원은
--   그 사원의 원래 급여 기준 30% 지급, 2000일 이상 근무한 사원은
--   그 사원의 원래 급여 기준 50% 지급을 할 수 있도록 처리한다.

--EX) 1001 김민성 9707251234567 남성 26 2005-01-03 2056-01-03 212121 2232323 3000 1500

SELECT *
FROM TBL_SAWON;

-- 수업 풀이

-- 사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일, 급여 ... 먼저
SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
    -- 성별
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남성'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여성'
            ELSE '성별확인불가'
       END "성별"
    -- 현재나이 = 현재년도 - 태어난년도 + 1 (1900년대 / 2000년대)
     , CASE WHEN 1900년대생이라면 THEN 현재년도 - (주민번호앞두자리 + 1899) 
            WHEN 1900년대생이라면 THEN 현재년도 - (주민번호앞두자리 + 1999) 
            ELSE END "현재나이"
FROM TBL_SAWON;

SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
    -- 성별
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남성'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여성'
            ELSE '성별확인불가'
       END "성별"
    -- 현재나이 = 현재년도 - 태어난년도 + 1 (1900년대 / 2000년대)
     , CASE WHEN 주민번호 7번째자리 1개가 '1'또는 '2' 
            THEN 현재년도 - (주민번호앞두자리 + 1899) 
            WHEN 주민번호 7번째자리 1개가 '3'또는 '4' 
            THEN 현재년도 - (주민번호앞두자리 + 1999) 
            ELSE -1 
       END "현재나이"
       
FROM TBL_SAWON;

SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
    -- 성별
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남성'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여성'
            ELSE '성별확인불가'
       END "성별"
    -- 현재나이 = 현재년도 - 태어난년도 + 1 (1900년대 / 2000년대)
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (주민번호앞두자리 + 1899) 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (주민번호앞두자리 + 1999) 
            ELSE -1 
       END "현재나이"
       
FROM TBL_SAWON;

SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
    -- 성별
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남성'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여성'
            ELSE '성별확인불가'
       END "성별"
    -- 현재나이 = 현재년도 - 태어난년도 + 1 (1900년대 / 2000년대)
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
            ELSE -1 
       END "현재나이"
    -- 입사일
     , HIREDATE "입사일"   
    -- 급여
     , SAL
FROM TBL_SAWON;

--● 하위 컬럼???? FROM 안에 SELECT 문 넣어 버리기!!!

SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM, 0) "연봉"
FROM EMP;

SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM, 0) "연봉", 연봉*2 "두배연봉"
FROM EMP;
--==> 에러 발생
--    (ORA-00904: "연봉": invalid identifier)

SELECT T.EMPNO, T.ENAME, T.SAL, T.연봉, T.연봉*2 "두배연봉"
FROM
(
    SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM, 0) "연봉"
    FROM EMP
) T;

SELECT T.*
FROM
(
    SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM, 0) "연봉"
    FROM EMP
) T;


-- 사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일, 
-- , 정년퇴직일, 근무일수, 남은일수, 급여, 보너스
SELECT T.사원번호, T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일
    -- 정년퇴직일
    -- 정년퇴직년도 → 해당 직원의 나이가 한국나이로 60세가 되는 해
    -- 현재 나이가... 57세...  3년 후        2022 → 2025
    -- 현재 나이가... 28세... 32년 후        2022 → 2054
    -- ADD_MONTHS(SYSDATE, 남은년수*12)
    --                     --------
    --                      60 - 현재나이
    -- ADD_MONTHS(SYSDATE, (60 - 현재나이) * 12) → 특정날짜
    -- TO_CHAR('특정날짜', 'YYYY')     → 정년퇴직 년도만 문자타입으로 추출
    -- TO_CHAR(입사일, 'MM-DD')        → 입사 월일만 문자타입으로 추출
    -- TO_CHAR('특정날짜', 'YYYY') || '-' || TO_CHAR(입사일, 'MM-DD') "정년퇴직일"
    -- TO_CHAR(ADD_MONTHS(SYSDATE, (60 - 현재나이) * 12), 'YYYY') || '-' || TO_CHAR(입사일, 'MM-DD') "정년퇴직일"
    , TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이) * 12), 'YYYY') || '-' || TO_CHAR(T.입사일, 'MM-DD') "정년퇴직일"
    
    -- 근무일수
    -- 근무일수 = 현재일 - 입사일
     , TRUNC(SYSDATE - T.입사일) "근무일수"
     
    -- 남은일수
    -- 남은일수 = 정년퇴직일 - 현재일
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이) * 12), 'YYYY') || '-' || TO_CHAR(T.입사일, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "남은일수"
     
    -- 급여
    , T.급여
    
    -- 보너스
    -- 근무일수가 1000일 이상 2000일 미만 → 원래 급여의 30% 지급
    -- 근무일수가 2000일 이상             → 원래 급여의 50% 지급
    -- 나머지                             → 0     
    -------------------------------------------------------------
    -- 근무일수 2000일 이상               → T.급여 * 0.5
    -- 근무일수 1000일 이상               → T.급여 * 0.3
    -- 나머지                             → 0     
    -------------------------------------------------------------
    , CASE WHEN TRUNC(SYSDATE - T.입사일) >= 2000 THEN T.급여 * 0.5
           WHEN TRUNC(SYSDATE - T.입사일) >= 1000 THEN T.급여 * 0.3
           ELSE 0
      END "보너스"
FROM 
(
    SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
        -- 성별
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남성'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여성'
                ELSE '성별확인불가'
           END "성별"
        -- 현재나이 = 현재년도 - 태어난년도 + 1 (1900년대 / 2000년대)
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
                ELSE -1 
           END "현재나이"
        -- 입사일
         , HIREDATE "입사일"   
        -- 급여
         , SAL "급여"
    FROM TBL_SAWON
) T;
--==>>
/*
1001	김민성	    9707251234567	남성	26	2005-01-03	2056-01-03	6260	12366	3000	1500
1002	서민지	    9505152234567	여성	28	1999-11-23	2054-11-23	8128	11960	4000	2000
1003	이지연	    9905192234567	여성	24	2006-08-10	2058-08-10	5676	13316	3000	1500
1004	이연주	    9508162234567	여성	28	2007-10-10	2054-10-10	5250	11916	4000	2000
1005	오이삭	    9805161234567	남성	25	2007-10-10	2057-10-10	5250	13012	4000	2000
1006	이현이	    8005132234567	여성	43	1999-10-10	2039-10-10	8172	 6437	1000	 500
1007	박한이	    0204053234567	남성	21	2010-10-10	2061-10-10	4154	14473	1000	 500
1008	선동렬	    6803171234567	남성	55	1998-10-10	2027-10-10	8537	 2054	1500	 750
1009	선우용녀	6912232234567	여성	54	1998-10-10	2028-10-10	8537	 2420	1300	 650
1010	선우선	    0303044234567	여성	20	2010-10-10	2062-10-10	4154	14838	1600	 800
1011	남주혁	    0506073234567	남성	18	2012-10-10	2064-10-10	3423	15569	2600	1300
1012	남궁민	    0208073234567	남성	21	2012-10-10	2061-10-10	3423	14473	2600	1300
1013	남진	    6712121234567	남성	56	1998-10-10	2026-10-10	8537	 1689	2200	1100
1014	홍수민	    0005044234567	여성	23	2015-10-10	2059-10-10	2328	13742	5200	2600
1015	임소민	    9711232234567	여성	26	2007-10-10	2056-10-10	5250	12647	5500	2750
1016	이이경	    0603194234567	여성	17	2015-01-20	2065-01-20	2591	15671	1500	 750
*/
--==>> 인라인 뷰!!! 라고 함 (FROM 절에서 쓰는 서브 쿼리)

--○ TBL_SAWON 테이블에 데이터 추가 입력
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1017, '이호석', '9611121234567', SYSDATE, 5000); 
--==>> 1 행 이(가) 삽입되었습니다.

--○ 확인
SELECT *
FROM TBL_SAWON;

--○ 커밋
COMMIT;
--==>> 커밋 완료.

SELECT T.사원번호, T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일
    , TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이) * 12), 'YYYY') || '-' || TO_CHAR(T.입사일, 'MM-DD') "정년퇴직일"
     , TRUNC(SYSDATE - T.입사일) "근무일수"
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이) * 12), 'YYYY') || '-' || TO_CHAR(T.입사일, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "남은일수"
    , T.급여
    , CASE WHEN TRUNC(SYSDATE - T.입사일) >= 2000 THEN T.급여 * 0.5
           WHEN TRUNC(SYSDATE - T.입사일) >= 1000 THEN T.급여 * 0.3
           ELSE 0
      END "보너스"
FROM 
(
    SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남성'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여성'
                ELSE '성별확인불가'
           END "성별"
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
                ELSE -1 
           END "현재나이"
         , HIREDATE "입사일"   
         , SAL "급여"
    FROM TBL_SAWON
) T;
--==>>
/*
1001	김민성	    9707251234567	남성	26	2005-01-03	2056-01-03	6260	12366	3000	1500
1002	서민지	    9505152234567	여성	28	1999-11-23	2054-11-23	8128	11960	4000	2000
1003	이지연	    9905192234567	여성	24	2006-08-10	2058-08-10	5676	13316	3000	1500
1004	이연주	    9508162234567	여성	28	2007-10-10	2054-10-10	5250	11916	4000	2000
1005	오이삭	    9805161234567	남성	25	2007-10-10	2057-10-10	5250	13012	4000	2000
1006	이현이	    8005132234567	여성	43	1999-10-10	2039-10-10	8172	 6437	1000	 500
1007	박한이     	0204053234567	남성	21	2010-10-10	2061-10-10	4154	14473	1000	 500
1008	선동렬	    6803171234567	남성	55	1998-10-10	2027-10-10	8537	 2054	1500	 750
1009	선우용녀	6912232234567	여성	54	1998-10-10	2028-10-10	8537	 2420	1300	 650
1010	선우선	    0303044234567	여성	20	2010-10-10	2062-10-10	4154	14838	1600	 800
1011	남주혁	    0506073234567	남성	18	2012-10-10	2064-10-10	3423	15569	2600	1300
1012	남궁민	    0208073234567	남성	21	2012-10-10	2061-10-10	3423	14473	2600	1300
1013	남진	    6712121234567	남성	56	1998-10-10	2026-10-10	8537	 1689	2200	1100
1014	홍수민	    0005044234567	여성	23	2015-10-10	2059-10-10	2328	13742	5200	2600
1015	임소민	    9711232234567	여성	26	2007-10-10	2056-10-10	5250	12647	5500	2750
1016	이이경	    0603194234567	여성	17	2015-01-20	2065-01-20	2591	15671	1500	 750
1017	이호석	    9611121234567	남성	27	2022-02-23	2055-02-23	   0	12052	5000	   0
*/


-- 위에서 처리한 내용을 기반으로 
-- 특정 근무일수의 사원을 확인해야 한다거나...
-- 특정 보너스 금액을 받는 사원을 확인해야 할 경우가 발생할 수 있다.
-- 이와 같은 경우... 해당 쿼리문을 다시 구성해야 하는 번거로움을 줄일 수 있도록
-- 뷰(VIEW)를 만들어 저장해 둘 수 있다.

CREATE TABLE TBL_SAWON
-- 이 테이블은 이미 있으니 못 만드는데요???? 하고 에러남
-- 이미 존재한다...

CREATE OR REPLACE TABLE TBL_SAWON
-- 이것도 에러남

-- 엄밀히 말하면 쿼리문이 저장되는 것, 데이터 저장이 아니라 이런 각도를 보고 싶어! 하는 거
CREATE OR REPLACE VIEW VIEW_SAWON -- 이미 만들어져 있더라도 덮어쓰기 됨










SELECT T.사원번호, T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일
    , TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이) * 12), 'YYYY') || '-' || TO_CHAR(T.입사일, 'MM-DD') "정년퇴직일"
     , TRUNC(SYSDATE - T.입사일) "근무일수"
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이) * 12), 'YYYY') || '-' || TO_CHAR(T.입사일, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "남은일수"
    , T.급여
    , CASE WHEN TRUNC(SYSDATE - T.입사일) >= 2000 THEN T.급여 * 0.5
           WHEN TRUNC(SYSDATE - T.입사일) >= 1000 THEN T.급여 * 0.3
           ELSE 0
      END "보너스"
FROM 
(
    SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남성'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여성'
                ELSE '성별확인불가'
           END "성별"
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
                ELSE -1 
           END "현재나이"
         , HIREDATE "입사일"   
         , SAL "급여"
    FROM TBL_SAWON
) T;








-- 내 풀이 ---------------------------------------------------------------------
-- 남은일수 수정해야 함!!!
SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호", 
       CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남성' 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여성'
            ELSE '성별 확인불가' 
       END "성별",  
       CASE WHEN TO_NUMBER(SUBSTR(JUBUN, 1, 1)) > 0 
            THEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER('19'||(SUBSTR(JUBUN, 1, 2))) + 1
            WHEN TO_NUMBER(SUBSTR(JUBUN, 1, 1)) = 0 
            THEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER('20'||(SUBSTR(JUBUN, 1, 2))) + 1
            ELSE 0 
       END "현재나이"
       , HIREDATE "입사일", 
       CASE WHEN TO_NUMBER(SUBSTR(JUBUN, 1, 1)) > 0 
            THEN TO_CHAR(ADD_MONTHS(SYSDATE, ((60 - (TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER('19'||(SUBSTR(JUBUN, 1, 2))) + 1))*12)), 'YYYY') || '-' || TO_CHAR(HIREDATE, 'MM-DD') 
            WHEN TO_NUMBER(SUBSTR(JUBUN, 1, 1)) = 0 
            THEN TO_CHAR(ADD_MONTHS(SYSDATE, ((60 - (TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER('20'||(SUBSTR(JUBUN, 1, 2))) + 1))*12)), 'YYYY') || '-' || TO_CHAR(HIREDATE, 'MM-DD')
            ELSE '정년퇴직일 확인불가' 
       END "정년퇴직일"
       , TRUNC(SYSDATE - HIREDATE) "근무일수", 
       CASE WHEN TO_NUMBER(SUBSTR(JUBUN, 1, 1)) > 0 
            THEN TRUNC(ADD_MONTHS(SYSDATE, ((60 - (TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER('19'||(SUBSTR(JUBUN, 1, 2))) + 1))*12)) - SYSDATE)
            WHEN TO_NUMBER(SUBSTR(JUBUN, 1, 1)) = 0 
            THEN TRUNC(ADD_MONTHS(SYSDATE, ((60 - (TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER('20'||(SUBSTR(JUBUN, 1, 2))) + 1))*12)) - SYSDATE)
            ELSE 0 
       END "남은일수", 
       SAL "급여", 
       CASE WHEN TRUNC(SYSDATE - HIREDATE) >= 1000 AND TRUNC(SYSDATE - HIREDATE) < 2000
            THEN SAL * 0.3
            WHEN TRUNC(SYSDATE - HIREDATE) >= 2000
            THEN SAL * 0.5
            ELSE 0
       END "보너스"
FROM TBL_SAWON;

-- 보너스 구하기
SELECT CASE WHEN TRUNC(SYSDATE - HIREDATE) >= 1000 AND TRUNC(SYSDATE - HIREDATE) < 2000
            THEN TO_CHAR(SAL * 0.3)
            WHEN TRUNC(SYSDATE - HIREDATE) >= 2000
            THEN TO_CHAR(SAL * 0.5)
            ELSE '보너스 판정불가'
       END "보너스"
FROM TBL_SAWON;

-- 정년퇴직일 구하기
SELECT TO_CHAR(ADD_MONTHS(SYSDATE, ((60 - (TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER('19'||(SUBSTR(JUBUN, 1, 2))) + 1))*12)), 'YYYY') || '-' || TO_CHAR(HIREDATE, 'MM-DD')
FROM TBL_SAWON
WHERE SANAME = '김민성';

SELECT (60 - (TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER('19'||(SUBSTR(JUBUN, 1, 2))) + 1)) 
FROM TBL_SAWON
WHERE SANAME = '김민성';

-- 현재나이 구하기
SELECT CASE WHEN TO_NUMBER(SUBSTR(JUBUN, 1, 1)) > 0 
            THEN TO_CHAR(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER('19'||(SUBSTR(JUBUN, 1, 2))) + 1)  
            ELSE '성별확인불가' 
       END "현재나이"
FROM TBL_SAWON;

SELECT TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER('19'||(SUBSTR(JUBUN, 1, 2))) + 1   
FROM TBL_SAWON
WHERE SANAME = '김민성';

SELECT CASE WHEN TO_NUMBER(SUBSTR(JUBUN, 1, 1)) > 0  THEN '1' 
            ELSE '성별확인불가' 
       END "성별"
FROM TBL_SAWON

