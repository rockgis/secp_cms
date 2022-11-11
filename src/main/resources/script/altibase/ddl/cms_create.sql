CREATE TABLE MC_BASIC_SETTING (
  SITE_ID 			NUMBER(11) DEFAULT NULL,
  HOMEPAGE_NAME 	VARCHAR2(100) DEFAULT NULL,
  CERTIFICATION_YN 	CHAR(1) DEFAULT NULL,
  LOGOUT_TIME_YN 	CHAR(1) DEFAULT NULL,
  LOGOUT_TIME 		NUMBER(32) DEFAULT NULL,
  PW_CHANGE_YN 		CHAR(1) DEFAULT NULL,
  PW_CHANGE_CYCLE 	NUMBER(32) DEFAULT NULL,
  DORMANCY_YN 		CHAR(1) DEFAULT NULL,
  DORMANCY_DAY 	NUMBER(32) DEFAULT NULL,
  ADM_LOGOUT_TIME_YN 	CHAR(1) DEFAULT NULL,
  ADM_LOGOUT_TIME 		NUMBER(32) DEFAULT NULL,
  ADM_PW_CHANGE_YN 		CHAR(1) DEFAULT NULL,
  ADM_PW_CHANGE_CYCLE 	NUMBER(32) DEFAULT NULL,
  ADM_DORMANCY_YN 		CHAR(1) DEFAULT NULL,
  ADM_DORMANCY_DAY 	NUMBER(32) DEFAULT NULL,
  CONDITIONS_YN 	CHAR(1) DEFAULT NULL,
  CONDITIONS_START_DT DATE DEFAULT NULL,
  CONDITIONS_END_DT DATE DEFAULT NULL,
  PRIVACY_YN 		CHAR(1) DEFAULT NULL,
  PRIVACY_START_DT 	DATE DEFAULT NULL,
  PRIVACY_END_DT 	DATE DEFAULT NULL,
  FOOTER_HTML 		CLOB,
  CONDITIONS_HTML 	CLOB,
  PRIVACY_HTML 		CLOB
);

CREATE TABLE MC_CMS_MENU
(
    CMS_MENU_SEQ    NUMBER(38) PRIMARY KEY,
    PARENT_MENU_SEQ NUMBER(38),
    TITLE           VARCHAR2(255) NOT NULL,
    TITLE_PATH_ON   VARCHAR2(255) NULL,
    TITLE_PATH_OFF  VARCHAR2(255) NULL,
    MENU_ORDER      NUMBER(38) DEFAULT 1,
    USE_YN          VARCHAR2(1) DEFAULT 'Y' NOT NULL,
    BLANK_YN        VARCHAR2(1) DEFAULT 'N',
    MENU_TYPE       VARCHAR2(1),
    TARGET_URL      VARCHAR2(128),
    PROGRAM_NM      VARCHAR2(255),
    BOARD_SEQ       NUMBER(38),
    CONTS           CLOB,
    TEMP_CONTS      CLOB,
    CCL_TYPE		VARCHAR2(1),
    NURI_TYPE		VARCHAR2(1),
    TAG_NAMES		VARCHAR2(200),
    SITE_ID         NUMBER(38) DEFAULT 1,
    REG_NM          VARCHAR2(32),
    REG_DT          DATE DEFAULT SYSDATE,
    MOD_NM          VARCHAR2(32),
    MOD_DT          DATE DEFAULT NULL,
    DEL_NM          VARCHAR2(32),
    DEL_DT          DATE DEFAULT NULL,
    DEL_YN          VARCHAR2(1) DEFAULT 'N',
    CHILD_TYPE      NUMBER(38),
    FOOT_HTML       CLOB,
    TEMPLATE_TYPE   NUMBER(38) DEFAULT 1,
    MENU_URL        VARCHAR2(100),
    ADD_PARAM       VARCHAR2(255),
    CUD_GROUP_SEQ   VARCHAR2(150),
    R_GROUP_SEQ     VARCHAR2(150),
    MANAGE_URL      VARCHAR2(128),
    INNER_YN		CHAR(1) DEFAULT 'N',
    TOP_YN          CHAR(1) DEFAULT 'Y',
    REG_ID          VARCHAR2(30),
    MOD_ID          VARCHAR2(30),
    DEL_ID          VARCHAR2(30),
    CMOD_ID			VARCHAR2(32),
    CMOD_NM			VARCHAR2(32),
    CMOD_DT         DATE,
    SUB_PATH        VARCHAR2(20)
);
CREATE INDEX IDX_CMS_MENU_SORTORDER
ON MC_CMS_MENU
(PARENT_MENU_SEQ,MENU_ORDER);

CREATE SEQUENCE SEQ_MC_CMS_MENU
START WITH 8
MINVALUE 0
MAXVALUE 9223372036854775806;

CREATE TABLE MC_CMS_MENU_BAKUP
(
    SEQ             NUMERIC(38) NOT NULL,
    CMS_MENU_SEQ    NUMBER(38) NOT NULL,
    PARENT_MENU_SEQ NUMBER(38),
    TITLE           VARCHAR2(255) NOT NULL,
    TITLE_PATH_ON   VARCHAR2(255) NULL,
    TITLE_PATH_OFF  VARCHAR2(255) NULL,
    MENU_ORDER      NUMBER(38) DEFAULT 1,
    USE_YN          VARCHAR2(1) DEFAULT 'Y' NOT NULL,
    BLANK_YN        VARCHAR2(1) DEFAULT 'N',
    MENU_TYPE       VARCHAR2(1),
    TARGET_URL      VARCHAR2(128),
    PROGRAM_NM      VARCHAR2(255),
    BOARD_SEQ       NUMBER(38),
    SITE_ID         NUMBER(38) DEFAULT 1,
    REG_NM          VARCHAR2(32),
    REG_DT          DATE DEFAULT SYSDATE,
    MOD_NM          VARCHAR2(32),
    MOD_DT          DATE DEFAULT NULL,
    DEL_NM          VARCHAR2(32),
    DEL_DT          DATE DEFAULT NULL,
    DEL_YN          VARCHAR2(1) DEFAULT 'N',
    CHILD_TYPE      NUMBER(38),
    FOOT_HTML       CLOB,
    TEMPLATE_TYPE   NUMBER(38) DEFAULT 1,
    MENU_URL        VARCHAR2(100),
    ADD_PARAM       VARCHAR2(255),
    CUD_GROUP_SEQ   VARCHAR2(150),
    R_GROUP_SEQ     VARCHAR2(150),
    MANAGE_URL      VARCHAR2(128),
    INNER_YN		CHAR(1) DEFAULT 'N',
    TOP_YN          CHAR(1) DEFAULT 'Y',
    JSON_STAFFS       	CLOB,
    JSON_STAFF_GROUP    CLOB,
    JSON_LIBS    	CLOB,
    REG_ID          VARCHAR2(30),
    MOD_ID          VARCHAR2(30),
    DEL_ID          VARCHAR2(30),
    CMOD_ID			VARCHAR2(32),
    CMOD_NM			VARCHAR2(32),
    CMOD_DT         DATE,
    SUB_PATH        VARCHAR2(20)
);

CREATE SEQUENCE SEQ_MC_CMS_MENU_BAKUP
START WITH 1
MINVALUE 0
MAXVALUE 9223372036854775806;

CREATE TABLE MC_CMS_CONTENT_BAKUP
(
    SEQ             NUMBER(38) ,
    CMS_MENU_SEQ    NUMBER(38) NOT NULL,
    CONTS           NVARCHAR,
    CMOD_ID         VARCHAR2(32),
    CMOD_NM         VARCHAR2(32),
    CMOD_DT         DATE ,
    PRIMARY KEY (SEQ)
);

CREATE SEQUENCE SEQ_MC_CMS_CONTENT_BAKUP
START WITH 1
MINVALUE 0
MAXVALUE 9223372036854775806;

