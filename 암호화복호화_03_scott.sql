SELECT USER
FROM DUAL;
--==>> SCOTT


--���� ��ȣȭ ��ȣȭ Ȯ�� �ǽ� ����--

--�� ���̺� ����
CREATE TABLE TBL_EXAM
( ID    NUMBER
, PW    VARCHAR2(20)
);
--==>> Table TBL_EXAM��(��) �����Ǿ����ϴ�.


--�� ������ �Է�(���ȣȭ)
INSERT INTO TBL_EXAM(ID, PW) VALUES(1, 'abcd1234');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


--�� Ȯ��
SELECT *
FROM TBL_EXAM;
--==>> 1	abcd1234


--�� �ѹ�
ROLLBACK;
--==>> �ѹ� �Ϸ�.


--�� ������ �Է�(��ȣȭ)
INSERT INTO TBL_EXAM(ID, PW) VALUES(1, CRYPTPACK.ENCRYPT('abcd1234', '0518'));
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


--�� Ȯ��
SELECT *
FROM TBL_EXAM;
--==>> 1	"$F??"


--�� ������ ��ȸ(��ȣȭ)
SELECT ID, CRYPTPACK.DECRYPT(PW, '1111') -- �߸��� Ű ��
FROM TBL_EXAM;
--==>> 1	?a!L


SELECT ID, CRYPTPACK.DECRYPT(PW, '2222') -- �߸��� Ű ��
FROM TBL_EXAM;
--==>> 1	?ku?o


SELECT ID, CRYPTPACK.DECRYPT(PW, '0518') -- �ùٸ� Ű ��
FROM TBL_EXAM;
--==>> 1	abcd1234



