--���̺� ����
drop table hmember;
drop table member;
drop table code;

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
    code_id     varchar2(10),       --�ڵ�
    decode      varchar2(30),       --�ڵ��
    discript    clob,               --�ڵ弳��
    pcode_id    varchar2(10),       --�����ڵ�
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
insert into code (code_id,decode,pcode_id,useyn) values ('M01','ȸ������',null,'Y');
insert into code (code_id,decode,pcode_id,useyn) values ('M0101','�Ϲ�','M01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('H0101','����','M01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('M01A1','������','M01','Y');
commit;

-------
--ȸ��
-------
create table member (
    USER_ID                varchar2(20),   --�α� ���̵�
    USER_PW                varchar2(20),   --�α� ��й�ȣ
    USER_NICK              varchar2(30),   --��Ī
    USER_EMAIL             varchar2(40),  --�̸���
    USER_PHOTO             BLOB,           --����
    GUBUN                  varchar2(10) default 'M0101',    --ȸ������(����,�Ϲ�) �Ϲ�ȸ�� �����ڵ� M0101, ����ȸ�� �����ڵ� H0101
    USER_CREATE_DATE       timestamp default systimestamp,         --�����Ͻ�
    USER_UPDATE            timestamp default systimestamp          --�����Ͻ�
);
--�⺻Ű����
alter table member add Constraint member_user_id_pk primary key (user_id);
--�ܷ�Ű
alter table member add constraint member_gubun_fk
    foreign key(gubun) references code(code_id);
    
--��������
alter table member add constraint member_user_email_uk unique (user_email);
alter table member modify user_pw constraint member_user_pw_nn not null;
alter table member modify user_nick constraint member_user_nick_nn not null; 
alter table member modify user_email constraint member_user_email_nn not null; 
-- not null ���������� add ��� modify ��ɹ� ���

--������ ����
--create sequence member_user_id_seq;
desc member;


--���� ������
insert into member (USER_ID , USER_PW, USER_NICK, USER_EMAIL, GUBUN)
    values('test1', '12341234', '�߾�', 'test1@kh.com', 'M0101');

select * from member;
commit;


-------
--����ȸ��
-------
create table hmember (
    H_ID                   varchar2(20),   --�α� ���̵�
    H_PW                   varchar2(20),   --�α� ��й�ȣ
    H_NAME                 varchar2(30),   --���� ��ȣ��
    H_EMAIL                varchar2(40),   --�̸���
    H_TEL                  varchar2(30),   --���� ����ó
    H_TIME                 varchar2(40),   --����ð�
    H_INFO                 varchar2(60),   --���ǽü�����
    H_ADDINFO              varchar2(60),   --������Ÿ����
    H_PLIST                varchar2(40),   --���ᵿ��
    GUBUN                  varchar2(10) default 'H0101',    --ȸ������(����,�Ϲ�) �Ϲ�ȸ�� �����ڵ� M0101, ����ȸ�� �����ڵ� H0101
    H_CREATE_DATE       timestamp default systimestamp,         --�����Ͻ�
    H_UPDATE            timestamp default systimestamp          --�����Ͻ�
);
--�⺻Ű����
alter table hmember add Constraint hmember_h_id_pk primary key (h_id);
--�ܷ�Ű
alter table hmember add constraint hmember_gubun_fk
    foreign key(gubun) references code(code_id);
    
--��������
alter table hmember add Constraint hmember_h_email unique (h_email);
alter table hmember modify h_pw constraint hmember_h_pw_nn not null;
alter table hmember modify h_email constraint hmember_h_email_nn not null; 
alter table hmember modify h_name constraint hmember_h_name_nn not null; 

desc hmember;





