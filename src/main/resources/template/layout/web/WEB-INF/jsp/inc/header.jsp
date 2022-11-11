<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<div id="header">
	<div class="h_wrap">
		<h1><a href="<c:url value="{{SUB_PATH}}"/>"><img src="/images/header/logo.gif" alt="미디어코어시스템즈"></a></h1>
		<div class="utill">
			<div class="search">
				<a href="#" class="sch_btn"><img src="/images/header/sch_btn.gif" alt="검색" /></a>
				<a href="#" class="close_btn" style="display:none"><img src="/images/header/close_btn.gif" alt="닫기" /></a>
				<div class="sch_form" style="display:none"> 
					<form action="<c:url value="/lay3/program/S1T2C58/total/search.do"/>" method="get" name="searchFrm">
						<fieldset>
							<legend>통합검색</legend>
							<input type="text" name="total_keyword" id="total_keyword" value="<c:out value="${param.total_keyword }" escapeXml="true"/>" placeholder="검색어를 입력해주세요" title="검색어 입력" />
							<input type="image" src="/images/header/sch_btn.gif" alt="검색" />
							<!-- <input type="submit" value="검색"> -->
						</fieldset>
					</form>
				</div>
			</div>
			<div class="familySite">
				<a class="btn_family" href="#none" title="외국어 사이트 링크 선택">Language</a>
				<ul class="familyList" style="display: none;">
					<li><a href="http://english.gg.go.kr/gyeonggi-urban-innovation-corporation/" target="_blank" title="영어 사이트 새창열림">ENGLISH</a></li>
				</ul>
				<a href="#none" class="submit">이동</a>
			</div>
			<div class="utill_menu">
				<ul>
					<li><a href="<c:url value="{{SUB_PATH}}"/>">홈</a></li>
					<c:choose>
						<c:when test="${empty sessionScope.member }">
						<li><a href="<c:url value="/lay4/program/S1T2C4/member/login.do"/>">로그인</a></li>
						<li><a href="<c:url value="/lay4/program/S1T2C3/member/join_step1.do"/>">회원가입</a></li>
						</c:when>
						<c:otherwise>
						<li>${sessionScope.member.member_nm }님 <a href="<c:url value="/login/logout.do"/>">로그아웃</a></li>
						</c:otherwise>
					</c:choose>
					<li><a href="/lay1/program/S1T125C126/sitemap/intro.do">사이트맵</a></li>
				</ul>
			</div>			
		</div>
		<div class="side_menu btnCtg"><a href="#"><img src="/images/common/m_menu_btn.gif" alt="전체메뉴 열기"></a></div>
		<div class="search_m">
			<a href="#" title="통합검색 창 열림 및 닫힘">
				<img src="/images/common/m_sch_btn.gif" alt="검색창 열기 , 닫기">
			</a>
		</div>
	</div> <!-- h_wrap -->
	
	<!-- LOCAL NAVIGATIONB BAR -->
	<div class="lnb" id="gnavi">
		<div class="lnb_bg" style="display:none"></div>
		<c:out value="${topmenu }" escapeXml="false"/>
	</div>
</div>