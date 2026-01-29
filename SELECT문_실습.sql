select first_name from customer; # select [열] from [테이블];

select first_name, last_name from customer; # 2개 이상의 열을 조회할 때 / select [열], [열] from [테이블];

select * from customer; # 전체 열 조회할 때 / select * from [테이블];
# 이때 전체 열 조회는 자원을 많이 소비하므로 주의할 것 (최소한으로만 조회하는 습관 들이기)

# 데이터르 조회할 때 -> 테이블에 무슨 열이 있는지 확인하고 싶은 경우, [Schemas] 탭에서 테이블을 확장하면 열의 정보를 확인할 수 있음

show columns from sakila.customer; # 테이블의 열의 정보를 조회할 때 / show columns from [경로.테이블]

select * from customer where first_name = 'Maria'; # where 절, = 연산자로 특정값 조회 
#			   [테이블]			[열]		  [데이터]

# where 절에서는 비교 연산자를 사용할 수 있음 (단, 크기를 비교하는 연산자는 숫자에만 사용할 것)

select * from customer where address_id = 200; # address_id 열의 데이터가 '200'에 해당하는 것만
select * from customer where address_id < 200; # '200' 미만에 해당하는 것만 
select * from customer where first_name = 'MARIA'; # first_name 열의 데이터가 MARIA인 행만
select * from customer where first_name < 'MARIA'; # A, B, C, 순으로 MARIA보다 앞에 위치한 행만
select * from payment where payment_date = '2005-07-09 13:24:07'; # payment_date가 2005-07-09 13:24:07인 행만
select * from payment where payment_date < '2005-07-09'; # payment_date가 2005년 7월 9일 미만인 행만
SELECT * FROM payment WHERE payment_date = '2005-07-08 07:33:56'; # 시간을 포함해 정확한 날짜형 데이터를 조건값으로 사용할 경우
SELECT * FROM customer WHERE first_name BETWEEN 'M' AND 'O'; # first_name 열에서 M과 O 사이의 데이터를 조회
SELECT * FROM customer WHERE first_name NOT BETWEEN 'M' AND 'O';  # BETWEEN을 사용하되, 범위를 포함하지 않은 데이터를 조회 
SELECT * FROM city WHERE city = 'Sunnyvale' AND country_id = 103; # 두 조건을 만족하는 데이터를 조회
SELECT * FROM payment WHERE payment_date >= '2005-06-01' AND payment_date <= '2005-07-05'; # 두 개의 비교 연산식을 만족하는 데이터를 조회
SELECT * FROM customer WHERE first_name = 'MARIA' OR first_name = 'LINDA'; # 둘 중 한 조건이라도 만족하는 데이터를 조회
SELECT * FROM customer WHERE first_name = 'MARIA' OR first_name = 'LINDA' OR first_name = 'NANCY'; # or를 2개 이상 사용한 경우
# 이런 경우에는 OR 보다 IN을 사용
SELECT * FROM customer WHERE first_name in ('MARIA', 'LINDA', 'NANCY'); # in 활용

# -------- AND, OR, IN 을 조합하여 데이터 조회 --------

SELECT * FROM city WHERE country_id = 103 or country_id = 86 and city in ('Cheju','Sunnyvale','Dallas');
# 			테이블에서			열이		103	 또는		열이		86  이면서  열이			인 데이터
# OR이 AND보다 높게 처리되어 데이터가 합쳐져서 조회된 것 => 원하는대로 결과를 도출하려면 소괄호를 이용해야 함 
SELECT * FROM city WHERE (country_id = 103 or country_id = 86) AND city IN ('Cheju', 'Sunnyvale', 'Dallas');
# country_id 열과 관려된 조건도 IN으로 묶은 다음 작성해도 앞선 실습과 같은 결과를 얻을 수 있음
SELECT * FROM city WHERE country_id IN (103, 86) AND city IN ('Cheju', 'Sunnyvale', 'Dallas');

# ------- NULL 데이터 조회 -------------
# NULL = 데이터가 없는 상태 (숫자 0, 공백이 아닌, 아예 정의되지 않는 값)

SELECT * FROM address WHERE address2 = NULL;
# NULL은 정의되지 않은 값이므로, 일반적인 연산자로는 조회할 수 없음 

SELECT * FROM address WHERE address2 IS NULL; # IS NULL을 사용해 데이터 조회
# 반대로, NULL이 아닌 데이터를 조회할 때도 일반 연산자가 아닌 IS NOT NULL을 사용해 데이터를 조회함 
SELECT * FROM address WHERE address2 IS NOT NULL;
# 공백의 경우 NULL이 아니므로 연산자로 조회 가능 (단, 공백은 ''로 표현)
SELECT * FROM address WHERE address2 = '';

# ---------- ORDER BY 절로 데이터 정렬 -----------

