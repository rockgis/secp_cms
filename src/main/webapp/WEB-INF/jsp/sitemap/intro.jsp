<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html lang="ko">
<head>
<title>사이트맵</title>
</head>

<body>
<!-- contents -->
<div class="sitemap_wrap">
	<div class="sitemap">
		<c:out value="${sitemap}" escapeXml="false"/>
	</div>
</div>

<!-- //contents --> 
</body>
</html>