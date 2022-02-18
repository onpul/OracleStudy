SELECT USER
FROM DUAL;
--==>> SYS

SELECT '문자열'
FROM DUAL;
--==>> 문자열
-- 작은 따옴표 확인!

SELECT 550 + 230
FROM DUAL;
--==>> 780

SELECT '박현수' + '홍은혜'
FROM DUAL;
--==>> 에러 발생
--     (ORA-01722: invalid number)
-- 숫자가 아니면 덧셈 연산이 유효하지 않다.

--○ 현재 오라클 서버에 존재하는 사용자 계정 상태 조회
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

--> 『DBA_』로 시작하는 Oracle Data Dictionary View 는
--  오로지 관리자 권한으로 접속했을 경우에만 조회가 가능하다.
--  아직 데이터 딕셔너리 개념을 잡지 못해도 상관없다.

--○ 『HR』 사용자 계정을 잠금 상태로 설정
ALTER USER HR ACCOUNT LOCK;
--==>> User HR이(가) 변경되었습니다.

--○ 사용자 계정 상태 조회
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>> HR	LOCKED

--○ 『HR』 사용자 계정을 잠금 해제 설정
ALTER USER HR ACCOUNT UNLOCK;
--==>> User HR이(가) 변경되었습니다.

--○ 사용자 계정 상태 조회
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>> HR	OPEN

--------------------------------------------------------------------------------

--○ TABLESPACE 생성

--※ TABLESPACE 란?
--> 세그먼트(테이블, 인덱스, ...)를 담아두는(저장해두는)
--  오라클의 논리적인 저장 구조를 의미한다.

CREATE TABLESPACE TBS_EDUA -- 생성하겠다. 테이블스페이스를... TBS_EDUA 라는 이름으로
DATAFILE 'C:\TESTDATA\TBS_DEUA01.DBF' -- 물리적 데이터 파일 경로 및 이름 지정
SIZE 4M -- 사이즈(용량)
EXTENT MANAGEMENT LOCAL -- 오라클 서버가 세그먼트를 알아서 관리할 수 있도록 하겠다.
SEGMENT SPACE MANAGEMENT AUTO; -- 세그먼트 공간 관리도 오라클 서버가 자동으로 관리
--==>> TABLESPACE TBS_EDUA이(가) 생성되었습니다

--※ 테이블스페이스 생성 구문을 실행하기 전에
--   해당 경로의 물리적인 디렉터리 생성이 필요하다.
--   (C:\TESTDATA)

--○ 생성된 테이블스페이스 조회
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

--○ 파일 용량 정보 조회(물리적인 파일 이름 조회)
SELECT *
FROM DBA_DATA_FILES;
--==>>
/*
             :
C:\TESTDATA\TBS_DEUA01.DBF	5	TBS_EDUA	4194304	512	AVAILABLE	5	NO	0	0	0	3145728	384	ONLINE
             :
*/

--○ 오라클 사용자 계정 생성
CREATE USER cmj IDENTIFIED BY java006$
DEFAULT TABLESPACE TBS_EDUA;
--==>> User CMJ이(가) 생성되었습니다.
--> cmj 라는 사용자 계정을 생성하겠다. (만들겠다.)
--  이 사용자 계정의 패스워드는 java006$로 하겠다.
--  이 계정을 통해 생성하는 오라클 세그먼트는
--  기본적으로 TBS_EDUA 라는 테이블스페이스에 생성할 수 있도록 설정하겠다.
--  어드민 파트지만 파이널 때 필요하니 잘 알아두기!!!

--※ 생성된 오라클 사용자 계정(각자 본인 이름 이니셜 계정)을 통해 접속 시도
--   → 접속 불가(실패)
--      『create session』 권한이 없기 때문에 접속 불가.

--○ 생성된 오라클 사용자 계정(각자 본인 이름 이니셜 계정)에 
--   오라클 서버 접속이 가능하도록 CREATE SESSION 권한 부여

-- 권한 부여 GRANT 권한 박탈 REVOKE
GRANT CREATE SESSION to CMJ;
--==>> Grant을(를) 성공했습니다.

--○ 각자 생성한 오라클 사용자 계정의 시스템 관련 권한 조회
SELECT *
FROM DBA_SYS_PRIVS;
--==>>
/*
        :
CMJ	CREATE SESSION	NO
*/

--○ 각자 생성한 오라클 사용자 계정에
--   테이블 생성이 가능하도록 CREATE TABLE 권한 부여

-- 오라클은 권한이 기본적으로는 없고, 하나씩 부여하며 늘려가는 것
GRANT CREATE TABLE TO CMJ;
--==>> Grant을(를) 성공했습니다.

--○ 각자 생성한 오라클 사용자 계정에
--   테이블 스페이스(TBS_EDUA)에서 사용할 수 있는 공간(할당량) 지정.
ALTER USER CMJ 
QUOTA UNLIMITED ON TBS_EDUA;
--==>> User CMJ이(가) 변경되었습니다.

--------------------------------------------------------------------------------

CREATE USER scott
IDENTIFIED BY tiger; -- 패스워드
--==>> User SCOTT이(가) 생성되었습니다.

GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO SCOTT;
--==>> Grant을(를) 성공했습니다.

ALTER USER SCOTT DEFAULT TABLESPACE USERS;
--==>> User SCOTT이(가) 변경되었습니다.

ALTER USER SCOTT TEMPORARY TABLESPACE TEMP; --임시 테이블스페이스는 템프로
--==>> User SCOTT이(가) 변경되었습니다.