/* 메뉴컨텐츠_관리그룹 */
CREATE TABLE mc_cms_staff_group (
	SEQ NUMBER(11) NOT NULL, /* 시퀀스 */
	CMS_MENU_SEQ NUMBER(11) NOT NULL, /* 메뉴_시퀀스 */
	GROUP_SEQ NUMBER(11) NOT NULL, /* 그룹_시퀀스 */
	GROUP_NM VARCHAR2(32), /* 그룹명 */
	REG_DT DATE, /* 등록일 */
	REG_ID VARCHAR2(30), /* 등록자_ID */
	REG_NM VARCHAR2(30), /* 등록자 */
	ORDER_SEQ NUMBER(11) DEFAULT 1 /* 순서 */
);

COMMENT ON TABLE mc_cms_staff_group IS '메뉴컨텐츠_관리그룹';

COMMENT ON COLUMN mc_cms_staff_group.SEQ IS '시퀀스';

COMMENT ON COLUMN mc_cms_staff_group.CMS_MENU_SEQ IS '메뉴_시퀀스';

COMMENT ON COLUMN mc_cms_staff_group.GROUP_SEQ IS '그룹_시퀀스';

COMMENT ON COLUMN mc_cms_staff_group.GROUP_NM IS '그룹명';

COMMENT ON COLUMN mc_cms_staff_group.REG_DT IS '등록일';

COMMENT ON COLUMN mc_cms_staff_group.REG_ID IS '등록자_ID';

COMMENT ON COLUMN mc_cms_staff_group.REG_NM IS '등록자';

COMMENT ON COLUMN mc_cms_staff_group.ORDER_SEQ IS '순서';

CREATE UNIQUE INDEX PK_mc_cms_staff_group
	ON mc_cms_staff_group (
		SEQ
	);

ALTER TABLE mc_cms_staff_group
	ADD
		CONSTRAINT PK_mc_cms_staff_group
		PRIMARY KEY (
			SEQ
		);

/* 메뉴별_개인정보_필터설정 */
CREATE TABLE mc_cms_menu_filter (
	SITE_ID NUMBER(11) NOT NULL, /* 사이트_ID */
	CMS_MENU_SEQ NUMBER(11) NOT NULL, /* 메뉴_시퀀스 */
	FILTER_YN CHAR(1) DEFAULT 'N', /* 필터_YN */
	JUMIN_YN CHAR(1) DEFAULT 'N', /* 주민번호_YN */
	BUSINO_YN CHAR(1) DEFAULT 'N', /* 사업자_YN */
	BUBINO_YN CHAR(1) DEFAULT 'N', /* 법인_YN */
	EMAIL_YN CHAR(1) DEFAULT 'N', /* 이메일_YN */
	TEL_YN CHAR(1) DEFAULT 'N', /* 전화번호_YN */
	CELL_YN CHAR(1) DEFAULT 'N', /* 휴대폰_YN */
	CARD_YN CHAR(1) DEFAULT 'N' /* 카드_YN */
);

COMMENT ON TABLE mc_cms_menu_filter IS '메뉴별_개인정보_필터설정';

COMMENT ON COLUMN mc_cms_menu_filter.SITE_ID IS '사이트_ID';

COMMENT ON COLUMN mc_cms_menu_filter.CMS_MENU_SEQ IS '메뉴시퀀스';

COMMENT ON COLUMN mc_cms_menu_filter.FILTER_YN IS '필터_YN';

COMMENT ON COLUMN mc_cms_menu_filter.JUMIN_YN IS '주민번호_YN';

COMMENT ON COLUMN mc_cms_menu_filter.BUSINO_YN IS '사업자_YN';

COMMENT ON COLUMN mc_cms_menu_filter.BUBINO_YN IS '법인_YN';

COMMENT ON COLUMN mc_cms_menu_filter.EMAIL_YN IS '이메일_YN';

COMMENT ON COLUMN mc_cms_menu_filter.TEL_YN IS '전화번호_YN';

COMMENT ON COLUMN mc_cms_menu_filter.CELL_YN IS '휴대폰_YN';

COMMENT ON COLUMN mc_cms_menu_filter.CARD_YN IS '카드_YN';

CREATE UNIQUE INDEX PK_mc_cms_menu_filter
	ON mc_cms_menu_filter (
		SITE_ID ASC,
		CMS_MENU_SEQ ASC
	);

ALTER TABLE mc_cms_menu_filter
	ADD
		CONSTRAINT PK_mc_cms_menu_filter
		PRIMARY KEY (
			SITE_ID,
			CMS_MENU_SEQ
		);

/* 만족도조사 */
CREATE TABLE mc_satisfaction (
	SEQ NUMBER(11) NOT NULL, /* 시퀀스 */
	CMS_MENU_SEQ NUMBER(11), /* 메뉴_시퀀스 */
	SCORE NUMBER(11) NOT NULL, /* 점수 */
	IP VARCHAR2(17), /* 아이피 */
	REG_DT DATE, /* 등록일 */
	ETC VARCHAR2(2000) /* 기타 */
);

COMMENT ON TABLE mc_satisfaction IS '만족도조사';

COMMENT ON COLUMN mc_satisfaction.SEQ IS '시퀀스';

COMMENT ON COLUMN mc_satisfaction.CMS_MENU_SEQ IS '메뉴_시퀀스';

COMMENT ON COLUMN mc_satisfaction.SCORE IS '점수';

COMMENT ON COLUMN mc_satisfaction.IP IS '아이피';

COMMENT ON COLUMN mc_satisfaction.REG_DT IS '등록일';

COMMENT ON COLUMN mc_satisfaction.ETC IS '기타';

CREATE UNIQUE INDEX PK_mc_satisfaction
	ON mc_satisfaction (
		SEQ
	);

ALTER TABLE mc_satisfaction
	ADD
		CONSTRAINT PK_mc_satisfaction
		PRIMARY KEY (
			SEQ
		);

/* 메뉴정보 */
CREATE TABLE mc_cms_menu (
	CMS_MENU_SEQ NUMBER(11) NOT NULL, /* 메뉴_시퀀스 */
	PARENT_MENU_SEQ NUMBER(11), /* 부모키 */
	TITLE VARCHAR2(255) NOT NULL, /* 메뉴명 */
	MENU_ORDER NUMBER(11) DEFAULT 1, /* 표시순서 */
	USE_YN VARCHAR2(1) DEFAULT 'Y' NOT NULL, /* 사용여부 */
	BLANK_YN VARCHAR2(1) DEFAULT 'N', /* 새창여부 */
	MENU_TYPE VARCHAR2(1), /* 메뉴타입 */
	TARGET_URL VARCHAR2(128), /* 링크주소 */
	PROGRAM_NM VARCHAR2(255), /* 프로그램명 */
	BOARD_SEQ NUMBER(11), /* 게시판_번호 */
	CONTS CLOB, /* 내용 */
	SITE_ID NUMBER(11) DEFAULT 1, /* 사이트_ID */
	REG_NM VARCHAR2(32), /* 등록자 */
	REG_DT DATE, /* 등록일 */
	MOD_NM VARCHAR2(32), /* 수정자 */
	MOD_DT DATE, /* 수정일 */
	DEL_NM VARCHAR2(32), /* 삭제자 */
	DEL_DT DATE, /* 삭제일 */
	DEL_YN CHAR(1) DEFAULT 'N', /* 삭제여부 */
	CHILD_TYPE NUMBER(11), /* 자식타입 */
	HEAD_HTML CLOB, /* 하단표시내용 */
	TEMPLATE_TYPE NUMBER(11) DEFAULT 1, /* 템플릿_타입 */
	MENU_URL VARCHAR2(100), /* 메뉴_URL */
	CUD_GROUP_SEQ VARCHAR2(150), /* 수정_삭제_권한시퀀스 */
	R_GROUP_SEQ VARCHAR2(150), /* 읽기권한_시퀀스 */
	MANAGE_URL VARCHAR2(128), /* 관리페이지_주소 */
	TOP_YN CHAR(1) DEFAULT 'Y', /* 상단메뉴_노출여부 */
	REG_ID VARCHAR2(30), /* 등록자_ID */
	MOD_ID VARCHAR2(30), /* 수정자_ID */
	DEL_ID VARCHAR2(30), /* 삭제자_ID */
	INNER_YN CHAR(1) DEFAULT 'N', /* 관리메뉴_탭에서_관리사용여부 */
	SUB_PATH VARCHAR2(20), /* 위성 사이트사용시 서브패스 */
	CMOD_ID VARCHAR2(32), /* 콘텐츠수정자_아이디 */
	CMOD_NM VARCHAR2(32), /* 콘텐츠수정자명 */
	CMOD_DT DATE, /* 콘텐츠수정일 */
	TEMP_CONTS CLOB, /* 임시저장_내용 */
	CCL_TYPE CHAR(1), /* 저작물타입 */
	NURI_TYPE CHAR(1), /* 공공누리타입 */
	TAG_NAMES VARCHAR2(200), /* 태그이름 */
	ADD_PARAM VARCHAR2(255), /* 추가파라미터 */
	FOOTER_HTML CLOB, /* 홈페이지 하단내용 */
	CONDITIONS_HTML CLOB, /* 홈페이지 이용약관 */
	PRIVACY_HTML CLOB, /* 취급방침 재동의 내용 */
	SATISFACTION_YN CHAR(1), /* 페이지 만족도 사용여부 */
	MANAGE_YN CHAR(1) /* 담당자 안내 사용여부 */
);

COMMENT ON TABLE mc_cms_menu IS '메뉴정보';

COMMENT ON COLUMN mc_cms_menu.CMS_MENU_SEQ IS '메뉴_시퀀스';

COMMENT ON COLUMN mc_cms_menu.PARENT_MENU_SEQ IS '부모키';

COMMENT ON COLUMN mc_cms_menu.TITLE IS '메뉴명';

COMMENT ON COLUMN mc_cms_menu.MENU_ORDER IS '표시순서';

COMMENT ON COLUMN mc_cms_menu.USE_YN IS '사용여부';

COMMENT ON COLUMN mc_cms_menu.BLANK_YN IS '새창여부';

COMMENT ON COLUMN mc_cms_menu.MENU_TYPE IS '메뉴타입';

COMMENT ON COLUMN mc_cms_menu.TARGET_URL IS '링크주소';

COMMENT ON COLUMN mc_cms_menu.PROGRAM_NM IS '프로그램명';

COMMENT ON COLUMN mc_cms_menu.BOARD_SEQ IS '게시판_번호';

COMMENT ON COLUMN mc_cms_menu.CONTS IS '내용';

COMMENT ON COLUMN mc_cms_menu.SITE_ID IS '사이트_ID';

COMMENT ON COLUMN mc_cms_menu.REG_NM IS '등록자';

COMMENT ON COLUMN mc_cms_menu.REG_DT IS '등록일';

COMMENT ON COLUMN mc_cms_menu.MOD_NM IS '수정자';

COMMENT ON COLUMN mc_cms_menu.MOD_DT IS '수정일';

COMMENT ON COLUMN mc_cms_menu.DEL_NM IS '삭제자';

COMMENT ON COLUMN mc_cms_menu.DEL_DT IS '삭제일';

COMMENT ON COLUMN mc_cms_menu.DEL_YN IS '삭제여부';

COMMENT ON COLUMN mc_cms_menu.CHILD_TYPE IS '자식타입';

COMMENT ON COLUMN mc_cms_menu.HEAD_HTML IS '하단표시내용';

COMMENT ON COLUMN mc_cms_menu.TEMPLATE_TYPE IS '템플릿_타입';

COMMENT ON COLUMN mc_cms_menu.MENU_URL IS '메뉴_URL';

COMMENT ON COLUMN mc_cms_menu.CUD_GROUP_SEQ IS '수정_삭제_권한시퀀스';

COMMENT ON COLUMN mc_cms_menu.R_GROUP_SEQ IS '읽기권한_시퀀스';

COMMENT ON COLUMN mc_cms_menu.MANAGE_URL IS '관리페이지_주소';

COMMENT ON COLUMN mc_cms_menu.TOP_YN IS '상단메뉴_노출여부';

COMMENT ON COLUMN mc_cms_menu.REG_ID IS '등록자_ID';

COMMENT ON COLUMN mc_cms_menu.MOD_ID IS '수정자_ID';

COMMENT ON COLUMN mc_cms_menu.DEL_ID IS '삭제자_ID';

COMMENT ON COLUMN mc_cms_menu.INNER_YN IS '관리메뉴_탭에서_관리사용여부';

COMMENT ON COLUMN mc_cms_menu.SUB_PATH IS '위성 사이트사용시 서브패스';

COMMENT ON COLUMN mc_cms_menu.CMOD_ID IS '콘텐츠수정자_아이디';

COMMENT ON COLUMN mc_cms_menu.CMOD_NM IS '콘텐츠수정자명';

COMMENT ON COLUMN mc_cms_menu.CMOD_DT IS '콘텐츠수정일';

COMMENT ON COLUMN mc_cms_menu.TEMP_CONTS IS '임시저장_내용';

COMMENT ON COLUMN mc_cms_menu.CCL_TYPE IS '저작물타입';

COMMENT ON COLUMN mc_cms_menu.NURI_TYPE IS '공공누리타입';

COMMENT ON COLUMN mc_cms_menu.TAG_NAMES IS '태그이름';

COMMENT ON COLUMN mc_cms_menu.ADD_PARAM IS '추가파라미터';

COMMENT ON COLUMN mc_cms_menu.FOOTER_HTML IS '홈페이지 하단내용';

COMMENT ON COLUMN mc_cms_menu.CONDITIONS_HTML IS '홈페이지 이용약관';

COMMENT ON COLUMN mc_cms_menu.PRIVACY_HTML IS '취급방침 재동의 내용';

COMMENT ON COLUMN mc_cms_menu.SATISFACTION_YN IS '페이지 만족도 사용여부';

COMMENT ON COLUMN mc_cms_menu.MANAGE_YN IS '담당자 안내 사용여부';

CREATE UNIQUE INDEX PK_mc_cms_menu
	ON mc_cms_menu (
		CMS_MENU_SEQ
	);

CREATE INDEX IDX_CMS_MENU_SORTORDER
	ON mc_cms_menu (
		PARENT_MENU_SEQ,
		MENU_ORDER
	);

ALTER TABLE mc_cms_menu
	ADD
		CONSTRAINT PK_mc_cms_menu
		PRIMARY KEY (
			CMS_MENU_SEQ
		);

/* 관리회원 */
CREATE TABLE mc_member (
	MEMBER_ID VARCHAR2(30) NOT NULL, /* 회원_ID */
	MEMBER_PW VARCHAR2(100), /* 회원_패스워드 */
	MEMBER_NM VARCHAR2(30), /* 회원명 */
	EMAIL VARCHAR2(100), /* 이메일 */
	TEL VARCHAR2(15), /* 전화번호 */
	CELL VARCHAR2(15), /* 휴대폰번호 */
	GROUP_SEQ NUMBER, /* 관리자_그룹시퀀스 */
	LAST_LOGIN DATE, /* 마지막_로그인시간 */
	MOD_ID VARCHAR2(30), /* 수정자_ID */
	MOD_NM VARCHAR2(30), /* 수정자 */
	MOD_DT DATE, /* 수정일 */
	DEL_ID VARCHAR2(30), /* 삭제자_ID */
	DEL_NM VARCHAR2(30), /* 삭제자 */
	DEL_DT DATE, /* 삭제일 */
	USE_YN CHAR(1) DEFAULT 'Y', /* 사용여부 */
	DEL_YN CHAR(1) DEFAULT 'N', /* 삭제여부 */
	ORDER_SEQ NUMBER(11), /* 순서 */
	RESPONSIBILITIES VARCHAR2(500), /* 담당업무 */
	POSITIONS VARCHAR2(100), /* 직위 */
	BLOCK_YN CHAR(1) DEFAULT 'N' NOT NULL, /* 블록여부 */
	LOGIN_FAIL_CNT NUMBER(11) DEFAULT 0 NOT NULL, /* 로그인_시도횟수 */
	LAST_PW_DT DATE, /* 마지막_패스워드변경일 */
	DI VARCHAR2(100), /* DI */
	BIRTH VARCHAR2(8), /* 생년월일 */
	EMAIL_YN CHAR(1) DEFAULT 'N', /* 이메일발송_허용 */
	SMS_YN CHAR(1) DEFAULT 'N', /* SMS발송_허용 */
	REG_DT DATE, /* 등록일 */
	MOD_IP VARCHAR2(16), /* 수정자_IP */
	DORMANCY_YN CHAR(1) DEFAULT 'N' /* 휴면계정_여부 */
);

COMMENT ON TABLE mc_member IS '관리회원';

COMMENT ON COLUMN mc_member.MEMBER_ID IS '회원_ID';

COMMENT ON COLUMN mc_member.MEMBER_PW IS '회원_패스워드';

COMMENT ON COLUMN mc_member.MEMBER_NM IS '회원명';

COMMENT ON COLUMN mc_member.EMAIL IS '이메일';

COMMENT ON COLUMN mc_member.TEL IS '전화번호';

COMMENT ON COLUMN mc_member.CELL IS '휴대폰번호';

COMMENT ON COLUMN mc_member.GROUP_SEQ IS '관리자_그룹시퀀스';

COMMENT ON COLUMN mc_member.LAST_LOGIN IS '마지막_로그인시간';

COMMENT ON COLUMN mc_member.MOD_ID IS '수정자_ID';

COMMENT ON COLUMN mc_member.MOD_NM IS '수정자';

COMMENT ON COLUMN mc_member.MOD_DT IS '수정일';

COMMENT ON COLUMN mc_member.DEL_ID IS '삭제자_ID';

COMMENT ON COLUMN mc_member.DEL_NM IS '삭제자';

COMMENT ON COLUMN mc_member.DEL_DT IS '삭제일';

COMMENT ON COLUMN mc_member.USE_YN IS '사용여부';

COMMENT ON COLUMN mc_member.DEL_YN IS '삭제여부';

COMMENT ON COLUMN mc_member.ORDER_SEQ IS '순서';

COMMENT ON COLUMN mc_member.RESPONSIBILITIES IS '담당업무';

COMMENT ON COLUMN mc_member.POSITIONS IS '직위';

COMMENT ON COLUMN mc_member.BLOCK_YN IS '블록여부';

COMMENT ON COLUMN mc_member.LOGIN_FAIL_CNT IS '로그인_시도횟수';

COMMENT ON COLUMN mc_member.LAST_PW_DT IS '마지막_패스워드변경일';

COMMENT ON COLUMN mc_member.DI IS 'DI';

COMMENT ON COLUMN mc_member.BIRTH IS '생년월일';

COMMENT ON COLUMN mc_member.EMAIL_YN IS '이메일발송_허용';

COMMENT ON COLUMN mc_member.SMS_YN IS 'SMS발송_허용';

COMMENT ON COLUMN mc_member.REG_DT IS '등록일';

COMMENT ON COLUMN mc_member.MOD_IP IS '수정자_IP';

COMMENT ON COLUMN mc_member.DORMANCY_YN IS '휴면계정_여부';

CREATE UNIQUE INDEX PK_mc_member
	ON mc_member (
		MEMBER_ID
	);

ALTER TABLE mc_member
	ADD
		CONSTRAINT PK_mc_member
		PRIMARY KEY (
			MEMBER_ID
		);

/* 공통코드목록_상세 */
CREATE TABLE mc_common_code (
	CODE_SEQ NUMBER(11) NOT NULL, /* 시퀀스 */
	CODE_GROUP_SEQ NUMBER(11) NOT NULL, /* 공통코드_시퀀스 */
	CODE VARCHAR2(32) NOT NULL, /* 코드값 */
	CODE_NM VARCHAR2(64) NOT NULL, /* 코드명 */
	VAL1 VARCHAR2(200), /* VAL1 */
	VAL2 VARCHAR2(200), /* VAL2 */
	ETC VARCHAR2(200), /* 기타 */
	USE_YN CHAR(1) NOT NULL, /* 사용여부 */
	ORDER_SEQ NUMBER(11) DEFAULT 1 NOT NULL, /* 순서 */
	REG_ID VARCHAR2(20), /* 등록자_ID */
	REG_NM VARCHAR2(20), /* 등록자 */
	REG_IP VARCHAR2(15), /* 등록자_IP */
	REG_DT DATE, /* 등록일 */
	MOD_ID VARCHAR2(20), /* 수정자_ID */
	MOD_NM VARCHAR2(20), /* 수정자 */
	MOD_IP VARCHAR2(15), /* 수정자_IP */
	MOD_DT DATE, /* 수정일 */
	DEL_ID VARCHAR2(20), /* 삭제자_ID */
	DEL_NM VARCHAR2(20), /* 삭제자 */
	DEL_IP VARCHAR2(15), /* 삭제자_IP */
	DEL_DT DATE, /* 삭제일 */
	DEL_YN CHAR(1) DEFAULT 'N' /* 삭제여부 */
);

COMMENT ON TABLE mc_common_code IS '공통코드목록_상세';

COMMENT ON COLUMN mc_common_code.CODE_SEQ IS '시퀀스';

COMMENT ON COLUMN mc_common_code.CODE_GROUP_SEQ IS '공통코드_시퀀스';

COMMENT ON COLUMN mc_common_code.CODE IS '코드값';

COMMENT ON COLUMN mc_common_code.CODE_NM IS '코드명';

COMMENT ON COLUMN mc_common_code.VAL1 IS 'VAL1';

COMMENT ON COLUMN mc_common_code.VAL2 IS 'VAL2';

COMMENT ON COLUMN mc_common_code.ETC IS '기타';

COMMENT ON COLUMN mc_common_code.USE_YN IS '사용여부';

COMMENT ON COLUMN mc_common_code.ORDER_SEQ IS '순서';

COMMENT ON COLUMN mc_common_code.REG_ID IS '등록자_ID';

COMMENT ON COLUMN mc_common_code.REG_NM IS '등록자';

COMMENT ON COLUMN mc_common_code.REG_IP IS '등록자_IP';

