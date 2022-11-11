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
		<div>  
			<select name="condition" title="검색조건 선택" class="sel_style1">
				<option value="TITLE" <c:if test="${params.condition eq 'TITLE' }">selected="selected"</c:if>>제목</option>
				<option value="REG_NM" <c:if test="${params.condition eq 'REG_NM' }">selected="selected"</c:if>>작성자</option>
				<option value="COMMENT_NM" <c:if test="${param.condition eq 'COMMENT_NM' }">selected="selected"</c:if>>댓글작성자</option>
				<option value="CONTS" <c:if test="${params.condition eq 'CONTS' }">selected="selected"</c:if>>내용</option>
				<option value="TAGNAME" <c:if test="${params.condition eq 'TAGNAME' }">selected="selected"</c:if>>태그</option>
			</select>
			<span><input type="text" name="keyword" value="${params.keyword}" title="검색바" placeholder="검색어를 입력해 주세요."/></span>
			<input type="submit" value="검색"/>
		</div>
	</form>
	</div>
</div>
<%-- 
<div class="list_option">	
	<div>
		<select title="건별보기를 선택하시면 해당 페이지 리스트 갯수를 설정하실 수 있습니다." id="rowsSel" name="rowsSel" class="select_1 ws_1">
			<c:forEach var="itemrow" items="${rowlist }" varStatus="i">
				<option value="${itemrow.code }"<c:if test="${itemrow.code == params.rows}"> selected="selected"</c:if>>${itemrow.code_nm }</option>
			</c:forEach>
		</select>
		<a href = "javascript:go_board_list();" class="move">이동</a>
	</div>
	<c:if test="${pagination.cat_yn == 'Y' }">
	<div>
		<select onchange="pageCat(this.value);" title="전체 또는 카테고리 선택을 통해 게시물을 분류할 수 있습니다.">
			<option value="" <c:if test="${params.cat eq '' }">selected="selected"</c:if>>전체</option>
			<c:forEach var="cat" items="${data.catlist }">
			<option value="${cat.board_cat_seq }" <c:if test="${params.cat eq cat.board_cat_seq }">selected="selected"</c:if>>${cat.cat_nm }</option>
			</c:forEach>
		</select>
	</div>
	</c:if>
</div>
 --%>
