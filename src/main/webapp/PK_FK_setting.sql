alter table main
add constraint pk_cnum PRIMARY KEY(cnum);

alter table fboard
add constraint pk_fboard_idx PRIMARY KEY(idx);

alter table board
add constraint pk_board_idx PRIMARY KEY(idx);

alter table schedule
add constraint pk_schedule_idx primary key(schedule_idx);

alter table meal
add(cnum number(*));

alter table meetingroom
add(cnum number(*));



ALTER TABLE atten_date
ADD CONSTRAINT fk_cnum_main_to_atten foreign KEY(cnum) references main (cnum);

ALTER TABLE elecappr
ADD CONSTRAINT fk_cnum_main_to_elec foreign KEY(cnum) references main (cnum);

ALTER TABLE board
ADD CONSTRAINT fk_cnum_main_to_board foreign KEY(cnum) references main (cnum);

ALTER TABLE fboard
alter table main
add constraint pk_cnum PRIMARY KEY(cnum);

alter table fboard
add constraint pk_fboard_idx PRIMARY KEY(idx);

alter table board
add constraint pk_board_idx PRIMARY KEY(idx);



ALTER TABLE atten_date
ADD CONSTRAINT fk_cnum_main_to_atten foreign KEY(cnum) references main (cnum);

ALTER TABLE elecappr
ADD CONSTRAINT fk_cnum_main_to_elec foreign KEY(cnum) references main (cnum);

ALTER TABLE board
ADD CONSTRAINT fk_cnum_main_to_board foreign KEY(cnum) references main (cnum);

ALTER TABLE fboard
ADD CONSTRAINT fk_cnum_main_to_fboard foreign KEY(cnum) references main (cnum);

alter table meal
ADD CONSTRAINT fk_cnum_main_to_meal foreign KEY(cnum) references main (cnum);

alter table meetingroom
ADD CONSTRAINT fk_cnum_main_to_meetingroom foreign KEY(cnum) references main (cnum);


commit;

select * from meal;
select * from meetingroom;