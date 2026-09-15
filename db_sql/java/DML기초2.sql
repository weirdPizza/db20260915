-- FRUIT 테이블 기준
-- 1. 오렌지, 1500원, 15개 데이터를 삽입(커밋)
-- 2. 가격이 1000원 이상인 과일 조회
-- 3. 오렌지 과일의 개수를 기존 개수 + 3개(커밋)
-- 4. 오렌지 과일을 삭제 (롤백)
INSERT INTO FRUIT
VALUES('오렌지', 1500, 15);

SELECT *
FROM FRUIT
WHERE PRICE >= 1000;

COMMIT;

UPDATE FRUIT SET
    CNT = CNT + 3
WHERE FRUIT_NAME = '오렌지';

DELETE FROM FRUIT WHERE FRUIT_NAME = '오렌지';

ROLLBACK;

SELECT * FROM FRUIT
ORDER BY PRICE DESC;