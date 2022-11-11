<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>

<%-- <c:set var="thumb_type" value="tile"/> --%>
<%-- <c:set var="thumb_type" value="list"/> --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<c:if test="${pagination.search_yn == 'N'}"><meta name="robots" content="noindex,nofollow"/></c:if>
<script type="text/javascript" src="<c:url value="/lib/js/bbs.js"/>"></script>
<script type = "text/javascript">
function go_board_list(){
	jQuery("#articleSearchForm > input[name=rows]").val(jQuery("#rowsSel").val());
	jQuery("#articleSearchForm").submit();
}
</script>
</head>
<body>
<c:out value="${boardInfo.conts }" escapeXml="false"></c:out>

<div class="board_util">
	<p class="hit">총 <b>${pagination.totalcount}</b>건 (<b>${params.cpage }</b>/<fmt:formatNumber value="${pagination.totalpage }" type="number"/> 페이지)</p>
	<div class="sch_box">
		<c:if test="${pagination.cat_yn == 'Y' }">
		<select onchange="pageCat(this.value);" title="전체 또는 카테고리 선택을 통해 게시물을 분류할 수 있습니다." class="sel_style1">
			<option value="" <c:if test="${params.cat eq '' }">selected="selected"</c:if>>전체</option>
			<c:forEach var="cat" items="${catlist }">
			<option value="${cat.board_cat_seq }" <c:if test="${params.cat eq cat.board_cat_seq }">selected="selected"</c:if>>${cat.cat_nm }</option>
			</c:forEach>
		</select>
		</c:if>
		<select onchange="go_board_list();" title="건별보기를 선택하시면 해당 페이지 리스트 갯수를 설정하실 수 있습니다." id="rowsSel" class="sel_style1">
			<c:set var="rows_array" value="${fn:split(boardInfo.rows_text, ',') }"/>
			<c:forEach var="item" items="${rows_array }">
				<option value="${item }" <c:if test="${params.rows eq item }">selected="selected"</c:if>>${item }건씩 보기</option>
			</c:forEach>
		</select>
		<form action="list.do" name="articleSearchForm" id="articleSearchForm" method="get" onsubmit="return goPage(1);">
			<input type="hidden" name="rows" value="${params.rows}"/>
			<input type="hidden" name="cpage" value="${params.cpage }" />
			<input type="hidden" name="cat" value="${params.cat }"/>
			<input type="hidden" name="article_seq" />
			<input type="hidden" name="thumb_type" value="${params.thumb_type }"/>
			<div>
				<select name="condition" title="검색조건 선택" class="sel_style1">
					<option value="TITLE" <c:if test="${params.condition eq 'TITLE' }">selected="selected"</c:if>>제목</option>
					<option value="REG_NM" <c:if test="${params.condition eq 'REG_NM' }">selected="selected"</c:if>>작성자</option>
					<option value="COMMENT_NM" <c:if test="${param.condition eq 'COMMENT_NM' }">selected="selected"</c:if>>댓글작성자</option>
					<option value="CONTS" <c:if test="${params.condition eq 'CONTS' }">selected="selected"</c:if>>내용</option>
					<option value="TAGNAME" <c:if test="${params.condition eq 'TAGNAME' }">selected="selected"</c:if>>태그</option>
				</select>			
				<span><input type="text" class="input_2" name="keyword" value="${params.keyword}" title="검색바" placeholder="검색어를 입력해 주세요."/></span>
				<input type="submit" value="검색"/>
			</div>
		</form>
	</div>
</div>
	
</div>

<c:if test="${boardInfo.thumb_type == 'T' || params.thumb_type == 'T'}">
<div class="board_list2">
	<ul class="clearfix">
		<c:if test="${empty list }">
		<li style="float:none;width:100%;text-align:center;padding:0px;border:0">등록 된 게시물이 없습니다.</li>
		</c:if>
		<c:forEach items="${list }" var="item" varStatus = "status">
		<li>
			<a href="view.do?article_seq=${item.article_seq }&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }">
				<p class="num">99</p>
				<div class="img"><img src="${item.thumb}" alt="${suf:clearXSS(item.title, '')}"/></div>
				<div class="txt">
					<p  class="tit">
						<c:if test="${item.notice_yn == 'Y' }"><img src="/images/super/notice.png" style="width:31px; height:18px;" alt="공지"/></c:if>
						<c:if test="${pagination.cat_yn == 'Y' }"><td>[${item.cat_nm }]</td></c:if>
						${suf:clearXSS(item.title, '')} <c:if test="${item.public_yn == 'N' }"><img src="/images/board/style01_mp.gif" alt="비공개" style="margin-left:5px;width:11px;height:12px;border:0;"></c:if>
						<c:if test="${item.comment_cnt > 0}"> (${item.comment_cnt })</c:if>
					</p>
					<span>${item.reg_dt }</span>
				</div>
			</a>
		</li>
		</c:forEach>
	</ul>
</div>
</c:if>
<jsp:include page="/share/paging.do">
	<jsp:param name="cpage" value="${params.cpage }"/>
	<jsp:param name="rows" value="${params.rows }"/>
	<jsp:param name="totalpage" value="${pagination.totalpage }"/>
</jsp:include>
<c:if test="${pagination.insert_yn=='Y' }">
	<div class="btn_area">
		<div class="right">
			<a href="insertForm.do" class="v1">글쓰기</a>
		</div>
	</div>
</c:if>
</body>
</html>

