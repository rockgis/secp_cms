<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<c:if test="${pagination.search_yn == 'N'}"><meta name="robots" content="noindex,nofollow"/></c:if>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script type="text/javascript" src="/lib/js/bbs.js"></script>

<script type = "text/javascript">
function go_board_list(){
	jQuery("#articleSearchForm > input[name=rows]").val(jQuery("#rowsSel").val());
	jQuery("#articleSearchForm").submit();
}

</script>

</head>
<body>
<c:out value="${boardInfo.conts }" escapeXml="false"></c:out>

<div class="sch_box">
	<form action="list.do" name="articleSearchForm" id="articleSearchForm" method="get" onsubmit="return goPage(1);">
		<input type="hidden" name="rows" value="${params.rows}"/>
		<input type="hidden" name="cpage" value="${params.cpage }" />
		<input type="hidden" name="cat" value="${params.cat }"/>
		<input type="hidden" name="article_seq" />
		<div>  
			<select name="condition" title="검색조건 선택">
				<option value="TITLE" <c:if test="${params.condition eq 'TITLE' }">selected="selected"</c:if>>제목</option>
				<option value="REG_NM" <c:if test="${params.condition eq 'REG_NM' }">selected="selected"</c:if>>작성자</option>
				<option value="COMMENT_NM" <c:if test="${param.condition eq 'COMMENT_NM' }">selected="selected"</c:if>>댓글작성자</option>
				<option value="CONTS" <c:if test="${params.condition eq 'CONTS' }">selected="selected"</c:if>>내용</option>
				<option value="TAGNAME" <c:if test="${params.condition eq 'TAGNAME' }">selected="selected"</c:if>>태그</option>
			</select>
			<span><input type="text" name="keyword" value="${params.keyword}" title="검색바" /></span>
			<input type="image" src="<c:url value="/images/article/sch_btn.gif"/>" name="image" alt="검색"/>
		</div>
	</form>
</div>

<div class="list_option">
	<p class="hit">전체 : ${pagination.totalcount} (<b>${params.cpage }</b>/<fmt:formatNumber value="${pagination.totalpage }" type="number"/> page)</p>
	<div>
		<select title="건별보기를 선택하시면 해당 페이지 리스트 갯수를 설정하실 수 있습니다." id="rowsSel">
			<c:set var="rows_array" value="${fn:split(boardInfo.rows_text, ',') }"/>
			<c:forEach var="item" items="${rows_array }">
				<option value="${item }" <c:if test="${params.rows eq item }">selected="selected"</c:if>>${item }건씩 보기</option>
			</c:forEach>
		</select>
		<a href = "javascript:go_board_list();"><img src="/images/sub/move_btn.gif" alt="이동"/></a>
	</div>
	<c:if test="${pagination.cat_yn == 'Y' }">
	<div>
		<select class="" onchange="pageCat(this.value);">
			<option value="" <c:if test="${params.cat eq '' }">selected="selected"</c:if>>전체</option>
			<c:forEach var="cat" items="${catlist }">
			<option value="${cat.board_cat_seq }" <c:if test="${params.cat eq cat.board_cat_seq }">selected="selected"</c:if>>${cat.cat_nm }</option>
			</c:forEach>
		</select>
	</div>
	</c:if>
</div>
<table class="list_style_1">
	<caption></caption>
	<colgroup>
		<col width="9%" class="none"/>
		<c:if test="${pagination.cat_yn == 'Y' }"><col width="12%" /></c:if>
		<col width="" />
		<col width="12%" />
		<col width="12%" class="none"/>
		<col width="13%" class="none"/>
	</colgroup>
	<thead>
		<tr>
			<th scope="col" class="none">번호</th>
			<c:if test="${pagination.cat_yn == 'Y' }"><th scope="col">카테고리</th></c:if>
			<th scope="col">제목</th>
			<th scope="col">작성자</th>
			<th scope="col" class="none">파일</th>
			<th scope="col" class="none">작성일</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach items="${notice_list }" var="item" varStatus = "status">
		<tr>
			<td class="none">
				<img src="/images/super/notice.png" alt="공지"/>
			</td>			
			<c:if test="${pagination.cat_yn == 'Y' }"><td>${item.cat_nm }</td></c:if>
			<td class="title">
			<a href="view.do?article_seq=${item.article_seq }&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }">
			${suf:clearXSS(item.title, '')}<c:if test="${item.public_yn == 'N' }"><img src="/images/article/style01_mp.gif" alt="비공개" style="margin-left: 5px;"></c:if><c:if test="${item.comment_cnt > 0}"> (${item.comment_cnt })</c:if>
			</a>
			</td>
			<td>${(item.member_id == '' || item.member_id == null) ? item.reg_nm : item.member_id}</td>
			<td class="none">
			<c:if test="${item.attach_cnt>0}">
				<img src="/images/article/file.gif" alt="첨부파일" /><span>(${item.attach_cnt })</span>
			</c:if>
			</td>		
			<td class="none">${item.reg_dt }</td>
		</tr>
	</c:forEach>
	<c:if test="${empty list }">
		<tr>
			<c:if test="${pagination.cat_yn == 'Y' }"><td colspan="6">등록 된 게시물이 없습니다.</td></c:if>
			<c:if test="${pagination.cat_yn == 'N' }"><td colspan="5">등록 된 게시물이 없습니다.</td></c:if>
		</tr>
	</c:if>
	<c:forEach items="${list }" var="item" varStatus = "status">
		<tr>
			<td class="none">
				${pagination.totalcount - item.rn + 1}
			</td>			
			<c:if test="${pagination.cat_yn == 'Y' }"><td>${item.cat_nm }</td></c:if>
			<td class="title">
			<a href="view.do?article_seq=${item.article_seq }&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }">
			${suf:clearXSS(item.title, '')}<c:if test="${item.public_yn == 'N' }"><img src="/images/article/style01_mp.gif" alt="비공개" style="margin-left: 5px;"></c:if><c:if test="${item.comment_cnt > 0}"> (${item.comment_cnt })</c:if>
			</a>
			</td>
			<td>${(item.member_id == '' || item.member_id == null) ? item.reg_nm : item.member_id}</td>
			<td class="none">
				<c:if test="${item.attach_cnt>0}">
					<img src="/images/article/file.gif" alt="첨부파일" /><span>(${item.attach_cnt })</span>
				</c:if>
			</td>		
			<td class="none">${item.reg_dt }</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
<c:if test="${pagination.insert_yn=='Y' }">
	<div class="btn_type1">
		<div class="right">
			<a href="insertForm.do">등록</a>
		</div>
	</div>
</c:if>

<jsp:include page="/share/paging.do">
	<jsp:param name="cpage" value="${params.cpage }"/>
	<jsp:param name="rows" value="${params.rows }"/>
	<jsp:param name="totalpage" value="${pagination.totalpage }"/>
</jsp:include>
</body>
</html>

