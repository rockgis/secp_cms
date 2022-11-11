<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:forward page="/bbs/${board_type}/${bbs_url}">
	<jsp:param name="servlet_path" value="${requestScope['javax.servlet.forward.servlet_path']}"/>
	<jsp:param name="forwrad_yn" value="Y"/>
	<jsp:param name="cms_menu_seq" value="${menu_seq }"/>
	<jsp:param name="board_type" value="${board_type }"/>
	<jsp:param name="board_seq" value="${board_seq }"/>
</jsp:forward>
