SELECT USER
FROM DUAL;
--==>> TEAM3

-- ���� �ο�(SYS ���� ��ȯ�� �� �ο�)
GRANT CREATE VIEW TO TEAM3;

/*
���� ��������䱸�м�(������) - 3.���� ��� ��� ���� ����
�����, ���� �Ⱓ(���� ������, �� ������), ���� ��, �л� ��, ���, �Ǳ�, �ʱ�, ����, ��� 
*/
CREATE OR REPLACE VIEW VIEW_PROFESSOR_GRADE
AS
SELECT T2.�����, T2.����Ⱓ, T2.�����, T2.�л���, T2.���, T2.�Ǳ�, T2.�ʱ�, T2.���������ڵ�, T2.����
     , RANK() OVER(PARTITION BY T2.���������ڵ� ORDER BY T2.���� DESC) "���", T2.�ߵ�Ż������
FROM
(
    SELECT T.*, NVL(T.��� + T.�Ǳ� + T.�ʱ�, 0) "����"
    FROM
    (
        SELECT SJ.SUBJECT_NAME "�����", OS.START_DATE || ' - ' || OS.END_DATE "����Ⱓ"
             , B.BOOK_NAME "�����", S.STU_NAME "�л���"
             , NVL(SC.ATTEND_SCORE * OS.ATTEND_POINT, 0) / 100 "���"
             , NVL(SC.PRACTICE_SCORE * OS.PRACTICE_POINT, 0) / 100 "�Ǳ�"
             , NVL(SC.WRITE_SCORE * OS.WRITE_POINT, 0) / 100 "�ʱ�"
             , OS.OPEN_SUBJ_ID "���������ڵ�"
             , CASE WHEN A.APP_ID = DR.APP_ID THEN '��' ELSE '��' END "�ߵ�Ż������"
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
--==>> View VIEW_PROFESSOR_GRADE��(��) �����Ǿ����ϴ�.