CREATE TABLE MC_FAVORITES
(
  MEMBER_ID    VARCHAR2(50)                  NOT NULL,
  TITLE      VARCHAR2(200)                 NOT NULL,
  URL        VARCHAR2(200)                 NOT NULL,
  MENU_SEQ   NUMERIC(11),
  ORDER_SEQ  NUMERIC(11)
);

CREATE TABLE MC_CMS_MENU_TOGGLE
(
  MEMBER_ID  VARCHAR2(50 BYTE),
  TITLE      VARCHAR2(50 BYTE),
  INFO       VARCHAR2(2000 BYTE)
);

CREATE TABLE MC_CMS_STAFF
(
    CMS_STAFF_SEQ   NUMERIC(11) PRIMARY KEY,
    CMS_MENU_SEQ    NUMERIC(11) NOT NULL,
    GROUP_SEQ       NUMERIC(11) NOT NULL,
    GROUP_NM        VARCHAR2(32),
    DEPT            VARCHAR2(30),
    MEMBER_NM       VARCHAR2(30),
    MEMBER_ID       VARCHAR2(30),
    REG_DT          DATE,
    REG_ID          VARCHAR2(30),
    REG_NM          VARCHAR2(30),
    ORDER_SEQ       NUMERIC(11) DEFAULT '1'
);

CREATE SEQUENCE SEQ_MC_CMS_STAFF
START WITH 1
MINVALUE 1
MAXVALUE 9223372036854775806;

CREATE TABLE MC_CMS_PERMISSION
(
    CMS_STAFF_SEQ   NUMERIC(11) PRIMARY KEY,
    CMS_MENU_SEQ    NUMERIC(11) NOT NULL,
    GROUP_SEQ       NUMERIC(11) NOT NULL,
    GROUP_NM        VARCHAR2(32),
    MEMBER_NM       VARCHAR2(30),
    MEMBER_ID       VARCHAR2(30),
    REG_DT          DATE,
    REG_ID          VARCHAR2(30),
    REG_NM          VARCHAR2(30),
    ORDER_SEQ       NUMERIC(11) DEFAULT '1'
);

CREATE SEQUENCE SEQ_MC_CMS_PERMISSION
START WITH 1
MINVALUE 1
MAXVALUE 9223372036854775806;

CREATE TABLE MC_CMS_STAFF_GROUP
(
  SEQ  NUMBER(11) PRIMARY KEY,
  CMS_MENU_SEQ   NUMBER(11)                     NOT NULL,
  GROUP_SEQ      NUMBER(11)                     NOT NULL,
  GROUP_NM       VARCHAR2(32),
  REG_DT         DATE,
  REG_ID         VARCHAR2(30),
  REG_NM         VARCHAR2(30),
  ORDER_SEQ      NUMBER(11)                     DEFAULT '1'
);

CREATE SEQUENCE SEQ_MC_CMS_STAFF_GROUP
START WITH 1
MINVALUE 1
MAXVALUE 9223372036854775806;


CREATE TABLE MC_IP_ALLOW
(
    SEQ         NUMBER(38) PRIMARY KEY,
    IP          VARCHAR2(100),
    TITLE       VARCHAR2(200),
    REG_ID      VARCHAR2(30),
    REG_NM      VARCHAR2(32),
    REG_DT      DATE ,
    MOD_ID      VARCHAR2(30),
    MOD_NM      VARCHAR2(32),
    MOD_DT      DATE,
    DEL_ID      VARCHAR2(30),
    DEL_NM      VARCHAR2(32),
    DEL_DT      DATE,
    DEL_YN      CHAR(1) DEFAULT 'N' NOT NULL
);

CREATE SEQUENCE SEQ_MC_IP_ALLOW
START WITH 1
MINVALUE 0
MAXVALUE 9223372036854775806;


CREATE TABLE MC_COMMON_CODE_GROUP
(
    CODE_GROUP_SEQ  NUMBER(38) PRIMARY KEY,
    GROUP_NM        VARCHAR2(64) NOT NULL,
    CONTS       	VARCHAR2(2000),
    REG_ID          VARCHAR2(20),
    REG_NM          VARCHAR2(20),
    REG_IP          VARCHAR2(15),
    REG_DT          DATE DEFAULT SYSDATE,
    MOD_ID          VARCHAR2(20),
    MOD_NM          VARCHAR2(20),
    MOD_IP          VARCHAR2(15),
    MOD_DT          DATE DEFAULT NULL,
    DEL_ID          VARCHAR2(20),
    DEL_NM          VARCHAR2(20),
    DEL_IP          VARCHAR2(15),
    DEL_DT          DATE DEFAULT NULL,
    DEL_YN          VARCHAR2(1) DEFAULT 'N'
);

CREATE SEQUENCE SEQ_MC_COMMON_CODE_GROUP
START WITH 5
MINVALUE 0
MAXVALUE 9223372036854775806;

CREATE TABLE MC_COMMON_CODE
(
    CODE_SEQ        NUMBER(38) PRIMARY KEY,
    CODE_GROUP_SEQ  NUMBER(38) NOT NULL,
    CODE            VARCHAR2(32) NOT NULL,
    CODE_NM         VARCHAR2(64) NOT NULL,
    VAL1            VARCHAR2(200),
    VAL2            VARCHAR2(200),
    ETC             VARCHAR2(200),
    USE_YN          CHAR(1) NOT NULL,
    ORDER_SEQ       NUMBER(38) DEFAULT 1 NOT NULL,
    REG_ID          VARCHAR2(20),
    REG_NM          VARCHAR2(20),
    REG_IP          VARCHAR2(15),
    REG_DT          DATE DEFAULT SYSDATE,
    MOD_ID          VARCHAR2(20),
    MOD_NM          VARCHAR2(20),
    MOD_IP          VARCHAR2(15),
    MOD_DT          DATE DEFAULT NULL,
    DEL_ID          VARCHAR2(20),
    DEL_NM          VARCHAR2(20),
    DEL_IP          VARCHAR2(15),
    DEL_DT          DATE DEFAULT NULL,
    DEL_YN          VARCHAR2(1) DEFAULT 'N'
);

CREATE SEQUENCE SEQ_MC_COMMON_CODE
START WITH 41
MINVALUE 0
MAXVALUE 9223372036854775806;


CREATE TABLE MC_GROUP
(
    GROUP_SEQ   NUMBER(38) PRIMARY KEY,
    GROUP_NM    VARCHAR2(32) NOT NULL,
    PARENT_SEQ  NUMBER(38),
	TEL         VARCHAR2(13),
	FAX         VARCHAR2(13),
	RESPONSIBILITIES  VARCHAR2(500),
	MANAGE_SEQ	NUMBER(38),
    USE_YN      CHAR(1) DEFAULT 'Y' NOT NULL,
    REG_DT      DATE DEFAULT SYSDATE NOT NULL,
    MOD_DT      DATE,
    DEL_DT      DATE,
    DEL_YN      CHAR(1) DEFAULT 'N' NOT NULL,
    ORDER_SEQ   NUMBER(38) DEFAULT 1 NOT NULL,
    REG_NM      VARCHAR2(32) DEFAULT NULL,
    MOD_NM      VARCHAR2(32),
    DEL_NM      VARCHAR2(32),
    MOD_ID      VARCHAR2(30),
    DEL_ID      VARCHAR2(30),
    REG_ID      VARCHAR2(30)
);

CREATE INDEX IDX_GROUP_SORTORDER
ON MC_GROUP
(PARENT_SEQ,ORDER_SEQ);

CREATE SEQUENCE SEQ_MC_GROUP
START WITH 3
MINVALUE 0
MAXVALUE 9223372036854775806;

