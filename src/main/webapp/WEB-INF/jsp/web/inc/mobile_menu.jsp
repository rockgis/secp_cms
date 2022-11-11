<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div id="naviMenu">
  	<div>
  		<div class="navi_top">
	      	<a href="<c:url value="/web"/>" class="gnbHome"><span>메인</span></a>
	      	<a href="/web/lay1/program/S1T125C126/sitemap/intro.do" class="sitemap"><span>사이트맵</span></a>
  		</div>
	    <ul class="menuCtg">
		    <c:out value="${mobile_menu }" escapeXml="false"/>
	    </ul>
    	<div class="sel_box1"> 
	      	<select>
		        <option>유관기관 홈페이지</option>
				<option value="//www.rapa.or.kr">한국전파진흥협회</option>
				<option value="//www.nipa.kr">정보통신산업진흥원</option>
				<option value="//www.msip.go.kr">미래창조과학부</option>
				<option value="//www.rra.go.kr">국립전파연구원</option>
				<option value="//www.kca.kr">한국방송통신전파진흥원</option>
	      	</select>
      		<span class="btn_go"><a href="#"><img src="/images/common/select_go_btn.gif" alt="이동" /></a></span>
      	</div>
  	</div>
  	<p class="closeArea"><a class="close"></a></p>
</div>