COMMENT ON COLUMN mc_common_code.REG_DT IS '등록일';

COMMENT ON COLUMN mc_common_code.MOD_ID IS '수정자_ID';

COMMENT ON COLUMN mc_common_code.MOD_NM IS '수정자';

COMMENT ON COLUMN mc_common_code.MOD_IP IS '수정자_IP';

COMMENT ON COLUMN mc_common_code.MOD_DT IS '수정일';

COMMENT ON COLUMN mc_common_code.DEL_ID IS '삭제자_ID';

COMMENT ON COLUMN mc_common_code.DEL_NM IS '삭제자';

COMMENT ON COLUMN mc_common_code.DEL_IP IS '삭제자_IP';

COMMENT ON COLUMN mc_common_code.DEL_DT IS '삭제일';

COMMENT ON COLUMN mc_common_code.DEL_YN IS '삭제여부';

CREATE UNIQUE INDEX PK_mc_common_code
	ON mc_common_code (
		CODE_SEQ,
		CODE_GROUP_SEQ ASC
	);

ALTER TABLE mc_common_code
	ADD
		CONSTRAINT PK_mc_common_code
		PRIMARY KEY (
			CODE_SEQ,
			CODE_GROUP_SEQ
		);

/* 메뉴컨텐츠_관리회원 */
CREATE TABLE mc_cms_staff (
	CMS_STAFF_SEQ NUMBER(11) NOT NULL, /* 시퀀스 */
	CMS_MENU_SEQ NUMBER(11) NOT NULL, /* 메뉴_시퀀스 */
	GROUP_SEQ NUMBER(11) NOT NULL, /* 그룹_시퀀스 */
	GROUP_NM VARCHAR2(32), /* 그룹명 */
	MEMBER_NM VARCHAR2(30), /* 회원명 */
	MEMBER_ID VARCHAR2(30), /* 회원_ID */
	REG_DT DATE, /* 등록일 */
	REG_ID VARCHAR2(30), /* 등록자_ID */
	REG_NM VARCHAR2(30), /* 등록자 */
	ORDER_SEQ NUMBER(11) DEFAULT 1 /* 순서 */
);

COMMENT ON TABLE mc_cms_staff IS '메뉴컨텐츠_관리회원';

COMMENT ON COLUMN mc_cms_staff.CMS_STAFF_SEQ IS '시퀀스';

COMMENT ON COLUMN mc_cms_staff.CMS_MENU_SEQ IS '메뉴_시퀀스';

COMMENT ON COLUMN mc_cms_staff.GROUP_SEQ IS '그룹_시퀀스';

COMMENT ON COLUMN mc_cms_staff.GROUP_NM IS '그룹명';

COMMENT ON COLUMN mc_cms_staff.MEMBER_NM IS '회원명';

COMMENT ON COLUMN mc_cms_staff.MEMBER_ID IS '회원_ID';

COMMENT ON COLUMN mc_cms_staff.REG_DT IS '등록일';

COMMENT ON COLUMN mc_cms_staff.REG_ID IS '등록자_ID';

COMMENT ON COLUMN mc_cms_staff.REG_NM IS '등록자';

COMMENT ON COLUMN mc_cms_staff.ORDER_SEQ IS '순서';

CREATE UNIQUE INDEX PK_mc_cms_staff
	ON mc_cms_staff (
		CMS_STAFF_SEQ
	);

ALTER TABLE mc_cms_staff
	ADD
		CONSTRAINT PK_mc_cms_staff
		PRIMARY KEY (
			CMS_STAFF_SEQ
		);

/* 팝업_목록 */
CREATE TABLE mc_popupzone (
	POPUPZONE_SEQ NUMBER(11) NOT NULL, /* 스퀀스 */
	TITLE VARCHAR2(128), /* 제목 */
	LINK_YN CHAR(1), /* 링크_사용여부 */
	LINK_URL VARCHAR2(256), /* 링크_URL */
	LINK_TARGET VARCHAR2(16), /* 새창 */
	FILE_PATH VARCHAR2(128), /* 파일경로 */
	USE_YN CHAR(1), /* 사용여부 */
	ORDER_SEQ VARCHAR2(5) DEFAULT '99999', /* 순서 */
	REG_DT DATE, /* 등록일 */
	REG_ID VARCHAR2(30), /* 등록자_ID */
	REG_NM VARCHAR2(32), /* 등록자 */
	MOD_DT DATE, /* 수정일 */
	MOD_ID VARCHAR2(30), /* 수정자_ID */
	MOD_NM VARCHAR2(32), /* 수정자 */
	DEL_DT DATE, /* 삭제일 */
	DEL_ID VARCHAR2(30), /* 삭제자_ID */
	DEL_NM VARCHAR2(32), /* 삭제자 */
	DEL_YN CHAR(1) DEFAULT 'N', /* 삭제여부 */
	START_DT DATE, /* 게시_시작일 */
	END_DT DATE, /* 게시_종료일 */
	ALT VARCHAR2(500), /* 설명 */
	X_COORD VARCHAR2(20), /* X좌표 */
	Y_COORD VARCHAR2(20), /* Y좌표 */
	SITE_ID VARCHAR2(20), /* 사이트_ID */
	SELECTER VARCHAR2(20) /* 구분 */
);

COMMENT ON TABLE mc_popupzone IS '팝업_목록';

COMMENT ON COLUMN mc_popupzone.POPUPZONE_SEQ IS '스퀀스';

COMMENT ON COLUMN mc_popupzone.TITLE IS '제목';

COMMENT ON COLUMN mc_popupzone.LINK_YN IS '링크_사용여부';

COMMENT ON COLUMN mc_popupzone.LINK_URL IS '링크_URL';

COMMENT ON COLUMN mc_popupzone.LINK_TARGET IS '새창';

COMMENT ON COLUMN mc_popupzone.FILE_PATH IS '파일경로';

COMMENT ON COLUMN mc_popupzone.USE_YN IS '사용여부';

COMMENT ON COLUMN mc_popupzone.ORDER_SEQ IS '순서';

COMMENT ON COLUMN mc_popupzone.REG_DT IS '등록일';

COMMENT ON COLUMN mc_popupzone.REG_ID IS '등록자_ID';

COMMENT ON COLUMN mc_popupzone.REG_NM IS '등록자';

COMMENT ON COLUMN mc_popupzone.MOD_DT IS '수정일';

COMMENT ON COLUMN mc_popupzone.MOD_ID IS '수정자_ID';

COMMENT ON COLUMN mc_popupzone.MOD_NM IS '수정자';

COMMENT ON COLUMN mc_popupzone.DEL_DT IS '삭제일';

COMMENT ON COLUMN mc_popupzone.DEL_ID IS '삭제자_ID';

COMMENT ON COLUMN mc_popupzone.DEL_NM IS '삭제자';

COMMENT ON COLUMN mc_popupzone.DEL_YN IS '삭제여부';

COMMENT ON COLUMN mc_popupzone.START_DT IS '게시_시작일';

COMMENT ON COLUMN mc_popupzone.END_DT IS '게시_종료일';

COMMENT ON COLUMN mc_popupzone.ALT IS '설명';

COMMENT ON COLUMN mc_popupzone.X_COORD IS 'X좌표';

COMMENT ON COLUMN mc_popupzone.Y_COORD IS 'Y좌표';

COMMENT ON COLUMN mc_popupzone.SITE_ID IS '사이트_ID';

COMMENT ON COLUMN mc_popupzone.SELECTER IS '구분';

CREATE UNIQUE INDEX PK_mc_popupzone
	ON mc_popupzone (
		POPUPZONE_SEQ
	);

ALTER TABLE mc_popupzone
	ADD
		CONSTRAINT PK_mc_popupzone
		PRIMARY KEY (
			POPUPZONE_SEQ
		);

/* 게시판설정_커스텀_컬럼_타입 */
CREATE TABLE mc_board_column (
	ORDER_NUM NUMBER(11) NOT NULL, /* 시퀀스 */
	COL_CODE VARCHAR2(20), /* 컬럼_코드 */
	COL_KOR VARCHAR2(20), /* 컬럼_제목 */
	COL_HELPER VARCHAR2(4000), /* 컬럼_설명 */
	COL_EDIT CHAR(1) DEFAULT 'Y' /* 사용자_입력가능여부 */
);

COMMENT ON TABLE mc_board_column IS '게시판설정_커스텀_컬럼_타입';

COMMENT ON COLUMN mc_board_column.ORDER_NUM IS '시퀀스';

COMMENT ON COLUMN mc_board_column.COL_CODE IS '컬럼_코드';

COMMENT ON COLUMN mc_board_column.COL_KOR IS '컬럼_제목';

COMMENT ON COLUMN mc_board_column.COL_HELPER IS '컬럼_설명';

COMMENT ON COLUMN mc_board_column.COL_EDIT IS '사용자_입력가능여부';

CREATE UNIQUE INDEX PK_mc_board_column
	ON mc_board_column (
		ORDER_NUM ASC
	);

ALTER TABLE mc_board_column
	ADD
		CONSTRAINT PK_mc_board_column
		PRIMARY KEY (
			ORDER_NUM
		);

/* 관리자_로그인_이력 */
CREATE TABLE mc_staff_login_tracking (
	SEQ NUMBER(11) NOT NULL, /* 로그인_시퀀스 */
	MEMBER_ID VARCHAR2(100), /* 회원_ID */
	MEMBER_NAME VARCHAR2(100), /* 회원이름 */
	LOGIN_DATE DATE, /* 로그인일 */
	LOGIN_IP VARCHAR2(50) /* 로그인_아이피 */
);

COMMENT ON TABLE mc_staff_login_tracking IS '관리자_로그인_이력';

COMMENT ON COLUMN mc_staff_login_tracking.SEQ IS '로그인_시퀀스';

COMMENT ON COLUMN mc_staff_login_tracking.MEMBER_ID IS '회원_ID';

COMMENT ON COLUMN mc_staff_login_tracking.MEMBER_NAME IS '회원이름';

COMMENT ON COLUMN mc_staff_login_tracking.LOGIN_DATE IS '로그인일';

COMMENT ON COLUMN mc_staff_login_tracking.LOGIN_IP IS '로그인_아이피';

CREATE UNIQUE INDEX PK_mc_staff_login_tracking
	ON mc_staff_login_tracking (
		SEQ
	);

CREATE INDEX SEQ
	ON mc_staff_login_tracking (
		SEQ,
		LOGIN_DATE
	);

ALTER TABLE mc_staff_login_tracking
	ADD
		CONSTRAINT PK_mc_staff_login_tracking
		PRIMARY KEY (
			SEQ
		);

/* 설문조사_질문지 */
CREATE TABLE mc_poll_question (
	POLL_SEQ NUMBER(11) NOT NULL, /* 설문조사_시퀀스 */
	QUESTION_SEQ NUMBER(11) NOT NULL, /* 질문_시퀀스 */
	QUESTION VARCHAR2(500) NOT NULL, /* 질문 */
	QUESTION_TYPE CHAR(1) NOT NULL, /* 질문_타입 */
	QUESTION_CONTENT CLOB, /* 질문_내용 */
	DEL_YN CHAR(1) NOT NULL, /* 삭제여부 */
	SUBJECT_YN CHAR(1) DEFAULT 'N', /* 소제목_여부 */
	REQUIRED_YN CHAR(1) DEFAULT 'N', /* 필수_여부 */
	REQUIRED_COUNT NUMBER(11) DEFAULT 0, /* 다중선택_갯수 */
	REQUIRED_COUNT_CONTROLL CHAR(1) DEFAULT 'U' /* 다중선택_미만_이상_선택 */
);

COMMENT ON TABLE mc_poll_question IS '설문조사_질문지';

COMMENT ON COLUMN mc_poll_question.POLL_SEQ IS '설문조사_시퀀스';

COMMENT ON COLUMN mc_poll_question.QUESTION_SEQ IS '질문_시퀀스';

COMMENT ON COLUMN mc_poll_question.QUESTION IS '질문';

COMMENT ON COLUMN mc_poll_question.QUESTION_TYPE IS '질문_타입';

COMMENT ON COLUMN mc_poll_question.QUESTION_CONTENT IS '질문_내용';

COMMENT ON COLUMN mc_poll_question.DEL_YN IS '삭제여부';

COMMENT ON COLUMN mc_poll_question.SUBJECT_YN IS '소제목_여부';

COMMENT ON COLUMN mc_poll_question.REQUIRED_YN IS '필수_여부';

COMMENT ON COLUMN mc_poll_question.REQUIRED_COUNT IS '다중선택_갯수';

COMMENT ON COLUMN mc_poll_question.REQUIRED_COUNT_CONTROLL IS '다중선택_미만_이상_선택';

CREATE UNIQUE INDEX PK_mc_poll_question
	ON mc_poll_question (
		POLL_SEQ ASC,
		QUESTION_SEQ ASC
	);

ALTER TABLE mc_poll_question
	ADD
		CONSTRAINT PK_mc_poll_question
		PRIMARY KEY (
			POLL_SEQ,
			QUESTION_SEQ
		);

/* 게시판설정_카테고리 */
CREATE TABLE mc_board_cat (
	BOARD_CAT_SEQ NUMBER(11) NOT NULL, /* 시퀀스 */
	BOARD_SEQ NUMBER(11) NOT NULL, /* 게시판_시퀀스 */
	CAT_NM VARCHAR2(64) NOT NULL, /* 카테고리명 */
	REG_DT DATE, /* 등록일 */
	REG_ID VARCHAR2(30), /* 등록자_ID */
	REG_NM VARCHAR2(32) NOT NULL, /* 등록자 */
	MOD_DT DATE, /* 수정일 */
	MOD_ID VARCHAR2(30), /* 수정자_ID */
	MOD_NM VARCHAR2(32), /* 수정자 */
	DEL_DT DATE, /* 삭제일 */
	DEL_ID VARCHAR2(30), /* 삭제자_ID */
	DEL_NM VARCHAR2(32), /* 삭제자 */
	DEL_YN CHAR(1) DEFAULT 'N' NOT NULL /* 삭제여부 */
);

COMMENT ON TABLE mc_board_cat IS '게시판설정_카테고리';

COMMENT ON COLUMN mc_board_cat.BOARD_CAT_SEQ IS '시퀀스';

COMMENT ON COLUMN mc_board_cat.BOARD_SEQ IS '게시판_시퀀스';

COMMENT ON COLUMN mc_board_cat.CAT_NM IS '카테고리명';

COMMENT ON COLUMN mc_board_cat.REG_DT IS '등록일';

COMMENT ON COLUMN mc_board_cat.REG_ID IS '등록자_ID';

COMMENT ON COLUMN mc_board_cat.REG_NM IS '등록자';

COMMENT ON COLUMN mc_board_cat.MOD_DT IS '수정일';

COMMENT ON COLUMN mc_board_cat.MOD_ID IS '수정자_ID';

COMMENT ON COLUMN mc_board_cat.MOD_NM IS '수정자';

COMMENT ON COLUMN mc_board_cat.DEL_DT IS '삭제일';

COMMENT ON COLUMN mc_board_cat.DEL_ID IS '삭제자_ID';

COMMENT ON COLUMN mc_board_cat.DEL_NM IS '삭제자';

COMMENT ON COLUMN mc_board_cat.DEL_YN IS '삭제여부';

CREATE UNIQUE INDEX PK_mc_board_cat
	ON mc_board_cat (
		BOARD_CAT_SEQ,
		BOARD_SEQ ASC
	);

ALTER TABLE mc_board_cat
	ADD
		CONSTRAINT PK_mc_board_cat
		PRIMARY KEY (
			BOARD_CAT_SEQ,
			BOARD_SEQ
		);

/* 관리자_작업이력 */
CREATE TABLE mc_staff_location_tracking (
	SEQ NUMBER(11) NOT NULL, /* 시퀀스 */
	PARENT_SEQ NUMBER(11) NOT NULL, /* 로그인_시퀀스 */
	LOCATION_TIME DATE, /* 이동시간 */
	TITLE VARCHAR2(500), /* 메뉴명 */
	URL VARCHAR2(1000) NOT NULL, /* 이동주소 */
	PARAMS CLOB, /* 파라미터목록 */
	JOB VARCHAR2(100) /* 작업간략내용 */
);

COMMENT ON TABLE mc_staff_location_tracking IS '관리자_작업이력';

COMMENT ON COLUMN mc_staff_location_tracking.SEQ IS '시퀀스';

COMMENT ON COLUMN mc_staff_location_tracking.PARENT_SEQ IS '로그인_시퀀스';

COMMENT ON COLUMN mc_staff_location_tracking.LOCATION_TIME IS '이동시간';

COMMENT ON COLUMN mc_staff_location_tracking.TITLE IS '메뉴명';

COMMENT ON COLUMN mc_staff_location_tracking.URL IS '이동주소';

COMMENT ON COLUMN mc_staff_location_tracking.PARAMS IS '파라미터목록';

COMMENT ON COLUMN mc_staff_location_tracking.JOB IS '작업간략내용';

CREATE UNIQUE INDEX PK_mc_staff_location_tracking
	ON mc_staff_location_tracking (
		SEQ
	);

CREATE INDEX SEQ2
	ON mc_staff_location_tracking (
		SEQ,
		PARENT_SEQ
	);

ALTER TABLE mc_staff_location_tracking
	ADD
		CONSTRAINT PK_mc_staff_location_tracking
		PRIMARY KEY (
			SEQ
		);

/* 메일발송_대기목록 */
CREATE TABLE mc_mail_queue (
	SEQ NUMBER(11) NOT NULL, /* 시퀀스 */
	P_SEQ NUMBER(11) NOT NULL, /* 메일발송_시퀀스 */
	USER_NAME VARCHAR2(50) NOT NULL, /* 수신자 */
	USER_EMAIL VARCHAR2(50) NOT NULL, /* 수신자_이메일 */
	STATUS CHAR(1) /* 상태 */
);

COMMENT ON TABLE mc_mail_queue IS '메일발송_대기목록';

COMMENT ON COLUMN mc_mail_queue.SEQ IS '시퀀스';

COMMENT ON COLUMN mc_mail_queue.P_SEQ IS '메일발송_시퀀스';

COMMENT ON COLUMN mc_mail_queue.USER_NAME IS '수신자';

COMMENT ON COLUMN mc_mail_queue.USER_EMAIL IS '수신자_이메일';

COMMENT ON COLUMN mc_mail_queue.STATUS IS '상태';

CREATE UNIQUE INDEX PK_mc_mail_queue
	ON mc_mail_queue (
		SEQ
	);

ALTER TABLE mc_mail_queue
	ADD
		CONSTRAINT PK_mc_mail_queue
		PRIMARY KEY (
			SEQ
		);

/* 소셜댓글_계정 */
CREATE TABLE mc_comment_sns_account (
	SEQ NUMBER(11) NOT NULL, /* 시퀀스 */
	TWT_CONSUMER_KEY VARCHAR2(255), /* 트위터_컨서머_키 */
	TWT_CONSUMER_SECRET VARCHAR2(255), /* 트위터_컨서머_시크릿 */
	FACE_APPID VARCHAR2(255), /* 페이스북_앱_아이디 */
	FACE_APP_SECRET VARCHAR2(255), /* 페이스북_앱_시크릿 */
	FACE_ACCESS_TOKEN VARCHAR2(255), /* 페이스북_엑세스토큰 */
	NAV_CLIENT_ID VARCHAR2(255), /* 네이버_클라이언트_아이디 */
	NAV_CLIENT_SECRET VARCHAR2(255), /* 네이버_클라이언트_시크릿 */
	GOOGLE_CLIENT_ID VARCHAR2(255), /* 구글_클라이언트_아이디 */
	GOOGLE_CLIENT_SECRET VARCHAR2(255), /* 구글_클라이언트_시크릿 */
	INSTA_CLIENT_ID VARCHAR(255), /* 인스타_클라이언트_아이디 */
	INSTA_CLIENT_SECRET VARCHAR(255), /* 인스타_클라이언트_시크릿 */
	KAO_CLIENT_ID VARCHAR2(255) /* 카카오_클라이언트_아이디 */
);

COMMENT ON TABLE mc_comment_sns_account IS '소셜댓글_계정';

COMMENT ON COLUMN mc_comment_sns_account.SEQ IS '시퀀스';

COMMENT ON COLUMN mc_comment_sns_account.TWT_CONSUMER_KEY IS '트위터_컨서머_키';

COMMENT ON COLUMN mc_comment_sns_account.TWT_CONSUMER_SECRET IS '트위터_컨서머_시크릿';

COMMENT ON COLUMN mc_comment_sns_account.FACE_APPID IS '페이스북_앱_아이디';

COMMENT ON COLUMN mc_comment_sns_account.FACE_APP_SECRET IS '페이스북_앱_시크릿';

COMMENT ON COLUMN mc_comment_sns_account.FACE_ACCESS_TOKEN IS '페이스북_엑세스토큰';

COMMENT ON COLUMN mc_comment_sns_account.NAV_CLIENT_ID IS '네이버_클라이언트_아이디';

COMMENT ON COLUMN mc_comment_sns_account.NAV_CLIENT_SECRET IS '네이버_클라이언트_시크릿';

COMMENT ON COLUMN mc_comment_sns_account.GOOGLE_CLIENT_ID IS '구글_클라이언트_아이디';

COMMENT ON COLUMN mc_comment_sns_account.GOOGLE_CLIENT_SECRET IS '구글_클라이언트_시크릿';

COMMENT ON COLUMN mc_comment_sns_account.INSTA_CLIENT_ID IS '인스타_클라이언트_아이디';

COMMENT ON COLUMN mc_comment_sns_account.INSTA_CLIENT_SECRET IS '인스타_클라이언트_시크릿';

COMMENT ON COLUMN mc_comment_sns_account.KAO_CLIENT_ID IS '카카오_클라이언트_아이디';

CREATE UNIQUE INDEX PK_mc_comment_sns_account
	ON mc_comment_sns_account (
		SEQ
	);

ALTER TABLE mc_comment_sns_account
	ADD
		CONSTRAINT PK_mc_comment_sns_account
		PRIMARY KEY (
			SEQ
		);