CREATE TABLE MC_MEMBER
(
    MEMBER_ID   VARCHAR2(30) PRIMARY KEY,
    MEMBER_PW   VARCHAR2(100),
    MEMBER_NM   VARCHAR2(30),
    EMAIL       VARCHAR2(100),
    TEL         VARCHAR2(15),
    CELL        VARCHAR2(15),
    GROUP_SEQ   VARCHAR2(4),
    LAST_LOGIN  DATE,
    RESPONSIBILITIES       VARCHAR2(500),
    POSITIONS       VARCHAR2(100),
    ORDER_SEQ   NUMERIC(11),
    REG_DT      DATE,
    MOD_ID      VARCHAR2(30),
    MOD_NM      VARCHAR2(30),
    MOD_DT      DATE,
    MOD_IP      VARCHAR2(16),
    DEL_ID      VARCHAR2(30),
    DEL_NM      VARCHAR2(30),
    DEL_DT      DATE,
    USE_YN      CHAR(1) DEFAULT 'Y',
    DEL_YN      CHAR(1) DEFAULT 'N',
    BLOCK_YN	CHAR(1) DEFAULT 'N',
    DORMANCY_YN	CHAR(1) DEFAULT 'N',
    LOGIN_FAIL_CNT	NUMBER DEFAULT 0 NOT NULL,
    LAST_PW_DT      DATE,
    DI			VARCHAR2(100),
    BIRTH		VARCHAR2(8),
    EMAIL_YN	CHAR(1) DEFAULT 'N',
    SMS_YN		CHAR(1) DEFAULT 'N'
);

CREATE TABLE MC_USER_MEMBER (
  MEMBER_ID VARCHAR2(30) PRIMARY KEY,
  MEMBER_PW VARCHAR2(100),
  MEMBER_NM VARCHAR2(30),
  EMAIL VARCHAR2(100),
  TEL VARCHAR2(15),
  CELL VARCHAR2(15),
  LAST_LOGIN DATE,
  MOD_ID VARCHAR2(30),
  MOD_NM VARCHAR2(30),
  MOD_DT DATE,
  MOD_IP VARCHAR2(16),
  DEL_ID VARCHAR2(30),
  DEL_NM VARCHAR2(30),
  DEL_DT DATE,
  LEAVE_CONT VARCHAR2(1000),
  USE_YN CHAR(1) DEFAULT 'Y',
  DEL_YN CHAR(1) DEFAULT 'N',
  ORDER_SEQ NUMERIC(11),
  BLOCK_YN CHAR(1) DEFAULT 'N',
  DORMANCY_YN CHAR(1) DEFAULT 'N',
  LOGIN_FAIL_CNT NUMERIC(11) NOT NULL DEFAULT 0,
  LAST_PW_DT DATE,
  DI VARCHAR2(100),
  BIRTH VARCHAR2(8),
  EMAIL_YN CHAR(1) DEFAULT 'N',
  SMS_YN CHAR(1) DEFAULT 'N',
  REG_DT DATE
);

CREATE TABLE MC_MEMBER_HISTORY
(
    SEQ   NUMBER(11),
    MEMBER_ID   VARCHAR2(30),
    MEMBER_NM   VARCHAR2(30),
    MOD_ID      VARCHAR2(30),
    MOD_NM      VARCHAR2(30),
    MOD_DT      DATE,
    MOD_IP      VARCHAR2(16),
    CONTS   	VARCHAR2(500),
    PRIMARY KEY (SEQ)
);

CREATE SEQUENCE SEQ_MC_MEMBER_HISTORY
START WITH 1
MINVALUE 0
MAXVALUE 9223372036854775806;

CREATE TABLE MC_PROGRAMS
(
    SEQ     NUMERIC(32),
    PROGRAM_NM      VARCHAR2(100),
    URL   VARCHAR2(200),
    MANAGE_URL   VARCHAR2(200),
    REG_ID  VARCHAR2(30),
    REG_NM  VARCHAR2(32),
    REG_DT  DATE,
    MOD_ID  VARCHAR2(30),
    MOD_NM  VARCHAR2(32),
    MOD_DT  DATE,
    DEL_ID  VARCHAR2(30),
    DEL_NM  VARCHAR2(32),
    DEL_DT  DATE,
    DEL_YN  CHAR(1) DEFAULT 'N' NOT NULL
);

CREATE SEQUENCE SEQ_MC_PROGRAMS
START WITH 100
MINVALUE 1
MAXVALUE 9223372036854775806;

CREATE TABLE MC_BOARD_LIST (
  SEQ 			NUMBER(11) NOT NULL,
  BOARD_TYPE 	VARCHAR2(2) NOT NULL,
  NAME 			VARCHAR2(50) NOT NULL,
  PRIMARY KEY (SEQ)  
);

CREATE SEQUENCE SEQ_MC_BOARD_LIST 
START WITH 7 
MINVALUE 1 
MAXVALUE 9223372036854775806;

CREATE TABLE MC_BOARD_COLUMN (
	ORDER_NUM		VARCHAR2(20), 
	COL_CODE		VARCHAR2(20), 
	COL_KOR			VARCHAR2(20), 
	COL_HELPER		VARCHAR2(4000),
	COL_EDIT		CHAR(1)
);

CREATE TABLE MC_BOARD_CUSTOM (
	SEQ 					NUMBER(11) NOT NULL, 
	BOARD_SEQ 				NUMBER(11) NOT NULL, 
	ELEMENT 				VARCHAR2(4000), 
	COLUMN_NAME 			VARCHAR2(4000), 
	USER_LIST_ELEMENT 		VARCHAR2(4000), 
	USER_LIST_COL 			VARCHAR2(4000), 
	USER_VIEW_ELEMENT 		VARCHAR2(4000), 
	USER_INSERT_ELEMENT 	VARCHAR2(4000), 
	USER_MODIFY_ELEMENT 	VARCHAR2(4000), 
	ADMIN_LIST_ELEMENT 		VARCHAR2(4000), 
	ADMIN_LIST_COL 			VARCHAR2(4000), 
	ADMIN_INSERT_ELEMENT 	VARCHAR2(4000), 
	ADMIN_MODIFY_ELEMENT 	VARCHAR2(4000), 
	REG_DT 					DATE DEFAULT SYSDATE, 
	REG_ID 					VARCHAR2(50), 
	MOD_DT 					DATE, 
	MOD_ID 					VARCHAR2(20), 
	DEL_YN 					CHAR(1) DEFAULT 'N', 
	ORDER_NUM 				NUMBER(11),
	REQUIRE_YN				CHAR(1) DEFAULT 'N',
	PRIMARY KEY(SEQ)
);

CREATE SEQUENCE SEQ_MC_BOARD_CUSTOM MINVALUE 1 MAXVALUE 9223372036854775806;

CREATE TABLE MC_BOARD_AGREE (
	BOARD_AGREE_SEQ			NUMBER(11) NOT NULL,  
	BOARD_SEQ 				NUMBER(11) NOT NULL, 
	AGREE_TIT				VARCHAR2(256),
	AGREE_CONT				CLOB,
	AGREE_CHECK				CHAR(1),
	AGREE_ORDER				VARCHAR2(3),
	REG_DT 					DATE, 
	REG_ID 					VARCHAR2(30), 
	REG_NM 					VARCHAR2(32),
	MOD_DT 					DATE, 
	MOD_ID 					VARCHAR2(30), 
	MOD_NM 					VARCHAR2(32),
	DEL_DT 					DATE, 
	DEL_ID 					VARCHAR2(30), 
	DEL_NM 					VARCHAR2(32),
	DEL_YN 					CHAR(1) DEFAULT 'N', 
	PRIMARY KEY(BOARD_AGREE_SEQ)
);

CREATE SEQUENCE SEQ_MC_BOARD_AGREE MINVALUE 1 MAXVALUE 9223372036854775806;


