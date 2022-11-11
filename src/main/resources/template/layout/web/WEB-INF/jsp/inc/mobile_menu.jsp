<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div id="naviMenu">
  <div>
    <div class="closeArea"><a class="close"></a></div>
    <ul class="menuCtg">
      <li>
        <p class="gnbHome"><a href="<c:url value="{{SUB_PATH}}"/>">메인</a></p>
        <p class="sitemap"><a href="/lay1/program/S1T125C126/sitemap/intro.do">사이트맵</a></p>
      </li>
      
      <!-- product -->
      <li class="on">
        <ul>
      	<c:out value="${mobile_menu }" escapeXml="false"/> 
      	</ul>
      </li>
    </ul>
    <div class="ml_tel"><a href="tel:02-3479-7600"><img src="" alt=""></a></div>
    <div class="m_main_link">
      <ul>
        <li><a href="#"><img src="" alt=""></a></li>
        <li><a href="#"><img src="" alt=""></a></li>
        <li><a href="#"><img src="" alt=""></a></li>
        <li><a href="#"><img src="" alt=""></a></li>
      </ul>
    </div>
    <div class="select_box_1"> <span class="select">
      <select>
        <option>유관기관 홈페이지</option>
		<option value="//www.rapa.or.kr">한국전파진흥협회</option>
		<option value="//www.nipa.kr">정보통신산업진흥원</option>
		<option value="//www.msip.go.kr">미래창조과학부</option>
		<option value="//www.rra.go.kr">국립전파연구원</option>
		<option value="//www.kca.kr">한국방송통신전파진흥원</option>
      </select>
      </span> <!-- <span class="btn_go"><a href="#"><img src="/images/common/select_go_btn.gif" alt="이동" /></a></span> --> </div>
  </div>
</div>