# 조회한 데이터를 정렬하기 위해서는 ORDER BY 절을 사용해야 함
# SELECT [열] FROM [테이블] WHERE [열] = [조건값] ORDER BY [열] [ASC(오름차순) 또는 DESC(내림차순)]
# SELECT 문의 가장 마지막에 추가하여 사용
 
 # 정렬 시 ORDER BY 절 뒤에 정렬할 열 이름 입력
 
 SELECT * FROM customer ORDER BY first_name;
 SELECT * FROM customer ORDER BY last_name;
 
 # 2개 이상의 열을 기준으로 정렬할 때 = 쉼표 사용
 # 열 입력 순서에 주의할 것!!

SELECT * FROM customer ORDER BY store_id, first_name;
# store_id 열을 기준으로 먼저 정리한 다음, store_id 열에 같은 값이 있는 경우 first_name 열을 기준으로 정렬
SELECT * FROM customer ORDER BY first_name, store_id;
# 정렬 순서가 다르므로, 결과도 다르게 표시됨 

# 오름차순 정렬
SELECT * FROM customer ORDER BY first_name ASC;
# 내림차순 정렬
SELECT * FROM customer ORDER BY first_name DESC;

# 오름차순과 내림차순을 조합하여 데이터 정렬
SELECT * FROM customer ORDER BY store_id DESC, first_name ASC;

# LIMIT로 상위 데이터 조회하기
# 특정 조건에 해당하는 데이터 중 상위 N개의 데이터만 보고 싶은 경우, SELECT 문에 LIMIT을 조합하면 됨 
# LIMIT의 경우 상위 N개의 데이터를 반환하므로, 정렬 우선순위가 매우 중요함

SELECT * FROM customer ORDER BY store_id DESC, first_name ASC LIMIT 10;
#								내림차순 			      오름차순  상위 10개 조회
# 상위 n개의 데이터를 조회할 때는 ORDER BY 절을 사용하는 것이 좋음 (정렬하지 않으면 어떤 값이 기준이 되는지 알 수 없기 때문)

# 101번째부터 10개의 데이터 조회
SELECT * FROM customer ORDER BY customer_id ASC LIMIT 100, 10;

# 데이터 100개 건너뛰고 101번째부터 데이터 10개 조회
SELECT * FROM customer ORDER BY customer_id ASC LIMIT 10 OFFSET 100;

# -------- 와일드카드로 문자열 조회하기 -----------

# LIKE : 와일드카드로 지정한 패턴과 일치하는 문자열, 날짜, 시간 등을 조회
# SELECT [열] FROM [테이블] WHERE [열] LIKE [조건값]

# 특정 문자열을 포함하는 문자열을 조회할 때 % 을 사용 
# A% : A로 시작하는 모든 문자열
# %A : A로 끝나는 모든 문자열
# %A% : A가 포함된 모든 문자열

SELECT * FROM customer WHERE first_name LIKE 'A%';
SELECT * FROM customer WHERE first_name LIKE 'AA%';
SELECT * FROM customer WHERE first_name LIKE '%A';

SELECT * FROM customer WHERE first_name LIKE '%RA';
SELECT * FROM customer WHERE first_name LIKE '%A%';
SELECT * FROM customer WHERE first_name NOT LIKE '%A';
# 특정 문자열을 제외해 데이터를 조합하고 싶다면 NOT 을 조합하면 됨
# NOT LIE %A -> A로 시작하는 문자열을 제외한 first_name 열의 데이터를 조회

# ------- ESCAPE 로 특수 문자를 포함한 데이터 조회하기 -------
# 특수문자 % 을 포함한 데이터를 검색하고 싶을 때 -> ESCAPE를 사용

WITH CTE (col_1) AS (
SELECT 'A%BC' UNION ALL 
SELECT 'A_BC' UNION ALL
SELECT 'ABC'
)

SELECT * FROM CTE;

# 이 테이블에서 특수문자 % 가 들어간 데이터 조회

WITH CTE (col_1) AS (
SELECT 'A%BC' UNION ALL
SELECT 'A_BC' UNION ALL
SELECT 'ABC'
)

SELECT * FROM CTE WHERE col_1 LIKE '%#%%' ESCAPE '#';
# ESCAPE가 #을 제거하여 실행 시 %%%로 해석 -> % 를 포함하는 앞뒤 어떠한 문자가 와도 상관없는 데이터로 검색됨 
# ESCAPE는 % 외에도 & ! / 등도 사용 가능, 단 해당 문자가 데이터에 쓰이지 않는 것이어야 함

WITH CTE (col_1) AS (
SELECT 'A%BC' UNION ALL
SELECT 'A_BC' UNION ALL
SELECT 'ABC' 
)
SELECT * FROM CTE WHERE col_1 LIKE '%!%%' ESCAPE '!';


