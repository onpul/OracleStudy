SELECT USER
FROM DUAL;
--==>> SCOTT

SELECT DEPTNO, SAL
FROM EMP
ORDER BY 1;
--==>>
/*
10	2450 ┐
10	5000 │8750
10	1300 ┘
20	2975 ┐
20	3000 │
20	1100 │10875
20	800  │
20	3000 ┘
30	1250 ┐
30	1500 │
30	1600 │9400
30	950  │
30	2850 │
30	1250 ┘
*/


SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
ORDER BY 1;
--==>>
/*
10	8750
20	10875
30	9400
*/

SELECT *
FROM EMP;

SELECT *
FROM TBL_EMP;


--○ 기존에 복사해둔 TBL_EMP 테이블 제거
DROP TABLE TBL_EMP;
--==>> Table TBL_EMP이(가) 삭제되었습니다.


--○ 다시 EMP 테이블 복사하여 TBL_EMP 테이블 생성
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>> Table TBL_EMP이(가) 생성되었습니다.


--○ 실습 데이터 추가 입력(TBL_EMP)
SELECT *
FROM TBL_EMP;

INSERT INTO TBL_EMP VALUES
(8001, '홍은혜', 'CLERK', 7566, SYSDATE, 1500, 10, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP VALUES
(8002, '김상기', 'CLERK', 7566, SYSDATE, 2000, 10, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP VALUES
(8003, '이호석', 'SALESMAN', 7698, SYSDATE, 1700, NULL, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP VALUES
(8004, '신시은', 'SALESMAN', 7698, SYSDATE, 2500, NULL, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP VALUES
(8005, '김태형', 'SALESMAN', 7698, SYSDATE, 1000, NULL, NULL);
--==>> 1 행 이(가) 삽입되었습니다.


--○ 확인
SELECT *
FROM TBL_EMP;
--==>>
/*
7369	SMITH	CLERK	    7902	1980-12-17	 800   (null)   20
7499	ALLEN	SALESMAN	7698	1981-02-20	1600	 300	30
7521	WARD	SALESMAN	7698	1981-02-22	1250	 500	30
7566	JONES	MANAGER	    7839	1981-04-02	2975   (null)   20
7654	MARTIN	SALESMAN	7698	1981-09-28	1250	1400	30
7698	BLAKE	MANAGER	    7839	1981-05-01	2850   (null)   30
7782	CLARK	MANAGER	    7839	1981-06-09	2450   (null)   10
7788	SCOTT	ANALYST	    7566	1987-07-13	3000   (null)   20
7839	KING	PRESIDENT  (null)   1981-11-17	5000   (null)   10
7844	TURNER	SALESMAN	7698	1981-09-08	1500	   0    30
7876	ADAMS	CLERK	    7788	1987-07-13	1100   (null)   20
7900	JAMES	CLERK	    7698	1981-12-03	 950   (null)   30
7902	FORD	ANALYST	    7566	1981-12-03	3000   (null)   20
7934	MILLER	CLERK	    7782	1982-01-23	1300   (null)   10
8001	홍은혜	CLERK	    7566	2022-02-24	1500	10	
8002	김상기	CLERK	    7566	2022-02-24	2000	10	
8003	이호석	SALESMAN	7698	2022-02-24	1700		
8004	신시은	SALESMAN	7698	2022-02-24	2500		
8005	김태형	SALESMAN	7698	2022-02-24	1000		
*/


--○ 커밋
COMMIT;
--==>> 커밋 완료.

SELECT DEPTNO, SAL, COMM
FROM TBL_EMP
ORDER BY COMM DESC;
--==>>
/*
20	     800	(null)
(null)	1700	(null)
(null)	1000	(null)
10	    1300	(null)
20	    2975	(null)
30	    2850	(null)
10	    2450	(null)
20	    3000	(null)
10	    5000	(null)
(null)	2500	(null)
20	    1100	(null)
30	    950	    (null)
20	    3000	(null)
30	    1250	 1400
30	    1250	  500
30	    1600	  300
(null)	1500	   10
(null)	2000	   10
30	    1500	    0
*/

--※ 오라클에서는 NULL을 가장 큰 값의 형태로 간주한다.
--   (ORACLE 9i 까지는 NULL 을 가장 작은 값의 형태로 간주했었다.)
--   MSSQL은 NULL을 가장 작은 값의 형태로 간주한다.


--○ TBL_EMP 테이블을 대상으로 부서별 급여합 조회
-- 부서번호, 급여합 항목 조회
SELECT DEPTNO "부서번호", SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;
--==>>
/*
    10	 8750
    20	10875
    30	 9400
(null)	 8700   --부서번호가 NULL인 사람들의 합
*/

--○ ROLLUP 사용
SELECT DEPTNO "부서번호", SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
   10	 8750
   20	10875
   30	 9400
(null)	 8700   -- 부서번호를 갖지 못한 직원들의 급여합
(null)	37725   -- 모든부서 직원들의 급여합
*/

SELECT DEPTNO "부서번호", SUM(SAL) "급여합"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
   10	 8750
   20	10875
   30	 9400
(null)	29025
*/

--==>>
/*
--------    ------
부서번호    급여합 
--------    ------
10	         8750
20	        10875
30	         9400
모든부서	29025
*/

SELECT NVL(TO_CHAR(DEPTNO), '모든부서') "부서번호", SUM(SAL) "급여합"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
모든부서	29025
*/

SELECT NVL2(DEPTNO, TO_CHAR(DEPTNO), '모든부서') "부서번호", SUM(SAL) "급여합"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
모든부서	29025
*/

SELECT *
FROM TBL_EMP;

SELECT NVL(TO_CHAR(DEPTNO), '모든부서') "부서번호", SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
모든부서	 8700
모든부서	37725
*/

SELECT NVL2(DEPTNO, TO_CHAR(DEPTNO), '모든부서') "부서번호", SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
모든부서	 8700
모든부서	37725
*/

SELECT GROUPING(DEPTNO) "GROUPING", DEPTNO "부서번호", SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
GROUPING   부서번호   급여합
--------   --------   ------
       0         10     8750
       0	     20	   10875
       0	     30	    9400
       0	  (null)    8700     -- 인턴
       1	  (null)   37725     -- 모든부서
*/

SELECT DEPTNO "부서번호", SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	     8750
20	    10875
30	     9400
(null)	 8700
(null)	37725
*/

--○ 위에서 조회한 해당 내용을
/*
10	         8750
20	        10875
30	         9400
인턴	     8700
모든부서	37725
*/
-- 이와 같이 조회될 수 있도록 쿼리문을 구성한다.

--※ 참고
SELECT GROUPING(DEPTNO) "GROUPING", DEPTNO "부서번호", SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);

--※ 힌트
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN '단일부서'
            ELSE '모든부서'
       END "부서번호"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
단일부서	8750
단일부서	10875
단일부서	9400
단일부서	8700
모든부서	37725
*/

SELECT CASE WHEN TO_CHAR(GROUPING(DEPTNO)) = '0' THEN NVL(TO_CHAR(DEPTNO), '인턴') 
            WHEN TO_CHAR(GROUPING(DEPTNO)) = '1' THEN NVL(TO_CHAR(DEPTNO), '모든부서')
            ELSE '확인 불가'
       END  "부서번호"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
인턴	     8700
모든부서	37725
*/

SELECT CASE TO_CHAR(GROUPING(DEPTNO)) -- CASE가 같을 경우 CASE를 먼저 쓸 수 있음
            WHEN '0' THEN NVL(TO_CHAR(DEPTNO), '인턴') 
            WHEN '1' THEN NVL(TO_CHAR(DEPTNO), '모든부서')
            ELSE '확인 불가'
       END  "부서번호"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
인턴	     8700
모든부서	37725
*/

-- 수업 풀이
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN TO_CHAR(DEPTNO)
            ELSE '모든부서'
       END "부서번호"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
             8700
모든부서	37725
*/

--==>> 최종
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
            ELSE '모든부서'
       END "부서번호"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
인턴	     8700
모든부서	37725
*/


--○ TBL_SAWON 테이블을 대상으로
--   다음과 같이 조회될 수 있도록 쿼리문을 구성한다.
/*
---------------------------
  성별            급여합
---------------------------
   남             XXXXXX
   여             XXXXXX   
   모든사원       XXXXXX
---------------------------   
*/
-- 내 풀이 ---------------------------------------------------------------------
SELECT *
FROM TBL_SAWON;

SELECT GROUPING(T.성별)
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남성'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여성'
                ELSE '성별확인불가'
           END "성별" 
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.성별);
--==>>
/*
0
0
1
*/

SELECT CASE WHEN GROUPING(T.성별) IS NOT NULL THEN NVL(T.성별, '모든사원')
            ELSE '확인불가'
       END "성별"
     , SUM(T.급여) "급여합"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남성'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여성'
                ELSE '성별확인불가'
           END "성별" 
         , SAL "급여"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.성별);
--==>>
/*
남성	    21900
여성	    32100
모든사원	54000
*/

-- 수업 풀이 -------------------------------------------------------------------
SELECT T.성별 "성별"
     , SUM(T.급여) "급여합"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여'
                ELSE '성별확인불가'
           END "성별"
         , SAL "급여"  
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.성별);
--==>> 
/*
남	    21900
여	    32100
(null)	54000
*/

