<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>${data.title }</title>
</head>
<body>
<c:out value="${tab_menu }" escapeXml="false"/>
<c:out value="${data.conts }" escapeXml="false"/>
<c:if test="${!empty data.tag_names }">
<div class="tag">
	<p>태그</p>
	<div>
		<c:set var="tag_list" value="${fn:split(data.tag_names, ',') }" />
		<c:forEach var="item" items="${tag_list }">
		<a>${item }</a>
		</c:forEach>
	</div>
</div>
</c:if>

<c:if test="${!empty data.ccl_type || !empty data.nuri_type}">
<div class="copyright">
	<c:choose>
		<c:when test="${data.ccl_type eq '1' }">
			<span><img src="/images/sub/ccl_mark_01.gif" alt="저작자표시 4.0 국제"></span>
		</c:when>
		<c:when test="${data.ccl_type eq '2' }">
			<span><img src="/images/sub/ccl_mark_02.gif" alt="저작자표시-변경금지 4.0 국제"></span>
		</c:when>
		<c:when test="${data.ccl_type eq '3' }">
			<span><img src="/images/sub/ccl_mark_03.gif" alt="저작자표시-동일조건변경허락 4.0 국제"></span>
		</c:when>
		<c:when test="${data.ccl_type eq '4' }">
			<span><img src="/images/sub/ccl_mark_04.gif" alt="저작자표시-비영리 4.0 국제"></span>
		</c:when>
		<c:when test="${data.ccl_type eq '5' }">
			<span><img src="/images/sub/ccl_mark_05.gif" alt="저작자표시-비영리-변경금지 4.0 국제"></span>
		</c:when>
		<c:when test="${data.ccl_type eq '6' }">
			<span><img src="/images/sub/ccl_mark_06.gif" alt="저작자표시-비영리-동일조건변경허락 4.0 국제"></span>
		</c:when>
	</c:choose>
	
	<c:choose>
		<c:when test="${data.nuri_type eq '1' }">
			<span><img src="/images/sub/kogl_mark_01.gif" alt="출처표시 / 상업적, 비상업적 이용가능 / 변형 등 2차적 저작물 작성 가능"></span>
		</c:when>
		<c:when test="${data.nuri_type eq '2' }">
			<span><img src="/images/sub/kogl_mark_02.gif" alt="출처표시 / 비상업적 이용만 가능 / 변형 등 2차적 저작물 작성 가능"></span>
		</c:when>
		<c:when test="${data.nuri_type eq '3' }">
			<span><img src="/images/sub/kogl_mark_03.gif" alt="출처표시 / 상업적, 비상업적 이용가능 / 변형 등 2차적 저작물 작성금지"></span>
		</c:when>
		<c:when test="${data.nuri_type eq '4' }">
			<span><img src="/images/sub/kogl_mark_04.gif" alt="출처표시 / 비상업적 이용만 가능 / 변형 등 2차적 저작물 작성 금지"></span>
		</c:when>
	</c:choose>
</div>
</c:if>
</body>
</html>
