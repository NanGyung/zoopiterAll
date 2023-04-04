--테이블 삭제
drop table C_BBSC CASCADE CONSTRAINTS;
drop table BBSC CASCADE CONSTRAINTS;
drop table C_BBSH CASCADE CONSTRAINTS;
drop table BBSH CASCADE CONSTRAINTS;
drop table PET_NOTE CASCADE CONSTRAINTS;
drop table PET_INFO CASCADE CONSTRAINTS;
drop table HOSPITAL_INFO CASCADE CONSTRAINTS;
drop table HOSPITAL_DATA CASCADE CONSTRAINTS;
drop table HMEMBER CASCADE CONSTRAINTS;
drop table MEMBER CASCADE CONSTRAINTS;
drop table CODE CASCADE CONSTRAINTS;

--시퀀스삭제
drop sequence C_BBSC_CC_ID_SEQ;
drop sequence BBSC_BBSC_ID_seq;
drop sequence C_BBSH_HC_ID_SEQ;
drop sequence BBSH_BBSH_ID_seq;
drop sequence  PET_NOTE_NOTE_NUM_seq;
drop sequence PET_INFO_PET_NUM_seq;
drop sequence HOSPITAL_INFO_H_NUM_seq;




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
insert into code (code_id,decode,pcode_id,useyn) values ('P01','기초접종',null,'Y');
insert into code (code_id,decode,pcode_id,useyn) values ('P0101','미접종','P01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('P0102','접종 전','P01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('P0103','접종 중','P01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('P0104','접종 완료','P01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('B01','게시판',null,'Y');
insert into code (code_id,decode,pcode_id,useyn) values ('B0101','병원후기','B01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('B0102','커뮤니티','B01','Y');
commit;

------------
--업로드 파일
------------
CREATE TABLE UPLOADFILE(
  UPLOADFILE_ID             NUMBER,          --파일 아이디(내부관리용)
  CODE                      varchar2(11),    --분류 코드(커뮤니티: F0101, 병원후기: F0102, 회원프로필: F0103)
  RID                       varchar2(10),    --참조번호 --해당 첨부파일이 첨부된 게시글의 순번
  STORE_FILENAME            varchar2(50),    --보관파일명
  UPLOAD_FILENAME           varchar2(50),    --업로드파일명
  FSIZE                     varchar2(45),    --파일크기 
  FTYPE                     varchar2(50),    --파일유형
  CDATE                     timestamp default systimestamp, --작성일
  UDATE                     timestamp default systimestamp  --수정일
);
--기본키생성
alter table UPLOADFILE add Constraint UPLOADFILE_UPLOADFILE_ID_pk primary key (UPLOADFILE_ID);
--외래키
alter table UPLOADFILE add constraint  UPLOADFILE_CODE_fk
    foreign key(CODE) references CODE(CODE_ID);

--제약조건
alter table UPLOADFILE modify CODE constraint UPLOADFILE_CODE_nn not null;
alter table UPLOADFILE modify RID constraint UPLOADFILE_RID_nn not null;
alter table UPLOADFILE modify STORE_FILENAME constraint UPLOADFILE_STORE_FILENAME_nn not null;
alter table UPLOADFILE modify UPLOAD_FILENAME constraint UPLOADFILE_UPLOAD_FILENAME_nn not null;
-- not null 제약조건은 add 대신 modify 명령문 사용

--시퀀스 생성
create sequence UPLOADFILE_UPLOADFILE_ID_SEQ;

--샘플데이터 of UPLOADFILE
insert into UPLOADFILE (UPLOADFILE_ID, CODE , STORE_FILENAME, UPLOAD_FILENAME, FSIZE) 
 values(UPLOADFILE_UPLOADFILE_ID_SEQ.NEXTVAL, 'F0101', 'F0101.png', '커뮤니티이미지첨부1.png','100','image/png');

COMMIT;

--테이블 구조 확인
DESC UPLOADFILE;

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

desc member;

--샘플데이터 of MEMBER
insert into member (USER_ID , USER_PW, USER_NICK, USER_EMAIL, GUBUN)
    values('test1', 'test1234', '별칭1', 'test1@gamil.com', 'M0101');

commit;

-------
--병원회원
-------
create table hmember (
    H_ID                   varchar2(20),   --로긴 아이디
    H_PW                   varchar2(20),   --로긴 비밀번호
    H_NAME                 varchar2(52),   --병원 상호명
    H_EMAIL                varchar2(40),   --이메일
    H_TEL                  varchar2(30),   --병원 연락처
    H_TIME                 clob,           --진료시간
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

--샘플 데이터 OF HMEMBER
insert into HMEMBER (H_ID , H_PW, H_NAME, H_EMAIL, H_TEL, H_TIME, H_INFO, H_ADDINFO, H_PLIST, GUBUN)
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
    'H0101');

--테이블 구조 확인
desc hmember;
commit;

-------------------
-- 동물병원 공공데이터 
-------------------
CREATE TABLE hospital_data(
   hd_id              NUMBER(4)                         --동물병원 데이터번호
  ,hd_code            NUMBER(7)                         --개방자치단체코드
  ,hd_manage          VARCHAR2(13)                      --관리번호
  ,hd_perdate         DATE                              --인허가일자
  ,hd_statuscode      NUMBER(1)                         --영업상태구분코드
  ,hd_satusname       VARCHAR2(23)                      --영업상태명
  ,hd_detailcode      NUMBER(4)                         --상세영업상태코드
  ,hd_detailname      VARCHAR2(13)                       --상세영업상태명
  ,hd_tel             VARCHAR2(30)                      --소재지전화
  ,hd_address_general VARCHAR2(200)                      --지번주소
  ,hd_address_road    VARCHAR2(200)                     --도로명주소
  ,hd_address_roadnum NUMBER(7)                         --도로명우편번호
  ,hd_name            VARCHAR2(52)                      --사업장명
  ,hd_adit_date       VARCHAR2(22)                      --최종수정시점
  ,hd_adit_gubun      CHAR(1) DEFAULT 'I'               --데이터갱신구분(갱신됨: U, 갱신안됨: I)
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
alter table hospital_data modify hd_detailname constraint hospital_data_hd_detailname_nn not null;
alter table hospital_data modify hd_name constraint hospital_data_hd_name_nn not null;
alter table hospital_data modify hd_adit_date constraint hospital_data_hd_adit_date_nn not null;
alter table hospital_data modify hd_adit_gubun constraint hospital_data_hd_adit_gubun_nn not null;
alter table hospital_data modify hd_adit_resdate constraint hospital_data_hd_adit_resdate_nn not null;
alter table hospital_data modify hd_lng constraint hospital_data_hd_lng_nn not null;
alter table hospital_data modify hd_lat constraint hospital_data_hd_lat_nn not null;

alter table hospital_data add constraint hospital_data_hd_adit_gubun_ck check(hd_adit_gubun in ('U','I'));

--샘플데이터 of HOSPITAL_DATA : 동물병원데이터(울산, 부산).sql 파일을 열어서 insert 해야함

--테이블 구조 확인
desc HOSPITAL_DATA;
commit;

------------
--병원정보
------------
CREATE TABLE hospital_info(
  H_NUM              NUMBER,         --순번
  HD_ID              NUMBER(4),      --동물병원 데이터번호
  H_ID               varchar2(20),   --병원회원 아이디
  H_NAME             varchar2(52),   --병원 상호명
  H_TEL              VARCHAR2(30),   --병원 연락처
  H_PLIST            varchar2(40),   --진료동물
  H_TIME             clob,           --진료시간
  H_INFO             varchar2(60),   --편의시설정보
  H_ADDINFO          varchar2(60),   --병원기타정보
  H_IMG              BLOB,           --병원이미지
  H_CREATE_DATE       timestamp default systimestamp,         --생성일시
  H_UPDATE            timestamp default systimestamp          --수정일시
);
--기본키생성
alter table HOSPITAL_INFO add Constraint HOSPITAL_INFO_H_NUM_pk primary key (H_NUM);
--외래키
alter table HOSPITAL_INFO add constraint  HOSPITAL_INFO_H_ID_fk
    foreign key(H_ID) references hmember(H_ID);
alter table HOSPITAL_INFO add constraint  HOSPITAL_INFO_HD_ID_fk
    foreign key(HD_ID) references hospital_data(HD_ID);

--제약조건
alter table HOSPITAL_INFO modify H_ID constraint HOSPITAL_INFO_H_ID_nn not null;
alter table HOSPITAL_INFO modify H_NAME constraint HOSPITAL_INFO_H_NAME_nn not null;
alter table HOSPITAL_INFO modify H_CREATE_DATE constraint HOSPITAL_INFO_H_CREATE_DATE_nn not null;
-- not null 제약조건은 add 대신 modify 명령문 사용

--시퀀스 생성
create sequence HOSPITAL_INFO_H_NUM_seq;

--------  아래 샘플데이터 생성 전에 hospital_data 샘플데이터 먼저 생성해야함!!!!  ----------
--샘플데이터 of hospital_info
insert into hospital_info (H_NUM , HD_ID, H_ID, H_NAME, H_TEL, H_PLIST, H_TIME, H_INFO, H_ADDINFO)
    values(
    hospital_info_h_num_seq.nextval, 
    5400, 
    'htest1', 
    '메이 동물병원', 
    '211-3375', 
    '강아지, 고양이', 
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
    '강아지, 고양이 전문 병원입니다!'
    );


COMMIT;
--테이블 구조 확인
DESC HOSPITAL_INFO;

------------
--반려동물 정보
------------
CREATE TABLE PET_INFO(
  PET_NUM            NUMBER,         --순번
  USER_ID            varchar2(20),   --일반회원 아이디
  PET_IMG            BLOB,           --반려동물 사진
  PET_NAME           varchar2(40),   --반려동물 이름
  PET_TYPE           VARCHAR2(20),   --반려동물 품종
  PET_GENDER         CHAR(1) default 'M',   --반려동물 성별(남: M, 여: F)
  PET_BIRTH          DATE,           --반려동물 생일
  PET_YN             CHAR(1) default 'N',       --중성화 여부(완료: Y, 미완료: N)
  PET_DATE           DATE,           --입양일
  PET_VAC            VARCHAR2(15) default 'p0101',   
  --기초접종 여부(미접종(P0101), 접종 전(P0102), 접종 중(P0103), 접종 완료(P0104))
  PET_INFO           VARCHAR2(60)    --기타사항
);
--기본키생성
alter table PET_INFO add Constraint PET_INFO_PET_NUM_pk primary key (PET_NUM);
--외래키
alter table PET_INFO add constraint  PET_INFO_USER_ID_fk
    foreign key(USER_ID) references member(USER_ID);
alter table PET_INFO add constraint  PET_INFO_PET_VAC_fk
    foreign key(PET_VAC) references  code(code_id);

--제약조건
alter table PET_INFO modify USER_ID constraint PET_INFO_USER_ID_nn not null;
alter table PET_INFO modify PET_NAME constraint PET_INFO_PET_NAME_nn not null;
alter table PET_INFO modify PET_VAC constraint PET_INFO_PET_VAC_nn not null;
alter table PET_INFO modify PET_GENDER constraint PET_INFO_PET_GENDER_nn not null;

alter table PET_INFO add constraint PET_INFO_PET_YN_ck check(PET_YN in ('Y','N'));
alter table PET_INFO add constraint PET_INFO_PET_GENDER_ck check(PET_GENDER in ('M','F'));
-- not null 제약조건은 add 대신 modify 명령문 사용

--시퀀스 생성
create sequence PET_INFO_PET_NUM_seq;

--테이블 구조 확인
DESC PET_INFO;

--샘플데이터 of PET_INFO
insert into PET_INFO (PET_NUM , USER_ID, PET_NAME, PET_TYPE, PET_GENDER, PET_BIRTH, PET_YN, PET_DATE, PET_VAC)
    values(
    PET_INFO_PET_NUM_seq.nextval, 
    'test1', 
    '반려동물1', 
    '강아지', 
    'F', 
    '2022-01-01', 
    'Y', 
    '2022-03-01', 
    'P0104'
    );

COMMIT;


------------
--의료수첩
------------
CREATE TABLE PET_NOTE(
  NOTE_NUM            NUMBER,         --순번
  USER_ID            varchar2(20),   --일반회원 아이디
  PET_NAME           varchar2(40),   --반려동물 이름
  PET_IMG            BLOB,           --반려동물 사진
  PET_TYPE           VARCHAR2(20),   --반려동물 품종
  PET_GENDER         CHAR(1) default 'M',   --반려동물 성별(남: M, 여: F)
  PET_BIRTH          DATE,           --반려동물 생일
  PET_YN             CHAR(1),        --중성화 여부(완료: Y, 미완료: N)
  PET_INFO           varchar2(60),   --기타사항
  PET_WEIG           number,         --반려동물 몸무게
  PET_H_CHECK        DATE,           --병원 방문날짜
  PET_H_NAME         VARCHAR2(52),   --방문한 병원이름
  PET_H_TEACHER       VARCHAR2(10),   --담당수의사
  PET_REASON         VARCHAR2(60),  --병원내방이유
  PET_STMP           VARCHAR2(60),  --동물 증상
  PET_SIGNICE        VARCHAR2(60),  --유의사항
  PET_NEXTDATE       DATE,           --다음 예약일
  PET_VAC            VARCHAR2(15) default 'p0101',   
  --기초접종 여부(미접종(P0101), 접종 전(P0102), 접종 중(P0103), 접종 완료(P0104))
  PET_DATE           VARCHAR2(15),  --작성 날짜(캘린더 선택날짜)
  PET_EDITDATE       VARCHAR2(15)   --수정 날짜
);
--기본키생성
alter table PET_NOTE add Constraint PET_NOTE_NOTE_NUM_pk primary key (NOTE_NUM);
--외래키
alter table PET_NOTE add constraint  PET_NOTE_USER_ID_fk
    foreign key(USER_ID) references member(USER_ID);
alter table PET_NOTE add constraint  PET_NOTE_PET_VAC_fk
    foreign key(PET_VAC) references  code(code_id);

--제약조건
alter table PET_NOTE modify USER_ID constraint PET_NOTE_USER_ID_nn not null;
alter table PET_NOTE modify PET_H_CHECK constraint PET_NOTE_PET_H_CHECK_nn not null;
alter table PET_NOTE modify PET_NAME constraint PET_NOTE_PET_NAME_nn not null;
alter table PET_NOTE modify PET_DATE constraint PET_NOTE_PET_DATE_nn not null;
alter table PET_NOTE modify PET_EDITDATE constraint PET_NOTE_PET_EDITDATE_nn not null;
alter table PET_NOTE add constraint PET_NOTE_PET_YN_ck check(PET_YN in ('Y','N'));
alter table PET_NOTE add constraint PET_NOTE_PET_GENDER_ck check(PET_GENDER in ('M','F'));
-- not null 제약조건은 add 대신 modify 명령문 사용

--시퀀스 생성
create sequence PET_NOTE_NOTE_NUM_seq;

--샘플데이터 of PET_NOTE 
insert into PET_NOTE (
    NOTE_NUM , USER_ID, PET_NAME, PET_TYPE, PET_GENDER, PET_BIRTH, PET_YN, PET_WEIG, PET_H_CHECK, 
    PET_H_NAME, PET_H_TEACHER, PET_REASON, PET_STMP, PET_SIGNICE, PET_NEXTDATE, PET_VAC)
    values(
    PET_NOTE_NOTE_NUM_seq.nextval, 
    'test1', 
    '반려동물1', 
    '강아지', 
    'F', 
    '2022-01-01', 
    'Y', 
    4,
    '2023-03-02',
    '메이 동물병원',
    '홍길동',
    '정기검진',
    '안구건조증',
    '수분섭취를 신경써야함',
    '2023-04-01',
    'P0104'
    );

COMMIT;
--테이블 구조 확인
DESC PET_NOTE;

------------
--게시판: 병원후기
------------
CREATE TABLE BBSH(
  BBSH_ID            NUMBER,          --게시글 번호(순번)
  BH_TITLE           varchar2(150),   --글 제목
  BH_CONTENT         clob,            --글 내용
  PET_TYPE           varchar2(20),    --반려동물 품종
  BH_ATTACH          BLOB,            --첨부파일
  BH_HNAME           VARCHAR2(52),    --병원이름
  BH_HIT             NUMBER default 0,--조회수
  BH_GUBUN           VARCHAR2(15) default 'B0101',      --게시판 구분(병원후기: B0101, 커뮤니티: B0102)
  USER_NICK          varchar2(30),    --일반회원 닉네임
  BH_CDATE           timestamp default systimestamp,   --작성일
  BH_UDATE           timestamp default systimestamp    --수정일 
);
--기본키생성
alter table BBSH add Constraint BBSH_BBSH_ID_pk primary key (BBSH_ID);
--외래키
alter table BBSH add constraint  BBSH_BH_GUBUN_fk
    foreign key(BH_GUBUN) references  code(code_id);

--제약조건
alter table BBSH modify BH_TITLE constraint BBSH_BH_TITLE_nn not null;
alter table BBSH modify BH_CONTENT constraint BBSH_BH_CONTENT_nn not null;
alter table BBSH modify USER_NICK constraint BBSH_USER_NICK_nn not null;
alter table BBSH modify BH_HIT constraint BBSH_BH_HIT_nn not null;
-- not null 제약조건은 add 대신 modify 명령문 사용


--시퀀스 생성
create sequence BBSH_BBSH_ID_seq;

--샘플데이터 of BBSH
insert into BBSH (BBSH_ID , BH_TITLE, BH_CONTENT, PET_TYPE, BH_HNAME, BH_GUBUN, USER_NICK)
    values(BBSH_BBSH_ID_seq.nextval, '병원후기제목1', '병원후기본문1', '고양이', '메이 동물병원', 'B0101','별칭1');

COMMIT;

--테이블 구조 확인
DESC BBSH;

------------
--댓글: 병원후기
------------
CREATE TABLE C_BBSH(
  HC_ID              NUMBER,          --댓글 번호(순번)
  BBSH_ID            NUMBER,          --게시글 번호
  HC_CONTENT         varchar2(1500),  --댓글 내용
  USER_NICK          varchar2(30),    --일반회원 닉네임
  BH_CDATE           timestamp default systimestamp,   --작성일
  BH_UDATE           timestamp default systimestamp    --수정일 
);
--기본키생성
alter table C_BBSH add Constraint C_BBSH_HC_ID_pk primary key (HC_ID);
--외래키
alter table C_BBSH add constraint  C_BBSH_BBSH_ID_fk
    foreign key(BBSH_ID) references BBSH(BBSH_ID);

--제약조건
alter table C_BBSH modify BBSH_ID constraint C_BBSH_BBSH_ID_nn not null;
alter table C_BBSH modify HC_CONTENT constraint C_BBSH_HC_CONTENT_nn not null;
alter table C_BBSH modify USER_NICK constraint C_BBSH_USER_NICK_nn not null;
-- not null 제약조건은 add 대신 modify 명령문 사용

--시퀀스 생성
create sequence C_BBSH_HC_ID_SEQ;

--샘플데이터 of C_BBSH
insert into C_BBSH (HC_ID, BBSH_ID , HC_CONTENT, USER_NICK) values(C_BBSH_HC_ID_SEQ.nextval, 1,'병원후기댓글1', '별칭1');

COMMIT;

--테이블 구조 확인
DESC C_BBSH;

------------
--게시판: 커뮤니티
------------
CREATE TABLE BBSC(
  BBSC_ID            NUMBER,              --게시글 번호(순번)
  BC_TITLE           varchar2(150),       --글 제목
  BC_CONTENT         clob,                --글 내용
  PET_TYPE           varchar2(20),        --반려동물 품종
  BC_ATTACH          BLOB,                --첨부파일
  BC_HIT             NUMBER  default 0,   --조회수
  BC_LIKE            NUMBER  default 0,   --좋아요수
  BC_PUBLIC          CHAR(1) default 'N', --게시글 공개여부(공개: Y, 비공개: N)
  BC_GUBUN           VARCHAR2(15) default 'B0102',      --게시판 구분(병원후기: B0101, 커뮤니티: B0102)
  USER_NICK          varchar2(30),        --일반회원 닉네임
  BC_CDATE           timestamp default systimestamp,   --작성일
  BC_UDATE           timestamp default systimestamp    --수정일 
);
--기본키생성
alter table BBSC add Constraint BBSC_BBSC_ID_pk primary key (BBSC_ID);
--외래키
alter table BBSC add constraint  BBSC_BC_GUBUN_fk
    foreign key(BC_GUBUN) references code(code_id);
    
--제약조건
alter table BBSC modify BC_TITLE constraint BBSC_BC_TITLE_nn not null;
alter table BBSC modify BC_CONTENT constraint BBSC_BC_CONTENT_nn not null;
alter table BBSC modify BC_HIT constraint BBSC_BC_HIT_nn not null;
alter table BBSC modify BC_LIKE constraint BBSC_BC_LIKE_nn not null;
alter table BBSC modify BC_PUBLIC constraint BBSC_BC_PUBLIC_nn not null;
alter table BBSC modify USER_NICK constraint BBSC_USER_NICK_nn not null;
-- not null 제약조건은 add 대신 modify 명령문 사용

--시퀀스 생성
create sequence BBSC_BBSC_ID_seq;

--샘플데이터 of BBSC
insert into BBSC (BBSC_ID , BC_TITLE, BC_CONTENT, PET_TYPE, BC_PUBLIC, BC_GUBUN, USER_NICK)
    values(BBSC_BBSC_ID_seq.nextval, '커뮤니티제목1', '커뮤니티본문1', '고양이', 'N', 'B0102', '별칭1');

COMMIT;

--테이블 구조 확인
DESC BBSC;

------------
--댓글: 커뮤니티
------------
CREATE TABLE C_BBSC(
  CC_ID              NUMBER,          --댓글 번호(순번)
  BBSC_ID            NUMBER,          --게시글 번호
  CC_CONTENT         varchar2(1500),  --댓글 내용
  USER_NICK          varchar2(30),    --일반회원 닉네임
  CC_CDATE           timestamp default systimestamp,   --작성일
  CC_UDATE           timestamp default systimestamp    --수정일 
);
--기본키생성
alter table C_BBSC add Constraint C_BBSC_CC_ID_pk primary key (CC_ID);
--외래키
alter table C_BBSC add constraint  C_BBSC_BBSC_ID_fk
    foreign key(BBSC_ID) references BBSC(BBSC_ID);

--제약조건
alter table C_BBSC modify BBSC_ID constraint C_BBSC_BBSC_ID_nn not null;
alter table C_BBSC modify CC_CONTENT constraint C_BBSC_CC_CONTENT_nn not null;
alter table C_BBSC modify USER_NICK constraint C_BBSC_USER_NICK_nn not null;
-- not null 제약조건은 add 대신 modify 명령문 사용

--시퀀스 생성
create sequence C_BBSC_CC_ID_SEQ;

--샘플데이터 of C_BBSC
insert into C_BBSC (CC_ID, BBSC_ID , CC_CONTENT, USER_NICK) values(C_BBSC_CC_ID_SEQ.nextval, 1, '커뮤니티댓글1', '별칭1');

COMMIT;

--테이블 구조 확인
DESC C_BBSC;






