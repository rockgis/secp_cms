<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
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
<table class="board_view">
	<caption>
		<strong>
			<c:choose>
				<c:when test="${boardInfo.cat_yn == 'Y' }">
					"[ ${view.cat_nm} ] ${suf:clearXSS(view.title, '')}" 상세페이지
				</c:when>
				<c:otherwise>
					"${suf:clearXSS(view.title, '')}" 상세페이지
				</c:otherwise>
			</c:choose>
		</strong>
		<p>제목, 작성자, 작성일 내용 정보를 제공합니다.</p>
	</caption>
	<colgroup>
		<col style="width:15%;"/>
		<col style="width:35%;"/>
		<col style="width:15%;"/>
		<col style="width:35%;"/>
	</colgroup>
	<thead>
		<tr>
			<th scope="row" colspan="4" class="clearfix">
				<c:choose>
					<c:when test="${boardInfo.cat_yn == 'Y' }">
						<p>[ ${view.cat_nm} ] ${suf:clearXSS(view.title, '')}</p>
					</c:when>
					<c:otherwise>
						<p>${suf:clearXSS(view.title, '')}</p>
					</c:otherwise>
				</c:choose>
				<ul>
					<li class="line"><b>작성자</b>${(view.member_id == '' || view.member_id == null) ? view.reg_nm : view.member_id}</li>
					<li class="line"><b>작성일</b>${view.reg_dt}</li>
					<li><b>조회수</b>51</li>
				</ul>
			</th>
		</tr>
	</thead>
	<tbody>
		<tr>
		  <td colspan="4" class="contents">
		  	<div class="conts">
		  	${fn:replace(fn:replace(view.conts, '<script>', '&lt;script&gt;'), '</script>', '&lt;/script&gt;')}
		  	</div>
			<c:if test="${fn:length(data.files) > 0 }">
				<div class="file">
				  <p>첨부파일</p>
				  	<ul>
				  	<c:forEach items="${data.files }" var="files" varStatus = "status">
					  	<li>
						  	<a href="<c:url value="/download.do"/>?uuid=${files.uuid }" target="_blank" title="첨부파일${count}">${files.attach_nm}</a>&nbsp;
						  	<c:set var="count" value="${count + 1}" scope="page"/>
					  	</li>
				  	</c:forEach>
				  	</ul>
				</div>
			</c:if>
		  </td>
		</tr>
	</tbody>
</table>

<%-- 태그 --%>
<c:if test="${boardInfo.tag_yn == 'Y'}">
	<c:if test="${!empty view.tag_names }">
		<div class="tag">
			<p>태그</p>
			<div>
				<c:set var="tag_list" value="${fn:split(view.tag_names, ',') }" />
				<c:forEach var="item" items="${tag_list }">
				<span>${item }</span>
				</c:forEach>
			</div>
		</div>
	</c:if>
</c:if>

