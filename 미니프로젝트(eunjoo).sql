-- USERTABLE
CREATE TABLE SEMI_USERTABLE (
    u_id       VARCHAR2(15)     PRIMARY KEY,    -- 유저 아이디
    u_pwd      VARCHAR2(15)     NOT NULL,       -- 유저 비밀번호
    u_nickname VARCHAR2(30)     NOT NULL,       -- 유저 닉네임
    u_name     VARCHAR2(20)     NOT NULL,       -- 유저 이름
    u_email    VARCHAR2(50)     NOT NULL,       -- 유저 이메일
    u_tel      VARCHAR2(13)     NOT NULL,       -- 유저 전화번호
    u_addr     VARCHAR2(150)    NOT NULL,       -- 유저 주소
    u_gender   VARCHAR2(6)      NOT NULL,       -- 유저 성별
    u_regdate  DATE                             -- 유저 가입일자
);

COMMIT;
DESC SEMI_USERTABLE;
SELECT * FROM SEMI_USERTABLE;
DROP TABLE SEMI_USERTABLE;
INSERT INTO SEMI_USERTABLE VALUES('a', 'aa', 'a', 'a', 'a', 'a', 'a', 'a', sysdate);
SELECT u_pwd FROM SEMI_USERTABLE WHERE u_id = 'a';





-- ADMINTABLE
CREATE TABLE SEMI_ADMINTABLE (
    a_id        VARCHAR2(10)        PRIMARY KEY,       -- 관리자 아이디
    a_pwd       VARCHAR2(10),                          -- 관리자 비밀번호
    a_nickname  VARCHAR2(10)                           -- 관리자 닉네임
);

INSERT INTO SEMI_ADMINTABLE VALUES('system', 'tiger', '관리자');
DROP TABLE SEMI_ADMINTABLE;
SELECT * FROM SEMI_ADMINTABLE;
COMMIT;





-- JOINTABLE
CREATE TABLE SEMI_JOINTABLE (
    j_idx       NUMBER(4)       PRIMARY KEY,                         -- 모집글 글번호
    j_id        VARCHAR2(15)    REFERENCES SEMI_USERTABLE(u_id),     -- 모집글 작성자/참여자 아이디(구분)
    j_nickname  VARCHAR2(30)    NOT NULL,                            -- 모집글 작성자/참여자 닉네임
    j_city      VARCHAR2(6)     NOT NULL,                            -- 모집글 지역 대분류
    j_location  VARCHAR2(100)   NOT NULL,                            -- 모집글 지역 소분류
    j_hobbyB    VARCHAR2(50)    NOT NULL,                            -- 모집글 취미 대분류
    j_hobbyS    VARCHAR2(100)   NOT NULL,                            -- 모집글 취미 소분류
    j_title     VARCHAR2(80)    NOT NULL,                            -- 모집글 제목
    j_content   VARCHAR2(3000)  NOT NULL,                            -- 모집글 내용
    j_date      DATE                    ,                            -- 모집글 작성일자
    j_Dday      VARCHAR2(10)    NOT NULL,                            -- 모집글 마감일자
    j_Mday      VARCHAR2(10)    NOT NULL,                            -- 모집글 만나는 일자
    j_count     NUMBER(5)       DEFAULT 0,                           -- 모집글 조회수
    j_maxmem    NUMBER(2)       DEFAULT 2,                           -- 모집글 최대인원
    j_nowmem    NUMBER(2)       DEFAULT 1,                           -- 모집글 현재인원
    j_pwd       VARCHAR(12)     NOT NULL                             -- 모집글 비밀번호
);

