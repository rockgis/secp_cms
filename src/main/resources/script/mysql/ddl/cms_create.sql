set SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- 페이지_조회수통계
CREATE TABLE `mc_analytics` (
	`YMD`          CHAR(8)      NULL     COMMENT '연월일', -- 연월일
	`TITLE`        VARCHAR(100) NOT NULL COMMENT '메뉴명', -- 메뉴명
	`REQUEST_URI`  VARCHAR(200) NULL     COMMENT '페이지_URL', -- 페이지_URL
	`QUERY_STRING` VARCHAR(250) NULL     COMMENT '페이지_파라미터', -- 페이지_파라미터
	`BROWSER`      VARCHAR(250) NULL     COMMENT '브라우저', -- 브라우저
	`REFERER`      VARCHAR(250) NULL     COMMENT '이전주소', -- 이전주소
	`IP`           VARCHAR(15)  NULL     COMMENT '아이피', -- 아이피
	`LOCALE`       VARCHAR(10)  NULL     COMMENT '지역', -- 지역
	`YYYY`         VARCHAR(4)   NULL     COMMENT '연', -- 연
	`MM`           CHAR(2)      NULL     COMMENT '월', -- 월
	`DD`           CHAR(2)      NULL     COMMENT '일', -- 일
	`HH`           CHAR(2)      NULL     COMMENT '시', -- 시
	`MEMBER_ID`    VARCHAR(30)  NULL     COMMENT '회원_ID', -- 회원_ID
	`SESSION_ID`   VARCHAR(40)  NULL     COMMENT '세션_ID', -- 세션_ID
	`CNT`          INT(11)      NULL     DEFAULT 1 COMMENT '페이지뷰수', -- 페이지뷰수
	`OS`           VARCHAR(20)  NULL     COMMENT 'OS', -- OS
	`SITE_ID`      INT(11)      NULL     COMMENT '사이트_ID' -- 사이트_ID
)
COMMENT '페이지_조회수통계';

-- IDX_MC_ANALYTICS
CREATE INDEX `IDX_MC_ANALYTICS`
	ON `mc_analytics`( -- 페이지_조회수통계
		`YMD` -- 연월일
	);

-- 게시물_목록
CREATE TABLE `mc_article` (
	`ARTICLE_SEQ` INT(38)       NOT NULL COMMENT '게시물_시퀀스', -- 게시물_시퀀스
	`BOARD_SEQ`   INT(38)       NOT NULL COMMENT '게시판_시퀀스', -- 게시판_시퀀스
	`TITLE`       VARCHAR(256)  NOT NULL COMMENT '제목', -- 제목
	`CONTS`       TEXT          NULL     COMMENT '내용', -- 내용
	`IP`          VARCHAR(16)   NOT NULL COMMENT '아이피', -- 아이피
	`VIEW_CNT`    INT(11)       NOT NULL DEFAULT 0 COMMENT '조회수', -- 조회수
	`PUBLIC_YN`   CHAR(1)       NOT NULL DEFAULT 'Y' COMMENT '공개여부', -- 공개여부
	`NOTICE_YN`   CHAR(1)       NOT NULL DEFAULT 'N' COMMENT '공지여부', -- 공지여부
	`CAT`         INT(38)       NULL     COMMENT '카테고리_코드', -- 카테고리_코드
	`STATE`       INT(38)       NULL     COMMENT '상태값', -- 상태값
	`THUMB`       VARCHAR(100)  NULL     COMMENT '썸네일', -- 썸네일
	`PASSWORD`    VARCHAR(100)  NULL     COMMENT '패스워드', -- 패스워드
	`REF_NUM`     INT(38)       NOT NULL COMMENT '참조_시퀀스', -- 참조_시퀀스
	`STEP_NUM`    INT(38)       NOT NULL DEFAULT 0 COMMENT '참조_시퀀스2', -- 참조_시퀀스2
	`DEPTH_NUM`   INT(38)       NOT NULL DEFAULT 0 COMMENT '계층_단계', -- 계층_단계
	`SDATE`       DATETIME      NULL     COMMENT '공지_시작일', -- 공지_시작일
	`EDATE`       DATETIME      NULL     COMMENT '공지_종료일', -- 공지_종료일
	`REG_DT`      DATETIME      NULL     COMMENT '등록일', -- 등록일
	`REG_ID`      VARCHAR(30)   NOT NULL COMMENT '등록자_ID', -- 등록자_ID
	`REG_NM`      VARCHAR(32)   NOT NULL COMMENT '등록자', -- 등록자
	`MOD_DT`      DATETIME      NULL     COMMENT '수정일', -- 수정일
	`MOD_ID`      VARCHAR(30)   NULL     COMMENT '수정자_ID', -- 수정자_ID
	`MOD_NM`      VARCHAR(32)   NULL     COMMENT '수정자', -- 수정자
	`DEL_DT`      DATETIME      NULL     COMMENT '삭제일', -- 삭제일
	`DEL_ID`      VARCHAR(30)   NULL     COMMENT '삭제자_ID', -- 삭제자_ID
	`DEL_NM`      VARCHAR(32)   NULL     COMMENT '삭제자', -- 삭제자
	`DEL_YN`      CHAR(1)       NOT NULL DEFAULT 'N' COMMENT '삭제여부', -- 삭제여부
	`REPLY_CONTS` TEXT          NULL     COMMENT '답글', -- 답글
	`REPLY_ID`    VARCHAR(30)   NULL     COMMENT '답글작성자_ID', -- 답글작성자_ID
	`REPLY_NM`    VARCHAR(32)   NULL     COMMENT '답글작성자', -- 답글작성자
	`REPLY_DT`    DATETIME      NULL     COMMENT '답글작성일', -- 답글작성일
	`TEL1`        VARCHAR(4)    NULL     COMMENT '전화번호1', -- 전화번호1
	`TEL2`        VARCHAR(4)    NULL     COMMENT '전화번호2', -- 전화번호2
	`TEL3`        VARCHAR(4)    NULL     COMMENT '전화번호3', -- 전화번호3
	`CELL1`       VARCHAR(4)    NULL     COMMENT '휴대폰번호1', -- 휴대폰번호1
	`CELL2`       VARCHAR(4)    NULL     COMMENT '휴대폰번호2', -- 휴대폰번호2
	`CELL3`       VARCHAR(4)    NULL     COMMENT '휴대폰번호3', -- 휴대폰번호3
	`EMAIL1`      VARCHAR(128)  NULL     COMMENT '이메일1', -- 이메일1
	`EMAIL2`      VARCHAR(128)  NULL     COMMENT '이메일2', -- 이메일2
	`ETC01`       VARCHAR(400)  NULL     COMMENT '기타1', -- 기타1
	`ETC02`       VARCHAR(400)  NULL     COMMENT '기타2', -- 기타2
	`ETC03`       VARCHAR(400)  NULL     COMMENT '기타3', -- 기타3
	`ETC04`       VARCHAR(400)  NULL     COMMENT '기타4', -- 기타4
	`ETC05`       VARCHAR(400)  NULL     COMMENT '기타5', -- 기타5
	`ETC06`       VARCHAR(400)  NULL     COMMENT '기타6', -- 기타6
	`ETC07`       VARCHAR(400)  NULL     COMMENT '기타7', -- 기타7
	`ETC08`       VARCHAR(4000) NULL     COMMENT '기타8', -- 기타8
	`ETC09`       VARCHAR(4000) NULL     COMMENT '기타9', -- 기타9
	`ETC10`       VARCHAR(4000) NULL     COMMENT '기타10', -- 기타10
	`CCL_TYPE`    VARCHAR(1)    NULL     COMMENT '저작권보호_CCL', -- 저작권보호_CCL
	`NURI_TYPE`   VARCHAR(1)    NULL     COMMENT '저작권보호_공공누리', -- 저작권보호_공공누리
	`TAG_NAMES`   VARCHAR(200)  NULL     COMMENT '태그' -- 태그
)
COMMENT '게시물_목록';

-- 게시물_목록
ALTER TABLE `mc_article`
	ADD CONSTRAINT
		PRIMARY KEY (
			`ARTICLE_SEQ`, -- 게시물_시퀀스
			`BOARD_SEQ`    -- 게시판_시퀀스
		);

-- IDX_MC_ARTICLE
CREATE INDEX `IDX_MC_ARTICLE`
	ON `mc_article`( -- 게시물_목록
		`REF_NUM`,     -- 참조_시퀀스
		`STEP_NUM`,    -- 참조_시퀀스2
		`DEPTH_NUM`,   -- 계층_단계
		`ARTICLE_SEQ`  -- 게시물_시퀀스
	);

-- IDX_MC_ARTICLE01
CREATE INDEX `IDX_MC_ARTICLE01`
	ON `mc_article`( -- 게시물_목록
		`DEL_YN` -- 삭제여부
	);

-- 첨부파일
CREATE TABLE `mc_attach` (
	`UUID`      VARCHAR(50)  NOT NULL COMMENT '고유번호', -- 고유번호
	`ATTACH_NM` VARCHAR(256) NOT NULL COMMENT '파일명', -- 파일명
	`YYYY`      CHAR(4)      NOT NULL COMMENT '연', -- 연
	`MM`        CHAR(2)      NOT NULL DEFAULT '00' COMMENT '월', -- 월
	`ORDER_SEQ` INT(2)       NULL     COMMENT '순서', -- 순서
	`TABLE_NM`  VARCHAR(64)  NULL     COMMENT '구분값', -- 구분값
	`TABLE_SEQ` INT(11)      NULL     COMMENT '게시물_시퀀스', -- 게시물_시퀀스
	`REG_ID`    VARCHAR(30)  NOT NULL COMMENT '등록자_ID', -- 등록자_ID
	`REG_NM`    VARCHAR(32)  NOT NULL COMMENT '등록자', -- 등록자
	`REG_DT`    DATETIME     NULL     COMMENT '등록일', -- 등록일
	`DEL_ID`    VARCHAR(30)  NULL     COMMENT '삭제자_ID', -- 삭제자_ID
	`DEL_NM`    VARCHAR(32)  NULL     COMMENT '삭제자', -- 삭제자
	`DEL_DT`    DATETIME     NULL     COMMENT '삭제일', -- 삭제일
	`DEL_YN`    CHAR(1)      NOT NULL DEFAULT 'N' COMMENT '삭제여부', -- 삭제여부
	`VIEW_CNT`  INT(11)      NULL     DEFAULT 0 COMMENT '조회수' -- 조회수
)
COMMENT '첨부파일';

-- 첨부파일
ALTER TABLE `mc_attach`
	ADD CONSTRAINT
		PRIMARY KEY (
			`UUID` -- 고유번호
		);

-- 첨부파일 유니크 인덱스
CREATE UNIQUE INDEX `IDX_MC_ATTACH`
	ON `mc_attach` ( -- 첨부파일
		`TABLE_SEQ` ASC, -- 게시물_시퀀스
		`TABLE_NM` ASC,  -- 구분값
		`UUID` ASC       -- 고유번호
	);

-- 사이트_기본설정
CREATE TABLE `mc_basic_setting` (
	`site_id`             INT(11) NULL COMMENT '사이트아이디', -- 사이트아이디
	`certification_yn`    CHAR(1) NULL COMMENT '회원가입 본인인증사용여부', -- 회원가입 본인인증사용여부
	`logout_time_yn`      CHAR(1) NULL COMMENT '로그아웃시간 사용여부', -- 로그아웃시간 사용여부
	`logout_time`         INT(32) NULL COMMENT '로그아웃시간 분', -- 로그아웃시간 분
	`pw_change_yn`        CHAR(1) NULL COMMENT '비밀번호변경주기 사용여부', -- 비밀번호변경주기 사용여부
	`pw_change_cycle`     INT(32) NULL COMMENT '비밀번호변경주기 개월', -- 비밀번호변경주기 개월
	`dormancy_yn`         CHAR(1) NULL COMMENT '장기 미접속 사용여부', -- 장기 미접속 사용여부
	`dormancy_day`        INT(32) NULL COMMENT '장기 미접속 설정개월', -- 장기 미접속 설정개월
	`adm_logout_time_yn`  CHAR(1) NULL COMMENT '관리자 로그아웃시간 사용여부', -- 관리자 로그아웃시간 사용여부
	`adm_logout_time`     INT(32) NULL COMMENT '관리자 로그아웃시간 분', -- 관리자 로그아웃시간 분
	`adm_pw_change_yn`    CHAR(1) NULL COMMENT '관리자 비밀번호변경주기 사용여부', -- 관리자 비밀번호변경주기 사용여부
	`adm_pw_change_cycle` INT(32) NULL COMMENT '관리자 비밀번호변경주기 개월', -- 관리자 비밀번호변경주기 개월
	`adm_dormancy_yn`     CHAR(1) NULL COMMENT '관리자 장기 미접속 사용여부', -- 관리자 장기 미접속 사용여부
	`adm_dormancy_day`    INT(32) NULL COMMENT '관리자 장기 미접속 설정개월' -- 관리자 장기 미접속 설정개월
)
COMMENT '사이트_기본설정';

-- 게시판설정_목록
CREATE TABLE `mc_board` (
	`BOARD_SEQ`       INT(38)     NOT NULL COMMENT '게시판_시퀀스', -- 게시판_시퀀스
	`BOARD_NM`        VARCHAR(64) NOT NULL COMMENT '게시판명', -- 게시판명
	`BOARD_TYPE`      VARCHAR(2)  NOT NULL COMMENT '게시판_타입', -- 게시판_타입
	`COMMENT_YN`      CHAR(1)     NOT NULL DEFAULT 'N' COMMENT '댓글여부', -- 댓글여부
	`COMMENT_TARGET`  CHAR(1)     NOT NULL DEFAULT 'U' COMMENT '댓글지원대상', -- 댓글지원대상
	`FILE_YN`         CHAR(1)     NOT NULL COMMENT '파일첨부여부', -- 파일첨부여부
	`LIMIT_FILE_SIZE` INT(11)     NULL     COMMENT '파일첨부_최대개수', -- 파일첨부_최대개수
	`FILE_LIMIT`      VARCHAR(1)  NOT NULL DEFAULT 'N' COMMENT '파일첨부_최대용량', -- 파일첨부_최대용량
	`SEARCH_YN`       CHAR(1)     NOT NULL COMMENT '검색노출여부', -- 검색노출여부
	`USE_YN`          CHAR(1)     NOT NULL COMMENT '사용여부', -- 사용여부
	`CAT_YN`          VARCHAR(1)  NULL     COMMENT '카테고리사용여부', -- 카테고리사용여부
	`REG_DT`          DATETIME    NULL     COMMENT '등록일', -- 등록일
	`REG_ID`          VARCHAR(30) NULL     COMMENT '등록자_ID', -- 등록자_ID
	`REG_NM`          VARCHAR(32) NOT NULL COMMENT '등록자', -- 등록자
	`MOD_DT`          DATETIME    NULL     COMMENT '수정일', -- 수정일
	`MOD_ID`          VARCHAR(30) NULL     COMMENT '수정자_ID', -- 수정자_ID
	`MOD_NM`          VARCHAR(32) NULL     COMMENT '수정자', -- 수정자
	`DEL_DT`          DATETIME    NULL     COMMENT '삭제일', -- 삭제일
	`DEL_ID`          VARCHAR(30) NULL     COMMENT '삭제자_ID', -- 삭제자_ID
	`DEL_NM`          VARCHAR(32) NULL     COMMENT '삭제자', -- 삭제자
	`DEL_YN`          CHAR(1)     NOT NULL DEFAULT 'N' COMMENT '삭제여부', -- 삭제여부
	`SITE_ID`         INT(2)      NULL     DEFAULT 1 COMMENT '사이트_ID', -- 사이트_ID
	`INSERT_YN`       CHAR(1)     NULL     DEFAULT 'Y' COMMENT '사용자_글등록_사용여부', -- 사용자_글등록_사용여부
	`PUBLIC_YN`       CHAR(1)     NOT NULL DEFAULT 'Y' COMMENT '비밀글_사용여부', -- 비밀글_사용여부
	`THUMB_TYPE`      VARCHAR(30) NULL     DEFAULT 'TILE' COMMENT '리스트_형태', -- 리스트_형태
	`agree_yn`        CHAR(1)     NULL     COMMENT '개인정보등록_사용여부', -- 개인정보등록_사용여부
	`editor_yn`       CHAR(1)     NULL     COMMENT '에디터_사용여부', -- 에디터_사용여부
	`ROWS_TEXT`       VARCHAR(50) NULL     DEFAULT '10,20,30' COMMENT '리스트페이지에_보여줄_갯수목록', -- 리스트페이지에_보여줄_갯수목록
	`list_row`        VARCHAR(3)  NULL     COMMENT '리스트페이지에_보여줄_갯수초기값', -- 리스트페이지에_보여줄_갯수초기값
	`CCLNURI_YN`      VARCHAR(1)  NULL     COMMENT '저작권보호_사용여부', -- 저작권보호_사용여부
	`TAG_YN`          VARCHAR(1)  NULL     COMMENT '태그_사용여부' -- 태그_사용여부
)
COMMENT '게시판설정_목록';

-- 게시판설정_목록
ALTER TABLE `mc_board`
	ADD CONSTRAINT
		PRIMARY KEY (
			`BOARD_SEQ` -- 게시판_시퀀스
		);

-- 게시판설정_커스텀_약관동의
CREATE TABLE `mc_board_agree` (
	`BOARD_AGREE_SEQ` INT(38)      NOT NULL COMMENT '시퀀스', -- 시퀀스
	`BOARD_SEQ`       INT(38)      NOT NULL COMMENT '게시판_시퀀스', -- 게시판_시퀀스
	`AGREE_TIT`       VARCHAR(256) NULL     COMMENT '약관명', -- 약관명
	`AGREE_CONT`      TEXT         NULL     COMMENT '약관내용', -- 약관내용
	`AGREE_CHECK`     CHAR(1)      NULL     COMMENT '약광동의', -- 약광동의
	`AGREE_ORDER`     VARCHAR(3)   NULL     COMMENT '약관순서', -- 약관순서
	`REG_DT`          DATETIME     NULL     COMMENT '등록일', -- 등록일
	`REG_ID`          VARCHAR(30)  NULL     COMMENT '등록자_ID', -- 등록자_ID
	`REG_NM`          VARCHAR(32)  NOT NULL COMMENT '등록자', -- 등록자
	`MOD_DT`          DATETIME     NULL     COMMENT '수정일', -- 수정일
	`MOD_ID`          VARCHAR(30)  NULL     COMMENT '수정자_ID', -- 수정자_ID
	`MOD_NM`          VARCHAR(32)  NULL     COMMENT '수정자', -- 수정자
	`DEL_DT`          DATETIME     NULL     COMMENT '삭제일', -- 삭제일
	`DEL_ID`          VARCHAR(30)  NULL     COMMENT '삭제자_ID', -- 삭제자_ID
	`DEL_NM`          VARCHAR(32)  NULL     COMMENT '삭제자', -- 삭제자
	`DEL_YN`          CHAR(1)      NOT NULL DEFAULT 'N' COMMENT '삭제여부' -- 삭제여부
)
COMMENT '게시판설정_커스텀_약관동의';

