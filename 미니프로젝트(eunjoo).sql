-- USERTABLE
CREATE TABLE SEMI_USERTABLE (
    u_id       VARCHAR2(15)     PRIMARY KEY,    -- ���� ���̵�
    u_pwd      VARCHAR2(15)     NOT NULL,       -- ���� ��й�ȣ
    u_nickname VARCHAR2(30)     NOT NULL,       -- ���� �г���
    u_name     VARCHAR2(20)     NOT NULL,       -- ���� �̸�
    u_email    VARCHAR2(50)     NOT NULL,       -- ���� �̸���
    u_tel      VARCHAR2(13)     NOT NULL,       -- ���� ��ȭ��ȣ
    u_addr     VARCHAR2(150)    NOT NULL,       -- ���� �ּ�
    u_gender   VARCHAR2(6)      NOT NULL,       -- ���� ����
    u_regdate  DATE                             -- ���� ��������
);

COMMIT;
DESC SEMI_USERTABLE;
SELECT * FROM SEMI_USERTABLE;
DROP TABLE SEMI_USERTABLE;
INSERT INTO SEMI_USERTABLE VALUES('a', 'aa', 'a', 'a', 'a', 'a', 'a', 'a', sysdate);
SELECT u_pwd FROM SEMI_USERTABLE WHERE u_id = 'a';





-- ADMINTABLE
CREATE TABLE SEMI_ADMINTABLE (
    a_id        VARCHAR2(10)        PRIMARY KEY,       -- ������ ���̵�
    a_pwd       VARCHAR2(10),                          -- ������ ��й�ȣ
    a_nickname  VARCHAR2(10)                           -- ������ �г���
);

INSERT INTO SEMI_ADMINTABLE VALUES('system', 'tiger', '������');
DROP TABLE SEMI_ADMINTABLE;
SELECT * FROM SEMI_ADMINTABLE;
COMMIT;





-- JOINTABLE
CREATE TABLE SEMI_JOINTABLE (
    j_idx       NUMBER(4)       PRIMARY KEY,                         -- ������ �۹�ȣ
    j_id        VARCHAR2(15)    REFERENCES SEMI_USERTABLE(u_id),     -- ������ �ۼ���/������ ���̵�(����)
    j_nickname  VARCHAR2(30)    NOT NULL,                            -- ������ �ۼ���/������ �г���
    j_city      VARCHAR2(6)     NOT NULL,                            -- ������ ���� ��з�
    j_location  VARCHAR2(100)   NOT NULL,                            -- ������ ���� �Һз�
    j_hobbyB    VARCHAR2(50)    NOT NULL,                            -- ������ ��� ��з�
    j_hobbyS    VARCHAR2(100)   NOT NULL,                            -- ������ ��� �Һз�
    j_title     VARCHAR2(80)    NOT NULL,                            -- ������ ����
    j_content   VARCHAR2(3000)  NOT NULL,                            -- ������ ����
    j_date      DATE                    ,                            -- ������ �ۼ�����
    j_Dday      VARCHAR2(10)    NOT NULL,                            -- ������ ��������
    j_Mday      VARCHAR2(10)    NOT NULL,                            -- ������ ������ ����
    j_count     NUMBER(5)       DEFAULT 0,                           -- ������ ��ȸ��
    j_maxmem    NUMBER(2)       DEFAULT 2,                           -- ������ �ִ��ο�
    j_nowmem    NUMBER(2)       DEFAULT 1,                           -- ������ �����ο�
    j_pwd       VARCHAR(12)     NOT NULL                             -- ������ ��й�ȣ
);

