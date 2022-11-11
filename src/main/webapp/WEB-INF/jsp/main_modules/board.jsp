<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf" %>
<ul>
<c:forEach var="item" items="${board }">
	<li><a href="${param.link_url }/view.do?article_seq=${item.article_seq}&cpage=&rows=&condition=&keyword=">${item.title }</a><span> ${item.reg_dt }</span></li>	
</c:forEach>
</ul>