DROP TABLE SEMI_JOINTABLE;
INSERT INTO SEMI_JOINTABLE VALUES(1, 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', sysdate, 'a', 'a', 0, 2, 1, 'a');
SELECT * FROM SEMI_JOINTABLE;
COMMIT;





-- BOARDTABLE
CREATE TABLE SEMI_BOARDTABLE (
    b_idx       NUMBER(4)       PRIMARY KEY,                         -- 자유게시판 글번호
    b_id        VARCHAR2(15)    REFERENCES SEMI_USERTABLE(u_id),     -- 자유게시판 아이디(유저)
    b_nickname  VARCHAR2(30)    NOT NULL,                            -- 자유게시판 닉네임
    b_title     VARCHAR2(80)    NOT NULL,                            -- 자유게시판 제목
    b_content   VARCHAR2(3000)  NOT NULL,                            -- 자유게시판 내용
    b_date      DATE                    ,                            -- 자유게시판 작성일자
    b_count     NUMBER(5)       DEFAULT 0,                           -- 자유게시판 조회수
    b_pwd       VARCHAR(12)     NOT NULL                             -- 자유게시판 비밀번호
);

INSERT INTO SEMI_BOARDTABLE VALUES(1, 'a', 'a', 'a', 'a', sysdate, 0, 'a');
SELECT * FROM SEMI_BOARDTABLE;
DROP TABLE SEMI_BOARDTABLE;
COMMIT;
delete from SEMI_BOARDTABLE where b_id is null;




-- NOTICETABLE
CREATE TABLE SEMI_NOTICETABLE(
    n_idx       NUMBER(4)       PRIMARY KEY,                         -- 공지사항 글번호
    n_id        VARCHAR2(15)    REFERENCES SEMI_ADMINTABLE(a_id),    -- 공지사항 아이디(관리자)
    n_nickname  VARCHAR2(30)    NOT NULL,                            -- 공지사항 닉네임
    n_title     VARCHAR2(80)    NOT NULL,                            -- 공지사항 제목
    n_content   VARCHAR2(3000)  NOT NULL,                            -- 공지사항 내용
    n_date      DATE                    ,                            -- 공지사항 작성일자
    n_count     NUMBER(5)       DEFAULT 0                            -- 공지사항 조회수
);

INSERT INTO SEMI_NOTICETABLE VALUES(1, 'system', 'a', 'a', 'a', sysdate, 0);
SELECT * FROM SEMI_NOTICETABLE;
DROP TABLE SEMI_NOTICETABLE;
COMMIT;





-- SEMI_BOARDCOMMENT
CREATE TABLE SEMI_BOARDCOMMENT(
    bc_idx          NUMBER(4)       PRIMARY KEY,
    bc_bidx         NUMBER(4)       REFERENCES SEMI_BOARDTABLE(b_idx),      -- 게시판 댓글의 게시글 번호
    bc_id           VARCHAR2(15)    REFERENCES SEMI_USERTABLE(u_id),        -- 게시판 댓글의 유저 아이디
    bc_nickname     VARCHAR2(30)    NOT NULL,                               -- 게시판 댓글의 유저 닉네임
    bc_content      VARCHAR2(3000)  NOT NULL,                               -- 게시판 댓글의 내용
    bc_date         DATE,                                                    -- 게시판 댓글의 작성일자
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
    jc_bidx         NUMBER(4)       REFERENCES SEMI_JOINTABLE(j_idx),       -- 모집글 댓글의 게시글 번호
    jc_id           VARCHAR2(15)    REFERENCES SEMI_USERTABLE(u_id),        -- 모집글 댓글의 유저 아이디
    jc_nickname     VARCHAR2(30)     NOT NULL,                              -- 모집글 댓글의 유저 닉네임
    jc_content      VARCHAR2(3000)  NOT NULL,                               -- 모집글 댓글의 내용
    jc_date         DATE                                                    -- 모집글 댓글의 작성일자
);
INSERT INTO SEMI_JOINCOMMENT VALUES(1, 'a', 'a', 'a', '22/08/17');
INSERT INTO SEMI_JOINCOMMENT VALUES(1, 'a', 'a', 'a', '22/09/17');
SELECT * FROM  SEMI_JOINCOMMENT ORDER BY jc_date;
DROP TABLE SEMI_JOINCOMMENT;
COMMIT;