-- 게시판설정_커스텀_약관동의
ALTER TABLE `mc_board_agree`
	ADD CONSTRAINT
		PRIMARY KEY (
			`BOARD_AGREE_SEQ` -- 시퀀스
		);

ALTER TABLE `mc_board_agree`
	MODIFY COLUMN `BOARD_AGREE_SEQ` INT(38) NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

ALTER TABLE `mc_board_agree`
	AUTO_INCREMENT = 1;

-- 게시판설정_카테고리
CREATE TABLE `mc_board_cat` (
	`BOARD_CAT_SEQ` INT(38)     NOT NULL COMMENT '시퀀스', -- 시퀀스
	`BOARD_SEQ`     INT(38)     NOT NULL COMMENT '게시판_시퀀스', -- 게시판_시퀀스
	`CAT_NM`        VARCHAR(64) NOT NULL COMMENT '카테고리명', -- 카테고리명
	`REG_DT`        DATETIME    NULL     COMMENT '등록일', -- 등록일
	`REG_ID`        VARCHAR(30) NULL     COMMENT '등록자_ID', -- 등록자_ID
	`REG_NM`        VARCHAR(32) NOT NULL COMMENT '등록자', -- 등록자
	`MOD_DT`        DATETIME    NULL     COMMENT '수정일', -- 수정일
	`MOD_ID`        VARCHAR(30) NULL     COMMENT '수정자_ID', -- 수정자_ID
	`MOD_NM`        VARCHAR(32) NULL     COMMENT '수정자', -- 수정자
	`DEL_DT`        DATETIME    NULL     COMMENT '삭제일', -- 삭제일
	`DEL_ID`        VARCHAR(30) NULL     COMMENT '삭제자_ID', -- 삭제자_ID
	`DEL_NM`        VARCHAR(32) NULL     COMMENT '삭제자', -- 삭제자
	`DEL_YN`        CHAR(1)     NOT NULL DEFAULT 'N' COMMENT '삭제여부' -- 삭제여부
)
COMMENT '게시판설정_카테고리';

-- 게시판설정_카테고리
ALTER TABLE `mc_board_cat`
	ADD CONSTRAINT
		PRIMARY KEY (
			`BOARD_CAT_SEQ`, -- 시퀀스
			`BOARD_SEQ`      -- 게시판_시퀀스
		);

ALTER TABLE `mc_board_cat`
	MODIFY COLUMN `BOARD_CAT_SEQ` INT(38) NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

ALTER TABLE `mc_board_cat`
	AUTO_INCREMENT = 7;

-- 게시판설정_커스텀_컬럼_타입
CREATE TABLE `mc_board_column` (
	`ORDER_NUM`  INT(11)       NOT NULL COMMENT '시퀀스', -- 시퀀스
	`COL_CODE`   VARCHAR(20)   NULL     COMMENT '컬럼_코드', -- 컬럼_코드
	`COL_KOR`    VARCHAR(20)   NULL     COMMENT '컬럼_제목', -- 컬럼_제목
	`COL_HELPER` VARCHAR(4000) NULL     COMMENT '컬럼_설명', -- 컬럼_설명
	`COL_EDIT`   CHAR(1)       NULL     DEFAULT 'Y' COMMENT '사용자_입력가능여부' -- 사용자_입력가능여부
)
COMMENT '게시판설정_커스텀_컬럼_타입';

-- 게시판설정_커스텀_컬럼_타입
ALTER TABLE `mc_board_column`
	ADD CONSTRAINT `PK_mc_board_column` -- 게시판설정_커스텀_컬럼_타입 기본키
		PRIMARY KEY (
			`ORDER_NUM` -- 시퀀스
		);

ALTER TABLE `mc_board_column`
	MODIFY COLUMN `ORDER_NUM` INT(11) NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

-- 게시판설정_커스텀
CREATE TABLE `mc_board_custom` (
	`SEQ`                  INT(11)      NOT NULL COMMENT '시퀀스', -- 시퀀스
	`BOARD_SEQ`            INT(38)      NOT NULL COMMENT '게시판_시퀀스', -- 게시판_시퀀스
	`ELEMENT`              VARCHAR(500) NULL     COMMENT '항목명', -- 항목명
	`COLUMN_NAME`          VARCHAR(500) NULL     COMMENT '컬럼형태', -- 컬럼형태
	`USER_LIST_ELEMENT`    VARCHAR(500) NULL     COMMENT '사용자_리스트_설정', -- 사용자_리스트_설정
	`USER_LIST_COL`        VARCHAR(500) NULL     COMMENT '사용자_리스트_사이즈', -- 사용자_리스트_사이즈
	`USER_VIEW_ELEMENT`    VARCHAR(500) NULL     COMMENT '사용자_뷰_설정', -- 사용자_뷰_설정
	`USER_INSERT_ELEMENT`  VARCHAR(500) NULL     COMMENT '사용자_쓰기_설정', -- 사용자_쓰기_설정
	`USER_MODIFY_ELEMENT`  VARCHAR(500) NULL     COMMENT '사용자_수정_설정', -- 사용자_수정_설정
	`ADMIN_LIST_ELEMENT`   VARCHAR(500) NULL     COMMENT '관리자_리스트_설정', -- 관리자_리스트_설정
	`ADMIN_LIST_COL`       VARCHAR(500) NULL     COMMENT '관리자_리스트_사이즈', -- 관리자_리스트_사이즈
	`ADMIN_INSERT_ELEMENT` VARCHAR(500) NULL     COMMENT '관리자_쓰기_설정', -- 관리자_쓰기_설정
	`ADMIN_MODIFY_ELEMENT` VARCHAR(500) NULL     COMMENT '관리자_수정_설정', -- 관리자_수정_설정
	`REG_DT`               DATETIME     NULL     COMMENT '등록일', -- 등록일
	`REG_ID`               VARCHAR(50)  NULL     COMMENT '등록자_ID', -- 등록자_ID
	`MOD_DT`               DATETIME     NULL     COMMENT '수정일', -- 수정일
	`MOD_ID`               VARCHAR(20)  NULL     COMMENT '수정자_ID', -- 수정자_ID
	`DEL_YN`               CHAR(1)      NULL     DEFAULT 'N' COMMENT '삭제여부', -- 삭제여부
	`ORDER_NUM`            INT(11)      NULL     COMMENT '순서', -- 순서
	`require_yn`           CHAR(1)      NULL     COMMENT '필수여부' -- 필수여부
)
COMMENT '게시판설정_커스텀';

-- 게시판설정_커스텀
ALTER TABLE `mc_board_custom`
	ADD CONSTRAINT
		PRIMARY KEY (
			`SEQ`,       -- 시퀀스
			`BOARD_SEQ`  -- 게시판_시퀀스
		);

ALTER TABLE `mc_board_custom`
	MODIFY COLUMN `SEQ` INT(11) NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

ALTER TABLE `mc_board_custom`
	AUTO_INCREMENT = 57;

-- 게시판_타입
CREATE TABLE `mc_board_list` (
	`SEQ`        INT(11)     NOT NULL COMMENT '시퀀스', -- 시퀀스
	`BOARD_TYPE` VARCHAR(2)  NOT NULL COMMENT '게시판_타입', -- 게시판_타입
	`NAME`       VARCHAR(50) NULL     COMMENT '게시판_타입명' -- 게시판_타입명
)
COMMENT '게시판_타입';

-- 게시판_타입
ALTER TABLE `mc_board_list`
	ADD CONSTRAINT
		PRIMARY KEY (
			`SEQ` -- 시퀀스
		);

ALTER TABLE `mc_board_list`
	MODIFY COLUMN `SEQ` INT(11) NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

-- 게시판설정_상태
CREATE TABLE `mc_board_state` (
	`BOARD_STATE_SEQ` INT(38)     NOT NULL COMMENT '시퀀스', -- 시퀀스
	`BOARD_SEQ`       INT(38)     NOT NULL COMMENT '게시판_시퀀스', -- 게시판_시퀀스
	`STATE_NM`        VARCHAR(64) NOT NULL COMMENT '상태명', -- 상태명
	`REG_DT`          DATETIME    NULL     COMMENT '등록일', -- 등록일
	`REG_ID`          VARCHAR(30) NULL     COMMENT '등록자_ID', -- 등록자_ID
	`REG_NM`          VARCHAR(32) NOT NULL COMMENT '등록자', -- 등록자
	`MOD_DT`          DATETIME    NULL     COMMENT '수정일', -- 수정일
	`MOD_ID`          VARCHAR(30) NULL     COMMENT '수정자_ID', -- 수정자_ID
	`MOD_NM`          VARCHAR(32) NULL     COMMENT '수정자', -- 수정자
	`DEL_DT`          DATETIME    NULL     COMMENT '삭제일', -- 삭제일
	`DEL_ID`          VARCHAR(30) NULL     COMMENT '삭제자_ID', -- 삭제자_ID
	`DEL_NM`          VARCHAR(32) NULL     COMMENT '삭제자', -- 삭제자
	`DEL_YN`          CHAR(1)     NOT NULL DEFAULT 'N' COMMENT '삭제여부' -- 삭제여부
)
COMMENT '게시판설정_상태';

-- 게시판설정_상태
ALTER TABLE `mc_board_state`
	ADD CONSTRAINT
		PRIMARY KEY (
			`BOARD_STATE_SEQ`, -- 시퀀스
			`BOARD_SEQ`        -- 게시판_시퀀스
		);

ALTER TABLE `mc_board_state`
	MODIFY COLUMN `BOARD_STATE_SEQ` INT(38) NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

ALTER TABLE `mc_board_state`
	AUTO_INCREMENT = 3;

-- 메뉴별_컨텐츠_백업
CREATE TABLE `mc_cms_content_bakup` (
	`SEQ`          INT(38)     NOT NULL COMMENT '시퀀스', -- 시퀀스
	`CMS_MENU_SEQ` INT(38)     NOT NULL COMMENT '메뉴_시퀀스', -- 메뉴_시퀀스
	`CONTS`        TEXT        NULL     COMMENT '내용', -- 내용
	`CMOD_ID`      VARCHAR(32) NULL     COMMENT '수정자_ID', -- 수정자_ID
	`CMOD_NM`      VARCHAR(32) NULL     COMMENT '수정자', -- 수정자
	`CMOD_DT`      DATETIME    NULL     COMMENT '수정일' -- 수정일
)
COMMENT '메뉴별_컨텐츠_백업';

-- 메뉴별_컨텐츠_백업
ALTER TABLE `mc_cms_content_bakup`
	ADD CONSTRAINT
		PRIMARY KEY (
			`SEQ` -- 시퀀스
		);

ALTER TABLE `mc_cms_content_bakup`
	MODIFY COLUMN `SEQ` INT(38) NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

ALTER TABLE `mc_cms_content_bakup`
	AUTO_INCREMENT = 20;

-- 메뉴정보
CREATE TABLE `mc_cms_menu` (
	`CMS_MENU_SEQ`    INT(38)      NOT NULL COMMENT '메뉴_시퀀스', -- 메뉴_시퀀스
	`PARENT_MENU_SEQ` INT(38)      NULL     COMMENT '부모키', -- 부모키
	`TITLE`           VARCHAR(255) NOT NULL COMMENT '메뉴명', -- 메뉴명
	`MENU_ORDER`      INT(38)      NULL     DEFAULT 1 COMMENT '표시순서', -- 표시순서
	`USE_YN`          VARCHAR(1)   NOT NULL DEFAULT 'Y' COMMENT '사용여부', -- 사용여부
	`BLANK_YN`        VARCHAR(1)   NULL     DEFAULT 'N' COMMENT '새창여부', -- 새창여부
	`MENU_TYPE`       VARCHAR(1)   NULL     COMMENT '메뉴타입', -- 메뉴타입
	`TARGET_URL`      VARCHAR(128) NULL     COMMENT '링크주소', -- 링크주소
	`PROGRAM_NM`      VARCHAR(255) NULL     COMMENT '프로그램명', -- 프로그램명
	`BOARD_SEQ`       INT(38)      NULL     COMMENT '게시판_번호', -- 게시판_번호
	`CONTS`           TEXT         NULL     COMMENT '내용', -- 내용
	`SITE_ID`         INT(38)      NULL     DEFAULT 1 COMMENT '사이트_ID', -- 사이트_ID
	`REG_NM`          VARCHAR(32)  NULL     COMMENT '등록자', -- 등록자
	`REG_DT`          DATETIME     NULL     COMMENT '등록일', -- 등록일
	`MOD_NM`          VARCHAR(32)  NULL     COMMENT '수정자', -- 수정자
	`MOD_DT`          DATETIME     NULL     COMMENT '수정일', -- 수정일
	`DEL_NM`          VARCHAR(32)  NULL     COMMENT '삭제자', -- 삭제자
	`DEL_DT`          DATETIME     NULL     COMMENT '삭제일', -- 삭제일
	`DEL_YN`          VARCHAR(1)   NULL     DEFAULT 'N' COMMENT '삭제여부', -- 삭제여부
	`CHILD_TYPE`      INT(38)      NULL     COMMENT '자식타입', -- 자식타입
	`HEAD_HTML`       TEXT         NULL     COMMENT '하단표시내용', -- 하단표시내용
	`TEMPLATE_TYPE`   INT(38)      NULL     DEFAULT 1 COMMENT '템플릿_타입', -- 템플릿_타입
	`MENU_URL`        VARCHAR(100) NULL     COMMENT '메뉴_URL', -- 메뉴_URL
	`CUD_GROUP_SEQ`   VARCHAR(150) NULL     COMMENT '수정_삭제_권한시퀀스', -- 수정_삭제_권한시퀀스
	`R_GROUP_SEQ`     VARCHAR(150) NULL     COMMENT '읽기권한_시퀀스', -- 읽기권한_시퀀스
	`MANAGE_URL`      VARCHAR(128) NULL     COMMENT '관리페이지_주소', -- 관리페이지_주소
	`TOP_YN`          CHAR(1)      NULL     DEFAULT 'Y' COMMENT '상단메뉴_노출여부', -- 상단메뉴_노출여부
	`REG_ID`          VARCHAR(30)  NULL     COMMENT '등록자_ID', -- 등록자_ID
	`MOD_ID`          VARCHAR(30)  NULL     COMMENT '수정자_ID', -- 수정자_ID
	`DEL_ID`          VARCHAR(30)  NULL     COMMENT '삭제자_ID', -- 삭제자_ID
	`INNER_YN`        CHAR(1)      NULL     DEFAULT 'N' COMMENT '관리메뉴_탭에서_관리사용여부', -- 관리메뉴_탭에서_관리사용여부
	`SUB_PATH`        VARCHAR(20)  NULL     COMMENT '위성 사이트사용시 서브패스', -- 위성 사이트사용시 서브패스
	`CMOD_ID`         VARCHAR(32)  NULL     COMMENT '콘텐츠수정자_아이디', -- 콘텐츠수정자_아이디
	`CMOD_NM`         VARCHAR(32)  NULL     COMMENT '콘텐츠수정자명', -- 콘텐츠수정자명
	`CMOD_DT`         DATETIME     NULL     COMMENT '콘텐츠수정일', -- 콘텐츠수정일
	`TEMP_CONTS`      TEXT         NULL     COMMENT '임시저장_내용', -- 임시저장_내용
	`CCL_TYPE`        VARCHAR(1)   NULL     COMMENT '저작물타입', -- 저작물타입
	`NURI_TYPE`       VARCHAR(1)   NULL     COMMENT '공공누리타입', -- 공공누리타입
	`TAG_NAMES`       VARCHAR(200) NULL     COMMENT '태그이름', -- 태그이름
	`ADD_PARAM`       VARCHAR(255) NULL     COMMENT '추가파라미터', -- 추가파라미터
	`FOOTER_HTML`     TEXT         NULL     COMMENT '홈페이지 하단내용', -- 홈페이지 하단내용
	`CONDITIONS_HTML` TEXT         NULL     COMMENT '홈페이지 이용약관', -- 홈페이지 이용약관
	`PRIVACY_HTML`    TEXT         NULL     COMMENT '취급방침 재동의 내용', -- 취급방침 재동의 내용
	`SATISFACTION_YN` CHAR(1)      NULL     COMMENT '페이지 만족도 사용여부', -- 페이지 만족도 사용여부
	`MANAGE_YN`       CHAR(1)      NULL     COMMENT '담당자 안내 사용여부', -- 담당자 안내 사용여부
	`POPUP_TYPE`      CHAR(1)      NULL     COMMENT '팝업타입' -- 팝업타입
)
COMMENT '메뉴정보';

-- 메뉴정보
ALTER TABLE `mc_cms_menu`
	ADD CONSTRAINT
		PRIMARY KEY (
			`CMS_MENU_SEQ` -- 메뉴_시퀀스
		);

-- IDX_CMS_MENU_SORTORDER
CREATE INDEX `IDX_CMS_MENU_SORTORDER`
	ON `mc_cms_menu`( -- 메뉴정보
		`PARENT_MENU_SEQ`, -- 부모키
		`MENU_ORDER`       -- 표시순서
	);

ALTER TABLE `mc_cms_menu`
	MODIFY COLUMN `CMS_MENU_SEQ` INT(38) NOT NULL AUTO_INCREMENT COMMENT '메뉴_시퀀스';

ALTER TABLE `mc_cms_menu`
	AUTO_INCREMENT = 293;

