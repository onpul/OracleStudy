SELECT USER
FROM DUAL;
--==>> SYS

SELECT '���ڿ�'
FROM DUAL;
--==>> ���ڿ�
-- ���� ����ǥ Ȯ��!

SELECT 550 + 230
FROM DUAL;
--==>> 780

SELECT '������' + 'ȫ����'
FROM DUAL;
--==>> ���� �߻�
--     (ORA-01722: invalid number)
-- ���ڰ� �ƴϸ� ���� ������ ��ȿ���� �ʴ�.

--�� ���� ����Ŭ ������ �����ϴ� ����� ���� ���� ��ȸ
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>>
/*
SYS              	OPEN
SYSTEM          	OPEN
ANONYMOUS       	OPEN
HR	                OPEN
APEX_PUBLIC_USER	LOCKED
FLOWS_FILES     	LOCKED
APEX_040000	        LOCKED
OUTLN           	EXPIRED & LOCKED
DIP	                EXPIRED & LOCKED
ORACLE_OCM	        EXPIRED & LOCKED
XS$NULL         	EXPIRED & LOCKED
MDSYS	            EXPIRED & LOCKED
CTXSYS	            EXPIRED & LOCKED
DBSNMP	            EXPIRED & LOCKED
XDB	                EXPIRED & LOCKED
APPQOSSYS          	EXPIRED & LOCKED
*/

SELECT *
FROM DBA_USERS;
--==>>
/*
SYS     	         0		OPEN		                    2022-08-14	SYSTEM	TEMP	2014-05-29	DEFAULT	SYS_GROUP	
SYSTEM	             5		OPEN		                    2022-08-14	SYSTEM	TEMP	2014-05-29	DEFAULT	SYS_GROUP	
ANONYMOUS	        35		OPEN		                    2014-11-25	SYSAUX	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP	
HR	                43		OPEN		                    2022-08-15	USERS	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP	
APEX_PUBLIC_USER	45		LOCKED	            2014-05-29	2014-11-25	SYSTEM	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP	
FLOWS_FILES	        44		LOCKED	            2014-05-29	2014-11-25	SYSAUX	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP	
APEX_040000	        47		LOCKED          	2014-05-29	2014-11-25	SYSAUX	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP	
OUTLN	             9		EXPIRED & LOCKED	2022-02-15	2022-02-15	SYSTEM	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP	
DIP	                14		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSTEM	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP	
ORACLE_OCM      	21		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSTEM	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP	
XS$NULL 	2147483638		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSTEM	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP	
MDSYS	            42		EXPIRED & LOCKED	2014-05-29	2022-02-15	SYSAUX	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP	
CTXSYS          	32		EXPIRED & LOCKED	2022-02-15	2022-02-15	SYSAUX	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP	
DBSNMP	            29		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSAUX	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP	
XDB	                34		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSAUX	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP	
APPQOSSYS	        30		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSAUX	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP	
*/  

SELECT USERNAME
FROM DBA_USERS;
--==>>
/*
SYS
SYSTEM
ANONYMOUS
HR
APEX_PUBLIC_USER
FLOWS_FILES
APEX_040000
OUTLN
DIP
ORACLE_OCM
XS$NULL
MDSYS
CTXSYS
DBSNMP
XDB
APPQOSSYS
*/

SELECT USERNAME, CREATED
FROM DBA_USERS;
--==>>
/*
SYS	                2014-05-29
SYSTEM	            2014-05-29
ANONYMOUS	        2014-05-29
HR	                2014-05-29
APEX_PUBLIC_USER	2014-05-29
FLOWS_FILES     	2014-05-29
APEX_040000	        2014-05-29
OUTLN	            2014-05-29
DIP	                2014-05-29
ORACLE_OCM      	2014-05-29
XS$NULL         	2014-05-29
MDSYS	            2014-05-29
CTXSYS	            2014-05-29
DBSNMP	            2014-05-29
XDB	                2014-05-29
APPQOSSYS          	2014-05-29
*/

--> ��DBA_���� �����ϴ� Oracle Data Dictionary View ��
--  ������ ������ �������� �������� ��쿡�� ��ȸ�� �����ϴ�.
--  ���� ������ ��ųʸ� ������ ���� ���ص� �������.

--�� ��HR�� ����� ������ ��� ���·� ����
ALTER USER HR ACCOUNT LOCK;
--==>> User HR��(��) ����Ǿ����ϴ�.

--�� ����� ���� ���� ��ȸ
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>> HR	LOCKED

--�� ��HR�� ����� ������ ��� ���� ����
ALTER USER HR ACCOUNT UNLOCK;
--==>> User HR��(��) ����Ǿ����ϴ�.

--�� ����� ���� ���� ��ȸ
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>> HR	OPEN

--------------------------------------------------------------------------------

--�� TABLESPACE ����

--�� TABLESPACE ��?
--> ���׸�Ʈ(���̺�, �ε���, ...)�� ��Ƶδ�(�����صδ�)
--  ����Ŭ�� ������ ���� ������ �ǹ��Ѵ�.

