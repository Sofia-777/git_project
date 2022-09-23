-- USERTABLE
CREATE TABLE SEMI_USERTABLE (
    u_id       VARCHAR2(15)     PRIMARY KEY,    -- ���� ���̵�
    u_pwd      VARCHAR2(15)     NOT NULL,       -- ���� ��й�ȣ
    u_nickname VARCHAR2(30)     NOT NULL,       -- ���� �г���
    u_name     VARCHAR2(20)     NOT NULL,       -- ���� �̸�
    u_age_y    NUMBER(4)        NOT NULL,       -- ���� ����(��)(4�ڸ�)
    u_age_m    NUMBER(2)        NOT NULL,       -- ���� ����(��)(2�ڸ�)
    u_age_d    NUMBER(2)        NOT NULL,       -- ���� ����(��)(2�ڸ�)
    u_email    VARCHAR2(50)     NOT NULL,       -- ���� �̸���
    u_tel      VARCHAR2(13)     NOT NULL,       -- ���� ��ȭ��ȣ
    u_addr     VARCHAR2(150)    NOT NULL,       -- ���� �ּ� 
    u_gender   VARCHAR2(6)      NOT NULL,       -- ���� ����(select)
    u_regdate  DATE                             -- ���� ��������
);
SELECT * FROM SEMI_USERTABLE;

-- ADMINTABLE
CREATE TABLE SEMI_ADMINTABLE (
    a_id        VARCHAR2(10)              PRIMARY KEY,       -- ������ ���̵�
    a_pwd       VARCHAR2(10),                                -- ������ ��й�ȣ
    a_nickname  VARCHAR2(10)                                 -- ������ �г���
);
INSERT INTO SEMI_ADMINTABLE VALUES('system', 'tiger', '������');


-- JOINTABLE 
CREATE TABLE SEMI_JOINTABLE (
    j_idx       NUMBER(4)       PRIMARY KEY,                         -- ������ �۹�ȣ
    j_id        VARCHAR2(15)    REFERENCES SEMI_USERTABLE(u_id),     -- ������ �ۼ���/������ ���̵�(����)
    j_nickname  VARCHAR2(30)    NOT NULL,                            -- ������ �ۼ���/������ �г���
    j_city      VARCHAR2(6)     NOT NULL,                            -- ������ ���� ��з�(select) 
    j_location  VARCHAR2(100)   NOT NULL,                            -- ������ ���� �Һз�(text)
    j_hobbyB    VARCHAR2(50)    NOT NULL,                            -- ������ ��� ��з�(select)
    j_hobbyS    VARCHAR2(100)   NOT NULL,                            -- ������ ��� �Һз�(text)
    j_title     VARCHAR2(80)    NOT NULL,                            -- ������ ����
    j_date      DATE                    ,                            -- ������ �ۼ�����  
    j_Dday_Y    VARCHAR2(10)    NOT NULL,                           -- ������ �������� �� (���� �޷�/text)
    j_Dday_M    VARCHAR2(10)    NOT NULL,                           -- ������ �������� �� (���� �޷�/text)
    j_Dday_D    VARCHAR2(10)    NOT NULL,                           -- ������ �������� �� (���� �޷�/text)
    j_Mday_Y    VARCHAR2(10)    NOT NULL,                           -- ������ ������ ����  �� (���� �޷�/text)
    j_Mday_M    VARCHAR2(10)    NOT NULL,                           -- ������ ������ ����  �� (���� �޷�/text) 
    j_Mday_D    VARCHAR2(10)    NOT NULL,                           -- ������ ������ ����  �� (���� �޷�/text)
    j_count     NUMBER(5)       DEFAULT 0,                           -- ������ ��ȸ��
    j_cost      VARCHAR2(2)     DEFAULT 'N',                         -- ������ ��� ����(üũ�ڽ�)
    j_maxmem    NUMBER(6)       NOT NULL,                           -- ������ �ִ��ο�(text)
    j_nowmem    NUMBER(2)       NOT NULL,                     -- ������ �����ο�   
    j_content   VARCHAR2(3000)  NOT NULL,                            -- ������ ����
    j_pwd       VARCHAR(12)     NOT NULL                             -- ������ ��й�ȣ
);

SELECT * FROM semi_jointable ORDER by j_idx;

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


-- SEMI_BOARDCOMMENT
CREATE TABLE SEMI_BOARDCOMMENT(
    bc_idx          NUMBER(4)       PRIMARY KEY,                            -- �Խ��� ����� �Խñ� ��ȣ
    bc_bidx         NUMBER(4)       REFERENCES SEMI_BOARDTABLE(b_idx),      -- �Խ��� ����� �Խ��� ��ȣ
    bc_id           VARCHAR2(15)    REFERENCES SEMI_USERTABLE(u_id),        -- �Խ��� ����� ���� ���̵�
    bc_nickname     VARCHAR2(30)    NOT NULL,                               -- �Խ��� ����� ���� �г���
    bc_content      VARCHAR2(3000)  NOT NULL,                               -- �Խ��� ����� ����
    bc_date         DATE,                                                   -- �Խ��� ����� �ۼ�����
    bc_ref          NUMBER(4),                                              -- �Խ��� ����� ���� ��ȣ
    bc_step         NUMBER(4),                                              -- �Խ��� ����� ���� ����
    bc_level        NUMBER(4)                                               -- �Խ��� ����� ������ ����
);


-- SEMI_JOINCOMMENT
CREATE TABLE SEMI_JOINCOMMENT(
    jc_bidx         NUMBER(4)       REFERENCES SEMI_JOINTABLE(j_idx),       -- ������ ����� �Խñ� ��ȣ
    jc_id           VARCHAR2(15)    REFERENCES SEMI_USERTABLE(u_id),        -- ������ ����� ���� ���̵�
    jc_nickname     VARCHAR2(30)     NOT NULL,                              -- ������ ����� ���� �г���
    jc_content      VARCHAR2(3000)  NOT NULL,                               -- ������ ����� ����
    jc_date         DATE                                                    -- ������ ����� �ۼ�����
);