SELECT CASE GROUPING(T.성별) WHEN 0 THEN T.성별 
                             ELSE '모든사원' 
       END "성별"
     , SUM(T.급여) "급여합"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여'
                ELSE '성별확인불가'
           END "성별"
         , SAL "급여"  
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.성별);
--==>>
/*
남	        21900
여	        32100
모든사원	54000
*/


SELECT *
FROM VIEW_SAWON;

--○ TBL_SAWON 테이블을 대상으로
--   다음과 같이 조회될 수 있도록 연령대별 인원수를 확인할 수 있는
--   쿼리문을 구성한다.
/*
----------------------
  연령대      인원수
----------------------
  10              X
  20              X
  40              X
  50              X
  전체           XX
----------------------
*/

-- 내 풀이 ---------------------------------------------------------------------

-- 테이블 조회
SELECT *
FROM TBL_SAWON;

-- 연령대
SELECT (SUBSTR(T.현재나이, 1, 1) || '0') "연령대"
FROM
(
SELECT
     CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
     THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
     WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
     THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
     ELSE -1 
END "현재나이"
FROM TBL_SAWON
) T;

-- 최종 
SELECT CASE GROUPING(T2.연령대) WHEN 0 THEN T2.연령대 
                                ELSE '전체' 
       END "연령대" 
     , COUNT(T2.연령대) "인원수"
