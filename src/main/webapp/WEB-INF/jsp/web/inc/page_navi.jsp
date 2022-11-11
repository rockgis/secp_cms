<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="state clearfix">
<c:set var="page_list" value="${fn:split(page_navi.page_navi, '>') }" />
<span class="home"><a href="/">HOME</a></span>
<c:forEach var="item" items="${page_list }" varStatus="status">
	<c:choose>
		<c:when test="${status.last }">
		<span>${item }</span>
		</c:when>
		<c:otherwise>
		<span>${item }</span>
		</c:otherwise>
	</c:choose>
</c:forEach>
</div>
