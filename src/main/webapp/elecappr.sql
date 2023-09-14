CREATE TABLE "ELECAPPR" (	
    "IDX" NUMBER(*,0) NOT NULL, 
    "CNUM" NUMBER(*,0) DEFAULT 0, 
    "NAME" VARCHAR2(20), 
    "SUBJECT" VARCHAR2(1000) NOT NULL, 
    "CONTENT" VARCHAR2(3000) NOT NULL, 
    "WRITEDATE" TIMESTAMP (6) DEFAULT sysdate, 
    "STATUS" VARCHAR2(20), 
    "REASON" VARCHAR2(1000), 
    "PAPER" VARCHAR2(60),
    "FILENAME" VARCHAR2(200 BYTE), 
    CONSTRAINT "ELECAPPR_PK" PRIMARY KEY ("IDX"),
    CONSTRAINT "FK_CNUM_MAIN_TO_ELEC" FOREIGN KEY ("CNUM")
    REFERENCES "MAIN" ("CNUM")
);

DROP TABLE elecappr;

DELETE FROM elecappr;
DROP SEQUENCE elecappr_idx_seq;
CREATE SEQUENCE elecappr_idx_seq;

SELECT * FROM elecappr ORDER BY idx DESC;
SELECT COUNT(*) FROM elecappr;
select * from elecappr where cnum = 110 order by idx desc;

Insert into ELECAPPR (IDX,CNUM,NAME,SUBJECT,CONTENT,WRITEDATE,STATUS,REASON,PAPER) values (elecappr_idx_seq.nextval,110,'강소은','탕비실 간식 지출결의서','탕비실 간식 지출결의서',to_timestamp('23/06/14 16:39:38.000000000','RR/MM/DD HH24:MI:SSXFF'),'승인',null,'지출결의서');
Insert into ELECAPPR (IDX,CNUM,NAME,SUBJECT,CONTENT,WRITEDATE,STATUS,REASON,PAPER) values (elecappr_idx_seq.nextval,111,'김형철','GWD-3120 개선에 관한 제안서','GWD-3120 개선에 관한 제안서',to_timestamp('23/07/03 16:41:06.000000000','RR/MM/DD HH24:MI:SSXFF'),'반려','양식 불충분','휴가근태서');
Insert into ELECAPPR (IDX,CNUM,NAME,SUBJECT,CONTENT,WRITEDATE,STATUS,REASON,PAPER) values (elecappr_idx_seq.nextval,112,'이하영','임원 승진 공문','임원 승진 공문',to_timestamp('23/07/05 16:42:10.000000000','RR/MM/DD HH24:MI:SSXFF'),'승인',null,'공문');
Insert into ELECAPPR (IDX,CNUM,NAME,SUBJECT,CONTENT,WRITEDATE,STATUS,REASON,PAPER) values (elecappr_idx_seq.nextval,113,'김유진','07.24~07.25 휴가신청서','07.24~07.25 휴가신청서',to_timestamp('23/07/06 16:42:52.000000000','RR/MM/DD HH24:MI:SSXFF'),'승인',null,'휴가근태서');
Insert into ELECAPPR (IDX,CNUM,NAME,SUBJECT,CONTENT,WRITEDATE,STATUS,REASON,PAPER) values (elecappr_idx_seq.nextval,114,'고대일','협조 요청 제안','협조 요청 제안',to_timestamp('23/07/08 16:43:08.000000000','RR/MM/DD HH24:MI:SSXFF'),'반려','사측에서 충분히 가능','제안서');
Insert into ELECAPPR (IDX,CNUM,NAME,SUBJECT,CONTENT,WRITEDATE,STATUS,REASON,PAPER) values (elecappr_idx_seq.nextval,115,'박상아','07.24~07.29 휴가신청합니다.','07.24~07.29 휴가신청합니다.',to_timestamp('23/07/09 16:44:08.000000000','RR/MM/DD HH24:MI:SSXFF'),'반려',null,'휴가근태서');
Insert into ELECAPPR (IDX,CNUM,NAME,SUBJECT,CONTENT,WRITEDATE,STATUS,REASON,PAPER) values (elecappr_idx_seq.nextval,116,'남수연','사내 직원 건강검진 공문','사내 직원 건강검진 공문',to_timestamp('23/07/09 16:44:31.000000000','RR/MM/DD HH24:MI:SSXFF'),'승인',null,'공문');
Insert into ELECAPPR (IDX,CNUM,NAME,SUBJECT,CONTENT,WRITEDATE,STATUS,REASON,PAPER) values (elecappr_idx_seq.nextval,117,'장현규','장현규 사원 사직서','안녕하세요.코딩 5팀 장현규입니다.
동거동락했던 우리 팀원을 뒤로 두고 퇴사하는 것이 마음에 걸립니다.
''희희낙락'' 그 자체였던 생활이었습니다.
여러분의 앞으로의 도전에도 행운이 깃드시길 바랍니다.

감사합니다
장현규 배상',to_timestamp('23/07/10 16:44:47.000000000','RR/MM/DD HH24:MI:SSXFF'),'반려',null,'사직서');

COMMIT;
