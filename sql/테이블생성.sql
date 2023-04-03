--테이블 삭제
DROP TABLE hospital_data CASCADE CONSTRAINTS;
drop table hmember CASCADE CONSTRAINTS;
drop table member CASCADE CONSTRAINTS;
drop table code CASCADE CONSTRAINTS;

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
    GUBUN                  varchar2(10) default 'M0101',    --회원구분(병원,일반) 일반회원 관리코드 M0101, 병원회원 관리코드 H0101
    USER_PHOTO             BLOB,           --사진
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
--create member_member_id_seq;
desc member;


--샘플 데이터
insert into member (USER_ID , USER_PW, USER_NICK, USER_EMAIL, GUBUN)
    values('test1', 'test1234', '별칭1', 'test1@gamil.com', 'M0101');

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
    H_TIME                 varchar2(5000), --진료시간
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

--샘플 데이터
insert into member (H_ID , H_PW, H_EMAIL, H_TEL, H_TIME, H_INFO, H_ADDINFO, H_PLIST, GUBUN)
    values(
    'htest1', 
    'htest1234', 
    '메이 동물병원', 
    'htest1@gamil.com', 
    '211-3375', 
    '월요일	오전 9:30~오후 7:00
    화요일	오전 9:30~오후 7:00
    수요일
    (식목일)
    오전 9:30~오후 7:00
    시간이 달라질 수 있음
    목요일	오전 9:30~오후 7:00
    금요일	오전 9:30~오후 7:00
    토요일	오전 9:30~오후 4:00
    일요일	휴무일', 
    '주차, 무선 인터넷, 반려동물 동반', 
    '강아지, 고양이 전문 병원입니다!', 
    '강아지, 고양이', 
    'M0101');

desc hmember;
commit;

-------------------
-- 동물병원 공공데이터 
-------------------
CREATE TABLE hospital_data(
   hd_id              NUMBER(4)                         --번호
  ,hd_code            NUMBER(7)                         --개방자치단체코드
  ,hd_manage          VARCHAR2(13)                      --관리번호
  ,hd_perdate         DATE                              --인허가일자
  ,hd_statuscode      NUMBER(1)                         --영업상태구분코드
  ,hd_satusname       VARCHAR2(23)                      --영업상태명
  ,hd_detailcode      NUMBER(4)                         --상세영업상태코드
  ,hd_detailname      VARCHAR2(13)                       --상세영업상태명
  ,hd_tel             VARCHAR2(17)                      --소재지전화
  ,hd_address_general VARCHAR2(200)                      --지번주소
  ,hd_address_road    VARCHAR2(200)                     --도로명주소
  ,hd_address_roadnum NUMBER(7)                         --도로명우편번호
  ,hd_name            VARCHAR2(52)                      --사업장명
  ,hd_adit_date       VARCHAR2(22)                      --최종수정시점
  ,hd_adit_gubun      VARCHAR2(1)                       --데이터갱신구분(U,I)
  ,hd_adit_resdate    VARCHAR2(22)                      --데이터갱신일자
  ,hd_lng             NUMBER                            --좌표(x)
  ,hd_lat             NUMBER                            --좌표(y)
);
--기본키생성
alter table hospital_data add Constraint hospital_data_hd_id_pk primary key (hd_id);
--제약조건
alter table hospital_data modify hd_code constraint hospital_data_hd_code_nn not null;
alter table hospital_data modify hd_manage constraint hospital_data_hd_manage_nn not null;
alter table hospital_data modify hd_perdate constraint hospital_data_hd_perdate_nn not null;
alter table hospital_data modify hd_statuscode constraint hospital_data_hd_statuscode_nn not null;
alter table hospital_data modify hd_satusname constraint hospital_data_hd_satusname_nn not null;
alter table hospital_data modify hd_detailcode constraint hospital_data_hd_detailcode_nn not null;
alter table hospital_data modify hd_name constraint hospital_data_hd_name_nn not null;
alter table hospital_data modify hd_adit_gubun constraint hospital_data_hd_adit_gubun_nn not null;
--alter table hospital_data modify hd_adit_resdate constraint hospital_data_hd_adit_resdate_nn not null;
--alter table hospital_data modify hd_adit_date constraint hospital_data_hd_adit_date_nn not null;
commit;

select * from hospital_data;

------------
--병원정보
------------
CREATE TABLE hospital_info(
   hd_id              NUMBER(4)                         --번호
  ,hd_code            NUMBER(7)                         --개방자치단체코드
  ,hd_manage          VARCHAR2(13)                      --관리번호
  ,hd_perdate         DATE                              --인허가일자
  ,hd_statuscode      NUMBER(1)                         --영업상태구분코드
  ,hd_satusname       VARCHAR2(23)                      --영업상태명
  ,hd_detailcode      NUMBER(4)                         --상세영업상태코드
  ,hd_detailname      VARCHAR2(13)                       --상세영업상태명
  ,hd_tel             VARCHAR2(17)                      --소재지전화
  ,hd_address_general VARCHAR2(200)                      --지번주소
  ,hd_address_road    VARCHAR2(200)                     --도로명주소
  ,hd_address_roadnum NUMBER(7)                         --도로명우편번호
  ,hd_name            VARCHAR2(52)                      --사업장명
  ,hd_adit_date       VARCHAR2(22)                      --최종수정시점
  ,hd_adit_gubun      VARCHAR2(1)                       --데이터갱신구분(U,I)
  ,hd_adit_resdate    VARCHAR2(22)                      --데이터갱신일자
  ,hd_lng             NUMBER                            --좌표(x)
  ,hd_lat             NUMBER                            --좌표(y)
);
