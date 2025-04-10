-- 인 메모리 데이터베이스 설계

-- # 테이블 생성 ----------------------------------------------------------------
DROP TABLE IF EXISTS user_account CASCADE;

CREATE TABLE IF NOT EXISTS user_account COMMENT '사용자계정' (
    id                  int             NOT NULL AUTO_INCREMENT COMMENT '사용자계정 번호',
    email               VARCHAR(40)     NOT NULL COMMENT '로그인 이메일',
    password            VARCHAR(255)    NOT NULL COMMENT '로그인 비밀번호',
    nickname            VARCHAR(20)     NOT NULL COMMENT '닉네임',
    name                VARCHAR(15)     NOT NULL COMMENT '이름',
    phone               VARCHAR(11)     NOT NULL COMMENT '휴대폰번호(하이픈 제외)',
    login_type          VARCHAR(5)      NOT NULL COMMENT '로그인 유형 (OAUTH:소셜 / LOCAL:일반)',
    enabled             TINYINT(1)      NOT NULL COMMENT '계정활성화(0:비활성화/1:활성화)',
    deleted_yn          CHAR(1)         NOT NULL DEFAULT 'N' COMMENT '삭제여부(탈퇴여부)',
    CREATED_AT          DATETIME        NOT NULL DEFAULT NOW() COMMENT '가입일자',
    UPDATED_AT          DATETIME        NOT NULL COMMENT '정보변경일자',
    DELETED_AT          DATETIME        NULL COMMENT '삭제일자(탈퇴일자)',
    PRIMARY KEY (id)
);


DROP TABLE IF EXISTS user_role CASCADE;

CREATE TABLE IF NOT EXISTS user_role COMMENT '사용자계정별 권한' (
    user_id             INT             NOT NULL COMMENT '사용자계정 번호',
    role                VARCHAR(20)     NOT NULL COMMENT '권한명(ROLE_USER/ROLE_ADMIN)',
    created_at          DATETIME        NOT NULL DEFAULT NOW() COMMENT '권한등록일자',
    updated_at          DATETIME        NOT NULL COMMENT '권한변경(삭제)일자'
);

ALTER TABLE user_role ADD CONSTRAINT user_role_user_id_fk
FOREIGN KEY (user_id) REFERENCES user_account (id) ON UPDATE CASCADE ON DELETE CASCADE;


DROP TABLE IF EXISTS user_profile CASCADE;

CREATE TABLE IF NOT EXISTS user_profile COMMENT '사용자 프로필' (
    id                  INT             NOT NULL AUTO_INCREMENT COMMENT '프로필 번호',
    user_id             INT             NOT NULL COMMENT '사용자계정 번호',
    profile_img_url     VARCHAR(255)    NOT NULL COMMENT '프로필 이미지 저장 경로',
    bio                 VARCHAR(150)    NOT NULL COMMENT '한 줄 소개',
    univ                VARCHAR(45)     NOT NULL COMMENT '대학명(재학 또는 졸업)',
    created_at          DATETIME        NOT NULL DEFAULT NOW() COMMENT '정보등록 일자',
    updated_at          DATETIME        NOT NULL COMMENT '정보변경 일자',
    PRIMARY KEY (id)
);

ALTER TABLE user_profile ADD CONSTRAINT user_profile_user_id_fk
FOREIGN KEY (user_id) REFERENCES user_account (id) ON UPDATE CASCADE ON DELETE CASCADE;


DROP TABLE IF EXISTS login_history CASCADE;

CREATE TABLE IF NOT EXISTS login_history COMMENT '로그인/로그아웃 이력' (
    id                  INT             NOT NULL AUTO_INCREMENT COMMENT '이력 번호',
    user_id             INT             NOT NULL COMMENT '사용자계정 번호',
    client_ip           VARCHAR(15)     NOT NULL COMMENT '접속 IP',
    agent               VARCHAR(255)    NOT NULL COMMENT '사용자식별정보',
    event_type          CHAR(1)         NOT NULL COMMENT '로그인/로그아웃 구분 코드(I:로그인/O:로그아웃)',
    login_at            DATETIME        NOT NULL COMMENT '로그인 일자',
    logout_at           DATETIME        NULL COMMENT '로그아웃 일자',
    PRIMARY KEY (id)
);