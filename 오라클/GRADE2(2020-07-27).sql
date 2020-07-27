-- GRADE2
DROP TABLE tbl_student;
CREATE TABLE tbl_student(
    st_num CHAR(5) PRIMARY KEY,
    st_name nVARCHAR2(20) NOT NULL,
    st_tel VARCHAR2(20) NOT NULL,
    st_addr nVARCHAR2(125),
    st_grade NUMBER NOT NULL,
    st_dept CHAR(3) NOT NULL
);

DROP TABLE tbl_dept;
CREATE TABLE tbl_dept (
    d_code CHAR(3) PRIMARY KEY,
    d_name nVARCHAR2(20) NOT NULL UNIQUE,
    d_prof nVARCHAR2(20)
);

DROP TABLE tbl_score;
CREATE TABLE tbl_score (
    sc_num CHAR(5) NOT NULL,
    sc_subject nVARCHAR2(20) NOT NULL,
    sc_score NUMBER NOT NULL
);

INSERT ALL
INTO tbl_student(st_num, st_name,st_tel, st_addr,st_grade,st_dept)
VALUES 
('20001','갈한수','010-2217-7851','경남 김해시 어방동 1088-7',3,'008')

INTO tbl_student(st_num, st_name,st_tel, st_addr,st_grade,st_dept)
VALUES 
('20002','강이찬','010-4311-1533','강원도 속초시 대포동 956-5',1,'006')

INTO tbl_student(st_num, st_name,st_tel, st_addr,st_grade,st_dept)
VALUES 
('20003','개원훈','010-6262-7441','경북 영천시 문외동 38-3번지',1,'009')

INTO tbl_student(st_num, st_name,st_tel, st_addr,st_grade,st_dept)
VALUES 
('20004','경시현','010-9793-9856','서울시 구도구 구로동 3-35번지',1,'006')

INTO tbl_student(st_num, st_name,st_tel, st_addr,st_grade,st_dept)
VALUES 
('20005','공동영','010-8811-7761','강원도 동해시 천곡동 1077-3',2,'010')
SELECT 1 FROM DUAL;

INSERT INTO tbl_dept (d_code,d_name,d_prof) VALUES ('001','컴퓨터공학','토발즈');
INSERT INTO tbl_dept (d_code,d_name,d_prof) VALUES ('002','전자공학','이철기');
INSERT INTO tbl_dept (d_code,d_name,d_prof) VALUES ('003','법학','킹스필드');

INSERT INTO tbl_score(sc_num, sc_subject, sc_score) VALUES('20001','데이터베이스',71);
INSERT INTO tbl_score(sc_num, sc_subject, sc_score) VALUES('20001','수학',63);
INSERT INTO tbl_score(sc_num, sc_subject, sc_score) VALUES('20001','미술',50);

INSERT INTO tbl_score(sc_num, sc_subject, sc_score) VALUES('20002','데이터베이스',84);
INSERT INTO tbl_score(sc_num, sc_subject, sc_score) VALUES('20002','음악',75);
INSERT INTO tbl_score(sc_num, sc_subject, sc_score) VALUES('20002','국어',52);

INSERT INTO tbl_score(sc_num, sc_subject, sc_score) VALUES('20003','수학',89);
INSERT INTO tbl_score(sc_num, sc_subject, sc_score) VALUES('20003','영어',75);
INSERT INTO tbl_score(sc_num, sc_subject, sc_score) VALUES('20003','국어',70);

SELECT sc_num FROM tbl_score WHERE sc_score < 60;

-- 학번별 성적조회
SELECT sc_num AS 학번, 
    SUM(sc_score),
    ROUND(AVG(sc_score),2)
FROM tbl_score
GROUP BY sc_num
ORDER BY sc_num;

SELECT sc_num AS 학번, ST.st_name, ST.st_tel,
    SUM(sc_score),
    ROUND(AVG(sc_score),2)
FROM tbl_score SC
    LEFT JOIN tbl_student ST
        ON ST.st_num = SC.sc_num
GROUP BY sc_num, ST.st_name, ST.st_tel
ORDER BY sc_num;