/* 메일서버설정 */
CREATE TABLE mc_mail_smtp (
	SEQ NUMBER(11) NOT NULL, /* 시퀀스 */
	TITLE VARCHAR2(200) NOT NULL, /* 호스트명 */
	HOST VARCHAR2(100) NOT NULL, /* 호스트 */
	PORT NUMBER(11) NOT NULL, /* 포트 */
	AUTH_ID VARCHAR2(200) NOT NULL, /* 인증_ID */
	AUTH_PW VARCHAR2(200) NOT NULL, /* 인증_PW */
	SSL_YN VARCHAR2(2) NOT NULL, /* SSL_YN */
	TLS_YN VARCHAR2(2) NOT NULL /* TLS_YN */
);

COMMENT ON TABLE mc_mail_smtp IS '메일서버설정';

COMMENT ON COLUMN mc_mail_smtp.SEQ IS '시퀀스';

COMMENT ON COLUMN mc_mail_smtp.TITLE IS '호스트명';

COMMENT ON COLUMN mc_mail_smtp.HOST IS '호스트';

COMMENT ON COLUMN mc_mail_smtp.PORT IS '포트';

COMMENT ON COLUMN mc_mail_smtp.AUTH_ID IS '인증_ID';

COMMENT ON COLUMN mc_mail_smtp.AUTH_PW IS '인증_PW';

COMMENT ON COLUMN mc_mail_smtp.SSL_YN IS 'SSL_YN';

COMMENT ON COLUMN mc_mail_smtp.TLS_YN IS 'TLS_YN';

CREATE UNIQUE INDEX PK_mc_mail_smtp
	ON mc_mail_smtp (
		SEQ
	);

ALTER TABLE mc_mail_smtp
	ADD
		CONSTRAINT PK_mc_mail_smtp
		PRIMARY KEY (
			SEQ
		);

/* 게시판설정_목록 */
CREATE TABLE mc_board (
	BOARD_SEQ NUMBER(11) NOT NULL, /* 게시판_시퀀스 */
	BOARD_NM VARCHAR2(64) NOT NULL, /* 게시판명 */
	BOARD_TYPE VARCHAR2(2) NOT NULL, /* 게시판_타입 */
	COMMENT_YN CHAR(1) DEFAULT 'N' NOT NULL, /* 댓글여부 */
	COMMENT_TARGET CHAR(1) DEFAULT 'U' NOT NULL, /* 댓글지원대상 */
	FILE_YN CHAR(1) NOT NULL, /* 파일첨부여부 */
	LIMIT_FILE_SIZE NUMBER(11), /* 파일첨부_최대개수 */
	FILE_LIMIT CHAR(1) DEFAULT 'N' NOT NULL, /* 파일첨부_최대용량 */
	SEARCH_YN CHAR(1) NOT NULL, /* 검색노출여부 */
	USE_YN CHAR(1) NOT NULL, /* 사용여부 */
	CAT_YN CHAR(1), /* 카테고리사용여부 */
	REG_DT DATE, /* 등록일 */
	REG_ID VARCHAR2(30), /* 등록자_ID */
	REG_NM VARCHAR2(32) NOT NULL, /* 등록자 */
	MOD_DT DATE, /* 수정일 */
	MOD_ID VARCHAR2(30), /* 수정자_ID */
	MOD_NM VARCHAR2(32), /* 수정자 */
	DEL_DT DATE, /* 삭제일 */
	DEL_ID VARCHAR2(30), /* 삭제자_ID */
	DEL_NM VARCHAR2(32), /* 삭제자 */
	DEL_YN CHAR(1) DEFAULT 'N' NOT NULL, /* 삭제여부 */
	SITE_ID NUMBER(11) DEFAULT 1, /* 사이트_ID */
	INSERT_YN CHAR(1) DEFAULT 'Y', /* 사용자_글등록_사용여부 */
	PUBLIC_YN CHAR(1) DEFAULT 'Y' NOT NULL, /* 비밀글_사용여부 */
	THUMB_TYPE VARCHAR2(30) DEFAULT 'TILE', /* 리스트_형태 */
	AGREE_YN CHAR(1), /* 개인정보등록_사용여부 */
	EDITOR_YN CHAR(1), /* 에디터_사용여부 */
	ROWS_TEXT VARCHAR2(50) DEFAULT '10,20,30', /* 리스트페이지에_보여줄_갯수목록 */
	LIST_ROW VARCHAR2(3), /* 리스트페이지에_보여줄_갯수초기값 */
	CCLNURI_YN CHAR(1), /* 저작권보호_사용여부 */
	TAG_YN CHAR(1) /* 태그_사용여부 */
);

COMMENT ON TABLE mc_board IS '게시판설정_목록';

COMMENT ON COLUMN mc_board.BOARD_SEQ IS '게시판_시퀀스';

COMMENT ON COLUMN mc_board.BOARD_NM IS '게시판명';

COMMENT ON COLUMN mc_board.BOARD_TYPE IS '게시판_타입';

COMMENT ON COLUMN mc_board.COMMENT_YN IS '댓글여부';

COMMENT ON COLUMN mc_board.COMMENT_TARGET IS '댓글지원대상';

COMMENT ON COLUMN mc_board.FILE_YN IS '파일첨부여부';

COMMENT ON COLUMN mc_board.LIMIT_FILE_SIZE IS '파일첨부_최대개수';

COMMENT ON COLUMN mc_board.FILE_LIMIT IS '파일첨부_최대용량';

COMMENT ON COLUMN mc_board.SEARCH_YN IS '검색노출여부';

COMMENT ON COLUMN mc_board.USE_YN IS '사용여부';

COMMENT ON COLUMN mc_board.CAT_YN IS '카테고리사용여부';

COMMENT ON COLUMN mc_board.REG_DT IS '등록일';

COMMENT ON COLUMN mc_board.REG_ID IS '등록자_ID';

COMMENT ON COLUMN mc_board.REG_NM IS '등록자';

COMMENT ON COLUMN mc_board.MOD_DT IS '수정일';

COMMENT ON COLUMN mc_board.MOD_ID IS '수정자_ID';

COMMENT ON COLUMN mc_board.MOD_NM IS '수정자';

COMMENT ON COLUMN mc_board.DEL_DT IS '삭제일';

COMMENT ON COLUMN mc_board.DEL_ID IS '삭제자_ID';

COMMENT ON COLUMN mc_board.DEL_NM IS '삭제자';

COMMENT ON COLUMN mc_board.DEL_YN IS '삭제여부';

COMMENT ON COLUMN mc_board.SITE_ID IS '사이트_ID';

COMMENT ON COLUMN mc_board.INSERT_YN IS '사용자_글등록_사용여부';

COMMENT ON COLUMN mc_board.PUBLIC_YN IS '비밀글_사용여부';

COMMENT ON COLUMN mc_board.THUMB_TYPE IS '리스트_형태';

COMMENT ON COLUMN mc_board.AGREE_YN IS '개인정보등록_사용여부';

COMMENT ON COLUMN mc_board.EDITOR_YN IS '에디터_사용여부';

COMMENT ON COLUMN mc_board.ROWS_TEXT IS '리스트페이지에_보여줄_갯수목록';

COMMENT ON COLUMN mc_board.LIST_ROW IS '리스트페이지에_보여줄_갯수초기값';

COMMENT ON COLUMN mc_board.CCLNURI_YN IS '저작권보호_사용여부';

COMMENT ON COLUMN mc_board.TAG_YN IS '태그_사용여부';

CREATE UNIQUE INDEX PK_mc_board
	ON mc_board (
		BOARD_SEQ
	);

ALTER TABLE mc_board
	ADD
		CONSTRAINT PK_mc_board
		PRIMARY KEY (
			BOARD_SEQ
		);

/* 설문조사_결과 */
CREATE TABLE mc_poll_result (
	POLL_SEQ NUMBER(11) NOT NULL, /* 설문조사_시퀀스 */
	QUESTION_SEQ NUMBER(11) NOT NULL, /* 질문지_시퀀스 */
	ANSWER_SEQ NUMBER(11) NOT NULL, /* 답변_시퀀스 */
	ANSWER VARCHAR2(126) NOT NULL, /* 답변 */
	REG_DT DATE NOT NULL, /* 등록일 */
	REG_ID VARCHAR2(50) NOT NULL, /* 등록자_ID */
	REG_NM VARCHAR2(32) NOT NULL, /* 등록자 */
	REG_EMAIL VARCHAR2(126), /* 작성자_메일 */
	REG_TEL VARCHAR2(32), /* 작성자_전화번호 */
	REG_SEQ NUMBER(11) NOT NULL, /* 작성_시퀀스 */
	LOT_WIN CHAR(1) /* 개인정보수집동의여부 */
);

COMMENT ON TABLE mc_poll_result IS '설문조사_결과';

COMMENT ON COLUMN mc_poll_result.POLL_SEQ IS '설문조사_시퀀스';

COMMENT ON COLUMN mc_poll_result.QUESTION_SEQ IS '질문지_시퀀스';

COMMENT ON COLUMN mc_poll_result.ANSWER_SEQ IS '답변_시퀀스';

COMMENT ON COLUMN mc_poll_result.ANSWER IS '답변';

COMMENT ON COLUMN mc_poll_result.REG_DT IS '등록일';

COMMENT ON COLUMN mc_poll_result.REG_ID IS '등록자_ID';

COMMENT ON COLUMN mc_poll_result.REG_NM IS '등록자';

COMMENT ON COLUMN mc_poll_result.REG_EMAIL IS '작성자_메일';

COMMENT ON COLUMN mc_poll_result.REG_TEL IS '작성자_전화번호';

COMMENT ON COLUMN mc_poll_result.REG_SEQ IS '작성_시퀀스';

COMMENT ON COLUMN mc_poll_result.LOT_WIN IS '개인정보수집동의여부';

/* 관리자_허용아이피 */
CREATE TABLE mc_ip_allow (
	SEQ NUMBER(11) NOT NULL, /* 시퀀스 */
	IP VARCHAR2(100), /* 아이피 */
	TITLE VARCHAR2(200), /* 제목 */
	REG_ID VARCHAR2(30), /* 등록자_ID */
	REG_NM VARCHAR2(32), /* 등록자 */
	REG_DT DATE, /* 등록일 */
	MOD_ID VARCHAR2(30), /* 수정자_ID */
	MOD_NM VARCHAR2(32), /* 수정자 */
	MOD_DT DATE, /* 수정일 */
	DEL_ID VARCHAR2(30), /* 삭제자_ID */
	DEL_NM VARCHAR2(32), /* 삭제자 */
	DEL_DT DATE, /* 삭제일 */
	DEL_YN CHAR(1) DEFAULT 'N' NOT NULL /* 삭제여부 */
);

COMMENT ON TABLE mc_ip_allow IS '관리자_허용아이피';

COMMENT ON COLUMN mc_ip_allow.SEQ IS '시퀀스';

COMMENT ON COLUMN mc_ip_allow.IP IS '아이피';

COMMENT ON COLUMN mc_ip_allow.TITLE IS '제목';

COMMENT ON COLUMN mc_ip_allow.REG_ID IS '등록자_ID';

COMMENT ON COLUMN mc_ip_allow.REG_NM IS '등록자';

COMMENT ON COLUMN mc_ip_allow.REG_DT IS '등록일';

COMMENT ON COLUMN mc_ip_allow.MOD_ID IS '수정자_ID';

COMMENT ON COLUMN mc_ip_allow.MOD_NM IS '수정자';

COMMENT ON COLUMN mc_ip_allow.MOD_DT IS '수정일';

COMMENT ON COLUMN mc_ip_allow.DEL_ID IS '삭제자_ID';

COMMENT ON COLUMN mc_ip_allow.DEL_NM IS '삭제자';

COMMENT ON COLUMN mc_ip_allow.DEL_DT IS '삭제일';

COMMENT ON COLUMN mc_ip_allow.DEL_YN IS '삭제여부';

CREATE UNIQUE INDEX PK_mc_ip_allow
	ON mc_ip_allow (
		SEQ
	);

ALTER TABLE mc_ip_allow
	ADD
		CONSTRAINT PK_mc_ip_allow
		PRIMARY KEY (
			SEQ
		);

/* 게시판설정_커스텀 */
CREATE TABLE mc_board_custom (
	SEQ NUMBER(11) NOT NULL, /* 시퀀스 */
	BOARD_SEQ NUMBER(11) NOT NULL, /* 게시판_시퀀스 */
	ELEMENT VARCHAR2(500), /* 항목명 */
	COLUMN_NAME VARCHAR2(500), /* 컬럼형태 */
	USER_LIST_ELEMENT VARCHAR2(500), /* 사용자_리스트_설정 */
	USER_LIST_COL VARCHAR2(500), /* 사용자_리스트_사이즈 */
	USER_VIEW_ELEMENT VARCHAR2(500), /* 사용자_뷰_설정 */
	USER_INSERT_ELEMENT VARCHAR2(500), /* 사용자_쓰기_설정 */
	USER_MODIFY_ELEMENT VARCHAR2(500), /* 사용자_수정_설정 */
	ADMIN_LIST_ELEMENT VARCHAR2(500), /* 관리자_리스트_설정 */
	ADMIN_LIST_COL VARCHAR2(500), /* 관리자_리스트_사이즈 */
	ADMIN_INSERT_ELEMENT VARCHAR2(500), /* 관리자_쓰기_설정 */
	ADMIN_MODIFY_ELEMENT VARCHAR2(500), /* 관리자_수정_설정 */
	REG_DT DATE, /* 등록일 */
	REG_ID VARCHAR2(50), /* 등록자_ID */
	MOD_DT DATE, /* 수정일 */
	MOD_ID VARCHAR2(20), /* 수정자_ID */
	DEL_YN CHAR(1) DEFAULT 'N', /* 삭제여부 */
	ORDER_NUM NUMBER(11), /* 순서 */
	require_yn CHAR(1) /* 필수여부 */
);

COMMENT ON TABLE mc_board_custom IS '게시판설정_커스텀';

COMMENT ON COLUMN mc_board_custom.SEQ IS '시퀀스';

COMMENT ON COLUMN mc_board_custom.BOARD_SEQ IS '게시판_시퀀스';

COMMENT ON COLUMN mc_board_custom.ELEMENT IS '항목명';

COMMENT ON COLUMN mc_board_custom.COLUMN_NAME IS '컬럼형태';

COMMENT ON COLUMN mc_board_custom.USER_LIST_ELEMENT IS '사용자_리스트_설정';

COMMENT ON COLUMN mc_board_custom.USER_LIST_COL IS '사용자_리스트_사이즈';

COMMENT ON COLUMN mc_board_custom.USER_VIEW_ELEMENT IS '사용자_뷰_설정';

COMMENT ON COLUMN mc_board_custom.USER_INSERT_ELEMENT IS '사용자_쓰기_설정';

COMMENT ON COLUMN mc_board_custom.USER_MODIFY_ELEMENT IS '사용자_수정_설정';

COMMENT ON COLUMN mc_board_custom.ADMIN_LIST_ELEMENT IS '관리자_리스트_설정';

COMMENT ON COLUMN mc_board_custom.ADMIN_LIST_COL IS '관리자_리스트_사이즈';

COMMENT ON COLUMN mc_board_custom.ADMIN_INSERT_ELEMENT IS '관리자_쓰기_설정';

COMMENT ON COLUMN mc_board_custom.ADMIN_MODIFY_ELEMENT IS '관리자_수정_설정';

COMMENT ON COLUMN mc_board_custom.REG_DT IS '등록일';

COMMENT ON COLUMN mc_board_custom.REG_ID IS '등록자_ID';

COMMENT ON COLUMN mc_board_custom.MOD_DT IS '수정일';

COMMENT ON COLUMN mc_board_custom.MOD_ID IS '수정자_ID';

COMMENT ON COLUMN mc_board_custom.DEL_YN IS '삭제여부';

COMMENT ON COLUMN mc_board_custom.ORDER_NUM IS '순서';

COMMENT ON COLUMN mc_board_custom.require_yn IS '필수여부';

CREATE UNIQUE INDEX PK_mc_board_custom
	ON mc_board_custom (
		SEQ,
		BOARD_SEQ ASC
	);

ALTER TABLE mc_board_custom
	ADD
		CONSTRAINT PK_mc_board_custom
		PRIMARY KEY (
			SEQ,
			BOARD_SEQ
		);

/* 게시물_목록 */
CREATE TABLE mc_article (
	ARTICLE_SEQ NUMBER(11) NOT NULL, /* 게시물_시퀀스 */
	BOARD_SEQ NUMBER(11) NOT NULL, /* 게시판_시퀀스 */
	TITLE VARCHAR2(256) NOT NULL, /* 제목 */
	CONTS CLOB, /* 내용 */
	IP VARCHAR2(16) NOT NULL, /* 아이피 */
	VIEW_CNT NUMBER(11) DEFAULT 0 NOT NULL, /* 조회수 */
	PUBLIC_YN CHAR(1) DEFAULT 'Y' NOT NULL, /* 공개여부 */
	NOTICE_YN CHAR(1) DEFAULT 'N' NOT NULL, /* 공지여부 */
	CAT NUMBER(11), /* 카테고리_코드 */
	STATE NUMBER(11), /* 상태값 */
	THUMB VARCHAR2(100), /* 썸네일 */
	PASSWORD VARCHAR2(100), /* 패스워드 */
	REF_NUM NUMBER(11) NOT NULL, /* 참조_시퀀스 */
	STEP_NUM NUMBER(11) DEFAULT 0 NOT NULL, /* 참조_시퀀스2 */
	DEPTH_NUM NUMBER(11) DEFAULT 0 NOT NULL, /* 계층_단계 */
	SDATE DATE, /* 공지_시작일 */
	EDATE DATE, /* 공지_종료일 */
	REG_DT DATE, /* 등록일 */
	REG_ID VARCHAR2(30) NOT NULL, /* 등록자_ID */
	REG_NM VARCHAR2(32) NOT NULL, /* 등록자 */
	MOD_DT DATE, /* 수정일 */
	MOD_ID VARCHAR2(30), /* 수정자_ID */
	MOD_NM VARCHAR2(32), /* 수정자 */
	DEL_DT DATE, /* 삭제일 */
	DEL_ID VARCHAR2(30), /* 삭제자_ID */
	DEL_NM VARCHAR2(32), /* 삭제자 */
	DEL_YN CHAR(1) DEFAULT 'N' NOT NULL, /* 삭제여부 */
	REPLY_CONTS CLOB, /* 답글 */
	REPLY_ID VARCHAR2(30), /* 답글작성자_ID */
	REPLY_NM VARCHAR2(32), /* 답글작성자 */
	REPLY_DT DATE, /* 답글작성일 */
	TEL1 VARCHAR2(4), /* 전화번호1 */
	TEL2 VARCHAR2(4), /* 전화번호2 */
	TEL3 VARCHAR2(4), /* 전화번호3 */
	CELL1 VARCHAR2(4), /* 휴대폰번호1 */
	CELL2 VARCHAR2(4), /* 휴대폰번호2 */
	CELL3 VARCHAR2(4), /* 휴대폰번호3 */
	EMAIL1 VARCHAR2(128), /* 이메일1 */
	EMAIL2 VARCHAR2(128), /* 이메일2 */
	ETC01 VARCHAR2(400), /* 기타1 */
	ETC02 VARCHAR2(400), /* 기타2 */
	ETC03 VARCHAR2(400), /* 기타3 */
	ETC04 VARCHAR2(400), /* 기타4 */
	ETC05 VARCHAR2(400), /* 기타5 */
	ETC06 VARCHAR2(400), /* 기타6 */
	ETC07 VARCHAR2(400), /* 기타7 */
	ETC08 VARCHAR2(4000), /* 기타8 */
	ETC09 VARCHAR2(4000), /* 기타9 */
	ETC10 VARCHAR2(4000), /* 기타10 */
	CCL_TYPE CHAR(1), /* 저작권보호_CCL */
	NURI_TYPE CHAR(1), /* 저작권보호_공공누리 */
	TAG_NAMES VARCHAR2(200) /* 태그 */
);

COMMENT ON TABLE mc_article IS '게시물_목록';

COMMENT ON COLUMN mc_article.ARTICLE_SEQ IS '게시물_시퀀스';

COMMENT ON COLUMN mc_article.BOARD_SEQ IS '게시판_시퀀스';

COMMENT ON COLUMN mc_article.TITLE IS '제목';

COMMENT ON COLUMN mc_article.CONTS IS '내용';

COMMENT ON COLUMN mc_article.IP IS '아이피';

COMMENT ON COLUMN mc_article.VIEW_CNT IS '조회수';

COMMENT ON COLUMN mc_article.PUBLIC_YN IS '공개여부';

COMMENT ON COLUMN mc_article.NOTICE_YN IS '공지여부';

COMMENT ON COLUMN mc_article.CAT IS '카테고리_코드';

COMMENT ON COLUMN mc_article.STATE IS '상태값';

COMMENT ON COLUMN mc_article.THUMB IS '썸네일';

COMMENT ON COLUMN mc_article.PASSWORD IS '패스워드';

COMMENT ON COLUMN mc_article.REF_NUM IS '참조_시퀀스';

COMMENT ON COLUMN mc_article.STEP_NUM IS '참조_시퀀스2';

COMMENT ON COLUMN mc_article.DEPTH_NUM IS '계층_단계';

COMMENT ON COLUMN mc_article.SDATE IS '공지_시작일';

COMMENT ON COLUMN mc_article.EDATE IS '공지_종료일';

COMMENT ON COLUMN mc_article.REG_DT IS '등록일';

COMMENT ON COLUMN mc_article.REG_ID IS '등록자_ID';

COMMENT ON COLUMN mc_article.REG_NM IS '등록자';

COMMENT ON COLUMN mc_article.MOD_DT IS '수정일';

COMMENT ON COLUMN mc_article.MOD_ID IS '수정자_ID';

COMMENT ON COLUMN mc_article.MOD_NM IS '수정자';

COMMENT ON COLUMN mc_article.DEL_DT IS '삭제일';

