-- USERTABLE
CREATE TABLE SEMI_USERTABLE (
    u_id       VARCHAR2(15)     PRIMARY KEY,    -- 유저 아이디
    u_pwd      VARCHAR2(15)     NOT NULL,       -- 유저 비밀번호
    u_nickname VARCHAR2(30)     NOT NULL,       -- 유저 닉네임
    u_name     VARCHAR2(20)     NOT NULL,       -- 유저 이름
    u_age_y    NUMBER(4)        NOT NULL,       -- 유저 나이(년)(4자리)
    u_age_m    NUMBER(2)        NOT NULL,       -- 유저 나이(월)(2자리)
    u_age_d    NUMBER(2)        NOT NULL,       -- 유저 나이(일)(2자리)
    u_email    VARCHAR2(50)     NOT NULL,       -- 유저 이메일
    u_tel      VARCHAR2(13)     NOT NULL,       -- 유저 전화번호
    u_addr     VARCHAR2(150)    NOT NULL,       -- 유저 주소 
    u_gender   VARCHAR2(6)      NOT NULL,       -- 유저 성별(select)
    u_regdate  DATE                             -- 유저 가입일자
);
SELECT * FROM SEMI_USERTABLE;

-- ADMINTABLE
CREATE TABLE SEMI_ADMINTABLE (
    a_id        VARCHAR2(10)              PRIMARY KEY,       -- 관리자 아이디
    a_pwd       VARCHAR2(10),                                -- 관리자 비밀번호
    a_nickname  VARCHAR2(10)                                 -- 관리자 닉네임
);
INSERT INTO SEMI_ADMINTABLE VALUES('system', 'tiger', '관리자');


-- JOINTABLE 
CREATE TABLE SEMI_JOINTABLE (
    j_idx       NUMBER(4)       PRIMARY KEY,                         -- 모집글 글번호
    j_id        VARCHAR2(15)    REFERENCES SEMI_USERTABLE(u_id),     -- 모집글 작성자/참여자 아이디(구분)
    j_nickname  VARCHAR2(30)    NOT NULL,                            -- 모집글 작성자/참여자 닉네임
    j_city      VARCHAR2(6)     NOT NULL,                            -- 모집글 지역 대분류(select) 
    j_location  VARCHAR2(100)   NOT NULL,                            -- 모집글 지역 소분류(text)
    j_hobbyB    VARCHAR2(50)    NOT NULL,                            -- 모집글 취미 대분류(select)
    j_hobbyS    VARCHAR2(100)   NOT NULL,                            -- 모집글 취미 소분류(text)
    j_title     VARCHAR2(80)    NOT NULL,                            -- 모집글 제목
    j_date      DATE                    ,                            -- 모집글 작성일자  
    j_Dday_Y    VARCHAR2(10)    NOT NULL,                           -- 모집글 마감일자 년 (보고 달력/text)
    j_Dday_M    VARCHAR2(10)    NOT NULL,                           -- 모집글 마감일자 월 (보고 달력/text)
    j_Dday_D    VARCHAR2(10)    NOT NULL,                           -- 모집글 마감일자 일 (보고 달력/text)
    j_Mday_Y    VARCHAR2(10)    NOT NULL,                           -- 모집글 만나는 일자  년 (보고 달력/text)
    j_Mday_M    VARCHAR2(10)    NOT NULL,                           -- 모집글 만나는 일자  월 (보고 달력/text) 
    j_Mday_D    VARCHAR2(10)    NOT NULL,                           -- 모집글 만나는 일자  일 (보고 달력/text)
    j_count     NUMBER(5)       DEFAULT 0,                           -- 모집글 조회수
    j_cost      VARCHAR2(2)     DEFAULT 'N',                         -- 모집글 비용 유무(체크박스)
    j_maxmem    NUMBER(6)       NOT NULL,                           -- 모집글 최대인원(text)
    j_nowmem    NUMBER(2)       NOT NULL,                     -- 모집글 현재인원   
    j_content   VARCHAR2(3000)  NOT NULL,                            -- 모집글 내용
    j_pwd       VARCHAR(12)     NOT NULL                             -- 모집글 비밀번호
);

SELECT * FROM semi_jointable ORDER by j_idx;

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


-- SEMI_BOARDCOMMENT
CREATE TABLE SEMI_BOARDCOMMENT(
    bc_idx          NUMBER(4)       PRIMARY KEY,                            -- 게시판 댓글의 게시글 번호
    bc_bidx         NUMBER(4)       REFERENCES SEMI_BOARDTABLE(b_idx),      -- 게시판 댓글의 게시판 번호
    bc_id           VARCHAR2(15)    REFERENCES SEMI_USERTABLE(u_id),        -- 게시판 댓글의 유저 아이디
    bc_nickname     VARCHAR2(30)    NOT NULL,                               -- 게시판 댓글의 유저 닉네임
    bc_content      VARCHAR2(3000)  NOT NULL,                               -- 게시판 댓글의 내용
    bc_date         DATE,                                                   -- 게시판 댓글의 작성일자
    bc_ref          NUMBER(4),                                              -- 게시판 댓글의 대댓글 번호
    bc_step         NUMBER(4),                                              -- 게시판 댓글의 대댓글 순서
    bc_level        NUMBER(4)                                               -- 게시판 댓글의 대댓글의 대댓글
);


-- SEMI_JOINCOMMENT
CREATE TABLE SEMI_JOINCOMMENT(
    jc_bidx         NUMBER(4)       REFERENCES SEMI_JOINTABLE(j_idx),       -- 모집글 댓글의 게시글 번호
    jc_id           VARCHAR2(15)    REFERENCES SEMI_USERTABLE(u_id),        -- 모집글 댓글의 유저 아이디
    jc_nickname     VARCHAR2(30)     NOT NULL,                              -- 모집글 댓글의 유저 닉네임
    jc_content      VARCHAR2(3000)  NOT NULL,                               -- 모집글 댓글의 내용
    jc_date         DATE                                                    -- 모집글 댓글의 작성일자
);