CREATE TABLE MC_BOARD (
	BOARD_SEQ 		NUMBER(11) NOT NULL, 
	BOARD_NM 		VARCHAR2(64) NOT NULL, 
	BOARD_TYPE 		VARCHAR2(2) NOT NULL,
	COMMENT_YN 		CHAR(1) DEFAULT 'N' NOT NULL,
	INSERT_YN 		CHAR(1) DEFAULT 'Y' NOT NULL,
	PUBLIC_YN		CHAR(1) DEFAULT 'Y' NOT NULL,
	FILE_YN 		CHAR(1) NOT NULL,
	LIMIT_FILE_SIZE NUMBER(11),
	FILE_LIMIT 		CHAR(1) DEFAULT 'N' NOT NULL, 
	SEARCH_YN 		CHAR(1) NOT NULL, 
	USE_YN 			CHAR(1) NOT NULL, 
	CAT_YN 			CHAR(1),
	
	FILTER_YN		CHAR(1),
	JUMIN_YN		CHAR(1),
	BUSINO_YN		CHAR(1),
	BUBINO_YN		CHAR(1),
	EMAIL_YN		CHAR(1),
	CELL_YN			CHAR(1),
	TEL_YN			CHAR(1),
	CARD_YN			CHAR(1),
	THUMB_TYPE		VARCHAR2(30) DEFAULT 'T',
	AGREE_YN		CHAR(1),
	EDITOR_YN		CHAR(1),
	CCLNURI_YN		CHAR(1),
	TAG_YN			CHAR(1),
	LIST_ROW		VARCHAR2(3),
	
	REG_DT 			DATE DEFAULT SYSDATE NOT NULL,
	REG_ID 			VARCHAR2(30), 
	REG_NM 			VARCHAR2(32) NOT NULL, 
	MOD_DT 			DATE,
	MOD_ID 			VARCHAR2(30), 
	MOD_NM 			VARCHAR2(32), 
	DEL_DT 			DATE,
	DEL_ID 			VARCHAR2(30), 
	DEL_NM 			VARCHAR2(32), 
	DEL_YN 			CHAR(1) DEFAULT 'N' NOT NULL, 
	SITE_ID 		NUMBER(2) DEFAULT 1, 	
	PRIMARY KEY (BOARD_SEQ)
);

CREATE SEQUENCE SEQ_MC_BOARD NOMINVALUE NOMAXVALUE;


CREATE TABLE MC_BOARD_CAT (
	BOARD_CAT_SEQ 	NUMBER(11) NOT NULL, 
	BOARD_SEQ 		NUMBER(11) NOT NULL, 
	CAT_NM 			VARCHAR2(64) NOT NULL, 
	REG_DT 			DATE DEFAULT SYSDATE NOT NULL, 
	REG_ID 			VARCHAR2(30), 
	REG_NM 			VARCHAR2(32) NOT NULL, 
	MOD_DT 			DATE, 
	MOD_ID 			VARCHAR2(30), 
	MOD_NM 			VARCHAR2(32), 
	DEL_DT 			DATE, 
	DEL_ID 			VARCHAR2(30), 
	DEL_NM 			VARCHAR2(32), 
	DEL_YN 			CHAR(1) DEFAULT 'N' NOT NULL,
	PRIMARY KEY (BOARD_CAT_SEQ)
);

CREATE SEQUENCE SEQ_MC_BOARD_CAT NOMINVALUE NOMAXVALUE;



CREATE TABLE MC_BOARD_STATE (
	BOARD_STATE_SEQ NUMBER(11) NOT NULL, 
	BOARD_SEQ 		NUMBER(11) NOT NULL, 
	STATE_NM 		VARCHAR2(64) NOT NULL, 
	REG_DT 			DATE DEFAULT SYSDATE NOT NULL, 
	REG_ID 			VARCHAR2(30), 
	REG_NM 			VARCHAR2(32) NOT NULL, 
	MOD_DT 			DATE, 
	MOD_ID 			VARCHAR2(30), 
	MOD_NM 			VARCHAR2(32), 
	DEL_DT 			DATE, 
	DEL_ID 			VARCHAR2(30), 
	DEL_NM 			VARCHAR2(32), 
	DEL_YN 			CHAR(1) DEFAULT 'N' NOT NULL,
	PRIMARY KEY (BOARD_STATE_SEQ)
);

CREATE SEQUENCE SEQ_MC_BOARD_STATE NOMINVALUE NOMAXVALUE;




CREATE TABLE MC_ATTACH (
	UUID 		VARCHAR2(50) NOT NULL, 
	ATTACH_NM 	VARCHAR2(256) NOT NULL, 
	YYYY 		CHAR(4) NOT NULL, 
	MM 			CHAR(2) DEFAULT '00' NOT NULL, 
	ORDER_SEQ 	NUMBER(2), 
	TABLE_NM 	VARCHAR2(64), 
	TABLE_SEQ 	NUMBER(11), 
	ALR_TAG 	VARCHAR2(600),
	VIEW_CNT	NUMBER(11) DEFAULT 0,
	REG_ID 		VARCHAR2(30) NOT NULL, 
	REG_NM 		VARCHAR2(32) NOT NULL, 
	REG_DT 		DATE DEFAULT SYSDATE NOT NULL, 
	DEL_ID 		VARCHAR2(30), 
	DEL_NM 		VARCHAR2(32), 
	DEL_DT 		DATE, 
	DEL_YN 		CHAR(1) DEFAULT 'N' NOT NULL, 
	PRIMARY KEY (UUID)
);

CREATE TABLE MC_USER_MEMBER (
  MEMBER_ID VARCHAR2(30) NOT NULL,
  MEMBER_PW VARCHAR2(100),
  MEMBER_NM VARCHAR2(30),
  EMAIL VARCHAR2(100),
  TEL VARCHAR2(15),
  CELL VARCHAR2(15),
  LAST_LOGIN DATE,
  MOD_ID VARCHAR2(30),
  MOD_NM VARCHAR2(30),
  MOD_DT DATE,
  MOD_IP VARCHAR2(16),
  DEL_ID VARCHAR2(30),
  DEL_NM VARCHAR2(30),
  DEL_DT DATE,
  USE_YN CHAR(1) DEFAULT 'Y',
  DEL_YN CHAR(1) DEFAULT 'N',
  ORDER_SEQ NUMBER(11),
  BLOCK_YN CHAR(1) DEFAULT 'N' NOT NULL, 
  LOGIN_FAIL_CNT NUMBER(11) DEFAULT '0' NOT NULL, 
  LAST_PW_DT DATE,
  DI VARCHAR2(100),
  BIRTH VARCHAR2(8),
  EMAIL_YN CHAR(1) DEFAULT 'N',
  SMS_YN CHAR(1) DEFAULT 'N',
  REG_DT DATE,
  PRIMARY KEY (MEMBER_ID)
);

CREATE TABLE MC_USER_REPORT (
	REPORT_SEQ 	NUMBER(11) NOT NULL,
	ARTICLE_SEQ NUMBER(11) NOT NULL,
	BOARD_SEQ 	NUMBER(11) NOT NULL,
	REPORTCONTS VARCHAR2(4000) NOT NULL, 
	IP 			VARCHAR2(16) NOT NULL, 
	REG_DT 		DATE, 
	REG_ID 		VARCHAR2(30), 
	REG_NM 		VARCHAR2(32), 
	PRIMARY KEY (REPORT_SEQ)
);
CREATE SEQUENCE SEQ_MC_USER_REPORT NOMINVALUE NOMAXVALUE;

CREATE TABLE MC_ARTICLE (
	ARTICLE_SEQ 	NUMBER(11) NOT NULL, 
	BOARD_SEQ 		NUMBER(11) NOT NULL, 
	TITLE 			VARCHAR2(256) NOT NULL, 
	CONTS 			CLOB, 
	IP 				VARCHAR2(16) NOT NULL, 
	VIEW_CNT 		NUMBER(11) DEFAULT 0 NOT NULL,  
	PUBLIC_YN 		CHAR(1) DEFAULT 'Y' NOT NULL, 
	NOTICE_YN 		CHAR(1) DEFAULT 'N' NOT NULL, 
	CAT 			NUMBER(11),
	STATE			NUMBER(11),
	THUMB 			VARCHAR2(100),
	PASSWORD 		VARCHAR2(100),
	REF_NUM 		NUMBER(11) NOT NULL, 
	STEP_NUM 		NUMBER(11) DEFAULT 0 NOT NULL, 
	DEPTH_NUM 		NUMBER(11) DEFAULT 0 NOT NULL, 
	SDATE 			DATE, 
	EDATE 			DATE, 
	REPLY_CONTS		CLOB,
	REPLY_ID 		VARCHAR2(30), 
	REPLY_NM 		VARCHAR2(32), 
	REPLY_DT 		DATE,
	CCL_TYPE		VARCHAR(1),
	NURI_TYPE		VARCHAR(1),
	TAG_NAMES		VARCHAR(200),
	REG_DT 			DATE DEFAULT SYSDATE NOT NULL, 
	REG_ID 			VARCHAR2(30) NOT NULL, 
	REG_NM 			VARCHAR2(32) NOT NULL, 
	MOD_DT 			DATE, 
	MOD_ID 			VARCHAR2(30), 
	MOD_NM 			VARCHAR2(32), 
	DEL_DT 			DATE, 
	DEL_ID 			VARCHAR2(30), 
	DEL_NM 			VARCHAR2(32), 
	DEL_YN 			CHAR(1) DEFAULT 'N' NOT NULL,
	PRIMARY KEY (ARTICLE_SEQ)
);

