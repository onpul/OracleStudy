
-- 1줄 주석문 처리(단일행 주석문 처리) 

/*
여러줄
(다중행)
주석문
처리
*/

--○ 현재 오라클 서버에 접속한 자신의 계정 조회
show user
--==>> USER이(가) "SYS"입니다.
--> sqlplus 상태일 때 사용하는 명령어 (여기서는 안 씀)

-- 오라클이 mysql을 인수했음 / mysql에서 my는 개발자 딸 이름ㅠㅠ
-- 오라클이 mysql 인수하자마자 mysql을 죽이기 시작함 ㅠㅠ 잘 해달라고 했는디...
-- 그래서 mysql 만든 개발자가 다른 딸 이름 붙여서 마리아db만듬...
-- 결론은... 오라클 못 됐다 ㅠㅠ

select user
from dual;
--==>> SYS

SELECT USER
FROM DUAL;  -- 의미 없음.
--==>> SYS
-- 대소문자 구분 안 함.

select 1 + 2
from dual;
--==>> 3

SELECT 1 + 2
FROM DUAL;
--==>> 3

SELECT                     2+   4
FROM             DUAL;
--==>> 6

SELECT 1+5
FROMDUAL;
--==>> 에러 발생
-- (ORA-00923: FROM keyword not found where expected)

SELECT 쌍용강북교육센터 F강의장
FROM DUAL;
--==>> 에러 발생
-- (ORA-00904: "쌍용강북교육센터": invalid identifier)
-- 쌍용~ 이 부분의 데이터의 유형 처리가 에러난 것.

SELECT "쌍용강북교육센터 F강의장"
FROM DUAL;
--==>> 에러 발생
-- (ORA-00972: identifier is too long)

SELECT '쌍용강북교육센터 F강의장'
FROM DUAL;
--==>> 쌍용강북교육센터 F강의장
-- 오라클에서 문자열은 작은 따옴표로 처리!!

SELECT '한 발 한 발 힘겨운 오라클 수업'
FROM DUAL;
--==>> 한 발 한 발 힘겨운 오라클 수업

SELECT 3.14 + 3.14
FROM DUAL;
--==>> 6.28

SELECT 10 * 5
FROM DUAL;
--==>> 50

SELECT 10 * 5.0
FROM DUAL;
--==>> 50

SELECT 4 / 2
FROM DUAL;
--==>> 2

SELECT 4.0 / 2
FROM DUAL;
--==>> 2

SELECT 4.0 / 2.0
FROM DUAL;
--==>> 2

SELECT 5 / 2
FROM DUAL;
--==>> 2.5

SELECT 100 - 23
FROM DUAL;
--==>> 77
