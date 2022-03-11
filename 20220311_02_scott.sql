SELECT USER
FROM DUAL;
--==>> SCOTT


--※ 20220311_01_scott(plsql).sql 파일에서
--   PRC_INSA_INSERT() 프로시저 생성 후 테스트
EXEC PRC_INSA_INSERT('양윤정', '970131-2234567', SYSDATE, '서울', '010-8624-4533', '개발부', '대리', 2000000, 2000000);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

--○ 프로시저 호출(실행) 후 확인
SELECT *
FROM TBL_INSA;
--==>>
/*
                                                 :
1061	양윤정	970131-2234567	2022-03-11	서울	010-8624-4533	개발부	대리	2000000	2000000                               
*/


--○ 실습 테이블 생성
-- 실무에서는 한글로 만들면 안 된다!
-- 트랜잭션 처리의 이해를 위해 한글로 만드는 것
CREATE TABLE TBL_상품
( 상품코드      VARCHAR2(20)
, 상품명        VARCHAR2(100)
, 소비자가격    NUMBER     
, 재고수량      NUMBER DEFAULT 0
, CONSTRAINT 상품_상품코드_PK PRIMARY KEY(상품코드)
);
--==>> Table TBL_상품이(가) 생성되었습니다.
-- TBL_상품 테이블의 상품코드를 기본키(PK) 제약조건 설정


--○ 실습 테이블 생성(TBL_입고)
CREATE TABLE TBL_입고
( 입고번호      NUMBER
, 상품코드      VARCHAR2(100)
, 입고일자      DATE DEFAULT SYSDATE
, 입고수량      NUMBER
, 입고단가      NUMBER
, CONSTRAINT 입고_입고번호_PK PRIMARY KEY(입고번호)
, CONSTRAINT 입고_상품코드_FK FOREIGN KEY(상품코드)
             REFERENCES TBL_상품(상품코드)
);
--==>> Table TBL_입고이(가) 생성되었습니다.
-- TBL_입고 테이블의 입고번호를 기본키(PK) 제약조건 설정
-- TBL_입고 테이블의 상품코드는 TBL_상품 테이블의 상품코드를
-- 참조할 수 있도록 외래키(FK) 제약조건 설정

--○ TBL_상품 테이블에 상품정보 입력
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('H001', '바밤바', 600);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('H002', '죠스바', 500);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('H003', '메로나', 500);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('H004', '보석바', 600);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('H005', '쌍쌍바', 600);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('H006', '수박바', 500);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('H007', '빠삐코', 500);
--==>> 1 행 이(가) 삽입되었습니다. * 7

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('C001', '월드콘', 1600);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('C002', '빵빠레', 1700);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('C003', '구구콘', 1800);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('C004', '메타콘', 1500);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('C005', '부라보', 1500);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('C006', '슈퍼콘', 1500);
--==>> 1 행 이(가) 삽입되었습니다. * 6

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('E001', '빵또아', 1100);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('E002', '셀렉션', 1700);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('E003', '투게더', 2500);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('E004', '거북알', 1500);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('E005', '팥빙수', 1500);
--==>> 1 행 이(가) 삽입되었습니다. * 5

--○ 확인
SELECT *
FROM TBL_상품;
--==>>
/*
H001	바밤바	 600	0
H002	죠스바	 500	0
H003	메로나	 500	0
H004	보석바	 600	0
H005	쌍쌍바	 600	0
H006	수박바	 500	0
H007	빠삐코	 500	0
C001	월드콘	1600	0
C002	빵빠레	1700	0
C003	구구콘	1800	0
C004	메타콘	1500	0
C005	부라보	1500	0
C006	슈퍼콘	1500	0
E001	빵또아	1100	0
E002	셀렉션	1700	0
E003	투게더	2500	0
E004	거북알	1500	0
E005	팥빙수	1500	0
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.


--※ 날짜 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.


--※ TBL_입고 테이블에 『입고』 이벤트 발생 시...
--   관련 테이블에 수행되어야 하는 내용

-- ① INSERT → TBL_입고
--    INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
--    VALUES(1, 'H001', SYSDATE, 30, 400);

-- ② UPDATE → TBL_상품
--    UPDATE TBL_상품
--    SET 재고수량 = 재고수량 + 입고수량
--    WHERE 상품코드 = 'H001';




