CREATE SEQUENCE SEQ_MC_ARTICLE NOMINVALUE NOMAXVALUE;

CREATE INDEX IDX_MC_ARTICLE ON MC_ARTICLE(REF_NUM DESC, STEP_NUM ASC, DEPTH_NUM DESC, ARTICLE_SEQ ASC);


CREATE TABLE MC_ARTICLE_COMMENT (
	COMMENT_SEQ 	NUMBER(11) NOT NULL, 
	ARTICLE_SEQ 	NUMBER(11) NOT NULL, 
	CONTS 			VARCHAR2(3000) NOT NULL, 
	IP 				VARCHAR2(16) NOT NULL, 
	REG_DT 			DATE DEFAULT SYSDATE NOT NULL, 
	REG_ID 			VARCHAR2(30) NOT NULL, 
	REG_NM 			VARCHAR2(32) NOT NULL, 
	DEL_DT			DATE, 
	DEL_ID 			VARCHAR2(30), 
	DEL_NM 			VARCHAR2(32), 
	DEL_YN 			CHAR(1) DEFAULT 'N' NOT NULL, 
	REF_NUM 		NUMBER(11), 
	STEP_NUM 		NUMBER(11) DEFAULT 0, 
	DEPTH_NUM 		NUMBER(11) DEFAULT 0, 
	REPLY_ID 		VARCHAR2(128), 
	PRIMARY KEY (COMMENT_SEQ)
);
CREATE SEQUENCE SEQ_MC_ARTICLE_COMMENT NOMINVALUE NOMAXVALUE;


CREATE TABLE MC_COMMENT_SNS
(
  COMMENT_SEQ   NUMBER(11) primary key,
  CMS_MENU_SEQ  NUMBER(11)                      NOT NULL,
  ARTICLE_SEQ   NUMBER(11)                      NOT NULL,
  PARENT_SEQ    NUMBER(11),
  CONTS         VARCHAR2(3000 )             NOT NULL,
  IP            VARCHAR2(16 )               NOT NULL,
  REG_DT        DATE                            DEFAULT SYSDATE               NOT NULL,
  REG_ID        VARCHAR2(30 ),
  REG_NM        VARCHAR2(32 )               NOT NULL,
  DEL_DT        DATE,
  DEL_ID        VARCHAR2(30),
  DEL_NM        VARCHAR2(32),
  DEL_YN        CHAR(1)                    DEFAULT 'N'                   NOT NULL,
  TWT_YN        CHAR(1)                    DEFAULT 'N',
  FACE_YN       CHAR(1)                    DEFAULT 'N',
  BLOG_YN       CHAR(1)                    DEFAULT 'N',
  PROFILE_IMG   VARCHAR2(300),
  MAIN_ACCOUNT  VARCHAR2(30),
  KAO_YN        CHAR(1)                    DEFAULT 'N',
  SNS_LINK      VARCHAR2(100)
);

CREATE SEQUENCE SEQ_MC_COMMENT_SNS
START WITH 1
MINVALUE 0
MAXVALUE 9223372036854775806;

create index IDX_COMMENT_SNS_SORTORDER on MC_COMMENT_SNS(PARENT_SEQ, COMMENT_SEQ);

CREATE TABLE MC_COMMENT_SNS_ACCOUNT
(
    SEQ    NUMBER(38) PRIMARY KEY,
    TWT_CONSUMER_KEY           VARCHAR2(255) NULL,
    TWT_CONSUMER_SECRET   VARCHAR2(255) NULL,
    FACE_APPID   VARCHAR2(255) NULL,
    FACE_APP_SECRET   VARCHAR2(255) NULL,
    FACE_ACCESS_TOKEN   VARCHAR2(255) NULL,
    NAV_CLIENT_ID   VARCHAR2(255) NULL,
    NAV_CLIENT_SECRET   VARCHAR2(255) NULL,
    DAUM_CLIENT_ID   VARCHAR2(255) NULL,
    DAUM_CLIENT_SECRET   VARCHAR2(255) NULL,
    KAO_CLIENT_ID   VARCHAR2(255) NULL
);

CREATE TABLE MC_POPUPZONE 
(	
	POPUPZONE_SEQ NUMERIC(32), 
	TITLE VARCHAR2(128), 
	LINK_YN CHAR(1), 
	LINK_URL VARCHAR2(256), 
	LINK_TARGET VARCHAR2(16), 
	FILE_PATH VARCHAR2(128), 
	USE_YN CHAR(1), 
	ORDER_SEQ VARCHAR2(5) DEFAULT 99999, 
	REG_DT DATE DEFAULT sysdate, 
	REG_ID VARCHAR2(30), 
	REG_NM VARCHAR2(32), 
	MOD_DT DATE DEFAULT NULL, 
	MOD_ID VARCHAR2(30), 
	MOD_NM VARCHAR2(32), 
	DEL_DT DATE DEFAULT NULL,
	DEL_ID VARCHAR2(30), 
	DEL_NM VARCHAR2(32), 
	DEL_YN CHAR(1) DEFAULT 'N', 
	START_DT DATE, 
	END_DT DATE, 
	ALT VARCHAR2(500), 
	X_COORD VARCHAR2(20),
	Y_COORD VARCHAR2(20),
	SITE_ID VARCHAR2(20),
	SELECTER VARCHAR2(20)
);

CREATE SEQUENCE SEQ_MC_POPUPZONE
START WITH 1
MINVALUE 1
MAXVALUE 9223372036854775806;

CREATE TABLE MC_RESERVE
(
    RESERVE_SEQ             NUMERIC(38) PRIMARY KEY,
    TITLE      		VARCHAR2(200),
    GUBUN      		VARCHAR2(1),
    CMS_MENU_SEQ    NUMERIC(38),
    BOARD_SEQ      	NUMERIC(38),
    PARAMS          CLOB,
    RESERVE_DT      VARCHAR2(30),
    STATUS          CHAR(1) DEFAULT 'W',
    TYPE            VARCHAR2(3),
    REG_ID          VARCHAR2(30),
    REG_NM          VARCHAR2(32),
    REG_DT          DATE,
    DEL_ID          VARCHAR2(30),
    DEL_NM          VARCHAR2(32),
    DEL_DT          DATE,
    DEL_YN          VARCHAR2(1) DEFAULT 'N'
);

CREATE SEQUENCE SEQ_MC_RESERVE
START WITH 1
MINVALUE 1
MAXVALUE 9223372036854775806;

CREATE TABLE MC_SATISFACTION
(
    SEQ   NUMERIC(11) PRIMARY KEY,
    CMS_MENU_SEQ    NUMERIC(11) NOT NULL,
    SCORE       NUMERIC(11) NOT NULL,
    ETC       VARCHAR2(1000),
    IP        VARCHAR2(17),
    REG_DT          DATE
);
CREATE SEQUENCE SEQ_MC_SATISFACTION
START WITH 1
MINVALUE 1
MAXVALUE 9223372036854775806;