COMMENT ON COLUMN mc_article.DEL_ID IS '삭제자_ID';

COMMENT ON COLUMN mc_article.DEL_NM IS '삭제자';

COMMENT ON COLUMN mc_article.DEL_YN IS '삭제여부';

COMMENT ON COLUMN mc_article.REPLY_CONTS IS '답글';

COMMENT ON COLUMN mc_article.REPLY_ID IS '답글작성자_ID';

COMMENT ON COLUMN mc_article.REPLY_NM IS '답글작성자';

COMMENT ON COLUMN mc_article.REPLY_DT IS '답글작성일';

COMMENT ON COLUMN mc_article.TEL1 IS '전화번호1';

COMMENT ON COLUMN mc_article.TEL2 IS '전화번호2';

COMMENT ON COLUMN mc_article.TEL3 IS '전화번호3';

COMMENT ON COLUMN mc_article.CELL1 IS '휴대폰번호1';

COMMENT ON COLUMN mc_article.CELL2 IS '휴대폰번호2';

COMMENT ON COLUMN mc_article.CELL3 IS '휴대폰번호3';

COMMENT ON COLUMN mc_article.EMAIL1 IS '이메일1';

COMMENT ON COLUMN mc_article.EMAIL2 IS '이메일2';

COMMENT ON COLUMN mc_article.ETC01 IS '기타1';

COMMENT ON COLUMN mc_article.ETC02 IS '기타2';

COMMENT ON COLUMN mc_article.ETC03 IS '기타3';

COMMENT ON COLUMN mc_article.ETC04 IS '기타4';

COMMENT ON COLUMN mc_article.ETC05 IS '기타5';

COMMENT ON COLUMN mc_article.ETC06 IS '기타6';

COMMENT ON COLUMN mc_article.ETC07 IS '기타7';

COMMENT ON COLUMN mc_article.ETC08 IS '기타8';

COMMENT ON COLUMN mc_article.ETC09 IS '기타9';

COMMENT ON COLUMN mc_article.ETC10 IS '기타10';

COMMENT ON COLUMN mc_article.CCL_TYPE IS '저작권보호_CCL';

COMMENT ON COLUMN mc_article.NURI_TYPE IS '저작권보호_공공누리';

COMMENT ON COLUMN mc_article.TAG_NAMES IS '태그';

CREATE UNIQUE INDEX PK_mc_article
	ON mc_article (
		ARTICLE_SEQ,
		BOARD_SEQ ASC
	);

CREATE INDEX IDX_MC_ARTICLE
	ON mc_article (
		REF_NUM,
		STEP_NUM,
		DEPTH_NUM,
		ARTICLE_SEQ
	);

CREATE INDEX IDX_MC_ARTICLE01
	ON mc_article (
		DEL_YN
	);

ALTER TABLE mc_article
	ADD
		CONSTRAINT PK_mc_article
		PRIMARY KEY (
			ARTICLE_SEQ,
			BOARD_SEQ
		);

/* 게시판설정_상태 */
CREATE TABLE mc_board_state (
	BOARD_STATE_SEQ NUMBER(11) NOT NULL, /* 시퀀스 */
	BOARD_SEQ NUMBER(11) NOT NULL, /* 게시판_시퀀스 */
	STATE_NM VARCHAR2(64) NOT NULL, /* 상태명 */
	REG_DT DATE, /* 등록일 */
	REG_ID VARCHAR2(30), /* 등록자_ID */
	REG_NM VARCHAR2(32) NOT NULL, /* 등록자 */
	MOD_DT DATE, /* 수정일 */
	MOD_ID VARCHAR2(30), /* 수정자_ID */
	MOD_NM VARCHAR2(32), /* 수정자 */
	DEL_DT DATE, /* 삭제일 */
	DEL_ID VARCHAR2(30), /* 삭제자_ID */
	DEL_NM VARCHAR2(32), /* 삭제자 */
	DEL_YN CHAR(1) DEFAULT 'N' NOT NULL /* 삭제여부 */
);

COMMENT ON TABLE mc_board_state IS '게시판설정_상태';

COMMENT ON COLUMN mc_board_state.BOARD_STATE_SEQ IS '시퀀스';

COMMENT ON COLUMN mc_board_state.BOARD_SEQ IS '게시판_시퀀스';

COMMENT ON COLUMN mc_board_state.STATE_NM IS '상태명';

COMMENT ON COLUMN mc_board_state.REG_DT IS '등록일';

COMMENT ON COLUMN mc_board_state.REG_ID IS '등록자_ID';

COMMENT ON COLUMN mc_board_state.REG_NM IS '등록자';

COMMENT ON COLUMN mc_board_state.MOD_DT IS '수정일';

COMMENT ON COLUMN mc_board_state.MOD_ID IS '수정자_ID';

COMMENT ON COLUMN mc_board_state.MOD_NM IS '수정자';

COMMENT ON COLUMN mc_board_state.DEL_DT IS '삭제일';

COMMENT ON COLUMN mc_board_state.DEL_ID IS '삭제자_ID';

COMMENT ON COLUMN mc_board_state.DEL_NM IS '삭제자';

COMMENT ON COLUMN mc_board_state.DEL_YN IS '삭제여부';

CREATE UNIQUE INDEX PK_mc_board_state
	ON mc_board_state (
		BOARD_STATE_SEQ,
		BOARD_SEQ ASC
	);

ALTER TABLE mc_board_state
	ADD
		CONSTRAINT PK_mc_board_state
		PRIMARY KEY (
			BOARD_STATE_SEQ,
			BOARD_SEQ
		);

/* 소스수정_이력 */
CREATE TABLE mc_source_history (
	seq NUMBER(11) NOT NULL, /* 시퀀스 */
	file_path VARCHAR2(200), /* 파일경로 */
	code_text CLOB, /* 코드내용 */
	reg_nm VARCHAR2(30), /* 작성자 */
	reg_id VARCHAR2(30), /* 작성자_ID */
	reg_dt DATE /* 작성일 */
);

COMMENT ON TABLE mc_source_history IS '소스수정_이력';

COMMENT ON COLUMN mc_source_history.seq IS '시퀀스';

COMMENT ON COLUMN mc_source_history.file_path IS '파일경로';

COMMENT ON COLUMN mc_source_history.code_text IS '코드내용';

COMMENT ON COLUMN mc_source_history.reg_nm IS '작성자';

COMMENT ON COLUMN mc_source_history.reg_id IS '작성자_ID';

COMMENT ON COLUMN mc_source_history.reg_dt IS '작성일';

CREATE UNIQUE INDEX PK_mc_source_history
	ON mc_source_history (
		seq
	);

ALTER TABLE mc_source_history
	ADD
		CONSTRAINT PK_mc_source_history
		PRIMARY KEY (
			seq
		);

/* 메뉴별_컨텐츠_백업 */
CREATE TABLE mc_cms_content_bakup (
	SEQ NUMBER(11) NOT NULL, /* 시퀀스 */
	CMS_MENU_SEQ NUMBER(11) NOT NULL, /* 메뉴_시퀀스 */
	CONTS CLOB, /* 내용 */
	CMOD_ID VARCHAR2(32), /* 수정자_ID */
	CMOD_NM VARCHAR2(32), /* 수정자 */
	CMOD_DT DATE /* 수정일 */
);

COMMENT ON TABLE mc_cms_content_bakup IS '메뉴별_컨텐츠_백업';

COMMENT ON COLUMN mc_cms_content_bakup.SEQ IS '시퀀스';

COMMENT ON COLUMN mc_cms_content_bakup.CMS_MENU_SEQ IS '메뉴_시퀀스';

COMMENT ON COLUMN mc_cms_content_bakup.CONTS IS '내용';

COMMENT ON COLUMN mc_cms_content_bakup.CMOD_ID IS '수정자_ID';

COMMENT ON COLUMN mc_cms_content_bakup.CMOD_NM IS '수정자';

COMMENT ON COLUMN mc_cms_content_bakup.CMOD_DT IS '수정일';

CREATE UNIQUE INDEX PK_mc_cms_content_bakup
	ON mc_cms_content_bakup (
		SEQ
	);

ALTER TABLE mc_cms_content_bakup
	ADD
		CONSTRAINT PK_mc_cms_content_bakup
		PRIMARY KEY (
			SEQ
		);

/* 공통코드목록 */
CREATE TABLE mc_common_code_group (
	CODE_GROUP_SEQ NUMBER(11) NOT NULL, /* 공통코드_시퀀스 */
	GROUP_NM VARCHAR2(64) NOT NULL, /* 공통코드명 */
	CONTS VARCHAR2(2000), /* 내용 */
	REG_ID VARCHAR2(20), /* 등록자_ID */
	REG_NM VARCHAR2(20), /* 등록자 */
	REG_IP VARCHAR2(15), /* 등록자_IP */
	REG_DT DATE, /* 등록일 */
	MOD_ID VARCHAR2(20), /* 수정자_ID */
	MOD_NM VARCHAR2(20), /* 수정자 */
	MOD_IP VARCHAR2(15), /* 수정자_IP */
	MOD_DT DATE, /* 수정일 */
	DEL_ID VARCHAR2(20), /* 삭제자_ID */
	DEL_NM VARCHAR2(20), /* 삭제자 */
	DEL_IP VARCHAR2(15), /* 삭제자_IP */
	DEL_DT DATE, /* 삭제일 */
	DEL_YN CHAR(1) DEFAULT 'N' /* 삭제여부 */
);

COMMENT ON TABLE mc_common_code_group IS '공통코드목록';

COMMENT ON COLUMN mc_common_code_group.CODE_GROUP_SEQ IS '공통코드_시퀀스';

COMMENT ON COLUMN mc_common_code_group.GROUP_NM IS '공통코드명';

COMMENT ON COLUMN mc_common_code_group.CONTS IS '내용';

COMMENT ON COLUMN mc_common_code_group.REG_ID IS '등록자_ID';

COMMENT ON COLUMN mc_common_code_group.REG_NM IS '등록자';

COMMENT ON COLUMN mc_common_code_group.REG_IP IS '등록자_IP';

COMMENT ON COLUMN mc_common_code_group.REG_DT IS '등록일';

COMMENT ON COLUMN mc_common_code_group.MOD_ID IS '수정자_ID';

COMMENT ON COLUMN mc_common_code_group.MOD_NM IS '수정자';

COMMENT ON COLUMN mc_common_code_group.MOD_IP IS '수정자_IP';

COMMENT ON COLUMN mc_common_code_group.MOD_DT IS '수정일';

COMMENT ON COLUMN mc_common_code_group.DEL_ID IS '삭제자_ID';

COMMENT ON COLUMN mc_common_code_group.DEL_NM IS '삭제자';

COMMENT ON COLUMN mc_common_code_group.DEL_IP IS '삭제자_IP';

COMMENT ON COLUMN mc_common_code_group.DEL_DT IS '삭제일';

COMMENT ON COLUMN mc_common_code_group.DEL_YN IS '삭제여부';

CREATE UNIQUE INDEX PK_mc_common_code_group
	ON mc_common_code_group (
		CODE_GROUP_SEQ
	);

ALTER TABLE mc_common_code_group
	ADD
		CONSTRAINT PK_mc_common_code_group
		PRIMARY KEY (
			CODE_GROUP_SEQ
		);

/* 메뉴정보_백업 */
CREATE TABLE mc_cms_menu_bakup (
	SEQ NUMBER(11) NOT NULL, /* 백업_시퀀스 */
	CMS_MENU_SEQ NUMBER(11) NOT NULL, /* 메뉴_시퀀스 */
	PARENT_MENU_SEQ NUMBER(11), /* 부모키 */
	TITLE VARCHAR2(255) NOT NULL, /* 메뉴명 */
	MENU_ORDER NUMBER(11) DEFAULT 1, /* 표시순서 */
	USE_YN CHAR(1) DEFAULT 'Y' NOT NULL, /* 사용여부 */
	BLANK_YN CHAR(1) DEFAULT 'N', /* 새창여부 */
	MENU_TYPE CHAR(1), /* 메뉴타입 */
	TARGET_URL VARCHAR2(128), /* 링크주소 */
	PROGRAM_NM VARCHAR2(255), /* 프로그램명 */
	BOARD_SEQ NUMBER(11), /* 게시판_번호 */
	SITE_ID NUMBER(11) DEFAULT 1, /* 사이트_ID */
	REG_NM VARCHAR2(32), /* 등록자 */
	REG_DT DATE, /* 등록일 */
	MOD_NM VARCHAR2(32), /* 수정자 */
	MOD_DT DATE, /* 수정일 */
	DEL_NM VARCHAR2(32), /* 삭제자 */
	DEL_DT DATE, /* 삭제일 */
	DEL_YN CHAR(1) DEFAULT 'N', /* 삭제여부 */
	CHILD_TYPE NUMBER(11), /* 자식타입 */
	HEAD_HTML CLOB, /* 하단표시내용 */
	TEMPLATE_TYPE NUMBER(11) DEFAULT 1, /* 템플릿_타입 */
	MENU_URL VARCHAR2(100), /* 메뉴_URL */
	CUD_GROUP_SEQ VARCHAR2(150), /* 수정_삭제_권한시퀀스 */
	R_GROUP_SEQ VARCHAR2(150), /* 읽기권한_시퀀스 */
	MANAGE_URL VARCHAR2(128), /* 관리페이지_주소 */
	TOP_YN CHAR(1) DEFAULT 'Y', /* 상단메뉴_노출여부 */
	REG_ID VARCHAR2(30), /* 등록자_ID */
	MOD_ID VARCHAR2(30), /* 수정자_ID */
	DEL_ID VARCHAR2(30), /* 삭제자_ID */
	INNER_YN CHAR(1) DEFAULT 'N', /* 관리메뉴_탭에서_관리사용여부 */
	SUB_PATH VARCHAR2(20), /* 위성 사이트사용시 서브패스 */
	JSON_STAFFS CLOB, /* 메뉴관리자_목록 */
	JSON_STAFF_GROUP CLOB, /* 메뉴관리자그룹_목록 */
	JSON_LIBS CLOB, /* 추가JS파일_목록 */
	ADD_PARAM VARCHAR2(255) /* 추가파라미터 */
);

COMMENT ON TABLE mc_cms_menu_bakup IS '메뉴정보_백업';

COMMENT ON COLUMN mc_cms_menu_bakup.SEQ IS '백업_시퀀스';

COMMENT ON COLUMN mc_cms_menu_bakup.CMS_MENU_SEQ IS '메뉴_시퀀스';

COMMENT ON COLUMN mc_cms_menu_bakup.PARENT_MENU_SEQ IS '부모키';

COMMENT ON COLUMN mc_cms_menu_bakup.TITLE IS '메뉴명';

COMMENT ON COLUMN mc_cms_menu_bakup.MENU_ORDER IS '표시순서';

COMMENT ON COLUMN mc_cms_menu_bakup.USE_YN IS '사용여부';

COMMENT ON COLUMN mc_cms_menu_bakup.BLANK_YN IS '새창여부';

COMMENT ON COLUMN mc_cms_menu_bakup.MENU_TYPE IS '메뉴타입';

COMMENT ON COLUMN mc_cms_menu_bakup.TARGET_URL IS '링크주소';

COMMENT ON COLUMN mc_cms_menu_bakup.PROGRAM_NM IS '프로그램명';

COMMENT ON COLUMN mc_cms_menu_bakup.BOARD_SEQ IS '게시판_번호';

COMMENT ON COLUMN mc_cms_menu_bakup.SITE_ID IS '사이트_ID';

COMMENT ON COLUMN mc_cms_menu_bakup.REG_NM IS '등록자';

COMMENT ON COLUMN mc_cms_menu_bakup.REG_DT IS '등록일';

COMMENT ON COLUMN mc_cms_menu_bakup.MOD_NM IS '수정자';

COMMENT ON COLUMN mc_cms_menu_bakup.MOD_DT IS '수정일';

COMMENT ON COLUMN mc_cms_menu_bakup.DEL_NM IS '삭제자';

COMMENT ON COLUMN mc_cms_menu_bakup.DEL_DT IS '삭제일';

COMMENT ON COLUMN mc_cms_menu_bakup.DEL_YN IS '삭제여부';

COMMENT ON COLUMN mc_cms_menu_bakup.CHILD_TYPE IS '자식타입';

COMMENT ON COLUMN mc_cms_menu_bakup.HEAD_HTML IS '하단표시내용';

COMMENT ON COLUMN mc_cms_menu_bakup.TEMPLATE_TYPE IS '템플릿_타입';

COMMENT ON COLUMN mc_cms_menu_bakup.MENU_URL IS '메뉴_URL';

COMMENT ON COLUMN mc_cms_menu_bakup.CUD_GROUP_SEQ IS '수정_삭제_권한시퀀스';

COMMENT ON COLUMN mc_cms_menu_bakup.R_GROUP_SEQ IS '읽기권한_시퀀스';

COMMENT ON COLUMN mc_cms_menu_bakup.MANAGE_URL IS '관리페이지_주소';

COMMENT ON COLUMN mc_cms_menu_bakup.TOP_YN IS '상단메뉴_노출여부';

COMMENT ON COLUMN mc_cms_menu_bakup.REG_ID IS '등록자_ID';

COMMENT ON COLUMN mc_cms_menu_bakup.MOD_ID IS '수정자_ID';

COMMENT ON COLUMN mc_cms_menu_bakup.DEL_ID IS '삭제자_ID';

COMMENT ON COLUMN mc_cms_menu_bakup.INNER_YN IS '관리메뉴_탭에서_관리사용여부';

COMMENT ON COLUMN mc_cms_menu_bakup.SUB_PATH IS '위성 사이트사용시 서브패스';

COMMENT ON COLUMN mc_cms_menu_bakup.JSON_STAFFS IS '메뉴관리자_목록';

COMMENT ON COLUMN mc_cms_menu_bakup.JSON_STAFF_GROUP IS '메뉴관리자그룹_목록';

COMMENT ON COLUMN mc_cms_menu_bakup.JSON_LIBS IS '추가JS파일_목록';

COMMENT ON COLUMN mc_cms_menu_bakup.ADD_PARAM IS '추가파라미터';

CREATE UNIQUE INDEX PK_mc_cms_menu_bakup
	ON mc_cms_menu_bakup (
		SEQ
	);

ALTER TABLE mc_cms_menu_bakup
	ADD
		CONSTRAINT PK_mc_cms_menu_bakup
		PRIMARY KEY (
			SEQ
		);

/* 수신자_그룹상세 */
CREATE TABLE mc_mail_target_list (
	SEQ NUMBER(11) NOT NULL, /* 시퀀스 */
	P_SEQ NUMBER(11) NOT NULL, /* 수신자그룹_시퀀스 */
	USER_NAME VARCHAR2(50) NOT NULL, /* 수신자 */
	USER_EMAIL VARCHAR2(50) NOT NULL /* 수신자_이메일 */
);

COMMENT ON TABLE mc_mail_target_list IS '수신자_그룹상세';

COMMENT ON COLUMN mc_mail_target_list.SEQ IS '시퀀스';

COMMENT ON COLUMN mc_mail_target_list.P_SEQ IS '수신자그룹_시퀀스';

COMMENT ON COLUMN mc_mail_target_list.USER_NAME IS '수신자';

COMMENT ON COLUMN mc_mail_target_list.USER_EMAIL IS '수신자_이메일';

CREATE UNIQUE INDEX PK_mc_mail_target_list
	ON mc_mail_target_list (
		SEQ
	);

ALTER TABLE mc_mail_target_list
	ADD
		CONSTRAINT PK_mc_mail_target_list
		PRIMARY KEY (
			SEQ
		);

/* 게시판설정_커스텀_약관동의 */
CREATE TABLE mc_board_agree (
	BOARD_AGREE_SEQ NUMBER(11) NOT NULL, /* 시퀀스 */
	BOARD_SEQ NUMBER(11) NOT NULL, /* 게시판_시퀀스 */
	AGREE_TIT VARCHAR2(256), /* 약관명 */
	AGREE_CONT CLOB, /* 약관내용 */
	AGREE_CHECK CHAR(1), /* 약광동의 */
	AGREE_ORDER VARCHAR2(3), /* 약관순서 */
	REG_DT DATE, /* 등록일 */
	REG_ID VARCHAR2(30), /* 등록자_ID */
	REG_NM VARCHAR2(32) NOT NULL, /* 등록자 */
	MOD_DT DATE, /* 수정일 */
	MOD_ID VARCHAR2(30), /* 수정자_ID */
	MOD_NM VARCHAR2(32), /* 수정자 */
	DEL_DT DATE, /* 삭제일 */
	DEL_ID VARCHAR2(30), /* 삭제자_ID */
	DEL_NM VARCHAR2(32), /* 삭제자 */
	DEL_YN CHAR(1) DEFAULT 'N' NOT NULL /* 삭제여부 */
);

COMMENT ON TABLE mc_board_agree IS '게시판설정_커스텀_약관동의';

COMMENT ON COLUMN mc_board_agree.BOARD_AGREE_SEQ IS '시퀀스';

COMMENT ON COLUMN mc_board_agree.BOARD_SEQ IS '게시판_시퀀스';

COMMENT ON COLUMN mc_board_agree.AGREE_TIT IS '약관명';

COMMENT ON COLUMN mc_board_agree.AGREE_CONT IS '약관내용';

COMMENT ON COLUMN mc_board_agree.AGREE_CHECK IS '약광동의';

COMMENT ON COLUMN mc_board_agree.AGREE_ORDER IS '약관순서';

COMMENT ON COLUMN mc_board_agree.REG_DT IS '등록일';

COMMENT ON COLUMN mc_board_agree.REG_ID IS '등록자_ID';

COMMENT ON COLUMN mc_board_agree.REG_NM IS '등록자';

COMMENT ON COLUMN mc_board_agree.MOD_DT IS '수정일';

COMMENT ON COLUMN mc_board_agree.MOD_ID IS '수정자_ID';

COMMENT ON COLUMN mc_board_agree.MOD_NM IS '수정자';

COMMENT ON COLUMN mc_board_agree.DEL_DT IS '삭제일';

