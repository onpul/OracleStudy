SELECT USER
FROM DUAL;
--==>> SCOTT


--※ BETWEEN ⓐ AND ⓑ 는 날짜형, 숫자형, 문자형 데이터 모두에 적용된다.
--   단, 문자형일 경우 아스키코드 순서를 따르기 때문에 (사전식 배열)
--   대문자가 앞쪽에 위치하고 소문자가 뒤쪽에 위치한다.
--   또한, BETWEEN ⓐ AND ⓑ는 해당 구문이 수행되는 시점에서
--   오라클 내부적으로는 부등호 연산자의 형태로 바뀌어 연산 처리된다.

SELECT ASCII('A') "COL1", ASCII('B') "COL2", ASCII('a') "COL3", ASCII('b') "COL4"
FROM DUAL;
--==>> 65	66	97	98


SELECT ENAME, JOB, SAL
FROM TBL_EMP
WHERE JOB = 'SALESMAN'
   OR JOB = 'CLERK';
--==>>
/*
SMITH	CLERK	     800
ALLEN	SALESMAN	1600
WARD	SALESMAN	1250
MARTIN	SALESMAN	1250
TURNER	SALESMAN	1500
ADAMS	CLERK	    1100
JAMES	CLERK	     950
MILLER	CLERK   	1300
호석이	SALESMAN	(null)
문정이	SALESMAN	(null)
*/
   
SELECT ENAME, JOB, SAL
FROM TBL_EMP
WHERE JOB IN('SALESMAN', 'CLERK'); -- 얘도 내부적으로는 위와 같이 실행됨
--==>>
/*
SMITH	CLERK	     800
ALLEN	SALESMAN	1600
WARD	SALESMAN	1250
MARTIN	SALESMAN	1250
TURNER	SALESMAN	1500
ADAMS	CLERK	    1100
JAMES	CLERK	     950
MILLER	CLERK   	1300
호석이	SALESMAN	(null)
문정이	SALESMAN	(null)
*/

SELECT ENAME, JOB, SAL
FROM TBL_EMP
WHERE JOB = ANY ('SALESMAN', 'CLERK'); -- 내부적으로는 OR논리연산 형태로 바뀌어 처리됨
--==>>
/*
SMITH	CLERK	     800
ALLEN	SALESMAN	1600
WARD	SALESMAN	1250
MARTIN	SALESMAN	1250
TURNER	SALESMAN	1500
ADAMS	CLERK	    1100
JAMES	CLERK	     950
MILLER	CLERK   	1300
호석이	SALESMAN	(null)
문정이	SALESMAN	(null)
*/


--※ 위의 3가지 유형의 쿼리문은 모두 같은 결과를 반환한다.
--   하지만, 맨 위의 쿼리문(OR) 이 가장 빠르게 처리된다.
--   물론 메모리에 대한 내용이 아니라 CPU 처리에 대한 내용이므로
--   이 부분까지 감안하여 쿼리문을 구성하게 되는 경우는 많지 않다.
--   → 『IN』 과 『=ANY』는 같은 연산자 효과를 가진다.
--      이들 모두는 내부적으로 『OR』 구조로 변경되어 연산 처리된다.

--------------------------------------------------------------------------------

--○ 추가 실습 테이블 구성(TBL_SAWON)
CREATE TABLE TBL_SAWON
( SANO      NUMBER(4)
, SANAME    VARCHAR2(30)
, JUBUN     CHAR(13)
, HIREDATE  DATE        DEFAULT SYSDATE
, SAL       NUMBER(10)
);
--==>> Table TBL_SAWON이(가) 생성되었습니다.

SELECT *
FROM TBL_SAWON;
--==>> 조회 결과 없음

DESC TBL_SAWON;
--==>>
/*
이름       널? 유형           
-------- -- ------------ 
SANO        NUMBER(4)    
SANAME      VARCHAR2(30) 
JUBUN       CHAR(13)     
HIREDATE    DATE         
SAL         NUMBER(10)
*/

--○ 생성된 테이블에 데이터 입력(TBL_SAWON)
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1001, '김민성', '9707251234567', TO_DATE('2005-01-03', 'YYYY-MM-DD'), 3000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1002, '서민지', '9505152234567', TO_DATE('1999-11-23', 'YYYY-MM-DD'), 4000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1003, '이지연', '9905192234567', TO_DATE('2006-08-10', 'YYYY-MM-DD'), 3000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1004, '이연주', '9508162234567', TO_DATE('2007-10-10', 'YYYY-MM-DD'), 4000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1005, '오이삭', '9805161234567', TO_DATE('2007-10-10', 'YYYY-MM-DD'), 4000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1006, '이현이', '8005132234567', TO_DATE('1999-10-10', 'YYYY-MM-DD'), 1000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1007, '박한이', '0204053234567', TO_DATE('2010-10-10', 'YYYY-MM-DD'), 1000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1008, '선동렬', '6803171234567', TO_DATE('1998-10-10', 'YYYY-MM-DD'), 1500);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1009, '선우용녀', '6912232234567', TO_DATE('1998-10-10', 'YYYY-MM-DD'), 1300);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1010, '선우선', '0303044234567', TO_DATE('2010-10-10', 'YYYY-MM-DD'), 1600);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1011, '남주혁', '0506073234567', TO_DATE('2012-10-10', 'YYYY-MM-DD'), 2600);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1012, '남궁민', '0208073234567', TO_DATE('2012-10-10', 'YYYY-MM-DD'), 2600);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1013, '남진', '6712121234567', TO_DATE('1998-10-10', 'YYYY-MM-DD'), 2200);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1014, '홍수민', '0005044234567', TO_DATE('2015-10-10', 'YYYY-MM-DD'), 5200);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1015, '임소민', '9711232234567', TO_DATE('2007-10-10', 'YYYY-MM-DD'), 5500);

--==>> 1 행 이(가) 삽입되었습니다. * 15

