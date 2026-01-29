select @@hostname

-- 이 창은 메모장처럼 사용됨.
-- 스크립트를 1줄씩 실행하는 것이 기본임 (ctrl + enter)
-- 만약 더미데이터를 20개 입력한다!!! (블럭 설정 후 ctrl + shift + enter) addresscategory

use sakila; -- sakila 데이터베이스에 가서 사용할게! 
select * from actor; -- actor 테이블에 모든 값을 가져와~

use world; -- world 데이터베이서에 가서 사용할게!
select * from city; -- city 테이블에 모든 값을 가져와~