-- ROWNUM 
-- 각 레코드들은 주민등록번호처럼 부여되는데 SELECT 되는 순서에 따라 순차적으로 부여되면서 번호를 갖고 있음. 그게 ROWNUM.
SELECT S.*, ROWNUM 
FROM STUDENT S
WHERE ROWNUM <= 3;

-- ROWNUM 값이 먼저 반영되고 정렬이 되므로 뒤죽박죽
SELECT S.*, ROWNUM 
FROM STUDENT S
WHERE STU_HEIGHT IS NOT NULL
ORDER BY STU_HEIGHT DESC; 
-- 정렬보다 ROWNUM이 먼저 정해져 버림, 키 순서대로 ROWNUM이 정해지는 게 아님

SELECT T.*, ROWNUM
FROM(
    SELECT S.*
    FROM STUDENT S
    WHERE STU_HEIGHT IS NOT NULL
    ORDER BY STU_HEIGHT DESC
) T
WHERE ROWNUM <= 3;

-- 
SELECT *
FROM (
SELECT T.*, ROWNUM AS NUM
    FROM(
        SELECT S.*
        FROM STUDENT S
        WHERE STU_HEIGHT IS NOT NULL
        ORDER BY STU_HEIGHT DESC
    ) T
)
WHERE NUM = 3;

-- EMP 
SELECT T.*
FROM(
    SELECT JOB, SUM(SAL) AS JOB_SAL
    FROM EMP
    GROUP BY JOB
    ORDER BY JOB_SAL DESC
) T
WHERE ROWNUM = 1; 
-- 단점 : 공동 1등이 있는 경우엔 ROWNUM 쓰지 않는 게 좋음.
-- 이땐 밑에 나오는 함수를 써주면 됨.


-- RANK, DENSE_RANK, ROW_NUMBER 함수
SELECT
    ENAME, SAL,
    RANK() OVER (ORDER BY SAL DESC) AS RANK1, -- 중복 순위 있음, 중복순위 후 건뛰 순위로.
    DENSE_RANK() OVER (ORDER BY SAL DESC) AS RANK2, -- 중복 순위 있음, 건뛰 ㄴㄴ
    ROW_NUMBER() OVER (ORDER BY SAL DESC, ENAME DESC) AS RANK3 -- 값이 중복이어도 순위 차이 줌.
    -- ROW_NUMBER 같은 경우엔 값이 중복이어도 다른 순위니까 그 안에서도 차별점을 주기 위해
    -- 다시 순위 기준을 또 넣음. 그래서 ORDER BY 1, 2 인자를 두 개 넣어줌.
FROM EMP;

SELECT
    ENAME, SAL, DEPTNO,
    RANK() OVER (PARTITION BY DEPTNO ORDER BY SAL DESC) AS RANK1
    -- PARTITION BY는 그룹으로 묶음
FROM EMP; -- 여기서 1등만 뽑고 싶다 이런 거 못해 , 서브쿼리 ㄱㄱ

SELECT *
FROM (
    SELECT
        ENAME, SAL, DEPTNO,
        RANK() OVER (PARTITION BY DEPTNO ORDER BY SAL DESC) AS RANK1
    FROM EMP
) WHERE RANK1 = 1;