COMMENT ON COLUMN mc_board_agree.DEL_ID IS '삭제자_ID';

COMMENT ON COLUMN mc_board_agree.DEL_NM IS '삭제자';

COMMENT ON COLUMN mc_board_agree.DEL_YN IS '삭제여부';

CREATE UNIQUE INDEX PK_mc_board_agree
	ON mc_board_agree (
		BOARD_AGREE_SEQ
	);

ALTER TABLE mc_board_agree
	ADD
		CONSTRAINT PK_mc_board_agree
		PRIMARY KEY (
			BOARD_AGREE_SEQ
		);

/* 페이지_조회수통계 */
CREATE TABLE mc_analytics (
	YMD CHAR(8), /* 연월일 */
	TITLE VARCHAR2(100) NOT NULL, /* 메뉴명 */
	REQUEST_URI VARCHAR2(200), /* 페이지_URL */
	QUERY_STRING VARCHAR2(250), /* 페이지_파라미터 */
	BROWSER VARCHAR2(250), /* 브라우저 */
	REFERER VARCHAR2(250), /* 이전주소 */
	IP VARCHAR2(15), /* 아이피 */
	LOCALE VARCHAR2(10), /* 지역 */
	YYYY VARCHAR2(4), /* 연 */
	MM CHAR(2), /* 월 */
	DD CHAR(2), /* 일 */
	HH CHAR(2), /* 시 */
	MEMBER_ID VARCHAR2(30), /* 회원_ID */
	SESSION_ID VARCHAR2(40), /* 세션_ID */
	CNT NUMBER(11) DEFAULT 1, /* 페이지뷰수 */
	OS VARCHAR2(20), /* OS */
	SITE_ID NUMBER(11) /* 사이트_ID */
);

COMMENT ON TABLE mc_analytics IS '페이지_조회수통계';

COMMENT ON COLUMN mc_analytics.YMD IS '연월일';

COMMENT ON COLUMN mc_analytics.TITLE IS '메뉴명';

COMMENT ON COLUMN mc_analytics.REQUEST_URI IS '페이지_URL';

COMMENT ON COLUMN mc_analytics.QUERY_STRING IS '페이지_파라미터';

COMMENT ON COLUMN mc_analytics.BROWSER IS '브라우저';

COMMENT ON COLUMN mc_analytics.REFERER IS '이전주소';

COMMENT ON COLUMN mc_analytics.IP IS '아이피';

COMMENT ON COLUMN mc_analytics.LOCALE IS '지역';

COMMENT ON COLUMN mc_analytics.YYYY IS '연';

COMMENT ON COLUMN mc_analytics.MM IS '월';

COMMENT ON COLUMN mc_analytics.DD IS '일';

COMMENT ON COLUMN mc_analytics.HH IS '시';

COMMENT ON COLUMN mc_analytics.MEMBER_ID IS '회원_ID';

COMMENT ON COLUMN mc_analytics.SESSION_ID IS '세션_ID';

COMMENT ON COLUMN mc_analytics.CNT IS '페이지뷰수';

COMMENT ON COLUMN mc_analytics.OS IS 'OS';

COMMENT ON COLUMN mc_analytics.SITE_ID IS '사이트_ID';

CREATE INDEX IDX_MC_ANALYTICS
	ON mc_analytics (
		YMD
	);

/* 관리자회원_변경이력 */
CREATE TABLE mc_member_history (
	SEQ NUMBER(11) NOT NULL, /* 시퀀스 */
	MEMBER_ID VARCHAR2(30), /* 회원_ID */
	MEMBER_NM VARCHAR2(30), /* 회원명 */
	MOD_ID VARCHAR2(30), /* 수정자_ID */
	MOD_NM VARCHAR2(30), /* 수정자 */
	MOD_DT DATE, /* 수정일 */
	MOD_IP VARCHAR2(16), /* 수정자_IP */
	CONTS VARCHAR2(2000) /* 변경내용 */
);

COMMENT ON TABLE mc_member_history IS '관리자회원_변경이력';

COMMENT ON COLUMN mc_member_history.SEQ IS '시퀀스';

COMMENT ON COLUMN mc_member_history.MEMBER_ID IS '회원_ID';

COMMENT ON COLUMN mc_member_history.MEMBER_NM IS '회원명';

COMMENT ON COLUMN mc_member_history.MOD_ID IS '수정자_ID';

COMMENT ON COLUMN mc_member_history.MOD_NM IS '수정자';

COMMENT ON COLUMN mc_member_history.MOD_DT IS '수정일';

COMMENT ON COLUMN mc_member_history.MOD_IP IS '수정자_IP';

COMMENT ON COLUMN mc_member_history.CONTS IS '변경내용';

CREATE UNIQUE INDEX PK_mc_member_history
	ON mc_member_history (
		SEQ
	);

ALTER TABLE mc_member_history
	ADD
		CONSTRAINT PK_mc_member_history
		PRIMARY KEY (
			SEQ
		);

/* 메일양식 */
CREATE TABLE mc_mail_form (
	SEQ NUMBER(11) NOT NULL, /* 메일양식_시퀀스 */
	TITLE VARCHAR2(100) NOT NULL, /* 메일양식명 */
	CONTS CLOB /* 메일양식내용 */
);

COMMENT ON TABLE mc_mail_form IS '메일양식';

COMMENT ON COLUMN mc_mail_form.SEQ IS '메일양식_시퀀스';

COMMENT ON COLUMN mc_mail_form.TITLE IS '메일양식명';

COMMENT ON COLUMN mc_mail_form.CONTS IS '메일양식내용';

CREATE UNIQUE INDEX PK_mc_mail_form
	ON mc_mail_form (
		SEQ
	);

ALTER TABLE mc_mail_form
	ADD
		CONSTRAINT PK_mc_mail_form
		PRIMARY KEY (
			SEQ
		);

/* 개인정보_필터설정 */
CREATE TABLE mc_cms_menu_filter_def (
	SITE_ID NUMBER(11) DEFAULT 0 NOT NULL, /* 사이트_ID */
	JUMIN_YN CHAR(1) DEFAULT 'N', /* 주민번호_YN */
	BUSINO_YN CHAR(1) DEFAULT 'N', /* 사업자_YN */
	BUBINO_YN CHAR(1) DEFAULT 'N', /* 법인_YN */
	EMAIL_YN CHAR(1) DEFAULT 'N', /* 이메일_YN */
	TEL_YN CHAR(1) DEFAULT 'N', /* 전화번호_YN */
	CELL_YN CHAR(1) DEFAULT 'N', /* 휴대폰_YN */
	CARD_YN CHAR(1) DEFAULT 'N', /* 카드_YN */
	FORBIDDEN_WORD VARCHAR2(4000) /* 비속어 */
);

COMMENT ON TABLE mc_cms_menu_filter_def IS '개인정보_필터설정';

COMMENT ON COLUMN mc_cms_menu_filter_def.SITE_ID IS '사이트_ID';

COMMENT ON COLUMN mc_cms_menu_filter_def.JUMIN_YN IS '주민번호_YN';

COMMENT ON COLUMN mc_cms_menu_filter_def.BUSINO_YN IS '사업자_YN';

COMMENT ON COLUMN mc_cms_menu_filter_def.BUBINO_YN IS '법인_YN';

COMMENT ON COLUMN mc_cms_menu_filter_def.EMAIL_YN IS '이메일_YN';

COMMENT ON COLUMN mc_cms_menu_filter_def.TEL_YN IS '전화번호_YN';

COMMENT ON COLUMN mc_cms_menu_filter_def.CELL_YN IS '휴대폰_YN';

COMMENT ON COLUMN mc_cms_menu_filter_def.CARD_YN IS '카드_YN';

COMMENT ON COLUMN mc_cms_menu_filter_def.FORBIDDEN_WORD IS '비속어';

CREATE UNIQUE INDEX PK_mc_cms_menu_filter_def
	ON mc_cms_menu_filter_def (
		SITE_ID
	);

ALTER TABLE mc_cms_menu_filter_def
	ADD
		CONSTRAINT PK_mc_cms_menu_filter_def
		PRIMARY KEY (
			SITE_ID
		);

/* 프로그램목록 */
CREATE TABLE mc_programs (
	SEQ NUMBER(11) NOT NULL, /* 시퀀스 */
	PROGRAM_NM VARCHAR2(100), /* 프로그램명 */
	URL VARCHAR2(200), /* 프로그램_URL */
	MANAGE_URL VARCHAR2(200), /* 프로그램관리_URL */
	INNER_YN CHAR(1), /* 프로그램관리_사용여부 */
	REG_ID VARCHAR2(30), /* 등록자_ID */
	REG_NM VARCHAR2(32), /* 등록자 */
	REG_DT DATE, /* 등록일 */
	MOD_ID VARCHAR2(30), /* 수정자_ID */
	MOD_NM VARCHAR2(32), /* 수정자 */
	MOD_DT DATE, /* 수정일 */
	DEL_ID VARCHAR2(30), /* 삭제자_ID */
	DEL_NM VARCHAR2(32), /* 삭제자 */
	DEL_DT DATE, /* 삭제일 */
	DEL_YN CHAR(1) DEFAULT 'N' NOT NULL /* 삭제여부 */
);

COMMENT ON TABLE mc_programs IS '프로그램목록';

COMMENT ON COLUMN mc_programs.SEQ IS '시퀀스';

COMMENT ON COLUMN mc_programs.PROGRAM_NM IS '프로그램명';

COMMENT ON COLUMN mc_programs.URL IS '프로그램_URL';

COMMENT ON COLUMN mc_programs.MANAGE_URL IS '프로그램관리_URL';

COMMENT ON COLUMN mc_programs.INNER_YN IS '프로그램관리_사용여부';

COMMENT ON COLUMN mc_programs.REG_ID IS '등록자_ID';

COMMENT ON COLUMN mc_programs.REG_NM IS '등록자';

COMMENT ON COLUMN mc_programs.REG_DT IS '등록일';

COMMENT ON COLUMN mc_programs.MOD_ID IS '수정자_ID';

COMMENT ON COLUMN mc_programs.MOD_NM IS '수정자';

COMMENT ON COLUMN mc_programs.MOD_DT IS '수정일';

COMMENT ON COLUMN mc_programs.DEL_ID IS '삭제자_ID';

COMMENT ON COLUMN mc_programs.DEL_NM IS '삭제자';

COMMENT ON COLUMN mc_programs.DEL_DT IS '삭제일';

COMMENT ON COLUMN mc_programs.DEL_YN IS '삭제여부';

CREATE UNIQUE INDEX PK_mc_programs
	ON mc_programs (
		SEQ
	);

ALTER TABLE mc_programs
	ADD
		CONSTRAINT PK_mc_programs
		PRIMARY KEY (
			SEQ
		);

/* 레이아웃_설정 */
CREATE TABLE mc_layout_detail (
	PARENT_SEQ NUMBER(11), /* 레이아웃_시퀀스 */
	IDX NUMBER(11), /* 정렬순서 */
	COM_TYPE NUMBER(11), /* 타입 */
	TAB_TITLE VARCHAR2(100), /* 탭 제목 */
	CONTS CLOB, /* 내용 */
	BOARD_SEQ NUMBER(11), /* 게시판 번호 */
	BOARD_SEQS VARCHAR2(100), /* 게시판 번호(복합) */
	COUNT NUMBER(11), /* 건수 */
	LINK_URL VARCHAR2(100) /* 바로가기페이지 */
);

COMMENT ON TABLE mc_layout_detail IS '레이아웃_설정';

COMMENT ON COLUMN mc_layout_detail.PARENT_SEQ IS '부모키';

COMMENT ON COLUMN mc_layout_detail.IDX IS '정렬순서';

COMMENT ON COLUMN mc_layout_detail.COM_TYPE IS '타입';

COMMENT ON COLUMN mc_layout_detail.TAB_TITLE IS '탭 제목';

COMMENT ON COLUMN mc_layout_detail.CONTS IS '내용';

COMMENT ON COLUMN mc_layout_detail.BOARD_SEQ IS '게시판 번호';

COMMENT ON COLUMN mc_layout_detail.BOARD_SEQS IS '게시판 번호(복합)';

COMMENT ON COLUMN mc_layout_detail.COUNT IS '건수';

COMMENT ON COLUMN mc_layout_detail.LINK_URL IS '바로가기페이지';

/* 설문조사 */
CREATE TABLE mc_poll (
	POLL_SEQ NUMBER(11) NOT NULL, /* 설문조사_시퀀스 */
	TITLE VARCHAR2(500) NOT NULL, /* 제목 */
	CONTENT CLOB, /* 내용 */
	START_DT DATE NOT NULL, /* 시작일 */
	END_DT DATE NOT NULL, /* 종료일 */
	REG_ID VARCHAR2(50) NOT NULL, /* 등록자_ID */
	REG_NM VARCHAR2(32) NOT NULL, /* 등록자 */
	REG_DT DATE NOT NULL, /* 등록일 */
	MOD_ID VARCHAR2(50), /* 수정자_ID */
	MOD_NM VARCHAR2(32), /* 수정자 */
	MOD_DT DATE, /* 수정일 */
	DEL_ID VARCHAR2(50), /* 삭제자_ID */
	DEL_NM VARCHAR2(32), /* 삭제자 */
	DEL_DT DATE, /* 삭제일 */
	DEL_YN CHAR(1) NOT NULL, /* 삭제여부 */
	USE_YN CHAR(1) NOT NULL, /* 사용여부 */
	LOT_YN CHAR(1) NOT NULL, /* 개인정보_수집여부 */
	CMS_MENU_SEQ NUMBER(11) NOT NULL, /* 메뉴_시퀀스 */
	CUD_GROUP_SEQ VARCHAR2(150), /* 설문대상_시퀀스 */
	DUP_YN CHAR(1) DEFAULT 'N' /* 중복설문_가능여부 */
);

COMMENT ON TABLE mc_poll IS '설문조사';

COMMENT ON COLUMN mc_poll.POLL_SEQ IS '설문조사_시퀀스';

COMMENT ON COLUMN mc_poll.TITLE IS '제목';

COMMENT ON COLUMN mc_poll.CONTENT IS '내용';

COMMENT ON COLUMN mc_poll.START_DT IS '시작일';

COMMENT ON COLUMN mc_poll.END_DT IS '종료일';

COMMENT ON COLUMN mc_poll.REG_ID IS '등록자_ID';

COMMENT ON COLUMN mc_poll.REG_NM IS '등록자';

COMMENT ON COLUMN mc_poll.REG_DT IS '등록일';

COMMENT ON COLUMN mc_poll.MOD_ID IS '수정자_ID';

COMMENT ON COLUMN mc_poll.MOD_NM IS '수정자';

COMMENT ON COLUMN mc_poll.MOD_DT IS '수정일';

COMMENT ON COLUMN mc_poll.DEL_ID IS '삭제자_ID';

COMMENT ON COLUMN mc_poll.DEL_NM IS '삭제자';

COMMENT ON COLUMN mc_poll.DEL_DT IS '삭제일';

COMMENT ON COLUMN mc_poll.DEL_YN IS '삭제여부';

COMMENT ON COLUMN mc_poll.USE_YN IS '사용여부';

COMMENT ON COLUMN mc_poll.LOT_YN IS '개인정보_수집여부';

COMMENT ON COLUMN mc_poll.CMS_MENU_SEQ IS '메뉴_시퀀스';

COMMENT ON COLUMN mc_poll.CUD_GROUP_SEQ IS '설문대상_시퀀스';

COMMENT ON COLUMN mc_poll.DUP_YN IS '중복설문_가능여부';

CREATE UNIQUE INDEX PK_mc_poll
	ON mc_poll (
		POLL_SEQ
	);

ALTER TABLE mc_poll
	ADD
		CONSTRAINT PK_mc_poll
		PRIMARY KEY (
			POLL_SEQ
		);

/* 수신자_그룹 */
CREATE TABLE mc_mail_target (
	SEQ NUMBER(11) NOT NULL, /* 수신자그룹_시퀀스 */
	TITLE VARCHAR2(100) NOT NULL, /* 수신자그룹명 */
	TARGET_CNT NUMBER(11) /* 수신자수 */
);

COMMENT ON TABLE mc_mail_target IS '수신자_그룹';

COMMENT ON COLUMN mc_mail_target.SEQ IS '수신자그룹_시퀀스';

COMMENT ON COLUMN mc_mail_target.TITLE IS '수신자그룹명';

COMMENT ON COLUMN mc_mail_target.TARGET_CNT IS '수신자수';

CREATE UNIQUE INDEX PK_mc_mail_target
	ON mc_mail_target (
		SEQ
	);

ALTER TABLE mc_mail_target
	ADD
		CONSTRAINT PK_mc_mail_target
		PRIMARY KEY (
			SEQ
		);

/* 메뉴설정권한회원 */
CREATE TABLE mc_cms_permission (
	CMS_STAFF_SEQ NUMBER(11) NOT NULL, /* 시퀀스 */
	CMS_MENU_SEQ NUMBER(11) NOT NULL, /* 메뉴_시퀀스 */
	GROUP_SEQ NUMBER(11) NOT NULL, /* 그룹_시퀀스 */
	GROUP_NM VARCHAR2(32), /* 그룹명 */
	MEMBER_NM VARCHAR2(30), /* 회원명 */
	MEMBER_ID VARCHAR2(30), /* 회원_ID */
	REG_DT DATE, /* 등록일 */
	REG_ID VARCHAR2(30), /* 등록자_ID */
	REG_NM VARCHAR2(30), /* 등록자 */
	ORDER_SEQ NUMBER(11) DEFAULT 1 /* 순서 */
);

COMMENT ON TABLE mc_cms_permission IS '메뉴설정권한회원';

COMMENT ON COLUMN mc_cms_permission.CMS_STAFF_SEQ IS '시퀀스';

COMMENT ON COLUMN mc_cms_permission.CMS_MENU_SEQ IS '메뉴_시퀀스';

COMMENT ON COLUMN mc_cms_permission.GROUP_SEQ IS '그룹_시퀀스';

COMMENT ON COLUMN mc_cms_permission.GROUP_NM IS '그룹명';

COMMENT ON COLUMN mc_cms_permission.MEMBER_NM IS '회원명';

COMMENT ON COLUMN mc_cms_permission.MEMBER_ID IS '회원_ID';

COMMENT ON COLUMN mc_cms_permission.REG_DT IS '등록일';

COMMENT ON COLUMN mc_cms_permission.REG_ID IS '등록자_ID';

COMMENT ON COLUMN mc_cms_permission.REG_NM IS '등록자';

COMMENT ON COLUMN mc_cms_permission.ORDER_SEQ IS '순서';

CREATE UNIQUE INDEX PK_mc_cms_permission
	ON mc_cms_permission (
		CMS_STAFF_SEQ
	);

ALTER TABLE mc_cms_permission
	ADD
		CONSTRAINT PK_mc_cms_permission
		PRIMARY KEY (
			CMS_STAFF_SEQ
		);

/* 첨부파일 */
CREATE TABLE mc_attach (
	UUID VARCHAR2(50) NOT NULL, /* 고유번호 */
	ATTACH_NM VARCHAR2(256) NOT NULL, /* 파일명 */
	YYYY CHAR(4) NOT NULL, /* 연 */
	MM CHAR(2) DEFAULT '00' NOT NULL, /* 월 */
	ORDER_SEQ NUMBER(11), /* 순서 */
	TABLE_NM VARCHAR2(64), /* 구분값 */
	TABLE_SEQ NUMBER(11), /* 게시물_시퀀스 */
	REG_ID VARCHAR2(30) NOT NULL, /* 등록자_ID */
	REG_NM VARCHAR2(32) NOT NULL, /* 등록자 */
	REG_DT DATE, /* 등록일 */
	DEL_ID VARCHAR2(30), /* 삭제자_ID */
	DEL_NM VARCHAR2(32), /* 삭제자 */
	DEL_DT DATE, /* 삭제일 */
	DEL_YN CHAR(1) DEFAULT 'N' NOT NULL, /* 삭제여부 */
	VIEW_CNT NUMBER(11) DEFAULT 0 /* 조회수 */
);

COMMENT ON TABLE mc_attach IS '첨부파일';

COMMENT ON COLUMN mc_attach.UUID IS '고유번호';

COMMENT ON COLUMN mc_attach.ATTACH_NM IS '파일명';

COMMENT ON COLUMN mc_attach.YYYY IS '연';

COMMENT ON COLUMN mc_attach.MM IS '월';

COMMENT ON COLUMN mc_attach.ORDER_SEQ IS '순서';

COMMENT ON COLUMN mc_attach.TABLE_NM IS '구분값';

COMMENT ON COLUMN mc_attach.TABLE_SEQ IS '게시물_시퀀스';

COMMENT ON COLUMN mc_attach.REG_ID IS '등록자_ID';

COMMENT ON COLUMN mc_attach.REG_NM IS '등록자';

COMMENT ON COLUMN mc_attach.REG_DT IS '등록일';

COMMENT ON COLUMN mc_attach.DEL_ID IS '삭제자_ID';

COMMENT ON COLUMN mc_attach.DEL_NM IS '삭제자';

COMMENT ON COLUMN mc_attach.DEL_DT IS '삭제일';

COMMENT ON COLUMN mc_attach.DEL_YN IS '삭제여부';

COMMENT ON COLUMN mc_attach.VIEW_CNT IS '조회수';

CREATE UNIQUE INDEX PK_mc_attach
	ON mc_attach (
		UUID
	);

ALTER TABLE mc_attach
	ADD
		CONSTRAINT PK_mc_attach
		PRIMARY KEY (
			UUID
		);

