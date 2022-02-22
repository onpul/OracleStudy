SELECT USER
FROM DUAL;
--==>> SCOTT

--○ ROUND() 반올림을 처리해 주는 함수
SELECT 48.678 "COL1"             -- 48.678
     , ROUND(48.678, 2) "COL2"   -- 48.68  -- 소수점 이하 둘째자리까지 표현 → 두 번째 파라미터
     , ROUND(48.674, 2) "COL3"   -- 48.67
     , ROUND(48.674, 1) "COL4"   -- 48.7
     , ROUND(48.674, 0) "COL5"   -- 49     -- 정수로 표현
     , ROUND(48.674) "COL6"      -- 49     -- 두 번째 파라미터 값이 0일 경우 생략 가능(보통 생략을 많이 함)
     , ROUND(48.674, -1) "COL7"  -- 50     -- 십의 자리까지 표현
     , ROUND(48.674, -2) "COL8"  -- 0      -- 백의 자리까지 표현
     , ROUND(68.674, -2) "COL9"  -- 100    -- 천의 자리까지 표현
     , ROUND(48.674, -3) "COL10" -- 0      -- 천의 자리까지 표현
FROM DUAL;

--○ TRUNC() 절삭을 처리해 주는 함수 -- 절삭이면 무조건 뒷부분 날아가는 거
SELECT 48.678 "COL1"             -- 48.678
     , TRUNC(48.678, 2) "COL2"   -- 48.67  -- 소수점 이하 둘째자리까지 표현 → 두 번째 파라미터
     , TRUNC(48.674, 2) "COL3"   -- 48.67
     , TRUNC(48.674, 1) "COL4"   -- 48.6
     , TRUNC(48.674, 0) "COL5"   -- 48     -- 정수로 표현
     , TRUNC(48.674) "COL6"      -- 48     -- 두 번째 파라미터 값이 0일 경우 생략 가능(보통 생략을 많이 함)
     , TRUNC(48.674, -1) "COL7"  -- 40     -- 십의 자리까지 표현
     , TRUNC(48.674, -2) "COL8"  -- 0      -- 백의 자리까지 표현
     , TRUNC(68.674, -2) "COL9"  -- 0
     , TRUNC(48.674, -3) "COL10" -- 0      -- 천의 자리까지 표현
FROM DUAL;


--○ MOD() 나머지를 반환하는 함수 --> 자바에서는 %
SELECT MOD(5, 2) "RESULT"
FROM DUAL;
--==>> 1
--> 5를 2로 나눈 나머지 결과값 반환


--○ POWER() 제곱의 결과를 반환하는 함수
SELECT POWER(5, 3) "RESULT"
FROM DUAL;
--==>> 125
--> 5의 3승을 결과값으로 반환


--○ SQRT() 루트 결과값을 반환하는 함수
SELECT SQRT(2) "RESULT"
FROM DUAL;
--==>> 1.41421356237309504880168872420969807857
--> 루트 2에 대한 결과값 반환


--○ LOG() 로그 함수
--   (오라클은 상용로그만 지원하는 반면, MSSQL은 상용로그·자연로그 모두 지원한다.)
SELECT LOG(10, 100) "COL1"
     , LOG(10, 20) "COL2"
FROM DUAL;
--==>> 2	1.30102999566398119521373889472449302677


--○ 삼각함수
SELECT SIN(1), COS(1), TAN(1)
FROM DUAL;
--==>> 0.8414709848078965066525023216302989996233	
--     0.5403023058681397174009366074429766037354	
--     1.55740772465490223050697480745836017308
--> 각각 싸인, 코싸인, 탄젠트 결과값을 반환한다.


--○ 삼각함수의 역함수(범위 : -1 ~ 1)
SELECT ASIN(0.5), ACOS(0.5), ATAN(0.5)
FROM DUAL;
--==>> 0.52359877559829887307710723054658381405
--     1.04719755119659774615421446109316762805
--     0.4636476090008061162142562314612144020295
--> 각각 어싸인, 어코싸인, 어탄젠트 결과값을 반환한다.


--○ SIGN() 서명, 부호, 특징(시그니처)
--> 연산 결과값이 양수이면 1, 0이면 0, 음수이면 -1을 반환한다.
SELECT SIGN(5-2) "COL1", SIGN(5-5) "COL2", SIGN(5-8) "COL3"
FROM DUAL;
--==>> 1	0	-1
--    양   영   음
--> 매출이나 수지와 관련하여 적자 및 흑자의 개념을 나타낼 때 사용된다.


--○ ASCII(), CHR() → 서로 대응(상응)하는 함수
SELECT ASCII('A') "COL1"
     , CHR(65) "COL2"
FROM DUAL;
--==>> 65	A
--> 『ASCII()』 : 매개변수로 넘겨받은 문자의 아스키코드 값을 반환한다.
--  『CHR()』   : 매개변수로 넘겨받은 아스키코드 값으로 해당 문자를 반환한다.

