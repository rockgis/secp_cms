<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<!-- 파라미터 -->
<c:set var="paramset" value=""/>
<c:choose>
	<c:when test="${empty param.use_params }">
	<c:forEach var="item" items="${pageContext.request.parameterNames}">
		<c:if test="${!(item eq 'servlet_path' || item eq 'forwrad_yn' || item eq 'blocksize' || item eq 'totalpage' || item eq 'cpage' || item eq 'rows' || item eq 'forwrad_yn' || item eq 'cms_menu_seq')}">
		<c:forEach var="val" items="${paramValues[item] }">
			<c:choose>
				<c:when test="${paramset eq '' }">
					<c:set var="paramset" value="${paramset }?${item }=${val }"/>
				</c:when>
				<c:otherwise>
					<c:set var="paramset" value="${paramset }&${item }=${val }"/>
				</c:otherwise>
			</c:choose>
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
				<c:choose>
					<c:when test="${paramset eq '' }">
						<c:set var="paramset" value="${paramset }?${item }=${val }"/>
					</c:when>
					<c:otherwise>
						<c:set var="paramset" value="${paramset }&${item }=${val }"/>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			</c:when>
			<c:otherwise>
			<c:choose>
				<c:when test="${paramset eq '' }">
					<c:set var="paramset" value="${paramset }?${item }=${param[item] }"/>
				</c:when>
				<c:otherwise>
					<c:set var="paramset" value="${paramset }&${item }=${param[item] }"/>
				</c:otherwise>
			</c:choose>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	</c:otherwise>
</c:choose>

<c:choose>
	<c:when test="${paramset eq '' }">
		<c:set var="paramset" value="?"/>
	</c:when>
	<c:otherwise>
		<c:set var="paramset" value="${paramset }&"/>
	</c:otherwise>
</c:choose>
<!-- //파라미터 -->

<c:if test="${0 < end}">
	<div class="paging">
		<span id="pagingWrap"> 
		<a href="javascript:void(0);" onclick="${param.fn_list}('${rows }', 1);">&lt;&lt;</a>
		
		<c:if test="${cpage > 1 }">
			<a href="javascript:void(0);" onclick="${param.fn_list}('${rows }', '${prevblock }');">&lt;</a>
		</c:if>
		
		<c:forEach var="i" begin="${start }" end="${end}">
		<c:choose>
			<c:when test="${cpage eq i }">
				<b><a href="javascript:void(0);" class="on">${i }</a></b>
			</c:when>
			<c:otherwise>
				<a href="javascript:void(0);" onclick="${param.fn_list}('${rows }', '${i}');">${i}</a>
			</c:otherwise>
		</c:choose>
		</c:forEach>
		
		<c:if test="${cpage < totalpage }">
			<a href="javascript:void(0);" onclick="${param.fn_list}('${rows }', '${nextblock}');">&gt;</a>
		</c:if>
		
		<a href="javascript:void(0);" onclick="${param.fn_list}('${rows }', '${totalpage}');">&gt;&gt;</a>
		</span>
	</div>
</c:if>