--○ 확인
SELECT *
FROM TBL_SAWON;
--==>>
/*
1001	김민성     	9707251234567	2005-01-03	3000
1002	서민지	    9505152234567	1999-11-23	4000
1003	이지연	    9905192234567	2006-08-10	3000
1004	이연주	    9508162234567	2007-10-10	4000
1005	오이삭	    9805161234567	2007-10-10	4000
1006	이현이	    8005132234567	1999-10-10	1000
1007	박한이	    0204053234567	2010-10-10	1000
1008	선동렬	    6803171234567	1998-10-10	1500
1009	선우용녀	6912232234567	1998-10-10	1300
1010	선우선	    0303044234567	2010-10-10	1600
1011	남주혁	    0506073234567	2012-10-10	2600
1012	남궁민	    0208073234567	2012-10-10	2600
1013	남진	    6712121234567	1998-10-10	2200
1014	홍수민	    0005044234567	2015-10-10	5200
1015	임소민	    9711232234567	2007-10-10	5500
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.

--○ TBL_SAWON 테이블에서 '이지연' 사원의 데이터를 조회한다.
SELECT *
FROM TBL_SAWON
WHERE SANAME = '이지연';
--==>> 1003	이지연	9905192234567	2006-08-10	3000

SELECT *
FROM TBL_SAWON
WHERE SANAME LIKE '이지연'; -- ~와 같이, ~처럼 LIKE
--==>> 1003	이지연	9905192234567	2006-08-10	3000

--※ LIKE : 동사 → 좋아하다
--          부사 → ~와 같이, ~처럼    CHECK~!!!

--※ WHILD CARD(CHARACTER) → 『%』
--   『LIKE』와 함께 사용되는 『%』는 모든 글자를 의미하고
--   『LIKE』와 함께 사용되는 『_』는 아무 글자 한 개를 의미한다.

--○ TBL_SAWON 테이블에서 성씨가 『김』씨인 사원의
--   사원명, 주민번호, 급여 항목을 조회한다.
SELECT *
FROM TBL_SAWON
WHERE SANAME = '김';
--==>> 조회 결과 없음

SELECT *
FROM TBL_SAWON
WHERE SANAME LIKE '김__'; -- 언더바 쓰려면 꼭 라이크랑 같이 쓰기
--==>> 1001	김민성	9707251234567	2005-01-03	3000

SELECT *
FROM TBL_SAWON
WHERE SANAME LIKE '김%'; -- 퍼센트 쓰려면 꼭 라이크랑 같이 쓰기
--==>> 1001	김민성	9707251234567	2005-01-03	3000


--○ TBL_SAWON 테이블에서 성씨가 『이』씨인 사원의
--   사원명, 주민번호, 급여 항목을 조회한다.
SELECT *
FROM TBL_SAWON
WHERE SANAME LIKE '이__';
-- WHERE SANAME LIKE '이%';
--==>>
/*
1003	이지연	9905192234567	2006-08-10	3000
1004	이연주	9508162234567	2007-10-10	4000
1006	이현이	8005132234567	1999-10-10	1000
*/

--○ TBL_SAWON 테이블에서 이름의 마지막 글자가 『민』인 사원의
--   사원명, 주민번호, 급여 항목을 조회한다.
SELECT SANAME "사원명", JUBUN "주민번호", SAL "급여"
FROM TBL_SAWON
WHERE SANAME LIKE '%민';
--==>>
/*
남궁민	0208073234567	2600
홍수민	0005044234567	5200
임소민	9711232234567	5500
*/

SELECT SANAME "사원명", JUBUN "주민번호", SAL "급여"
FROM TBL_SAWON
WHERE SANAME LIKE '__민';
--==>>
/*
남궁민	0208073234567	2600
홍수민	0005044234567	5200
임소민	9711232234567	5500
*/

--○ 추가 데이터 입력(TBL_SAWON)
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1016, '이이경', '0603194234567', TO_DATE('2015-01-20', 'YYYY-MM-DD'), 1500);
--==>> 1 행 이(가) 삽입되었습니다.

--○ 확인
SELECT *
FROM TBL_SAWON;
--==>>
/*
1001	김민성	    9707251234567	2005-01-03	3000
1002	서민지	    9505152234567	1999-11-23	4000
1003	이지연	    9905192234567	2006-08-10	3000
1004	이연주	    9508162234567	2007-10-10	4000
1005	오이삭	    9805161234567	2007-10-10	4000
1006	이현이	    8005132234567	1999-10-10	1000
1007	박한이	    0204053234567	2010-10-10	1000
1008	선동렬	    6803171234567	1998-10-10	1500
1009	선우용녀	6912232234567	1998-10-10	1300
1010	선우선	    0303044234567	2010-10-10	1600
1011	남주혁	    0506073234567	2012-10-10	2600
1012	남궁민	    0208073234567	2012-10-10	2600
1013	남진	    6712121234567	1998-10-10	2200
1014	홍수민	    0005044234567	2015-10-10	5200
1015	임소민	    9711232234567	2007-10-10	5500
1016	이이경	    0603194234567	2015-01-20	1500
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.

--○ TBL_SAWON 테이블에서 사원의 이름에 『이』라는 글자가
--   하나라도 포함되어 있다면 그 사원의
--   사원번호, 사원명, 급여 항목을 조회한다.
SELECT SANO "사원번호", SANAME "사원명", SAL "급여"
FROM TBL_SAWON
WHERE SANAME LIKE '%이%'; -- 없는 것도 퍼센트 안에 포함되는군
--==>>
/*
1003	이지연	3000
1004	이연주	4000
1005	오이삭	4000
1006	이현이	1000
1007	박한이	1000
1016	이이경	1500
*/

--○ TBL_SAWON 테이블에서 사원의 이름에 『이』라는 글자가
--   연속으로 두 번 들어있는 사원의
--   사원번호, 사원명, 급여 항목을 조회한다.
SELECT SANO "사원번호", SANAME "사원명", SAL "급여"
FROM TBL_SAWON
WHERE SANAME LIKE '%이이%';
--==>>1016	이이경	1500


