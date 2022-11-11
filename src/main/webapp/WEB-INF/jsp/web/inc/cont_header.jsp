<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib  prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld"%>
<c:out value="${fn:replace(fn:replace(cont_header, '<script>', '&lt;script&gt;'), '</script>', '&lt;/script&gt;')}" escapeXml="false" />
<%-- <c:out value="${cont_header }" escapeXml="false"/> --%>
<%-- <c:out value="${suf:clearXSS(cont_header, '')}" escapeXml="false" /> --%>