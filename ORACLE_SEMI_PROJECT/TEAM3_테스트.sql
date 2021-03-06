--■■■ 데이터 입력 프로시저 테스트 ■■■--

--1. 관리자 아이디 생성
INSERT INTO ADMIN(ADMIN_ID, ADMIN_NAME, SSN, PASSWORD)
VALUES('ADMIN', '관리자', '123456-1234567', '1111');
--==>> 1 행 이(가) 삽입되었습니다.

--2. 교재 데이터 생성
EXEC PRC_BOOK_INSERT('자바의 정석', '도우출판');
EXEC PRC_BOOK_INSERT('오라클책', '집');
EXEC PRC_BOOK_INSERT('JDBC책', '집');
EXEC PRC_BOOK_INSERT('WEB책', '집');

--3. 강의실 데이터 생성
EXEC PRC_CLASS_INSERT('1강의실');
EXEC PRC_CLASS_INSERT('2강의실');
EXEC PRC_CLASS_INSERT('3강의실');
EXEC PRC_CLASS_INSERT('4강의실');

--4. 과목데이터 생성
EXEC PRC_SUBJECT_INSERT('JAVA');
EXEC PRC_SUBJECT_INSERT('ORACLE');
EXEC PRC_SUBJECT_INSERT('JDBC');
EXEC PRC_SUBJECT_INSERT('WEB');

--5. 과정데이터 생성
EXEC PRC_COURSE_INSERT('풀스택 A');
EXEC PRC_COURSE_INSERT('풀스택 B');
EXEC PRC_COURSE_INSERT('프론트 A');
EXEC PRC_COURSE_INSERT('백엔드 A');

--6. 탈락사유 데이터 생성
EXEC PRC_REASONS_DROPOUT_INSERT('개인사정');
EXEC PRC_REASONS_DROPOUT_INSERT('취업');
EXEC PRC_REASONS_DROPOUT_INSERT('건강문제');

--7. 학생 데이터 생성
EXEC PRC_STU_INSERT('김민성', '970725-1111111');
EXEC PRC_STU_INSERT('이연주', '950816-2111111');
EXEC PRC_STU_INSERT('김태형', '950714-1111111');
EXEC PRC_STU_INSERT('최문정', '990702-2111111');

--8. 교수 데이터 생성
EXEC PRC_PROF_INSERT('양윤정', '970131-2111111');
EXEC PRC_PROF_INSERT('홍수민', '000504-2111111');