<table class="board_list1">
	<caption>
		<strong>${suf:clearXSS(boardInfo.title, '')} 목록</strong>
		<p>${suf:clearXSS(boardInfo.title, '')} 게시판 목록이며 번호,구분,제목,파일,작성일을 제공하고 제목 링크를 통해 상세페이지로 이동합니다.</p>
	</caption>
	<colgroup>
			<c:set var="colspan" value="0"/>
			<c:forEach items="${data.custom }" var="item" varStatus="status">
				<c:set var="view_yn" value="Y"/>
				<c:forEach items="${data.notViews }" var="notView" varStatus="notStatus">
					<c:if test="${item.column_name == notView }">
						<c:set var="view_yn" value="N"/>					
					</c:if>
					<c:if test="${item.column_name == 'cat_nm' && (fn:length(data.catlist) == 0 || empty data.catlist)}">
						<c:set var="view_yn" value="N"/>					
					</c:if>
				</c:forEach>
				<c:if test="${view_yn == 'Y'}">
					<c:set var="colspan" value="${colspan+1}"/>
					<col width="${item.user_list_col == null || item.user_list_col == '' ? '*' : item.user_list_col }"/>
				</c:if>						
			</c:forEach>
			
			<c:if test="${data.boardInfo.file_yn=='Y'}">
				<col width="10%" class="none"/>
			</c:if>
			
		</colgroup>
		
		
		<thead>
			<tr>
				<c:forEach items="${data.custom }" var="item" varStatus="status">
					<c:set var="view_yn" value="Y"/>
					<c:forEach items="${data.notViews }" var="notView" varStatus="notStatus">
						<c:if test="${item.column_name == notView }">
							<c:set var="view_yn" value="N"/>					
						</c:if>
						<c:if test="${item.column_name == 'cat_nm' && (fn:length(data.catlist) == 0 || empty data.catlist)}">
							<c:set var="view_yn" value="N"/>					
						</c:if>
					</c:forEach>
					<c:if test="${view_yn == 'Y'}">
						<th scope="col">${item.element }</th>						
					</c:if>
				</c:forEach>
				
				<c:if test="${data.boardInfo.file_yn=='Y'}">
					<th scope="col" class="none">파일</th>
				</c:if>
				
			</tr>
		</thead>
		
		
		<tbody>
			<c:if test="${empty data.list }">
				<tr>
					<c:if test="${data.boardInfo.file_yn=='Y'}">
						<td colspan="${colspan + 1 }">등록된 게시물이 없습니다.</td>
					</c:if>
					<c:if test="${data.boardInfo.file_yn=='N'}">
						<td colspan="${colspan }">등록된 게시물이 없습니다.</td>
					</c:if>
					
				</tr>
			</c:if>
			<c:forEach items="${data.list }" var="article" varStatus="status">
				<tr>
					<c:forEach items="${data.custom }" var="item" varStatus="status">
						<c:set var="view_yn" value="Y"/>
						<c:forEach items="${data.notViews }" var="notView" varStatus="notStatus">
							<c:if test="${item.column_name == notView }">
								<c:set var="view_yn" value="N"/>					
							</c:if>
							<c:if test="${item.column_name == 'cat_nm' && (fn:length(data.catlist) == 0 || empty data.catlist)}">
								<c:set var="view_yn" value="N"/>					
							</c:if>
						</c:forEach>
						<c:if test="${view_yn == 'Y' }">
							<c:choose>
								<c:when test="${item.column_name == 'rn' }">
									<c:choose>
										<c:when test="${article.notice_yn == 'Y' }">
											<td><img src="<c:url value="/images/super/notice.png"/>" alt="공지"/></td>
										</c:when>
										<c:otherwise>
											<td>${pagination.totalcount - article.rn + 1}</td>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:when test="${item.column_name == 'public_yn' }">
									<c:choose>
										<c:when test="${article.public_yn == 'N' }">
											<td>비공개</td>
										</c:when>
										<c:otherwise>
											<td>공개</td>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:when test="${item.column_name == 'title' }">
									<!-- <td class="table_c left"> -->
									<td class="title">
										<a href="view.do?article_seq=${article.article_seq }&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }&amp;show=${params.show }&amp;cat=${params.cat}">
											${suf:clearXSS(article.title, '')}<c:if test="${article.comment_cnt > 0}"> ( ${article.comment_cnt } )</c:if>
											<c:if test="${article.public_yn == 'N' }"><img src="/images/board/style01_mp.gif" alt="비공개" style="margin-left: 5px;"></c:if>
										</a>
									</td>
								</c:when>								
								<c:when test="${item.column_name == 'conts' }">
									<!-- <td class="table_c left"> -->
									<td>
										${suf:clearXSS(article.conts, '')}
									</td>
								</c:when>
								<c:when test="${item.column_name == 'thumb' }">
									<td>
										<c:choose>
											<c:when test="${article.thumb != null && article.thumb != '' }">
												<img src="${article.thumb }" alt="${suf:clearXSS(article.title, '')}_썸네일 이미지" style="width:100px;height:100px;"/>
											</c:when>
											<c:otherwise>
												<%-- <img src="<c:url value="/images/common/noimg.gif"/>" alt="이미지 없음"/> --%>
											</c:otherwise>
										</c:choose>
									</td>
								</c:when>
								<c:otherwise>
									<td>${article[item.column_name] }</td>
								</c:otherwise>
							</c:choose>
						</c:if>
					</c:forEach>
					
					<c:if test="${data.boardInfo.file_yn=='Y'}">
					<td class="none">
						<c:if test="${item.attach_cnt>0}">
							<img src="/images/board/file.gif" alt="첨부파일" /><span>(${item.attach_cnt })</span>
						</c:if>
					</td>
					</c:if>
					
			
				</tr>
			</c:forEach>
		</tbody>
</table>
<c:if test="${pagination.insert_yn=='Y' }">
	<div class="btn_area">
		<div class="right">
			<a href="insertForm.do" class="v1">글쓰기</a>
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

