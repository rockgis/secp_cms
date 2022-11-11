<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<div id="skipNavi">
	<a href="#container" class="main_skip">본문으로 바로가기</a>
	<a href="#sub" class="sub_skip">본문으로 바로가기</a>
	<a href="#lnb">메뉴로 바로가기</a>
</div>
<header id="header">
	<div class="inner">
        <h1>
            <a href="/">
                <img class="main_logo" src="/images/new/header/logo.png" alt="미디어코어시스템즈" />
                <img class="sub_logo" src="/images/new/header/sub_logo.png" alt="미디어코어시스템즈" />
            </a>
        </h1>
        <nav id="lnb">
			<ul>
			<c:out value="${topmenu }" escapeXml="false"/>
			</ul>
		</nav>
        <div class="utill">
            <ul>
                <li>
                    <img class="main home_ico" src="/images/new/header/home.gif" alt="" />
                    <img class="sub" src="/images/new/sub/home_ico.png" alt="" />
                    <a href="/">HOME</a>
                </li>
                <c:choose>
					<c:when test="${empty sessionScope.member }">
					<li>
	                    <img class="main" src="/images/new/header/login.gif" alt="" />
	                    <img class="sub" src="/images/new/sub/login_ico.png" alt="" />
	                    <a href="<c:url value="/web/lay1/program/S1T2C4/member/login.do"/>">LOGIN</a>
	                </li>
	                <li class="u_last">
	                    <img class="main" src="/images/new/header/join.gif" alt="" />
	                    <img class="sub" src="/images/new/sub/join_ico.png" alt="" />
	                    <a href="<c:url value="/web/lay1/program/S1T2C3/member/join_step1.do"/>">JOIN</a>
	                </li>
					</c:when>
					<c:otherwise>
					<li>${sessionScope.member.member_nm }님 환영합니다.</li>
					<li><a href="<c:url value="/web/lay1/S1T1C451/sublink.do"/>">MYPAGE</a></li>
					<li><a href="<c:url value="/login/logout.do"/>">로그아웃</a></li>
					</c:otherwise>
				</c:choose>
            </ul>
        </div>
        <div class="side_menu">
            <div class="side_btn btnCtg">
                <span>1</span> <span>2</span> <span>3</span>
            </div>
        </div>
    </div>
 <!-- h_wrap -->
</header>