-- 메뉴정보_백업
CREATE TABLE `mc_cms_menu_bakup` (
	`SEQ`              INT(11)      NOT NULL COMMENT '백업_시퀀스', -- 백업_시퀀스
	`CMS_MENU_SEQ`     INT(38)      NOT NULL COMMENT '메뉴_시퀀스', -- 메뉴_시퀀스
	`PARENT_MENU_SEQ`  INT(38)      NULL     COMMENT '부모키', -- 부모키
	`TITLE`            VARCHAR(255) NOT NULL COMMENT '메뉴명', -- 메뉴명
	`MENU_ORDER`       INT(38)      NULL     DEFAULT 1 COMMENT '표시순서', -- 표시순서
	`USE_YN`           VARCHAR(1)   NOT NULL DEFAULT 'Y' COMMENT '사용여부', -- 사용여부
	`BLANK_YN`         VARCHAR(1)   NULL     DEFAULT 'N' COMMENT '새창여부', -- 새창여부
	`MENU_TYPE`        VARCHAR(1)   NULL     COMMENT '메뉴타입', -- 메뉴타입
	`TARGET_URL`       VARCHAR(128) NULL     COMMENT '링크주소', -- 링크주소
	`PROGRAM_NM`       VARCHAR(255) NULL     COMMENT '프로그램명', -- 프로그램명
	`BOARD_SEQ`        INT(38)      NULL     COMMENT '게시판_번호', -- 게시판_번호
	`SITE_ID`          INT(38)      NULL     DEFAULT 1 COMMENT '사이트_ID', -- 사이트_ID
	`REG_NM`           VARCHAR(32)  NULL     COMMENT '등록자', -- 등록자
	`REG_DT`           DATETIME     NULL     COMMENT '등록일', -- 등록일
	`MOD_NM`           VARCHAR(32)  NULL     COMMENT '수정자', -- 수정자
	`MOD_DT`           DATETIME     NULL     COMMENT '수정일', -- 수정일
	`DEL_NM`           VARCHAR(32)  NULL     COMMENT '삭제자', -- 삭제자
	`DEL_DT`           DATETIME     NULL     COMMENT '삭제일', -- 삭제일
	`DEL_YN`           VARCHAR(1)   NULL     DEFAULT 'N' COMMENT '삭제여부', -- 삭제여부
	`CHILD_TYPE`       INT(38)      NULL     COMMENT '자식타입', -- 자식타입
	`HEAD_HTML`        TEXT         NULL     COMMENT '하단표시내용', -- 하단표시내용
	`TEMPLATE_TYPE`    INT(38)      NULL     DEFAULT 1 COMMENT '템플릿_타입', -- 템플릿_타입
	`MENU_URL`         VARCHAR(100) NULL     COMMENT '메뉴_URL', -- 메뉴_URL
	`CUD_GROUP_SEQ`    VARCHAR(150) NULL     COMMENT '수정_삭제_권한시퀀스', -- 수정_삭제_권한시퀀스
	`R_GROUP_SEQ`      VARCHAR(150) NULL     COMMENT '읽기권한_시퀀스', -- 읽기권한_시퀀스
	`MANAGE_URL`       VARCHAR(128) NULL     COMMENT '관리페이지_주소', -- 관리페이지_주소
	`TOP_YN`           CHAR(1)      NULL     DEFAULT 'Y' COMMENT '상단메뉴_노출여부', -- 상단메뉴_노출여부
	`REG_ID`           VARCHAR(30)  NULL     COMMENT '등록자_ID', -- 등록자_ID
	`MOD_ID`           VARCHAR(30)  NULL     COMMENT '수정자_ID', -- 수정자_ID
	`DEL_ID`           VARCHAR(30)  NULL     COMMENT '삭제자_ID', -- 삭제자_ID
	`INNER_YN`         CHAR(1)      NULL     DEFAULT 'N' COMMENT '관리메뉴_탭에서_관리사용여부', -- 관리메뉴_탭에서_관리사용여부
	`SUB_PATH`         VARCHAR(20)  NULL     COMMENT '위성 사이트사용시 서브패스', -- 위성 사이트사용시 서브패스
	`JSON_STAFFS`      TEXT         NULL     COMMENT '메뉴관리자_목록', -- 메뉴관리자_목록
	`JSON_STAFF_GROUP` TEXT         NULL     COMMENT '메뉴관리자그룹_목록', -- 메뉴관리자그룹_목록
	`JSON_LIBS`        TEXT         NULL     COMMENT '추가JS파일_목록', -- 추가JS파일_목록
	`ADD_PARAM`        VARCHAR(255) NULL     COMMENT '추가파라미터' -- 추가파라미터
)
COMMENT '메뉴정보_백업';

-- 메뉴정보_백업
ALTER TABLE `mc_cms_menu_bakup`
	ADD CONSTRAINT
		PRIMARY KEY (
			`SEQ` -- 백업_시퀀스
		);

ALTER TABLE `mc_cms_menu_bakup`
	MODIFY COLUMN `SEQ` INT(11) NOT NULL AUTO_INCREMENT COMMENT '백업_시퀀스';

ALTER TABLE `mc_cms_menu_bakup`
	AUTO_INCREMENT = 53;

-- 메뉴별_개인정보_필터설정
CREATE TABLE `mc_cms_menu_filter` (
	`SITE_ID`      INT(38) NOT NULL COMMENT '사이트_ID', -- 사이트_ID
	`CMS_MENU_SEQ` INT(38) NOT NULL COMMENT '메뉴시퀀스', -- 메뉴_시퀀스
	`FILTER_YN`    CHAR(1) NULL     DEFAULT 'N' COMMENT '필터_YN', -- 필터_YN
	`JUMIN_YN`     CHAR(1) NULL     DEFAULT 'N' COMMENT '주민번호_YN', -- 주민번호_YN
	`BUSINO_YN`    CHAR(1) NULL     DEFAULT 'N' COMMENT '사업자_YN', -- 사업자_YN
	`BUBINO_YN`    CHAR(1) NULL     DEFAULT 'N' COMMENT '법인_YN', -- 법인_YN
	`EMAIL_YN`     CHAR(1) NULL     DEFAULT 'N' COMMENT '이메일_YN', -- 이메일_YN
	`TEL_YN`       CHAR(1) NULL     DEFAULT 'N' COMMENT '전화번호_YN', -- 전화번호_YN
	`CELL_YN`      CHAR(1) NULL     DEFAULT 'N' COMMENT '휴대폰_YN', -- 휴대폰_YN
	`CARD_YN`      CHAR(1) NULL     DEFAULT 'N' COMMENT '카드_YN' -- 카드_YN
)
COMMENT '메뉴별_개인정보_필터설정';

-- 메뉴별_개인정보_필터설정
ALTER TABLE `mc_cms_menu_filter`
	ADD CONSTRAINT
		PRIMARY KEY (
			`SITE_ID`,      -- 사이트_ID
			`CMS_MENU_SEQ`  -- 메뉴_시퀀스
		);

-- 개인정보_필터설정
CREATE TABLE `mc_cms_menu_filter_def` (
	`SITE_ID`        INT(11)       NOT NULL DEFAULT 0 COMMENT '사이트_ID', -- 사이트_ID
	`JUMIN_YN`       CHAR(1)       NULL     DEFAULT 'N' COMMENT '주민번호_YN', -- 주민번호_YN
	`BUSINO_YN`      CHAR(1)       NULL     DEFAULT 'N' COMMENT '사업자_YN', -- 사업자_YN
	`BUBINO_YN`      CHAR(1)       NULL     DEFAULT 'N' COMMENT '법인_YN', -- 법인_YN
	`EMAIL_YN`       CHAR(1)       NULL     DEFAULT 'N' COMMENT '이메일_YN', -- 이메일_YN
	`TEL_YN`         CHAR(1)       NULL     DEFAULT 'N' COMMENT '전화번호_YN', -- 전화번호_YN
	`CELL_YN`        CHAR(1)       NULL     DEFAULT 'N' COMMENT '휴대폰_YN', -- 휴대폰_YN
	`CARD_YN`        CHAR(1)       NULL     DEFAULT 'N' COMMENT '카드_YN', -- 카드_YN
	`FORBIDDEN_WORD` VARCHAR(4000) NULL     COMMENT '비속어' -- 비속어
)
COMMENT '개인정보_필터설정';

-- 개인정보_필터설정
ALTER TABLE `mc_cms_menu_filter_def`
	ADD CONSTRAINT
		PRIMARY KEY (
			`SITE_ID` -- 사이트_ID
		);

-- JS_CSS_파일목록
CREATE TABLE `mc_cms_menu_libs` (
	`SEQ`           INT(11)      NOT NULL COMMENT '시퀀스', -- 시퀀스
	`CMS_MENU_SEQ`  INT(38)      NULL     COMMENT '메뉴_시퀀스', -- 메뉴_시퀀스
	`TP`            CHAR(1)      NULL     COMMENT '파일타입', -- 파일타입
	`EXTENSION`     VARCHAR(3)   NULL     COMMENT '확장자명', -- 확장자명
	`ORDER_SEQ`     INT(11)      NULL     COMMENT '순서', -- 순서
	`FULL_PATH`     VARCHAR(200) NULL     COMMENT '전체경로', -- 전체경로
	`ORG_FILE_NAME` VARCHAR(50)  NULL     COMMENT '원본파일명', -- 원본파일명
	`SYS_FILE_NAME` VARCHAR(50)  NULL     COMMENT '시스템파일명' -- 시스템파일명
)
COMMENT 'JS_CSS_파일목록';

-- JS_CSS_파일목록
ALTER TABLE `mc_cms_menu_libs`
	ADD CONSTRAINT
		PRIMARY KEY (
			`SEQ` -- 시퀀스
		);

ALTER TABLE `mc_cms_menu_libs`
	MODIFY COLUMN `SEQ` INT(11) NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

ALTER TABLE `mc_cms_menu_libs`
	AUTO_INCREMENT = 1;

-- 메뉴설정권한회원
CREATE TABLE `mc_cms_permission` (
	`CMS_STAFF_SEQ` INT(11)     NOT NULL COMMENT '시퀀스', -- 시퀀스
	`CMS_MENU_SEQ`  INT(38)     NOT NULL COMMENT '메뉴_시퀀스', -- 메뉴_시퀀스
	`GROUP_SEQ`     INT(11)     NOT NULL COMMENT '그룹_시퀀스', -- 그룹_시퀀스
	`GROUP_NM`      VARCHAR(32) NULL     COMMENT '그룹명', -- 그룹명
	`MEMBER_NM`     VARCHAR(30) NULL     COMMENT '회원명', -- 회원명
	`MEMBER_ID`     VARCHAR(30) NULL     COMMENT '회원_ID', -- 회원_ID
	`REG_DT`        DATETIME    NULL     COMMENT '등록일', -- 등록일
	`REG_ID`        VARCHAR(30) NULL     COMMENT '등록자_ID', -- 등록자_ID
	`REG_NM`        VARCHAR(30) NULL     COMMENT '등록자', -- 등록자
	`ORDER_SEQ`     INT(11)     NULL     DEFAULT 1 COMMENT '순서' -- 순서
)
COMMENT '메뉴설정권한회원';

-- 메뉴설정권한회원
ALTER TABLE `mc_cms_permission`
	ADD CONSTRAINT
		PRIMARY KEY (
			`CMS_STAFF_SEQ` -- 시퀀스
		);

ALTER TABLE `mc_cms_permission`
	MODIFY COLUMN `CMS_STAFF_SEQ` INT(11) NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

ALTER TABLE `mc_cms_permission`
	AUTO_INCREMENT = 2;

-- 메뉴컨텐츠_관리회원
CREATE TABLE `mc_cms_staff` (
	`CMS_STAFF_SEQ` INT(11)     NOT NULL COMMENT '시퀀스', -- 시퀀스
	`CMS_MENU_SEQ`  INT(38)     NOT NULL COMMENT '메뉴_시퀀스', -- 메뉴_시퀀스
	`GROUP_SEQ`     INT(11)     NOT NULL COMMENT '그룹_시퀀스', -- 그룹_시퀀스
	`GROUP_NM`      VARCHAR(32) NULL     COMMENT '그룹명', -- 그룹명
	`MEMBER_NM`     VARCHAR(30) NULL     COMMENT '회원명', -- 회원명
	`MEMBER_ID`     VARCHAR(30) NULL     COMMENT '회원_ID', -- 회원_ID
	`REG_DT`        DATETIME    NULL     COMMENT '등록일', -- 등록일
	`REG_ID`        VARCHAR(30) NULL     COMMENT '등록자_ID', -- 등록자_ID
	`REG_NM`        VARCHAR(30) NULL     COMMENT '등록자', -- 등록자
	`ORDER_SEQ`     INT(11)     NULL     DEFAULT 1 COMMENT '순서' -- 순서
)
COMMENT '메뉴컨텐츠_관리회원';

-- 메뉴컨텐츠_관리회원
ALTER TABLE `mc_cms_staff`
	ADD CONSTRAINT
		PRIMARY KEY (
			`CMS_STAFF_SEQ` -- 시퀀스
		);

ALTER TABLE `mc_cms_staff`
	MODIFY COLUMN `CMS_STAFF_SEQ` INT(11) NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

ALTER TABLE `mc_cms_staff`
	AUTO_INCREMENT = 647;

-- 메뉴컨텐츠_관리그룹
CREATE TABLE `mc_cms_staff_group` (
	`SEQ`          INT(11)     NOT NULL COMMENT '시퀀스', -- 시퀀스
	`CMS_MENU_SEQ` INT(38)     NOT NULL COMMENT '메뉴_시퀀스', -- 메뉴_시퀀스
	`GROUP_SEQ`    INT(11)     NOT NULL COMMENT '그룹_시퀀스', -- 그룹_시퀀스
	`GROUP_NM`     VARCHAR(32) NULL     COMMENT '그룹명', -- 그룹명
	`REG_DT`       DATETIME    NULL     COMMENT '등록일', -- 등록일
	`REG_ID`       VARCHAR(30) NULL     COMMENT '등록자_ID', -- 등록자_ID
	`REG_NM`       VARCHAR(30) NULL     COMMENT '등록자', -- 등록자
	`ORDER_SEQ`    INT(11)     NULL     DEFAULT 1 COMMENT '순서' -- 순서
)
COMMENT '메뉴컨텐츠_관리그룹';

-- 메뉴컨텐츠_관리그룹
ALTER TABLE `mc_cms_staff_group`
	ADD CONSTRAINT
		PRIMARY KEY (
			`SEQ` -- 시퀀스
		);

ALTER TABLE `mc_cms_staff_group`
	MODIFY COLUMN `SEQ` INT(11) NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

ALTER TABLE `mc_cms_staff_group`
	AUTO_INCREMENT = 52;

-- 게시물_댓글
CREATE TABLE `mc_comment_sns` (
	`COMMENT_SEQ`  INT(11)       NOT NULL COMMENT '고유번호', -- 고유번호
	`CMS_MENU_SEQ` INT(11)       NOT NULL COMMENT '메뉴번호', -- 메뉴번호
	`ARTICLE_SEQ`  INT(11)       NOT NULL COMMENT '게시물번호', -- 게시물번호
	`PARENT_SEQ`   INT(11)       NULL     COMMENT '부모키', -- 부모키
	`CONTS`        VARCHAR(3000) NOT NULL COMMENT '내용', -- 내용
	`IP`           VARCHAR(16)   NOT NULL COMMENT 'IP', -- 아이피
	`REG_DT`       DATETIME      NOT NULL COMMENT '등록일', -- 등록일
	`REG_ID`       VARCHAR(30)   NULL     COMMENT '등록자ID', -- 등록자_ID
	`REG_NM`       VARCHAR(32)   NOT NULL COMMENT '등록자', -- 등록자
	`DEL_DT`       DATETIME      NULL     COMMENT '삭제일', -- 삭제일
	`DEL_ID`       VARCHAR(30)   NULL     COMMENT '삭제자ID', -- 삭제자_ID
	`DEL_NM`       VARCHAR(32)   NULL     COMMENT '삭제자', -- 삭제자
	`DEL_YN`       CHAR(1)       NOT NULL DEFAULT 'N' COMMENT '삭제여부', -- 삭제여부
	`TWT_YN`       CHAR(1)       NULL     DEFAULT 'N' COMMENT '트위터 보냄', -- 트위터 보냄
	`FACE_YN`      CHAR(1)       NULL     DEFAULT 'N' COMMENT '페이스북 보냄', -- 페이스북 보냄
	`BLOG_YN`      CHAR(1)       NULL     DEFAULT 'N' COMMENT '블로그 보냄', -- 블로그 보냄
	`PROFILE_IMG`  VARCHAR(300)  NULL     COMMENT '프로필 주소', -- 프로필 주소
	`MAIN_ACCOUNT` VARCHAR(30)   NULL     COMMENT '로그인한 계정', -- 로그인한 계정
	`KAO_YN`       CHAR(1)       NULL     DEFAULT 'N' COMMENT '카카오 보냄', -- 카카오 보냄
	`SNS_LINK`     VARCHAR(100)  NULL     COMMENT 'SNS링크' -- SNS링크
)
COMMENT '게시물_댓글';

-- 게시물_댓글
ALTER TABLE `mc_comment_sns`
	ADD CONSTRAINT
		PRIMARY KEY (
			`COMMENT_SEQ` -- 고유번호
		);

-- 게시물_댓글 유니크 인덱스
CREATE UNIQUE INDEX `IDX_MC_COMMENT_SNS`
	ON `mc_comment_sns` ( -- 게시물_댓글
		`ARTICLE_SEQ` ASC,  -- 게시물번호
		`CMS_MENU_SEQ` ASC  -- 메뉴번호
	);

ALTER TABLE `mc_comment_sns`
	MODIFY COLUMN `COMMENT_SEQ` INT(11) NOT NULL AUTO_INCREMENT COMMENT '고유번호';

ALTER TABLE `mc_comment_sns`
	AUTO_INCREMENT = 36;

-- 소셜댓글_계정
CREATE TABLE `mc_comment_sns_account` (
	`SEQ`                  INT(38)      NOT NULL COMMENT '시퀀스', -- 시퀀스
	`TWT_CONSUMER_KEY`     VARCHAR(255) NULL     COMMENT '트위터_컨서머_키', -- 트위터_컨서머_키
	`TWT_CONSUMER_SECRET`  VARCHAR(255) NULL     COMMENT '트위터_컨서머_시크릿', -- 트위터_컨서머_시크릿
	`FACE_APPID`           VARCHAR(255) NULL     COMMENT '페이스북_앱_아이디', -- 페이스북_앱_아이디
	`FACE_APP_SECRET`      VARCHAR(255) NULL     COMMENT '페이스북_앱_시크릿', -- 페이스북_앱_시크릿
	`FACE_ACCESS_TOKEN`    VARCHAR(255) NULL     COMMENT '페이스북_엑세스토큰', -- 페이스북_엑세스토큰
	`NAV_CLIENT_ID`        VARCHAR(255) NULL     COMMENT '네이버_클라이언트_아이디', -- 네이버_클라이언트_아이디
	`NAV_CLIENT_SECRET`    VARCHAR(255) NULL     COMMENT '네이버_클라이언트_시크릿', -- 네이버_클라이언트_시크릿
	`GOOGLE_CLIENT_ID`     VARCHAR(255) NULL     COMMENT '구글_클라이언트_아이디', -- 구글_클라이언트_아이디
	`GOOGLE_CLIENT_SECRET` VARCHAR(255) NULL     COMMENT '구글_클라이언트_시크릿', -- 구글_클라이언트_시크릿
	`INSTA_CLIENT_ID`      VARCHAR(255) NULL     COMMENT '인스타_클라이언트_아이디', -- 인스타_클라이언트_아이디
	`INSTA_CLIENT_SECRET`  VARCHAR(255) NULL     COMMENT '인스타_클라이언트_시크릿', -- 인스타_클라이언트_시크릿
	`KAO_CLIENT_ID`        VARCHAR(255) NULL     COMMENT '카카오_클라이언트_아이디' -- 카카오_클라이언트_아이디
)
COMMENT '소셜댓글_계정';

-- 소셜댓글_계정
ALTER TABLE `mc_comment_sns_account`
	ADD CONSTRAINT
		PRIMARY KEY (
			`SEQ` -- 시퀀스
		);