--○ TBL_SAWON 테이블에서 사원의 이름에 『이』라는 글자가 두 번 들어있는 사원의
--   사원번호, 사원명, 급여 항목을 조회한다.
SELECT SANO "사원번호", SANAME "사원명", SAL "급여"
FROM TBL_SAWON
WHERE SANAME LIKE '%이%이%';
--==>>
/*
1006	이현이	1000
1016	이이경	1500
*/

--○ TBL_SAWON 테이블에서 사원 이름의 두 번째 글자가 『이』인 사원의
--   사원번호, 사원명, 급여 항목을 조회한다.
SELECT SANO "사원번호", SANAME "사원명", SAL "급여"
FROM TBL_SAWON
WHERE SANAME LIKE '_이%';
--==>>
/*
1005	오이삭	4000
1016	이이경	1500
*/


--○ TBL_SAWON 테이블에서 사원의 성씨가 『선』씨인 사원의
--   사원명, 주민번호, 급여 항목을 조회한다.
--   → 불가!!!!!!
SELECT SANAME "사원명", JUBUN "주민번호", SAL "급여"
FROM TBL_SAWON
WHERE SANAME LIKE '선%';

SELECT SANAME "사원명", JUBUN "주민번호", SAL "급여"
FROM TBL_SAWON
WHERE SANAME LIKE '남%';
--==>> 성씨가 선우인지, 선인지 모르고 / 남궁인지 남인지 모름...

--※ 데이터베이스 설계 과정에서
--   성과 이름을 분리하여 처리해야 할 업무 계획이 있다면
--   (지금 당장은 아니더라도...)
--   테이블에서 성 컬럼과 이름 컬럼을 분리하여 구성해야 한다.


--○ TBL_SAWON 테이블에서 여직원들의
--   사원명, 주민번호, 급여 항목을 조회한다.
DESC TBL_SAWON;
--==>>
/*
이름       널? 유형           
-------- -- ------------ 
SANO        NUMBER(4)    
SANAME      VARCHAR2(30) 
JUBUN       CHAR(13)     
HIREDATE    DATE         
SAL         NUMBER(10)
*/

SELECT SANAME "사원명", JUBUN "주민번호", SAL "급여"
FROM TBL_SAWON
WHERE JUBUN LIKE '______2______' OR JUBUN LIKE '______4______';
--==>>
/*
서민지	    9505152234567	4000
이지연	    9905192234567	3000
이연주	    9508162234567	4000
이현이     	8005132234567	1000
선우용녀	6912232234567	1300
선우선     	0303044234567	1600
홍수민	    0005044234567	5200
임소민	    9711232234567	5500
이이경	    0603194234567	1500
*/


--○ 테이블 생성(TBL_WATCH)
CREATE TABLE TBL_WATCH
( WATCH_NAME    VARCHAR2(20)
, BIGO          VARCHAR2(100)
);
--==>> Table TBL_WATCH이(가) 생성되었습니다.

--○ 데이터 입력(TBL_WATCH)
INSERT INTO TBL_WATCH(WATCH_NAME, BIGO)
VALUES('금시계', '순금 99.99% 함유된 최고급 시계');
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_WATCH(WATCH_NAME, BIGO)
VALUES('은시계', '고객 만족도 99.99점을 획득한 멋진 시계');
--==>> 1 행 이(가) 삽입되었습니다.

--○ 확인
SELECT *
FROM TBL_WATCH;
--==>>
/*
금시계	순금 99.99% 함유된 최고급 시계
은시계	고객 만족도 99.99점을 획득한 멋진 시계
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ TBL_WATCH 테이블의 BIGO(비고) 컬럼에
--   『99.99%』라는 글자가 포함된(들어있는) 행(레코드)의
--   데이터를 조회한다.
SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '99.99%';
--==>> 조회 결과 없음

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99%%';
--==>>
/*
금시계	순금 99.99% 함유된 최고급 시계
은시계	고객 만족도 99.99점을 획득한 멋진 시계
*/

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99%%%';
--==>>
/*
금시계	순금 99.99% 함유된 최고급 시계
은시계	고객 만족도 99.99점을 획득한 멋진 시계
*/

-------↓ESCAPE 문법

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99\%%' ESCAPE '\';
--==>> 금시계	순금 99.99% 함유된 최고급 시계

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99$%%' ESCAPE '$';
--==>> 금시계	순금 99.99% 함유된 최고급 시계

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99@%%' ESCAPE '@';
--==>> 금시계	순금 99.99% 함유된 최고급 시계

--※ ESCAPE로 정한 문자의 다음 한 글자를 와일드카드에서 탈출시켜라...
--   일반적으로 사용 빈도가 낮은 특수문자(특수기호)를 사용한다.

--------------------------------------------------------------------------------

--■■■ COMMIT / ROLLBACK ■■■--

SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*/

--○ 데이터 입력
INSERT INTO TBL_DEPT VALUES(50, '개발부', '서울');
--==>> 1 행 이(가) 삽입되었습니다.

--○ 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES   	CHICAGO
40	OPERATIONS	BOSTON
50	개발부     	서울
*/

-- 50번 개발부 서울...
-- 이 데이터는 TBL_DEPT 테이블이 저장되어 있는
-- 하드디스크상에 물리적으로 적용되어 저장된 것이 아니다.
-- 메모리(RAM)상에 입력된 것이다.

--○ 롤백
ROLLBACK; --CTRL+Z 처럼... 메모리에 있던 것을 모두 비워버림
--==>> 롤백 완료.

--○ 다시 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*/
--> 50번 개발부 서울... 에 대한 데이터가 소실되었음을 확인(존재하지 않음)

--○ 다시 데이터 입력
INSERT INTO TBL_DEPT VALUES(50, '개발부', '서울');
--==>> 1 행 이(가) 삽입되었습니다.

-- 50번 개발부 서울...
-- 이 데이터는 TBL_DEPT 테이블이 저장되어 있는 하드디스크상에 저장된 것이 아니라
-- 메모리(RAM) 상에 입력된 것이다.
-- 이를 실제 하드디스크상에 물리적으로 저장하기 위해서는
-- COMMIT을 수행해야 한다.

--○ 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	개발부	    서울
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.

--○ 커밋 이후 다시 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	개발부	    서울
*/

