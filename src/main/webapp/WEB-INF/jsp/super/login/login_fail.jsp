<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	
	alert("아이디와 비밀번호가 일치하지 않습니다.");
	history.back();
	
});
</script>
</head>
<body>
  아이디와 비밀번호가 일치하지 않습니다.
</body>
</html>
