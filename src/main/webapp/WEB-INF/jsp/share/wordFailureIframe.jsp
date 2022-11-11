<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div title="개인정보 필터">
	<div class="system_warning_box">
	  	<div class="title">
	    	<img src="/images/super/system_pop_03.png" alt="경고 아이콘">
	    	<p>등록하시려는 게시물 본문에서<br />개인정보유출이 우려되는 내용이 검출되었습니다.</p>
	  	</div>
	  	<c:if test="${!empty param.str1 or !empty param.str2}">
	  	<h4>검출된 문자열</h4>
	  	<div class="text">
	   		<p style="color:red;">${param.str1 }</p>
	   		<p style="color:blue;">${param.str2 }</p>
	  	</div>
	  	</c:if>
	  	
	  	<c:if test="${!empty param.str3}">
	  	<h4>필터링</h4>
	  	<div class="text">
	  		<p style="color:red;">${param.str3 }</p>
	  	</div>
	  	</c:if>
	</div>
</div>