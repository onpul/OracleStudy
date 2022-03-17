SELECT USER
FROM DUAL;
--==>> TEAM3

-- 권한 부여(SYS 계정 전환한 후 부여)
GRANT CREATE VIEW TO TEAM3;

/*
■■■ 사용자측요구분석(교수자) - 3.성적 출력 기능 구현 ■■■
과목명, 과목 기간(시작 연월일, 끝 연월일), 교재 명, 학생 명, 출결, 실기, 필기, 총점, 등수 
*/
CREATE OR REPLACE VIEW VIEW_PROFESSOR_GRADE
AS
SELECT T2.과목명, T2.과목기간, T2.교재명, T2.학생명, T2.출결, T2.실기, T2.필기, T2.개설과목코드, T2.총점
     , RANK() OVER(PARTITION BY T2.개설과목코드 ORDER BY T2.총점 DESC) "등수", T2.중도탈락여부
FROM
(
    SELECT T.*, NVL(T.출결 + T.실기 + T.필기, 0) "총점"
    FROM
    (
        SELECT SJ.SUBJECT_NAME "과목명", OS.START_DATE || ' - ' || OS.END_DATE "과목기간"
             , B.BOOK_NAME "교재명", S.STU_NAME "학생명"
             , NVL(SC.ATTEND_SCORE * OS.ATTEND_POINT, 0) / 100 "출결"
             , NVL(SC.PRACTICE_SCORE * OS.PRACTICE_POINT, 0) / 100 "실기"
             , NVL(SC.WRITE_SCORE * OS.WRITE_POINT, 0) / 100 "필기"
             , OS.OPEN_SUBJ_ID "개설과목코드"
             , CASE WHEN A.APP_ID = DR.APP_ID THEN '○' ELSE 'Ⅹ' END "중도탈락여부"
        FROM OPEN_COUR OC JOIN PROF P
        ON OC.PROF_ID = P.PROF_ID
            JOIN OPEN_SUBJ OS
            ON OC.OPEN_COUR_ID = OS.OPEN_COUR_ID
            JOIN SUBJECT SJ
            ON OS.SUBJECT_ID = SJ.SUBJECT_ID
            JOIN BOOK B
            ON OS.BOOK_ID = B.BOOK_ID
            JOIN APP A
            ON OC.OPEN_COUR_ID = A.OPEN_COUR_ID
            JOIN STU S
            ON A.STU_ID = S.STU_ID
            JOIN SCORE SC
            ON A.APP_ID = SC.APP_ID
            JOIN DROPOUT DR
            ON A.APP_ID = DR.APP_ID
    ) T
) T2;
--==>> View VIEW_PROFESSOR_GRADE이(가) 생성되었습니다.