--○ 커밋을 수행한 이후 롤백
ROLLBACK;
--==>> 롤백 완료.

--○ 롤백 이후 다시 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	개발부	    서울
*/
--> 롤백(ROLLBACK)을 수행했음에도 불구하고
--  50번 개발부 서울... 의 행 데이터는 소실되지 않았음을 확인

--※ COMMIT 을 실행한 이후로 DML 구문(INSERT, UPDATE, DELETE)을 통해
--   변경된 데이터를 취소할 수 있는 것일 뿐...
--   DML 구문을 사용한 후 COMMIT 을 하고 나서 ROLLBACK을 실행해 봐야
--   아무런 소용이 없다.


--○ 데이터 수정(UPDATE → TBL_DEPT)
UPDATE TBL_DEPT
SET DNAME='연구부', LOC='경기'
WHERE DEPTNO = 50; -- 얘부터 쓰기
--==>> 1 행 이(가) 업데이트되었습니다.

--○ 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS 	BOSTON
50	연구부	    경기
*/

--○ 롤백
ROLLBACK;
--==>> 롤백 완료.

--○ 롤백 수행 후 다시 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	CHICAGO
40	OPERATIONS	BOSTON
50	개발부	서울
*/

--○ 데이터 삭제(DELETE → TBL_DEPT)
DELETE TBL_DEPT
WHERE DEPTNO=50;  -- 이렇게 말고

SELECT * -- 먼저 삭제할 데이터 조회 후, 조회 내용 확인 한 후 딜리트로 바꾸기
FROM TBL_DEPT 
WHERE DEPTNO=50;

DELETE  -- 이렇게 하자!
FROM TBL_DEPT  -- FROM 절 웬만하면 넣자!
WHERE DEPTNO=50;
--==>> 1 행 이(가) 삭제되었습니다.

--○ 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*/

--○ 롤백
ROLLBACK;
--==>> 롤백 완료.

--○ 롤백 이후 다시 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	개발부	    서울
*/

--------------------------------------------------------------------------------

--■■■ ORDER BY 절 ■■■--

SELECT ENAME "사원명", DEPTNO "부서번호", JOB "직종", SAL "급여"
        , SAL*12+NVL(COMM, 0) "연봉"
FROM EMP;
--==>>
/*
SMITH	20	CLERK	     800	9600
ALLEN	30	SALESMAN	1600	19500
WARD	30	SALESMAN	1250	15500
JONES	20	MANAGER	    2975	35700
MARTIN	30	SALESMAN	1250	16400
BLAKE	30	MANAGER	    2850	34200
CLARK	10	MANAGER	    2450	29400
SCOTT	20	ANALYST	    3000	36000
KING	10	PRESIDENT	5000	60000
TURNER	30	SALESMAN	1500	18000
ADAMS	20	CLERK   	1100	13200
JAMES	30	CLERK	     950	11400
FORD	20	ANALYST 	3000	36000
MILLER	10	CLERK	    1300	15600
*/

SELECT ENAME "사원명", DEPTNO "부서번호", JOB "직종", SAL "급여"
        , SAL*12+NVL(COMM, 0) "연봉"
FROM EMP
ORDER BY DEPTNO ASC;    -- DEPTNO    → 정렬 기준 : 부서번호
                        -- ASC       → 정렬 유형 : 오름차순
--==>>
/*
CLARK	10	MANAGER	    2450	29400
KING	10	PRESIDENT	5000	60000
MILLER	10	CLERK	    1300	15600
JONES	20	MANAGER 	2975	35700
FORD	20	ANALYST	    3000	36000
ADAMS	20	CLERK	    1100	13200
SMITH	20	CLERK	     800	 9600
SCOTT	20	ANALYST	    3000	36000
WARD	30	SALESMAN	1250	15500
TURNER	30	SALESMAN	1500	18000
ALLEN	30	SALESMAN	1600	19500
JAMES	30	CLERK	     950	11400
BLAKE	30	MANAGER	    2850	34200
MARTIN	30	SALESMAN	1250	16400
*/

SELECT ENAME "사원명", DEPTNO "부서번호", JOB "직종", SAL "급여"
        , SAL*12+NVL(COMM, 0) "연봉"
FROM EMP
ORDER BY DEPTNO;  -- ASC    → 정렬 유형 : 오름차순 → 생략 가능~!!!


SELECT ENAME "사원명", DEPTNO "부서번호", JOB "직종", SAL "급여"
        , SAL*12+NVL(COMM, 0) "연봉"
FROM EMP
ORDER BY DEPTNO DESC;  -- DESC    → 정렬 유형 : 내림차순 → 생략 불가~!!!
--==>>
/*
BLAKE	30	MANAGER	    2850	34200
TURNER	30	SALESMAN	1500	18000
ALLEN	30	SALESMAN	1600	19500
MARTIN	30	SALESMAN	1250	16400
WARD	30	SALESMAN	1250	15500
JAMES	30	CLERK	     950	11400
SCOTT	20	ANALYST	    3000	36000
JONES	20	MANAGER	    2975	35700
SMITH	20	CLERK	     800	9600
ADAMS	20	CLERK	    1100	13200
FORD	20	ANALYST	    3000	36000
KING	10	PRESIDENT	5000	60000
MILLER	10	CLERK	    1300	15600
CLARK	10	MANAGER	2450	29400
*/

SELECT ENAME "사원명", DEPTNO "부서번호", JOB "직종", SAL "급여"
        , SAL*12+NVL(COMM, 0) "연봉"
FROM EMP
ORDER BY 연봉 DESC;
--==>>
/*
KING	10	PRESIDENT	5000	60000
FORD	20	ANALYST 	3000	36000
SCOTT	20	ANALYST 	3000	36000
JONES	20	MANAGER	    2975	35700
BLAKE	30	MANAGER	    2850	34200
CLARK	10	MANAGER	    2450	29400
ALLEN	30	SALESMAN	1600	19500
TURNER	30	SALESMAN	1500	18000
MARTIN	30	SALESMAN	1250	16400
MILLER	10	CLERK	    1300	15600
WARD	30	SALESMAN	1250	15500
ADAMS	20	CLERK	    1100	13200
JAMES	30	CLERK	     950	11400
SMITH	20	CLERK	     800	 9600
*/

