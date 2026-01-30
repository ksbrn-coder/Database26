# LMS에 대한 테이블을 생성하고 더미데이터 입력 (CRUD)

SHOW databases; # LMS만 보인다.

USE LMS; # LMS 데이터베이스를 사용하겠다.

DROP TABLE members; # 잘못 만들었을 경우 삭제

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

DROP TABLE scores;
CREATE TABLE scores (
	id		INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    korean	INT NOT NULL,
    english INT NOT NULL,
    math	INT NOT NULL,
    total	INT NOT NULL,
    average FLOAT NOT NULL,
    grade	CHAR(1) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (member_id) REFERENCES members(id)
    # 외래키 생성	내가 가진 필드와		연결		테이블  필드 
);

# 후보키 : 공백이 없고, 유일해야 되는 필드들 (학번, 주민번호, id, email.....)
# PRIMARY KEY는 기본 키로 공백이 없고, 유일해야 되고, 인덱싱이 되어 있는 옵션
# 인덱싱 : db에서 빠른 찾기를 위한 옵션
# 외래키(FOREIGN KEY) : 다른 테이블과 연결이 되는 키!!!! 
# 외래키는 자식이고 기본키는 부모
# members가 부모이므로, kkw 계정이 있어야 scores 테이블에 kkw 점수를 넣을 수 있다.
# members 테이블의 id와 scores 테이블의 member_id는 타입이 일치 필수

INSERT INTO scores (member_id, korean, english, math, total, average, grade)
VALUES (1, 99, 99, 99, 297, 99, 'A');
INSERT INTO scores (member_id, korean, english, math, total, average, grade)
VALUES (2, 88, 88, 88, 264, 88, 'B');
INSERT INTO scores (member_id, korean, english, math, total, average, grade)
VALUES (3, 77, 77, 77, 231, 77, 'C');
INSERT INTO scores (member_id, korean, english, math, total, average, grade)
VALUES (4, 66, 66, 66, 198, 66, 'F');
INSERT INTO scores (member_id, korean, english, math, total, average, grade)
VALUES (5, 80, 80, 80, 240, 80, 'B');

SELECT * FROM scores; # 전체 출력

# 기본 정보 조회 (INNER JOIN)
# 성적 데이터가 존재하는 회원만 조회합니다. 이름, 과목 점수, 평균, 등급을 가져오는 쿼리.

SELECT
	m.name AS 이름,
	m.uid AS 아이디,
    s.korean AS 국어,
    s.english AS 영어,
    s.math AS 수학,
    s.total AS 총점,
    s.average AS 평균,
    s.grade AS 등급
FROM members m 
# Aliasing (별칭) : members m 처럼 테이블 이름 뒤에 한 글자 별칭을 주면 쿼리가 훨씬 간결해짐.
JOIN scores s ON m.id = s.member_id;
# ON 조건 : m.id = s.member_id와
# 같이 두 테이블을 연결하는 핵심 키 (PK-FK) 를 정확히 지정.

DELETE FROM scores WHERE member_id = 2;

# 성적이 없는 회원도 포함 조회 (LEFT JOIN)
# 성적표가 아직 작성되지 않은 회원까지 모두 포함하여 명단을 만들 때 사용합니다. 성적이 없으면 NULL로 표시됩니다.

SELECT 
	m.name AS 이름,
    m.role AS 역할,
    s.average AS 평균,
    s.grade AS 등급,
    IFNULL(s.grade, '미산출') AS 상태 # 성적이 없으면 '미산출' 표시
FROM members m
LEFT JOIN scores s ON m.id = s.member_id;

DROP TABLE boards;
CREATE TABLE boards (
	id			INT AUTO_INCREMENT PRIMARY KEY,
    member_id 	INT NOT NULL,
    title		VARCHAR(200) NOT NULL,
    content		TEXT NOT NULL,
    create_at	DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (member_id) REFERENCES members(id)
);

INSERT INTO boards (member_id, title, content)
VALUES (2, '제목1', '내용1');
INSERT INTO boards (member_id, title, content)
VALUES (3, '제목3', '내용3');
INSERT INTO boards (member_id, title, content)
VALUES (3, '제목5', '내용5');
INSERT INTO boards (member_id, title, content)
VALUES (4, '제목7', '내용7');
INSERT INTO boards (member_id, title, content)
VALUES (4, '제목9', '내용9');

SELECT * FROM boards; # 전체 출력

# 게시글 목록 조회 (INNER JOIN)
SELECT 
	b.id AS 글번호,
    b.title AS 제목,
    m.name AS 작성자, -- members 테이블에서 가져옴
    b.create_at AS 작성일
FROM boards b
INNER JOIN members m ON b.member_id = m.id
# ORDER BY b.create_at DESC; -- 최신글 순으로 정렬
WHERE m.uid = 'lhj'; -- 특정 아이디를 가진 유저의 글만 필터링
    
# 관리자용 : 통계 조회 (GROUP BY 조합)
SELECT
	m.name,
    m.uid,
    COUNT(b.id) AS 작성글수 # GROUP BY와 세트
FROM members m
LEFT JOIN boards b ON m.id = b.member_id
GROUP BY m.id;

# 작성자 이름으로 검색하기 (LIKE 활용)
SELECT
	b.id AS 글번호,
    b.title AS 제목,
    m.name AS 작성자,
    b.create_at AS 작성일
FROM boards b
INNER JOIN members m ON b.member_id = m.id
WHERE m.name LIKE '%효정%'
ORDER BY b.create_at DESC;

# WHERE m.name LIKE '%검색어%' OR b.title LIKE '%검색어%'
