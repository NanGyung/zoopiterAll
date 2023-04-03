--���̺� ����
DROP TABLE hospital_data CASCADE CONSTRAINTS;
drop table hmember CASCADE CONSTRAINTS;
drop table member CASCADE CONSTRAINTS;
drop table code CASCADE CONSTRAINTS;

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
    GUBUN                  varchar2(10) default 'M0101',    --ȸ������(����,�Ϲ�) �Ϲ�ȸ�� �����ڵ� M0101, ����ȸ�� �����ڵ� H0101
    USER_PHOTO             BLOB,           --����
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
--create member_member_id_seq;
desc member;


--���� ������
insert into member (USER_ID , USER_PW, USER_NICK, USER_EMAIL, GUBUN)
    values('test1', 'test1234', '��Ī1', 'test1@gamil.com', 'M0101');

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
    H_TIME                 varchar2(5000), --����ð�
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

--���� ������
insert into member (H_ID , H_PW, H_EMAIL, H_TEL, H_TIME, H_INFO, H_ADDINFO, H_PLIST, GUBUN)
    values(
    'htest1', 
    'htest1234', 
    '���� ��������', 
    'htest1@gamil.com', 
    '211-3375', 
    '������	���� 9:30~���� 7:00
    ȭ����	���� 9:30~���� 7:00
    ������
    (�ĸ���)
    ���� 9:30~���� 7:00
    �ð��� �޶��� �� ����
    �����	���� 9:30~���� 7:00
    �ݿ���	���� 9:30~���� 7:00
    �����	���� 9:30~���� 4:00
    �Ͽ���	�޹���', 
    '����, ���� ���ͳ�, �ݷ����� ����', 
    '������, ����� ���� �����Դϴ�!', 
    '������, �����', 
    'M0101');

desc hmember;
commit;

-------------------
-- �������� ���������� 
-------------------
CREATE TABLE hospital_data(
   hd_id              NUMBER(4)                         --��ȣ
  ,hd_code            NUMBER(7)                         --������ġ��ü�ڵ�
  ,hd_manage          VARCHAR2(13)                      --������ȣ
  ,hd_perdate         DATE                              --���㰡����
  ,hd_statuscode      NUMBER(1)                         --�������±����ڵ�
  ,hd_satusname       VARCHAR2(23)                      --�������¸�
  ,hd_detailcode      NUMBER(4)                         --�󼼿��������ڵ�
  ,hd_detailname      VARCHAR2(13)                       --�󼼿������¸�
  ,hd_tel             VARCHAR2(17)                      --��������ȭ
  ,hd_address_general VARCHAR2(200)                      --�����ּ�
  ,hd_address_road    VARCHAR2(200)                     --���θ��ּ�
  ,hd_address_roadnum NUMBER(7)                         --���θ�����ȣ
  ,hd_name            VARCHAR2(52)                      --������
  ,hd_adit_date       VARCHAR2(22)                      --������������
  ,hd_adit_gubun      VARCHAR2(1)                       --�����Ͱ��ű���(U,I)
  ,hd_adit_resdate    VARCHAR2(22)                      --�����Ͱ�������
  ,hd_lng             NUMBER                            --��ǥ(x)
  ,hd_lat             NUMBER                            --��ǥ(y)
);
--�⺻Ű����
alter table hospital_data add Constraint hospital_data_hd_id_pk primary key (hd_id);
--��������
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
--��������
------------
CREATE TABLE hospital_info(
   hd_id              NUMBER(4)                         --��ȣ
  ,hd_code            NUMBER(7)                         --������ġ��ü�ڵ�
  ,hd_manage          VARCHAR2(13)                      --������ȣ
  ,hd_perdate         DATE                              --���㰡����
  ,hd_statuscode      NUMBER(1)                         --�������±����ڵ�
  ,hd_satusname       VARCHAR2(23)                      --�������¸�
  ,hd_detailcode      NUMBER(4)                         --�󼼿��������ڵ�
  ,hd_detailname      VARCHAR2(13)                       --�󼼿������¸�
  ,hd_tel             VARCHAR2(17)                      --��������ȭ
  ,hd_address_general VARCHAR2(200)                      --�����ּ�
  ,hd_address_road    VARCHAR2(200)                     --���θ��ּ�
  ,hd_address_roadnum NUMBER(7)                         --���θ�����ȣ
  ,hd_name            VARCHAR2(52)                      --������
  ,hd_adit_date       VARCHAR2(22)                      --������������
  ,hd_adit_gubun      VARCHAR2(1)                       --�����Ͱ��ű���(U,I)
  ,hd_adit_resdate    VARCHAR2(22)                      --�����Ͱ�������
  ,hd_lng             NUMBER                            --��ǥ(x)
  ,hd_lat             NUMBER                            --��ǥ(y)
);