-- 공통코드목록_상세
CREATE TABLE `mc_common_code` (
	`CODE_SEQ`       INT(38)      NOT NULL COMMENT '시퀀스', -- 시퀀스
	`CODE_GROUP_SEQ` INT(38)      NOT NULL COMMENT '공통코드_시퀀스', -- 공통코드_시퀀스
	`CODE`           VARCHAR(32)  NOT NULL COMMENT '코드값', -- 코드값
	`CODE_NM`        VARCHAR(64)  NOT NULL COMMENT '코드명', -- 코드명
	`VAL1`           VARCHAR(200) NULL     COMMENT 'VAL1', -- VAL1
	`VAL2`           VARCHAR(200) NULL     COMMENT 'VAL2', -- VAL2
	`ETC`            VARCHAR(200) NULL     COMMENT '기타', -- 기타
	`USE_YN`         CHAR(1)      NOT NULL COMMENT '사용여부', -- 사용여부
	`ORDER_SEQ`      INT(38)      NOT NULL DEFAULT 1 COMMENT '순서', -- 순서
	`REG_ID`         VARCHAR(20)  NULL     COMMENT '등록자_ID', -- 등록자_ID
	`REG_NM`         VARCHAR(20)  NULL     COMMENT '등록자', -- 등록자
	`REG_IP`         VARCHAR(15)  NULL     COMMENT '등록자_IP', -- 등록자_IP
	`REG_DT`         DATETIME     NULL     COMMENT '등록일', -- 등록일
	`MOD_ID`         VARCHAR(20)  NULL     COMMENT '수정자_ID', -- 수정자_ID
	`MOD_NM`         VARCHAR(20)  NULL     COMMENT '수정자', -- 수정자
	`MOD_IP`         VARCHAR(15)  NULL     COMMENT '수정자_IP', -- 수정자_IP
	`MOD_DT`         DATETIME     NULL     COMMENT '수정일', -- 수정일
	`DEL_ID`         VARCHAR(20)  NULL     COMMENT '삭제자_ID', -- 삭제자_ID
	`DEL_NM`         VARCHAR(20)  NULL     COMMENT '삭제자', -- 삭제자
	`DEL_IP`         VARCHAR(15)  NULL     COMMENT '삭제자_IP', -- 삭제자_IP
	`DEL_DT`         DATETIME     NULL     COMMENT '삭제일', -- 삭제일
	`DEL_YN`         VARCHAR(1)   NULL     DEFAULT 'N' COMMENT '삭제여부' -- 삭제여부
)
COMMENT '공통코드목록_상세';

-- 공통코드목록_상세
ALTER TABLE `mc_common_code`
	ADD CONSTRAINT
		PRIMARY KEY (
			`CODE_SEQ`,       -- 시퀀스
			`CODE_GROUP_SEQ`  -- 공통코드_시퀀스
		);

ALTER TABLE `mc_common_code`
	MODIFY COLUMN `CODE_SEQ` INT(38) NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

ALTER TABLE `mc_common_code`
	AUTO_INCREMENT = 54;

-- 공통코드목록
CREATE TABLE `mc_common_code_group` (
	`CODE_GROUP_SEQ` INT(38)       NOT NULL COMMENT '공통코드_시퀀스', -- 공통코드_시퀀스
	`GROUP_NM`       VARCHAR(64)   NOT NULL COMMENT '공통코드명', -- 공통코드명
	`CONTS`          VARCHAR(2000) NULL     COMMENT '내용', -- 내용
	`REG_ID`         VARCHAR(20)   NULL     COMMENT '등록자_ID', -- 등록자_ID
	`REG_NM`         VARCHAR(20)   NULL     COMMENT '등록자', -- 등록자
	`REG_IP`         VARCHAR(15)   NULL     COMMENT '등록자_IP', -- 등록자_IP
	`REG_DT`         DATETIME      NULL     COMMENT '등록일', -- 등록일
	`MOD_ID`         VARCHAR(20)   NULL     COMMENT '수정자_ID', -- 수정자_ID
	`MOD_NM`         VARCHAR(20)   NULL     COMMENT '수정자', -- 수정자
	`MOD_IP`         VARCHAR(15)   NULL     COMMENT '수정자_IP', -- 수정자_IP
	`MOD_DT`         DATETIME      NULL     COMMENT '수정일', -- 수정일
	`DEL_ID`         VARCHAR(20)   NULL     COMMENT '삭제자_ID', -- 삭제자_ID
	`DEL_NM`         VARCHAR(20)   NULL     COMMENT '삭제자', -- 삭제자
	`DEL_IP`         VARCHAR(15)   NULL     COMMENT '삭제자_IP', -- 삭제자_IP
	`DEL_DT`         DATETIME      NULL     COMMENT '삭제일', -- 삭제일
	`DEL_YN`         VARCHAR(1)    NULL     DEFAULT 'N' COMMENT '삭제여부' -- 삭제여부
)
COMMENT '공통코드목록';

-- 공통코드목록
ALTER TABLE `mc_common_code_group`
	ADD CONSTRAINT
		PRIMARY KEY (
			`CODE_GROUP_SEQ` -- 공통코드_시퀀스
		);

ALTER TABLE `mc_common_code_group`
	MODIFY COLUMN `CODE_GROUP_SEQ` INT(38) NOT NULL AUTO_INCREMENT COMMENT '공통코드_시퀀스';

ALTER TABLE `mc_common_code_group`
	AUTO_INCREMENT = 5;

-- 관리자그룹
CREATE TABLE `mc_group` (
	`GROUP_SEQ`        INT(38)      NOT NULL COMMENT '그룹_시퀀스', -- 그룹_시퀀스
	`GROUP_NM`         VARCHAR(32)  NOT NULL COMMENT '그룹명', -- 그룹명
	`PARENT_SEQ`       INT(38)      NULL     COMMENT '부모그룹_시퀀스', -- 부모그룹_시퀀스
	`USE_YN`           CHAR(1)      NOT NULL DEFAULT 'Y' COMMENT '사용여부', -- 사용여부
	`REG_DT`           DATETIME     NOT NULL COMMENT '등록일', -- 등록일
	`MOD_DT`           DATETIME     NULL     COMMENT '수정일', -- 수정일
	`DEL_DT`           DATETIME     NULL     COMMENT '삭제일', -- 삭제일
	`DEL_YN`           CHAR(1)      NOT NULL DEFAULT 'N' COMMENT '삭제여부', -- 삭제여부
	`ORDER_SEQ`        INT(38)      NOT NULL DEFAULT 1 COMMENT '순서', -- 순서
	`REG_NM`           VARCHAR(32)  NULL     COMMENT '등록자', -- 등록자
	`MOD_NM`           VARCHAR(32)  NULL     COMMENT '수정자', -- 수정자
	`DEL_NM`           VARCHAR(32)  NULL     COMMENT '삭제자', -- 삭제자
	`MOD_ID`           VARCHAR(30)  NULL     COMMENT '수정자_ID', -- 수정자_ID
	`DEL_ID`           VARCHAR(30)  NULL     COMMENT '삭제자_ID', -- 삭제자_ID
	`REG_ID`           VARCHAR(30)  NULL     COMMENT '등록자_ID', -- 등록자_ID
	`TEL`              VARCHAR(13)  NULL     COMMENT '전화번호', -- 전화번호
	`FAX`              VARCHAR(13)  NULL     COMMENT '팩스번호', -- 팩스번호
	`RESPONSIBILITIES` VARCHAR(500) NULL     COMMENT '상세내용', -- 상세내용
	`MANAGE_SEQ`       INT(38)      NULL     COMMENT '관리_시퀀스' -- 관리_시퀀스
)
COMMENT '관리자그룹';

-- 관리자그룹
ALTER TABLE `mc_group`
	ADD CONSTRAINT
		PRIMARY KEY (
			`GROUP_SEQ` -- 그룹_시퀀스
		);

-- IDX_GROUP_SORTORDER
CREATE INDEX `IDX_GROUP_SORTORDER`
	ON `mc_group`( -- 관리자그룹
		`PARENT_SEQ`, -- 부모그룹_시퀀스
		`ORDER_SEQ`   -- 순서
	);

ALTER TABLE `mc_group`
	MODIFY COLUMN `GROUP_SEQ` INT(38) NOT NULL AUTO_INCREMENT COMMENT '그룹_시퀀스';

ALTER TABLE `mc_group`
	AUTO_INCREMENT = 15;

-- 휴일관리
CREATE TABLE `mc_holiday` (
	`HOLIDAY_SEQ` INT(38)     NOT NULL COMMENT '시퀀스', -- 시퀀스
	`HOLIDAY`     VARCHAR(30) NULL     COMMENT '휴일', -- 휴일
	`TITLE`       VARCHAR(32) NULL     COMMENT '제목', -- 제목
	`LUNAR_CAL`   VARCHAR(30) NULL     COMMENT '음력', -- 음력
	`SUN_CAL`     VARCHAR(30) NULL     COMMENT '양력', -- 양력
	`REG_ID`      VARCHAR(30) NULL     COMMENT '등록자_ID', -- 등록자_ID
	`REG_NM`      VARCHAR(32) NULL     COMMENT '등록자', -- 등록자
	`REG_DT`      DATETIME    NULL     COMMENT '등록일', -- 등록일
	`MOD_ID`      VARCHAR(30) NULL     COMMENT '수정자_ID', -- 수정자_ID
	`MOD_NM`      VARCHAR(32) NULL     COMMENT '수정자', -- 수정자
	`MOD_DT`      DATETIME    NULL     COMMENT '수정일', -- 수정일
	`DEL_ID`      VARCHAR(30) NULL     COMMENT '삭제자_ID', -- 삭제자_ID
	`DEL_NM`      VARCHAR(32) NULL     COMMENT '삭제자', -- 삭제자
	`DEL_DT`      DATETIME    NULL     COMMENT '삭제일', -- 삭제일
	`DEL_YN`      CHAR(1)     NOT NULL DEFAULT 'N' COMMENT '삭제여부' -- 삭제여부
)
COMMENT '휴일관리';

-- 휴일관리
ALTER TABLE `mc_holiday`
	ADD CONSTRAINT
		PRIMARY KEY (
			`HOLIDAY_SEQ` -- 시퀀스
		);

ALTER TABLE `mc_holiday`
	MODIFY COLUMN `HOLIDAY_SEQ` INT(38) NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

ALTER TABLE `mc_holiday`
	AUTO_INCREMENT = 519;

-- 관리자_허용아이피
CREATE TABLE `mc_ip_allow` (
	`SEQ`    INT(38)      NOT NULL COMMENT '시퀀스', -- 시퀀스
	`IP`     VARCHAR(100) NULL     COMMENT '아이피', -- 아이피
	`TITLE`  VARCHAR(200) NULL     COMMENT '제목', -- 제목
	`REG_ID` VARCHAR(30)  NULL     COMMENT '등록자_ID', -- 등록자_ID
	`REG_NM` VARCHAR(32)  NULL     COMMENT '등록자', -- 등록자
	`REG_DT` DATETIME     NULL     COMMENT '등록일', -- 등록일
	`MOD_ID` VARCHAR(30)  NULL     COMMENT '수정자_ID', -- 수정자_ID
	`MOD_NM` VARCHAR(32)  NULL     COMMENT '수정자', -- 수정자
	`MOD_DT` DATETIME     NULL     COMMENT '수정일', -- 수정일
	`DEL_ID` VARCHAR(30)  NULL     COMMENT '삭제자_ID', -- 삭제자_ID
	`DEL_NM` VARCHAR(32)  NULL     COMMENT '삭제자', -- 삭제자
	`DEL_DT` DATETIME     NULL     COMMENT '삭제일', -- 삭제일
	`DEL_YN` CHAR(1)      NOT NULL DEFAULT 'N' COMMENT '삭제여부' -- 삭제여부
)
COMMENT '관리자_허용아이피';

-- 관리자_허용아이피
ALTER TABLE `mc_ip_allow`
	ADD CONSTRAINT
		PRIMARY KEY (
			`SEQ` -- 시퀀스
		);

ALTER TABLE `mc_ip_allow`
	MODIFY COLUMN `SEQ` INT(38) NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

ALTER TABLE `mc_ip_allow`
	AUTO_INCREMENT = 24;

-- 메인_레이아웃설정
CREATE TABLE `mc_layout` (
	`SEQ`     INT(11)      NOT NULL COMMENT '레이아웃_시퀀스', -- 레이아웃_시퀀스
	`SITE_ID` INT(11)      NULL     COMMENT '사이트_ID', -- 사이트_ID
	`IDX`     INT(11)      NULL     COMMENT '정렬순서', -- 정렬순서
	`COL_CNT` INT(11)      NULL     COMMENT '가로사이즈', -- 가로사이즈
	`ROW_CNT` INT(11)      NULL     COMMENT '세로사이즈', -- 세로사이즈
	`TITLE`   VARCHAR(100) NULL     COMMENT '제목', -- 제목
	`TAB_YN`  CHAR(1)      NULL     DEFAULT 'N' COMMENT '탭_사용여부' -- 탭_사용여부
)
COMMENT '메인_레이아웃설정';

-- 메인_레이아웃설정
ALTER TABLE `mc_layout`
	ADD CONSTRAINT
		PRIMARY KEY (
			`SEQ` -- 레이아웃_시퀀스
		);

ALTER TABLE `mc_layout`
	MODIFY COLUMN `SEQ` INT(11) NOT NULL AUTO_INCREMENT COMMENT '레이아웃_시퀀스';

ALTER TABLE `mc_layout`
	AUTO_INCREMENT = 1;

-- 레이아웃_설정
CREATE TABLE `mc_layout_detail` (
	`PARENT_SEQ` INT(11)      NULL COMMENT '부모키', -- 레이아웃_시퀀스
	`IDX`        INT(11)      NULL COMMENT '정렬순서', -- 정렬순서
	`COM_TYPE`   INT(11)      NULL COMMENT '타입', -- 타입
	`TAB_TITLE`  VARCHAR(100) NULL COMMENT '탭 제목', -- 탭 제목
	`CONTS`      TEXT         NULL COMMENT '내용', -- 내용
	`BOARD_SEQ`  INT(11)      NULL COMMENT '게시판 번호', -- 게시판 번호
	`BOARD_SEQS` VARCHAR(100) NULL COMMENT '게시판 번호(복합)', -- 게시판 번호(복합)
	`COUNT`      INT(11)      NULL COMMENT '건수', -- 건수
	`LINK_URL`   VARCHAR(100) NULL COMMENT '바로가기페이지' -- 바로가기페이지
)
COMMENT '레이아웃_설정';

-- 메일발송목록
CREATE TABLE `mc_mail` (
	`SEQ`         INT(11)      NOT NULL COMMENT '메일발송_시퀀스', -- 메일발송_시퀀스
	`TITLE`       VARCHAR(200) NOT NULL COMMENT '제목', -- 제목
	`CONTS`       TEXT         NULL     COMMENT '내용', -- 내용
	`SENDER_NM`   VARCHAR(200) NOT NULL COMMENT '보내는사람', -- 보내는사람
	`SENDER_MAIL` VARCHAR(200) NOT NULL COMMENT '보내는사람_이메일', -- 보내는사람_이메일
	`STATUS`      VARCHAR(2)   NOT NULL COMMENT '상태', -- 상태
	`REG_ID`      VARCHAR(50)  NOT NULL COMMENT '등록자_ID', -- 등록자_ID
	`REG_NM`      VARCHAR(32)  NOT NULL COMMENT '등록자', -- 등록자
	`REG_DT`      DATETIME     NULL     COMMENT '등록일', -- 등록일
	`MOD_ID`      VARCHAR(50)  NULL     COMMENT '수정자_ID', -- 수정자_ID
	`MOD_NM`      VARCHAR(32)  NULL     COMMENT '수정자', -- 수정자
	`MOD_DT`      DATETIME     NULL     COMMENT '수정일', -- 수정일
	`TARGET_SEQ`  INT(11)      NULL     COMMENT '수신자그룹_시퀀스', -- 수신자그룹_시퀀스
	`FORM_SEQ`    INT(11)      NULL     COMMENT '메일양식_시퀀스' -- 메일양식_시퀀스
)
COMMENT '메일발송목록';

-- 메일발송목록
ALTER TABLE `mc_mail`
	ADD CONSTRAINT
		PRIMARY KEY (
			`SEQ` -- 메일발송_시퀀스
		);

ALTER TABLE `mc_mail`
	MODIFY COLUMN `SEQ` INT(11) NOT NULL AUTO_INCREMENT COMMENT '메일발송_시퀀스';

ALTER TABLE `mc_mail`
	AUTO_INCREMENT = 2;

-- 메일양식
CREATE TABLE `mc_mail_form` (
	`SEQ`   INT(11)      NOT NULL COMMENT '메일양식_시퀀스', -- 메일양식_시퀀스
	`TITLE` VARCHAR(100) NOT NULL COMMENT '메일양식명', -- 메일양식명
	`CONTS` TEXT         NULL     COMMENT '메일양식내용' -- 메일양식내용
)
COMMENT '메일양식';

-- 메일양식
ALTER TABLE `mc_mail_form`
	ADD CONSTRAINT
		PRIMARY KEY (
			`SEQ` -- 메일양식_시퀀스
		);

ALTER TABLE `mc_mail_form`
	MODIFY COLUMN `SEQ` INT(11) NOT NULL AUTO_INCREMENT COMMENT '메일양식_시퀀스';

ALTER TABLE `mc_mail_form`
	AUTO_INCREMENT = 2;

-- 메일발송_대기목록
CREATE TABLE `mc_mail_queue` (
	`SEQ`        INT(11)     NOT NULL COMMENT '시퀀스', -- 시퀀스
	`P_SEQ`      INT(11)     NOT NULL COMMENT '메일발송_시퀀스', -- 메일발송_시퀀스
	`USER_NAME`  VARCHAR(50) NOT NULL COMMENT '수신자', -- 수신자
	`USER_EMAIL` VARCHAR(50) NOT NULL COMMENT '수신자_이메일', -- 수신자_이메일
	`STATUS`     CHAR(1)     NULL     COMMENT '상태' -- 상태
)
COMMENT '메일발송_대기목록';

-- 메일발송_대기목록
ALTER TABLE `mc_mail_queue`
	ADD CONSTRAINT
		PRIMARY KEY (
			`SEQ` -- 시퀀스
		);

ALTER TABLE `mc_mail_queue`
	MODIFY COLUMN `SEQ` INT(11) NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

ALTER TABLE `mc_mail_queue`
	AUTO_INCREMENT = 2;

-- 메일서버설정
CREATE TABLE `mc_mail_smtp` (
	`SEQ`     INT(11)      NOT NULL COMMENT '시퀀스', -- 시퀀스
	`TITLE`   VARCHAR(200) NOT NULL COMMENT '호스트명', -- 호스트명
	`HOST`    VARCHAR(100) NOT NULL COMMENT '호스트', -- 호스트
	`PORT`    INT(11)      NOT NULL COMMENT '포트', -- 포트
	`AUTH_ID` VARCHAR(200) NOT NULL COMMENT '인증_ID', -- 인증_ID
	`AUTH_PW` VARCHAR(200) NOT NULL COMMENT '인증_PW', -- 인증_PW
	`SSL_YN`  VARCHAR(2)   NOT NULL COMMENT 'SSL_YN', -- SSL_YN
	`TLS_YN`  VARCHAR(2)   NOT NULL COMMENT 'TLS_YN' -- TLS_YN
)
COMMENT '메일서버설정';

-- 메일서버설정
ALTER TABLE `mc_mail_smtp`
	ADD CONSTRAINT
		PRIMARY KEY (
			`SEQ` -- 시퀀스
		);

ALTER TABLE `mc_mail_smtp`
	MODIFY COLUMN `SEQ` INT(11) NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

ALTER TABLE `mc_mail_smtp`
	AUTO_INCREMENT = 2;

-- 수신자_그룹
CREATE TABLE `mc_mail_target` (
	`SEQ`        INT(11)      NOT NULL COMMENT '수신자그룹_시퀀스', -- 수신자그룹_시퀀스
	`TITLE`      VARCHAR(100) NOT NULL COMMENT '수신자그룹명', -- 수신자그룹명
	`TARGET_CNT` INT(11)      NULL     COMMENT '수신자수' -- 수신자수
)
COMMENT '수신자_그룹';

