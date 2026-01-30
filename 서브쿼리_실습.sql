# ------- 서브 쿼리에 대해서
# 서브 쿼리 : 쿼리 안에 포함되어 있는 또 다른 쿼리 
# 서브 쿼리는 조인하지 않은 상태에서 다른 테이블과 일치하는 행을 찾거나, 조인 결과를 다시 조인할 때 사용할 수 있다.

# 서브 쿼리의 특징
# 1. 서브 쿼리는 반드시 소괄호로 감싸 사용함
# 2. 서브 쿼리는 주 쿼리를 실행하기 전에 1번만 실행됨
# 3. 비교 연산자와 함께 서브 쿼리를 사용하는 경우 서브 쿼리를 연산자 오른쪽에 기술해야 함
# 4. 서브 쿼리 내부에는 정렬 구문인 ORDER BY 절을 사용할 수 없음

-- 단일 행 서브 쿼리 사용하기
# SELECT [열]
# FROM [테이블] 
# WHERE [열] = (SELECT [열] FROM [테이블])

# 단일 행 서브 쿼리 적용
SELECT * FROM customer
WHERE customer_id = (SELECT customer_id FROM customer WHERE first_name = 'ROSA');

-- 다중 행 서브 쿼리 사용하기
# SELECT [열]
# FROM [테이블]
# WHERE [열] IN (SELECT [열] FROM [테이블])

# 다중 행 서브 쿼리 적용 (IN 활용) (1) 
SELECT * FROM customer
WHERE first_name IN ('ROSA', 'ANA');

# 다중 행 서브 쿼리 적용 (IN 활용) (2)
select * FROM customer
where customer_id in (select customer_id from customer where first_name in ('ROSA', 'ANA'));

# 테이블 3개를 조인하는 쿼리
select
	a.film_id, a.title
FROM film AS a
	INNER JOIN film_category AS b ON a.film_id = b.film_id
    INNER JOIN category AS c ON b.category_id = c.category_id
WHERE c.name = 'Action';

# IN을 활용한 서브 쿼리 적용
SELECT 
	film_id, title
FROM film
where film_id in (
	SELECT a.film_id 
    FROM film_category AS a
		INNER join category AS b on a.category_id = b.category_id
	WHERE b.name = 'Action');
    
# NOT IN 을 활용한 서브 쿼리 적용
SELECT
	film_id, title
FROM film
WHERE film_id NOT IN (
	SELECT a.film_id
    FROM film_category AS a
		INNER JOIN category AS b ON a.category_id = b.category_id
	WHERE b.name = 'Action');
    
# = ANY를 활용한 서브 쿼리 적용 
SELECT * FROM customer
WHERE customer_id = ANY (SELECT customer_id FROM customer where first_name in ('ROSA', 'ANA'));

# < ANY 를 활용한 서브 쿼리 적용
SELECT * FROM customer
WHERE customer_id < ANY (SELECT customer_id FROM customer WHERE first_name IN ('ROSA', 'ANA'));

# > ANY 를 활용한 서브 쿼리 적용
SELECT * FROM customer
WHERE customer_id > ANY (SELECT customer_id FROM customer WHERE first_name IN ('ROSA', 'ANA'));

# EXISTS 를 활용한 서브 쿼리 적용 : TRUE를 반환하는 경우
SELECT * FROM customer 
WHERE EXISTS (SELECT customer_id FROM customer WHERE first_name IN ('ROSA', 'ANA'));

# FALSE를 반환하는 경우 -> 주 쿼리를 실행하지 않으며, 아무것도 나타나지 않음
SELECT * FROM customer 
WHERE EXISTS (SELECT customer_id FROM customer WHERE first_name IN ('KANG'));

# NOT EXISTS를 활용한 서브 쿼리 적용 : TRUE를 반환하는 경우
SELECT * FROM customer 
WHERE NOT EXISTS (SELECT customer_id FROM customer WHERE first_name IN ('KANG'));
# WHERE 절에 사용된 서브 쿼리에 결과값이 없기 때문에, 반대인 TRUE로 판단되어 주 쿼리가 실행되고 customer 테이블 전체가 출력된 것을 확인할 수 있다. 

# ALL을 활용한 서브 쿼리 적용
SELECT * FROM customer
WHERE customer_id = ALL (SELECT customer_id FROM customer WHERE first_name IN ('ROSA', 'ANA'));
# ALL : 서브 쿼리 결괏값에 있는 모든 값을 만족하는 조건을 주 쿼리에서 검색하여 결과를 반환한다.
# 서브 쿼리의 결괏값 모두를 만족하는 결과가 주 쿼리 결괏값에 없으므로, 아무것도 나오지 않음

# FROM 절에 서브 쿼리 사용하기 
# FROM 절에 사용한 서브 쿼리 결과는 테이블처럼 사용되어, 다른 테이블과 다시 조인할 수 있음
# -> 쿼리를 논리적으로 격리할 수 있다.
# SELECT
#	[열]
# FROM [테이블] AS a
# 	INNER JOIN (SELECT [열] FROM [테이블] WHERE [열] = [값]) AS b ON [a.열] = [b.열]
# WHERE [열] = [값] 

# 테이블 조인 
select
	a.film_id, a.title, a.special_features, c.name
from film AS a
	inner join film_category as b on a.film_id = b.film_id
    inner join category as c on b.category_id = c.category_id
where a.film_id > 10 and a.film_id < 20;

# FROM 절에서 서브 쿼리 사용
select 
	a.film_id, a.title, a.special_features, x.name
from film as a
	inner join ( 
    select
		b.film_id, c.name
	from film_category as b
		inner join category as c on b.category_id = c.category_id
	where b.film_id > 10 and b.film_id < 20) as x on a.film_id = x.film_id;
    
# SELECT 절에 서브 쿼리 사용하기
# 스칼라 서브 쿼리의 기본 형식
# SELECT 
#	[열], (SELECT <집계 함수> [열] FROM [테이블 2]
# 	WHERE [테이블 2.열] = [테이블 1.열]) AS a
# FROM [테이블 1]
# WHERE [조건]

# 테이블 조인
SELECT
	a.film_id, a.title, a.special_features, c.name
FROM film AS a
	INNER JOIN film_category AS b ON a.film_id = b.film_id
	INNER JOIN category AS c ON b.category_id = c.category_id
WHERE a.film_id > 10 AND a.film_id < 20;

# SELECT 절에 서브 쿼리 적용 
SELECT 
	a.film_id, a.title, a.special_features, (SELECT c.name FROM film_category as b INNER JOIN category AS c ON b.category_id = c.category_id WHERE a.film_id = b.film_id) AS name
FROM film AS a
WHERE a.film_id > 10 AND a.film_id < 20;