# ------- LIKE와 _로 길이가 정해진 데이터 조회

# A_ : A로 시작하면서 뒤의 글자는 무엇이든 상관없으며 전체 글자 수는 2개인 문자열
# _A : A로 끝나면서 앞의 문자는 무엇이든 상관없으며 전체 글자 수는 2개인 문자열
# _A_ : 세 글자로 된 문자열 중 가운데 글자만 A이며 앞뒤로는 무엇이든 상관없는 문자열

SELECT * FROM customer WHERE first_name LIKE 'A_';
SELECT * FROM customer WHERE first_name LIKE 'A__';
SELECT * FROM customer WHERE first_name LIKE '__A';
SELECT * FROM customer WHERE first_name LIKE 'A__A';
SELECT * FROM customer WHERE first_name LIKE '_____'; # 5글자 이름을 찾는 경우

# _과 %로 문자열 조회하기
# 특정 문자열을 포함하고, 길이가 정해진 데이터를 조회하려면 _과 %를 조합하여 사용하면 됨

SELECT * FROM customer WHERE first_name LIKE 'A_R%';
# A와 R 사이에 한 글자를 포함하여 시작하면서, 이후 문자열은 어떤 문자열이어도 상관없는 데이터 조회

SELECT * FROM customer WHERE first_name LIKE '__R%';
# R 앞에 두 글자를 포함하여 시작하면서, 이후 문자열은 어떤 문자열이어도 상관없는 데이터 조회

SELECT * FROM customer WHERE first_name LIKE 'A%R_';
# A로 시작하고, 마지막은 R과 함께 마지막 한 글자가 더 있는 문자열 데이터 조회

# MySQL의 정규 표현식
# . : 줄바꿈 문자를 제외한 임의의 한 문자
# * : 해당 문자 패턴이 0번 이상 반복
# + : 해당 문자 패턴이 1번 이상 반복
# ^ : 문자열의 처음 
# $ : 문자열의 끝
# [...] : 대괄호 [] 안에 있는 문자
# [^...] : 대괄호 [] 안에 있지 않은 문자 
# {n} : 반복되는 횟수 지정
# {m,n} : 반복되는 횟수의 최솟값과 최댓값 지정

SELECT * FROM customer WHERE first_name REGEXP '^K|N$';
# first_name 열에서 K로 시작하거나 N으로 끝나는 데이터 조회

SELECT * FROM customer WHERE first_name REGEXP 'K[L-N]'; 
# first_name 열에서 K와 함께 L과 N 사이의 글자를 포함한 데이터 조회

SELECT * FROM customer WHERE first_name REGEXP 'K[^L-N]';
# K와 함께 L과 N 사이의 글자를 포함하지 않는 데이터 조회

SELECT * FROM customer WHERE first_name LIKE 'S%' AND first_name REGEXP 'A[L-N]';
# S로 시작하는 문자열 데이터 중에 A 뒤에 L과 N 사이의 글자가 있는 데이터 조회

SELECT * FROM customer WHERE first_name LIKE '_______' AND first_name REGEXP 'A[L-N]' AND first_name REGEXP 'O$';
# first_name 열에서 총 7 글자 / 뒤에 L과 N 사이의 글자가 있고 / 마지막 글자는 O인 문자열 데이터 조회

# -------- GROUP BY 절로 데이터 묶기 -------
# 데이터를 그룹화할 때 GROUP BY 절 사용
# 데이터 그룹을 필터링할 때는 HAVING 절 사용
# GROUP BY : SELECT [열] FROM [테이블] WHERE [열] = [조건값] GROUP BY [열] HAVING [열] = [조건값] 
#													        그룹화된 데이터 where   필터링을 위한 조건값

SELECT special_features FROM film GROUP BY special_features;
# special_features 열의 데이터를 그룹화 

SELECT rating FROM film GROUP BY rating;
# rating 열의 데이터를 그룹화 

# GROUP BY 사용 시 열을 순서대로 작성하면 그 순서대로 데이터를 그룹화함
# 즉, 2개 이상의 열을 기준으로 그룹화할 수 있음

SELECT special_features, rating FROM film GROUP BY special_features, rating;
# special_features, rating 열 순서대로 그룹화

SELECT rating, special_features FROM film GROUP BY special_features, rating;
# 열 순서를 변경하는 것도 가능 -> 모두 같은 개수의 데이터를 출력함

# ------ COUNT -------
# COUNT : 각 데이터 그룹에 몇 개의 데이터가 있는지 세어볼 수 있음 

SELECT special_features, COUNT(*) AS cnt FROM film GROUP BY special_features;
# COUNT 함수로 그룹에 속한 데이터 개수 세기

SELECT special_features, rating, COUNT(*) AS cnt FROM film GROUP BY special_features, rating ORDER BY special_features, rating, cnt DESC;


