-- 시퀀스

-- EX) 게시판 -> 제목, 내용, 작성자, 작성일, 조회수 등이 필요
-- 게시글번호 : 1 (필수적임. 이런 게시글번호 같은 값)
-- 제목 : 오라클 재밋다
-- 내용 : 정말 재밋다
-- 작성자 : TEST1234
-- 작성일 : 2026/09/30
-- 조회수 : 0
-- 삭제, 수정을 무슨 값을 기준으로 하겠어? 제목으로? ㄴㄴ 같은 제목을 다 삭제할 수도 있잖아.
-- 게시글 번호 같은 고유의 값으로 삭제, 수정을 한다.
-- 이 때 시퀀스를 쓰는거임. 정해진 규칙대로 숫자를 증감시켜줌.

CREATE TABLE BOARD(
    BOARDNO NUMBER PRIMARY KEY, 
    TITLE VARCHAR2(100),
    CONTENTS VARCHAR2(300),
    USERID VARCHAR(100),
    CNT NUMBER,
    CDATETIME DATE, 
    UDATETIME DATE
    -- CREATE DATE TIME = CDATETIME으로 많이 쓴다네. 쌤왈
    -- 업뎃 날짜도 같이 관리를 한다네.
    -- 날짜와 관련된 건 맨 마지막에 넣음. 규칙.
); 

SELECT * FROM BOARD;

-- 시퀀스 생성
CREATE SEQUENCE TEST_SEQ
-- 테이블 제외하곤 나 시퀀스야, 뷰야 _SEQ 이렇게 이름 많이 지음
    INCREMENT BY 1
    START WITH 1 -- 시퀀스 만들 때 보통 여기까지 함.
    MINVALUE 1
    MAXVALUE 99999
    NOCYCLE; -- CYCLE: 1부터 99999까지 도달하면 다시 1부터 시작한다는 얘기
    
SELECT
    TEST_SEQ.NEXTVAL -- 실행할 때마다 증가.
FROM DUAL;


CREATE SEQUENCE BOARD_SEQ
    INCREMENT BY 1
    START WITH 1;
    
SELECT * FROM BOARD;

INSERT INTO BOARD 
VALUES (BOARD_SEQ.NEXTVAL, '재밋는..., 코딩', 'ㅋㅋ', 'TEST123',0,SYSDATE,SYSDATE);
COMMIT;

INSERT INTO BOARD 
VALUES (BOARD_SEQ.NEXTVAL, '다그닥다그닥', '말은 간다', 'QQQ',0,SYSDATE,SYSDATE);
COMMIT;


-- 댓글 테이블
-- 댓글번호, 내용, 작성자, 부모댓글번호(대댓글일 경우: 근데 지금은 기초니까 없다 가정), 작성일, 수정일
DROP TABLE BOARD_COMMENT;
CREATE TABLE BOARD_COMMENT(
   COMMENTNO NUMBER PRIMARY KEY,
    BOARDNO NUMBER, -- 게시글 참조키
   CONTENTS VARCHAR2(200),
   USERID VARCHAR2(100),
   CDATETIME DATE,
   UDATETIME DATE
);

CREATE SEQUENCE COMMENT_SEQ
    INCREMENT BY 1
    START WITH 1;
    
SELECT * FROM BOARD_COMMENT;

INSERT INTO BOARD_COMMENT
VALUES(COMMENT_SEQ.NEXTVAL, 1, '공감', 'TEST123', SYSDATE, SYSDATE);
INSERT INTO BOARD_COMMENT
VALUES(COMMENT_SEQ.NEXTVAL, 1, 'ㄴㄴ', 'QQQ', SYSDATE, SYSDATE);


-- 각 게시글별 댓글 수 구하기(없으면 0으로 출력)
SELECT B.BOARDNO, NVL(COUNT(COMMENTNO),0)
FROM BOARD B 
LEFT JOIN BOARD_COMMENT C ON B.BOARDNO = C.BOARDNO
GROUP BY B.BOARDNO;

-- 번호, 제목, 댓글 개수
SELECT B.BOARDNO, TITLE, NVL(COUNT(COMMENTNO),0)
FROM BOARD B 
LEFT JOIN BOARD_COMMENT C ON B.BOARDNO = C.BOARDNO
GROUP BY B.BOARDNO, TITLE; 
-- 출력하고자 하는 컬럼 많을수록 넘 비효율적. 그래서 아래처럼.

SELECT B.*, NVL(C_CNT, 0) AS 댓글개수
FROM BOARD B 
LEFT JOIN( -- LEFT 조인으로 게시글은 다 나오게
    SELECT BOARDNO, COUNT(*) AS C_CNT -- 키 남겨두고, 개수 뽑음
    FROM BOARD_COMMENT
    GROUP BY BOARDNO
)T ON B.BOARDNO = T.BOARDNO;

SELECT * FROM STUDENT;
SELECT * FROM ENROL;
SELECT * FROM SUBJECT;

SELECT S.*, ENR_GRADE, 과목평균, 과목명
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
INNER JOIN (
    SELECT AVG(ENR_GRADE) 과목평균,SUB.SUB_NO, SUB_NAME 과목명
    FROM ENROL E
    INNER JOIN SUBJECT SUB ON E.SUB_NO = SUB.SUB_NO
    GROUP BY SUB.SUB_NO, SUB_NAME
) T ON E.SUB_NO = T.SUB_NO;


