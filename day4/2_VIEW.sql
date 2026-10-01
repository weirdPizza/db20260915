-- VIEW, PL/SQL(사용자 정의함수, TRIGGER, 프로시저 ..)

-- VIEW
-- 다른 부서와 협업을 하게 돼서 그냥 테이블 자체를 준다면
-- SAL 정보와 같은 민감 정보가 유출될 수 있고, 누군가가 정보를 수정할 수도 있겠지.
-- 또는 조인 작업이 빈번한데 그 조인 쿼리가 너무 길어. 그리고 다른 사람도 많이 써. 그럴 땐 뷰를 만들어 두고 쓴다.
SELECT * FROM EMP; 

CREATE VIEW EMP_VIEW AS
SELECT EMPNO, ENAME, JOB, DEPTNO
FROM EMP;

SELECT * FROM EMP_VIEW;
UPDATE EMP_VIEW SET
    ENAME = 'ZZZ'; -- 엥 수정 됨. 왜? 수정 자체가 불가능한 건 아님! 수정이 목적일 수도 있으니까
ROLLBACK; -- 수정을 못하게 막을 수도 있음.
    
CREATE OR REPLACE VIEW EMP_VIEW AS -- OR REPLACE 키워드 : 만들거나 대체임.
SELECT EMPNO, ENAME, JOB, DNAME, LOC 
-- DNAME, LOC 추가 하니까 오류 생김. 근데 OR REPLACE 하면 DROP 안해도 수정됨.
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WITH READ ONLY; -- 읽기 전용
DROP VIEW EMP_VIEW;

-- VIEW에서 수정이 가능한 경우 (밑 4개 다 만족해야 함)
-- 1. 읽기 전용 옵션 없을 때(WITH READ ONLY 없을 때)
-- 2. 조인이 없을 때
-- 3. GROUP 함수 없을 때
-- 4. DISTINCT 없을 때 
-- # VIEW는 웬만하면 READ ONLY 옵션 적용하는 게 좋다.

SELECT 
    DISTINCT STU_NO, ENR_GRADE -- DISTINCT 는 모든 컬럼의 값이 같아야 묶어줌
FROM ENROL; -- 그래서 STU_NO 만 DISTINCT면 묶어주는데(중복제거) ENR_GRADE는 값이 다르니까 중복이 풀어짐

-- 학번, 이름, 학과, 시험평균 점수를 출력하는 VIEW 생성. 읽기전용.
-- SCORE_VIEW
SELECT * FROM STUDENT;
SELECT * FROM ENROL;

CREATE OR REPLACE VIEW SCORE_VIEW AS
SELECT S.STU_NO, STU_NAME, STU_DEPT, AVG(ENR_GRADE) 시험평균점수
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
GROUP BY S.STU_NO, STU_NAME, STU_DEPT
WITH READ ONLY; 

SELECT * FROM SCORE_VIEW;