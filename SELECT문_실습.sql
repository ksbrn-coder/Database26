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
select * from payment where payment_date < '2005-07-09'; # payment_date거 2005년 7월 9일 미만인 행만