/* 메뉴별_개인정보_결과 */
CREATE TABLE mc_personal_data (
	SEQ NUMBER(11) NOT NULL, /* 시퀀스 */
	CMS_MENU_SEQ NUMBER(11), /* 메뉴_시퀀스 */
	SITE_ID NUMBER(11) DEFAULT 1, /* 사이트_ID */
	SUB_SEQ NUMBER(11), /* 보조_시퀀스 */
	MENU_NM VARCHAR2(255) NOT NULL, /* 메뉴명 */
	TITLE VARCHAR2(200), /* 제목 */
	REG_DT DATE, /* 등록일 */
	JUMIN_CNT NUMBER(11) DEFAULT 0, /* 주민번호_건수 */
	JUMIN_CONTS CLOB, /* 주민번호_상세 */
	BUSINO_CNT NUMBER(11) DEFAULT 0, /* 사업자번호_건수 */
	BUSINO_CONTS CLOB, /* 사업자번호_상세 */
	BUBINO_CNT NUMBER(11) DEFAULT 0, /* 법인번호_건수 */
	BUBINO_CONTS CLOB, /* 법인번호_상세 */
	EMAIL_CNT NUMBER(11) DEFAULT 0, /* 이메일_건수 */
	EMAIL_CONTS CLOB, /* 이메일_상세 */
	CELL_CNT NUMBER(11) DEFAULT 0, /* 휴대폰_건수 */
	CELL_CONTS CLOB, /* 휴대폰_상세 */
	TEL_CNT NUMBER(11) DEFAULT 0, /* 전화번호_건수 */
	TEL_CONTS CLOB, /* 전화번호_상세 */
	CARD_CNT NUMBER(11) DEFAULT 0, /* 카드_건수 */
	CARD_CONTS CLOB /* 카드_상세 */
);

COMMENT ON TABLE mc_personal_data IS '메뉴별_개인정보_결과';

COMMENT ON COLUMN mc_personal_data.SEQ IS '시퀀스';

COMMENT ON COLUMN mc_personal_data.CMS_MENU_SEQ IS '메뉴_시퀀스';

COMMENT ON COLUMN mc_personal_data.SITE_ID IS '사이트_ID';

COMMENT ON COLUMN mc_personal_data.SUB_SEQ IS '보조_시퀀스';

COMMENT ON COLUMN mc_personal_data.MENU_NM IS '메뉴명';

COMMENT ON COLUMN mc_personal_data.TITLE IS '제목';

COMMENT ON COLUMN mc_personal_data.REG_DT IS '등록일';

COMMENT ON COLUMN mc_personal_data.JUMIN_CNT IS '주민번호_건수';

COMMENT ON COLUMN mc_personal_data.JUMIN_CONTS IS '주민번호_상세';

COMMENT ON COLUMN mc_personal_data.BUSINO_CNT IS '사업자번호_건수';

COMMENT ON COLUMN mc_personal_data.BUSINO_CONTS IS '사업자번호_상세';

COMMENT ON COLUMN mc_personal_data.BUBINO_CNT IS '법인번호_건수';

COMMENT ON COLUMN mc_personal_data.BUBINO_CONTS IS '법인번호_상세';

COMMENT ON COLUMN mc_personal_data.EMAIL_CNT IS '이메일_건수';

COMMENT ON COLUMN mc_personal_data.EMAIL_CONTS IS '이메일_상세';

COMMENT ON COLUMN mc_personal_data.CELL_CNT IS '휴대폰_건수';

COMMENT ON COLUMN mc_personal_data.CELL_CONTS IS '휴대폰_상세';

COMMENT ON COLUMN mc_personal_data.TEL_CNT IS '전화번호_건수';

COMMENT ON COLUMN mc_personal_data.TEL_CONTS IS '전화번호_상세';

COMMENT ON COLUMN mc_personal_data.CARD_CNT IS '카드_건수';

COMMENT ON COLUMN mc_personal_data.CARD_CONTS IS '카드_상세';

CREATE UNIQUE INDEX PK_mc_personal_data
	ON mc_personal_data (
		SEQ
	);

ALTER TABLE mc_personal_data
	ADD
		CONSTRAINT PK_mc_personal_data
		PRIMARY KEY (
			SEQ
		);

/* 게시판_타입 */
CREATE TABLE mc_board_list (
	SEQ NUMBER(11) NOT NULL, /* 시퀀스 */
	BOARD_TYPE VARCHAR2(2) NOT NULL, /* 게시판_타입 */
	NAME VARCHAR2(50) /* 게시판_타입명 */
);

COMMENT ON TABLE mc_board_list IS '게시판_타입';

COMMENT ON COLUMN mc_board_list.SEQ IS '시퀀스';

COMMENT ON COLUMN mc_board_list.BOARD_TYPE IS '게시판_타입';

COMMENT ON COLUMN mc_board_list.NAME IS '게시판_타입명';

CREATE UNIQUE INDEX PK_mc_board_list
	ON mc_board_list (
		SEQ ASC
	);

ALTER TABLE mc_board_list
	ADD
		CONSTRAINT PK_mc_board_list
		PRIMARY KEY (
			SEQ
		);

/* 휴일관리 */
CREATE TABLE mc_holiday (
	HOLIDAY_SEQ NUMBER(11) NOT NULL, /* 시퀀스 */
	HOLIDAY VARCHAR2(30), /* 휴일 */
	TITLE VARCHAR2(32), /* 제목 */
	LUNAR_CAL VARCHAR2(30), /* 음력 */
	SUN_CAL VARCHAR2(30), /* 양력 */
	REG_ID VARCHAR2(30), /* 등록자_ID */
	REG_NM VARCHAR2(32), /* 등록자 */
	REG_DT DATE, /* 등록일 */
	MOD_ID VARCHAR2(30), /* 수정자_ID */
	MOD_NM VARCHAR2(32), /* 수정자 */
	MOD_DT DATE, /* 수정일 */
	DEL_ID VARCHAR2(30), /* 삭제자_ID */
	DEL_NM VARCHAR2(32), /* 삭제자 */
	DEL_DT DATE, /* 삭제일 */
	DEL_YN CHAR(1) DEFAULT 'N' NOT NULL /* 삭제여부 */
);

COMMENT ON TABLE mc_holiday IS '휴일관리';

COMMENT ON COLUMN mc_holiday.HOLIDAY_SEQ IS '시퀀스';

COMMENT ON COLUMN mc_holiday.HOLIDAY IS '휴일';

COMMENT ON COLUMN mc_holiday.TITLE IS '제목';

COMMENT ON COLUMN mc_holiday.LUNAR_CAL IS '음력';

COMMENT ON COLUMN mc_holiday.SUN_CAL IS '양력';

COMMENT ON COLUMN mc_holiday.REG_ID IS '등록자_ID';

COMMENT ON COLUMN mc_holiday.REG_NM IS '등록자';

COMMENT ON COLUMN mc_holiday.REG_DT IS '등록일';

COMMENT ON COLUMN mc_holiday.MOD_ID IS '수정자_ID';

COMMENT ON COLUMN mc_holiday.MOD_NM IS '수정자';

COMMENT ON COLUMN mc_holiday.MOD_DT IS '수정일';

COMMENT ON COLUMN mc_holiday.DEL_ID IS '삭제자_ID';

COMMENT ON COLUMN mc_holiday.DEL_NM IS '삭제자';

COMMENT ON COLUMN mc_holiday.DEL_DT IS '삭제일';

COMMENT ON COLUMN mc_holiday.DEL_YN IS '삭제여부';

CREATE UNIQUE INDEX PK_mc_holiday
	ON mc_holiday (
		HOLIDAY_SEQ
	);

ALTER TABLE mc_holiday
	ADD
		CONSTRAINT PK_mc_holiday
		PRIMARY KEY (
			HOLIDAY_SEQ
		);

/* 메일발송목록 */
CREATE TABLE mc_mail (
	SEQ NUMBER(11) NOT NULL, /* 메일발송_시퀀스 */
	TITLE VARCHAR2(200) NOT NULL, /* 제목 */
	CONTS CLOB, /* 내용 */
	SENDER_NM VARCHAR2(200) NOT NULL, /* 보내는사람 */
	SENDER_MAIL VARCHAR2(200) NOT NULL, /* 보내는사람_이메일 */
	STATUS VARCHAR2(2) NOT NULL, /* 상태 */
	REG_ID VARCHAR2(50) NOT NULL, /* 등록자_ID */
	REG_NM VARCHAR2(32) NOT NULL, /* 등록자 */
	REG_DT DATE, /* 등록일 */
	MOD_ID VARCHAR2(50), /* 수정자_ID */
	MOD_NM VARCHAR2(32), /* 수정자 */
	MOD_DT DATE, /* 수정일 */
	TARGET_SEQ NUMBER(11), /* 수신자그룹_시퀀스 */
	FORM_SEQ NUMBER(11) /* 메일양식_시퀀스 */
);

COMMENT ON TABLE mc_mail IS '메일발송목록';

COMMENT ON COLUMN mc_mail.SEQ IS '메일발송_시퀀스';

COMMENT ON COLUMN mc_mail.TITLE IS '제목';

COMMENT ON COLUMN mc_mail.CONTS IS '내용';

COMMENT ON COLUMN mc_mail.SENDER_NM IS '보내는사람';

COMMENT ON COLUMN mc_mail.SENDER_MAIL IS '보내는사람_이메일';

COMMENT ON COLUMN mc_mail.STATUS IS '상태';

COMMENT ON COLUMN mc_mail.REG_ID IS '등록자_ID';

COMMENT ON COLUMN mc_mail.REG_NM IS '등록자';

COMMENT ON COLUMN mc_mail.REG_DT IS '등록일';

COMMENT ON COLUMN mc_mail.MOD_ID IS '수정자_ID';

COMMENT ON COLUMN mc_mail.MOD_NM IS '수정자';

COMMENT ON COLUMN mc_mail.MOD_DT IS '수정일';

COMMENT ON COLUMN mc_mail.TARGET_SEQ IS '수신자그룹_시퀀스';

COMMENT ON COLUMN mc_mail.FORM_SEQ IS '메일양식_시퀀스';

CREATE UNIQUE INDEX PK_mc_mail
	ON mc_mail (
		SEQ
	);

ALTER TABLE mc_mail
	ADD
		CONSTRAINT PK_mc_mail
		PRIMARY KEY (
			SEQ
		);

/* 예약등록 */
CREATE TABLE mc_reserve (
	RESERVE_SEQ NUMBER(11) NOT NULL, /* 시퀀스 */
	SITE_ID NUMBER(11), /* 사이트_ID */
	CMS_MENU_SEQ NUMBER(11), /* 메뉴_시퀀스 */
	BOARD_SEQ NUMBER(11), /* 게시판_시퀀스 */
	ARTICLE_SEQ NUMBER(11), /* 게시물_시퀀스 */
	PARAMS CLOB, /* 파라미터셋 */
	RESERVE_DT VARCHAR2(30), /* 예약배포일 */
	TYPE VARCHAR2(3), /* 배포타입 */
	REG_ID VARCHAR2(30), /* 등록자_ID */
	REG_NM VARCHAR2(32), /* 등록자 */
	REG_DT DATE, /* 등록일 */
	DEL_ID VARCHAR2(30), /* 삭제자_ID */
	DEL_NM VARCHAR2(32), /* 삭제자 */
	DEL_DT DATE, /* 삭제일 */
	DEL_YN VARCHAR2(1) DEFAULT 'N', /* 삭제여부 */
	TITLE VARCHAR2(100), /* 제목 */
	GUBUN VARCHAR2(1) DEFAULT 'M', /* 구분 */
	STATUS CHAR(1) DEFAULT 'I' /* 상태 */
);

COMMENT ON TABLE mc_reserve IS '예약등록';

COMMENT ON COLUMN mc_reserve.RESERVE_SEQ IS '시퀀스';

COMMENT ON COLUMN mc_reserve.SITE_ID IS '사이트_ID';

COMMENT ON COLUMN mc_reserve.CMS_MENU_SEQ IS '메뉴_시퀀스';

COMMENT ON COLUMN mc_reserve.BOARD_SEQ IS '게시판_시퀀스';

COMMENT ON COLUMN mc_reserve.ARTICLE_SEQ IS '게시물_시퀀스';

COMMENT ON COLUMN mc_reserve.PARAMS IS '파라미터셋';

COMMENT ON COLUMN mc_reserve.RESERVE_DT IS '예약배포일';

COMMENT ON COLUMN mc_reserve.TYPE IS '배포타입';

COMMENT ON COLUMN mc_reserve.REG_ID IS '등록자_ID';

COMMENT ON COLUMN mc_reserve.REG_NM IS '등록자';

COMMENT ON COLUMN mc_reserve.REG_DT IS '등록일';

COMMENT ON COLUMN mc_reserve.DEL_ID IS '삭제자_ID';

COMMENT ON COLUMN mc_reserve.DEL_NM IS '삭제자';

COMMENT ON COLUMN mc_reserve.DEL_DT IS '삭제일';

COMMENT ON COLUMN mc_reserve.DEL_YN IS '삭제여부';

COMMENT ON COLUMN mc_reserve.TITLE IS '제목';

COMMENT ON COLUMN mc_reserve.GUBUN IS 'M:매뉴,B:게시판';

COMMENT ON COLUMN mc_reserve.STATUS IS '상태';

CREATE UNIQUE INDEX PK_mc_reserve
	ON mc_reserve (
		RESERVE_SEQ
	);

ALTER TABLE mc_reserve
	ADD
		CONSTRAINT PK_mc_reserve
		PRIMARY KEY (
			RESERVE_SEQ
		);

/* JS_CSS_파일목록 */
CREATE TABLE mc_cms_menu_libs (
	SEQ NUMBER(11) NOT NULL, /* 시퀀스 */
	CMS_MENU_SEQ NUMBER(11), /* 메뉴_시퀀스 */
	TP CHAR(1), /* 파일타입 */
	EXTENSION VARCHAR2(3), /* 확장자명 */
	ORDER_SEQ NUMBER(11), /* 순서 */
	FULL_PATH VARCHAR2(200), /* 전체경로 */
	ORG_FILE_NAME VARCHAR2(50), /* 원본파일명 */
	SYS_FILE_NAME VARCHAR2(50) /* 시스템파일명 */
);

COMMENT ON TABLE mc_cms_menu_libs IS 'JS_CSS_파일목록';

COMMENT ON COLUMN mc_cms_menu_libs.SEQ IS '시퀀스';

COMMENT ON COLUMN mc_cms_menu_libs.CMS_MENU_SEQ IS '메뉴_시퀀스';

COMMENT ON COLUMN mc_cms_menu_libs.TP IS '파일타입';

COMMENT ON COLUMN mc_cms_menu_libs.EXTENSION IS '확장자명';

COMMENT ON COLUMN mc_cms_menu_libs.ORDER_SEQ IS '순서';

COMMENT ON COLUMN mc_cms_menu_libs.FULL_PATH IS '전체경로';

COMMENT ON COLUMN mc_cms_menu_libs.ORG_FILE_NAME IS '원본파일명';

COMMENT ON COLUMN mc_cms_menu_libs.SYS_FILE_NAME IS '시스템파일명';

CREATE UNIQUE INDEX PK_mc_cms_menu_libs
	ON mc_cms_menu_libs (
		SEQ
	);

ALTER TABLE mc_cms_menu_libs
	ADD
		CONSTRAINT PK_mc_cms_menu_libs
		PRIMARY KEY (
			SEQ
		);

/* 사이트_기본설정 */
CREATE TABLE mc_basic_setting (
	site_id NUMBER(11), /* 사이트아이디 */
	certification_yn CHAR(1), /* 회원가입 본인인증사용여부 */
	logout_time_yn CHAR(1), /* 로그아웃시간 사용여부 */
	logout_time NUMBER(11), /* 로그아웃시간 분 */
	pw_change_yn CHAR(1), /* 비밀번호변경주기 사용여부 */
	pw_change_cycle NUMBER(11), /* 비밀번호변경주기 개월 */
	dormancy_yn CHAR(1), /* 장기 미접속 사용여부 */
	dormancy_day NUMBER(11), /* 장기 미접속 설정개월 */
	adm_logout_time_yn CHAR(1), /* 관리자 로그아웃시간 사용여부 */
	adm_logout_time NUMBER(11), /* 관리자 로그아웃시간 분 */
	adm_pw_change_yn CHAR(1), /* 관리자 비밀번호변경주기 사용여부 */
	adm_pw_change_cycle NUMBER(11), /* 관리자 비밀번호변경주기 개월 */
	adm_dormancy_yn CHAR(1), /* 관리자 장기 미접속 사용여부 */
	adm_dormancy_day NUMBER(11) /* 관리자 장기 미접속 설정개월 */
);

COMMENT ON TABLE mc_basic_setting IS '사이트_기본설정';

COMMENT ON COLUMN mc_basic_setting.site_id IS '사이트아이디';

COMMENT ON COLUMN mc_basic_setting.certification_yn IS '회원가입 본인인증사용여부';

COMMENT ON COLUMN mc_basic_setting.logout_time_yn IS '로그아웃시간 사용여부';

COMMENT ON COLUMN mc_basic_setting.logout_time IS '로그아웃시간 분';

COMMENT ON COLUMN mc_basic_setting.pw_change_yn IS '비밀번호변경주기 사용여부';

COMMENT ON COLUMN mc_basic_setting.pw_change_cycle IS '비밀번호변경주기 개월';

COMMENT ON COLUMN mc_basic_setting.dormancy_yn IS '장기 미접속 사용여부';

COMMENT ON COLUMN mc_basic_setting.dormancy_day IS '장기 미접속 설정개월';

COMMENT ON COLUMN mc_basic_setting.adm_logout_time_yn IS '관리자 로그아웃시간 사용여부';

COMMENT ON COLUMN mc_basic_setting.adm_logout_time IS '관리자 로그아웃시간 분';

COMMENT ON COLUMN mc_basic_setting.adm_pw_change_yn IS '관리자 비밀번호변경주기 사용여부';

COMMENT ON COLUMN mc_basic_setting.adm_pw_change_cycle IS '관리자 비밀번호변경주기 개월';

COMMENT ON COLUMN mc_basic_setting.adm_dormancy_yn IS '관리자 장기 미접속 사용여부';

COMMENT ON COLUMN mc_basic_setting.adm_dormancy_day IS '관리자 장기 미접속 설정개월';

/* 설문조사_응답보기 */
CREATE TABLE mc_poll_answer (
	POLL_SEQ NUMBER(11) NOT NULL, /* 설문조사_시퀀스 */
	QUESTION_SEQ NUMBER(11) NOT NULL, /* 질문_시퀀스 */
	ANSWER_SEQ NUMBER(11) NOT NULL, /* 답변_시퀀스 */
	ANSWER VARCHAR2(126) NOT NULL, /* 답변 */
	NULL_CHK CHAR(1), /* 널_체크 */
	JUMP_CHK CHAR(1), /* 건너띄기_체크 */
	DEL_YN CHAR(1) NOT NULL /* 삭제여부 */
);

COMMENT ON TABLE mc_poll_answer IS '설문조사_응답보기';

COMMENT ON COLUMN mc_poll_answer.POLL_SEQ IS '설문조사_시퀀스';

COMMENT ON COLUMN mc_poll_answer.QUESTION_SEQ IS '질문_시퀀스';

COMMENT ON COLUMN mc_poll_answer.ANSWER_SEQ IS '답변_시퀀스';

COMMENT ON COLUMN mc_poll_answer.ANSWER IS '답변';

COMMENT ON COLUMN mc_poll_answer.NULL_CHK IS '널_체크';

COMMENT ON COLUMN mc_poll_answer.JUMP_CHK IS '건너띄기_체크';

COMMENT ON COLUMN mc_poll_answer.DEL_YN IS '삭제여부';

CREATE UNIQUE INDEX PK_mc_poll_answer
	ON mc_poll_answer (
		POLL_SEQ ASC,
		QUESTION_SEQ ASC,
		ANSWER_SEQ ASC
	);

ALTER TABLE mc_poll_answer
	ADD
		CONSTRAINT PK_mc_poll_answer
		PRIMARY KEY (
			POLL_SEQ,
			QUESTION_SEQ,
			ANSWER_SEQ
		);

/* 게시물_댓글 */
CREATE TABLE mc_comment_sns (
	COMMENT_SEQ NUMBER(11) NOT NULL, /* 고유번호 */
	CMS_MENU_SEQ NUMBER(11) NOT NULL, /* 메뉴번호 */
	ARTICLE_SEQ NUMBER(11) NOT NULL, /* 게시물번호 */
	PARENT_SEQ NUMBER(11), /* 부모키 */
	CONTS VARCHAR2(3000) NOT NULL, /* 내용 */
	IP VARCHAR2(16) NOT NULL, /* 아이피 */
	REG_DT DATE NOT NULL, /* 등록일 */
	REG_ID VARCHAR2(30), /* 등록자_ID */
	REG_NM VARCHAR2(32) NOT NULL, /* 등록자 */
	DEL_DT DATE, /* 삭제일 */
	DEL_ID VARCHAR2(30), /* 삭제자_ID */
	DEL_NM VARCHAR2(32), /* 삭제자 */
	DEL_YN CHAR(1) DEFAULT 'N' NOT NULL, /* 삭제여부 */
	TWT_YN CHAR(1) DEFAULT 'N', /* 트위터 보냄 */
	FACE_YN CHAR(1) DEFAULT 'N', /* 페이스북 보냄 */
	BLOG_YN CHAR(1) DEFAULT 'N', /* 블로그 보냄 */
	PROFILE_IMG VARCHAR2(300), /* 프로필 주소 */
	MAIN_ACCOUNT VARCHAR2(30), /* 로그인한 계정 */
	KAO_YN CHAR(1) DEFAULT 'N', /* 카카오 보냄 */
	SNS_LINK VARCHAR2(100) /* SNS링크 */
);

COMMENT ON TABLE mc_comment_sns IS '게시물_댓글';

COMMENT ON COLUMN mc_comment_sns.COMMENT_SEQ IS '고유번호';

COMMENT ON COLUMN mc_comment_sns.CMS_MENU_SEQ IS '메뉴번호';

COMMENT ON COLUMN mc_comment_sns.ARTICLE_SEQ IS '게시물번호';

COMMENT ON COLUMN mc_comment_sns.PARENT_SEQ IS '부모키';

COMMENT ON COLUMN mc_comment_sns.CONTS IS '내용';

COMMENT ON COLUMN mc_comment_sns.IP IS 'IP';

