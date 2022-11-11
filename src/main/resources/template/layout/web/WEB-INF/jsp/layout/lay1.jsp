<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<sec:csrfMetaTags/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="SiteID" content="${site_id }"/>
<title><sitemesh:decorate decorator="{{SUB_PATH}}/inc/page_title.do?site_id=0&cms_menu_seq=${menu_seq }" /></title>
<link rel="stylesheet" href="<c:url value="/lib/css/import.css"/>" type="text/css">
<link href="<c:url value="/lib/css/base/jquery-ui-1.12.1.css"/>" rel="stylesheet" type="text/css" />
<link href="<c:url value="/lib/css/base/jquery-ui.theme.css"/>" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<c:url value="/lib/js/jquery-3.5.1.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery-migrate-1.4.1.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery-ui-1.12.1.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.cookie.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.lck.util.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.form.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/gnb.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/sub.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/common.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/mc.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.blockUI.js"/>"></script>
<sitemesh:decorate decorator="{{SUB_PATH}}/inc/libs.do?site_id=${site_id }&cms_menu_seq=${menu_seq }" /><!-- 관리자 메뉴설정에서 설정 -->
<sitemesh:write property='head'/>
</head>
<body>
<div class="wrap">
	<sitemesh:decorate decorator="{{SUB_PATH}}/inc/header.do?site_id=${site_id }&cms_menu_seq=${menu_seq }" />
	
	<div class="contents_wrap">
		<div class="sub_visual">
			<sitemesh:decorate decorator="{{SUB_PATH}}/inc/cont_header.do?site_id=${site_id }&cms_menu_seq=${menu_seq }" />
			<div class="navi">
				<sitemesh:decorate decorator="{{SUB_PATH}}/inc/page_navi.do?site_id=${site_id }&cms_menu_seq=${menu_seq }" />
			</div>
		</div>
    	<div class="contents">
        <sitemesh:decorate decorator="{{SUB_PATH}}/inc/left.do?site_id=${site_id }&cms_menu_seq=${menu_seq }" />
        	<div id="sub">
        		<div class="strapline"><sitemesh:decorate decorator="{{SUB_PATH}}/inc/sub_tit.do?site_id=${site_id }&cms_menu_seq=${menu_seq }" /></div>
				<div class="sub_contents">
					<sitemesh:decorate decorator="{{SUB_PATH}}/inc/tabmenu.do?site_id=${site_id }&cms_menu_seq=${menu_seq }" />
					<sitemesh:write property='body'/>
					<sitemesh:decorate decorator="{{SUB_PATH}}/inc/page_manager.do?site_id=${site_id }&cms_menu_seq=${menu_seq }" />
				</div>
        	</div>
    	</div>
	</div>
	<sitemesh:decorate decorator="{{SUB_PATH}}/inc/footer.do?site_id=${site_id }" />
</div>
<sitemesh:decorate decorator="{{SUB_PATH}}/inc/mobile_menu.do?site_id=${site_id }" />
</body>
</html>