CREATE TABLESPACE TBS_EDUA -- �����ϰڴ�. ���̺����̽���... TBS_EDUA ��� �̸�����
DATAFILE 'C:\TESTDATA\TBS_DEUA01.DBF' -- ������ ������ ���� ��� �� �̸� ����
SIZE 4M -- ������(�뷮)
EXTENT MANAGEMENT LOCAL -- ����Ŭ ������ ���׸�Ʈ�� �˾Ƽ� ������ �� �ֵ��� �ϰڴ�.
SEGMENT SPACE MANAGEMENT AUTO; -- ���׸�Ʈ ���� ������ ����Ŭ ������ �ڵ����� ����
--==>> TABLESPACE TBS_EDUA��(��) �����Ǿ����ϴ�

--�� ���̺����̽� ���� ������ �����ϱ� ����
--   �ش� ����� �������� ���͸� ������ �ʿ��ϴ�.
--   (C:\TESTDATA)

--�� ������ ���̺����̽� ��ȸ
SELECT *
FROM DBA_TABLESPACES;
--==>>
/*
SYSTEM	    8192	65536		    1	    2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	    NO	    LOCAL	SYSTEM	NO	MANUAL	DISABLED	NOT APPLY	NO	HOST	NO	
SYSAUX	    8192	65536		    1	    2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	    NO	    LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
UNDOTBS1	8192	65536		    1	    2147483645	2147483645		65536	ONLINE	UNDO	    LOGGING	    NO	    LOCAL	SYSTEM	NO	MANUAL	DISABLED	NOGUARANTEE	NO	HOST	NO	
TEMP	    8192	1048576	1048576	1		2147483645	0	            1048576	ONLINE	TEMPORARY	NOLOGGING	NO	    LOCAL	UNIFORM	NO	MANUAL	DISABLED	NOT APPLY	NO	HOST	NO	
USERS	    8192	65536		    1	    2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING 	NO  	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
TBS_EDUA	8192	65536		    1	    2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	    NO	    LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
*/

--�� ���� �뷮 ���� ��ȸ(�������� ���� �̸� ��ȸ)
SELECT *
FROM DBA_DATA_FILES;
--==>>
/*
             :
C:\TESTDATA\TBS_DEUA01.DBF	5	TBS_EDUA	4194304	512	AVAILABLE	5	NO	0	0	0	3145728	384	ONLINE
             :
*/

--�� ����Ŭ ����� ���� ����
CREATE USER cmj IDENTIFIED BY java006$
DEFAULT TABLESPACE TBS_EDUA;
--==>> User CMJ��(��) �����Ǿ����ϴ�.
--> cmj ��� ����� ������ �����ϰڴ�. (����ڴ�.)
--  �� ����� ������ �н������ java006$�� �ϰڴ�.
--  �� ������ ���� �����ϴ� ����Ŭ ���׸�Ʈ��
--  �⺻������ TBS_EDUA ��� ���̺����̽��� ������ �� �ֵ��� �����ϰڴ�.
--  ���� ��Ʈ���� ���̳� �� �ʿ��ϴ� �� �˾Ƶα�!!!

--�� ������ ����Ŭ ����� ����(���� ���� �̸� �̴ϼ� ����)�� ���� ���� �õ�
--   �� ���� �Ұ�(����)
--      ��create session�� ������ ���� ������ ���� �Ұ�.

--�� ������ ����Ŭ ����� ����(���� ���� �̸� �̴ϼ� ����)�� 
--   ����Ŭ ���� ������ �����ϵ��� CREATE SESSION ���� �ο�

-- ���� �ο� GRANT ���� ��Ż REVOKE
GRANT CREATE SESSION to CMJ;
--==>> Grant��(��) �����߽��ϴ�.

--�� ���� ������ ����Ŭ ����� ������ �ý��� ���� ���� ��ȸ
SELECT *
FROM DBA_SYS_PRIVS;
--==>>
/*
        :
CMJ	CREATE SESSION	NO
*/

--�� ���� ������ ����Ŭ ����� ������
--   ���̺� ������ �����ϵ��� CREATE TABLE ���� �ο�

-- ����Ŭ�� ������ �⺻�����δ� ����, �ϳ��� �ο��ϸ� �÷����� ��
GRANT CREATE TABLE TO CMJ;
--==>> Grant��(��) �����߽��ϴ�.

--�� ���� ������ ����Ŭ ����� ������
--   ���̺� �����̽�(TBS_EDUA)���� ����� �� �ִ� ����(�Ҵ緮) ����.
ALTER USER CMJ 
QUOTA UNLIMITED ON TBS_EDUA;
--==>> User CMJ��(��) ����Ǿ����ϴ�.

--------------------------------------------------------------------------------

CREATE USER scott
IDENTIFIED BY tiger; -- �н�����
--==>> User SCOTT��(��) �����Ǿ����ϴ�.

GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO SCOTT;
--==>> Grant��(��) �����߽��ϴ�.

ALTER USER SCOTT DEFAULT TABLESPACE USERS;
--==>> User SCOTT��(��) ����Ǿ����ϴ�.

ALTER USER SCOTT TEMPORARY TABLESPACE TEMP; --�ӽ� ���̺����̽��� ������
--==>> User SCOTT��(��) ����Ǿ����ϴ�.