SELECT ENAME "사원명", DEPTNO "부서번호", JOB "직종", SAL "급여"
        , SAL*12+NVL(COMM, 0) "연봉"
FROM EMP
ORDER BY 2;             -- 부서번호 오름차순
-- ORDER BY 부서번호;   -- 이렇게 쓴 거랑 똑같음
--> EMP 테이블이 갖고 있는 테이블의 고유한 컬럼 순서(2 → ENAME, 사원명)가 아니라
--  SELECT 처리되는 두 번째 컬럼(2 → DEPTNO, 부서번호)을 기준으로 정렬되는 것을 확인
--  ASC 생략된 상태 → 오름차순 정렬되는 것을 확인
--  즉, 『ORDER BY 2』는 『ORDER BY DEPTNO ASC』
--==>>
/*
CLARK	10	MANAGER	    2450	29400
KING	10	PRESIDENT	5000	60000
MILLER	10	CLERK	    1300	15600
JONES	20	MANAGER	    2975	35700
FORD	20	ANALYST	    3000	36000
ADAMS	20	CLERK	    1100	13200
SMITH	20	CLERK	     800	 9600
SCOTT	20	ANALYST	    3000	36000
WARD	30	SALESMAN	1250	15500
TURNER	30	SALESMAN	1500	18000
ALLEN	30	SALESMAN	1600	19500
JAMES	30	CLERK	     950	11400
BLAKE	30	MANAGER	    2850	34200
MARTIN	30	SALESMAN	1250	16400
*/
--> 컬럼인덱스 활용해서 부서번호로 정렬

SELECT ENAME, DEPTNO, JOB, SAL
FROM EMP
ORDER BY 2, 4;  -- DEPTNO, SAL 기준 ... ASC
--==>>
/*
MILLER	10	CLERK	    1300
CLARK	10	MANAGER	    2450
KING	10	PRESIDENT	5000
SMITH	20	CLERK	     800
ADAMS	20	CLERK	    1100
JONES	20	MANAGER	    2975
SCOTT	20	ANALYST	    3000
FORD	20	ANALYST	    3000
JAMES	30	CLERK	     950
MARTIN	30	SALESMAN	1250
WARD	30	SALESMAN	1250
TURNER	30	SALESMAN	1500
ALLEN	30	SALESMAN	1600
BLAKE	30	MANAGER	    2850
*/

SELECT ENAME, DEPTNO, JOB, SAL
FROM EMP
ORDER BY 2, 3, 4 DESC; --> 4에만 DESC 적용!!! CHECK~!!!
--> ① 2      → DEPTNO(부서번호) 기준 오름차순 정렬
--  ② 3      → JOB(직종명) 기준 오름차순 정렬
--  ③ 4 DESC → SAL(급여) 기준 내림차순 정렬
--     (3차 정렬 수행)
--==>>
/*
MILLER	10	CLERK	    1300
CLARK	10	MANAGER	    2450
KING	10	PRESIDENT	5000
SCOTT	20	ANALYST	    3000
FORD	20	ANALYST	    3000
ADAMS	20	CLERK	    1100
SMITH	20	CLERK	     800
JONES	20	MANAGER	    2975
JAMES	30	CLERK	     950
BLAKE	30	MANAGER	    2850
ALLEN	30	SALESMAN	1600
TURNER	30	SALESMAN	1500
MARTIN	30	SALESMAN	1250
WARD	30	SALESMAN	1250
*/

--------------------------------------------------------------------------------

--○ CONCAT()
SELECT ENAME || JOB "COL1"
     , CONCAT(ENAME, JOB) "COL2"
FROM EMP;
--==>>
/*
SMITHCLERK	    SMITHCLERK
ALLENSALESMAN	ALLENSALESMAN
WARDSALESMAN	WARDSALESMAN
JONESMANAGER	JONESMANAGER
MARTINSALESMAN	MARTINSALESMAN
BLAKEMANAGER	BLAKEMANAGER
CLARKMANAGER	CLARKMANAGER
SCOTTANALYST	SCOTTANALYST
KINGPRESIDENT	KINGPRESIDENT
TURNERSALESMAN	TURNERSALESMAN
ADAMSCLERK	    ADAMSCLERK
JAMESCLERK	    JAMESCLERK
FORDANALYST 	FORDANALYST
MILLERCLERK	    MILLERCLERK
*/

-- 문자열을 결합하는 기능을 가진 함수 CONCAT()
-- 오로지 2개의 문자열만 결합시켜줄 수 있다.
SELECT ENAME || JOB || DEPTNO "COL1"
     , CONCAT(ENAME, JOB, DEPTNO) "COL2"
FROM EMP;
--==>> 에러 발생
--     (ORA-00909: invalid number of arguments)

SELECT ENAME || JOB || DEPTNO "COL1"
     , CONCAT(CONCAT(ENAME, JOB), DEPTNO) "COL2"
FROM EMP;
--==>>
/*
SMITHCLERK	    SMITHCLERK
ALLENSALESMAN	ALLENSALESMAN
WARDSALESMAN	WARDSALESMAN
JONESMANAGER	JONESMANAGER
MARTINSALESMAN	MARTINSALESMAN
BLAKEMANAGER	BLAKEMANAGER
CLARKMANAGER	CLARKMANAGER
SCOTTANALYST	SCOTTANALYST
KINGPRESIDENT	KINGPRESIDENT
TURNERSALESMAN	TURNERSALESMAN
ADAMSCLERK	    ADAMSCLERK
JAMESCLERK	    JAMESCLERK
FORDANALYST 	FORDANALYST
MILLERCLERK	    MILLERCLERK
*/

--> 내부적으로 형 변환이 일어나며 결합을 수행하게 된다.
--  CONCAT()은 문자열과 문자열을 결합시켜 주는 함수이지만
--  내부적으로 숫자나 날짜를 문자로 바꾸어주는 과정이 포함되어 있다.

