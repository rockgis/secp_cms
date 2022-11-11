<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>
<c:set var="view" value="${data.view }"/>
<c:set var="prev" value="${data.prev }"/>
<c:set var="next" value="${data.next }"/>
<c:set var="count" value="1"/>
<html>
<head>
<c:if test="${boardInfo.search_yn == 'N'}"><meta name="robots" content="noindex,nofollow"/></c:if>
<script type="text/javascript" src="<c:url value="/lib/js/bbs.js"/>"></script>
</head>
<body>
<c:out value="${boardInfo.conts }" escapeXml="false"></c:out>

<table class="view_style_1 view_s1">
	<caption></caption>
	<colgroup>
		<col style="width:15%"/>
		<col/>
		<col style="width:13%"/>
		<col style="width:15%"/>
		<col style="width:13%"/>
		<col style="width:15%"/>
	</colgroup>
	<thead>
		<tr>
		  <th scope="row" colspan="6" class="c1 title">${suf:clearXSS(view.title, '')}</th>
		</tr>
	</thead>
	<tbody>
		<tr>
		<c:choose>
			<c:when test="${boardInfo.cat_yn == 'Y' }">
				<th scope="row">카테고리</th>
				<td>${view.cat_nm}</td>
				<th scope="row">작성자</th>
				<td>${(view.member_id == '' || view.member_id == null) ? view.reg_nm : view.member_id}</td>
				<th scope="row">작성일</th>
				<td>${view.reg_dt}</td>
			</c:when>
			<c:otherwise>
				<th scope="row">작성자</th>
				<td colspan="2">${(view.member_id == '' || view.member_id == null) ? view.reg_nm : view.member_id}</td>
				<th scope="row">작성일</th>
				<td colspan="2">${view.reg_dt}</td>
			</c:otherwise>
		</c:choose>
		</tr>
		<c:if test="${fn:length(data.files) > 0 }">
		<tr>
		  <th scope="row">파일</th>
		  <td colspan="5">
		  <c:forEach items="${data.files }" var="files" varStatus = "status">
		  	<a href="<c:url value="/download.do"/>?uuid=${files.uuid }" target="_blank" title="첨부파일${count}">${files.attach_nm}</a>&nbsp;
		  	<c:set var="count" value="${count + 1}" scope="page"/>
		  	<%-- <a href="<c:url value="/docview/preview.do"/>?uuid=${files.uuid }" title="새창열림" target="_blank"><img src="/images/sub/preview_btn.gif" alt="미리보기"></a> --%>
		  </c:forEach>
		  </td>
		</tr>
		</c:if>
		<tr>
		  <td colspan="6" class="view_text">
		    ${fn:replace(fn:replace(view.conts, '<script>', '&lt;script&gt;'), '</script>', '&lt;/script&gt;')}
		  </td>
		</tr>
	</tbody>
</table>

<div class="btn_type1">
	<div class="right">
		<c:if test="${(sessionScope.member != null && sessionScope.member.member_id == view.reg_id) || view.password != null}">
			<a href="javascript:del('${view.article_seq}', '${param.cpage}', '${param.rows}', '${param.condition}', '${param.keyword}')" class="b_btn_2">삭제</a>
			<a href="modifyForm.do?article_seq=${view.article_seq }&amp;cpage=${param.cpage }&amp;rows=${param.rows }&amp;condition=${param.condition }&amp;keyword=${param.keyword }" class="b_btn_1">수정</a>
		</c:if>
			<a href="list.do?cpage=${param.cpage }&amp;rows=${param.rows }&amp;condition=${param.condition }&amp;keyword=${param.keyword }&amp;cat=${param.cat}" class="b_btn_1">목록으로</a>
	</div>
</div>

<table class="nextprev_style_1">
	<caption>이전,다음 게시물 목록을 볼 수 있습니다.</caption>
	<colgroup>
		<col width="120px">
		<col width="">
	</colgroup>
	<tbody>
		<tr>
		  <th scope="row">다음글</th>
		  <td>
		  <c:choose>
		  <c:when test="${next.article_seq eq null}">다음 글이 없습니다.</c:when>
		  <c:otherwise><a href="view.do?mode=view&amp;article_seq=${next.article_seq }&amp;cpage=${param.cpage }&amp;rows=${param.rows }&amp;condition=${param.condition }&amp;keyword=${param.keyword }">${suf:clearXSS(next.title, '')}</a></c:otherwise>
		  </c:choose>
		  </td>
		</tr>
		<tr>
		  <th scope="row">이전글</th>
		  <td>
		  <c:choose>
		  <c:when test="${prev.article_seq eq null}">이전 글이 없습니다.</c:when>
		  <c:otherwise><a href="view.do?mode=view&amp;article_seq=${prev.article_seq }&amp;cpage=${param.cpage }&amp;rows=${param.rows }&amp;condition=${param.condition }&amp;keyword=${param.keyword }">${suf:clearXSS(prev.title, '')}</a></c:otherwise>
		  </c:choose>
		  </td>
		</tr>
	</tbody>
</table>

<c:if test="${boardInfo.comment_yn == 'Y' }">
<jsp:include page="/comments/comment_box.do">
	<jsp:param name="cms_menu_seq" value="${menu_seq }"/>
	<jsp:param name="article_seq" value="${view.article_seq }"/>
</jsp:include>
</c:if>
</body>
</html>