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
<meta name="SiteID" content="1"/>
<title><sitemesh:decorate decorator="/web/inc/page_title.do?site_id=0&cms_menu_seq=1" /></title>
<%-- <link rel="stylesheet" href="<c:url value="/lib/css/import.css"/>" type="text/css" /> --%>
<link rel="stylesheet" href="<c:url value="/lib/css/main.css"/>" type="text/css" />
<link rel="stylesheet" href="<c:url value="/lib/css/jquery.bxslider.css"/>" type="text/css" />
<script type="text/javascript" src="<c:url value="/lib/js/jquery-3.5.1.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery-migrate-1.4.1.min.js"/>" defer></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery-ui-1.12.1.min.js"/>" defer></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.cookie.js"/>" defer></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.bxslider.min.js"/>" defer></script>
<script type="text/javascript" src="<c:url value="/lib/js/common.js"/>" defer></script>
<script type="text/javascript" src="<c:url value="/lib/js/gnb.js"/>" defer></script>
<script type="text/javascript" src="<c:url value="/lib/js/main.js"/>" defer></script>
<sitemesh:write property='head'/>
</head>
<body>
<div class="wrap">
	<!-- <sitemesh:decorate decorator="/web/inc/header.do?site_id=1" /> -->
	<sitemesh:write property='body'/>
	<!-- <sitemesh:decorate decorator="/web/inc/footer.do?site_id=1" />
	<sitemesh:decorate decorator="/web/inc/mobile_menu.do?site_id=1" /> -->
</div>
</body>
</html>