FROM
(
    SELECT (SUBSTR(T.현재나이, 1, 1) || '0') "연령대"
    FROM
    (
        SELECT
             CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
             THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
             WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
             THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
             ELSE -1 
        END "현재나이"
        FROM TBL_SAWON
    ) T
) T2
GROUP BY ROLLUP(T2.연령대);
--==>>
/*
10	     2
20	    12
40	     1
50	     3
전체	18
*/

-- 수업 풀이 -------------------------------------------------------------------

-- 방법 1. → INLINE VIEW를 두 번 중첩

-- 나이
SELECT NVL(TO_CHAR(T2.연령대), '전체') "연령대"
     , COUNT(*) "인원수"
FROM 
(
    -- 연령대
    SELECT CASE WHEN T1.나이 >= 50 THEN 50 
                WHEN T1.나이 >= 40 THEN 40 
                WHEN T1.나이 >= 30 THEN 30
                WHEN T1.나이 >= 20 THEN 20
                WHEN T1.나이 >= 10 THEN 10
                ELSE 0 
           END "연령대"
    FROM
    (
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
                    WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)  
                    ELSE -1
               END "나이"
        FROM TBL_SAWON  
    ) T1
)T2
GROUP BY ROLLUP(T2.연령대);
--==>>
/*
10	     2
20	    12
40	     1
50	     3
전체	18
*/

SELECT CASE GROUPING(T2.연령대) WHEN 0 THEN TO_CHAR(T2.연령대)
            ELSE '전체' END "연령대"
     , COUNT(*) "인원수"
FROM 
(
    -- 연령대
    SELECT CASE WHEN T1.나이 >= 50 THEN 50 
                WHEN T1.나이 >= 40 THEN 40 
                WHEN T1.나이 >= 30 THEN 30
                WHEN T1.나이 >= 20 THEN 20
                WHEN T1.나이 >= 10 THEN 10
                ELSE 0 
           END "연령대"
    FROM
    (
        SELECT SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
                    WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)  
                    ELSE -1
               END "나이"
        FROM TBL_SAWON  
    ) T1
)T2
GROUP BY ROLLUP(T2.연령대);

-- 방법 2. → INLINE VIEW를 한 번만

--연령대
SELECT CASE GROUPING(T.연령대) WHEN 0 THEN TO_CHAR(T.연령대)
                               ELSE '전체' 
       END "연령대"
     , COUNT(*) "인원수"

FROM
(
    SELECT TRUNC(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                      THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
                      WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                      THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)  
                      ELSE -1
                 END, -1) "연령대"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.연령대);
--==>>
/*
10	     2
20	    12
40	     1
50	     3
전체	18
*/

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY 1, 2;
--==>>
/*
10	CLERK	    1300
10	MANAGER	    2450
10	PRESIDENT	5000
20	ANALYST	    6000
20	CLERK	    1900
20	MANAGER	    2975
30	CLERK	     950
30	MANAGER	    2850
30	SALESMAN	5600
*/

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	     1300   -- 10번 부서 CLERK 직종의 급여합
10	    MANAGER	     2450   -- 10번 부서 MANAGER 직종의 급여합
10	    PRESIDENT	 5000   -- 10번 부서 PRESIDENT 직종의 급여합
10	    (null)       8750   -- 10번 부서 모든 직종의 급여합        -- CHECK~!!!
20	    ANALYST	     6000   -- 20번 부서 ANALYST 직종의 급여합
20	    CLERK	     1900   -- 20번 부서 CLERK 직종의 급여합
20	    MANAGER	     2975   -- 20번 부서 MANAGER 직종의 급여합
20	    (null)      10875   -- 20번 부서 모든 직종의 급여합        -- CHECK~!!!
30	    CLERK	      950   -- 30번 부서 CLERK 직종의 급여합
30	    MANAGER	     2850   -- 30번 부서 MANAGER 직종의 급여합
30	    SALESMAN	 5600   -- 30번 부서 SALESMAN 직종의 급여합
30	    (null)       9400   -- 30번 부서 모든 직종의 급여합        -- CHECK~!!!
(null)  (null)      29025   -- 모든 부서 모든 직종의 급여합        -- CHECK~!!!
*/


