drop user c##zoopiter;
--��������
CREATE USER c##zoopiter IDENTIFIED BY zoopiter1234
    DEFAULT TABLESPACE users
    TEMPORARY TABLESPACE temp
    PROFILE DEFAULT;
--���Ѻο�
GRANT CONNECT, RESOURCE TO c##zoopiter;
GRANT CREATE VIEW, CREATE SYNONYM TO c##zoopiter;
GRANT UNLIMITED TABLESPACE TO c##zoopiter;
--�� Ǯ��
ALTER USER c##zoopiter ACCOUNT UNLOCK;