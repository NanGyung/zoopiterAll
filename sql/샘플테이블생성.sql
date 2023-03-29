--���̺� ����
drop table uploadfile;
drop table bbs;
drop table member;
drop table notice;
drop table code;
drop table product;

--����������
drop sequence member_member_id_seq;
drop sequence notice_notice_id_seq;
drop sequence bbs_bbs_id_seq;
drop sequence uploadfile_uploadfile_id_seq;
drop sequence product_product_id_seq;


-------
--�ڵ�
-------
create table code(
    code_id     varchar2(11),       --�ڵ�
    decode      varchar2(30),       --�ڵ��
    discript    clob,               --�ڵ弳��
    pcode_id    varchar2(11),       --�����ڵ�
    useyn       char(1) default 'Y',            --��뿩�� (���:'Y',�̻��:'N')
    cdate       timestamp default systimestamp,         --�����Ͻ�
    udate       timestamp default systimestamp          --�����Ͻ�
);
--�⺻Ű
alter table code add Constraint code_code_id_pk primary key (code_id);

--�ܷ�Ű
alter table code add constraint bbs_pcode_id_fk
    foreign key(pcode_id) references code(code_id);

--��������
alter table code modify decode constraint code_decode_nn not null;
alter table code modify useyn constraint code_useyn_nn not null;
alter table code add constraint code_useyn_ck check(useyn in ('Y','N'));