COMMENT ON COLUMN mc_comment_sns.REG_DT IS '등록일';

COMMENT ON COLUMN mc_comment_sns.REG_ID IS '등록자ID';

COMMENT ON COLUMN mc_comment_sns.REG_NM IS '등록자';

COMMENT ON COLUMN mc_comment_sns.DEL_DT IS '삭제일';

COMMENT ON COLUMN mc_comment_sns.DEL_ID IS '삭제자ID';

COMMENT ON COLUMN mc_comment_sns.DEL_NM IS '삭제자';

COMMENT ON COLUMN mc_comment_sns.DEL_YN IS '삭제여부';

COMMENT ON COLUMN mc_comment_sns.TWT_YN IS '트위터 보냄';

COMMENT ON COLUMN mc_comment_sns.FACE_YN IS '페이스북 보냄';

COMMENT ON COLUMN mc_comment_sns.BLOG_YN IS '블로그 보냄';

COMMENT ON COLUMN mc_comment_sns.PROFILE_IMG IS '프로필 주소';

COMMENT ON COLUMN mc_comment_sns.MAIN_ACCOUNT IS '로그인한 계정';

COMMENT ON COLUMN mc_comment_sns.KAO_YN IS '카카오 보냄';

COMMENT ON COLUMN mc_comment_sns.SNS_LINK IS 'SNS링크';

CREATE UNIQUE INDEX PK_mc_comment_sns
	ON mc_comment_sns (
		COMMENT_SEQ
	);

ALTER TABLE mc_comment_sns
	ADD
		CONSTRAINT PK_mc_comment_sns
		PRIMARY KEY (
			COMMENT_SEQ
		);

/* 메인_레이아웃설정 */
CREATE TABLE mc_layout (
	SEQ NUMBER(11) NOT NULL, /* 레이아웃_시퀀스 */
	SITE_ID NUMBER(11), /* 사이트_ID */
	IDX NUMBER(11), /* 정렬순서 */
	COL_CNT NUMBER(11), /* 가로사이즈 */
	ROW_CNT NUMBER(11), /* 세로사이즈 */
	TITLE VARCHAR2(100), /* 제목 */
	TAB_YN CHAR(1) DEFAULT 'N' /* 탭_사용여부 */
);

COMMENT ON TABLE mc_layout IS '메인_레이아웃설정';

COMMENT ON COLUMN mc_layout.SEQ IS '레이아웃_시퀀스';

COMMENT ON COLUMN mc_layout.SITE_ID IS '사이트_ID';

COMMENT ON COLUMN mc_layout.IDX IS '정렬순서';

COMMENT ON COLUMN mc_layout.COL_CNT IS '가로사이즈';

COMMENT ON COLUMN mc_layout.ROW_CNT IS '세로사이즈';

COMMENT ON COLUMN mc_layout.TITLE IS '제목';

COMMENT ON COLUMN mc_layout.TAB_YN IS '탭_사용여부';

CREATE UNIQUE INDEX PK_mc_layout
	ON mc_layout (
		SEQ
	);

ALTER TABLE mc_layout
	ADD
		CONSTRAINT PK_mc_layout
		PRIMARY KEY (
			SEQ
		);

/* 관리자그룹 */
CREATE TABLE mc_group (
	GROUP_SEQ NUMBER(11) NOT NULL, /* 그룹_시퀀스 */
	GROUP_NM VARCHAR2(32) NOT NULL, /* 그룹명 */
	PARENT_SEQ NUMBER(11), /* 부모그룹_시퀀스 */
	USE_YN CHAR(1) DEFAULT 'Y' NOT NULL, /* 사용여부 */
	REG_DT DATE NOT NULL, /* 등록일 */
	MOD_DT DATE, /* 수정일 */
	DEL_DT DATE, /* 삭제일 */
	DEL_YN CHAR(1) DEFAULT 'N' NOT NULL, /* 삭제여부 */
	ORDER_SEQ NUMBER(11) DEFAULT 1 NOT NULL, /* 순서 */
	REG_NM VARCHAR2(32), /* 등록자 */
	MOD_NM VARCHAR2(32), /* 수정자 */
	DEL_NM VARCHAR2(32), /* 삭제자 */
	MOD_ID VARCHAR2(30), /* 수정자_ID */
	DEL_ID VARCHAR2(30), /* 삭제자_ID */
	REG_ID VARCHAR2(30), /* 등록자_ID */
	TEL VARCHAR2(13), /* 전화번호 */
	FAX VARCHAR2(13), /* 팩스번호 */
	RESPONSIBILITIES VARCHAR2(500), /* 상세내용 */
	MANAGE_SEQ NUMBER(11) /* 관리_시퀀스 */
);

COMMENT ON TABLE mc_group IS '관리자그룹';

COMMENT ON COLUMN mc_group.GROUP_SEQ IS '그룹_시퀀스';

COMMENT ON COLUMN mc_group.GROUP_NM IS '그룹명';

COMMENT ON COLUMN mc_group.PARENT_SEQ IS '부모그룹_시퀀스';

COMMENT ON COLUMN mc_group.USE_YN IS '사용여부';

COMMENT ON COLUMN mc_group.REG_DT IS '등록일';

COMMENT ON COLUMN mc_group.MOD_DT IS '수정일';

COMMENT ON COLUMN mc_group.DEL_DT IS '삭제일';

COMMENT ON COLUMN mc_group.DEL_YN IS '삭제여부';

COMMENT ON COLUMN mc_group.ORDER_SEQ IS '순서';

COMMENT ON COLUMN mc_group.REG_NM IS '등록자';

COMMENT ON COLUMN mc_group.MOD_NM IS '수정자';

COMMENT ON COLUMN mc_group.DEL_NM IS '삭제자';

COMMENT ON COLUMN mc_group.MOD_ID IS '수정자_ID';

COMMENT ON COLUMN mc_group.DEL_ID IS '삭제자_ID';

COMMENT ON COLUMN mc_group.REG_ID IS '등록자_ID';

COMMENT ON COLUMN mc_group.TEL IS '전화번호';

COMMENT ON COLUMN mc_group.FAX IS '팩스번호';

COMMENT ON COLUMN mc_group.RESPONSIBILITIES IS '상세내용';

COMMENT ON COLUMN mc_group.MANAGE_SEQ IS '관리_시퀀스';

CREATE UNIQUE INDEX PK_mc_group
	ON mc_group (
		GROUP_SEQ
	);

CREATE INDEX IDX_GROUP_SORTORDER
	ON mc_group (
		PARENT_SEQ,
		ORDER_SEQ
	);

ALTER TABLE mc_group
	ADD
		CONSTRAINT PK_mc_group
		PRIMARY KEY (
			GROUP_SEQ
		);

/* 게시물_신고 */
CREATE TABLE mc_user_report (
	REPORT_SEQ NUMBER(11) NOT NULL, /* 시퀀스 */
	ARTICLE_SEQ NUMBER(11) NOT NULL, /* 게시물_시퀀스 */
	BOARD_SEQ NUMBER(11) NOT NULL, /* 게시판_시퀀스 */
	REPORTCONTS VARCHAR2(4000) NOT NULL, /* 내용 */
	IP VARCHAR2(16) NOT NULL, /* 아이피 */
	REG_DT DATE, /* 등록일 */
	REG_ID VARCHAR2(30), /* 등록자_ID */
	REG_NM VARCHAR2(32) /* 등록자 */
);

COMMENT ON TABLE mc_user_report IS '게시물_신고';

COMMENT ON COLUMN mc_user_report.REPORT_SEQ IS '시퀀스';

COMMENT ON COLUMN mc_user_report.ARTICLE_SEQ IS '게시물_시퀀스';

COMMENT ON COLUMN mc_user_report.BOARD_SEQ IS '게시판_시퀀스';

COMMENT ON COLUMN mc_user_report.REPORTCONTS IS '내용';

COMMENT ON COLUMN mc_user_report.IP IS '아이피';

COMMENT ON COLUMN mc_user_report.REG_DT IS '등록일';

COMMENT ON COLUMN mc_user_report.REG_ID IS '등록자_ID';

COMMENT ON COLUMN mc_user_report.REG_NM IS '등록자';

CREATE UNIQUE INDEX PK_mc_user_report
	ON mc_user_report (
		REPORT_SEQ
	);

ALTER TABLE mc_user_report
	ADD
		CONSTRAINT PK_mc_user_report
		PRIMARY KEY (
			REPORT_SEQ
		);

/* 사용자회원 */
CREATE TABLE mc_user_member (
	MEMBER_ID VARCHAR2(30) NOT NULL, /* 회원_ID */
	MEMBER_PW VARCHAR2(100), /* 회원_패스워드 */
	MEMBER_NM VARCHAR2(30), /* 회원명 */
	EMAIL VARCHAR2(100), /* 이메일 */
	TEL VARCHAR2(15), /* 전화번호 */
	CELL VARCHAR2(15), /* 휴대폰번호 */
	GROUP_SEQ NUMBER, /* 회원_그룹시퀀스 */
	LAST_LOGIN DATE, /* 마지막_로그인시간 */
	MOD_ID VARCHAR2(30), /* 수정자_ID */
	MOD_NM VARCHAR2(30), /* 수정자 */
	MOD_DT DATE, /* 수정일 */
	MOD_IP VARCHAR2(16), /* 수정자_IP */
	DEL_ID VARCHAR2(30), /* 삭제자_ID */
	DEL_NM VARCHAR2(30), /* 삭제자 */
	DEL_DT DATE, /* 삭제일 */
	USE_YN CHAR(1) DEFAULT 'Y', /* 사용여부 */
	DEL_YN CHAR(1) DEFAULT 'N', /* 삭제여부 */
	ORDER_SEQ NUMBER(11), /* 순서 */
	BLOCK_YN CHAR(1) DEFAULT 'N' NOT NULL, /* 블록여부 */
	LOGIN_FAIL_CNT NUMBER(11) DEFAULT 0 NOT NULL, /* 로그인_시도횟수 */
	LAST_PW_DT DATE, /* 마지막_패스워드변경일 */
	DI VARCHAR2(100), /* DI */
	BIRTH VARCHAR2(8), /* 생년월일 */
	EMAIL_YN CHAR(1) DEFAULT 'N', /* 이메일발송_허용 */
	SMS_YN CHAR(1) DEFAULT 'N', /* SMS발송_허용 */
	REG_DT DATE, /* 등록일 */
	DORMANCY_YN CHAR(1) DEFAULT 'N', /* 휴면계정_여부 */
	LEAVE_CONT VARCHAR2(1000) /* 탈퇴_사유 */
);

COMMENT ON TABLE mc_user_member IS '사용자회원';

COMMENT ON COLUMN mc_user_member.MEMBER_ID IS '회원_ID';

COMMENT ON COLUMN mc_user_member.MEMBER_PW IS '회원_패스워드';

COMMENT ON COLUMN mc_user_member.MEMBER_NM IS '회원명';

COMMENT ON COLUMN mc_user_member.EMAIL IS '이메일';

COMMENT ON COLUMN mc_user_member.TEL IS '전화번호';

COMMENT ON COLUMN mc_user_member.CELL IS '휴대폰번호';

COMMENT ON COLUMN mc_user_member.GROUP_SEQ IS '회원_그룹시퀀스';

COMMENT ON COLUMN mc_user_member.LAST_LOGIN IS '마지막_로그인시간';

COMMENT ON COLUMN mc_user_member.MOD_ID IS '수정자_ID';

COMMENT ON COLUMN mc_user_member.MOD_NM IS '수정자';

COMMENT ON COLUMN mc_user_member.MOD_DT IS '수정일';

COMMENT ON COLUMN mc_user_member.MOD_IP IS '수정자_IP';

COMMENT ON COLUMN mc_user_member.DEL_ID IS '삭제자_ID';

COMMENT ON COLUMN mc_user_member.DEL_NM IS '삭제자';

COMMENT ON COLUMN mc_user_member.DEL_DT IS '삭제일';

COMMENT ON COLUMN mc_user_member.USE_YN IS '사용여부';

COMMENT ON COLUMN mc_user_member.DEL_YN IS '삭제여부';

COMMENT ON COLUMN mc_user_member.ORDER_SEQ IS '순서';

COMMENT ON COLUMN mc_user_member.BLOCK_YN IS '블록여부';

COMMENT ON COLUMN mc_user_member.LOGIN_FAIL_CNT IS '로그인_시도횟수';

COMMENT ON COLUMN mc_user_member.LAST_PW_DT IS '마지막_패스워드변경일';

COMMENT ON COLUMN mc_user_member.DI IS 'DI';

COMMENT ON COLUMN mc_user_member.BIRTH IS '생년월일';

COMMENT ON COLUMN mc_user_member.EMAIL_YN IS '이메일발송_허용';

COMMENT ON COLUMN mc_user_member.SMS_YN IS 'SMS발송_허용';

COMMENT ON COLUMN mc_user_member.REG_DT IS '등록일';

COMMENT ON COLUMN mc_user_member.DORMANCY_YN IS '휴면계정_여부';

COMMENT ON COLUMN mc_user_member.LEAVE_CONT IS '탈퇴_사유';

CREATE UNIQUE INDEX PK_mc_user_member
	ON mc_user_member (
		MEMBER_ID
	);

ALTER TABLE mc_user_member
	ADD
		CONSTRAINT PK_mc_user_member
		PRIMARY KEY (
			MEMBER_ID
		);

/* 회원그룹 */
CREATE TABLE mc_user_group (
	GROUP_SEQ NUMBER(11) NOT NULL, /* 그룹_시퀀스 */
	GROUP_NM VARCHAR2(32) NOT NULL, /* 그룹명 */
	PARENT_SEQ NUMBER(11), /* 부모그룹_시퀀스 */
	USE_YN CHAR(1) DEFAULT 'Y' NOT NULL, /* 사용여부 */
	REG_DT DATE NOT NULL, /* 등록일 */
	MOD_DT DATE, /* 수정일 */
	DEL_DT DATE, /* 삭제일 */
	DEL_YN CHAR(1) DEFAULT 'N' NOT NULL, /* 삭제여부 */
	ORDER_SEQ NUMBER(11) DEFAULT 1 NOT NULL, /* 순서 */
	REG_NM VARCHAR2(32), /* 등록자 */
	MOD_NM VARCHAR2(32), /* 수정자 */
	DEL_NM VARCHAR2(32), /* 삭제자 */
	MOD_ID VARCHAR2(30), /* 수정자_ID */
	DEL_ID VARCHAR2(30), /* 삭제자_ID */
	REG_ID VARCHAR2(30), /* 등록자_ID */
	TEL VARCHAR2(13), /* 전화번호 */
	FAX VARCHAR2(13), /* 팩스번호 */
	RESPONSIBILITIES VARCHAR2(500), /* 상세내용 */
	MANAGE_SEQ NUMBER(11) /* 관리_시퀀스 */
);

COMMENT ON TABLE mc_user_group IS '회원그룹';

COMMENT ON COLUMN mc_user_group.GROUP_SEQ IS '그룹_시퀀스';

COMMENT ON COLUMN mc_user_group.GROUP_NM IS '그룹명';

COMMENT ON COLUMN mc_user_group.PARENT_SEQ IS '부모그룹_시퀀스';

COMMENT ON COLUMN mc_user_group.USE_YN IS '사용여부';

COMMENT ON COLUMN mc_user_group.REG_DT IS '등록일';

COMMENT ON COLUMN mc_user_group.MOD_DT IS '수정일';

COMMENT ON COLUMN mc_user_group.DEL_DT IS '삭제일';

COMMENT ON COLUMN mc_user_group.DEL_YN IS '삭제여부';

COMMENT ON COLUMN mc_user_group.ORDER_SEQ IS '순서';

COMMENT ON COLUMN mc_user_group.REG_NM IS '등록자';

COMMENT ON COLUMN mc_user_group.MOD_NM IS '수정자';

COMMENT ON COLUMN mc_user_group.DEL_NM IS '삭제자';

COMMENT ON COLUMN mc_user_group.MOD_ID IS '수정자_ID';

COMMENT ON COLUMN mc_user_group.DEL_ID IS '삭제자_ID';

COMMENT ON COLUMN mc_user_group.REG_ID IS '등록자_ID';

COMMENT ON COLUMN mc_user_group.TEL IS '전화번호';

COMMENT ON COLUMN mc_user_group.FAX IS '팩스번호';

COMMENT ON COLUMN mc_user_group.RESPONSIBILITIES IS '상세내용';

COMMENT ON COLUMN mc_user_group.MANAGE_SEQ IS '관리_시퀀스';

CREATE UNIQUE INDEX PK_mc_user_group
	ON mc_user_group (
		GROUP_SEQ
	);

CREATE INDEX IDX_GROUP_SORTORDER2
	ON mc_user_group (
		PARENT_SEQ,
		ORDER_SEQ
	);

ALTER TABLE mc_user_group
	ADD
		CONSTRAINT PK_mc_user_group
		PRIMARY KEY (
			GROUP_SEQ
		);

/* 메뉴_그룹별_사용자_접근권한 */
CREATE TABLE mc_cms_menu_grant (
	SEQ NUMBER(11) NOT NULL, /* 시퀀스 */
	CMS_MENU_SEQ NUMBER(11) NOT NULL, /* 메뉴_시퀀스 */
	GROUP_SEQ NUMBER(11) NOT NULL, /* 그룹_시퀀스 */
	GROUP_NM VARCHAR2(32), /* 그룹명 */
	REG_DT DATE, /* 등록일 */
	REG_ID VARCHAR2(30), /* 등록자_ID */
	REG_NM VARCHAR2(30), /* 등록자 */
	ORDER_SEQ NUMBER(11) DEFAULT 1 /* 순서 */
);

COMMENT ON TABLE mc_cms_menu_grant IS '메뉴_그룹별_사용자_접근권한';

COMMENT ON COLUMN mc_cms_menu_grant.SEQ IS '시퀀스';

COMMENT ON COLUMN mc_cms_menu_grant.CMS_MENU_SEQ IS '메뉴_시퀀스';

COMMENT ON COLUMN mc_cms_menu_grant.GROUP_SEQ IS '그룹_시퀀스';

COMMENT ON COLUMN mc_cms_menu_grant.GROUP_NM IS '그룹명';

COMMENT ON COLUMN mc_cms_menu_grant.REG_DT IS '등록일';

COMMENT ON COLUMN mc_cms_menu_grant.REG_ID IS '등록자_ID';

COMMENT ON COLUMN mc_cms_menu_grant.REG_NM IS '등록자';

COMMENT ON COLUMN mc_cms_menu_grant.ORDER_SEQ IS '순서';

CREATE UNIQUE INDEX PK_mc_cms_menu_grant
	ON mc_cms_menu_grant (
		SEQ
	);

ALTER TABLE mc_cms_menu_grant
	ADD
		CONSTRAINT PK_mc_cms_menu_grant
		PRIMARY KEY (
			SEQ
		);

/* 알림_읽음 */
CREATE TABLE MC_ALRAM_READ (
	TABLE_CD VARCHAR2(50) NOT NULL, /* 테이블코드 */
	ARTICLE_SEQ NUMBER NOT NULL, /* 시퀀스 */
	MEMBER_ID VARCHAR2(30) NOT NULL, /* 회원_ID */
	READ_DT DATE /* 읽은날짜 */
);

COMMENT ON TABLE MC_ALRAM_READ IS '알림_읽음';

COMMENT ON COLUMN MC_ALRAM_READ.TABLE_CD IS '테이블코드';

COMMENT ON COLUMN MC_ALRAM_READ.ARTICLE_SEQ IS '시퀀스';

COMMENT ON COLUMN MC_ALRAM_READ.MEMBER_ID IS '회원_ID';

COMMENT ON COLUMN MC_ALRAM_READ.READ_DT IS '읽은날짜';

CREATE UNIQUE INDEX PK_MC_ALRAM_READ
	ON MC_ALRAM_READ (
		TABLE_CD ASC,
		ARTICLE_SEQ ASC,
		MEMBER_ID ASC
	);

ALTER TABLE MC_ALRAM_READ
	ADD
		CONSTRAINT PK_MC_ALRAM_READ
		PRIMARY KEY (
			TABLE_CD,
			ARTICLE_SEQ,
			MEMBER_ID
		);

/* 사용자회원_변경이력 */
CREATE TABLE mc_user_member_history (
	SEQ NUMBER(11) NOT NULL, /* 시퀀스 */
	MEMBER_ID VARCHAR2(30), /* 회원_ID */
	MEMBER_NM VARCHAR2(30), /* 회원명 */
	MOD_ID VARCHAR2(30), /* 수정자_ID */
	MOD_NM VARCHAR2(30), /* 수정자 */
	MOD_DT DATE, /* 수정일 */
	MOD_IP VARCHAR2(16), /* 수정자_IP */
	CONTS VARCHAR2(2000) /* 변경내용 */
);

COMMENT ON TABLE mc_user_member_history IS '사용자회원_변경이력';

COMMENT ON COLUMN mc_user_member_history.SEQ IS '시퀀스';

COMMENT ON COLUMN mc_user_member_history.MEMBER_ID IS '회원_ID';

COMMENT ON COLUMN mc_user_member_history.MEMBER_NM IS '회원명';

COMMENT ON COLUMN mc_user_member_history.MOD_ID IS '수정자_ID';

COMMENT ON COLUMN mc_user_member_history.MOD_NM IS '수정자';

COMMENT ON COLUMN mc_user_member_history.MOD_DT IS '수정일';

COMMENT ON COLUMN mc_user_member_history.MOD_IP IS '수정자_IP';

COMMENT ON COLUMN mc_user_member_history.CONTS IS '변경내용';

CREATE UNIQUE INDEX PK_mc_user_member_history
	ON mc_user_member_history (
		SEQ
	);

ALTER TABLE mc_user_member_history
	ADD
		CONSTRAINT PK_mc_user_member_history
		PRIMARY KEY (
			SEQ
		);

