-- 숫자함수 - 소수점 처리하는 함수들은 꼭 알아둘 것

-- ROUND : 반올림
SELECT ROUND(12.345, 2)
FROM DUAL;

-- CEIL : 올림
SELECT CEIL(12.345)
FROM DUAL;
-- 특정 자릿값에서 올리고 싶으면 ROUND랑 조합하면 됨.

-- FLOOR : 내림
SELECT FLOOR(12.999)
FROM DUAL;

-- TRUNC : 날림
SELECT TRUNC(12.34567, 2)
FROM DUAL;


-- 문자 함수

-- CONCAT : 문자열 이어 붙이기, || 로 대체해서 많이 사용
-- 이름_학번 형태로 출력
SELECT CONCAT(CONCAT(STU_NAME, '_'), STU_NO) AS 이름_학번, -- 컬럼에 한해서 AS가 있는 걸 권장
    STU_NAME || '_' || STU_NO "이름 학번2" -- ||를 쓰는 게 낫겠죠?
FROM STUDENT;

-- SUBSTR : 문자열 자르기
SELECT STU_NO, SUBSTR(STU_NO, 5), SUBSTR(STU_NO, 2, 3) 
FROM STUDENT;

SELECT STU_DEPT, LENGTH(STU_DEPT)
FROM STUDENT;

SELECT EMAIL, INSTR(EMAIL, '@')
FROM PROFESSOR;

-- LPAD, RPAD
SELECT 
    ID,
    RPAD(ID, 10, '*'),
    RPAD(SUBSTR(ID, 1, LENGTH(ID)-3), LENGTH(ID), '*'),
    SUBSTR(ID, 1, LENGTH(ID)-3) || '***'
FROM PROFESSOR;

-- 이름의 마지막을 *로 출력
SELECT
    NAME,
    RPAD(SUBSTR(NAME, 1, LENGTH(NAME)-1), LENGTH(NAME), '*'),
    -- 이게 제대로 동작을 안할텐데 코드는 일단 맞아. 근데 한글, 영어 처리하는 바이트가 달라서 
    -- 생기는 문제임. 그니까 한글로 위에 코드는 무리.
    SUBSTR(NAME, 1, LENGTH(NAME)-1) || '*'
FROM PROFESSOR;

