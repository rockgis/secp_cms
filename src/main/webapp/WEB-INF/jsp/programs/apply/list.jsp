<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

    <link rel="stylesheet" type="text/css" href="/css/secp/jquery.splitter.css">
    <link rel="stylesheet" type="text/css" href="/css/secp/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="/css/secp/common.css">

	<script src="/js/secp/jquery-1.12.4.min.js"></script>
    <script src="/js/secp/jquery.splitter.js"></script>
    <script src="/js/secp/jquery-ui.min.js"></script>
    <script src="/js/secp/common.js"></script>
    <script src="/js/secp/biz/onlineList.js"></script>
</head>

<body>
    <div class="wrap">
        <!-- 상단 영역 //-->
        <%@ include file="/WEB-INF/jsp/programs/header.jsp" %>
        <!--// 상단 영역 -->

        <!-- 서브 헤드 //-->
        <div class="sub-head sub2">
            <div class="content-width">
                <h2>온라인 접수</h2>
                <ul class="linemap">
                    <li><a href="index.html"><img src="/images/secp/ico_home_w.png" alt="홈"></a></li>
                    <li>지원 신청</li>
                    <li>온라인 접수</li>
                </ul>
            </div>
        </div>
        <!--// 서브헤드 -->

        <!-- 콘텐츠 영역 //-->
        <div class="sub-content">
            <div class="apply-list-wrap">
                <ul class="prj-cate">
                    <li><a href="#" class="active">전체 25</a></li>
                    <li><a href="#">개인접수</a></li>
                    <li><a href="#">단체접수</a></li>
                    <li><a href="#">시군접수</a></li>
                </ul>
                <div class="prj-filter">
                    <ul class="">
                        <li><a href="#" class="active">전체</a></li>
                        <li><a href="#">접수중</a></li>
                        <li><a href="#">접수마감</a></li>
                        <li><a href="#">신청대기</a></li>
                    </ul>
                    <ul class="">
                        <li><a href="#" class="active">사업명순</a></li>
                        <li><a href="#">관심도순</a></li>
                        <li><a href="#">마감임박순</a></li>
                    </ul>
                </div>
                <ul class="prj-list f-clear" id="prj-list">
                    <li>
                        <div class="prj-item">
                            <a href="#">
                                <div class="thumb" style="background-image: url(/images/secp/thumb1.jpg);">
                                    <div class="badge1">접수중</div>
                                </div>
                                <p class="subject">(1단계) 역량강화_골목상권공동체_신규</p>
                                <p class="date">2022.07.01 ~ 2022.12.31</p>
                            </a>
                        </div>
                    </li>
                </ul>
            </div>
            
        </div>
        <!--// 콘텐츠 영역 -->

        <!-- 푸터 영역 //-->
        <%@ include file="/WEB-INF/jsp/programs/footer.jsp" %>
        <!--// 푸터 영역 -->
    </div>
    
</body>

</html>

