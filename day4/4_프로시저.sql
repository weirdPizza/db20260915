-- 프로시저
-- 미리 만들어 놓은 쿼리
-- 예를 들어 성적을 빈번하게 관리해야 한다 이런 건 프로시저를 만들어서 씀.
-- 물론 쿼리로도 가능하다만 프로시저로 미리 만들어두고 사용한다.

CREATE OR REPLACE PROCEDURE TEMP_PROC
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE'); -- DB의 PRINT문
END;
/

SET SERVEROUTPUT ON; 
-- 서버 메시지(프린트문) 볼 수 있는 옵션, 처음 한 번 ON 하면 됨.
-- PL/SQL과 관련된 건 주석에 민감하니 주석을 다음 라인에 달 것
EXEC TEMP_PROC;

-- 인자 값으로 보낸 사번을 가진 사원의 이름, 직급, 급여 정보를 출력
SELECT * FROM EMP;
EXEC EMPINFO_PROC(7499);

-- 프로시저는 테이블과 독립적 VS. 함수는 테이블과 연관적
CREATE OR REPLACE PROCEDURE EMPINFO_PROC(I_EMPNO EMP.EMPNO%TYPE) 
-- EMPNO 타입과 동일하게 I_EMPNO를 받을게 란 의미
IS
    O_ENAME EMP.ENAME%TYPE;
    O_JOB EMP.JOB%TYPE;
    O_SAL EMP.SAL%TYPE;
BEGIN
    SELECT ENAME, JOB, SAL
    -- 이 쿼리 안에서만 존재함. ENAME, JOB...은 따지자면 지역변수.
    -- 그래서 프린트문에서 못 씀.
    -- 쓸려면 내가 만든 변수에 담아줘야 함.(INTO절)
    INTO O_ENAME, O_JOB, O_SAL
    -- 위에 얘넨 전역변수
    FROM EMP
    WHERE EMPNO = I_EMPNO;
    
    DBMS_OUTPUT.PUT_LINE(O_ENAME || '님의 직급은 ' || O_JOB || ', 급여는 ' || O_SAL);
END;
/

 EXEC EMP_ADDSAL_PROC(7566, 4000)

-- 해당 사번을 가진 사원의 급여를 두번째 인자값으로 변경
-- 급여변경 프로시저
CREATE OR REPLACE PROCEDURE EMP_ADDSAL_PROC(
    I_EMPNO EMP.EMPNO%TYPE, I_SAL EMP.SAL%TYPE
)
IS
    O_COUNT NUMBER;
BEGIN
    UPDATE EMP SET
        SAL = I_SAL
    WHERE EMPNO = I_EMPNO;
    O_COUNT := SQL%ROWCOUNT;
    -- SQL%COUNT : SQL쿼리문을 실행했을 때 영향받은 쿼리 개수
    -- SQL%COUNT = 0이면 업데이트 안 일어난 거임.
    
    IF O_COUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('사번을 확인해주세요.');
    ELSIF O_COUNT = 1 THEN
        DBMS_OUTPUT.PUT_LINE('수정되었습니다.');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('2건 이상 수정되었습니다.');
        -- 사실 PK를 조건으로 이루어지는 거라 2건이상 수정될 일 없긴 해.
    END IF;
    COMMIT;
    -- 프로시저 안에 커밋을 넣을 수 있음. = 커밋 안넣으면 프로시저는 롤백 할 수 있음ㅇㅇ
END;
/


-- 문제
-- 프로시저 호출
EXEC ENROL_PROC('20131001', '104', 75);
-- 1. 없는 학번이나 없는 과목번호를 입력하면 '정보를 다시 확인해주세요' 출력
-- 2. 점수가 0미만, 100초과일 경우 '점수의 범위는 1~100 입니다' 출력
-- 3. 학번, 과목번호에 해당하는 점수는 3번째 인자값으로 변경

SELECT * FROM ENROL;

CREATE OR REPLACE PROCEDURE ENROL_PROC(
    I_STUNO ENROL.STU_NO%TYPE, I_SUBNO ENROL.SUB_NO%TYPE, I_ENRGRADE ENROL.ENR_GRADE%TYPE
)
IS
    O_COUNT NUMBER;
BEGIN
    IF I_ENRGRADE BETWEEN 0 AND 100 THEN
        UPDATE ENROL SET
            ENR_GRADE = I_ENRGRADE
        WHERE SUB_NO = I_SUBNO AND STU_NO = I_STUNO;
        O_COUNT := SQL%ROWCOUNT;
        IF O_COUNT = 0 THEN 
            DBMS_OUTPUT.PUT_LINE('정보를 다시 확인해주세요.');
        ELSIF O_COUNT = 1 THEN
            DBMS_OUTPUT.PUT_LINE('수정되었습니다.');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('2건 이상 수정되었습니다.');
        END IF;
    ELSE 
        DBMS_OUTPUT.PUT_LINE('점수의 범위는 0~100 입니다');
    END IF;
    COMMIT;
END;
/


-- STUDENT 테이블에 학번, 이름, 학과를 입력받아서 저장하는 프로시저
-- 학번은 8글자 아니면 에러 문구 출력
-- 프로시저 이름 : STUINSERT_PROC 
EXEC STUINSERT_PROC('1234', '김나리', '기계');
ROLLBACK;
SELECT * FROM STUDENT;

CREATE OR REPLACE PROCEDURE STUINSERT_PROC(
    I_STUNO STUDENT.STU_NO%TYPE, I_STUNAME STUDENT.STU_NAME%TYPE,I_STUDEPT STUDENT.STU_DEPT%TYPE
)
IS

BEGIN
    IF LENGTH(I_STUNO) != 8 THEN
        DBMS_OUTPUT.PUT_LINE('8글자로 학번을 입력해주세요.');
        RAISE_APPLICATION_ERROR(-20001, '학번은 8글자!');
        -- 에러 출력, 에러 만나면 바로 끝나버림. 에러출력하고.
        -- 그래서 INSERT를 ELSEIF로 처리할 필요가 없음.
        -- 우리가 정할 수 있는 오류 숫자 범위는 20001~20999까지임.
        -- -는 그냥 규칙
    END IF;
    INSERT INTO STUDENT(STU_NO, STU_NAME, STU_DEPT)
    VALUES (I_STUNO, I_STUNAME, I_STUDEPT);

--    COMMIT;
END;
/