--9. 개설과정 데이터 생성
EXEC PRC_OP_COUR_INSERT(TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2022-06-20', 'YYYY-MM-DD'), 'CL009', 'P202200001', 'C00001');
EXEC PRC_OP_COUR_INSERT(TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2022-06-20', 'YYYY-MM-DD'), 'CL010', 'P202200002', 'C00002');
EXEC PRC_OP_COUR_INSERT(TO_DATE('2021-01-01', 'YYYY-MM-DD'), TO_DATE('2021-06-20', 'YYYY-MM-DD'), 'CL010', 'P202200002', 'C00002');
EXEC PRC_OP_COUR_INSERT(TO_DATE('2022-08-01', 'YYYY-MM-DD'), TO_DATE('2022-12-31', 'YYYY-MM-DD'), 'CL011', 'P202200002', 'C00002');

--10. 개설과목 데이터 생성
EXEC PRC_OP_SUBJ_INSERT(TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2022-03-01', 'YYYY-MM-DD'), 'OC22001', 'BK001', 'SB00001', 40, 30, 30);
EXEC PRC_OP_SUBJ_INSERT(TO_DATE('2022-03-02', 'YYYY-MM-DD'), TO_DATE('2022-04-01', 'YYYY-MM-DD'), 'OC22001', 'BK002', 'SB00002', 40, 30, 30);
EXEC PRC_OP_SUBJ_INSERT(TO_DATE('2022-04-02', 'YYYY-MM-DD'), TO_DATE('2022-05-01', 'YYYY-MM-DD'), 'OC22001', 'BK003', 'SB00003', 40, 30, 30);
EXEC PRC_OP_SUBJ_INSERT(TO_DATE('2022-05-02', 'YYYY-MM-DD'), TO_DATE('2022-06-20', 'YYYY-MM-DD'), 'OC22001', 'BK004', 'SB00004', 40, 30, 30);
-- OC22001 개설 강좌의 개설과목
EXEC PRC_OP_SUBJ_INSERT(TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2022-03-01', 'YYYY-MM-DD'), 'OC22002', 'BK001', 'SB00001', 40, 30, 30);
EXEC PRC_OP_SUBJ_INSERT(TO_DATE('2022-03-02', 'YYYY-MM-DD'), TO_DATE('2022-04-01', 'YYYY-MM-DD'), 'OC22002', 'BK002', 'SB00002', 40, 30, 30);
EXEC PRC_OP_SUBJ_INSERT(TO_DATE('2022-04-02', 'YYYY-MM-DD'), TO_DATE('2022-05-01', 'YYYY-MM-DD'), 'OC22002', 'BK003', 'SB00003', 40, 30, 30);
EXEC PRC_OP_SUBJ_INSERT(TO_DATE('2022-05-02', 'YYYY-MM-DD'), TO_DATE('2022-06-20', 'YYYY-MM-DD'), 'OC22002', 'BK004', 'SB00004', 40, 30, 30);
-- OC2202 개설 강좌의 개설과목

--11. 수강신청 데이터 입력
-- 이미 시작한 과정...은 따로 넣어주자...
INSERT INTO APP(APP_ID, OPEN_COUR_ID, STU_ID, APP_DATE) VALUES('AP90001', 'OC22001', 'S202200001', TO_DATE('2022-01-01', 'YYYY-MM-DD'));
INSERT INTO APP(APP_ID, OPEN_COUR_ID, STU_ID, APP_DATE) VALUES('AP90002', 'OC22001', 'S202200002', TO_DATE('2022-01-01', 'YYYY-MM-DD'));
INSERT INTO APP(APP_ID, OPEN_COUR_ID, STU_ID, APP_DATE) VALUES('AP90003', 'OC22001', 'S202200003', TO_DATE('2022-01-01', 'YYYY-MM-DD'));
INSERT INTO APP(APP_ID, OPEN_COUR_ID, STU_ID, APP_DATE) VALUES('AP90004', 'OC22001', 'S202200004', TO_DATE('2022-01-01', 'YYYY-MM-DD'));

SELECT *
FROM SCORE;
COMMIT;

-- 12. 성적 데이터 입력
EXEC PRC_SCORE_INSERT('OS2200001', 'AP90001', 100, 90, 60);
EXEC PRC_SCORE_INSERT('OS2200001', 'AP90002', 90, 90, 60);
EXEC PRC_SCORE_INSERT('OS2200001', 'AP90003', 100, 90, 70);
EXEC PRC_SCORE_INSERT('OS2200001', 'AP90004', 80, 60, 60);

-- 13. 중도탈락리스트 데이터 입력 PRC_DROPOUT_INSERT
EXEC PRC_DROPOUT_INSERT('AP90001', 'DR001');
EXEC PRC_DROPOUT_INSERT('AP90002', 'DR002');

--------------------------------------------------------------------------------

--■■■ 데이터 수정 프로시저 테스트 ■■■--

-- 14. 교수 데이터 수정 
EXEC PRC_PROF_UPDATE('P202200001', '970131-2111112');

-- 15. 학생 데이터 수정
EXEC PRC_STU_UPDATE('S202200001', '970725-1111112');


--■■■ 로그인 테스트 ■■■--
SET SERVEROUTPUT ON;
EXEC PRC_LOGIN_ADMIN('ADMIN', '1111');
EXEC PRC_LOGIN_ADMIN('ADMIN', '1112');

EXEC PRC_LOGIN_PROF('P202200002', '2111111');
EXEC PRC_LOGIN_PROF('P202200002', '2111112');

EXEC PRC_LOGIN_STU('S202200004', '2111111');
EXEC PRC_LOGIN_STU('S202200004', '2111112');

SELECT *
FROM DROPOUT; --중도탈락리스트
--==>>
/*
D00003	AP90002	DR002	2022-03-18
D00001	AP90001	DR001	2022-03-18
*/

SELECT *
FROM REASONS_DROPOUT; --탈락사유
--==>>
/*
DR004	건강문제
DR001	개인사정
DR002	취업
*/

--■■■ 삭제 테스트 ■■■--
EXEC PRC_REASONS_DROPOUT_DELETE('DR004');