--------------------------------------------------------------------------------

--※ 날짜 관련 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.


--※ 날짜 연산의 기본 단위는 DAY(일수) 이다~!!!
SELECT SYSDATE "COL1"        -- 2022-02-22 09:43:52
     , SYSDATE + 1 "COL2"    -- 2022-02-23 09:43:52 → 하루 뒤
     , SYSDATE - 2 "COL3"    -- 2022-02-20 09:43:52 → 이틀 전
     , SYSDATE -30 "COL4"    -- 2022-01-23 09:43:52 → 30일 전
FROM DUAL;


--○ 시간 단위 연산
SELECT SYSDATE "COL1"           -- 2022-02-22 09:46:13 
     , SYSDATE + 1/24 "COL2"    -- 2022-02-22 10:46:13 → 한 시간 뒤
     , SYSDATE - 2/24 "COL3"    -- 2022-02-22 07:46:13 → 두 시간 전
FROM DUAL;


--○ 현재 시간과... 현재 시간 기준 1일 2시간 3분 4초 후를 조회하는 쿼리문을 구성한다.
/*
------------------------ ------------------------
 현재 시간                연산 후 시간
------------------------ ------------------------
2022-02-22 10:03:21      2022-02-23 12:05:25
*/
-- 내 풀이
SELECT SYSDATE "현재 시간"
     , SYSDATE + 1 + 2/24 + 3/1440 + 4/86400 "연산 후 시간"
FROM DUAL;
--==>> 2022-02-22 10:05:36	
--     2022-02-23 12:08:40

-- 수업 풀이
-- 방법 1.
SELECT SYSDATE "현재 시간"
     , SYSDATE + 1 + (2/24) + ((3/24*60)) + (4/(24*60*60)) "연산 후 시간"
FROM DUAL;
--==>> 2022-02-22 10:18:25
--     2022-03-03 00:18:29

-- 방법 2.
SELECT SYSDATE "현재 시간"
     , SYSDATE + ((1*24*60*60) + (2*60*60) + (3*60) + 4) / (24*60*60)  "연산 후 시간"
FROM DUAL;
--==>> 2022-02-22 10:20:13	
--     2022-02-23 12:23:17


--○ 날짜 - 날짜 = 일수
SELECT TO_DATE('2022-06-20', 'YYYY-MM-DD') - TO_DATE('2022-02-22', 'YYYY-MM-DD') "RESULT"
FROM DUAL;
--==>> 118
--     앞에 있는 연산자가 값이 크다 -> 미래


--○ 데이터 타입의 변환
SELECT TO_DATE('2022-06-20', 'YYYY-MM-DD') "RESULT"
FROM DUAL;
--==>> 2022-06-20 00:00:00

SELECT TO_DATE('2022-06-35', 'YYYY-MM-DD') "RESULT"
FROM DUAL;
--==>> 에러 발생
--     (ORA-01847: day of month must be between 1 and last day of month)

SELECT TO_DATE('2022-02-29', 'YYYY-MM-DD') "RESULT"
FROM DUAL;
--==>> 에러 발생
--     (ORA-01839: date not valid for month specified)

SELECT TO_DATE('2022-13-29', 'YYYY-MM-DD') "RESULT"
FROM DUAL;
--==>> 에러 발생
--     (ORA-01843: not a valid month)


--※ TO_DATE() 함수를 통해 문자 타입을 날짜 타입으로 변환을 수행하는 과정에서
--   내부적으로 해당 날짜에 대한 유효성 검사가 이루어진다.


--○ ADD_MONTHS() 개월 수를 더해주는 함수
SELECT SYSDATE "COL1"
     , ADD_MONTHS(SYSDATE, 2) "COL2" 
     , ADD_MONTHS(SYSDATE, 3) "COL3"
     , ADD_MONTHS(SYSDATE, -2) "COL4"
     , ADD_MONTHS(SYSDATE, -3) "COL5"
FROM DUAL;
--==>>
/*
2022-02-22 10:29:55    → 현재
2022-04-22 10:29:55	   → 2개월 후
2022-05-22 10:29:55	   → 3개월 후
2021-12-22 10:29:55	   → 2개월 전 
2021-11-22 10:29:55    → 3개월 전
*/
--> 월을 더하고 빼기


--○ MONTHS_BETWEEN()
--   첫 번째 인자값에서 두 번째 인자값을 뺀 개월 수를 반환한다.
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2002-05-31', 'YYYY-MM-DD')) "RESULT"
FROM DUAL;
--==>> 236.72387470131421744324970131421744325

--> 개월 수의 차이를 반환하는 함수
--  결과값의 부호가 『-』로 반환되었을 경우에는
--  첫 번째 인자값에 해당하는 날짜보다
--  두 번째 인자값에 해당하는 날짜가 『미래』라는 의미로 확인할 수 있다.