/*
obj.substring()
---
 |
 문자열.substring(n, m);
                 ------
                 n부터 m-1까지... (인덱스는 0부터)
*/

--○ SUBSTR() 추출 갯수 기반 / SUBSTRB() 추출 바이트 기반
SELECT ENAME "COL1"
     , SUBSTR(ENAME, 1, 2) "COL2"
FROM EMP;
--> 문자열을 추출하는 기능을 가진 함수
--  첫 번째 파라미터 값은 대상 문자열(추출의 대상, TARGET)
--  두 번째 파라미터 값은 추출을 시작하는 위치(인덱스는 1부터 시작)
--  세 번째 파라미터 값은 추출할 문자열의 갯수(생략 시... 끝까지)
--==>>
/*
SMITH	SM
ALLEN	AL
WARD	WA
JONES	JO
MARTIN	MA
BLAKE	BL
CLARK	CL
SCOTT	SC
KING	KI
TURNER	TU
ADAMS	AD
JAMES	JA
FORD	FO
MILLER	MI
*/


--○ TBL_SAWON 테이블에서 성별이 남성인 사원만
--   사원번호, 사원명, 주민번호, 급여 항목을 조회한다.
--   단, SUBSTR() 함수를 활용할 수 있도록 한다.

SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호", SAL "급여"
FROM TBL_SAWON
WHERE SUBSTR(JUBUN, 7, 1) = '1' OR SUBSTR(JUBUN, 7, 1) = '3';
--WHERE SUBSTR(JUBUN, 7, 1) = 1 OR SUBSTR(JUBUN, 7, 1) = 3;
--> 이것도 되지만 SUBSTR은 문자를 반환하기 때문에 문자로 처리하는 것이 맞다.
--==>>
/*
1001	김민성	9707251234567	3000
1005	오이삭	9805161234567	4000
1007	박한이	0204053234567	1000
1008	선동렬	6803171234567	1500
1011	남주혁	0506073234567	2600
1012	남궁민	0208073234567	2600
1013	남진	6712121234567	2200
*/

SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호", SAL "급여"
FROM TBL_SAWON
WHERE SUBSTR(JUBUN, 7, 1) IN ('1', '3');
--==>>
/*
1001	김민성	9707251234567	3000
1005	오이삭	9805161234567	4000
1007	박한이	0204053234567	1000
1008	선동렬	6803171234567	1500
1011	남주혁	0506073234567	2600
1012	남궁민	0208073234567	2600
1013	남진	6712121234567	2200
*/


--○ LENGTH() 글자 수 / LENGTHB() 바이트 수
SELECT ENAME "COL1"
     , LENGTH(ENAME) "COL2"
     , LENGTHB(ENAME) "COL3"
FROM EMP;
--==>> 
/*
SMITH	5	5
ALLEN	5	5
WARD	4	4
JONES	5	5
MARTIN	6	6
BLAKE	5	5
CLARK	5	5
SCOTT	5	5
KING	4	4
TURNER	6	6
ADAMS	5	5
JAMES	5	5
FORD	4	4
MILLER	6	6
*/

SELECT *
FROM NLS_DATABASE_PARAMETERS;
/*
NLS_LANGUAGE	        AMERICAN
NLS_TERRITORY	        AMERICA
NLS_CURRENCY	        $
NLS_ISO_CURRENCY	    AMERICA
NLS_NUMERIC_CHARACTERS	.,
NLS_CHARACTERSET	    AL32UTF8
NLS_CALENDAR	        GREGORIAN
NLS_DATE_FORMAT	        DD-MON-RR
NLS_DATE_LANGUAGE	    AMERICAN
NLS_SORT	            BINARY
NLS_TIME_FORMAT	        HH.MI.SSXFF AM
NLS_TIMESTAMP_FORMAT	DD-MON-RR HH.MI.SSXFF AM
NLS_TIME_TZ_FORMAT	    HH.MI.SSXFF AM TZR
NLS_TIMESTAMP_TZ_FORMAT	DD-MON-RR HH.MI.SSXFF AM TZR
NLS_DUAL_CURRENCY	    $
NLS_COMP	            BINARY
NLS_LENGTH_SEMANTICS	BYTE
NLS_NCHAR_CONV_EXCP	    FALSE
NLS_NCHAR_CHARACTERSET	AL16UTF16
NLS_RDBMS_VERSION	    11.2.0.2.0
*/

--○ INSTR()
SELECT 'ORACLE ORAHOME BIORA' "COL1"
     , INSTR('ORACLE ORAHOME BIORA', 'ORA', 1, 1) "COL2"    -- 1
     , INSTR('ORACLE ORAHOME BIORA', 'ORA', 1, 2) "COL3"    -- 8
     , INSTR('ORACLE ORAHOME BIORA', 'ORA', 2, 1) "COL4"    -- 8
     , INSTR('ORACLE ORAHOME BIORA', 'ORA', 2) "COL5"       -- 8
     , INSTR('ORACLE ORAHOME BIORA', 'ORA', 2, 3) "COL6"    -- 0
     , INSTR('ORACLE ORAHOME BIORA', 'ORA', -3) "COL7"      -- 18
     , INSTR('ORACLE ORAHOME BIORA', 'ORA', -4) "COL8"      -- 8
     , INSTR('ORACLE ORAHOME BIORA', 'ORA', -4, 2) "COL9"      -- 1
FROM DUAL;
--> 첫 번째 파라미터 값에 해당하는 문자열에서... (대상 문자열, TARGET)
--  두 번째 파라미터 값을 통해 넘겨준 문자열이 등장하는 위치를 찾아라~
--  세 번째 파라미터 값은 찾기 시작하는(스캔을 시작하는) 위치(→ 음수일 경우 뒤에서부터 스캔)
--  네 번째 파라미터 값은 몇 번째 등장하는 값을 찾을 것인지에 대한 설정(→ 1은 생략 가능)


