<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>${data.title }</title>
<link rel="stylesheet" href="<c:url value="/lib/css/board.css"/>" type="text/css" />
<script type="text/javascript" src="<c:url value="/lib/js/mc.js"/>"></script>

</head>
<body>
<div class="board_util">
	<div class="sch_box">
		<form action="list.do" name="articleSearchForm" id="articleSearchForm" method="get" >
			<input type="hidden" name="rows" value="${params.rows}"/>
			<input type="hidden" name="cpage" value="${params.cpage }" />
			<input type="hidden" name="poll_seq" />
			<select name="condition" title="건별보기를 선택하시면 해당 페이지 리스트 갯수를 설정하실 수 있습니다." class="sel_style1">
				<option value="TITLE" <c:if test="${params.condition eq 'TITLE' }">selected="selected"</c:if>>제목</option>
			</select>
			<input type="text" id="keyword" name="keyword" value="${param.keyword}" title="검색바" placeholder="검색어를 입력해주세요." />
			<input type="submit" value="검색" alt="검색" />
		</form>
	</div>
</div>
<!--<div class="list_option">
	<p class="hit">전체 : ${pagination.totalcount} (<b>1</b>/3 page)</p>
	<div>
		<select onchange="pageRows(this.value);">
			<option value="10" <c:if test="${params.rows eq '10' }">selected="selected"</c:if>>10건씩 보기</option>
			<option value="20" <c:if test="${params.rows eq '20' }">selected="selected"</c:if>>20건씩 보기</option>
			<option value="50" <c:if test="${params.rows eq '50' }">selected="selected"</c:if>>50건씩 보기</option>
		</select>
		<a href = "javascript:go_board_list();"><img src="/images/sub/move_btn.gif" alt="이동"/></a>
	</div>
</div>-->



<table class="board_list1">
	<caption>설문조사 리스트로 번호, 제목, 설문기간, 상태, 설문권한 정보를 제공하며 제목 링크를 통해 상세페이지로 이동합니다. </caption>
	<colgroup>
		<col class="col_id hide-for-mobile" />
		<col class="col_title" />
		<col class="col_period" />
		<col class="col_status" />
		<col class="col_status" />
	</colgroup>
	<thead>
		<tr>
			<th scope="col" class="hide-for-mobile">번호</th>
			<th scope="col">제목</th>
			<th scope="col">참여기간</th>
			<th scope="col">상태</th>
			<th scope="col">설문권한</th>
		</tr>
	</thead>
	<tbody>
	<c:if test="${empty data.list }">
		<tr>
			<td colspan="5">등록 된 설문이 없습니다.</td>
		</tr>
	</c:if>
	<c:forEach items="${data.list }" var="item" varStatus = "status">
		<tr>
			<td class="hide-for-mobile">${data.pagination.totalcount - item.rn + 1}</td>
			<td class="tit">
				<c:choose>
					<c:when test="${item.stat_num == '1' }"><a href="joinForm.do?poll_seq=${item.poll_seq }&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }">${suf:clearXSS(item.title, '')}</a></c:when>
					<c:when test="${item.stat_num == '2' }"><a href="result.do?poll_seq=${item.poll_seq }&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }">${suf:clearXSS(item.title, '')}</a></c:when>
					<c:otherwise>${suf:clearXSS(item.title, '')}</c:otherwise>
				</c:choose>
			</td>
			<td>${dtf:simpleDateFormat(item.start_dt,'yyyy-MM-dd','yy.MM.dd') } ~ ${dtf:simpleDateFormat(item.end_dt,'yyyy-MM-dd','yy.MM.dd') }</td>
			<td>
				<c:choose>
					<c:when test="${item.stat_num == '1' }">
						<a href="joinForm.do?poll_seq=${item.poll_seq }&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }">${item.stat }</a>
					</c:when>
					<c:otherwise>
						<a href="result.do?poll_seq=${item.poll_seq }&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }">${item.stat }</a>
					</c:otherwise>
				</c:choose>
			</td>		
			<td>
				<c:choose>
					<c:when test="${item.stat_num == '1' }">
						<a href="joinForm.do?poll_seq=${item.poll_seq }&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }">${item.cud == 'true' ? '참여가능' : '참여불가' }</a> 
					</c:when>
					<c:otherwise>
						<a href="result.do?poll_seq=${item.poll_seq }&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }">참여불가</a>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>

<jsp:include page="/share/paging.do">
	<jsp:param name="cpage" value="${param.cpage }"/>
	<jsp:param name="rows" value="${param.rows }"/>
	<jsp:param name="totalpage" value="${data.pagination.totalpage }"/>
</jsp:include>
</body>
</html>