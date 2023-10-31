CREATE TABLE "MAIN" (	
    "CNUM" NUMBER(*,0) NOT NULL, 
    "NAME" VARCHAR2(20) NOT NULL, 
    "JOININGDATE" VARCHAR2(6) NOT NULL,
    "TEAM" VARCHAR2(20) NOT NULL,
    "ROLE" VARCHAR2(20) NOT NULL,
    "EMAIL" VARCHAR2(100) NOT NULL, 
    "PHONE" VARCHAR2(20) NOT NULL, 
    "BIRTHDAY" VARCHAR2(6) NOT NULL, 
    "DAYOFF" NUMBER(8) NOT NULL,
    "PASSWORD" VARCHAR2(20) NOT NULL,
    "IMAGEFILE" VARCHAR(50),
    CONSTRAINT "PK_CNUM" PRIMARY KEY ("CNUM")
);

DROP TABLE main;

DELETE FROM main;
DROP SEQUENCE main_seq;
CREATE SEQUENCE main_seq;

SELECT * FROM main ORDER BY cnum DESC;
SELECT COUNT(*) FROM main;

INSERT INTO main (cnum, name, joiningdate, team, role, email, phone, birthday, dayoff, password) 
VALUES (110, '강소은', '230523', '인사', '팀장', 'a@a', '010-2906-0775', '000106', 15, '1234');
INSERT INTO main (cnum, name, joiningdate, team, role, email, phone, birthday, dayoff, password) 
VALUES (111, '김형철', '230312', '식당 운영', '팀장', 'b@a', '010-8928-9488', '000303', 15, '1234');
INSERT INTO main (cnum, name, joiningdate, team, role, email, phone, birthday, dayoff, password) 
VALUES (112, '이하영', '230118', '총무', '팀장', 'c@a', '010-2468-3151', '990608', 15, '1234');
INSERT INTO main (cnum, name, joiningdate, team, role, email, phone, birthday, dayoff, password) 
VALUES (113, '김유진',  '220119', 'IT', '팀장', 'd@a', '010-5044-1868', '901007', 15, '1234');
INSERT INTO main (cnum, name, joiningdate, team, role, email, phone, birthday, dayoff, password) 
VALUES (114, '고대일', '230612', 'IT', '과장', 'e@a', '010-1234-4561', '950504', 15, '1234');
INSERT INTO main (cnum, name, joiningdate, team, role, email, phone, birthday, dayoff, password) 
VALUES (115, '박상아', '230812', '총무',  '사원', 'f@a', '010-1234-4562', '980410', 15, '1234');
INSERT INTO main (cnum, name, joiningdate, team, role, email, phone, birthday, dayoff, password) 
VALUES (116, '남수연', '230301', '식당 운영', '대리', 'g@a', '010-1234-4563', '961117', 15, '1234');
INSERT INTO main (cnum, name, joiningdate, team, role, email, phone, birthday, dayoff, password) 
VALUES (117, '장현규', '230818', '인사', '대리', 'h@a', '010-1234-4564', '971019', 15, '1234');
INSERT INTO main (cnum, name, joiningdate, team, role, email, phone, birthday, dayoff, password) 
VALUES (118, '이소민', '221230', '총무', '대리', 'i@a', '010-1234-4565', '980408', 15, '1234');
INSERT INTO main (cnum, name, joiningdate, team, role, email, phone, birthday, dayoff, password) 
VALUES (220, '유종우', '171013', '경영진', '사장', 'j@a', '010-1234-4566', '800714', 15, '1234');

INSERT INTO main (cnum, name, joiningdate, team, role, email, phone, birthday, dayoff, password) 
VALUES (120, '인사팀', '230523', '인사', '팀장', 'a@a', '010-2906-0775', '000106', 15, '1234');
INSERT INTO main (cnum, name, joiningdate, team, role, email, phone, birthday, dayoff, password) 
VALUES (121, '식당 운영팀', '230312', '식당 운영', '팀장', 'b@a', '010-8928-9488', '000303', 15, '1234');
INSERT INTO main (cnum, name, joiningdate, team, role, email, phone, birthday, dayoff, password) 
VALUES (122, '총무팀', '230118', '총무', '팀장', 'c@a', '010-2468-3151', '990608', 15, '1234');
INSERT INTO main (cnum, name, joiningdate, team, role, email, phone, birthday, dayoff, password) 
VALUES (123, 'IT 개발팀',  '220119', 'IT 개발', '팀장', 'd@a', '010-5044-1868', '901007', 15, '1234');
INSERT INTO main (cnum, name, joiningdate, team, role, email, phone, birthday, dayoff, password) 
VALUES (220, '경영진', '171013', '경영진', '사장', 'j@a', '010-1234-4566', '800714', 15, '1234');

DELETE FROM main WHERE cnum = 220;

INSERT INTO main (cnum, name, joiningdate, team, role, email, phone, birthday, dayoff, password) 
VALUES (200, '관리자', '221222', '경영진', 'ADMIN', 'j@a', '010-1111-1111', '000000', 15, '1234');
SELECT * FROM main WHERE team = '총무';

COMMIT;
    