CREATE TABLE MC_ANALYTICS
(
  YMD           CHAR(8),
  TITLE         VARCHAR2(100)              NOT NULL,
  REQUEST_URI   VARCHAR2(200),
  QUERY_STRING  VARCHAR2(250),
  BROWSER       VARCHAR2(250),
  REFERER       VARCHAR2(250),
  IP            VARCHAR2(15),
  LOCALE        VARCHAR2(10),
  YYYY          VARCHAR2(4),
  MM            CHAR(2),
  DD            CHAR(2),
  HH            CHAR(2),
  MEMBER_ID     VARCHAR2(30),
  SESSION_ID    VARCHAR2(40),
  CNT           NUMBER(11)                          DEFAULT '1',
  OS            VARCHAR2(20),
  SITE_ID 		NUMBER(11) DEFAULT 1
);

CREATE INDEX IDX_MC_ANALYTICS ON MC_ANALYTICS(YMD);

CREATE TABLE MC_POLL (
	POLL_SEQ 		NUMBER(11) NOT NULL,
	TITLE 			VARCHAR2(500) NOT NULL,
	START_DT 		DATE NOT NULL,
	END_DT 			DATE NOT NULL,
	REG_DT 			DATE NOT NULL,
	REG_ID 			VARCHAR2(50) NOT NULL,
	REG_NM 			VARCHAR2(32) NOT NULL,
	MOD_DT 			DATE NULL,
	MOD_ID 			VARCHAR2(50) NULL,
	MOD_NM 			VARCHAR2(32) NULL,
	DEL_DT 			DATE NULL,
	DEL_ID 			VARCHAR2(50) NULL,
	DEL_NM 			VARCHAR2(32) NULL,
	DEL_YN 			CHAR(1) NOT NULL,
	USE_YN 			CHAR(1) NOT NULL,
	LOT_YN			CHAR(1) NOT NULL,
	CMS_MENU_SEQ	NUMBER(11) NOT NULL,
	CONTENT 		CLOB NULL,
	CUD_GROUP_SEQ	VARCHAR2(150) NULL,
	PRIMARY KEY (POLL_SEQ)
);

CREATE TABLE MC_POLL_ANSWER (
	QUESTION_SEQ 	NUMBER(11) NOT NULL,
	ANSWER_SEQ 		NUMBER(11) NOT NULL,
	ANSWER 			VARCHAR2(4000) NOT NULL,
	POLL_SEQ 		NUMBER(11) NOT NULL,
	NULL_CHK 		CHAR(1) NULL,
	JUMP_CHK 		CHAR(1) NULL,
	DEL_YN			CHAR(1) NULL
);

CREATE TABLE MC_POLL_QUESTION (
	POLL_SEQ 			NUMBER(11) NOT NULL,
	QUESTION_SEQ 		NUMBER(11) NOT NULL,
	QUESTION 			VARCHAR2(4000) NOT NULL,
	QUESTION_TYPE 		CHAR(1) NOT NULL,
	QUESTION_CONTENT 	VARCHAR2(4000) NULL,
	DEL_YN				CHAR(1) NULL
);

CREATE TABLE MC_POLL_RESULT (
	POLL_SEQ 		NUMBER(11) NOT NULL,
	QUESTION_SEQ 	NUMBER(11) NOT NULL,
	ANSWER_SEQ 		NUMBER(11) NOT NULL,
	ANSWER 			VARCHAR2(4000) NULL,
	REG_DT 			DATE NOT NULL,
	REG_ID 			VARCHAR2(50) NOT NULL,
	REG_NM 			VARCHAR2(32) NOT NULL,
	REG_EMAIL 		VARCHAR2(126) NULL,
	REG_TEL			VARCHAR2(32) NULL,
	REG_SEQ 		NUMBER(11) NOT NULL,
	LOT_WIN			CHAR(1) NULL
);

CREATE TABLE MC_HOLIDAY 
(
	HOLIDAY_SEQ		NUMERIC(38) PRIMARY KEY, 
	HOLIDAY			VARCHAR2(30), 
	TITLE 			VARCHAR2(32),
	LUNAR_CAL 		VARCHAR2(30),
	SUN_CAL 		VARCHAR2(30),
	REG_ID      	VARCHAR2(30),
    REG_NM      	VARCHAR2(32),
    REG_DT      	DATE ,
    MOD_ID      	VARCHAR2(30),
    MOD_NM      	VARCHAR2(32),
    MOD_DT      	DATE,
    DEL_ID      	VARCHAR2(30),
    DEL_NM      	VARCHAR2(32),
    DEL_DT      	DATE,
    DEL_YN          VARCHAR2(1) DEFAULT 'N'
) ;

CREATE SEQUENCE SEQ_MC_HOLIDAY 
START WITH 518
MINVALUE 518
MAXVALUE 9223372036854775806;

CREATE TABLE MC_FILTER
(
	filtering VARCHAR2(1000) NOT NULL
);

CREATE TABLE MC_SEARCH (
  URL VARCHAR2(256) NOT NULL,
  CONTS VARCHAR2(3000) NOT NULL,
  IMG VARCHAR2(4000),
  TITLE VARCHAR2(128) NOT NULL,
  PRIMARY KEY (URL)
);

CREATE SEQUENCE SEQ_MC_SEARCH
START WITH 1
MINVALUE 1
MAXVALUE 9223372036854775806;

CREATE TABLE MC_SEARCH_TEXT(
	SEQ NUMBER NOT NULL, 
	SEARCH_TEXT VARCHAR2(256), 
	SEARCH_DATE DATE, 
	SEARCH_TIME NUMBER, 
	SEARCH_COUNT NUMBER, 
	PRIMARY KEY (SEQ)
);

CREATE SEQUENCE SEQ_MC_SEARCH_TEXT
START WITH 1
MINVALUE 0 
MAXVALUE 9223372036854775806;

CREATE TABLE MC_CMS_MENU_FILTER(
  CMS_MENU_SEQ NUMERIC(38) NOT NULL,
  FILTER_YN CHAR(1) DEFAULT 'N',
  JUMIN_YN CHAR(1) DEFAULT 'N',
  BUSINO_YN CHAR(1) DEFAULT 'N',
  BUBINO_YN CHAR(1) DEFAULT 'N',
  EMAIL_YN CHAR(1) DEFAULT 'N',
  TEL_YN CHAR(1) DEFAULT 'N',
  CELL_YN CHAR(1) DEFAULT 'N',
  CARD_YN CHAR(1) DEFAULT 'N',
  PRIMARY KEY (CMS_MENU_SEQ)
);

CREATE SEQUENCE SEQ_MC_CMS_MENU_FILTER
START WITH 1
MINVALUE 0 
MAXVALUE 9223372036854775806;

CREATE TABLE MC_CMS_MENU_FILTER_DEF (
  SEQ NUMERIC(11) DEFAULT 0,
  JUMIN_YN CHAR(1) DEFAULT 'N',
  BUSINO_YN CHAR(1) DEFAULT 'N',
  BUBINO_YN CHAR(1) DEFAULT 'N',
  EMAIL_YN CHAR(1) DEFAULT 'N',
  TEL_YN CHAR(1) DEFAULT 'N',
  CELL_YN CHAR(1) DEFAULT 'N',
  CARD_YN CHAR(1) DEFAULT 'N',
  FORBIDDEN_WORD VARCHAR2(4000),
  PRIMARY KEY (SEQ)
);

CREATE TABLE MC_PERSONAL_DATA(
    SEQ             NUMBER(11) NOT NULL,
    SITE_ID         NUMBER(11) DEFAULT 1,
    CMS_MENU_SEQ       NUMBER(11),
    SUB_SEQ       NUMBER(11),
    MENU_NM        VARCHAR2(255) NOT NULL,
    TITLE        VARCHAR2(200) NOT NULL,
    REG_DT          DATE DEFAULT SYSDATE NOT NULL,
    JUMIN_CNT        NUMBER(11),
    JUMIN_CONTS     CLOB,
    BUSINO_CNT       NUMBER(11),
    BUSINO_CONTS    CLOB,
    BUBINO_CNT       NUMBER(11),
    BUBINO_CONTS    CLOB,
    EMAIL_CNT        NUMBER(11),
    EMAIL_CONTS     CLOB,
    CELL_CNT         NUMBER(11),
    CELL_CONTS      CLOB,
    TEL_CNT          NUMBER(11),
    TEL_CONTS       CLOB,
    CARD_CNT         NUMBER(11),
    CARD_CONTS      CLOB,
    PRIMARY KEY(SEQ)
);

