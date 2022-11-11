<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<title>페이지이력</title>
</head>
<body>
	<div class="policy_form">
		<div class="recent">
			${view.conts }
		</div>
		<c:if test="${!empty hlist }">
		<ul class="list">
		<c:forEach var="item" items="${hlist }">
			<c:if test="${item.seq ne view.seq }">
			<!--<li><a href="intro.do?gubun=${item.gubun }&seq=${item.seq }">이전 개인정보취급방침 ${item.reg_dt }</a></li>-->
			<li><a href="intro.do?gubun=${item.gubun }&seq=${item.seq }">${item.reg_dt } 내용 확인 하기</a></li>
			</c:if>
		</c:forEach>
		</ul>
		</c:if>
	</div>
</body>
</html>
