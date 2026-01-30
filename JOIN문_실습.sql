# INNER JOIN - 내부 조인, 두 조건에 모두 맞는 열을 조회할 수 있다.

# SELECT [열] 
# FROM [테이블 1]
#	 INNER JOIN [테이블 2] ON [테이블 1.열] = [테이블 2.열]
# WHERE [검색 조건]

# 실제 쿼리를 작성할 때는 SELECT 문에 조인할 테이블의 열을 나열하면 됨 

SELECT
	a.customer_id, a.store_id, a.first_name, a.last_name, a.email, a.address_id
AS a_address_id,
	b.address_id AS b_address_id, b.address, b.district, b.city_id, b.postal_code, b.phone, b.location
FROM customer AS a  -- FROM : 조인할 테이블 이름을 입력 / 테이블 이름을 나열할 때 AS 활용
	INNER JOIN address AS b ON a.address_id = b.address_id -- ON : 테이블을 조인할 때, 조인키라고 하는 조인 조건으로 사용할 열을 지정
WHERE a.first_name = 'ROSA';
# 조인할 두 테이블에 이름이 같은 열이 있으므로, a.address_id, b.address_id 라는 각 테이블의 별칭을 붙여서 조회함 
# 구분하기 쉽도록 열 이름도 별칭을 사용해 a_address_id와 b_address_id를 입력하여 별칭 사용 

# ----- INNER JOIN에 조인 조건 2개 이상 사용하기
# AND, OR 등의 연산자를 활용하여 조합 가능
SELECT
	a.customer_id, a.first_name, a.last_name,
    b.address_id, b.address, b.district, b.postal_code
FROM customer AS a
	INNER join address AS b ON a.address_id = b.address_id AND a.create_date = b.last_update
WHERE a.first_name = 'ROSA';
# 조인 조건으로 열이 달라도 상관없음 -> 무조건 열 이름이 같을 필요는 없다. (다만 비교를 위해 데이터 유형이 같아야 할 뿐)

# ----- INNER JOIN에 조인 조건 3개 이상 사용하기
# SELECT [열]
# FROM [테이블 1]
# 	INNER JOIN [테이블 2] ON [테이블 1.열] = [테이블 2.열]
#	INNER JOIN [테이블 3] ON [테이블 2.열] = [테이블 3.열]
# WHERE [검색 조건]

SELECT 
	a.customer_id, a.first_name, a.last_name,
    b.address_id, b.address, b.district, b.postal_code,
    c.city_id, c.city
FROM customer AS a
	INNER JOIN address AS b ON a.address_id = b.address_id
    INNER JOIN CITY AS c ON b.city_id = c.city_id
WHERE a.first_name = 'ROSA';
# address_id 열은 customer 테이블과 address 테이블이 공통으로 가지고 있음
# city_id 열은 address 테이블과 city 테이블이 공통으로 가지고 있음
# 테이블 3개 이상 조인 시 공통된 열을 활용해 조인
# INNER JOIN은 조건에 맞는 데이터만 조회하므로, NULL이 발생하지 않음.

# OUTER JOIN - 외부 조인, 두 조건 중 한 테이블에 만 있는 데이터를 조회함
# SELECT 
#	[열]
# FROM [테이블 1]
# 	[LEFT | RIGHT | FULL] OUTER JOIN [테이블 2] ON [테이블 1.열] = [테이블 2.열] -- LEFT, RIGHT, FULL 중에서 1개만 선택해 사용
# WHERE [검색 조건]
# LEFT, RIGHT, FULL 중 한 옵션을 지정하여, 기준이 되는 테이블을 지정함 >> A 기준 B 테이블을 조인하고 싶다면 LEFT, B 기준 A 테이블을 조인하고 싶다면 RIGHT 사용

# ------ LEFT OUTER JOIN으로 외부 조인하기
SELECT
	a.address, a.address_id AS a_address_id,
    b.address_id AS b_address_id, b.store_id
FROM address AS a
	LEFT OUTER JOIN store AS b ON a.address_id = b.address_id;
# address 테이블을 기준으로 조인했기 때문에, store 테이블에 없는 address_id는 NULL 처리 

# LEFT(왼쪽) 기준 테이블에 있는 데이터만 추출하고 싶다면 : LEFT OUTER JOIN 결과에서 NULL이 있는 데이터만 골라내면 됨 
SELECT 
	a.address, a.address_id AS a_address_id,
    b.address_id AS b_address_id, b.store_id
FROM address AS a
	LEFT OUTER JOIN store AS b ON a.address_id = b.address_id
WHERE b.address_id IS NULL

