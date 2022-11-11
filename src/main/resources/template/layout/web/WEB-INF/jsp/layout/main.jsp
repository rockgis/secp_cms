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
<meta name="SiteID" content="{{SITE_ID}}"/>
<title><sitemesh:decorate decorator="{{SUB_PATH}}/inc/page_title.do?site_id=0&cms_menu_seq={{SITE_ID}}" /></title>
<link rel="stylesheet" href="<c:url value="/lib/css/import.css"/>" type="text/css" />
<link rel="stylesheet" href="<c:url value="/lib/css/jquery.bxslider.css"/>" type="text/css" />
<link href="<c:url value="/lib/css/base/jquery-ui-1.12.1.css"/>" rel="stylesheet" type="text/css" />
<link href="<c:url value="/lib/css/base/jquery-ui.theme.css"/>" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<c:url value="/lib/js/jquery-3.5.1.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery-migrate-1.4.1.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery-ui-1.12.1.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.cookie.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.bxslider.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/common.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/gnb.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/b_banner.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/main.js"/>"></script>
<sitemesh:write property='head'/>
</head>
<body>
<div class="wrap">
	<sitemesh:decorate decorator="{{SUB_PATH}}/inc/header.do?site_id={{SITE_ID}}" />
	<sitemesh:write property='body'/>
	<sitemesh:decorate decorator="{{SUB_PATH}}/inc/footer.do?site_id={{SITE_ID}}" />
	<sitemesh:decorate decorator="{{SUB_PATH}}/inc/mobile_menu.do?site_id={{SITE_ID}}" />
</div>
</body>
</html>