-- 수신자_그룹
ALTER TABLE `mc_mail_target`
	ADD CONSTRAINT
		PRIMARY KEY (
			`SEQ` -- 수신자그룹_시퀀스
		);

ALTER TABLE `mc_mail_target`
	MODIFY COLUMN `SEQ` INT(11) NOT NULL AUTO_INCREMENT COMMENT '수신자그룹_시퀀스';

ALTER TABLE `mc_mail_target`
	AUTO_INCREMENT = 2;

-- 수신자_그룹상세
CREATE TABLE `mc_mail_target_list` (
	`SEQ`        INT(11)     NOT NULL COMMENT '시퀀스', -- 시퀀스
	`P_SEQ`      INT(11)     NOT NULL COMMENT '수신자그룹_시퀀스', -- 수신자그룹_시퀀스
	`USER_NAME`  VARCHAR(50) NOT NULL COMMENT '수신자', -- 수신자
	`USER_EMAIL` VARCHAR(50) NOT NULL COMMENT '수신자_이메일' -- 수신자_이메일
)
COMMENT '수신자_그룹상세';

-- 수신자_그룹상세
ALTER TABLE `mc_mail_target_list`
	ADD CONSTRAINT
		PRIMARY KEY (
			`SEQ` -- 시퀀스
		);

ALTER TABLE `mc_mail_target_list`
	MODIFY COLUMN `SEQ` INT(11) NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

ALTER TABLE `mc_mail_target_list`
	AUTO_INCREMENT = 2;

-- 관리회원
CREATE TABLE `mc_member` (
	`MEMBER_ID`        VARCHAR(30)  NOT NULL COMMENT '회원_ID', -- 회원_ID
	`MEMBER_PW`        VARCHAR(100) NULL     COMMENT '회원_패스워드', -- 회원_패스워드
	`MEMBER_NM`        VARCHAR(30)  NULL     COMMENT '회원명', -- 회원명
	`EMAIL`            VARCHAR(100) NULL     COMMENT '이메일', -- 이메일
	`TEL`              VARCHAR(15)  NULL     COMMENT '전화번호', -- 전화번호
	`CELL`             VARCHAR(15)  NULL     COMMENT '휴대폰번호', -- 휴대폰번호
	`GROUP_SEQ`        INT(11)      NULL     COMMENT '관리자_그룹시퀀스', -- 관리자_그룹시퀀스
	`LAST_LOGIN`       DATETIME     NULL     COMMENT '마지막_로그인시간', -- 마지막_로그인시간
	`MOD_ID`           VARCHAR(30)  NULL     COMMENT '수정자_ID', -- 수정자_ID
	`MOD_NM`           VARCHAR(30)  NULL     COMMENT '수정자', -- 수정자
	`MOD_DT`           DATETIME     NULL     COMMENT '수정일', -- 수정일
	`DEL_ID`           VARCHAR(30)  NULL     COMMENT '삭제자_ID', -- 삭제자_ID
	`DEL_NM`           VARCHAR(30)  NULL     COMMENT '삭제자', -- 삭제자
	`DEL_DT`           DATETIME     NULL     COMMENT '삭제일', -- 삭제일
	`USE_YN`           CHAR(1)      NULL     DEFAULT 'Y' COMMENT '사용여부', -- 사용여부
	`DEL_YN`           CHAR(1)      NULL     DEFAULT 'N' COMMENT '삭제여부', -- 삭제여부
	`ORDER_SEQ`        INT(11)      NULL     COMMENT '순서', -- 순서
	`RESPONSIBILITIES` VARCHAR(500) NULL     COMMENT '담당업무', -- 담당업무
	`POSITIONS`        VARCHAR(100) NULL     COMMENT '직위', -- 직위
	`BLOCK_YN`         CHAR(1)      NOT NULL DEFAULT 'N' COMMENT '블록여부', -- 블록여부
	`LOGIN_FAIL_CNT`   INT(11)      NOT NULL DEFAULT 0 COMMENT '로그인_시도횟수', -- 로그인_시도횟수
	`LAST_PW_DT`       DATE         NULL     COMMENT '마지막_패스워드변경일', -- 마지막_패스워드변경일
	`DI`               VARCHAR(100) NULL     COMMENT 'DI', -- DI
	`BIRTH`            VARCHAR(8)   NULL     COMMENT '생년월일', -- 생년월일
	`EMAIL_YN`         CHAR(1)      NULL     DEFAULT 'N' COMMENT '이메일발송_허용', -- 이메일발송_허용
	`SMS_YN`           CHAR(1)      NULL     DEFAULT 'N' COMMENT 'SMS발송_허용', -- SMS발송_허용
	`REG_DT`           DATETIME     NULL     COMMENT '등록일', -- 등록일
	`MOD_IP`           VARCHAR(16)  NULL     COMMENT '수정자_IP', -- 수정자_IP
	`DORMANCY_YN`      CHAR(1)      NULL     DEFAULT 'N' COMMENT '휴면계정_여부', -- 휴면계정_여부
	`MADE_YN`          CHAR(1)      NULL     DEFAULT 'N' COMMENT '관리자 직접등록여부' -- 관리자 직접등록여부
)
COMMENT '관리회원';

-- 관리회원
ALTER TABLE `mc_member`
	ADD CONSTRAINT
		PRIMARY KEY (
			`MEMBER_ID` -- 회원_ID
		);

-- 관리자회원_변경이력
CREATE TABLE `mc_member_history` (
	`SEQ`       INT(11)       NOT NULL COMMENT '시퀀스', -- 시퀀스
	`MEMBER_ID` VARCHAR(30)   NULL     COMMENT '회원_ID', -- 회원_ID
	`MEMBER_NM` VARCHAR(30)   NULL     COMMENT '회원명', -- 회원명
	`MOD_ID`    VARCHAR(30)   NULL     COMMENT '수정자_ID', -- 수정자_ID
	`MOD_NM`    VARCHAR(30)   NULL     COMMENT '수정자', -- 수정자
	`MOD_DT`    DATETIME      NULL     COMMENT '수정일', -- 수정일
	`MOD_IP`    VARCHAR(16)   NULL     COMMENT '수정자_IP', -- 수정자_IP
	`CONTS`     VARCHAR(2000) NULL     COMMENT '변경내용' -- 변경내용
)
COMMENT '관리자회원_변경이력';

-- 관리자회원_변경이력
ALTER TABLE `mc_member_history`
	ADD CONSTRAINT
		PRIMARY KEY (
			`SEQ` -- 시퀀스
		);

ALTER TABLE `mc_member_history`
	MODIFY COLUMN `SEQ` INT(11) NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

ALTER TABLE `mc_member_history`
	AUTO_INCREMENT = 260;

-- 메뉴별_개인정보_결과
CREATE TABLE `mc_personal_data` (
	`SEQ`          INT(38)      NOT NULL COMMENT '시퀀스', -- 시퀀스
	`CMS_MENU_SEQ` INT(38)      NULL     COMMENT '메뉴_시퀀스', -- 메뉴_시퀀스
	`SITE_ID`      INT(38)      NULL     DEFAULT 1 COMMENT '사이트_ID', -- 사이트_ID
	`SUB_SEQ`      INT(11)      NULL     COMMENT '보조_시퀀스', -- 보조_시퀀스
	`MENU_NM`      VARCHAR(255) NOT NULL COMMENT '메뉴명', -- 메뉴명
	`TITLE`        VARCHAR(200) NULL     COMMENT '제목', -- 제목
	`REG_DT`       DATETIME     NULL     COMMENT '등록일', -- 등록일
	`JUMIN_CNT`    INT(38)      NULL     DEFAULT 0 COMMENT '주민번호_건수', -- 주민번호_건수
	`JUMIN_CONTS`  TEXT         NULL     COMMENT '주민번호_상세', -- 주민번호_상세
	`BUSINO_CNT`   INT(38)      NULL     DEFAULT 0 COMMENT '사업자번호_건수', -- 사업자번호_건수
	`BUSINO_CONTS` TEXT         NULL     COMMENT '사업자번호_상세', -- 사업자번호_상세
	`BUBINO_CNT`   INT(38)      NULL     DEFAULT 0 COMMENT '법인번호_건수', -- 법인번호_건수
	`BUBINO_CONTS` TEXT         NULL     COMMENT '법인번호_상세', -- 법인번호_상세
	`EMAIL_CNT`    INT(38)      NULL     DEFAULT 0 COMMENT '이메일_건수', -- 이메일_건수
	`EMAIL_CONTS`  TEXT         NULL     COMMENT '이메일_상세', -- 이메일_상세
	`CELL_CNT`     INT(38)      NULL     DEFAULT 0 COMMENT '휴대폰_건수', -- 휴대폰_건수
	`CELL_CONTS`   TEXT         NULL     COMMENT '휴대폰_상세', -- 휴대폰_상세
	`TEL_CNT`      INT(38)      NULL     DEFAULT 0 COMMENT '전화번호_건수', -- 전화번호_건수
	`TEL_CONTS`    TEXT         NULL     COMMENT '전화번호_상세', -- 전화번호_상세
	`CARD_CNT`     INT(38)      NULL     DEFAULT 0 COMMENT '카드_건수', -- 카드_건수
	`CARD_CONTS`   TEXT         NULL     COMMENT '카드_상세' -- 카드_상세
)
COMMENT '메뉴별_개인정보_결과';

-- 메뉴별_개인정보_결과
ALTER TABLE `mc_personal_data`
	ADD CONSTRAINT
		PRIMARY KEY (
			`SEQ` -- 시퀀스
		);

ALTER TABLE `mc_personal_data`
	MODIFY COLUMN `SEQ` INT(38) NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

ALTER TABLE `mc_personal_data`
	AUTO_INCREMENT = 8;

-- 설문조사
CREATE TABLE `mc_poll` (
	`POLL_SEQ`      INT(11)      NOT NULL COMMENT '설문조사_시퀀스', -- 설문조사_시퀀스
	`TITLE`         VARCHAR(500) NOT NULL COMMENT '제목', -- 제목
	`CONTENT`       TEXT         NULL     COMMENT '내용', -- 내용
	`START_DT`      DATETIME     NOT NULL COMMENT '시작일', -- 시작일
	`END_DT`        DATETIME     NOT NULL COMMENT '종료일', -- 종료일
	`REG_ID`        VARCHAR(50)  NOT NULL COMMENT '등록자_ID', -- 등록자_ID
	`REG_NM`        VARCHAR(32)  NOT NULL COMMENT '등록자', -- 등록자
	`REG_DT`        DATETIME     NOT NULL COMMENT '등록일', -- 등록일
	`MOD_ID`        VARCHAR(50)  NULL     COMMENT '수정자_ID', -- 수정자_ID
	`MOD_NM`        VARCHAR(32)  NULL     COMMENT '수정자', -- 수정자
	`MOD_DT`        DATETIME     NULL     COMMENT '수정일', -- 수정일
	`DEL_ID`        VARCHAR(50)  NULL     COMMENT '삭제자_ID', -- 삭제자_ID
	`DEL_NM`        VARCHAR(32)  NULL     COMMENT '삭제자', -- 삭제자
	`DEL_DT`        DATETIME     NULL     COMMENT '삭제일', -- 삭제일
	`DEL_YN`        CHAR(1)      NOT NULL COMMENT '삭제여부', -- 삭제여부
	`USE_YN`        CHAR(1)      NOT NULL COMMENT '사용여부', -- 사용여부
	`LOT_YN`        CHAR(1)      NOT NULL COMMENT '개인정보_수집여부', -- 개인정보_수집여부
	`CMS_MENU_SEQ`  INT(11)      NOT NULL COMMENT '메뉴_시퀀스', -- 메뉴_시퀀스
	`CUD_GROUP_SEQ` VARCHAR(150) NULL     COMMENT '설문대상_시퀀스', -- 설문대상_시퀀스
	`DUP_YN`        CHAR(1)      NULL     DEFAULT 'N' COMMENT '중복설문_가능여부' -- 중복설문_가능여부
)
COMMENT '설문조사';

-- 설문조사
ALTER TABLE `mc_poll`
	ADD CONSTRAINT
		PRIMARY KEY (
			`POLL_SEQ` -- 설문조사_시퀀스
		);

ALTER TABLE `mc_poll`
	MODIFY COLUMN `POLL_SEQ` INT(11) NOT NULL AUTO_INCREMENT COMMENT '설문조사_시퀀스';

ALTER TABLE `mc_poll`
	AUTO_INCREMENT = 1;

-- 설문조사_응답보기
CREATE TABLE `mc_poll_answer` (
	`POLL_SEQ`     INT(11)      NOT NULL COMMENT '설문조사_시퀀스', -- 설문조사_시퀀스
	`QUESTION_SEQ` INT(11)      NOT NULL COMMENT '질문_시퀀스', -- 질문_시퀀스
	`ANSWER_SEQ`   INT(11)      NOT NULL COMMENT '답변_시퀀스', -- 답변_시퀀스
	`ANSWER`       VARCHAR(126) NOT NULL COMMENT '답변', -- 답변
	`NULL_CHK`     CHAR(1)      NULL     COMMENT '널_체크', -- 널_체크
	`JUMP_CHK`     CHAR(1)      NULL     COMMENT '건너띄기_체크', -- 건너띄기_체크
	`DEL_YN`       CHAR(1)      NOT NULL COMMENT '삭제여부' -- 삭제여부
)
COMMENT '설문조사_응답보기';

-- 설문조사_응답보기
ALTER TABLE `mc_poll_answer`
	ADD CONSTRAINT `PK_mc_poll_answer` -- 설문조사_응답보기 기본키
		PRIMARY KEY (
			`POLL_SEQ`,     -- 설문조사_시퀀스
			`QUESTION_SEQ`, -- 질문_시퀀스
			`ANSWER_SEQ`    -- 답변_시퀀스
		);

-- 설문조사_질문지
CREATE TABLE `mc_poll_question` (
	`POLL_SEQ`                INT(11)      NOT NULL COMMENT '설문조사_시퀀스', -- 설문조사_시퀀스
	`QUESTION_SEQ`            INT(11)      NOT NULL COMMENT '질문_시퀀스', -- 질문_시퀀스
	`QUESTION`                VARCHAR(500) NOT NULL COMMENT '질문', -- 질문
	`QUESTION_TYPE`           CHAR(1)      NOT NULL COMMENT '질문_타입', -- 질문_타입
	`QUESTION_CONTENT`        TEXT         NULL     COMMENT '질문_내용', -- 질문_내용
	`DEL_YN`                  CHAR(1)      NOT NULL COMMENT '삭제여부', -- 삭제여부
	`SUBJECT_YN`              CHAR(1)      NULL     DEFAULT 'N' COMMENT '소제목_여부', -- 소제목_여부
	`REQUIRED_YN`             CHAR(1)      NULL     DEFAULT 'N' COMMENT '필수_여부', -- 필수_여부
	`REQUIRED_COUNT`          INT          NULL     DEFAULT 0 COMMENT '다중선택_갯수', -- 다중선택_갯수
	`REQUIRED_COUNT_CONTROLL` CHAR(1)      NULL     DEFAULT 'U' COMMENT '다중선택_미만_이상_선택' -- 다중선택_미만_이상_선택
)
COMMENT '설문조사_질문지';

-- 설문조사_질문지
ALTER TABLE `mc_poll_question`
	ADD CONSTRAINT `PK_mc_poll_question` -- 설문조사_질문지 기본키
		PRIMARY KEY (
			`POLL_SEQ`,     -- 설문조사_시퀀스
			`QUESTION_SEQ`  -- 질문_시퀀스
		);

-- 설문조사_결과
CREATE TABLE `mc_poll_result` (
	`POLL_SEQ`     INT(11)      NOT NULL COMMENT '설문조사_시퀀스', -- 설문조사_시퀀스
	`QUESTION_SEQ` INT(11)      NOT NULL COMMENT '질문지_시퀀스', -- 질문지_시퀀스
	`ANSWER_SEQ`   INT(11)      NOT NULL COMMENT '답변_시퀀스', -- 답변_시퀀스
	`ANSWER`       VARCHAR(126) NOT NULL COMMENT '답변', -- 답변
	`REG_DT`       DATETIME     NOT NULL COMMENT '등록일', -- 등록일
	`REG_ID`       VARCHAR(50)  NOT NULL COMMENT '등록자_ID', -- 등록자_ID
	`REG_NM`       VARCHAR(32)  NOT NULL COMMENT '등록자', -- 등록자
	`REG_EMAIL`    VARCHAR(126) NULL     COMMENT '작성자_메일', -- 작성자_메일
	`REG_TEL`      VARCHAR(32)  NULL     COMMENT '작성자_전화번호', -- 작성자_전화번호
	`REG_SEQ`      INT(11)      NOT NULL COMMENT '작성_시퀀스', -- 작성_시퀀스
	`LOT_WIN`      CHAR(1)      NULL     COMMENT '개인정보수집동의여부' -- 개인정보수집동의여부
)
COMMENT '설문조사_결과';

-- 팝업_목록
CREATE TABLE `mc_popupzone` (
	`POPUPZONE_SEQ` INT(38)      NOT NULL COMMENT '스퀀스', -- 스퀀스
	`TITLE`         VARCHAR(128) NULL     COMMENT '제목', -- 제목
	`LINK_YN`       CHAR(1)      NULL     COMMENT '링크_사용여부', -- 링크_사용여부
	`LINK_URL`      VARCHAR(256) NULL     COMMENT '링크_URL', -- 링크_URL
	`LINK_TARGET`   VARCHAR(16)  NULL     COMMENT '새창', -- 새창
	`FILE_PATH`     VARCHAR(128) NULL     COMMENT '파일경로', -- 파일경로
	`USE_YN`        CHAR(1)      NULL     COMMENT '사용여부', -- 사용여부
	`ORDER_SEQ`     VARCHAR(5)   NULL     DEFAULT '99999' COMMENT '순서', -- 순서
	`REG_DT`        DATETIME     NULL     COMMENT '등록일', -- 등록일
	`REG_ID`        VARCHAR(30)  NULL     COMMENT '등록자_ID', -- 등록자_ID
	`REG_NM`        VARCHAR(32)  NULL     COMMENT '등록자', -- 등록자
	`MOD_DT`        DATETIME     NULL     COMMENT '수정일', -- 수정일
	`MOD_ID`        VARCHAR(30)  NULL     COMMENT '수정자_ID', -- 수정자_ID
	`MOD_NM`        VARCHAR(32)  NULL     COMMENT '수정자', -- 수정자
	`DEL_DT`        DATETIME     NULL     COMMENT '삭제일', -- 삭제일
	`DEL_ID`        VARCHAR(30)  NULL     COMMENT '삭제자_ID', -- 삭제자_ID
	`DEL_NM`        VARCHAR(32)  NULL     COMMENT '삭제자', -- 삭제자
	`DEL_YN`        CHAR(1)      NULL     DEFAULT 'N' COMMENT '삭제여부', -- 삭제여부
	`START_DT`      DATETIME     NULL     COMMENT '게시_시작일', -- 게시_시작일
	`END_DT`        DATETIME     NULL     COMMENT '게시_종료일', -- 게시_종료일
	`ALT`           VARCHAR(500) NULL     COMMENT '설명', -- 설명
	`X_COORD`       VARCHAR(20)  NULL     COMMENT 'X좌표', -- X좌표
	`Y_COORD`       VARCHAR(20)  NULL     COMMENT 'Y좌표', -- Y좌표
	`SITE_ID`       VARCHAR(20)  NULL     COMMENT '사이트_ID', -- 사이트_ID
	`SELECTER`      VARCHAR(20)  NULL     COMMENT '구분' -- 구분
)
COMMENT '팝업_목록';