SELECT '나의오라클 집으로오라 합니다.' "COL1"
    , INSTR('나의오라클 집으로오라 합니다.', '오라', 1) "COL2"    -- 3
    , INSTR('나의오라클 집으로오라 합니다.', '오라', 2) "COL3"    -- 3
    , INSTR('나의오라클 집으로오라 합니다.', '오라', 10) "COL4"   -- 10
    , INSTR('나의오라클 집으로오라 합니다.', '오라', 11) "COL5"   -- 0
FROM DUAL;
--==>> 나의오라클 집으로오라 합니다.	3	3	10	0
--> 마지막 파라미터 값을 생략한 형태로 사용 → 마지막 파라미터 → 1


--○ REVERSE()
SELECT 'ORACLE' "COL1"
    , REVERSE('ORACLE') "COL2"
    , REVERSE('오라클') "COL3"
FROM DUAL;
--==>> ORACLE	ELCARO	???
--> 대상 문자열을 거꾸로 반환한다. (단, 한글은 제외)

--○ 실습 테이블 생성(TBL_FILES)
CREATE TABLE TBL_FILES
(   FILENO    NUMBER(3)
,   FILENAME  VARCHAR2(100)
);
--==>> Table TBL_FILES이(가) 생성되었습니다.

--○ 데이터 입력(TBL_FILES)
INSERT INTO TBL_FILES VALUES(1, 'C:\AAA\BBB\CCC\SALES.DOC');
INSERT INTO TBL_FILES VALUES(2, 'C:\AAA\PANMAE.XXLS');
INSERT INTO TBL_FILES VALUES(3, 'D:\RESEARCH.PPT');
INSERT INTO TBL_FILES VALUES(4, 'C:\DOCUMENTS\STUDY.HWP');
INSERT INTO TBL_FILES VALUES(5, 'C:\DOCUMENTS\TEMP\SQL.TXT');
INSERT INTO TBL_FILES VALUES(6, 'D:\SHARE\F\TEST.PNG');
INSERT INTO TBL_FILES VALUES(7, 'E:\STUDY\ORACLE.SQL');
--==>> 1 행 이(가) 삽입되었습니다. * 7

--○ 확인
SELECT *
FROM TBL_FILES;
--==>>
/*
1	C:\AAA\BBB\CCC\SALES.DOC
2	C:\AAA\PANMAE.XXLS
3	D:\RESEARCH.PPT
4	C:\DOCUMENTS\STUDY.HWP
5	C:\DOCUMENTS\TEMP\SQL.TXT
6	D:\SHARE\F\TEST.PNG
7	E:\STUDY\ORACLE.SQL
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.

SELECT FILENO "파일번호"
     , FILENAME "파일명"
FROM TBL_FILES;
--==>>
/*
--------- --------------------------
파일 번호 파일명
--------- --------------------------
        1 C:\AAA\BBB\CCC\SALES.DOC
        2 C:\AAA\PANMAE.XXLS
        3 D:\RESEARCH.PPT
        4 C:\DOCUMENTS\STUDY.HWP
        5 C:\DOCUMENTS\TEMP\SQL.TXT
        6 D:\SHARE\F\TEST.PNG
        7 E:\STUDY\ORACLE.SQL
--------- --------------------------
*/

--○ TBL_FILES 테이블을
--   다음과 같이 조회될 수 있도록 쿼리문을 구성한다.
/*
--------- --------------------------
파일 번호 파일명
--------- --------------------------
        1 SALES.DOC
        2 PANMAE.XXLS
        3 RESEARCH.PPT
        4 STUDY.HWP
        5 SQL.TXT
        6 TEST.PNG
        7 ORACLE.SQL
--------- --------------------------
*/

