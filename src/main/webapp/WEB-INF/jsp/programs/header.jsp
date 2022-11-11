<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String id = session.getAttribute("id") == null ? "" : session.getAttribute("id").toString();
	String name = session.getAttribute("name") == null ? "" : session.getAttribute("name").toString();
%>
<div class="header">
    <h1><a href="/"><img src="/images/secp/logo.png" alt="경기도"><span>소상공인 종합지원 포털</span></a></h1>
    <div class="nav-wrap">
        <ul>
            <li><a href="/intro/index.do">포털 소개</a>
                <ul>
                    <li><a href="/intro/index.do">포털 소개</a></li>
                    <li><a href="/intro/biz-intro.do">사업 안내</a></li>
                    <li><a href="/intro/site-guide.do">이용 안내</a></li>
                </ul>
            </li>
            <li><a href="/apply/list.do">지원 신청</a>
                <ul>
                    <li><a href="/apply/list.do">온라인 접수</a></li>
                    <li><a href="/apply/apply-easy.do">간편 접수</a></li>
                </ul>
            </li>
            <li><a href="/board/boardIndex.do?type=1">알림소식</a>
                <ul>
                    <li><a href="/board/boardIndex.do?type=1">공지사항</a></li>
                    <li><a href="/board/boardIndex.do?type=2">자주 묻는 질문</a></li>
                    <li><a href="/board/boardIndex.do?type=3">1:1 문의</a></li>
                </ul>
            </li>
            <li><a href="/mybiz/index.do">나의 신청 현황</a></li>
        </ul>
    </div>
    <div class="member">
        <button type="button" class="btn-search">검색</button>

		<c:choose>
			<c:when test="${not empty id}">
		        <a href="#" id="btn-logout"><img src="/images/secp/ico_logout.svg" alt="" class="ico-logout"><span>로그아웃</span></a>
		        <a href="#"><img src="/images/secp/ico_memedit.svg" alt="" class="ico-memedit"><span>회원정보 수정</span></a>
        	</c:when>
        	<c:otherwise>
		        <a href="/member/login.do"><img src="/images/secp/ico_login.svg" alt="" class="ico-login"><span>로그인</span></a>
		        <a href="/member/join.do"><img src="/images/secp/ico_join.svg" alt="" class="ico-join"><span>회원가입</span></a>
        	</c:otherwise>	
        </c:choose>
    </div>
    <!-- 전체 메뉴 버튼 -->
    <button type="button" class="btn-menu"></button>

    <div class="dim"></div>
</div>

<div class="pop-gnb-search">
    <button type="button" class="btn-search-close">닫기</button>
    <div class="gnb-search-wrap">
        <input type="text" class="gnb-search" id="gnb-search" placeholder="검색어를 입력하세요">
        <button type="button" class="btn-gnb-search" id="header-search-btn">검색</button>
    </div>
    <ul class="tag">
        <li><a href="#">#전통시장</a></li>
        <li><a href="#">#청년사관학교</a></li>
        <li><a href="#">#푸드트럭</a></li> 
        <li><a href="#">#경기지역화폐</a></li>
    </ul>
</div>