<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<sec:csrfMetaTags/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="SiteID" content="${site_id }"/>
<title><sitemesh:decorate decorator="/web/inc/page_title.do?site_id=0&cms_menu_seq=${menu_seq }" /></title>
<link rel="stylesheet" href="<c:url value="/lib/css/import.css"/>" type="text/css" />
<link rel="stylesheet" href="<c:url value="/lib/css/sub.css"/>" type="text/css" />
<link href="<c:url value="/lib/css/base/jquery-ui-1.12.1.css"/>" rel="stylesheet" type="text/css" />
<link href="<c:url value="/lib/css/base/jquery-ui.theme.css"/>" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<c:url value="/lib/js/jquery-3.5.1.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery-migrate-1.4.1.min.js"/>" defer></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery-ui-1.12.1.min.js"/>" defer></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.cookie.js"/>" defer></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.lck.util.js"/>" defer></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.form.js"/>" defer></script>
<script type="text/javascript" src="<c:url value="/lib/js/gnb.js"/>" defer></script>
<script type="text/javascript" src="<c:url value="/inc/lib/js/sub.do?site_id=${site_id }"/>" defer></script><!-- 관리자에서 설정 -->
<script type="text/javascript" src="<c:url value="/inc/lib/js/common.do?site_id=${site_id }"/>" defer></script><!-- 관리자에서 설정 -->
<script type="text/javascript" src="<c:url value="/lib/js/mc.js"/>" defer></script>
<sitemesh:decorate decorator="/web/inc/libs.do?site_id=${site_id }&cms_menu_seq=${menu_seq }" /><!-- 관리자 메뉴설정에서 설정 -->
<sitemesh:write property='head'/>
</head>
<body>
<div class="wrap">
	<sitemesh:decorate decorator="/web/inc/header.do?site_id=${site_id }&cms_menu_seq=${menu_seq }" />
	
	<div class="member_wrap">
    	<div class="member_contents">
        	<div id="member_area">
	        		<sitemesh:decorate decorator="/web/inc/tabmenu.do?site_id=${site_id }&cms_menu_seq=${menu_seq }" />
					<sitemesh:write property='body'/>
				<%--         		
				<div class="sub_contents">
				</div>
				 --%>
        	</div>
    	</div>
	</div>
	<sitemesh:decorate decorator="/web/inc/footer.do?site_id=${site_id }" />
</div>
<sitemesh:decorate decorator="/web/inc/mobile_menu.do" />
</body>
</html>
