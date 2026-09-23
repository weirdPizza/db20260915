-- SELECT, DELETE, UPDATE, INSERT는 외워라 

-- SELECT (조회)
SELECT * FROM STUDENT;

-- 특정 컬럼만 조회
SELECT STU_NO, STU_NAME, STU_DEPT 
FROM STUDENT;

-- 별칭
SELECT STU_NO AS 학번, STU_NAME AS 이름, STU_DEPT AS "학과 이름"
FROM STUDENT;

-- 테이블 별칭
SELECT STU_NAME 이름, S.*
FROM STUDENT S;
-- 테이블 별칭 앞글자 하나로 보통함


-- INSERT
-- 1. 모든 컬럼에 값을 넣는 경우, 2. 특정 컬럼에 값을 넣는 경우

-- 모든 컬럼에 값을 넣는 경우 컬럼명 생략이 가능하다
INSERT INTO STUDENT
VALUES ('12123434', '김철수', '전기전자', 2, 'B', 'M', 200, 100);
COMMIT;

-- 이름 : 홍길동, 학번 : 12345678, 학과 : 기계
-- 특정 컬럼에 값을 넣는 경우 컬럼명을 명시
INSERT INTO STUDENT (STU_NAME, STU_NO, STU_DEPT)
VALUES ('홍길동', '12345678', '기계');
COMMIT;

SELECT * FROM STUDENT;


-- UPDATE (수정)
UPDATE STUDENT SET
    STU_GRADE = 3,
    STU_CLASS = 'C'
WHERE STU_NAME = '김철수';


-- DELETE
DELETE FROM STUDENT
WHERE STU_NAME = '홍길동';