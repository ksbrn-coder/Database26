# LMS에 대한 테이블을 생성하고 더미데이터 입력 (CRUD)

SHOW databases; # LMS만 보인다.

USE LMS; # LMS 데이터베이스를 사용하겠다.


CREATE TABLE members (	# members 테이블 생성
#		필드명	  타입   옵션
		id		  INT AUTO_INCREMENT PRIMARY KEY,
#				  정수   자동 번호 생성기  기본 키(다른 테이블과 연결용)
		uid 	  VARCHAR(50) NOT NULL UNIQUE,
#				  가변문자(50자) 공백 비허용 유일한 값
		password  VARCHAR(255) NOT NULL,
        name	  VARCHAR(50) NOT NULL,
        role	  ENUM('admin', 'manager', 'user') DEFAULT 'user',
#				   열거타입(괄호 안에 글자만 허용)          기본값은 user
        active	  BOOLEAN DEFAULT TRUE,
#				  불린타입           기본값
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
# 		생성일		날짜 / 시간 타입	기본값은 시스템 시간
);


# 더미데이터 입력
INSERT INTO members (uid, password, name, role, active)
VALUES ('kkw','1234','김기원','admin',true);
INSERT INTO members (uid, password, name, role, active)
VALUES ('lhj','5678','임효정','manager',true);
INSERT INTO members (uid, password, name, role, active)
VALUES ('kdg','1111','김도균','user',true);
INSERT INTO members (uid, password, name, role, active)
VALUES ('ksb','2222','김수빈','user',true);
INSERT INTO members (uid, password, name, role, active)
VALUES ('kjy','3333','김지영','user',true); # 여러 개 추가 시 ctrl+shift+enter


# 더미데이터 출력
SELECT * FROM members; # 전체 출력

# 로그인할 때 
SELECT * FROM members where uid='kkw' and password='1234' and active=true;

# 더미데이터 수정
UPDATE members set password = '1111' WHERE uid = 'kkw';

# 회원 삭제
DELETE FROM members WHERE uid = 'kkw';
UPDATE members set active = false WHERE uid = 'kkw'; # 회원 비활성화
SELECT * FROM members;
