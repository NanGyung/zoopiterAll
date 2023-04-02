--테이블 삭제
drop table hmember;
drop table member;
drop table code;

--시퀀스삭제
drop sequence member_member_id_seq;
drop sequence notice_notice_id_seq;
drop sequence bbs_bbs_id_seq;
drop sequence uploadfile_uploadfile_id_seq;
drop sequence product_product_id_seq;


-------
--코드
-------
create table code(
    code_id     varchar2(10),       --코드
    decode      varchar2(30),       --코드명
    discript    clob,               --코드설명
    pcode_id    varchar2(10),       --상위코드
    useyn       char(1) default 'Y',            --사용여부 (사용:'Y',미사용:'N')
    cdate       timestamp default systimestamp,         --생성일시
    udate       timestamp default systimestamp          --수정일시
);
--기본키
alter table code add Constraint code_code_id_pk primary key (code_id);

--외래키
alter table code add constraint bbs_pcode_id_fk
    foreign key(pcode_id) references code(code_id);

--제약조건
alter table code modify decode constraint code_decode_nn not null;
alter table code modify useyn constraint code_useyn_nn not null;
alter table code add constraint code_useyn_ck check(useyn in ('Y','N'));

--샘플데이터 of code
insert into code (code_id,decode,pcode_id,useyn) values ('M01','회원구분',null,'Y');
insert into code (code_id,decode,pcode_id,useyn) values ('M0101','일반','M01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('H0101','병원','M01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('M01A1','관리자','M01','Y');
commit;

-------
--회원
-------
create table member (
    USER_ID                varchar2(20),   --로긴 아이디
    USER_PW                varchar2(20),   --로긴 비밀번호
    USER_NICK              varchar2(30),   --별칭
    USER_EMAIL             varchar2(40),  --이메일
    USER_PHOTO             BLOB,           --사진
    GUBUN                  varchar2(10) default 'M0101',    --회원구분(병원,일반) 일반회원 관리코드 M0101, 병원회원 관리코드 H0101
    USER_CREATE_DATE       timestamp default systimestamp,         --생성일시
    USER_UPDATE            timestamp default systimestamp          --수정일시
);
--기본키생성
alter table member add Constraint member_user_id_pk primary key (user_id);
--외래키
alter table member add constraint member_gubun_fk
    foreign key(gubun) references code(code_id);
    
--제약조건
alter table member add constraint member_user_email_uk unique (user_email);
alter table member modify user_pw constraint member_user_pw_nn not null;
alter table member modify user_nick constraint member_user_nick_nn not null; 
alter table member modify user_email constraint member_user_email_nn not null; 
-- not null 제약조건은 add 대신 modify 명령문 사용

--시퀀스 생성
--create sequence member_user_id_seq;
desc member;


--샘플 데이터
insert into member (USER_ID , USER_PW, USER_NICK, USER_EMAIL, GUBUN)
    values('test1', '12341234', '뜨아', 'test1@kh.com', 'M0101');

select * from member;
commit;


-------
--병원회원
-------
create table hmember (
    H_ID                   varchar2(20),   --로긴 아이디
    H_PW                   varchar2(20),   --로긴 비밀번호
    H_NAME                 varchar2(30),   --병원 상호명
    H_EMAIL                varchar2(40),   --이메일
    H_TEL                  varchar2(30),   --병원 연락처
    H_TIME                 varchar2(40),   --진료시간
    H_INFO                 varchar2(60),   --편의시설정보
    H_ADDINFO              varchar2(60),   --병원기타정보
    H_PLIST                varchar2(40),   --진료동물
    GUBUN                  varchar2(10) default 'H0101',    --회원구분(병원,일반) 일반회원 관리코드 M0101, 병원회원 관리코드 H0101
    H_CREATE_DATE       timestamp default systimestamp,         --생성일시
    H_UPDATE            timestamp default systimestamp          --수정일시
);
--기본키생성
alter table hmember add Constraint hmember_h_id_pk primary key (h_id);
--외래키
alter table hmember add constraint hmember_gubun_fk
    foreign key(gubun) references code(code_id);
    
--제약조건
alter table hmember add Constraint hmember_h_email unique (h_email);
alter table hmember modify h_pw constraint hmember_h_pw_nn not null;
alter table hmember modify h_email constraint hmember_h_email_nn not null; 
alter table hmember modify h_name constraint hmember_h_name_nn not null; 

desc hmember;