DROP TABLE SEMI_JOINTABLE;
INSERT INTO SEMI_JOINTABLE VALUES(1, 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', sysdate, 'a', 'a', 0, 2, 1, 'a');
SELECT * FROM SEMI_JOINTABLE;
COMMIT;





-- BOARDTABLE
CREATE TABLE SEMI_BOARDTABLE (
    b_idx       NUMBER(4)       PRIMARY KEY,                         -- �����Խ��� �۹�ȣ
    b_id        VARCHAR2(15)    REFERENCES SEMI_USERTABLE(u_id),     -- �����Խ��� ���̵�(����)
    b_nickname  VARCHAR2(30)    NOT NULL,                            -- �����Խ��� �г���
    b_title     VARCHAR2(80)    NOT NULL,                            -- �����Խ��� ����
    b_content   VARCHAR2(3000)  NOT NULL,                            -- �����Խ��� ����
    b_date      DATE                    ,                            -- �����Խ��� �ۼ�����
    b_count     NUMBER(5)       DEFAULT 0,                           -- �����Խ��� ��ȸ��
    b_pwd       VARCHAR(12)     NOT NULL                             -- �����Խ��� ��й�ȣ
);

INSERT INTO SEMI_BOARDTABLE VALUES(1, 'a', 'a', 'a', 'a', sysdate, 0, 'a');
SELECT * FROM SEMI_BOARDTABLE;
DROP TABLE SEMI_BOARDTABLE;
COMMIT;
delete from SEMI_BOARDTABLE where b_id is null;




-- NOTICETABLE
CREATE TABLE SEMI_NOTICETABLE(
    n_idx       NUMBER(4)       PRIMARY KEY,                         -- �������� �۹�ȣ
    n_id        VARCHAR2(15)    REFERENCES SEMI_ADMINTABLE(a_id),    -- �������� ���̵�(������)
    n_nickname  VARCHAR2(30)    NOT NULL,                            -- �������� �г���
    n_title     VARCHAR2(80)    NOT NULL,                            -- �������� ����
    n_content   VARCHAR2(3000)  NOT NULL,                            -- �������� ����
    n_date      DATE                    ,                            -- �������� �ۼ�����
    n_count     NUMBER(5)       DEFAULT 0                            -- �������� ��ȸ��
);

INSERT INTO SEMI_NOTICETABLE VALUES(1, 'system', 'a', 'a', 'a', sysdate, 0);
SELECT * FROM SEMI_NOTICETABLE;
DROP TABLE SEMI_NOTICETABLE;
COMMIT;





-- SEMI_BOARDCOMMENT
CREATE TABLE SEMI_BOARDCOMMENT(
    bc_idx          NUMBER(4)       PRIMARY KEY,
    bc_bidx         NUMBER(4)       REFERENCES SEMI_BOARDTABLE(b_idx),      -- �Խ��� ����� �Խñ� ��ȣ
    bc_id           VARCHAR2(15)    REFERENCES SEMI_USERTABLE(u_id),        -- �Խ��� ����� ���� ���̵�
    bc_nickname     VARCHAR2(30)    NOT NULL,                               -- �Խ��� ����� ���� �г���
    bc_content      VARCHAR2(3000)  NOT NULL,                               -- �Խ��� ����� ����
    bc_date         DATE,                                                    -- �Խ��� ����� �ۼ�����
    bc_ref          NUMBER(4),
    bc_step         NUMBER(4),
    bc_level        NUMBER(4)
);
INSERT INTO SEMI_BOARDCOMMENT VALUES(1, 1, 'a', 'a', 'a', '22/08/17');
INSERT INTO SEMI_BOARDCOMMENT VALUES(2, 1, 'a', 'a', 'a', '22/09/17');
SELECT * FROM  SEMI_BOARDCOMMENT ORDER BY bc_bidx, bc_date;
DROP TABLE SEMI_BOARDCOMMENT;
delete from SEMI_BOARDCOMMENT;
COMMIT;

SELECT MAX(BC_IDX) FROM SEMI_BOARDCOMMENT;


SELECT bc_bidx
     , bc_id
     , bc_nickname
     , bc_content
     , bc_date 
  FROM SEMI_BOARDCOMMENT 
 WHERE bc_bidx = 2
 ORDER BY bc_date;



-- SEMI_JOINCOMMENT
CREATE TABLE SEMI_JOINCOMMENT(
    jc_bidx         NUMBER(4)       REFERENCES SEMI_JOINTABLE(j_idx),       -- ������ ����� �Խñ� ��ȣ
    jc_id           VARCHAR2(15)    REFERENCES SEMI_USERTABLE(u_id),        -- ������ ����� ���� ���̵�
    jc_nickname     VARCHAR2(30)     NOT NULL,                              -- ������ ����� ���� �г���
    jc_content      VARCHAR2(3000)  NOT NULL,                               -- ������ ����� ����
    jc_date         DATE                                                    -- ������ ����� �ۼ�����
);
INSERT INTO SEMI_JOINCOMMENT VALUES(1, 'a', 'a', 'a', '22/08/17');
INSERT INTO SEMI_JOINCOMMENT VALUES(1, 'a', 'a', 'a', '22/09/17');
SELECT * FROM  SEMI_JOINCOMMENT ORDER BY jc_date;
DROP TABLE SEMI_JOINCOMMENT;
COMMIT;