-- 팝업_목록
ALTER TABLE `mc_popupzone`
	ADD CONSTRAINT
		PRIMARY KEY (
			`POPUPZONE_SEQ` -- 스퀀스
		);

ALTER TABLE `mc_popupzone`
	MODIFY COLUMN `POPUPZONE_SEQ` INT(38) NOT NULL AUTO_INCREMENT COMMENT '스퀀스';

ALTER TABLE `mc_popupzone`
	AUTO_INCREMENT = 43;

-- 프로그램목록
CREATE TABLE `mc_programs` (
	`SEQ`        INT(32)      NOT NULL COMMENT '시퀀스', -- 시퀀스
	`PROGRAM_NM` VARCHAR(100) NULL     COMMENT '프로그램명', -- 프로그램명
	`URL`        VARCHAR(200) NULL     COMMENT '프로그램_URL', -- 프로그램_URL
	`MANAGE_URL` VARCHAR(200) NULL     COMMENT '프로그램관리_URL', -- 프로그램관리_URL
	`INNER_YN`   CHAR(1)      NULL     COMMENT '프로그램관리_사용여부', -- 프로그램관리_사용여부
	`REG_ID`     VARCHAR(30)  NULL     COMMENT '등록자_ID', -- 등록자_ID
	`REG_NM`     VARCHAR(32)  NULL     COMMENT '등록자', -- 등록자
	`REG_DT`     DATETIME     NULL     COMMENT '등록일', -- 등록일
	`MOD_ID`     VARCHAR(30)  NULL     COMMENT '수정자_ID', -- 수정자_ID
	`MOD_NM`     VARCHAR(32)  NULL     COMMENT '수정자', -- 수정자
	`MOD_DT`     DATETIME     NULL     COMMENT '수정일', -- 수정일
	`DEL_ID`     VARCHAR(30)  NULL     COMMENT '삭제자_ID', -- 삭제자_ID
	`DEL_NM`     VARCHAR(32)  NULL     COMMENT '삭제자', -- 삭제자
	`DEL_DT`     DATETIME     NULL     COMMENT '삭제일', -- 삭제일
	`DEL_YN`     CHAR(1)      NOT NULL DEFAULT 'N' COMMENT '삭제여부' -- 삭제여부
)
COMMENT '프로그램목록';

-- 프로그램목록
ALTER TABLE `mc_programs`
	ADD CONSTRAINT
		PRIMARY KEY (
			`SEQ` -- 시퀀스
		);

ALTER TABLE `mc_programs`
	MODIFY COLUMN `SEQ` INT(32) NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

ALTER TABLE `mc_programs`
	AUTO_INCREMENT = 77;

-- 예약등록
CREATE TABLE `mc_reserve` (
	`RESERVE_SEQ`  INT(38)      NOT NULL COMMENT '시퀀스', -- 시퀀스
	`SITE_ID`      INT(38)      NULL     COMMENT '사이트_ID', -- 사이트_ID
	`CMS_MENU_SEQ` INT(38)      NULL     COMMENT '메뉴_시퀀스', -- 메뉴_시퀀스
	`BOARD_SEQ`    INT(38)      NULL     COMMENT '게시판_시퀀스', -- 게시판_시퀀스
	`ARTICLE_SEQ`  INT(38)      NULL     COMMENT '게시물_시퀀스', -- 게시물_시퀀스
	`PARAMS`       TEXT         NULL     COMMENT '파라미터셋', -- 파라미터셋
	`RESERVE_DT`   VARCHAR(30)  NULL     COMMENT '예약배포일', -- 예약배포일
	`TYPE`         VARCHAR(3)   NULL     COMMENT '배포타입', -- 배포타입
	`REG_ID`       VARCHAR(30)  NULL     COMMENT '등록자_ID', -- 등록자_ID
	`REG_NM`       VARCHAR(32)  NULL     COMMENT '등록자', -- 등록자
	`REG_DT`       DATETIME     NULL     COMMENT '등록일', -- 등록일
	`DEL_ID`       VARCHAR(30)  NULL     COMMENT '삭제자_ID', -- 삭제자_ID
	`DEL_NM`       VARCHAR(32)  NULL     COMMENT '삭제자', -- 삭제자
	`DEL_DT`       DATETIME     NULL     COMMENT '삭제일', -- 삭제일
	`DEL_YN`       VARCHAR(1)   NULL     DEFAULT 'N' COMMENT '삭제여부', -- 삭제여부
	`TITLE`        VARCHAR(100) NULL     COMMENT '제목', -- 제목
	`GUBUN`        VARCHAR(1)   NULL     DEFAULT 'M' COMMENT 'M:매뉴,B:게시판', -- 구분
	`STATUS`       CHAR(1)      NULL     DEFAULT 'I' COMMENT '상태' -- 상태
)
COMMENT '예약등록';

-- 예약등록
ALTER TABLE `mc_reserve`
	ADD CONSTRAINT
		PRIMARY KEY (
			`RESERVE_SEQ` -- 시퀀스
		);

ALTER TABLE `mc_reserve`
	MODIFY COLUMN `RESERVE_SEQ` INT(38) NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

ALTER TABLE `mc_reserve`
	AUTO_INCREMENT = 1673;

-- 만족도조사
CREATE TABLE `mc_satisfaction` (
	`SEQ`          INT(11)       NOT NULL COMMENT '시퀀스', -- 시퀀스
	`CMS_MENU_SEQ` INT(38)       NULL     COMMENT '메뉴_시퀀스', -- 메뉴_시퀀스
	`SCORE`        INT(11)       NOT NULL COMMENT '점수', -- 점수
	`IP`           VARCHAR(17)   NULL     COMMENT '아이피', -- 아이피
	`REG_DT`       DATETIME      NULL     COMMENT '등록일', -- 등록일
	`ETC`          VARCHAR(2000) NULL     COMMENT '기타' -- 기타
)
COMMENT '만족도조사';

-- 만족도조사
ALTER TABLE `mc_satisfaction`
	ADD CONSTRAINT
		PRIMARY KEY (
			`SEQ` -- 시퀀스
		);

ALTER TABLE `mc_satisfaction`
	MODIFY COLUMN `SEQ` INT(11) NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

ALTER TABLE `mc_satisfaction`
	AUTO_INCREMENT = 425;

-- 소스수정_이력
CREATE TABLE `mc_source_history` (
	`seq`       INT(11)      NOT NULL COMMENT '시퀀스', -- 시퀀스
	`file_path` VARCHAR(200) NULL     COMMENT '파일경로', -- 파일경로
	`code_text` TEXT         NULL     COMMENT '코드내용', -- 코드내용
	`reg_nm`    VARCHAR(30)  NULL     COMMENT '작성자', -- 작성자
	`reg_id`    VARCHAR(30)  NULL     COMMENT '작성자_ID', -- 작성자_ID
	`reg_dt`    DATETIME     NULL     COMMENT '작성일' -- 작성일
)
COMMENT '소스수정_이력';

-- 소스수정_이력
ALTER TABLE `mc_source_history`
	ADD CONSTRAINT
		PRIMARY KEY (
			`seq` -- 시퀀스
		);