# ------ RIGHT OUTER JOIN으로 외부 조인하기
SELECT 
	a.address, a.address_id AS a_address_id,
    b.address_id AS b_address_id, b.store_id
FROM address AS a
	RIGHT OUTER JOIN store AS b ON a.address_id = b.address_id;
    
# RIGHT(오른쪽) 기준 테이블에 있는 데이터만 추출하고 싶다면 : RIGHT OUTER JOIN 결과에서 NULL이 있는 데이터만 골라내면 됨 
SELECT
	a.address_id AS a_address_id, a.store_id,
    b.address, b.address_id AS b_address_id
FROM store AS a
	RIGHT OUTER JOIN address AS b ON a.address_id = b.address_id
WHERE a.address_id IS NULL;

# ------ FULL OUTER JOIN으로 외부 조인하기
# FULL : LEFT + RIGHT OUT JOIN을 합친 것
# 양쪽 테이블에서 일치하지 않는 행도 모두 조회함 => 조인 조건에 일치하지 않는 항목까지 모두 표시
# 가끔 데이터베이스 디자인이나, 데이터에 몇 가지 문제가 있어서 누락 / 오류를 찾아낼 때 사용

SELECT
	a.address_id AS a_address_id, a.store_id,
	b.address, b.address_id AS b_address_id
FROM store AS a
	LEFT OUTER JOIN address AS b ON a.address_id = b.address_id

UNION

SELECT
	a.address_id AS a_address_id, a.store_id,
	b.address, b.address_id AS b_address_id
FROM store AS a	
	RIGHT OUTER JOIN address AS b ON a.address_id = b.address_id;


# RIGHT, LEFT 테이블에 있는 데이터만 추출하려면 NULL 데이터를 조회하면 된다.

SELECT
    a.address_id AS a_address_id, a.store_id,
    b.address, b.address_id AS b_address_id
FROM store AS a
LEFT OUTER JOIN address AS b ON a.address_id = b.address_id

UNION

SELECT
    a.address_id AS a_address_id, a.store_id,
    b.address, b.address_id AS b_address_id
FROM store AS a
	RIGHT OUTER JOIN address AS b ON a.address_id = b.address_id
WHERE a.address_id IS NULL;SELECT
	a.address_id AS a_address_id, a.store_id,
	b.address, b.address_id AS b_address_id
FROM store AS a
	LEFT OUTER JOIN address AS b ON a.address_id = b.address_id
WHERE b.address_id IS NULL

UNION

SELECT
	a.address_id AS a_address_id, a.store_id,
	b.address, b.address_id AS b_address_id
FROM store AS a
	RIGHT OUTER JOIN address AS b ON a.address_id = b.address_id
WHERE a.address_id IS NULL;
# 교집합을 제외한 양쪽 테이블에만 있는 데이터를 조회한 결과

# ------ 교차 조인
# 각 테이블의 모든 경우의 수를 조합한 데이터가 필요할 경우, 교차 조인을 사용할 수 있음
# SELECT [열]
# FROM [테이블 1]
# 	CROSS JOIN [테이블 2]
# WHERE [검색 조건]

CREATE TABLE doit_cross1 (num INT);
CREATE TABLE doit_cross2 (name VARCHAR(10));
INSERT INTO doit_cross1 VALUES (1), (2), (3);
INSERT INTO doit_cross2 VALUES ('Do'), ('It'), ('SQL');

DROP TABLE doit_cross1;
DROP TABLE doit_cross2;

SELECT 
	a.num, b.name
FROM doit_cross1 AS a
	CROSS JOIN doit_cross2 AS b
ORDER BY a.num;

# num 열 값이 1인 것만 출력하고 싶을 때 : 
SELECT
	a.num, b.name
FROM doit_cross1 AS a
	CROSS JOIN doit_cross2 AS b
WHERE a.num = 1;

# ---- 셀프 조인
# 셀프 조인은 동일한 테이블을 사용하는 특수한 조인이다. 
# 셀프 조인은 별도의 구문이 없으나, 별칭을 사용하여 구분해야 함
# 소스는 하나의 테이블이지만, 2개의 테이블처럼 사용하기에 각 테이블에 다른 별칭을 붙여 조인해야 한다.

SELECT a.customer_id AS a_customer_id, b.customer_id AS b_customer_id
FROM customer AS a
	INNER JOIN customer AS b ON a.customer_id = b.customer_id;
	
SELECT 
	a.payment_id, a.amount, b.payment_id, b.amount, b.amount - a.amount AS profit_amount
FROM payment AS a
	LEFT OUTER JOIN payment AS b ON a.payment_id = b.payment_id -1;
