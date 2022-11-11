<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>MC@CMS Demo Log-In</title>
<link href="<c:url value="/lib/css/cmsbase.css" />" rel="stylesheet" type="text/css" />
<link href="<c:url value="/lib/css/cmsadmin.css" />" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<c:url value="/lib/js/jquery-3.5.1.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery-migrate-1.4.1.min.js"/>"></script>
<script type="text/javascript">
$(function(){

	<sec:authorize access="hasRole('ROLE_ADMIN')">
	alert("사용자 화면을 이용하시기위해서 관리자 계정을 로그아웃하여주시기 바랍니다.");
	location.href="/super";
	</sec:authorize>	

	<sec:authorize access="hasRole('ROLE_USER')">
	alert("이미 로그인 되어있습니다.");
	location.href="/";
	</sec:authorize>
	
});
</script>
</head>
<body>
<sec:authorize access="hasRole('ROLE_ADMIN')">
  사용자 화면을 이용하시기위해서 관리자 계정을 로그아웃하여주시기 바랍니다.
</sec:authorize>
</body>
</html>