--○ CUBE() → ROLLUP() 보다 더 자세한 결과를 반환받는다.
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	     1300
10	    MANAGER	     2450
10	    PRESIDENT	 5000
10	    (null)	     8750
20	    ANALYST	     6000
20	    CLERK	     1900
20	    MANAGER	     2975
20	    (null)	    10875
30	    CLERK	      950
30	    MANAGER	     2850
30	    SALESMAN	 5600
30	    (null)	     9400
(null)	ANALYST	     6000   -- 모든 부서 ANALYST 직종의 급여합
(null)	CLERK	     4150   -- 모든 부서 CLERK 직종의 급여합
(null)	MANAGER	     8275   -- 모든 부서 MANAGER 직종의 급여합
(null)	PRESIDENT	 5000   -- 모든 부서 PRESIDENT 직종의 급여합
(null)	SALESMAN	 5600   -- 모든 부서 SALESMAN 직종의 급여합
(null)  (null)      29025
*/

-- ※ ROLLUP() 과 CUBE() 는
--    그룹을 묶어주는 방식이 다르다. (차이)

-- ex.
-- ROLLUP(A, B, C)
-- → (A, B, C) / (A, B) / (A) / ()

-- CUBE(A, B, C)
-- → (A, B, C) / (A, B) / (A, C) / (B, C) / (A) / (B) / (C) / ()

--==>> 위에서 사용한 것(ROLLUP())은 묶음 방식이 다소 모자라고
--     아래에서 사용한 것(CUBE())은 묶음 방식이 다속 지나치기 때문에
--     다음과 같은 방식의 쿼리 형태를 더 많이 사용한다.
--     다음 작성하는 쿼리는 조회하고자 하는 그룹만 『GROUPING SETS』를
--     이용하여 묶어주는 방식이다.
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴') 
            ELSE '전체부서'
       END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '전체직종'
       END "직종"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	        CLERK	     1300
10	        MANAGER	     2450
10	        PRESIDENT	 5000
10	        전체직종	 8750
20	        ANALYST	     6000
20	        CLERK	     1900
20	        MANAGER	     2975
20	        전체직종	10875
30	        CLERK	      950
30	        MANAGER	     2850
30	        SALESMAN	 5600
30	        전체직종	 9400
인턴	    CLERK	     3500
인턴	    SALESMAN	 5200
인턴	    전체직종	 8700
전체부서	전체직종	37725
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴') 
            ELSE '전체부서'
       END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '전체직종'
       END "직종"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	        CLERK	     1300
10	        MANAGER	     2450
10	        PRESIDENT	 5000
10	        전체직종	 8750
20	        ANALYST 	 6000
20	        CLERK	     1900
20	        MANAGER	     2975
20	        전체직종	10875
30	        CLERK	      950
30	        MANAGER	     2850
30	        SALESMAN	 5600
30	        전체직종	 9400
인턴	    CLERK	     3500
인턴	    SALESMAN	 5200
인턴	    전체직종	 8700
전체부서	ANALYST	     6000
전체부서	CLERK	     7650
전체부서	MANAGER	     8275
전체부서	PRESIDENT	 5000
전체부서	SALESMAN	10800
전체부서	전체직종	37725
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴') 
            ELSE '전체부서'
       END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '전체직종'
       END "직종"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), (JOB), ())
ORDER BY 1, 2;
--> CUBE() 를 사용한 결과와 같은 조회 결과

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴') 
            ELSE '전체부서'
       END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '전체직종'
       END "직종"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), ())
ORDER BY 1, 2;
--> ROLLUP() 을 사용한 결과와 같은 조회 결과

SELECT *
FROM TBL_EMP
ORDER BY HIREDATE;


--○ TBL_EMP 테이블을 대상으로
--   입사년도별 인원수를 조회한다.
--   인원수 총합도!

-- 내 풀이 ---------------------------------------------------------------------
SELECT *
FROM TBL_EMP
ORDER BY HIREDATE;

SELECT T.*, COUNT(T.입사년도) "인원수"
FROM
(
    SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
    FROM TBL_EMP
) T GROUP BY GROUPING SETS((T.입사년도), ());
--==>>
/*
1980	 1
1981	10
1982	 1
1987	 2
2022	 5
(null)  19
*/






   


