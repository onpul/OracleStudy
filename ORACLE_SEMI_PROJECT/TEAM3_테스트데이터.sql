INSERT INTO STU(STU_ID, STU_NAME, SSN, PASSWORD)
VALUES ('1', '홍수민', '000101-1234567', '1234567');
INSERT INTO STU(STU_ID, STU_NAME, SSN, PASSWORD)
VALUES ('2', '홍길동', '000202-1723456', '1723456');
INSERT INTO STU(STU_ID, STU_NAME, SSN, PASSWORD)
VALUES ('3', '최문정', '990702-1234567', '1234567');

SELECT *
FROM STU;

INSERT INTO COURSE(COURSE_ID, COURSE_NAME)
VALUES ('1','개발자양성');

SELECT *
FROM COURSE;

INSERT INTO SUBJECT(SUBJECT_ID, SUBJECT_NAME)
VALUES ('1', '자바');

SELECT *
FROM SUBJECT;

INSERT INTO CLASS(CLASS_ID, CLASS_NAME)
VALUES ('1', '101강의실');

SELECT *
FROM CLASS;

INSERT INTO PROF(PROF_ID, PROF_NAME, SSN, PASSWORD, REGIST_DATE)
VALUES('1','홍길동','001010-1765432','1765432',TO_DATE('2022-04-02','YYYY-MM-DD'));

SELECT *
FROM PROF;


INSERT INTO OPEN_COUR(OPEN_COUR_ID, START_DATE, END_DATE, CLASS_ID, PROF_ID, REGIST_DATE, COURSE_ID)
VALUES ('1', '2022-01-01','2022-05-01','1','1','2022-01-01','1');

SELECT *
FROM OPEN_COUR;

INSERT INTO APP(APP_ID, OPEN_COUR_ID, STU_ID)
VALUES ('1', '1', '1');
INSERT INTO APP(APP_ID, OPEN_COUR_ID, STU_ID)
VALUES ('2', '1', '2');
INSERT INTO APP(APP_ID, OPEN_COUR_ID, STU_ID)
VALUES ('3', '1', '3');

SELECT *
FROM APP;

INSERT INTO BOOK(BOOK_ID, BOOK_NAME, BOOK_PUB)
VALUES ('1','자바의정석',TO_DATE('2022-05-01','YYYY-MM-DD'));
SELECT *
FROM BOOK;

INSERT INTO OPEN_SUBJ(OPEN_SUBJ_ID, START_DATE, END_DATE, OPEN_COUR_ID, BOOK_ID, SUBJECT_ID, WRITE_POINT, PRACTICE_POINT, ATTEND_POINT)
VALUES ('1','2022-01-01','2022-02-01','1','1','1',30 ,30 ,40);
SELECT *
FROM OPEN_SUBJ;

INSERT INTO SCORE(SCORE_ID, OPEN_SUBJ_ID, APP_ID, ATTEND_SCORE, WRITE_SCORE, PRACTICE_SCORE, SCORE_DATE)
VALUES ('1','1','1',40 ,50 ,10,'2022-05-05');
INSERT INTO SCORE(SCORE_ID, OPEN_SUBJ_ID, APP_ID, ATTEND_SCORE, WRITE_SCORE, PRACTICE_SCORE, SCORE_DATE)
VALUES ('2','1','2',90 ,80 ,70,'2022-05-05');
SELECT *
FROM SCORE;

INSERT INTO REASONS_DROPOUT(REASONS_DROPOUT_ID, REASON_DROPOUT)
VALUES ('1','이유없음');
SELECT *
FROM REASONS_DROPOUT;

INSERT INTO DROPOUT(DROPOUT_ID, APP_ID, REASONS_DROPOUT_ID)
VALUES('1','1','1');
SELECT *
FROM DROPOUT;