-- 그룹 함수
-- SUM, AVG, MAX, MIN, COUNT

SELECT * FROM PROFESSOR;

SELECT SUM(PAY) FROM PROFESSOR;
-- 그룹 함수를 쓸 경우 컬럼을 같이 쓸 수 없다.

SELECT 
    SUM(PAY)
FROM PROFESSOR
WHERE POSITION = '정교수';

-- MAX, MIN
SELECT MAX(PAY), MIN(PAY)
FROM PROFESSOR;

SELECT AVG(PAY)
FROM PROFESSOR;

SELECT COUNT(*),-- 전체 레코드의 개수
    COUNT(NAME), -- NAME 컬럼의 NULL이 아닌 레코드의 개수
    COUNT(BONUS)-- BONUS 컬럼의 NULL이 아닌 레코드의 개수
FROM PROFESSOR;

-- GROUP BY (그룹화)
SELECT POSITION, ROUND(AVG(PAY))
-- 그룹함수를 쓸 때는 GROUP BY에 있는 컬럼명만 볼 수 있음 주의!
FROM PROFESSOR
GROUP BY POSITION;

-- 그룹함수에서 WHERE와 HAVING의 차이
-- WHERE : 그룹하기 전에 조건으로 먼저 걸러냄(조건에 맞는 애들끼리 그룹화)
-- HAVING : 그룹이 다 끝난 후 조건 처리

-- EX1) 직급별 급여 평균. 단, 급여가 200 이상인 사람들을 기준 => WHERE
SELECT POSITION, ROUND(AVG(PAY))
FROM PROFESSOR
WHERE PAY >= 200
GROUP BY POSITION;

-- EX2) 직급별 급여 평균이 300이 넘는 직급 구하기. => HAVING
SELECT POSITION, ROUND(AVG(PAY))
FROM PROFESSOR
GROUP BY POSITION
HAVING AVG(PAY) >= 300;

-- WHERE와 HAVING은 같이 쓸 수 있음.
SELECT POSITION, ROUND(AVG(PAY))
FROM PROFESSOR
WHERE PAY >= 200
GROUP BY POSITION
HAVING AVG(PAY) >= 300;

-- 각 학과별 학생 수가 3 이하인 학과명과 학생 수 출력
SELECT * FROM STUDENT;
SELECT STU_DEPT, COUNT(STU_NO) "학생 수"
FROM STUDENT
GROUP BY STU_DEPT
HAVING COUNT(STU_NO) <= 3;

-- 각 성별에서 가장 키가 큰 학생의 성별, 키 값 구하기
SELECT STU_GENDER, MAX(STU_HEIGHT)
FROM STUDENT
GROUP BY STU_GENDER;

-- 각 학과별 학생들의 평균 키를 구하기
-- 단, 165 이하인 학생들은 평균에서 제외
SELECT STU_DEPT, ROUND(AVG(STU_HEIGHT)) 평균키
FROM STUDENT
WHERE STU_HEIGHT > 165
GROUP BY STU_DEPT;

-- GROUP은 2개 이상의 컬럼으로 가능
-- 1. 각 학과별 학생 수 구하기
-- 2. 각 학과 내에서도 성별로 구분해서 학생 수 구하기
SELECT STU_DEPT, STU_GENDER, COUNT(*)
FROM STUDENT
GROUP BY STU_DEPT, STU_GENDER
ORDER BY STU_DEPT;

-- 각 학과에서 키가 170 이상인 학생들의 학생 수 구하기
-- 출력 컬럼 : 학과명, 키가 170 이상 학생 수
SELECT STU_DEPT, COUNT(*)
FROM STUDENT
WHERE STU_HEIGHT >= 170
GROUP BY STU_DEPT;





