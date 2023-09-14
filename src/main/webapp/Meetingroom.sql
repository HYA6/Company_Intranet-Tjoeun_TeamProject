CREATE TABLE "MEETINGROOM" (	
    "ROOM_ID" NUMBER,
    "USER_NAME" VARCHAR2(50 BYTE) NOT NULL ENABLE, 
    "STATUS" VARCHAR2(20 BYTE), 
    "MEETINGDATE" VARCHAR2(100 BYTE), 
    "MEETINGTIME" VARCHAR2(100 BYTE),
    "TEAM" VARCHAR2(50 BYTE),
    "CNUM" NUMBER, 
    CONSTRAINT "FK_CNUM_MAIN_TO_MEETINGROOM" FOREIGN KEY ("CNUM")
    REFERENCES "MAIN" ("CNUM")
);

DROP TABLE meetingroom;

DELETE FROM meetingroom;
DROP SEQUENCE meetingroom_seq;
CREATE SEQUENCE meetingroom_seq;

SELECT COUNT(*) FROM meetingroom;
SELECT * FROM meetingroom ORDER BY room_id DESC;
SELECT * FROM meetingroom ORDER BY MEETINGDATE DESC;

INSERT INTO MeetingRoom (room_id, user_name, meetingDate, meetingTime)
VALUES (101, '111', '111', '111');
INSERT INTO MeetingRoom (room_id, user_name, meetingDate, meetingTime)
VALUES (102, '222', '222', '222');

SELECT * FROM meetingroom where meetingdate = '2023-09-05' and to_number(substr(meetingtime, 4, 2)) >= to_number('15') 
order by room_id;
select substr(meetingtime, 4,2) from meetingroom;
SELECT meetingTime FROM MeetingRoom WHERE room_id = 103 AND meetingDate = '2023-09-11' AND meetingTime = 'AM 10:00';

COMMIT;