<%-- 저작권표시 --%>
<c:if test="${suf:inArray(fn:split('C,P,A', ','), boardInfo.cclnuri_yn)}">
	<c:if test="${!empty view.ccl_type || !empty view.nuri_type}">
		<div class="copyright">
			<c:choose>
				<c:when test="${view.ccl_type eq '1' }">
					<span><img src="/images/sub/ccl_mark_01.gif" alt="저작자표시 4.0 국제"></span>
				</c:when>
				<c:when test="${view.ccl_type eq '2' }">
					<span><img src="/images/sub/ccl_mark_02.gif" alt="저작자표시-변경금지 4.0 국제"></span>
				</c:when>
				<c:when test="${view.ccl_type eq '3' }">
					<span><img src="/images/sub/ccl_mark_03.gif" alt="저작자표시-동일조건변경허락 4.0 국제"></span>
				</c:when>
				<c:when test="${view.ccl_type eq '4' }">
					<span><img src="/images/sub/ccl_mark_04.gif" alt="저작자표시-비영리 4.0 국제"></span>
				</c:when>
				<c:when test="${view.ccl_type eq '5' }">
					<span><img src="/images/sub/ccl_mark_05.gif" alt="저작자표시-비영리-변경금지 4.0 국제"></span>
				</c:when>
				<c:when test="${view.ccl_type eq '6' }">
					<span><img src="/images/sub/ccl_mark_06.gif" alt="저작자표시-비영리-동일조건변경허락 4.0 국제"></span>
				</c:when>
			</c:choose>
			
			<c:choose>
				<c:when test="${view.nuri_type eq '1' }">
					<span><img src="/images/sub/kogl_mark_01.gif" alt="출처표시 / 상업적, 비상업적 이용가능 / 변형 등 2차적 저작물 작성 가능"></span>
				</c:when>
				<c:when test="${view.nuri_type eq '2' }">
					<span><img src="/images/sub/kogl_mark_02.gif" alt="출처표시 / 비상업적 이용만 가능 / 변형 등 2차적 저작물 작성 가능"></span>
				</c:when>
				<c:when test="${view.nuri_type eq '3' }">
					<span><img src="/images/sub/kogl_mark_03.gif" alt="출처표시 / 상업적, 비상업적 이용가능 / 변형 등 2차적 저작물 작성금지"></span>
				</c:when>
				<c:when test="${view.nuri_type eq '4' }">
					<span><img src="/images/sub/kogl_mark_04.gif" alt="출처표시 / 비상업적 이용만 가능 / 변형 등 2차적 저작물 작성 금지"></span>
				</c:when>
			</c:choose>
		</div>
	</c:if>
</c:if>

<div class="btn_area">
	<div class="right">
	<c:if test="${(sessionScope.member != null && sessionScope.member.member_id == view.reg_id) || view.password != null}">
		<a class="v1" href="javascript:del('${view.article_seq}', '${suf:requestReplace(params.cpage, '')}', '${suf:requestReplace(params.rows, '')}', '${suf:requestReplace(params.condition, '')}', '${suf:requestReplace(params.keyword, '')}')">삭제</a>
		<a class="v2"  href="modifyForm.do?article_seq=${view.article_seq }&amp;cpage=${suf:requestReplace(params.cpage , '')}&amp;rows=${suf:requestReplace(params.rows , '')}&amp;condition=${suf:requestReplace(params.condition , '')}&amp;keyword=${suf:requestReplace(params.keyword , '')}">수정</a>
	</c:if>
		<a class="v3"  href="list.do?cpage=${suf:requestReplace(params.cpage , '')}&amp;rows=${suf:requestReplace(params.rows , '')}&amp;condition=${suf:requestReplace(params.condition , '')}&amp;keyword=${suf:requestReplace(params.keyword , '')}&amp;cat=${suf:requestReplace(params.cat, '')}">목록으로</a>
	</div>
</div>

<table class="board_nav">
	<caption>이전,다음 게시물 목록을 볼 수 있습니다.</caption>
	<colgroup>
		<col style="width:100px"/>
		<col/>
	</colgroup>
	<tbody>
		<tr>
		  <th scope="row">이전글</th>
		  <td>
			  <c:choose>
			  <c:when test="${prev.article_seq eq null}">이전 글이 없습니다.</c:when>
			  <c:otherwise><a href="view.do?mode=view&amp;article_seq=${prev.article_seq }&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }">${suf:clearXSS(prev.title, '')}</a></c:otherwise>
			  </c:choose>
		  </td>
		</tr>
		<tr>
		  <th scope="row">다음글</th>
		  <td>
			  <c:choose>
			  <c:when test="${next.article_seq eq null}">다음 글이 없습니다.</c:when>
			  <c:otherwise><a href="view.do?mode=view&amp;article_seq=${next.article_seq }&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }">${suf:clearXSS(next.title, '')}</a></c:otherwise>
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