--���õ����� of code
insert into code (code_id,decode,pcode_id,useyn) values ('B01','�Խ���',null,'Y');
insert into code (code_id,decode,pcode_id,useyn) values ('B0101','Spring','B01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('B0102','Datbase','B01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('B0103','Q_A','B01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('M01','ȸ������',null,'Y');
insert into code (code_id,decode,pcode_id,useyn) values ('M0101','�Ϲ�','M01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('M0102','���','M01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('M01A1','������1','M01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('M01A2','������2','M01','Y');
commit;

-------
--ȸ��
-------
create table member (
    ADMIN_ID               number,         --������ ���̵�
    U_PET_ID               number,         --���ΰ����� ���̵�
    GUBUN                  varchar2(9) default 'M0101',    --ȸ������(����,�Ϲ�) �Ϲ�ȸ�� �����ڵ� M0101, ����ȸ�� �����ڵ� H0101
    USER_ID                varchar2(15),   --�α� ���̵�
    USER_PW                varchar2(12),   --�α� ��й�ȣ
    USER_NICK              varchar2(30),   --��Ī
    USER_EMAIL             varchar2(300),  --�̸���
    USER_PHOTO             BLOB,       --����
    USER_CREATE_DATE       timestamp default systimestamp,         --�����Ͻ�
    USER_UPDATE            timestamp default systimestamp          --�����Ͻ�
);
--�⺻Ű����
alter table member add Constraint member_user_id_pk primary key (user_id);
--��������
alter table member add constraint member_gubun_fk
    foreign key(gubun) references code(code_id);
--alter table member modify email constraint member_passwd_uk unique;
--alter table member modify email constraint member_passwd_nn not null;
--alter table member add constraint member_gender_ck check (gender in ('����','����'));

--������ ����
create sequence member_user_id_seq;
desc member;

--���� ������(������)
insert into member (member_id,email,passwd,nickname,gender,hobby,region,gubun)
    values(member_member_id_seq.nextval, 'test1@kh.com', '1234', '�׽���1','����','����,����','���', 'M0101');
insert into member (member_id,email,passwd,nickname,gender,hobby,region,gubun)
    values(member_member_id_seq.nextval, 'test2@kh.com', '1234', '�׽���2','����','����,����','�λ�', 'M0102');
insert into member (member_id,email,passwd,nickname,gender,hobby,region,gubun)
    values(member_member_id_seq.nextval, 'admin1@kh.com', '1234','������1', '����','���,����','����','M01A1');
insert into member (member_id,email,passwd,nickname,gender,hobby,region,gubun)
    values(member_member_id_seq.nextval, 'admin2@kh.com', '1234','������2', '����','����,����','�뱸','M01A2');
select * from member;
commit;

---------
--��������
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
--�⺻Ű����
alter table notice add Constraint notice_notice_id_pk primary key (notice_id);

--�������� not null
alter table notice modify subject constraint notice_subject_nn not null;
alter table notice modify content constraint notice_content_nn not null;
alter table notice modify author constraint notice_author_nn not null;

--������
create sequence notice_notice_id_seq
start with 1
increment by 1
minvalue 0
maxvalue 99999999
nocycle;

-------
--�Խ���
-------
create table bbs(
    bbs_id      number(10),         --�Խñ� ��ȣ
    bcategory   varchar2(11),       --�з�ī�װ�
    title       varchar2(150),      --����
    email       varchar2(50),       --email
    nickname    varchar2(30),       --��Ī
    hit         number(5) default 0,          --��ȸ��
    bcontent    clob,               --����
    pbbs_id     number(10),         --�θ� �Խñ۹�ȣ
    bgroup      number(10),         --��۱׷�
    step        number(3) default 0,          --��۴ܰ�
    bindent     number(3) default 0,          --��۵鿩����
    status      char(1),               --��ۻ���  (����: 'D', �ӽ�����: 'I')
    cdate       timestamp default systimestamp,         --�����Ͻ�
    udate       timestamp default systimestamp          --�����Ͻ�
);

--�⺻Ű
alter table bbs add Constraint bbs_bbs_id_pk primary key (bbs_id);

--�ܷ�Ű
alter table bbs add constraint bbs_bcategory_fk
    foreign key(bcategory) references code(code_id);
alter table bbs add constraint bbs_pbbs_id_fk
    foreign key(pbbs_id) references bbs(bbs_id);
alter table bbs add constraint bbs_email_fk
    foreign key(email) references member(email);

--��������
alter table bbs modify bcategory constraint bbs_bcategory_nn not null;
alter table bbs modify title constraint bbs_title_nn not null;
alter table bbs modify email constraint bbs_email_nn not null;
alter table bbs modify nickname constraint bbs_nickname_nn not null;
alter table bbs modify bcontent constraint bbs_bcontent_nn not null;

--������
create sequence bbs_bbs_id_seq;

---------
--÷������
---------
create table uploadfile(
    uploadfile_id   number(10),     --���Ͼ��̵�
    code            varchar2(11),   --�з��ڵ�
    rid             varchar2(10),     --������ȣ(�Խñ۹�ȣ��)
    store_filename  varchar2(100),   --�����������ϸ�
    upload_filename varchar2(100),   --���ε����ϸ�(������ ���ε������ϸ�)
    fsize           varchar2(45),   --���ε�����ũ��(����byte)
    ftype           varchar2(100),   --��������(mimetype)
    cdate           timestamp default systimestamp, --����Ͻ�
    udate           timestamp default systimestamp  --�����Ͻ�
);
--�⺻Ű
alter table uploadfile add constraint uploadfile_uploadfile_id_pk primary key(uploadfile_id);

--�ܷ�Ű
alter table uploadfile add constraint uploadfile_uploadfile_id_fk
    foreign key(code) references code(code_id);

--��������
alter table uploadfile modify code constraint uploadfile_code_nn not null;
alter table uploadfile modify rid constraint uploadfile_rid_nn not null;
alter table uploadfile modify store_filename constraint uploadfile_store_filename_nn not null;
alter table uploadfile modify upload_filename constraint uploadfile_upload_filename_nn not null;
alter table uploadfile modify fsize constraint uploadfile_fsize_nn not null;
alter table uploadfile modify ftype constraint uploadfile_ftype_nn not null;

--������
create sequence uploadfile_uploadfile_id_seq;

