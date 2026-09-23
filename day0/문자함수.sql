-- 문자 함수

SELECT * 
FROM STUDENT;

-- 학번_이름, EX) 20153075_옥한빛

-- 1) CONCAT (문자열 이어붙이기)
SELECT CONCAT(CONCAT(STU_NO, '_'), STU_NAME) -- 인자값을 두 개만 허용하기 때문에 이런식
FROM STUDENT;

-- 1-1) ||파이프 
SELECT STU_NO || '_' || STU_NAME -- 얜 인자값 몇 개 받고 제한 없어서 편함
FROM STUDENT;

-- 2) LENTH
SELECT ID, LENGTH(ID)
FROM PROFESSOR;

-- 3) SUBSTR
SELECT
    NAME,
    SUBSTR(JUMIN, 3, 2) 생월,
    SUBSTR(JUMIN, 1, 6) 생년월일, 
    -- 자바는 1 인덱스부터 6 인덱스 전까지인데 데베에선 첫번째부터 6개를 의미
    SUBSTR(JUMIN, 7) -- 7번째 자리부터 끝까지(인덱스 관점이 없음)
FROM STU;

-- DECODE => 자바의 IF문
-- DECODE(컬럼값, 1, 컬럼값이 1일때 출력, 아닐때 출력)
SELECT
    NAME,
    DECODE(SUBSTR(JUMIN, 7,1), 1, '남자', '여자') 성별
FROM STU

-- UPPER, LOWER
SELECT
    UPPER('Hello orAcLe'),
    LOWER('Hello orAcLe')
FROM DUAL;

-- INSTR (특정 문자열이 몇번째 위치에 처음 나오는지)
SELECT 
    EMAIL,
    INSTR(EMAIL,'@')
FROM PROFESSOR;

SELECT 
    EMAIL,
    SUBSTR(EMAIL,INSTR(EMAIL,'@')+1) DOMAIN
FROM PROFESSOR;

-- TRIM, LTRIM, RTRIM
SELECT
    TRIM('       HELLO ORACLE         '),
    LTRIM('       HELLO ORACLE         '),
    RTRIM('       HELLO ORACLE         ')
FROM DUAL;

-- LPAD, RPAD (지정한 길이 만큼 특정 문자열 채우기)
SELECT
    ID,
    RPAD(ID, 10, '*'),
    LPAD(ID, 10, '*')
FROM PROFESSOR;
-- 얘는 이벤트 당첨된 아이디 세글자만 보여주고 나머지는 별표로 채우는 그런 걸로 응용 가능

-- 아이디에 첫 3글자만 출력하고 나머지 공간을 *로 채우기
-- 아이디가 6글자면 *이 3개, 아이디가 8글자면 *이 5개

SELECT
    ID,
    RPAD(SUBSTR(ID, 1, 3), LENGTH(ID), '*')
FROM PROFESSOR;

-- 아이디의 마지막 3글자만 *로 출력
SELECT
    ID,
    RPAD(SUBSTR(ID,1,LENGTH(ID)-3), LENGTH(ID), '*'),
    SUBSTR(ID,1,LENGTH(ID)-3) || '***'
FROM PROFESSOR;

-- EMAIL에서 아이디 뒷부분을 다 *로 출력
-- captain@abc.net => captain@*******
SELECT 
    EMAIL,
    RPAD(SUBSTR(EMAIL, 1, INSTR(EMAIL,'@')), LENGTH(EMAIL), '*') 메일
FROM PROFESSOR;

-- 첫글자와 마지막 글자 빼고 다 *로
SELECT *
FROM STU;
-- 마지막 글자 빼고 SUB, *하고 마지막 글자는 이어붙이기
    