ALTER TABLE `mc_source_history`
	MODIFY COLUMN `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

ALTER TABLE `mc_source_history`
	AUTO_INCREMENT = 2;

-- 관리자_작업이력
CREATE TABLE `mc_staff_location_tracking` (
	`SEQ`           INT(38)       NOT NULL COMMENT '시퀀스', -- 시퀀스
	`PARENT_SEQ`    INT(38)       NOT NULL COMMENT '로그인_시퀀스', -- 로그인_시퀀스
	`LOCATION_TIME` DATETIME      NULL     COMMENT '이동시간', -- 이동시간
	`TITLE`         VARCHAR(500)  NULL     COMMENT '메뉴명', -- 메뉴명
	`URL`           VARCHAR(1000) NOT NULL COMMENT '이동주소', -- 이동주소
	`PARAMS`        TEXT          NULL     COMMENT '파라미터목록', -- 파라미터목록
	`JOB`           VARCHAR(100)  NULL     COMMENT '작업간략내용' -- 작업간략내용
)
COMMENT '관리자_작업이력';

-- 관리자_작업이력
ALTER TABLE `mc_staff_location_tracking`
	ADD CONSTRAINT
		PRIMARY KEY (
			`SEQ` -- 시퀀스
		);

-- SEQ
CREATE INDEX `SEQ`
	ON `mc_staff_location_tracking`( -- 관리자_작업이력
		`SEQ`,        -- 시퀀스
		`PARENT_SEQ`  -- 로그인_시퀀스
	);

ALTER TABLE `mc_staff_location_tracking`
	MODIFY COLUMN `SEQ` INT(38) NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

ALTER TABLE `mc_staff_location_tracking`
	AUTO_INCREMENT = 49455;

-- 관리자_로그인_이력
CREATE TABLE `mc_staff_login_tracking` (
	`SEQ`         INT(38)      NOT NULL COMMENT '로그인_시퀀스', -- 로그인_시퀀스
	`MEMBER_ID`   VARCHAR(100) NULL     COMMENT '회원_ID', -- 회원_ID
	`MEMBER_NAME` VARCHAR(100) NULL     COMMENT '회원이름', -- 회원이름
	`LOGIN_DATE`  DATETIME     NULL     COMMENT '로그인일', -- 로그인일
	`LOGIN_IP`    VARCHAR(50)  NULL     COMMENT '로그인_아이피' -- 로그인_아이피
)
COMMENT '관리자_로그인_이력';

-- 관리자_로그인_이력
ALTER TABLE `mc_staff_login_tracking`
	ADD CONSTRAINT
		PRIMARY KEY (
			`SEQ` -- 로그인_시퀀스
		);

-- SEQ
CREATE INDEX `SEQ`
	ON `mc_staff_login_tracking`( -- 관리자_로그인_이력
		`SEQ`,        -- 로그인_시퀀스
		`LOGIN_DATE`  -- 로그인일
	);

ALTER TABLE `mc_staff_login_tracking`
	MODIFY COLUMN `SEQ` INT(38) NOT NULL AUTO_INCREMENT COMMENT '로그인_시퀀스';

ALTER TABLE `mc_staff_login_tracking`
	AUTO_INCREMENT = 739;

-- 사용자회원
CREATE TABLE `mc_user_member` (
	`MEMBER_ID`      VARCHAR(30)   NOT NULL COMMENT '회원_ID', -- 회원_ID
	`MEMBER_PW`      VARCHAR(100)  NULL     COMMENT '회원_패스워드', -- 회원_패스워드
	`MEMBER_NM`      VARCHAR(30)   NULL     COMMENT '회원명', -- 회원명
	`EMAIL`          VARCHAR(100)  NULL     COMMENT '이메일', -- 이메일
	`TEL`            VARCHAR(15)   NULL     COMMENT '전화번호', -- 전화번호
	`CELL`           VARCHAR(15)   NULL     COMMENT '휴대폰번호', -- 휴대폰번호
	`GROUP_SEQ`      INT(11)       NULL     COMMENT '회원_그룹시퀀스', -- 회원_그룹시퀀스
	`LAST_LOGIN`     DATETIME      NULL     COMMENT '마지막_로그인시간', -- 마지막_로그인시간
	`MOD_ID`         VARCHAR(30)   NULL     COMMENT '수정자_ID', -- 수정자_ID
	`MOD_NM`         VARCHAR(30)   NULL     COMMENT '수정자', -- 수정자
	`MOD_DT`         DATETIME      NULL     COMMENT '수정일', -- 수정일
	`MOD_IP`         VARCHAR(16)   NULL     COMMENT '수정자_IP', -- 수정자_IP
	`DEL_ID`         VARCHAR(30)   NULL     COMMENT '삭제자_ID', -- 삭제자_ID
	`DEL_NM`         VARCHAR(30)   NULL     COMMENT '삭제자', -- 삭제자
	`DEL_DT`         DATETIME      NULL     COMMENT '삭제일', -- 삭제일
	`USE_YN`         CHAR(1)       NULL     DEFAULT 'Y' COMMENT '사용여부', -- 사용여부
	`DEL_YN`         CHAR(1)       NULL     DEFAULT 'N' COMMENT '삭제여부', -- 삭제여부
	`ORDER_SEQ`      INT(11)       NULL     COMMENT '순서', -- 순서
	`BLOCK_YN`       CHAR(1)       NOT NULL DEFAULT 'N' COMMENT '블록여부', -- 블록여부
	`LOGIN_FAIL_CNT` INT(11)       NOT NULL DEFAULT 0 COMMENT '로그인_시도횟수', -- 로그인_시도횟수
	`LAST_PW_DT`     DATE          NULL     COMMENT '마지막_패스워드변경일', -- 마지막_패스워드변경일
	`DI`             VARCHAR(100)  NULL     COMMENT 'DI', -- DI
	`BIRTH`          VARCHAR(8)    NULL     COMMENT '생년월일', -- 생년월일
	`EMAIL_YN`       CHAR(1)       NULL     DEFAULT 'N' COMMENT '이메일발송_허용', -- 이메일발송_허용
	`SMS_YN`         CHAR(1)       NULL     DEFAULT 'N' COMMENT 'SMS발송_허용', -- SMS발송_허용
	`REG_DT`         DATETIME      NULL     COMMENT '등록일', -- 등록일
	`DORMANCY_YN`    CHAR(1)       NULL     DEFAULT 'N' COMMENT '휴면계정_여부', -- 휴면계정_여부
	`LEAVE_CONT`     VARCHAR(1000) NULL     COMMENT '탈퇴_사유', -- 탈퇴_사유
	`MADE_YN`        CHAR(1)       NULL     COMMENT '비밀번호 변경여부' -- 비밀번호 변경여부
)
COMMENT '사용자회원';

-- 사용자회원
ALTER TABLE `mc_user_member`
	ADD CONSTRAINT
		PRIMARY KEY (
			`MEMBER_ID` -- 회원_ID
		);

-- 게시물_신고
CREATE TABLE `mc_user_report` (
	`REPORT_SEQ`  INT(11)       NOT NULL COMMENT '시퀀스', -- 시퀀스
	`ARTICLE_SEQ` INT(38)       NOT NULL COMMENT '게시물_시퀀스', -- 게시물_시퀀스
	`BOARD_SEQ`   INT(38)       NOT NULL COMMENT '게시판_시퀀스', -- 게시판_시퀀스
	`REPORTCONTS` VARCHAR(4000) NOT NULL COMMENT '내용', -- 내용
	`IP`          VARCHAR(16)   NOT NULL COMMENT '아이피', -- 아이피
	`REG_DT`      DATETIME      NULL     COMMENT '등록일', -- 등록일
	`REG_ID`      VARCHAR(30)   NULL     COMMENT '등록자_ID', -- 등록자_ID
	`REG_NM`      VARCHAR(32)   NULL     COMMENT '등록자' -- 등록자
)
COMMENT '게시물_신고';

-- 게시물_신고
ALTER TABLE `mc_user_report`
	ADD CONSTRAINT
		PRIMARY KEY (
			`REPORT_SEQ` -- 시퀀스
		);

-- 게시물_신고 유니크 인덱스
CREATE UNIQUE INDEX `IDX_MC_USER_REPORT`
	ON `mc_user_report` ( -- 게시물_신고
		`BOARD_SEQ` ASC,   -- 게시판_시퀀스
		`ARTICLE_SEQ` ASC  -- 게시물_시퀀스
	);

ALTER TABLE `mc_user_report`
	MODIFY COLUMN `REPORT_SEQ` INT(11) NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

ALTER TABLE `mc_user_report`
	AUTO_INCREMENT = 56;

-- 메뉴_그룹별_사용자_접근권한
CREATE TABLE `mc_cms_menu_grant` (
	`SEQ`          INT(11)     NOT NULL COMMENT '시퀀스', -- 시퀀스
	`CMS_MENU_SEQ` INT(38)     NOT NULL COMMENT '메뉴_시퀀스', -- 메뉴_시퀀스
	`GROUP_SEQ`    INT(11)     NOT NULL COMMENT '그룹_시퀀스', -- 그룹_시퀀스
	`GROUP_NM`     VARCHAR(32) NULL     COMMENT '그룹명', -- 그룹명
	`REG_DT`       DATETIME    NULL     COMMENT '등록일', -- 등록일
	`REG_ID`       VARCHAR(30) NULL     COMMENT '등록자_ID', -- 등록자_ID
	`REG_NM`       VARCHAR(30) NULL     COMMENT '등록자', -- 등록자
	`ORDER_SEQ`    INT(11)     NULL     DEFAULT 1 COMMENT '순서' -- 순서
)
COMMENT '메뉴_그룹별_사용자_접근권한';

-- 메뉴_그룹별_사용자_접근권한
ALTER TABLE `mc_cms_menu_grant`
	ADD CONSTRAINT
		PRIMARY KEY (
			`SEQ` -- 시퀀스
		);

ALTER TABLE `mc_cms_menu_grant`
	MODIFY COLUMN `SEQ` INT(11) NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

-- 회원그룹
CREATE TABLE `mc_user_group` (
	`GROUP_SEQ`        INT(38)      NOT NULL COMMENT '그룹_시퀀스', -- 그룹_시퀀스
	`GROUP_NM`         VARCHAR(32)  NOT NULL COMMENT '그룹명', -- 그룹명
	`PARENT_SEQ`       INT(38)      NULL     COMMENT '부모그룹_시퀀스', -- 부모그룹_시퀀스
	`USE_YN`           CHAR(1)      NOT NULL DEFAULT 'Y' COMMENT '사용여부', -- 사용여부
	`REG_DT`           DATETIME     NOT NULL COMMENT '등록일', -- 등록일
	`MOD_DT`           DATETIME     NULL     COMMENT '수정일', -- 수정일
	`DEL_DT`           DATETIME     NULL     COMMENT '삭제일', -- 삭제일
	`DEL_YN`           CHAR(1)      NOT NULL DEFAULT 'N' COMMENT '삭제여부', -- 삭제여부
	`ORDER_SEQ`        INT(38)      NOT NULL DEFAULT 1 COMMENT '순서', -- 순서
	`REG_NM`           VARCHAR(32)  NULL     COMMENT '등록자', -- 등록자
	`MOD_NM`           VARCHAR(32)  NULL     COMMENT '수정자', -- 수정자
	`DEL_NM`           VARCHAR(32)  NULL     COMMENT '삭제자', -- 삭제자
	`MOD_ID`           VARCHAR(30)  NULL     COMMENT '수정자_ID', -- 수정자_ID
	`DEL_ID`           VARCHAR(30)  NULL     COMMENT '삭제자_ID', -- 삭제자_ID
	`REG_ID`           VARCHAR(30)  NULL     COMMENT '등록자_ID', -- 등록자_ID
	`TEL`              VARCHAR(13)  NULL     COMMENT '전화번호', -- 전화번호
	`FAX`              VARCHAR(13)  NULL     COMMENT '팩스번호', -- 팩스번호
	`RESPONSIBILITIES` VARCHAR(500) NULL     COMMENT '상세내용', -- 상세내용
	`MANAGE_SEQ`       INT(38)      NULL     COMMENT '관리_시퀀스' -- 관리_시퀀스
)
COMMENT '회원그룹';

-- 회원그룹
ALTER TABLE `mc_user_group`
	ADD CONSTRAINT
		PRIMARY KEY (
			`GROUP_SEQ` -- 그룹_시퀀스
		);

-- IDX_GROUP_SORTORDER
CREATE INDEX `IDX_GROUP_SORTORDER`
	ON `mc_user_group`( -- 회원그룹
		`PARENT_SEQ`, -- 부모그룹_시퀀스
		`ORDER_SEQ`   -- 순서
	);

ALTER TABLE `mc_user_group`
	MODIFY COLUMN `GROUP_SEQ` INT(38) NOT NULL AUTO_INCREMENT COMMENT '그룹_시퀀스';

-- 알림_읽음
CREATE TABLE `MC_ALRAM_READ` (
	`TABLE_CD`    VARCHAR(50) NOT NULL COMMENT '테이블코드', -- 테이블코드
	`ARTICLE_SEQ` INT         NOT NULL COMMENT '시퀀스', -- 시퀀스
	`MEMBER_ID`   VARCHAR(30) NOT NULL COMMENT '회원_ID', -- 회원_ID
	`READ_DT`     DATE        NULL     COMMENT '읽은날짜' -- 읽은날짜
)
COMMENT '알림_읽음';

-- 알림_읽음
ALTER TABLE `MC_ALRAM_READ`
	ADD CONSTRAINT `PK_MC_ALRAM_READ` -- 알림_읽음 기본키
		PRIMARY KEY (
			`TABLE_CD`,    -- 테이블코드
			`ARTICLE_SEQ`, -- 시퀀스
			`MEMBER_ID`    -- 회원_ID
		);

-- 사용자회원_변경이력
CREATE TABLE `mc_user_member_history` (
	`SEQ`       INT(11)       NOT NULL COMMENT '시퀀스', -- 시퀀스
	`MEMBER_ID` VARCHAR(30)   NULL     COMMENT '회원_ID', -- 회원_ID
	`MEMBER_NM` VARCHAR(30)   NULL     COMMENT '회원명', -- 회원명
	`MOD_ID`    VARCHAR(30)   NULL     COMMENT '수정자_ID', -- 수정자_ID
	`MOD_NM`    VARCHAR(30)   NULL     COMMENT '수정자', -- 수정자
	`MOD_DT`    DATETIME      NULL     COMMENT '수정일', -- 수정일
	`MOD_IP`    VARCHAR(16)   NULL     COMMENT '수정자_IP', -- 수정자_IP
	`CONTS`     VARCHAR(2000) NULL     COMMENT '변경내용' -- 변경내용
)
COMMENT '사용자회원_변경이력';

-- 사용자회원_변경이력
ALTER TABLE `mc_user_member_history`
	ADD CONSTRAINT
		PRIMARY KEY (
			`SEQ` -- 시퀀스
		);

ALTER TABLE `mc_user_member_history`
	MODIFY COLUMN `SEQ` INT(11) NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

-- 이력이남는_페이지
CREATE TABLE `MC_PHISTORY` (
	`SEQ`    INT         NOT NULL COMMENT '시퀀스', -- 시퀀스
	`GUBUN`  INT         NULL     COMMENT '구분', -- 구분
	`CONTS`  TEXT        NULL     COMMENT '내용', -- 내용
	`REG_DT` DATETIME    NULL     COMMENT '등록일', -- 등록일
	`REG_ID` VARCHAR(30) NULL     COMMENT '등록자_ID', -- 등록자_ID
	`REG_NM` VARCHAR(32) NOT NULL COMMENT '등록자', -- 등록자
	`MOD_DT` DATETIME    NULL     COMMENT '수정일', -- 수정일
	`MOD_ID` VARCHAR(30) NULL     COMMENT '수정자_ID', -- 수정자_ID
	`MOD_NM` VARCHAR(32) NULL     COMMENT '수정자' -- 수정자
)
COMMENT '이력이남는_페이지';

-- 이력이남는_페이지
ALTER TABLE `MC_PHISTORY`
	ADD CONSTRAINT `PK_MC_PHISTORY` -- 이력이남는_페이지 기본키
		PRIMARY KEY (
			`SEQ` -- 시퀀스
		);

ALTER TABLE `MC_PHISTORY`
	MODIFY COLUMN `SEQ` INT NOT NULL AUTO_INCREMENT COMMENT '시퀀스';

-- 게시물_목록
ALTER TABLE `mc_article`
	ADD CONSTRAINT `FK_mc_board_TO_mc_article` -- 게시판설정_목록 -> 게시물_목록
		FOREIGN KEY (
			`BOARD_SEQ` -- 게시판_시퀀스
		)
		REFERENCES `mc_board` ( -- 게시판설정_목록
			`BOARD_SEQ` -- 게시판_시퀀스
		)
		ON DELETE CASCADE;

-- 게시판설정_커스텀_약관동의
ALTER TABLE `mc_board_agree`
	ADD CONSTRAINT `FK_mc_board_TO_mc_board_agree` -- 게시판설정_목록 -> 게시판설정_커스텀_약관동의
		FOREIGN KEY (
			`BOARD_SEQ` -- 게시판_시퀀스
		)
		REFERENCES `mc_board` ( -- 게시판설정_목록
			`BOARD_SEQ` -- 게시판_시퀀스
		)
		ON DELETE CASCADE;

-- 게시판설정_카테고리
ALTER TABLE `mc_board_cat`
	ADD CONSTRAINT `FK_mc_board_TO_mc_board_cat` -- 게시판설정_목록 -> 게시판설정_카테고리
		FOREIGN KEY (
			`BOARD_SEQ` -- 게시판_시퀀스
		)
		REFERENCES `mc_board` ( -- 게시판설정_목록
			`BOARD_SEQ` -- 게시판_시퀀스
		)
		ON DELETE CASCADE;

-- 게시판설정_커스텀
ALTER TABLE `mc_board_custom`
	ADD CONSTRAINT `FK_mc_board_TO_mc_board_custom` -- 게시판설정_목록 -> 게시판설정_커스텀
		FOREIGN KEY (
			`BOARD_SEQ` -- 게시판_시퀀스
		)
		REFERENCES `mc_board` ( -- 게시판설정_목록
			`BOARD_SEQ` -- 게시판_시퀀스
		)
		ON DELETE CASCADE;

-- 게시판설정_상태
ALTER TABLE `mc_board_state`
	ADD CONSTRAINT `FK_mc_board_TO_mc_board_state` -- 게시판설정_목록 -> 게시판설정_상태
		FOREIGN KEY (
			`BOARD_SEQ` -- 게시판_시퀀스
		)
		REFERENCES `mc_board` ( -- 게시판설정_목록
			`BOARD_SEQ` -- 게시판_시퀀스
		)
		ON DELETE CASCADE;

-- 메뉴별_컨텐츠_백업
ALTER TABLE `mc_cms_content_bakup`
	ADD CONSTRAINT `FK_mc_cms_menu_TO_mc_cms_content_bakup` -- 메뉴정보 -> 메뉴별_컨텐츠_백업
		FOREIGN KEY (
			`CMS_MENU_SEQ` -- 메뉴_시퀀스
		)
		REFERENCES `mc_cms_menu` ( -- 메뉴정보
			`CMS_MENU_SEQ` -- 메뉴_시퀀스
		)
		ON DELETE CASCADE;

-- 메뉴정보_백업
ALTER TABLE `mc_cms_menu_bakup`
	ADD CONSTRAINT `FK_mc_cms_menu_TO_mc_cms_menu_bakup` -- 메뉴정보 -> 메뉴정보_백업
		FOREIGN KEY (
			`CMS_MENU_SEQ` -- 메뉴_시퀀스
		)
		REFERENCES `mc_cms_menu` ( -- 메뉴정보
			`CMS_MENU_SEQ` -- 메뉴_시퀀스
		)
		ON DELETE CASCADE;

-- JS_CSS_파일목록
ALTER TABLE `mc_cms_menu_libs`
	ADD CONSTRAINT `FK_mc_cms_menu_TO_mc_cms_menu_libs` -- 메뉴정보 -> JS_CSS_파일목록
		FOREIGN KEY (
			`CMS_MENU_SEQ` -- 메뉴_시퀀스
		)
		REFERENCES `mc_cms_menu` ( -- 메뉴정보
			`CMS_MENU_SEQ` -- 메뉴_시퀀스
		)
		ON DELETE CASCADE;

-- 메뉴설정권한회원
ALTER TABLE `mc_cms_permission`
	ADD CONSTRAINT `FK_mc_cms_menu_TO_mc_cms_permission` -- 메뉴정보 -> 메뉴설정권한회원
		FOREIGN KEY (
			`CMS_MENU_SEQ` -- 메뉴_시퀀스
		)
		REFERENCES `mc_cms_menu` ( -- 메뉴정보
			`CMS_MENU_SEQ` -- 메뉴_시퀀스
		)
		ON DELETE CASCADE;

-- 메뉴컨텐츠_관리회원
ALTER TABLE `mc_cms_staff`
	ADD CONSTRAINT `FK_mc_cms_menu_TO_mc_cms_staff` -- 메뉴정보 -> 메뉴컨텐츠_관리회원
		FOREIGN KEY (
			`CMS_MENU_SEQ` -- 메뉴_시퀀스
		)
		REFERENCES `mc_cms_menu` ( -- 메뉴정보
			`CMS_MENU_SEQ` -- 메뉴_시퀀스
		)
		ON DELETE CASCADE;

-- 메뉴컨텐츠_관리그룹
ALTER TABLE `mc_cms_staff_group`
	ADD CONSTRAINT `FK_mc_mn_TO_mc_staff_group` -- 메뉴정보 -> 메뉴컨텐츠_관리그룹
		FOREIGN KEY (
			`CMS_MENU_SEQ` -- 메뉴_시퀀스
		)
		REFERENCES `mc_cms_menu` ( -- 메뉴정보
			`CMS_MENU_SEQ` -- 메뉴_시퀀스
		)
		ON DELETE CASCADE;

-- 공통코드목록_상세
ALTER TABLE `mc_common_code`
	ADD CONSTRAINT `FK_mc_common_code_group_TO_mc_common_code` -- 공통코드목록 -> 공통코드목록_상세
		FOREIGN KEY (
			`CODE_GROUP_SEQ` -- 공통코드_시퀀스
		)
		REFERENCES `mc_common_code_group` ( -- 공통코드목록
			`CODE_GROUP_SEQ` -- 공통코드_시퀀스
		)
		ON DELETE CASCADE;

-- 레이아웃_설정
ALTER TABLE `mc_layout_detail`
	ADD CONSTRAINT `FK_mc_layout_TO_mc_layout_detail` -- 메인_레이아웃설정 -> 레이아웃_설정
		FOREIGN KEY (
			`PARENT_SEQ` -- 레이아웃_시퀀스
		)
		REFERENCES `mc_layout` ( -- 메인_레이아웃설정
			`SEQ` -- 레이아웃_시퀀스
		)
		ON DELETE CASCADE;

-- 메일발송_대기목록
ALTER TABLE `mc_mail_queue`
	ADD CONSTRAINT `FK_mc_mail_TO_mc_mail_queue` -- 메일발송목록 -> 메일발송_대기목록
		FOREIGN KEY (
			`P_SEQ` -- 메일발송_시퀀스
		)
		REFERENCES `mc_mail` ( -- 메일발송목록
			`SEQ` -- 메일발송_시퀀스
		)
		ON DELETE CASCADE;

-- 수신자_그룹상세
ALTER TABLE `mc_mail_target_list`
	ADD CONSTRAINT `FK_mc_mail_target_TO_mc_mail_target_list` -- 수신자_그룹 -> 수신자_그룹상세
		FOREIGN KEY (
			`P_SEQ` -- 수신자그룹_시퀀스
		)
		REFERENCES `mc_mail_target` ( -- 수신자_그룹
			`SEQ` -- 수신자그룹_시퀀스
		)
		ON DELETE CASCADE;

-- 메뉴별_개인정보_결과
ALTER TABLE `mc_personal_data`
	ADD CONSTRAINT `FK_mc_cms_menu_TO_mc_personal_data` -- 메뉴정보 -> 메뉴별_개인정보_결과
		FOREIGN KEY (
			`CMS_MENU_SEQ` -- 메뉴_시퀀스
		)
		REFERENCES `mc_cms_menu` ( -- 메뉴정보
			`CMS_MENU_SEQ` -- 메뉴_시퀀스
		)
		ON DELETE CASCADE;

-- 설문조사_응답보기
ALTER TABLE `mc_poll_answer`
	ADD CONSTRAINT `FK_mc_poll_TO_mc_poll_answer` -- 설문조사 -> 설문조사_응답보기
		FOREIGN KEY (
			`POLL_SEQ` -- 설문조사_시퀀스
		)
		REFERENCES `mc_poll` ( -- 설문조사
			`POLL_SEQ` -- 설문조사_시퀀스
		)
		ON DELETE CASCADE;

-- 설문조사_질문지
ALTER TABLE `mc_poll_question`
	ADD CONSTRAINT `FK_mp_TO_mpq` -- 설문조사 -> 설문조사_질문지
		FOREIGN KEY (
			`POLL_SEQ` -- 설문조사_시퀀스
		)
		REFERENCES `mc_poll` ( -- 설문조사
			`POLL_SEQ` -- 설문조사_시퀀스
		)
		ON DELETE CASCADE;

-- 설문조사_결과
ALTER TABLE `mc_poll_result`
	ADD CONSTRAINT `FK_mp_TO_mpr` -- 설문조사 -> 설문조사_결과
		FOREIGN KEY (
			`POLL_SEQ` -- 설문조사_시퀀스
		)
		REFERENCES `mc_poll` ( -- 설문조사
			`POLL_SEQ` -- 설문조사_시퀀스
		)
		ON DELETE CASCADE;

-- 만족도조사
ALTER TABLE `mc_satisfaction`
	ADD CONSTRAINT `FK_mc_cms_menu_TO_mc_satisfaction` -- 메뉴정보 -> 만족도조사
		FOREIGN KEY (
			`CMS_MENU_SEQ` -- 메뉴_시퀀스
		)
		REFERENCES `mc_cms_menu` ( -- 메뉴정보
			`CMS_MENU_SEQ` -- 메뉴_시퀀스
		)
		ON DELETE CASCADE;

-- 관리자_작업이력
ALTER TABLE `mc_staff_location_tracking`
	ADD CONSTRAINT `FK_mc_staff_login_tracking_TO_mc_staff_location_tracking` -- 관리자_로그인_이력 -> 관리자_작업이력
		FOREIGN KEY (
			`PARENT_SEQ` -- 로그인_시퀀스
		)
		REFERENCES `mc_staff_login_tracking` ( -- 관리자_로그인_이력
			`SEQ` -- 로그인_시퀀스
		)
		ON DELETE CASCADE;

-- 게시물_신고
ALTER TABLE `mc_user_report`
	ADD CONSTRAINT `FK_mc_article_TO_mc_user_report` -- 게시물_목록 -> 게시물_신고
		FOREIGN KEY (
			`ARTICLE_SEQ`, -- 게시물_시퀀스
			`BOARD_SEQ`    -- 게시판_시퀀스
		)
		REFERENCES `mc_article` ( -- 게시물_목록
			`ARTICLE_SEQ`, -- 게시물_시퀀스
			`BOARD_SEQ`    -- 게시판_시퀀스
		)
		ON DELETE CASCADE;

-- 메뉴_그룹별_사용자_접근권한
ALTER TABLE `mc_cms_menu_grant`
	ADD CONSTRAINT `FK_mc_mn_TO_mc_mn_grant` -- 메뉴정보 -> 메뉴_그룹별_사용자_접근권한
		FOREIGN KEY (
			`CMS_MENU_SEQ` -- 메뉴_시퀀스
		)
		REFERENCES `mc_cms_menu` ( -- 메뉴정보
			`CMS_MENU_SEQ` -- 메뉴_시퀀스
		)
		ON DELETE CASCADE;
		
DELIMITER $$
CREATE FUNCTION `MANAGEMENT_SITE_TITLE`(IN_STR VARCHAR(200)) RETURNS TEXT CHARSET utf8
    READS SQL DATA
BEGIN
	DECLARE V_RETURN VARCHAR(4000);
	
	IF IFNULL(IN_STR,'') = '' THEN
		RETURN '';
	END IF;
	
	SELECT 
		 (SELECT GROUP_CONCAT(SUBSTRING_INDEX(T2.SITE_TITLE,'.',-1) SEPARATOR ', ')) AS SITE_TITLE
		 INTO V_RETURN
	FROM (
		SELECT
			DISTINCT SUBSTRING(T1.PAGE_NAVI,1, CASE WHEN INSTR(T1.PAGE_NAVI,'>') = 0 THEN LENGTH(T1.PAGE_NAVI)	ELSE INSTR(T1.PAGE_NAVI,'>')-1 END) AS SITE_TITLE
   	FROM (
			SELECT  
				sg.CMS_MENU_SEQ,
				SUBSTR(SYS_CONNECT_BY_PATH_MENU(sg.CMS_MENU_SEQ, '>'),2) AS PAGE_NAVI
			FROM (
				SELECT  start_with_connect_by_memu() AS PARENT_MENU_SEQ, @level AS MENU_LEVEL
				FROM (
					SELECT @start_with := IFNULL(0, '1'),
							 @id := @start_with,
							 @level := 0,
							 @rn := 0
				) vars, MC_CMS_MENU
				WHERE   @id IS NOT NULL
			) sg2
			JOIN    MC_CMS_MENU sg
			ON      sg.CMS_MENU_SEQ = sg2.PARENT_MENU_SEQ
		) AS T1
		JOIN MC_CMS_STAFF B ON T1.CMS_MENU_SEQ = B.CMS_MENU_SEQ AND B.MEMBER_ID = IN_STR
	) AS T2;
	RETURN V_RETURN;
END$$
DELIMITER ;		


DELIMITER $$

CREATE FUNCTION `start_with_connect_by_memu`() RETURNS INT(11)
    READS SQL DATA
BEGIN
        DECLARE _id INT;
        DECLARE _parent INT;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET @id = NULL;
        SET _parent = @id;
        SET _id = -1;
        IF @id IS NULL THEN
                RETURN NULL;
        END IF;
        LOOP		
                SELECT  MIN(cms_menu_seq)
                INTO    @id
                FROM    MC_CMS_MENU 
                WHERE   PARENT_MENU_SEQ = _parent
                        AND CMS_MENU_SEQ > _id;
                IF @id IS NOT NULL OR _parent = @start_with THEN    
                        SET @level = @level + 1;
                        RETURN @id;
                END IF;
                SET @level := @level - 1;
                SELECT  CMS_MENU_SEQ, PARENT_MENU_SEQ
                INTO    _id, _parent
                FROM    MC_CMS_MENU
                WHERE   CMS_MENU_SEQ = _parent;
        END LOOP;
END$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION `start_with_connect_by_group`() RETURNS INT(11)
    READS SQL DATA
BEGIN
        DECLARE _id INT;
        DECLARE _parent INT;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET @id = NULL;
        SET _parent = @id;
        SET _id = -1;
        IF @id IS NULL THEN
                RETURN NULL;
        END IF;
        LOOP
                SELECT  MIN(GROUP_SEQ)
                INTO    @id
                FROM    MC_GROUP
                WHERE   DEL_YN='N' AND PARENT_SEQ = _parent
                        AND GROUP_SEQ > _id;
                IF @id IS NOT NULL OR _parent = @start_with THEN
                        SET @level = @level + 1;
                        RETURN @id;
                END IF;
                SET @level := @level - 1;
                SELECT  GROUP_SEQ, PARENT_SEQ
                INTO    _id, _parent
                FROM    MC_GROUP
                WHERE   DEL_YN='N' AND GROUP_SEQ = _parent;
        END LOOP;
END$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION `start_with_connect_by_group_user`() RETURNS INT(11)
    READS SQL DATA
BEGIN
        DECLARE _id INT;
        DECLARE _parent INT;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET @id = NULL;
        SET _parent = @id;
        SET _id = -1;
        IF @id IS NULL THEN
                RETURN NULL;
        END IF;
        LOOP
                SELECT  MIN(GROUP_SEQ)
                INTO    @id
                FROM    MC_USER_GROUP
                WHERE   DEL_YN='N' AND PARENT_SEQ = _parent
                        AND GROUP_SEQ > _id;
                IF @id IS NOT NULL OR _parent = @start_with THEN
                        SET @level = @level + 1;
                        RETURN @id;
                END IF;
                SET @level := @level - 1;
                SELECT  GROUP_SEQ, PARENT_SEQ
                INTO    _id, _parent
                FROM    MC_USER_GROUP
                WHERE   DEL_YN='N' AND GROUP_SEQ = _parent;
        END LOOP;
END$$
DELIMITER ;


DELIMITER $$
CREATE FUNCTION `sys_connect_by_path_group_order`(p_seq INT, p_delimiter VARCHAR(200)) RETURNS TEXT CHARSET utf8
    READS SQL DATA
BEGIN
	DECLARE _path VARCHAR(200);
        DECLARE _parent INT;
        DECLARE _title VARCHAR(200);
	DECLARE EXIT HANDLER FOR NOT FOUND RETURN _path;
	SET _parent = COALESCE(p_seq, @id);
	SET _path = '';
	LOOP
        SELECT  
			LPAD(ORDER_SEQ, 3, '0') AS ORDER_SEQ, PARENT_SEQ INTO _title, _parent
		FROM MC_GROUP
		WHERE GROUP_SEQ = _parent
			AND COALESCE(GROUP_SEQ <> @start_with, TRUE);
		SET _path = CONCAT(p_delimiter, LPAD(_title, 3, 0), _path);
	END LOOP;
END$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION `sys_connect_by_path_group_user_order`(p_seq INT, p_delimiter VARCHAR(200)) RETURNS TEXT CHARSET utf8
    READS SQL DATA
BEGIN
	DECLARE _path VARCHAR(200);
        DECLARE _parent INT;
        DECLARE _title VARCHAR(200);
	DECLARE EXIT HANDLER FOR NOT FOUND RETURN _path;
	SET _parent = COALESCE(p_seq, @id);
	SET _path = '';
	LOOP
        SELECT  
			LPAD(ORDER_SEQ, 3, '0') AS ORDER_SEQ, PARENT_SEQ INTO _title, _parent
		FROM MC_USER_GROUP
		WHERE GROUP_SEQ = _parent
			AND COALESCE(GROUP_SEQ <> @start_with, TRUE);
		SET _path = CONCAT(p_delimiter, LPAD(_title, 3, 0), _path);
	END LOOP;
END$$
DELIMITER ;


DELIMITER $$
CREATE FUNCTION `SYS_CONNECT_BY_PATH_MENU`(p_seq INT, p_delimiter VARCHAR(200)) RETURNS TEXT CHARSET utf8
    READS SQL DATA
BEGIN
	DECLARE _path VARCHAR(200);
        DECLARE _parent INT;
        DECLARE _title VARCHAR(200);
	DECLARE EXIT HANDLER FOR NOT FOUND RETURN _path;
	SET _parent = COALESCE(p_seq, @id);
	SET _path = '';
	LOOP
                SELECT  
			TITLE, PARENT_MENU_SEQ INTO _title, _parent
		FROM MC_CMS_MENU
		WHERE CMS_MENU_SEQ = _parent
			AND COALESCE(CMS_MENU_SEQ <> @start_with, TRUE);
		SET _path = CONCAT(p_delimiter, _title, _path);
	END LOOP;
END$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION `SYS_CONNECT_BY_PATH_MENU_SITE`(p_seq INT, p_delimiter VARCHAR(200)) RETURNS TEXT CHARSET utf8
    READS SQL DATA
BEGIN
	DECLARE _path VARCHAR(200);
        DECLARE _parent INT;
        DECLARE _title VARCHAR(200);
        DECLARE _sub_path VARCHAR(200);
	DECLARE EXIT HANDLER FOR NOT FOUND RETURN _path;
	SET _parent = COALESCE(p_seq, @id);
	SET _path = '';
	LOOP
                SELECT  
			TITLE, PARENT_MENU_SEQ INTO _title, _parent
		FROM MC_CMS_MENU
		WHERE CMS_MENU_SEQ = _parent
			AND COALESCE(CMS_MENU_SEQ <> @start_with, TRUE);
		SET _path = CONCAT(p_delimiter, CONCAT(_title, '(', IFNULL(_sub_path, '/'), ')'), _path);
	END LOOP;
END$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION `SYS_CONNECT_BY_PATH_MENU_ORDER`(p_seq INT, p_delimiter VARCHAR(200)) RETURNS TEXT CHARSET utf8
    READS SQL DATA
BEGIN
	DECLARE _path VARCHAR(200);
        DECLARE _parent INT;
        DECLARE _title VARCHAR(200);
	DECLARE EXIT HANDLER FOR NOT FOUND RETURN _path;
	SET _parent = COALESCE(p_seq, @id);
	SET _path = '';
	LOOP
        SELECT  
			LPAD(MENU_ORDER,3,'0') AS MENU_ORDER, PARENT_MENU_SEQ INTO _title, _parent
		FROM MC_CMS_MENU
		WHERE CMS_MENU_SEQ = _parent
			AND COALESCE(CMS_MENU_SEQ <> @start_with, TRUE);
		SET _path = CONCAT(p_delimiter, LPAD(_title, 3, 0), _path);
	END LOOP;
END$$
DELIMITER ;


DELIMITER $$
CREATE FUNCTION `start_with_connect_by_sns_comment`() RETURNS INT(11)
    READS SQL DATA
BEGIN
        DECLARE _id INT;
        DECLARE _parent INT;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET @id = NULL;
        SET _parent = @id;
        SET _id = -1;
        IF @id IS NULL THEN
                RETURN NULL;
        END IF;
        LOOP
                SELECT  MIN(COMMENT_SEQ)
                INTO    @id
                FROM    MC_COMMENT_SNS
                WHERE   PARENT_SEQ = _parent
                        AND COMMENT_SEQ > _id;
                IF @id IS NOT NULL OR _parent = @start_with THEN
                        SET @level = @level + 1;
                        RETURN @id;
                END IF;
                SET @level := @level - 1;
                SELECT  COMMENT_SEQ, PARENT_SEQ
                INTO    _id, _parent
                FROM    MC_COMMENT_SNS
                WHERE   COMMENT_SEQ = _parent;
        END LOOP;
END$$
DELIMITER ;


DELIMITER $$
CREATE FUNCTION FN_GET_SPLIT(
	in_str 		VARCHAR(2000),
	in_level 	INT,
	in_delimeter	VARCHAR(20),
	in_default_val	VARCHAR(100)

) RETURNS VARCHAR(2000)
BEGIN
    DECLARE v_return VARCHAR(2000) DEFAULT '';
    DECLARE strvalue VARCHAR(2000) DEFAULT in_str;
    DECLARE default_return_val VARCHAR(2000) DEFAULT in_default_val;
    DECLARE idx INT;
    DECLARE ilevel INT DEFAULT 0;

    # 문자열이 없으면 기본 리턴값 반환 후 종료
    IF IFNULL(strvalue,'NO_STRING') = 'NO_STRING' THEN
        RETURN default_return_val;
    END IF;
        
    loop_loop : LOOP
        #구분자 인덱스 확인
        SET idx = INSTR(strvalue, in_delimeter);
        
        IF idx > 0 THEN #구분자로 문자를 찾은경우
                                    
            SET ilevel = ilevel + 1;
            
            # 현재 레벨이 원하는 레벨이면 현재 문자열 반환 AND 레벨이 -1인경우는 마지막까지 LOOP
            IF ilevel = in_level AND in_level != -1 THEN
                SET v_return = SUBSTR(strvalue, 1, idx-1);
                LEAVE loop_loop;
            END IF;
                        
            SET strvalue = SUBSTR(strvalue, idx + LENGTH(in_delimeter));
        ELSE  # 구분자가 없을 경우, 문자열을 그대로 반환
        
            IF ilevel = 0 THEN
                #구분자가 포함이 안되었지만 레벨이 1인경우 문자 그대로 반환
                IF in_level = 1 THEN
                    SET v_return = strvalue;
                ELSE
                    SET v_return = '';
                END IF;
            ELSE
                # 마지막 문자열일 경우
                SET ilevel = ilevel + 1;
                
                # 마지막을 원하는 경우 마지막 문자열 반환 / -1은 레벨을 모를경우 구분자의 마지막 문자열 반환
                IF ilevel = in_level OR in_level = -1 THEN
                        SET v_return = strvalue;
                ELSE
                    # 원하는 레벨의 값이 없을 경우, 공백 반환
                    SET v_return := '';        
                END IF;
            END IF;
            
            LEAVE loop_loop; #반복 탈출문
            
        END IF;
    END LOOP loop_loop;    
    
    #최종결과 리턴
    RETURN IF(v_return = '', default_return_val, IFNULL(v_return, default_return_val));        
END$$
DELIMITER ;

-- 조인용 날짜 테이블 생성
CREATE TABLE t (n INT); 
INSERT INTO t VALUES (1);
INSERT INTO t SELECT * FROM t; 
INSERT INTO t SELECT * FROM t; 
INSERT INTO t SELECT * FROM t; 
INSERT INTO t SELECT * FROM t; 
INSERT INTO t SELECT * FROM t; 
INSERT INTO t SELECT * FROM t; 
INSERT INTO t SELECT * FROM t; 
INSERT INTO t SELECT * FROM t; 
INSERT INTO t SELECT * FROM t; 
INSERT INTO t SELECT * FROM t; 
INSERT INTO t SELECT * FROM t; 
INSERT INTO t SELECT * FROM t; 
INSERT INTO t SELECT * FROM t; 
CREATE TABLE MC_DATE (d DATE, ds CHAR(8)); 
INSERT INTO MC_DATE
SELECT d, DATE_FORMAT(d, '%Y%m%d') FROM (
  SELECT @rnum:=@rnum+1 AS rownum, DATE(ADDDATE('2015-01-01', INTERVAL @rnum DAY)) AS d
  FROM (SELECT @rnum:=-1) r, t
  ) t
WHERE YEAR(d) < 2030;
DROP TABLE t;

CREATE TABLE MC_ANALYTICS_HH (
  HH CHAR(2) NOT NULL,
  PRIMARY KEY (HH)
);

INSERT INTO mc_analytics_hh(HH) VALUES('00');
INSERT INTO mc_analytics_hh(HH) VALUES('01');
INSERT INTO mc_analytics_hh(HH) VALUES('02');
INSERT INTO mc_analytics_hh(HH) VALUES('03');
INSERT INTO mc_analytics_hh(HH) VALUES('04');
INSERT INTO mc_analytics_hh(HH) VALUES('05');
INSERT INTO mc_analytics_hh(HH) VALUES('06');
INSERT INTO mc_analytics_hh(HH) VALUES('07');
INSERT INTO mc_analytics_hh(HH) VALUES('08');
INSERT INTO mc_analytics_hh(HH) VALUES('09');
INSERT INTO mc_analytics_hh(HH) VALUES('10');
INSERT INTO mc_analytics_hh(HH) VALUES('11');
INSERT INTO mc_analytics_hh(HH) VALUES('12');
INSERT INTO mc_analytics_hh(HH) VALUES('13');
INSERT INTO mc_analytics_hh(HH) VALUES('14');
INSERT INTO mc_analytics_hh(HH) VALUES('15');
INSERT INTO mc_analytics_hh(HH) VALUES('16');
INSERT INTO mc_analytics_hh(HH) VALUES('17');
INSERT INTO mc_analytics_hh(HH) VALUES('18');
INSERT INTO mc_analytics_hh(HH) VALUES('19');
INSERT INTO mc_analytics_hh(HH) VALUES('20');
INSERT INTO mc_analytics_hh(HH) VALUES('21');
INSERT INTO mc_analytics_hh(HH) VALUES('22');
INSERT INTO mc_analytics_hh(HH) VALUES('23');

DELIMITER $$
CREATE TRIGGER TR_MC_MEMBER
AFTER UPDATE ON MC_MEMBER
FOR EACH ROW
BEGIN
	DECLARE _conts VARCHAR(500);
	SET _conts = '';
	
	IF IFNULL(OLD.EMAIL, 'x') != IFNULL(NEW.EMAIL, 'x') THEN
		SET _conts = CONCAT(_conts, '<p>이메일 : ', NEW.EMAIL, '</p>');
	END IF;
	IF IFNULL(OLD.TEL, 'x') != IFNULL(NEW.TEL, 'x') THEN
		SET _conts = CONCAT(_conts, '<p>전화번호 : ', NEW.TEL, '</p>');
	END IF;
	IF IFNULL(OLD.CELL, 'x') != IFNULL(NEW.CELL, 'x') THEN
		SET _conts = CONCAT(_conts, '<p>휴대전화 : ', NEW.CELL, '</p>');
	END IF;
	IF IFNULL(OLD.MEMBER_PW, 'x') != IFNULL(NEW.MEMBER_PW, 'x') THEN
		SET _conts = CONCAT(_conts, '<p>패스워드 변경</p>');
	END IF;
	IF IFNULL(OLD.GROUP_SEQ, -1) != IFNULL(NEW.GROUP_SEQ, -1) THEN
		SET _conts = CONCAT(_conts, '<p>부서이동</p>');
    END IF;
    
	IF LENGTH(_conts) > 1 THEN   
	INSERT INTO MC_MEMBER_HISTORY(
		MEMBER_ID, MEMBER_NM, CONTS, MOD_ID, MOD_NM, MOD_DT, MOD_IP
	) VALUES(
		NEW.MEMBER_ID, NEW.MEMBER_NM, _conts, NEW.MOD_ID, NEW.MOD_NM, NEW.MOD_DT, NEW.MOD_IP
	);
	END IF;
END;
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER TR_MC_USER_MEMBER
AFTER UPDATE ON MC_USER_MEMBER
FOR EACH ROW
BEGIN
	DECLARE _conts VARCHAR(500);
	SET _conts = '';
	
	IF IFNULL(OLD.EMAIL, 'x') != IFNULL(NEW.EMAIL, 'x') THEN
		SET _conts = CONCAT(_conts, '<p>이메일 : ', NEW.EMAIL, '</p>');
	END IF;
	IF IFNULL(OLD.TEL, 'x') != IFNULL(NEW.TEL, 'x') THEN
		SET _conts = CONCAT(_conts, '<p>전화번호 : ', NEW.TEL, '</p>');
	END IF;
	IF IFNULL(OLD.CELL, 'x') != IFNULL(NEW.CELL, 'x') THEN
		SET _conts = CONCAT(_conts, '<p>휴대전화 : ', NEW.CELL, '</p>');
	END IF;
	IF IFNULL(OLD.MEMBER_PW, 'x') != IFNULL(NEW.MEMBER_PW, 'x') THEN
		SET _conts = CONCAT(_conts, '<p>패스워드 변경</p>');
	END IF;
	IF IFNULL(OLD.GROUP_SEQ, -1) != IFNULL(NEW.GROUP_SEQ, -1) THEN
		SET _conts = CONCAT(_conts, '<p>부서이동</p>');
    END IF;
    
	IF LENGTH(_conts) > 1 THEN   
	INSERT INTO MC_USER_MEMBER_HISTORY(
		MEMBER_ID, MEMBER_NM, CONTS, MOD_ID, MOD_NM, MOD_DT, MOD_IP
	) VALUES(
		NEW.MEMBER_ID, NEW.MEMBER_NM, _conts, NEW.MOD_ID, NEW.MOD_NM, NEW.MOD_DT, NEW.MOD_IP
	);
	END IF;
END;
$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE CP_MC_CMS_MENU_BAKUP(
     IN V_JSON_STAFFS TEXT
    ,IN V_JSON_STAFF_GROUP TEXT
    ,IN V_JSON_LIBS TEXT
    ,IN V_CMS_MENU_SEQ TEXT
 )
BEGIN 
   INSERT INTO MC_CMS_MENU_BAKUP(
            CMS_MENU_SEQ, TITLE, TITLE_PATH_ON, TITLE_PATH_OFF, MENU_ORDER, USE_YN, BLANK_YN, MENU_TYPE, TARGET_URL, 
            PROGRAM_NM, CUD_GROUP_SEQ, R_GROUP_SEQ, MANAGE_URL, ADD_PARAM, INNER_YN, BOARD_SEQ, SITE_ID, REG_NM, REG_DT, MOD_NM, MOD_DT, 
            DEL_NM, DEL_DT, DEL_YN, CHILD_TYPE, HEAD_HTML, TEMPLATE_TYPE, REG_ID, MOD_ID, DEL_ID, PARENT_MENU_SEQ, MENU_URL, TOP_YN,
            JSON_STAFFS, JSON_STAFF_GROUP, JSON_LIBS
        )
        SELECT 
            CMS_MENU_SEQ, TITLE, TITLE_PATH_ON, TITLE_PATH_OFF, MENU_ORDER, USE_YN, BLANK_YN, MENU_TYPE, TARGET_URL, 
            PROGRAM_NM, CUD_GROUP_SEQ, R_GROUP_SEQ, MANAGE_URL, ADD_PARAM, INNER_YN, BOARD_SEQ, SITE_ID, REG_NM, REG_DT, MOD_NM, MOD_DT, 
            DEL_NM, DEL_DT, DEL_YN, CHILD_TYPE, HEAD_HTML, TEMPLATE_TYPE, REG_ID, MOD_ID, DEL_ID, PARENT_MENU_SEQ, MENU_URL, TOP_YN,
            V_JSON_STAFFS, V_JSON_STAFF_GROUP, V_JSON_LIBS
        FROM MC_CMS_MENU 
        WHERE CMS_MENU_SEQ=V_CMS_MENU_SEQ
        ;
   COMMIT; 
END;
$$
DELIMITER ; 