CREATE SEQUENCE SEQ_MC_PERSONAL_DATA
START WITH 1
MINVALUE 0 
MAXVALUE 9223372036854775806;


/* 확인 불가 */

CREATE TABLE MC_STAFF_LOGIN_TRACKING(
  SEQ          NUMBER NOT NULL,
  MEMBER_ID    VARCHAR2(100),
  MEMBER_NAME  VARCHAR2(100),
  LOGIN_DATE   DATE,
  LOGIN_IP     VARCHAR2(50),
  PRIMARY KEY(SEQ)
);

CREATE SEQUENCE SEQ_MC_STAFF_LOGIN_TRACKING START WITH 1 MINVALUE 0 MAXVALUE 9223372036854775806;

CREATE INDEX IDX_MC_STAFF_LOGIN_TRACKING ON MC_STAFF_LOGIN_TRACKING (SEQ,LOGIN_DATE);

CREATE TABLE MC_STAFF_LOCATION_TRACKING (
  SEQ            NUMBER NOT NULL,
  PARENT_SEQ     NUMBER NOT NULL,
  LOCATION_TIME  DATE DEFAULT SYSDATE,
  TITLE          VARCHAR2(500),
  JOB          	 VARCHAR2(100),
  URL            VARCHAR2(1000) NOT NULL,
  PARAMS		 CLOB,
  PRIMARY KEY (SEQ)
);

CREATE SEQUENCE SEQ_MC_STAFF_LOCATION_TRACKING START WITH 1 MINVALUE 0 MAXVALUE 9223372036854775806;

CREATE INDEX IDX_MC_STAFF_LOCATION_TRACKING ON MC_STAFF_LOCATION_TRACKING (SEQ,PARENT_SEQ);


CREATE TABLE MC_MANAGE_AUTH
(
  SEQ     NUMBER,
  TITLE   VARCHAR2(100),
  REG_ID  VARCHAR2(30),
  REG_NM  VARCHAR2(30),
  REG_DT  DATE,
  MOD_ID  VARCHAR2(30),
  MOD_NM  VARCHAR2(30),
  MOD_DT  DATE,
  DEL_ID  VARCHAR2(30),
  DEL_NM  VARCHAR2(30),
  DEL_DT  DATE,
  DEL_YN  CHAR(1) DEFAULT 'N',
  PRIMARY KEY (SEQ)
);

CREATE SEQUENCE SEQ_MC_MANAGE_AUTH NOMINVALUE NOMAXVALUE;


CREATE TABLE MC_MANAGE_AUTH_DETAIL
(
  SITE_ID		NUMBER,
  PARENT_SEQ    NUMBER,
  CMS_MENU_SEQ  NUMBER,
  ORDER_SEQ     NUMBER,
  ADD_YN        CHAR(1)                    DEFAULT 'N',
  MOD_YN        CHAR(1)                    DEFAULT 'N',
  VIEW_YN       CHAR(1)                    DEFAULT 'N',
  PRIMARY KEY (SITE_ID, PARENT_SEQ, CMS_MENU_SEQ, ORDER_SEQ)
);

CREATE TABLE MC_CMS_MANAGE_AUTH_DETAIL
(
  SITE_ID		NUMBER,
  MEMBER_ID       VARCHAR2(32),
  CMS_MENU_SEQ  NUMBER,
  ADD_YN        CHAR(1)                    DEFAULT 'N',
  MOD_YN        CHAR(1)                    DEFAULT 'N',
  VIEW_YN       CHAR(1)                    DEFAULT 'N',
  PRIMARY KEY (SITE_ID, MEMBER_ID, CMS_MENU_SEQ)
);


CREATE TABLE MC_MAIL (
	SEQ NUMBER(11) NOT NULL,
	TITLE VARCHAR2(200) NOT NULL,
	CONTS CLOB,
	SENDER_NM VARCHAR2(200) NOT NULL,
	SENDER_MAIL VARCHAR2(200) NOT NULL,
	RECEIVER VARCHAR2(100),
	STATUS VARCHAR2(2) NOT NULL,
	REG_ID VARCHAR2(50) NOT NULL,
	REG_NM VARCHAR2(32) NOT NULL,
	REG_DT DATE,
	MOD_ID VARCHAR2(50),
	MOD_NM VARCHAR2(32),
	MOD_DT DATE,
	TARGET_SEQ NUMBER,
	FORM_SEQ NUMBER,
  	PRIMARY KEY (SEQ)
);

CREATE SEQUENCE SEQ_MC_MAIL
  START WITH 1
  MAXVALUE 9223372036854775806
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;

CREATE TABLE MC_MAIL_FORM (
	SEQ NUMBER(11) NOT NULL,
	TITLE VARCHAR2(100) NOT NULL,
	CONTS CLOB,
  	PRIMARY KEY (SEQ)
);

CREATE SEQUENCE SEQ_MC_MAIL_FORM
  START WITH 1
  MAXVALUE 9223372036854775806
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;

CREATE TABLE MC_MAIL_QUEUE (
	SEQ NUMBER(11) NOT NULL,
	P_SEQ NUMBER(11) NOT NULL,
	USER_NAME VARCHAR2(50) NOT NULL,
	USER_EMAIL VARCHAR2(50) NOT NULL,
	STATUS CHAR(1),
  	PRIMARY KEY (SEQ)
);

CREATE SEQUENCE SEQ_MC_MAIL_QUEUE
  START WITH 1
  MAXVALUE 9223372036854775806
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;

CREATE TABLE MC_MAIL_SMTP (
	SEQ NUMBER(11) NOT NULL,
	TITLE VARCHAR2(200) NOT NULL,
	HOST VARCHAR2(100) NOT NULL,
	PORT NUMBER NOT NULL,
	AUTH_ID VARCHAR2(200) NOT NULL,
	AUTH_PW VARCHAR2(200) NOT NULL,
	SSL_YN VARCHAR2(2) NOT NULL,
	TLS_YN VARCHAR2(2) NOT NULL,
  	PRIMARY KEY (SEQ)
);

CREATE SEQUENCE SEQ_MC_MAIL_SMTP
  START WITH 1
  MAXVALUE 9223372036854775806
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;

CREATE TABLE MC_MAIL_TARGET (
	SEQ NUMBER(11) NOT NULL,
	TITLE VARCHAR2(100) NOT NULL,
	TARGET_CNT NUMBER(11),
  	PRIMARY KEY (SEQ)
);

CREATE SEQUENCE SEQ_MC_MAIL_TARGET
  START WITH 1
  MAXVALUE 9223372036854775806
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;

CREATE TABLE MC_MAIL_TARGET_LIST (
	SEQ NUMBER(11) NOT NULL,
	P_SEQ NUMBER(11) NOT NULL,
	USER_NAME VARCHAR2(50) NOT NULL,
	USER_EMAIL VARCHAR2(50) NOT NULL,
  	PRIMARY KEY (SEQ)
);

CREATE SEQUENCE SEQ_MC_MAIL_TARGET_LIST
  START WITH 1
  MAXVALUE 9223372036854775806
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;

CREATE TABLE MC_CMS_LIBS (
  SEQ NUMBER(11) NOT NULL,
  SITE_ID NUMBER(11) DEFAULT NULL,
  FILE_NAME VARCHAR2(100) DEFAULT NULL,
  CODE_TEXT CLOB,
  REG_NM VARCHAR2(30) DEFAULT NULL,
  REG_ID VARCHAR2(30) DEFAULT NULL,
  REG_DT DATE,
  PRIMARY KEY (SEQ)
);

CREATE SEQUENCE SEQ_MC_CMS_LIBS
  START WITH 1
  MAXVALUE 9223372036854775806
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;

