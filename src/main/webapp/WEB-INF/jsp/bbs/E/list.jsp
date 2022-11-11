<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE HTML>
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
<script type="text/javascript">
var x = null;
$(document).ready(function(){
	var article_seq = $('input[name=article_seq]').val();
	if(article_seq != null || article_seq != "") { // 메인 페이지에서 게시물을 선택함
		var dom = $("a[data-seq='" + article_seq + "']");
		var next_tr = $(dom).parents("tr").next();
		$(next_tr).show(0);
		$(next_tr).find("div.answer_s").css("min-height","44px");
		$(next_tr).find(".answer_s").slideDown(0);
	}
	
	$(".question").click(function(e){
		e.preventDefault();
		//$(".faq_click").css("background","url(/images/board/open_arr.gif) 98% center no-repeat");
		//$(this).find(">td>a").css("background","url(/images/board/close_arr.gif) 98% center no-repeat");
		var answer = $(".answer");
		var next_tr = $(this).next();
		var current = $(this);
		
		
		$.each(answer,function(){
			if(current.find("td:eq(0)").html() != $(this).prev().find("td:eq(0)").html()){
				$(this).find(".answer_s").slideUp(500);
				$(this).hide(600);
			}
		});
		
		if($(next_tr).css("display")=="none"){
			$(next_tr).show(600);
			$(next_tr).find(".answer_s").slideDown(500);
			$(this).find("span").addClass("on").html("열림");
			$(this).siblings().find("span").html("닫힘").removeClass();
			$(".question td").removeClass("on");
			$(current).children('td').addClass("on");
		}else{
			//$(this).find(">td>a").css("background","url(/images/board/open_arr.gif) 98% center no-repeat");
			$(next_tr).find(".answer_s").slideUp(500);
			$(next_tr).hide(600);
			$(this).find("span").html("닫힘").removeClass();
			$(".question td").removeClass("on");
		}
		
	})
});
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
			<input type="hidden" name="rows" value="${param.rows}"/>
			<input type="hidden" name="cpage" value="${param.cpage }" />
			<input type="hidden" name="cat" value="${param.cat }"/>
			<input type="hidden" name="article_seq" />
			<div>  
				<select name="condition" title="검색조건 선택" class="sel_style1">
					<option value="TITLE" <c:if test="${params.condition eq 'TITLE' }">selected="selected"</c:if>>제목</option>
					<option value="REG_NM" <c:if test="${params.condition eq 'REG_NM' }">selected="selected"</c:if>>작성자</option>
					<option value="COMMENT_NM" <c:if test="${param.condition eq 'COMMENT_NM' }">selected="selected"</c:if>>댓글작성자</option>
					<option value="CONTS" <c:if test="${params.condition eq 'CONTS' }">selected="selected"</c:if>>내용</option>
					<option value="TAGNAME" <c:if test="${params.condition eq 'TAGNAME' }">selected="selected"</c:if>>태그</option>
				</select>
				<span><input type="text" class="input_2" name="keyword" value="${param.keyword}" title="검색바" placeholder="검색어를 입력해 주세요."/></span>
				<input type="submit" value="검색"/>
			</div>
		</form>
	</div>
</div>
<table class="faq_list">
	<caption>
		<strong>${suf:clearXSS(boardInfo.title, '')} 목록</strong>
		<p>${suf:clearXSS(boardInfo.title, '')} 게시판 목록이며 제목 링크를 통해 답변을 확인할 수 있습니다.</p>
	</caption>
	<colgroup>
		<col/>
	</colgroup>
	<tbody>
	
	<c:forEach items="${notice_list }" var="item" varStatus = "status">
		<tr class="question">
			<td class="tit">
				<img src="/images/super/notice.png" alt="공지"/>
				<a href="javascript:;" class="faq_click" data-seq="${item.article_seq }" data-board_seq="${item.board_seq }" data-attach_info="${item.attach_info }">
					<c:if test="${pagination.cat_yn == 'Y' }">[${item.cat_nm }]</c:if>
					${suf:clearXSS(item.title, '')}
					<c:if test="${item.comment_cnt > 0}"></c:if>
				</a>
			</td>
		</tr>
		<tr class="answer" style="display:none;">
			<td class="answer_s" style="display:none;">
				<div class="answer_s" style="display:none;">
					<%-- ${suf:clearXSS(item.conts, '')} --%>
					${fn:replace(fn:replace(item.conts, '<script>', '&lt;script&gt;'), '</script>', '&lt;/script&gt;')}
					<c:if test="${!empty item.attch_info}">
						<c:forEach items="${fn:split(item.attch_info,'|') }" var="file" varStatus="file_status">
						<ul>
							<li>
								<a href="/download.do?uuid=${fn:split(file,',')[1] }" target="_blank" title="첨부파일${file_status.count }">${fn:split(file,',')[0] }</a>
							</li>
						</ul>
						</c:forEach>
					</c:if>	
				</div>
			</td>
		</tr>
	</c:forEach>
	<c:if test="${empty list }">
		<tr>
			<td>등록된 게시물이 없습니다.</td>
		</tr>
	</c:if>
	<c:forEach items="${list }" var="item" varStatus = "status">
		<tr class="question">
			<td class="tit">
				<a href="javascript:;" class="faq_click" data-seq="${item.article_seq }" data-board_seq="${item.board_seq }" data-attach_info="${item.attach_info }">
					<c:if test="${pagination.cat_yn == 'Y' }"><span class="cat">[${item.cat_nm }]</span></c:if>
					${suf:clearXSS(item.title, '')}					
					<c:if test="${item.comment_cnt > 0}"></c:if>
				</a>				
				<span>닫힘</span>
			</td>
		</tr>
		<tr class="answer" style="display:none;">
			<td class="answer_s" style="display:none;">
				<div class="answer_s" style="display:none;">
					<%-- ${suf:clearXSS(item.conts, '')} --%>
					${fn:replace(fn:replace(item.conts, '<script>', '&lt;script&gt;'), '</script>', '&lt;/script&gt;')}
					<c:if test="${!empty item.attch_info}">
						<c:forEach items="${fn:split(item.attch_info,'|') }" var="file" varStatus="file_status">
						<ul>
							<li>
								<a href="/download.do?uuid=${fn:split(file,',')[1] }" target="_blank" title="첨부파일${file_status.count }">${fn:split(file,',')[0] }</a>
							</li>
						</ul>
						</c:forEach>
					</c:if>	
				</div>
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>

<c:if test="${pagination.insert_yn=='Y' }">
	<div class="btn_area mt2">
		<div class="right">
			<a href="insertForm.do" class="v1">등록</a>
		</div>
	</div>
</c:if>

<jsp:include page="/share/paging.do">
	<jsp:param name="cpage" value="${param.cpage }"/>
	<jsp:param name="rows" value="${param.rows }"/>
	<jsp:param name="totalpage" value="${pagination.totalpage }"/>
</jsp:include>
</body>
</html>

