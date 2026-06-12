-- ============================================================
--  Day 03 예제 정답 (5문제)
--  주제: 집계 함수 / 서브쿼리 / 집합 연산자 / 계층형 질의
--  데이터베이스: classicmodels.db
--  참고 강의: Day03_lecture.sql
-- ============================================================
--
--  classicmodels DB 테이블 (8개)
--  ┌─────────────────┬──────────────────────────────────────┐
--  │ 테이블           │ 설명                                  │
--  ├─────────────────┼──────────────────────────────────────┤
--  │ productlines    │ 제품 라인                              │
--  │ products        │ 제품 (productLine FK)                 │
--  │ offices         │ 지사                                   │
--  │ employees       │ 직원 (reportsTo → 계층형 구조)         │
--  │ customers       │ 고객 (salesRepEmployeeNumber FK)      │
--  │ orders          │ 주문 헤더                              │
--  │ orderdetails    │ 주문 상세                              │
--  │ payments        │ 결제 내역                              │
--  └─────────────────┴──────────────────────────────────────┘
-- ============================================================


-- ============================================================
-- 문제 1. [집계 함수 + HAVING]
-- 제품 라인(productLine)별 제품 수를 구하고,
-- 제품이 10개 이상인 라인만 제품 수 내림차순으로 보여주세요.
-- 조회할 필드명: productLine, 제품수
-- 테이블: products
-- ============================================================

SELECT productLine, COUNT(*) AS 제품수
FROM products
GROUP BY productLine
HAVING 제품수 >= 10
ORDER BY 2 DESC
;


-- ============================================================
-- 문제 2. [WHERE 절 서브쿼리]
-- 전체 제품의 평균 MSRP보다 비싼 제품의
-- productCode, productName, MSRP를 MSRP 내림차순으로 조회하세요.
-- 조회할 필드명: productCode, productName, MSRP
-- 테이블: products
-- ============================================================

-- 메인쿼리 : productCode, productName, MSRP를 MSRP 내림차순으로 조회
SELECT productCode, productName, MSRP
FROM products
WHERE MSRP > ()
ORDER BY MSRP DESC
;
-- 서브쿼리 : 전체 제품의 평균 MSRP 조회
SELECT AVG(MSRP) FROM products;

-- 합치기 
SELECT productCode, productName, MSRP
FROM products
WHERE MSRP > (SELECT AVG(MSRP) FROM products)
ORDER BY MSRP DESC
;


-- ============================================================
-- 문제 3. [JOIN]
-- 주문(orders)한 적이 없는 고객을 고객번호, 고객명 순으로 조회하는 시나리오:
-- 내부 조인을 사용하지 않고, LEFT JOIN을 활용하여 orders 테이블에 존재하지 않는 고객을 찾으세요.
-- LEFT JOIN문 사용
-- 조회할 필드명: customerNumber, customerName
-- 테이블: customers, orders
-- ============================================================

SELECT c.customerNumber, c.customerName
FROM customers c
LEFT JOIN orders o
    ON c.customerNumber = o.customerNumber
WHERE o.orderNumber IS NULL
;


-- ============================================================
-- 문제 4. [INTERSECT + JOIN]
-- 2003년과 2004년 모두 주문한 고객의 customerNumber와 고객명을
-- customerNumber 오름차순으로 조회하세요. (customers 테이블 JOIN)
-- 조회할 필드명: customerNumber, customerName, country, city
-- 테이블: customers, orders
-- ============================================================

-- 1. 구해야 할 필드명을 정리
SELECT customerNumber, customerName, country, city
FROM customers;

-- 2. 2003년과 2004년 모두 주문한 고객의 customerNumber 조회
--      먼저 2003년 주문한 고객을 조회하는 쿼리를 만들고
--      2004년을 주문한 고객을 조회하는 쿼리를 만든 뒤,
--      INTERSECT로 연결
SELECT customerNumber
FROM orders
WHERE strftime('%Y', orderDate) = '2003'
INTERSECT
SELECT customerNumber
FROM orders
WHERE strftime('%Y', orderDate) = '2004'
;

-- 3. 2번에서 구한 customerNumber로 고객 정보를 조회해야 하므로,
--    1번에서 작성한 쿼리와 JOIN으로 연결
--      2번 쿼리의 결과가 하나의 테이블이므로,
--      2번 쿼리 결과 테이블과 customers 테이블을 JOIN
--          JOIN문 괄호 안에 2번에서 작성한 쿼리 넣기
--    JOIN문 전체에 별칭 부여
--    customerNumber로 두 테이블 연결