--○ NEXT_DAY()
SELECT NEXT_DAY(SYSDATE, '토') "COL1"
     , NEXT_DAY(SYSDATE, '월') "COL2"
FROM DUAL;
--==>> 2022-02-26 10:37:45
--     2022-02-28 10:38:22


--※ 세션 설정 변경
ALTER SESSION SET NLS_DATE_LANGUAGE = 'ENGLISH';
--==>> Session이(가) 변경되었습니다.

SELECT NEXT_DAY(SYSDATE, '토') "COL1"
     , NEXT_DAY(SYSDATE, '월') "COL2"
FROM DUAL;
--==>> 에러 발생
--     (ORA-01846: not a valid day of the week)

SELECT NEXT_DAY(SYSDATE, 'SAT') "COL1"
     , NEXT_DAY(SYSDATE, 'MON') "COL2"
FROM DUAL;
--==>> 2022-02-26 10:40:21
--     2022-02-28 10:40:21

--※ 세션 설정 다시 변경
ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
--==>> Session이(가) 변경되었습니다.

SELECT NEXT_DAY(SYSDATE, 'SAT') "COL1"
     , NEXT_DAY(SYSDATE, 'MON') "COL2"
FROM DUAL;
--==>> 에러 발생
--     (ORA-01846: not a valid day of the week)

SELECT NEXT_DAY(SYSDATE, '토') "COL1"
     , NEXT_DAY(SYSDATE, '월') "COL2"
FROM DUAL;
--==>> 2022-02-26 10:42:14
--     2022-02-28 10:42:14


--○ LAST_DAY()
--> 해당 날짜가 포함되어 있는 그 달의 마지막 날을 반환한다.
SELECT LAST_DAY(SYSDATE) "COL1"
     , LAST_DAY(TO_DATE('2020-02-10', 'YYYY-MM-DD')) "COL2"
     , LAST_DAY(TO_DATE('2019-02-10', 'YYYY-MM-DD')) "COL2"
FROM DUAL;
--==> 2022-02-28 10:44:39 → 평년	
--    2020-02-29 00:00:00 → 윤년	
--    2019-02-28 00:00:00 → 평년


--※ 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.


--○ 오늘부로... 상기가 군대에 다시 끌려(?)간다...
--   복무기간은 22개월로 한다.

-- 1. 전역 일자를 구한다.
SELECT ADD_MONTHS(SYSDATE, 22)
FROM DUAL;
--==>> 2023-12-22
-- 2. 하루 꼬박꼬박 3끼 식사를 한다고 가정하면
--    상기가 몇 끼를 먹어야 집에 보내줄까...
-- (전역일자 - 현재일자) * 3
SELECT (ADD_MONTHS(SYSDATE, 22) - SYSDATE) *3
FROM DUAL;
--==>> 2004

-- 내 풀이
SELECT SYSDATE "오늘 날짜"
     , ADD_MONTHS(SYSDATE, 22) "전역 일자"
     , ((ADD_MONTHS(SYSDATE, 22) - SYSDATE) * 3) "몇 끼를 먹어야 할까"
FROM DUAL;
--==>> 2022-02-22	2023-12-22	2004


--○ 현재 날짜 및 시각으로부터...
--   수료일(2022-06-20 18:00:00)까지
--   남은 기간을... 다음과 같은 형태로 조회할 수 있도록 쿼리문을 구성한다.
/*
--------------------------------------------------------------------------------
현재시각             | 수료일               | 일   | 시간  | 분  | 초  |
--------------------------------------------------------------------------------
2022-02-22 11:34:35  | 2022-06-20 18:00:00  | 117  | 7     | 15  | 15  |
*/

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.

-- 내 풀이 
SELECT SYSDATE "현재시각"
     , TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "수료일"
     , TRUNC(TO_DATE('2022-06-20', 'YYYY-MM-DD') - SYSDATE) "일"
     , TRUNC(MOD((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE),1)*24) "시간"
     , TRUNC(MOD((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE)*24,1)*60) "분"
     , TRUNC(ROUND(MOD((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE)*24*60,1)*60)) "초"
FROM DUAL;


SELECT TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE -- 118.161053240740740740740740740740740741
     , MOD((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE),1)*24 "시간"
FROM DUAL;
--> MOD함수 1로 나누면 --> 나머지는 소수점만 (정수=지난 일은 떨어져 나감)
--  나머지는 ? 남은 시간, 분, 초
--  *24 -> 시간

SELECT MOD((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE), 0) "전체값" --118.15712962962962962962962962962962963
     , MOD((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE), 1) "정수 버려" --0.15712962962962962962962962962962963
     , MOD((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE), 1)*24 "시간" --날수에다 24곱해야 시간
     , MOD((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE)*24, 1)*60 "분" --24곱해서 시간화 -> 정수 버려 -> *60
FROM DUAL;
--> 분은...? 시간 구한 거에서 정수 버림 --> *60
--  초는 분 구한 거에서 정수 버림 --> *60
