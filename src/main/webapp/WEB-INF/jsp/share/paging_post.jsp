<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<c:set var="isMobile" value="${fn:contains(header['user-agent'], 'Mobile')}"/>
<c:set var="servlet_path" value="${param.servlet_path}"/>
<fmt:parseNumber var="totalpage" value="${param.totalpage }" integerOnly="true" type="number"/>
<c:set var="rows" value="${empty param.rows ? '10' : param.rows }"/>
<c:set var="blocksize" value="${empty param.blocksize ? (isMobile?5:10) : param.blocksize }"/>
<c:set var="cpage" value="${empty param.cpage ? '1' : param.cpage }"/>
<fmt:parseNumber var="start" value="${cpage - ((cpage - 1) % blocksize) }" integerOnly="true" type="number"/>
<fmt:parseNumber var="end" value="${start + (blocksize-1) > totalpage ? totalpage : start + (blocksize-1) }" integerOnly="true" type="number"/>
<fmt:parseNumber var="nextblock" value="${(start+blocksize) > totalpage ? totalpage : (start+blocksize) }" integerOnly="true" type="number"/>
<fmt:parseNumber var="prevblock" value="${(end-blocksize) < 1 ? 1 : (start-blocksize)}" integerOnly="true" type="number"/>
<script type="text/javascript">
function goPage(rows, cpage){
	$("#pageFrm").prop("action", "<c:url value='${servlet_path }'/>?rows="+rows+"&cpage="+cpage);
	$("#pageFrm").submit();
}
</script>
<!-- 파라미터 -->
<form id="pageFrm" action="<c:url value='${servlet_path }'/>" method="post">
<sec:csrfInput />
<c:choose>
	<c:when test="${empty param.use_params }">
		<c:forEach var="item" items="${pageContext.request.parameterNames}">
			<c:if test="${param.forwrad_yn eq 'Y' && !(item eq 'servlet_path' || item eq 'forwrad_yn' || item eq 'blocksize' || item eq 'totalpage' || item eq 'cpage' || item eq 'rows' || item eq 'cms_menu_seq' || item eq 'board_type' || item eq 'board_seq')}">
			<c:forEach var="val" items="${paramValues[item] }">
				<input type="hidden" name="${item }" value="<c:out value="${val }" escapeXml="true"/>"/>
			</c:forEach>
			</c:if>
		</c:forEach>
	</c:when>
	<c:otherwise><!-- 허용 파라미터만 직접 지정한경우 -->
		<c:set var="param_list" value="${fn:split(param.use_params, ',') }"/>
		<c:forEach var="item" items="${param_list}">
			<c:choose>
				<c:when test="${fn:endsWith(item, '[]') }">
				<c:set var="item" value="${fn:replace(item, '[]', '') }"/>
				<c:forEach var="val" items="${paramValues[item] }">
					<input type="hidden" name="${item }" value="$<c:out value="${val }" escapeXml="true"/>"/>
				</c:forEach>
				</c:when>
				<c:otherwise>
					<input type="hidden" name="${item }" value="<c:out value="${param[item] }" escapeXml="true"/>"/>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</c:otherwise>
</c:choose>
</form>
<!-- //파라미터 -->
<c:if test="${0 < end}">
	<div class="paging">
		<span id="pagingWrap"> 
		<a href="javascript:goPage(${rows }, 1);"><img src="/images/board/fst_arr.gif" alt="처음으로" /></a>
		
		<c:if test="${cpage > 1 }">
			<a href="javascript:goPage(${rows }, ${prevblock });"><img src="/images/board/fst_arr.gif" alt="처음으로" /></a>
		</c:if>
		
		<c:forEach var="i" begin="${start }" end="${end}">
		<c:choose>
			<c:when test="${cpage eq i }">
				<b><a href="javascript:void(0);" class="on">${i }</a></b>
			</c:when>
			<c:otherwise>
				<a href="javascript:goPage(${rows }, ${i });">${i}</a>
			</c:otherwise>
		</c:choose>
		</c:forEach>
		
		<c:if test="${cpage < totalpage }">
			<a href="javascript:goPage(${rows }, ${nextblock });"><img src="/images/board/next_arr.gif" alt="이전" /></a>
		</c:if>
		
		<a href="javascript:goPage(${rows }, ${totalpage });"><img src="/images/board/lst_arr.gif" alt="마지막으로" /></a>
		</span>
	</div>
</c:if>