-- 내 풀이
SELECT FILENO "파일번호", SUBSTR(FILENAME, INSTR(FILENAME, '\', -1)+1) "파일명"
FROM TBL_FILES;
--==>>
/*
1	SALES.DOC
2	PANMAE.XXLS
3	RESEARCH.PPT
4	STUDY.HWP
5	SQL.TXT
6	TEST.PNG
7	ORACLE.SQL
*/

-- 수업 풀이
SELECT FILENO "파일번호", REVERSE(FILENAME) "거꾸로"
FROM TBL_FILES;
--==>>
/*
1	COD.SELAS       \CCC\BBB\AAA\:C     → 최초 『\』의 등장위치 : 10 → 1 ~  9 추출 
2	SLXX.EAMNAP     \AAA\:C             → 최초 『\』의 등장위치 : 12 → 1 ~ 11 추출
3	TPP.HCRAESER    \:D                 → 최초 『\』의 등장위치 : 13 → 1 ~ 12 추출  
4	PWH.YDUTS       \STNEMUCOD\:C       → 최초 『\』의 등장위치 : 10 → 1 ~  9 추출 
5	TXT.LQS         \PMET\STNEMUCOD\:C  → 최초 『\』의 등장위치 :  8 → 1 ~  7 추출
6	GNP.TSET        \F\ERAHS\:D         → 최초 『\』의 등장위치 :  9 → 1 ~  8 추출
7	LQS.ELCARO      \YDUTS\:E           → 최초 『\』의 등장위치 : 11 → 1 ~ 10 추출
*/

SELECT FILENO "파일번호"
    , FILENAME "경로포함파일명"
    , REVERSE(FILENAME) "거꾸로된경로및파일명"
    , SUBSTRING(대상문자열, 추출시작위치, 최초 『\』의 등장위치 - 1) "거꾸로된파일명"
FROM TBL_FILES;

SELECT FILENO "파일번호"
    , FILENAME "경로포함파일명"
    , REVERSE(FILENAME) "거꾸로된경로및파일명"
    , SUBSTR(REVERSE(FILENAME), 1, 최초 『\』의 등장위치 - 1) "거꾸로된파일명"
FROM TBL_FILES;

-- 최초 『\』의 등장위치
-- → INSTR(REVERSE(FILENAME), '\', 1)   -- 마지막 매개변수 1 생략
SELECT FILENO "파일번호"
    , FILENAME "경로포함파일명"
    , REVERSE(FILENAME) "거꾸로된경로및파일명"
    , SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME), '\', 1) - 1) "거꾸로된파일명"
FROM TBL_FILES;
--==>>
/*
1	C:\AAA\BBB\CCC\SALES.DOC    COD.SELAS\CCC\BBB\AAA\:C	COD.SELAS
2	C:\AAA\PANMAE.XXLS	        SLXX.EAMNAP\AAA\:C	        SLXX.EAMNAP
3	D:\RESEARCH.PPT	            TPP.HCRAESER\:D	            TPP.HCRAESER
4	C:\DOCUMENTS\STUDY.HWP	    PWH.YDUTS\STNEMUCOD\:C	    PWH.YDUTS
5	C:\DOCUMENTS\TEMP\SQL.TXT	TXT.LQS\PMET\STNEMUCOD\:C	TXT.LQS
6	D:\SHARE\F\TEST.PNG	        GNP.TSET\F\ERAHS\:D         GNP.TSET
7	E:\STUDY\ORACLE.SQL	        LQS.ELCARO\YDUTS\:E	        LQS.ELCARO
*/

SELECT FILENO "파일번호"
    , REVERSE(SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME), '\', 1) - 1)) "파일명"
FROM TBL_FILES;
--==>>
/*
1	C:\AAA\BBB\CCC\SALES.DOC	COD.SELAS\CCC\BBB\AAA\:C	SALES.DOC
2	C:\AAA\PANMAE.XXLS	        SLXX.EAMNAP\AAA\:C	        PANMAE.XXLS
3	D:\RESEARCH.PPT	            TPP.HCRAESER\:D	            RESEARCH.PPT
4	C:\DOCUMENTS\STUDY.HWP	    PWH.YDUTS\STNEMUCOD\:C  	STUDY.HWP
5	C:\DOCUMENTS\TEMP\SQL.TXT	TXT.LQS\PMET\STNEMUCOD\:C	SQL.TXT
6	D:\SHARE\F\TEST.PNG	        GNP.TSET\F\ERAHS\:D	        TEST.PNG
7	E:\STUDY\ORACLE.SQL	        LQS.ELCARO\YDUTS\:E	        ORACLE.SQL
*/

--○ LPAD() --> LEFT
--> Byte를 확보하여 왼쪽부터 문자로 채우는 기능을 가진 함수
SELECT 'ORACLE' "COL1"
     , LPAD('ORACLE', 10, '*') "COL2" --> 두 번째 파라미터부터 보자!
FROM DUAL;
--==>>  ORACLE	****ORACLE
--> ① 10Byte 공간을 확보한다.                  → 두 번째 파라미터 값에 의해...
--  ② 확보한 공간에 'ORACLE' 문자열을 담는다.  → 첫 번째 파라미터 값에 의해...
--  ③ 남아있는 Byte 공간을 『왼쪽』부터 세 번째 파라미터 값으로 채운다.
--  ④ 이렇게 구성된 최종 결과값을 반환한다.


--○ RPAD() --> RIGTH
--> Byte를 확보하여 오른쪽부터 문자로 채우는 기능을 가진 함수
SELECT 'ORACLE' "COL1"
     , RPAD('ORACLE', 10, '*') "COL2" --> 두 번째 파라미터부터 보자!
FROM DUAL;
--==>>  ORACLE	ORACLE****
--> ① 10Byte 공간을 확보한다.                  → 두 번째 파라미터 값에 의해...
--  ② 확보한 공간에 'ORACLE' 문자열을 담는다.  → 첫 번째 파라미터 값에 의해...
--  ③ 남아있는 Byte 공간을 『오른쪽』부터 세 번째 파라미터 값으로 채운다.
--  ④ 이렇게 구성된 최종 결과값을 반환한다.


--○ LTRIM() 
SELECT 'ORAORAORACLEORACLE' "COL1"
    , LTRIM('ORAORAORACLEORACLE', 'ORA') "COL2"
    , LTRIM('AAAAAAAAAAORAORAORACLEORACLE', 'ORA') "COL3"
    , LTRIM('ORAoRAORACLEORACLE', 'ORA') "COL4"
    , LTRIM('ORAORA ORACLEORACLE', 'ORA') "COL5"
    , LTRIM('               ORACLE', ' ') "COL6" -- 왼쪽 공백 함수로 많이 쓰임!!!
    , LTRIM('               ORACLE') "COL7"      -- 공백이면 두 번째 파라미터값 생략 가능 
FROM DUAL;
--==>>
/*
ORAORAORACLEORACLE	
CLEORACLE	
CLEORACLE	
oRAORACLEORACLE	 
 ORACLEORACLE	
ORACLE
*/
--> 첫 번째 파라미터 값에 해당하는 문자열을 대상으로
--  왼쪽부터 연속적으로 등장하는 두 번재 파라미터 값에서 지정한 글자와
--  같은 글자가 등장할 경우 이를 제거한 결과값을 반환한다.
--  단, 완성형으로 처리되지 않는다.

SELECT LTRIM('이김신이김신이김김신신신이김김김이신김신이박이김신', '이김신') "RESULT"
FROM DUAL;
--==>> 박이김신
-- 한글도 적용됨!

--○ RTRIM()
--> 첫 번째 파라미터 값에 해당하는 문자열을 대상으로
--  오른쪽부터 연속적으로 등장하는 두 번째 파라미터 값에서 지정한 글자와
--  같은 글자가 등장할 경우 이를 제거한 결과값을 반환한다.
--  단, 완성형으로 처리되지 않는다.

--○ TRANSLATE()
--> 1:1로 바꿔준다.
SELECT TRANSLATE('MY ORACLE SERVER'
                , 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
                , 'abcdefghijklmnopqrstuvwxyz') "RESULT"
FROM DUAL;
--==>>> my oracle server

SELECT TRANSLATE('010-4139-4969' 
                , '0123456789'
                , '영일이삼사오육칠팔구') "RESULT"
FROM DUAL;
--==>> 영일영-사일삼구-사구육구

--○ REPLACE()
SELECT REPLACE('MY ORACLE SEVER ORAHOME', 'ORA', '오라') "RESULT"
FROM DUAL;
--==>> MY 오라CLE SEVER 오라HOME
 

