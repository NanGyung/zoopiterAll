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


--샘플 데이터(수정전)
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

-- 이하 샘플데이터 그대로

---------
--공지사항
---------
create table notice(
    notice_id    number(8),
    subject     varchar2(100),
    content     clob,
    author      varchar2(12),
    hit         number(5) default 0,
    cdate       timestamp default systimestamp,
    udate       timestamp default systimestamp
);
--기본키생성
alter table notice add Constraint notice_notice_id_pk primary key (notice_id);

--제약조건 not null
alter table notice modify subject constraint notice_subject_nn not null;
alter table notice modify content constraint notice_content_nn not null;
alter table notice modify author constraint notice_author_nn not null;

--시퀀스
create sequence notice_notice_id_seq
start with 1
increment by 1
minvalue 0
maxvalue 99999999
nocycle;

-------
--게시판
-------
create table bbs(
    bbs_id      number(10),         --게시글 번호
    bcategory   varchar2(11),       --분류카테고리
    title       varchar2(150),      --제목
    email       varchar2(50),       --email
    nickname    varchar2(30),       --별칭
    hit         number(5) default 0,          --조회수
    bcontent    clob,               --본문
    pbbs_id     number(10),         --부모 게시글번호
    bgroup      number(10),         --답글그룹
    step        number(3) default 0,          --답글단계
    bindent     number(3) default 0,          --답글들여쓰기
    status      char(1),               --답글상태  (삭제: 'D', 임시저장: 'I')
    cdate       timestamp default systimestamp,         --생성일시
    udate       timestamp default systimestamp          --수정일시
);

--기본키
alter table bbs add Constraint bbs_bbs_id_pk primary key (bbs_id);

--외래키
alter table bbs add constraint bbs_bcategory_fk
    foreign key(bcategory) references code(code_id);
alter table bbs add constraint bbs_pbbs_id_fk
    foreign key(pbbs_id) references bbs(bbs_id);
alter table bbs add constraint bbs_email_fk
    foreign key(email) references member(email);

--제약조건
alter table bbs modify bcategory constraint bbs_bcategory_nn not null;
alter table bbs modify title constraint bbs_title_nn not null;
alter table bbs modify email constraint bbs_email_nn not null;
alter table bbs modify nickname constraint bbs_nickname_nn not null;
alter table bbs modify bcontent constraint bbs_bcontent_nn not null;

--시퀀스
create sequence bbs_bbs_id_seq;

---------
--첨부파일
---------
create table uploadfile(
    uploadfile_id   number(10),     --파일아이디
    code            varchar2(11),   --분류코드
    rid             varchar2(10),     --참조번호(게시글번호등)
    store_filename  varchar2(100),   --서버보관파일명
    upload_filename varchar2(100),   --업로드파일명(유저가 업로드한파일명)
    fsize           varchar2(45),   --업로드파일크기(단위byte)
    ftype           varchar2(100),   --파일유형(mimetype)
    cdate           timestamp default systimestamp, --등록일시
    udate           timestamp default systimestamp  --수정일시
);
--기본키
alter table uploadfile add constraint uploadfile_uploadfile_id_pk primary key(uploadfile_id);

--외래키
alter table uploadfile add constraint uploadfile_uploadfile_id_fk
    foreign key(code) references code(code_id);

--제약조건
alter table uploadfile modify code constraint uploadfile_code_nn not null;
alter table uploadfile modify rid constraint uploadfile_rid_nn not null;
alter table uploadfile modify store_filename constraint uploadfile_store_filename_nn not null;
alter table uploadfile modify upload_filename constraint uploadfile_upload_filename_nn not null;
alter table uploadfile modify fsize constraint uploadfile_fsize_nn not null;
alter table uploadfile modify ftype constraint uploadfile_ftype_nn not null;

--시퀀스
create sequence uploadfile_uploadfile_id_seq;

