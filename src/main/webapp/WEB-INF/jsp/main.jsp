<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<style type="text/css">
#main_layout {
	width: 1100px;
	position: relative;
	margin: 0 auto;
}

#main_layout>div.component_module {
	position: absolute;
}

<%
for(int i=1;i<=40;i++){
	out.println("#main_layout>div[data-ss-colspan='"+i+"'] {width:"+((i*20)+(i-1)*10)+"px;}");
	out.println("#main_layout>div[data-ss-rowspan='"+i+"'] {height:"+((i*20)+(i-1)*10)+"px;}");
}
%>
</style>
<title>MC@CMS Enterprise eGov V.1.5.0</title>
<script type="text/javascript" src="/lib/js/jquery.shapeshift.js"></script>
<script type="text/javascript">
$(function(){
	$("#main_layout").shapeshift({
		minColumns : 40,
		paddingX:10,
		paddingY:10,
        colWidth:20
	});
});

function shwoTabNav(eName, totalNum, showNum) {
	for(i=1; i<=totalNum; i++){
		var zero = (i >= 10) ? "" : "0";
		var e = document.getElementById("tabNav" + eName + zero + i);
		var eTitle = document.getElementById("tabNavTitle" + eName + zero + i);
		e.style.display = "none";
		eTitle.className = "";
	}

	var zero = (showNum >= 10) ? "" : "0";
	var e = document.getElementById("tabNav" + eName + zero + showNum);
	var eTitle = document.getElementById("tabNavTitle" + eName + zero + showNum);
	e.style.display = "block";
	eTitle.className = "on";
}
</script>
<style type="text/css">
#main_layout>div.component_module h2{font-size:20px; font-family:"NanumSquareB";}
#main_layout>div[data-ss-colspan='22']{border:1px solid #ddd;}
#tabNav43 {position:relative; height:293px; border:1px solid #dcdcdc;}
#tabNav43:after{display:block; content:""; clear:both;}
#tabNav43 h3 {position: absolute; top:0; left:0;}
#tabNav43 h3 a {display:block; width:246px; height:18px; padding:16px 0; background:#cdd1d3; font-size:14px; text-align:center; color:#707070;}
#tabNav43 h3.on {top:0px;}
#tabNav43 h3.on a {border-top:4px solid #4ea5d4; background:#fff;}
#tabNav43 h3#tabNavTitle0102 {left:246px;}
#tabNav43 h3#tabNavTitle0103 {right:0; left:inherit;}
#tabNav43 #tabNav0101 {display:block;}
#tabNav43 div {display:none; margin:77px 0 0 0; padding:0 35px 0 30px;}
#tabNav43 div ul li {overflow:hidden; margin-bottom:19px;}
#tabNav43 div ul li a {overflow:hidden; text-overflow:ellipsis; white-space:nowrap; float:left; width:550px; padding-left:9px; background:url(/images/main/dot_01.gif) no-repeat left 6px; font-size:14px;}
#tabNav43 div ul li span {float:right; font-size:13px; color:#989898;}
#tabNav43 div span.more {position:absolute; top:-36px; right:0;}
</style>
</head>
<body>
	<c:set var="module_idx"/>
	<div id="container">
		<div id="main_layout">
			<c:forEach var="item" items="${data.list }">
			<div class="component_module" data-ss-colspan="${item.col }" data-ss-rowspan="${item.row }">
				<c:if test="${!empty item.title }"><h2>${item.title }</h2></c:if>
				<c:if test="${item.tab_yn eq 'Y' }">
					<div id="tabNav${item.seq }">
						<c:forEach var="module" items="${item.module }" varStatus="status">
							<h3 id="tabNavTitle${item.seq }0${module.idx}" class="on"><a href="#" onclick="shwoTabNav('${item.seq }', ${item.module.size()}, ${module.idx}); return false;" onfocus="this.onclick();">${module.tab_title }</a></h3>
							<div id="tabNav${item.seq }0${module.idx}" style="display:${status.first ? 'block;' : 'none;'}">
							<c:choose>
								<c:when test="${module.com_type eq '1' }">${module.conts }</c:when>
								<c:when test="${module.com_type eq '2' }">
								<jsp:include page="/main_board.do">
									<jsp:param name="board_seq" value="${module.board_seq }"/>
									<jsp:param name="link_url" value="${module.link_url }"/>
								</jsp:include>
								</c:when>
							</c:choose>
							</div>
						</c:forEach>
					</div>
				</c:if>
				<c:if test="${item.tab_yn eq 'N' }">
				<c:set var="module" value="${item.module[0] }"></c:set>
					<c:choose>
						<c:when test="${module.com_type eq '1' }">${module.conts }</c:when>
						<c:when test="${module.com_type eq '2' }">
						<jsp:include page="/main_board.do">
							<jsp:param name="board_seq" value="${module.board_seq }"/>
							<jsp:param name="link_url" value="${module.link_url }"/>
						</jsp:include>
						</c:when>
					</c:choose>
				</c:if>
			</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>