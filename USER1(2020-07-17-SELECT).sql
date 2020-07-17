-- 여기는 user1 화면입니다
SELECT * FROM tbl_dept ;

-- PROJECTION, SELECTION
-- DB 공학에서 논리적인 차원 DB 관련용서
-- 실무에서는 별로 사용하지 않는 단어이기도 하다.

-- PROJECTION
SELECT d_code, d_name, d_prof
FROM tbl_dept;

-- SELECTION
SELECT *
FROM tbl_dept
WHERE d_name = '관광학';

-- 현재 학과테이블의 학과명중에 관광학 학과를 관광정보학으로 변경을 하려고 한다.
-- 1. 내가 변경하고자하는 조건에 맞는 데이터가 있는 확인
SELECT * FROM tbl_dept WHERE d_name = '관광학';

-- 2. SELECTION 한 결과가 1개의 레코드만 나타나고 있지만 d_name 은 PK가 아니다.
--      여기에서 보여주는 데이터는 리스트이다.
--      UPDATE 할때 d_name = '관광학' 조건으로 UPDATE를 실행하면 안된다.

--      UPDATE tbl_dept SET d_name = '관광정보학' WHERE d_name ='관광학' 처럼
--          명령을 수행하면 안된다.

-- 3. 조회된 결과에서 PK이 무엇인지를 파악해야 한다.

-- 4. PK를 조건으로 데이터를 UPDATE 수행해야 한다.
UPDATE tbl_dept 
SET d_name = '관광정보학'
WHERE d_code = 'D001' ;

SELECT * FROM tbl_dept ;

INSERT INTO tbl_dept(d_code, d_name,d_prof)
VALUES ('D006','무역학','장길산');

-- DELETE
-- DBMS의 스키마에 포함된 Table중에 여러 업무를 수행하는데 필요한 Table을
--      보틍 Master Data Table이라고 한다.
--      (학생정보, 학과정보)
--      Master Data는 초기에 INSERT가 수행된 후에 업무가 진행동안
--      가급적 데이터를 변경하거나, 삭제하는 일이 최소화 되어야 하는 데이터이다
--      Master Data와 Relation을 하여 생성되는 여러데이터들의 무결성을 위해서
--      Master Data는 변경을 최소화 하면서 유지 해야 한다.

-- DBMS의 스키마에 포함된 Table중에 수시로 데이터가 추가, 변경, 삭제가 필요한 Table을
--      보통 Work Data Table 이라고 한다.
--      (성적정보)
--      Work Data는 수시로 데이터가 추가되고, 여러가지 연산을 수행하여
--      통계, 집계 등 보고서를 작성하는 기본 데이터가 된다.
--      통계, 집계 등 보고서를 작성한 후 데이터를 검증하였을때 이상이 있으면
--      데이터를 수정, 삭제를 수행하여 정정하는 과정이 이루어진다.
--      Work Data는 Master Table과 Relation을 잘 연동하여 
--      데이터를 INSERT 하는 단계부터 잘못된 데이터가 추가되는 것을 막아줄 필요가 있다.
--      이때 설정하는 조건중에 외래키 연관 조건이 있다.

SELECT * FROM tbl_score;
INSERT INTO tbl_score(sc_num) VALUE(100);
COMMIT ;

UPDATE tbl_score        -- 변경할 테이블
SET sc_kor = 90         -- 변경할 대상 = 값
WHERE sc_num = '20015'  -- 조건(Update에서 WHERE는 선택사항이나, 실무에서는 필수사항으로 인식)

UPDATE tbl_score
SET sc_kor = 90, sc_math = 90 -- 다수의 칼럼 값을 변경하고 할때 칼럼 = 값, 칼럼 = 값 형식으로
WHERE sc_num = '20015';

SELECT * FROM tbl_Score;
SELECT * FROM tbl_score WHERE sc_num = '20015' ;

UPDATE tbl_score
SET sc_kor = 100;

SELECT * FROM tbl_score;

-- SQL문으로 CUD(Insert,Udate,Delete)를 수행하고 난 직후에는
-- Table의 변경된 데이터가 물리적(스토리지)에 반영이 아직 안된상태이다
-- 스토리지에 데이터 변경이 반영이 되기전에
-- ROLLBACK 명령을 수행하면 변경내용이 모두 제거(취소) 된다.
-- ROLLBACK 명령을 잘못 수행하면, 정상적으로 변경(CUD) 필요한 데이터 마져
-- 변경이 취소되어 문제을 일으킬수 있다.

-- INSERT 를 수행하고 난 직후에는 데이터의 변경이 물리적으로 반영될수 있도록
-- COMMIT 명령을 수행해주는 것이 좋다.
-- UPDATE나 DELETE는 수행한 직후 반드시 SELECT 를 수행하여
--      원하는결과가 잘 수행되었는지 확인하는 것이 좋다

ROLLBACK;
SELECT * FROM tbl_score;

-- 20020 학번의 학생이 시험날 결석을 하여 시험 응시를 하지 못했는데
--  성적이 입력되었다.
--  이 학생의 성적데이터는 삭제되어 한다.
--  20020 학생이 정말 시험날 결석한 학생인지 확인하는 절차가 필요하다
--  20020 학생의 학생정보를 확인하고, 만약 이 학생의 성적정보가 등록되어 있다면
--  삭제를 수행하자.
SELECT * FROM tbl_student WHERE st_num = '20020';

-- 아래 Query문을 실행했을때
-- 학생정보는 보이는데, 성적정보 칼럼 값들이 모두 (null)로 나타나면
--      이 학생의 성적정보는 등록되지 않은 것이다.
--      따라서 삭제하는 과정이 필요하지 않다.

-- 학생정봐 함께 성적정보 칼럼의 값들이 1개라도 (null)이 아닌 것으로 나타나면
--      이 학생의 성적정보는 등록된 것이다.
--      따라서 학생의 성적정보를 삭제해야 한다.

SELECT *
FROM tbl_student ST
    LEFT JOIN tbl_score SC
        ON ST.st_num = Sc.sc_num
WHERE ST.st_num = '20020';        