CREATE TABLE MC_CMS_MENU_LIBS (
  SEQ NUMBER(11) NOT NULL,
  CMS_MENU_SEQ NUMBER(11) DEFAULT NULL,
  TP CHAR(1) DEFAULT NULL,
  EXTENSION VARCHAR2(3) DEFAULT NULL,
  ORDER_SEQ NUMBER(11) DEFAULT NULL,
  FULL_PATH VARCHAR2(200) DEFAULT NULL,
  ORG_FILE_NAME VARCHAR2(50) DEFAULT NULL,
  SYS_FILE_NAME VARCHAR2(50) DEFAULT NULL,
  PRIMARY KEY (SEQ)
);

CREATE SEQUENCE SEQ_MC_CMS_MENU_LIBS
  START WITH 1
  MAXVALUE 9223372036854775806
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;



CREATE TABLE MC_SOURCE_HISTORY (
  SEQ NUMBER(11) NOT NULL,
  FILE_PATH VARCHAR2(200) DEFAULT NULL,
  CODE_TEXT CLOB,
  REG_NM VARCHAR2(30) DEFAULT NULL,
  REG_ID VARCHAR2(30) DEFAULT NULL,
  REG_DT DATE DEFAULT NULL,
  PRIMARY KEY (seq)
);

CREATE SEQUENCE SEQ_MC_SOURCE_HISTORY
  START WITH 1
  MAXVALUE 9223372036854775806
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;
  
CREATE OR REPLACE FUNCTION MANAGEMENT_SITE_TITLE(
    IN_STR         IN  VARCHAR 
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


/* 확인 불가 */







CREATE OR REPLACE FUNCTION FN_GET_SPLIT (
	IN_STR 			IN VARCHAR2 (2000)
	,IN_LEVEL 		IN INTEGER
	,IN_DELIMETER 	IN VARCHAR2 (20)
	,IN_DEFAULT_VAL IN VARCHAR2 (100)
)
RETURN VARCHAR2 (4000) 
IS 
	V_RETURN 			VARCHAR2 (2000);
	STRVALUE 			VARCHAR2 (2000) : = IN_STR;
	DEFAULT_RETURN_VAL 	VARCHAR2 (2000) : = IN_DEFAULT_VAL;
	IDX INTEGER;
	ILEVEL INTEGER : = 0;
BEGIN 
	V_RETURN : = '';
	-- 문자열이 없으면 기본 리턴값 반환 후 종료
	IF NVL(STRVALUE,'NO_STRING') = 'NO_STRING' THEN
		RETURN DEFAULT_RETURN_VAL;
	END IF;
	LOOP
		--구분자 인덱스 확인
 		IDX : = INSTR (STRVALUE,IN_DELIMETER);
 		
 		IF IDX > 0 THEN --구분자로 문자를 찾은경우
 			ILEVEL : = ILEVEL + 1; -- 현재 레벨이 원하는 레벨이면 현재 문자열 반환 AND 레벨이 -1인경우는 마지막까지 LOOP
 			IF ILEVEL = IN_LEVEL AND IN_LEVEL ! = - 1 THEN 
 				V_RETURN : = SUBSTR (STRVALUE,1,IDX - 1);
 				EXIT;
			END IF;
			STRVALUE : = SUBSTR (STRVALUE,IDX + LENGTH (IN_DELIMETER));
		ELSE -- 구분자가 없을 경우, 문자열을 그대로 반환
 			IF ILEVEL = 0 THEN --구분자가 포함이 안되었지만 레벨이 1인경우 문자 그대로 반환
 				IF IN_LEVEL = 1 THEN
 					V_RETURN : = STRVALUE;
				ELSE
					V_RETURN : = '';
				END IF;
			ELSE 
				-- 마지막 문자열일 경우
 				ILEVEL : = ILEVEL + 1;
 				
 				-- 마지막을 원하는 경우 마지막 문자열 반환 / -1은 레벨을 모를경우 구분자의 마지막 문자열 반환
 				IF ILEVEL = IN_LEVEL OR IN_LEVEL = - 1 THEN
 					V_RETURN : = STRVALUE;
				ELSE
					-- 원하는 레벨의 값이 없을 경우, 공백 반환
 					V_RETURN : = '';
				END IF;
			END IF;
			EXIT; --반복 탈출문
		END IF;
	END LOOP;
	--최종결과 리턴
	RETURN NVL (V_RETURN,DEFAULT_RETURN_VAL);
	EXCEPTION 
		WHEN OTHERS	THEN
			RETURN SQLERRM;
END FN_GET_SPLIT;
/

CREATE OR REPLACE FUNCTION SYS_CONNECT_BY_PATH_MENU (
	PKEY MC_CMS_MENU.PARENT_MENU_SEQ % TYPE
	,PLEVEL INTEGER
	,DELIM VARCHAR (10)
)
RETURN VARCHAR2 (200) AS PATH VARCHAR (200);
	BEGIN 
		DECLARE CURSOR C1 IS 
		
			SELECT TITLE FROM MC_CMS_MENU WHERE LEVEL <= PLEVEL
			START WITH CMS_MENU_SEQ = PKEY 
			CONNECT BY PRIOR PARENT_MENU_SEQ = CMS_MENU_SEQ;
		BEGIN 
			FOR CREC IN C1 
		LOOP 
			PATH : = DELIM || CREC.TITLE || PATH;
		END LOOP;
		RETURN PATH;
	END;
END;
/

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
    IF  NVL(:OLD.GROUP_SEQ, 'x') !=  NVL(:NEW.GROUP_SEQ, 'x') THEN
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


CREATE OR REPLACE PROCEDURE CP_MC_CMS_MENU_BAKUP
 /* IN  PARAMETER */
 (
     V_JSON_STAFFS    IN    CLOB
    ,V_JSON_STAFF_GROUP    IN    CLOB
    ,V_JSON_LIBS    IN    CLOB
    ,V_CMS_MENU_SEQ IN NUMBER
 )       
 IS 
 BEGIN 
   INSERT INTO MC_CMS_MENU_BAKUP(
            SEQ, CMS_MENU_SEQ, TITLE, TITLE_PATH_ON, TITLE_PATH_OFF, MENU_ORDER, USE_YN, BLANK_YN, MENU_TYPE, TARGET_URL, 
            PROGRAM_NM, CUD_GROUP_SEQ, R_GROUP_SEQ, MANAGE_URL, ADD_PARAM, INNER_YN, BOARD_SEQ, SITE_ID, REG_NM, REG_DT, MOD_NM, MOD_DT, 
            DEL_NM, DEL_DT, DEL_YN, CHILD_TYPE, FOOT_HTML, TEMPLATE_TYPE, REG_ID, MOD_ID, DEL_ID, PARENT_MENU_SEQ, MENU_URL, TOP_YN,
            JSON_STAFFS, JSON_STAFF_GROUP, JSON_LIBS
        )
        SELECT 
            SEQ_MC_CMS_MENU_BAKUP.NEXTVAL, CMS_MENU_SEQ, TITLE, TITLE_PATH_ON, TITLE_PATH_OFF, MENU_ORDER, USE_YN, BLANK_YN, MENU_TYPE, TARGET_URL, 
            PROGRAM_NM, CUD_GROUP_SEQ, R_GROUP_SEQ, MANAGE_URL, ADD_PARAM, INNER_YN, BOARD_SEQ, SITE_ID, REG_NM, REG_DT, MOD_NM, MOD_DT, 
            DEL_NM, DEL_DT, DEL_YN, CHILD_TYPE, FOOT_HTML, TEMPLATE_TYPE, REG_ID, MOD_ID, DEL_ID, PARENT_MENU_SEQ, MENU_URL, TOP_YN,
            V_JSON_STAFFS, V_JSON_STAFF_GROUP, V_JSON_LIBS
        FROM MC_CMS_MENU 
        WHERE CMS_MENU_SEQ=V_CMS_MENU_SEQ
        ;
   COMMIT; 
 END CP_MC_CMS_MENU_BAKUP;
/