SELECT c.customerNumber,
       c.customerName,
       c.country,
       c.city
FROM customers c
JOIN (
    SELECT customerNumber
    FROM orders
    WHERE strftime('%Y', orderDate) = '2003'
    INTERSECT
    SELECT customerNumber
    FROM orders
    WHERE strftime('%Y', orderDate) = '2004'
) o
ON c.customerNumber = o.customerNumber
ORDER BY c.customerNumber
;


-- ============================================================
-- 문제 5. [복합 활용: JOIN, Subquery, UNION]
-- 1) 2004년에 주문한 적이 있는 고객 중,
--    미국(USA) 또는 프랑스(France) 국적 고객의 고객번호, 이름, 국가, 도시, 주문 개수(orderCount)를 조회하세요.
--    (1) 미국 고객과 프랑스 고객은 각각 별도의 쿼리(서브쿼리)에서 추출하여, UNION을 사용해 합칩니다.
--    (2) 각 쿼리에서는 JOIN, 서브쿼리를 자유롭게 활용해 주문 개수도 함께 반환하세요.
--    (3) 결과는 국가(country), 고객번호(customerNumber) 오름차순 정렬입니다.
--    필드: customerNumber, customerName, country, city, orderCount
-- 테이블: customers, orders
-- ============================================================
-- [메인 쿼리] 미국 또는 프랑스 국적 고객 중 2004년에 주문한 적이 있는 고객들의 정보를 조회
SELECT 
FROM (
    -- [서브쿼리1] 미국 고객 중 2004년에 주문한 고객
    SELECT 
           (
               -- [서브쿼리1-1] 해당 고객의 2004년 주문 개수
               
           ) AS orderCount
    

    UNION

    -- [서브쿼리2] 프랑스 고객 중 2004년에 주문한 고객
    SELECT 
           (
               -- [서브쿼리2-1] 해당 고객의 2004년 주문 개수
               
           ) AS orderCount
    
)
ORDER BY 


-- 메인쿼리 : customerNumber, customerName, country, city, orderCount 조회
-- 서브쿼리
---- 서브쿼리 1 : 미국 고객 중 2004년에 주문한 고객
---- 서브쿼리 2 : 프랑스 고객 중 2004년에 주문한 고객
-- 분할하고 합치기


SELECT
    c. customerNumber
    , c.customerName
    , c.country
    , c.city
    , COUNT(*) AS orderCount
FROM customers c
INNER JOIN orders o
    ON c.customerNumber = o.customerNumber
WHERE c.country = 'USA'
    AND strftime('%Y', o.orderDate) = '2004'
GROUP BY c.customerNumber

UNION

SELECT
    c. customerNumber
    , c.customerName
    , c.country
    , c.city
    , COUNT(*) AS orderCount
FROM customers c
INNER JOIN orders o
    ON c.customerNumber = o.customerNumber
WHERE c.country = 'France'
    AND strftime('%Y', o.orderDate) = '2004'
GROUP BY c.customerNumber
;


SELECT customerNumber,
       customerName,
       country,
       city,
       orderCount
FROM (
    -- 미국 고객 중 2004년에 주문한 고객
    SELECT c.customerNumber,
           c.customerName,
           c.country,
           c.city,
           (SELECT COUNT(*) FROM orders o WHERE o.customerNumber = c.customerNumber AND strftime('%Y', o.orderDate) = '2004') AS orderCount
    FROM customers c
    JOIN orders o ON c.customerNumber = o.customerNumber
    WHERE c.country = 'USA'
      AND strftime('%Y', o.orderDate) = '2004'
    GROUP BY c.customerNumber
    UNION
    -- 프랑스 고객 중 2004년에 주문한 고객
    SELECT c.customerNumber,
           c.customerName,
           c.country,
           c.city,
           (SELECT COUNT(*) FROM orders o WHERE o.customerNumber = c.customerNumber AND strftime('%Y', o.orderDate) = '2004') AS orderCount
    FROM customers c
    JOIN orders o ON c.customerNumber = o.customerNumber
    WHERE c.country = 'France'
      AND strftime('%Y', o.orderDate) = '2004'
    GROUP BY c.customerNumber
)
ORDER BY country, customerNumber;