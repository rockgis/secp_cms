<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<c:set var="view" value="${data.view }"/>
<c:set var="prev" value="${data.prev }"/>
<c:set var="next" value="${data.next }"/>
<c:set var="colspan" value="0"/>
<c:set var="conts_element" value=""/>
<c:set var="conts_yn" value="N"/>
<c:set var="title_element" value=""/>
<c:set var="title_yn" value="N"/>
<c:set var="count" value="1"/>
<c:forEach items="${custom }" var="item" varStatus="status">
	<%--<c:if test="${item.column_name == 'title' }">
		<c:set var="title_element" value="${item.element }"/>
		<c:set var="title_yn" value="Y"/>					
	</c:if>--%>
	<c:if test="${item.column_name == 'conts' }">
		<c:set var="conts_element" value="${item.element }"/>
		<c:set var="conts_yn" value="Y"/>					
	</c:if>
	 <%--<c:if test="${item.column_name == 'reg_dt' }">
		<c:set var="colspan" value="2"/>					
	</c:if> --%>
</c:forEach>
<html>
<head>
<c:if test="${boardInfo.search_yn == 'N'}"><meta name="robots" content="noindex,nofollow"/></c:if>
<script type="text/javascript" src="<c:url value="/lib/js/bbs.js"/>"></script>
</head>
<body>
<c:out value="${boardInfo.conts }" escapeXml="false"></c:out>
<%-- 
<div class="view_option">
	<form id="reportFrm" name="reportFrm" action="<c:url value="/userreport/userReport.do"/>" method="post">
		<input type="hidden" name="article_seq" value="${view.article_seq }"/>
		<input type="hidden" name="board_seq" value="${view.board_seq }"/>
		<div>
			<input type="image" class="report" src="/images/board/report_off.gif" alt="신고하기" />
		</div>
		<div class="report_insert">
			<textarea name="reportconts" id="reportconts"></textarea>
			<a href="javascript:userReport()"><span>신고</span></a>
		</div>
	</form>
</div>
 --%>
<table class="board_view">
	<colgroup>
		<col style="width:15%"/>
		<col/>
		<c:if test="${colspan > 0 }">
			<col style="width:15%"/>
		</c:if>
	</colgroup>
	<%-- <c:if test="${title_yn == 'Y' }">제목 필드
		<thead>
			<tr>
	  			<th scope="row" class="c1">${title_element }</th>
	  			<td class="title">${view.title}</td>
	  			<c:if test="${colspan > 0 }">
	  				<td class="title">${view.reg_dt}</td>
	  			</c:if>
			</tr>
		</thead>
	</c:if> --%>
	
	
	<tbody>
		<c:forEach items="${custom }" var="item" varStatus="status">
			<c:set var="view_yn" value="Y"/>
			<c:forEach items="${notViews }" var="notView" varStatus="notStatus">
				<c:if test="${item.column_name == notView }">
					<c:set var="view_yn" value="N"/>					
				</c:if>
				<%-- <c:if test="${item.column_name == 'cat_nm' && (fn:length(cat) == 0 || empty cat)}">
					<c:set var="view_yn" value="N"/>					
				</c:if> --%>
			</c:forEach>
			<c:if test="${view_yn == 'Y' }">
				<tr>
					<th scope="row">${item.element }</th>
					<c:choose>
						<c:when test="${item.column_name == 'public_yn' }"><td><c:if test="${view.public_yn == 'Y' }">공개</c:if><c:if test="${view.public_yn == 'N' }">비공개</c:if></td></c:when>
						<c:when test="${item.column_name == 'notice_yn' }"><td><c:if test="${view.notice_yn == 'N' }">일반</c:if><c:if test="${view.notice_yn == 'Y' }">공지</c:if></td></td></c:when>
						<c:when test="${item.column_name == 'tel' }"><td>${view.tel }</td></c:when>
						<c:when test="${item.column_name == 'cell' }"><td>${view.cell }</td></c:when>
						<c:when test="${item.column_name == 'email' }"><td>${view.email }</td></c:when>
						<%-- <c:when test="${item.column_name == 'conts' }"><td colspan="2" class="contents">${view.conts}</td></c:when> --%>
						
						<c:otherwise>
							<%-- <td><input type="text" id="${item.column_name }" name="${item.column_name }" class="input_1" value="${view[item.column_name] }"/></td> --%>
							<td<c:if test="${colspan > 0 }"> colspan="${colspan }"</c:if>>${view[item.column_name]}</td>
						</c:otherwise>
					</c:choose>
				</tr>
			</c:if>
		</c:forEach>
		
		<c:if test="${conts_yn == 'Y' }">
			<tr>
				<%-- <th scope="row">${conts_element }</th> --%>
				<%-- <td <c:if test="${colspan > 0 }"> colspan='${colspan }'</c:if> class="contents">${view.conts}</td> --%>
				<td colspan="2" class="contents">${fn:replace(fn:replace(view.conts, '<script>', '&lt;script&gt;'), '</script>', '&lt;/script&gt;')}</td>
			</tr>
		</c:if>
		
		<c:if test="${view.file_yn == 'Y' }">
			<c:if test="${fn:length(data.files) > 0 }"><%-- 파일 다운로드 --%>
				<tr>
	  				<th scope="row">파일</th>
	  				<td<c:if test="${colspan > 0 }"> colspan="${colspan }"</c:if>>
	  					<c:forEach items="${data.files }" var="files" varStatus = "status">
	  						<a class="file_link" href="<c:url value="/download.do"/>?uuid=${files.uuid }" target="_blank" title="첨부파일${count}">${files.attach_nm}</a><br />
	  						<c:set var="count" value="${count + 1}" scope="page"/>
	  					</c:forEach>
	  				</td>
				</tr>
			</c:if>
		</c:if>
	</tbody>
</table>

<div class="btn_area">
	<div class="right">
	<c:if test="${(sessionScope.member != null && sessionScope.member.member_id == view.reg_id) || view.password != null}">
		<a class="v1" href="javascript:del('${view.article_seq}', '${suf:requestReplace(params.cpage, '')}', '${suf:requestReplace(params.rows, '')}', '${suf:requestReplace(params.condition, '')}', '${suf:requestReplace(params.keyword, '')}')">삭제</a>
		<a class="v2"  href="modifyForm.do?article_seq=${view.article_seq }&amp;cpage=${suf:requestReplace(params.cpage , '')}&amp;rows=${suf:requestReplace(params.rows , '')}&amp;condition=${suf:requestReplace(params.condition , '')}&amp;keyword=${suf:requestReplace(params.keyword , '')}">수정</a>
	</c:if>
		<a class="v3"  href="list.do?cpage=${suf:requestReplace(params.cpage , '')}&amp;rows=${suf:requestReplace(params.rows , '')}&amp;condition=${suf:requestReplace(params.condition , '')}&amp;keyword=${suf:requestReplace(params.keyword , '')}&amp;cat=${suf:requestReplace(params.cat, '')}">목록으로</a>
	</div>
</div>

<c:if test="${boardInfo.tag_yn == 'Y' }">
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