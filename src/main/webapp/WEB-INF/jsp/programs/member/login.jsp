<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta property="og:image" content="">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <sec:csrfMetaTags/>
    <title>경기도 소상공인 종합지원 플랫폼</title>

    <link rel="stylesheet" type="text/css" href="/css/secp/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="/css/secp/common.css">
    
    <script src="/js/secp/jquery-1.12.4.min.js"></script>
    <script src="/js/secp/jquery-ui.min.js"></script>
    <script src="/js/secp/common.js"></script>
	<script src="/js/secp/member/login.js"></script>
</head>

<body>
    <div class="wrap">
        <!-- 상단 영역 //-->
        <%@ include file="/WEB-INF/jsp/programs/header.jsp" %>
        <!--// 상단 영역 -->

        <!-- 서브 헤드 //-->
        <div class="sub-head sub5">
            <div class="content-width">
                <h2>로그인</h2>
                <ul class="linemap">
                    <li><a href="index.html"><img src="/images/secp/ico_home_w.png" alt="홈"></a></li>
                    <li>로그인</li>
                </ul>
            </div>
        </div>
        <!--// 서브헤드 -->

        <!-- 콘텐츠 영역 //-->
        <div class="sub-content">

            <div class="login-wrap">
                <h2>경기도 소상공인 종합지원 포털 <span class="c-blue">로그인</span></h2>
                <p>경기도 소상공인 종합지원 포털에 오신 것을 환영합니다.</p>
                <p>로그인 하셔야 지원 사업에 관한 서비스를 이용할 수 있습니다.</p>

                <div>
                    <div class="login-form">
                        <input type="text" placeholder="아이디를 입력하세요" class="inp" id="login-id">
                        <input type="password" placeholder="비밀번호를 입력하세요" class="inp" id="pwd">
                        <a href="#" class="btn-login">로그인</a>
                    </div>
                    <div class="login-etc">
                        <ul>
                            <li class="login-join">
                                <a href="/member/join.do">
                                    <b>회원가입</b>
                                    <p>경기도 소상공인 종합지원 포털의 회원이 되어보세요.</p>
                                </a>
                            </li>
                            <li class="login-find">
                                <a href="#">
                                    <b>아이디/비밀번호 찾기</b>
                                    <p>아이디 또는 비밀번호를 잊으셨나요?</p>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
        <!--// 콘텐츠 영역 -->

        <!-- 푸터 영역 //-->
        <%@ include file="/WEB-INF/jsp/programs/footer.jsp" %>
        <!--// 푸터 영역 -->
    </div>
    
</body>

</html>

    