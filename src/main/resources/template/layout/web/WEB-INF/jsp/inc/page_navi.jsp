<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript" src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">
//사용할 앱의 JavaScript 키를 설정해 주세요.
Kakao.init("<spring:eval expression="@config['kao_javascript_key']" />");
</script>
<div class="n_wrap">
	<div class="state">
	<c:set var="page_list" value="${fn:split(page_navi.page_navi, '>') }" />
	<span><a href="#"><img src="/images/sub/home.png" alt="홈" /></a></span>
	<c:forEach var="item" items="${page_list }" varStatus="status">
		<c:choose>
			<c:when test="${status.last }">
			<span><strong>${item }</strong></span>
			</c:when>
			<c:otherwise>
			<span>${item }</span>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	</div>
	<div class="etc">
		<a href="javascript:window.print();"><img src="/images/sub/print.png" alt="인쇄" title="새창열림" /></a>
		<a href="javascript:fbLink();"><img src="/images/sub/facebook.png" alt="페이스북" title="새창열림" /></a>
		<a href="javascript:twtLink();"><img src="/images/sub/twitter.png" alt="트위터" title="새창열림" /></a>
		<a href="javascript:ksLink();"><img src="/images/sub/kakao.png" alt="카카오스토리" title="새창열림" /></a>
		<a href="javascript:copyLink();"><img src="/images/sub/link.png" alt="링크복사" title="새창열림" /></a>
	</div>
</div>