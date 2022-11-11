<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.mc.common.util.RequestSnack" %>
<%
session.invalidate();
if(RequestSnack.isAjax(request)) {
	response.setStatus(403);
	new org.springframework.security.access.AccessDeniedException("403 returned");
}else{
	out.print("<script>alert('새로운 사용자가 로그인하였거나, 로그아웃되었습니다.');location.href='/';</script>");
}
%>