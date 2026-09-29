-- 성능 안좋음.
SELECT 
    STU_NO, STU_NAME, STU_DEPT, 
    (SELECT AVG(ENR_GRADE) FROM ENROL)--권장하지 않음. 왜? 똑같은 데이터를 반복해서 많이 실행하는 거 잖아.
FROM STUDENT;

SELECT 
    STU_NO, STU_NAME, STU_DEPT, AVG_SCORE 
FROM STUDENT S
INNER JOIN ( -- SELECT절에 서브쿼리 넣지 말고 INNER JOIN 해라 이말인듯?
    SELECT AVG(ENR_GRADE) AVG_SCORE
    FROM ENROL
)T ON 1=1; -- 트루니까 무조건 조인될 수 밖에 없음
-- 서로 동일한 값 가진 컬럼(마땅한 조건) 없으니까 억지로 1=1로 이어준 것