/* 이력이남는_페이지 */
CREATE TABLE MC_PHISTORY (
	SEQ NUMBER NOT NULL, /* 시퀀스 */
	GUBUN NUMBER, /* 구분 */
	CONTS CLOB, /* 내용 */
	REG_DT DATE, /* 등록일 */
	REG_ID VARCHAR2(30), /* 등록자_ID */
	REG_NM VARCHAR2(32) NOT NULL, /* 등록자 */
	MOD_DT DATE, /* 수정일 */
	MOD_ID VARCHAR2(30), /* 수정자_ID */
	MOD_NM VARCHAR2(32) /* 수정자 */
);

COMMENT ON TABLE MC_PHISTORY IS '이력이남는_페이지';

COMMENT ON COLUMN MC_PHISTORY.SEQ IS '시퀀스';

COMMENT ON COLUMN MC_PHISTORY.GUBUN IS '구분';

COMMENT ON COLUMN MC_PHISTORY.CONTS IS '내용';

COMMENT ON COLUMN MC_PHISTORY.REG_DT IS '등록일';

COMMENT ON COLUMN MC_PHISTORY.REG_ID IS '등록자_ID';

COMMENT ON COLUMN MC_PHISTORY.REG_NM IS '등록자';

COMMENT ON COLUMN MC_PHISTORY.MOD_DT IS '수정일';

COMMENT ON COLUMN MC_PHISTORY.MOD_ID IS '수정자_ID';

COMMENT ON COLUMN MC_PHISTORY.MOD_NM IS '수정자';

CREATE UNIQUE INDEX PK_MC_PHISTORY
	ON MC_PHISTORY (
		SEQ ASC
	);

ALTER TABLE MC_PHISTORY
	ADD
		CONSTRAINT PK_MC_PHISTORY
		PRIMARY KEY (
			SEQ
		);

ALTER TABLE mc_cms_staff_group
	ADD
		CONSTRAINT FK_mc_mn_TO_mc_staff_group
		FOREIGN KEY (
			CMS_MENU_SEQ
		)
		REFERENCES mc_cms_menu (
			CMS_MENU_SEQ
		)
		ON DELETE CASCADE;

ALTER TABLE mc_satisfaction
	ADD
		CONSTRAINT FK_mc_cms_mn_TO_mc_stsfctn
		FOREIGN KEY (
			CMS_MENU_SEQ
		)
		REFERENCES mc_cms_menu (
			CMS_MENU_SEQ
		)
		ON DELETE CASCADE;

ALTER TABLE mc_common_code
	ADD
		CONSTRAINT FK_mc_cmn_grp_TO_mc_cmn_cd
		FOREIGN KEY (
			CODE_GROUP_SEQ
		)
		REFERENCES mc_common_code_group (
			CODE_GROUP_SEQ
		)
		ON DELETE CASCADE;

ALTER TABLE mc_cms_staff
	ADD
		CONSTRAINT FK_mc_cms_menu_TO_mc_cms_staff
		FOREIGN KEY (
			CMS_MENU_SEQ
		)
		REFERENCES mc_cms_menu (
			CMS_MENU_SEQ
		)
		ON DELETE CASCADE;

ALTER TABLE mc_poll_question
	ADD
		CONSTRAINT FK_mp_TO_mpq
		FOREIGN KEY (
			POLL_SEQ
		)
		REFERENCES mc_poll (
			POLL_SEQ
		)
		ON DELETE CASCADE;

ALTER TABLE mc_board_cat
	ADD
		CONSTRAINT FK_mc_board_TO_mc_board_cat
		FOREIGN KEY (
			BOARD_SEQ
		)
		REFERENCES mc_board (
			BOARD_SEQ
		)
		ON DELETE CASCADE;

ALTER TABLE mc_staff_location_tracking
	ADD
		CONSTRAINT FK_mc_trckng_TO_mc
		FOREIGN KEY (
			PARENT_SEQ
		)
		REFERENCES mc_staff_login_tracking (
			SEQ
		)
		ON DELETE CASCADE;

ALTER TABLE mc_mail_queue
	ADD
		CONSTRAINT FK_mc_mail_TO_mc_mail_queue
		FOREIGN KEY (
			P_SEQ
		)
		REFERENCES mc_mail (
			SEQ
		)
		ON DELETE CASCADE;

ALTER TABLE mc_poll_result
	ADD
		CONSTRAINT FK_mp_TO_mpr
		FOREIGN KEY (
			POLL_SEQ
		)
		REFERENCES mc_poll (
			POLL_SEQ
		)
		ON DELETE CASCADE;

ALTER TABLE mc_board_custom
	ADD
		CONSTRAINT FK_mc_board_TO_mc_board_custom
		FOREIGN KEY (
			BOARD_SEQ
		)
		REFERENCES mc_board (
			BOARD_SEQ
		)
		ON DELETE CASCADE;

ALTER TABLE mc_article
	ADD
		CONSTRAINT FK_mc_board_TO_mc_article
		FOREIGN KEY (
			BOARD_SEQ
		)
		REFERENCES mc_board (
			BOARD_SEQ
		)
		ON DELETE CASCADE;

ALTER TABLE mc_board_state
	ADD
		CONSTRAINT FK_mc_board_TO_mc_board_state
		FOREIGN KEY (
			BOARD_SEQ
		)
		REFERENCES mc_board (
			BOARD_SEQ
		)
		ON DELETE CASCADE;

ALTER TABLE mc_cms_content_bakup
	ADD
		CONSTRAINT FK_mc_mn_TO_mc_cntnt_bkp
		FOREIGN KEY (
			CMS_MENU_SEQ
		)
		REFERENCES mc_cms_menu (
			CMS_MENU_SEQ
		)
		ON DELETE CASCADE;

ALTER TABLE mc_cms_menu_bakup
	ADD
		CONSTRAINT FK_mc_cms_mn_TO_mc_mn_bkp
		FOREIGN KEY (
			CMS_MENU_SEQ
		)
		REFERENCES mc_cms_menu (
			CMS_MENU_SEQ
		)
		ON DELETE CASCADE;

ALTER TABLE mc_mail_target_list
	ADD
		CONSTRAINT FK_mc_trgt_TO_mc_trgt_lst
		FOREIGN KEY (
			P_SEQ
		)
		REFERENCES mc_mail_target (
			SEQ
		)
		ON DELETE CASCADE;

ALTER TABLE mc_board_agree
	ADD
		CONSTRAINT FK_mc_board_TO_mc_board_agree
		FOREIGN KEY (
			BOARD_SEQ
		)
		REFERENCES mc_board (
			BOARD_SEQ
		)
		ON DELETE CASCADE;

ALTER TABLE mc_layout_detail
	ADD
		CONSTRAINT FK_mc_layout_TO_mc_lt_dtl
		FOREIGN KEY (
			PARENT_SEQ
		)
		REFERENCES mc_layout (
			SEQ
		)
		ON DELETE CASCADE;

ALTER TABLE mc_cms_permission
	ADD
		CONSTRAINT FK_mc_cms_mn_TO_mc_prmsn
		FOREIGN KEY (
			CMS_MENU_SEQ
		)
		REFERENCES mc_cms_menu (
			CMS_MENU_SEQ
		)
		ON DELETE CASCADE;

ALTER TABLE mc_personal_data
	ADD
		CONSTRAINT FK_mc_cms_mn_TO_mc_prsnl_dt
		FOREIGN KEY (
			CMS_MENU_SEQ
		)
		REFERENCES mc_cms_menu (
			CMS_MENU_SEQ
		)
		ON DELETE CASCADE;

ALTER TABLE mc_cms_menu_libs
	ADD
		CONSTRAINT FK_mc_cms_mn_TO_mc_mn_lbs
		FOREIGN KEY (
			CMS_MENU_SEQ
		)
		REFERENCES mc_cms_menu (
			CMS_MENU_SEQ
		)
		ON DELETE CASCADE;

ALTER TABLE mc_poll_answer
	ADD
		CONSTRAINT FK_mp_TO_mpa
		FOREIGN KEY (
			POLL_SEQ
		)
		REFERENCES mc_poll (
			POLL_SEQ
		)
		ON DELETE CASCADE;

ALTER TABLE mc_user_report
	ADD
		CONSTRAINT FK_mc_artcl_TO_mc_usr_rprt
		FOREIGN KEY (
			ARTICLE_SEQ,
			BOARD_SEQ
		)
		REFERENCES mc_article (
			ARTICLE_SEQ,
			BOARD_SEQ
		)
		ON DELETE CASCADE;

ALTER TABLE mc_cms_menu_grant
	ADD
		CONSTRAINT FK_mc_mn_TO_mc_mn_grant
		FOREIGN KEY (
			CMS_MENU_SEQ
		)
		REFERENCES mc_cms_menu (
			CMS_MENU_SEQ
		)
		ON DELETE CASCADE;

CREATE SEQUENCE SEQ_MC_CMS_MENU
START WITH 8
MINVALUE 0
MAXVALUE 9223372036854775806;

CREATE SEQUENCE SEQ_MC_CMS_MENU_BAKUP NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_CMS_CONTENT_BAKUP NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_CMS_STAFF NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_CMS_PERMISSION NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_CMS_STAFF_GROUP NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_IP_ALLOW NOMINVALUE NOMAXVALUE;

CREATE SEQUENCE SEQ_MC_COMMON_CODE_GROUP
START WITH 5
MINVALUE 0
MAXVALUE 9223372036854775806;

CREATE SEQUENCE SEQ_MC_COMMON_CODE
START WITH 41
MINVALUE 0
MAXVALUE 9223372036854775806;

CREATE SEQUENCE SEQ_MC_GROUP
START WITH 3
MINVALUE 0
MAXVALUE 9223372036854775806;

CREATE SEQUENCE SEQ_MC_MEMBER_HISTORY NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_USER_MEMBER_HISTORY NOMINVALUE NOMAXVALUE;

CREATE SEQUENCE SEQ_MC_PROGRAMS
START WITH 100
MINVALUE 1
MAXVALUE 9223372036854775806;

CREATE SEQUENCE SEQ_MC_BOARD NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_BOARD_CAT NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_BOARD_STATE NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_USER_REPORT NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_ARTICLE NOMINVALUE NOMAXVALUE;

CREATE SEQUENCE SEQ_MC_BOARD_LIST 
START WITH 7 
MINVALUE 1 
MAXVALUE 9223372036854775806;

CREATE SEQUENCE SEQ_MC_BOARD_CUSTOM NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_BOARD_AGREE NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_ARTICLE_COMMENT NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_COMMENT_SNS NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_POPUPZONE NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_RESERVE NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_SATISFACTION NOMINVALUE NOMAXVALUE;

CREATE SEQUENCE SEQ_MC_HOLIDAY 
START WITH 518
MINVALUE 518
MAXVALUE 9223372036854775806;

CREATE SEQUENCE SEQ_MC_STAFF_LOGIN_TRACKING NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_STAFF_LOCATION_TRACKING NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_CMS_MENU_FILTER NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_PERSONAL_DATA NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_MAIL NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_MAIL_FORM NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_MAIL_QUEUE NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_MAIL_SMTP NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_MAIL_TARGET NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_MAIL_TARGET_LIST NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_CMS_MENU_LIBS NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_SOURCE_HISTORY NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_USER_GROUP START WITH 2 MINVALUE 2 NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_CMS_MENU_GRANT NOMINVALUE NOMAXVALUE;
CREATE SEQUENCE SEQ_MC_PHISTORY NOMINVALUE NOMAXVALUE;


CREATE OR REPLACE FUNCTION MANAGEMENT_SITE_TITLE(
    IN_STR         IN  VARCHAR2 
)
RETURN VARCHAR2
IS
    V_RETURN              VARCHAR2(4000);    
BEGIN
    V_RETURN := '';
    -- 문자열이 없으면 기본 리턴값 반환 후 종료
    IF NVL(IN_STR,'') = '' THEN
        RETURN V_RETURN;
    END IF;        
    
    
    SELECT
        SUBSTR(XMLAGG(XMLELEMENT (A,', ', T2.SITE_TITLE)).EXTRACT('//text()'),3) AS SITE_TITLE
        INTO V_RETURN
    FROM (
        SELECT 
            DISTINCT SUBSTR(T1.PAGE_NAVI,0,INSTR(T1.PAGE_NAVI,'>',1)-1) AS SITE_TITLE
        FROM (
            SELECT 
                A.CMS_MENU_SEQ, SUBSTR(SYS_CONNECT_BY_PATH(A.TITLE, '>'),2) as PAGE_NAVI
            FROM MC_CMS_MENU A
            START WITH A.PARENT_MENU_SEQ = nvl(0, '1') AND A.DEL_YN = 'N'
            CONNECT BY PRIOR A.CMS_MENU_SEQ = A.PARENT_MENU_SEQ
            ORDER SIBLINGS BY A.MENU_ORDER
        ) T1
        JOIN MC_CMS_STAFF B ON T1.CMS_MENU_SEQ = B.CMS_MENU_SEQ AND B.MEMBER_ID = IN_STR
    ) T2;
    
    --최종결과 리턴
    RETURN NVL(V_RETURN, '');        
    EXCEPTION
         WHEN OTHERS THEN
              RETURN SQLERRM;
END MANAGEMENT_SITE_TITLE;

CREATE OR REPLACE FUNCTION FN_GET_SPLIT(
    IN_STR         IN  VARCHAR2,    
    IN_LEVEL       IN  INT,         
    IN_DELIMETER   IN  VARCHAR2,
    IN_DEFAULT_VAL IN  VARCHAR2     
)
RETURN VARCHAR2
IS
    V_RETURN              VARCHAR2(4000);    
    STRVALUE              VARCHAR2(4000) := IN_STR; 
    DEFAULT_RETURN_VAL    VARCHAR2(4000) := IN_DEFAULT_VAL;
    IDX INT;    
    ILEVEL INT := 0;
BEGIN
    V_RETURN := '';
    -- 문자열이 없으면 기본 리턴값 반환 후 종료
    IF NVL(STRVALUE,'NO_STRING') = 'NO_STRING' THEN
        RETURN DEFAULT_RETURN_VAL;
    END IF;        
    LOOP
        --구분자 인덱스 확인
        IDX := INSTR(STRVALUE, IN_DELIMETER);
        
        IF IDX > 0 THEN --구분자로 문자를 찾은경우
                                    
            ILEVEL := ILEVEL + 1;
            
            -- 현재 레벨이 원하는 레벨이면 현재 문자열 반환 AND 레벨이 -1인경우는 마지막까지 LOOP
            IF ILEVEL = IN_LEVEL AND IN_LEVEL != -1 THEN
                V_RETURN := SUBSTR(STRVALUE, 1, IDX-1);
                EXIT;
            END IF;                        
            STRVALUE := SUBSTR(STRVALUE, IDX + LENGTH(IN_DELIMETER));
        ELSE  -- 구분자가 없을 경우, 문자열을 그대로 반환        
            IF ILEVEL = 0 THEN
                --구분자가 포함이 안되었지만 레벨이 1인경우 문자 그대로 반환
                IF IN_LEVEL = 1 THEN
                    V_RETURN := STRVALUE;
                ELSE
                    V_RETURN := '';
                END IF;
            ELSE
                -- 마지막 문자열일 경우
                ILEVEL := ILEVEL + 1;
                
                -- 마지막을 원하는 경우 마지막 문자열 반환 / -1은 레벨을 모를경우 구분자의 마지막 문자열 반환
                IF ILEVEL = IN_LEVEL OR IN_LEVEL = -1 THEN
                        V_RETURN := STRVALUE;
                ELSE
                    -- 원하는 레벨의 값이 없을 경우, 공백 반환
                    V_RETURN := '';        
                END IF;
            END IF;            
            EXIT; --반복 탈출문            
        END IF;
    END LOOP;        
    --최종결과 리턴
    RETURN NVL(V_RETURN, DEFAULT_RETURN_VAL);        
    EXCEPTION
         WHEN OTHERS THEN
              RETURN SQLERRM;
END FN_GET_SPLIT;

create or replace function fn_chosung_extract(i_str varchar2) return varchar2
deterministic
is
i int ;
v_chosung varchar2(3) ;
v_result varchar2(4000) ;
v_1char  varchar2(3) ;
 
begin
  FOR i IN 1..length(i_str) LOOP
   v_1char := substr(i_str,i,1) ;
   if v_1char < 'ㄱ' then v_chosung:=v_1char ;
   elsif v_1char in ( 'ㄱ','ㄲ','ㄴ','ㄷ','ㄸ','ㄹ','ㅁ','ㅂ','ㅃ','ㅅ'
   ,'ㅆ','ㅇ','ㅈ','ㅉ','ㅊ','ㅋ','ㅌ','ㅍ','ㅎ') then v_chosung:= v_1char ;
   elsif v_1char < '까' then v_chosung:= 'ㄱ' ;
   elsif v_1char < '나' then v_chosung:= 'ㄲ' ;
   elsif v_1char < '다' then v_chosung:= 'ㄴ' ;
   elsif v_1char < '따' then v_chosung:= 'ㄷ' ;
   elsif v_1char < '라' then v_chosung:= 'ㄸ' ;
   elsif v_1char < '마' then v_chosung:= 'ㄹ' ;
   elsif v_1char < '바' then v_chosung:= 'ㅁ' ;
   elsif v_1char < '빠' then v_chosung:= 'ㅂ' ;
   elsif v_1char < '사' then v_chosung:= 'ㅃ' ;
   elsif v_1char < '싸' then v_chosung:= 'ㅅ' ;
   elsif v_1char < '아' then v_chosung:= 'ㅆ' ;
   elsif v_1char < '자' then v_chosung:= 'ㅇ' ;
   elsif v_1char < '짜' then v_chosung:= 'ㅈ' ;
   elsif v_1char < '차' then v_chosung:= 'ㅉ' ;
   elsif v_1char < '카' then v_chosung:= 'ㅊ' ;
   elsif v_1char < '타' then v_chosung:= 'ㅋ' ;
   elsif v_1char < '파' then v_chosung:= 'ㅌ' ;
   elsif v_1char < '하' then v_chosung:= 'ㅍ' ;
   elsif v_1char <='힣' then v_chosung:= 'ㅎ' ;
   elsif v_1char <= '힝' then v_chosung:= 'ㅎ' ;
   else
    v_chosung:=v_1char ; 
    dbms_output.put_line(v_1char);
   end if;
   v_result := v_result || v_chosung ;
 
  end loop ;
  return v_result ;
end ;

CREATE OR REPLACE TRIGGER TR_MC_MEMBER
AFTER UPDATE ON MC_MEMBER
FOR EACH ROW
    DECLARE conts VARCHAR2(500) := '';
BEGIN   
    IF  NVL(:OLD.EMAIL, 'x') !=  NVL(:NEW.EMAIL, 'x') THEN
        conts := conts || '<p>이메일 : ' || :NEW.EMAIL || '</p>';
    END IF;    
    IF  NVL(:OLD.TEL, 'x') !=  NVL(:NEW.TEL, 'x') THEN
        conts := conts || '<p>전화번호 : ' || :NEW.TEL || '</p>';
    END IF;
    IF  NVL(:OLD.CELL, 'x') !=  NVL(:NEW.CELL, 'x') THEN
        conts := conts || '<p>휴대전화 : ' || :NEW.CELL || '</p>';
    END IF;
    IF  NVL(:OLD.MEMBER_PW, 'x') !=  NVL(:NEW.MEMBER_PW, 'x') THEN
        conts := conts || '<p>패스워드 변경</p>';
    END IF;
    IF  NVL(:OLD.GROUP_SEQ, -1) !=  NVL(:NEW.GROUP_SEQ, -1) THEN
        conts := conts || '<p>부서이동</p>';
    END IF;
     
    IF  length(conts) > 1 THEN   
    INSERT INTO MC_MEMBER_HISTORY(
        SEQ, MEMBER_ID, MEMBER_NM, CONTS, MOD_ID, MOD_NM, MOD_DT, MOD_IP
    ) VALUES(
        SEQ_MC_MEMBER_HISTORY.NEXTVAL, :NEW.MEMBER_ID, :NEW.MEMBER_NM, conts, :NEW.MOD_ID, :NEW.MOD_NM, :NEW.MOD_DT, :NEW.MOD_IP
    );
    END IF;
     
END TR_MC_MEMBER;

CREATE OR REPLACE TRIGGER TR_MC_USER_MEMBER
AFTER UPDATE ON MC_USER_MEMBER
FOR EACH ROW
    DECLARE conts VARCHAR2(500) := '';
BEGIN   
    IF  NVL(:OLD.EMAIL, 'x') !=  NVL(:NEW.EMAIL, 'x') THEN
        conts := conts || '<p>이메일 : ' || :NEW.EMAIL || '</p>';
    END IF;    
    IF  NVL(:OLD.TEL, 'x') !=  NVL(:NEW.TEL, 'x') THEN
        conts := conts || '<p>전화번호 : ' || :NEW.TEL || '</p>';
    END IF;
    IF  NVL(:OLD.CELL, 'x') !=  NVL(:NEW.CELL, 'x') THEN
        conts := conts || '<p>휴대전화 : ' || :NEW.CELL || '</p>';
    END IF;
    IF  NVL(:OLD.MEMBER_PW, 'x') !=  NVL(:NEW.MEMBER_PW, 'x') THEN
        conts := conts || '<p>패스워드 변경</p>';
    END IF;
    IF  NVL(:OLD.GROUP_SEQ, -1) !=  NVL(:NEW.GROUP_SEQ, -1) THEN
        conts := conts || '<p>부서이동</p>';
    END IF;
     
    IF  length(conts) > 1 THEN   
    INSERT INTO MC_USER_MEMBER_HISTORY(
        SEQ, MEMBER_ID, MEMBER_NM, CONTS, MOD_ID, MOD_NM, MOD_DT, MOD_IP
    ) VALUES(
        SEQ_MC_USER_MEMBER_HISTORY.NEXTVAL, :NEW.MEMBER_ID, :NEW.MEMBER_NM, conts, :NEW.MOD_ID, :NEW.MOD_NM, :NEW.MOD_DT, :NEW.MOD_IP
    );
    END IF;
     
END TR_MC_USER_MEMBER;