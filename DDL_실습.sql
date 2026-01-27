use	doitsql;

create table doit_create_table (
col_1 INT,
col_2 VARCHAR(50),
col_3 DATETIME
); # CREATE 문으로 테이블 생성

drop table doit_create_table; # DROP 문으로 테이블 삭제

# --------

create table doit_dml ( # doit_dml 테이블 생성 시 <<
col_1 INT,
col_2 VARCHAR(50),
col_3 DATETIME
);

insert into doit_dml (col_1, col_2, col_3) values (1, 'doitsql', '2023-01-01'); # INSERT 문으로 데이터 삽입
select * from doit_dml; # SELECT 문을 사용하여 데이터 조회

# --------

insert into doit_dml values (2, '열 이름 생략', '2023-01-02'); # 열 이름 생략 예시 / (col_1, col_2, col_3) < 생략
select * from doit_dml; # SELECT 문을 사용하여 데이터 조회

insert into doit_dml values (3, 'col_3 값 생략'); # 테이블의 열 개수와 입력값이 일치하지 않아 오류 발생!

# --------

insert into doit_dml (col_1, col_2) values (3, 'col_3 값 생략');
select * from doit_dml; # col_1, col_2 열에만 데이터를 삽입하려면 -> 테이블 이름 다음에 삽입하고자 하는 열만 소괄호 안에 나열하면 됨

# --------
# 삽입하려는 데이터의 순서를 바꿀 수도 있음
insert into doit_dml (col_1, col_3, col_2) values (4, '2021-01-03', '열순서 변경');
select * from doit_dml; # 데이터 순서를 바꿨어도 테이블에는 바르게 입력됨

# 여러 데이터 한 번에 삽입
insert into doit_dml (col_1, col_2, col_3)
values (5, '데이터 입력5', '2023-01-03'), (6, '데이터 입력6', '2023-01-03'), (7,'데이터 입력7', '2023-01-03');
select * from doit_dml; # 데이터 3개 삽입 확인

# UPDATE 문으로 데이터 수정하기

UPDATE doit_dml SET col_2 = '데이터 수정'
WHERE col_1 = 4; # 키 값을 사용하지 않고 데이터를 수정하거나 삭제할 때 이를 방지하도록 안전 장치가 발동됨 (Error code : 1175)
select * from doit_dml; # 안전 모드 비활성화 시 4번 란 수정 제대로 작동됨

update doit_dml set col_1 = col_1 + 10; # update 문으로 테이블 전체 데이터 수정
select * from doit_dml; # col_1 부분이 11(1+10)부터 시작되는 것 확인 

DELETE from doit_dml where col_1 = 14;  # delete 문으로 데이터 수정 (14인 데이터만 삭제)
select * from doit_dml;

delete from doit_dml; # where 절 없이 delete를 입력하면 전체 데이터를 삭제할 수 있음
select * from doit_dml; # 대량의 데이터를 삭제할 경우 truncate 문을 사용하여 삭제 (단, 롤백 불가)
