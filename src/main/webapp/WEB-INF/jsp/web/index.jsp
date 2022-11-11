<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf" %>
<%@ taglib uri="/WEB-INF/tlds/FileUtil_fn.tld" prefix="fuf" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta property="og:image" content="">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>경기도 소상공인 종합지원 플랫폼</title>

    <link rel="stylesheet" type="text/css" href="/css/secp/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="/css/secp/swiper.css">
    <link rel="stylesheet" type="text/css" href="/css/secp/aos.css">
    <link rel="stylesheet" type="text/css" href="/css/secp/common.css">

	<script src="/js/secp/jquery-1.12.4.min.js"></script>
    <script src="/js/secp/jquery-ui.min.js"></script>
    <script src="/js/secp/index/index.js"></script>
    <script src="/js/secp/swiper.js"></script>
    <script src="/js/secp/aos.js"></script>
    <script src="/js/secp/common.js"></script>
    
    <script>

        $(function () {

            // 접속시 메인 상단 배경 이미지 랜덤
            var bg_idx = Math.floor(Math.random() * 4) + 1;
            var bg_url = 'url(/images/secp/main_visual' + bg_idx + '.jpg)';
            $(".main-header-wrap").css({backgroundImage : bg_url});

            // 배너 슬라이더
            var ban_swiper = new Swiper('.ban-swiper', {
                speed: 1000,
                effect : 'slide',
                navigation: {
                    nextEl: '.next',
                    prevEl: '.prev',
                },
                pagination: {
                    el: ".swiper-pagination",
                    type : 'bullets'
                },
                autoplay: {
                    delay: 2000,
                },
                autoplayDisableOnInteraction: true,
                loop: true,
            });

            // 스크롤에 따른 등장 모션
            AOS.init({
                offset: 160,
                duration : 800,
                easing: 'ease'
            });

            $(window).scroll(function(){
                // Top 버튼 보이기/가리기
                if ($(this).scrollTop() > 300){
                    $('.btn-top').show();
                } else{
                    $('.btn-top').hide();
                }

                // 스크롤 특정지점에서 카테고리/필터 위치 고정
                var cateTop = $(".apply-list-wrap").offset().top;
                var winscrollTop = $(this).scrollTop();

                if (cateTop <= winscrollTop) {
                    $(".apply-list-wrap").addClass("float");

                } else {
                    $(".apply-list-wrap").removeClass("float");
                }
            });

            // Top 버튼 클릭시
            $('.btn-top').click(function(){
                $('html, body').stop().animate({scrollTop: 0}, 1000, "easeInOutExpo");
                return false;
            });

            // Scroll 버튼 클릭시
            $('.btn-scroll').click(function(e){
                e.preventDefault();
                x = $(this).attr("href");
                $('html, body').stop().animate({scrollTop : $(x).offset().top + 60}, 1000, "easeInOutExpo");
            });

            // 공지사항 뉴스티커
            var notice_swiper = new Swiper('.notice-swiper', {
                direction: "vertical",
                speed: 1000,
                navigation: {
                    nextEl: '.noti-btn-right',
                    prevEl: '.noti-btn-left',
                },
                autoplay: {
                    delay: 2000,
                },
                pauseOnMouseEnter: true,
                loop: true,
            });

        });
    </script>
</head>

<body>
    <!-- 바로가기 링크 //-->
    <div class="skip">
        <a href="#content">본문 내용 바로가기</a>
        <a href="#nav-wrap">주메뉴 바로가기</a> 
    </div>
    <!--// 바로가기 링크 -->

    <div class="wrap">
        <!-- 메인 상단 영역 //-->
        <div class="main-header-wrap">
            <!-- 상단 영역 //-->
            <%@ include file="/WEB-INF/jsp/programs/header.jsp" %>
            <!--// 상단 영역 -->

            <!-- 메인 헤드 내용 //-->
            <div class="main-head">
                <div class="content-width">
                    <div class="group1">
                        <p class="txt1">어떤 지원분야를 <br>찾으시나요?</p>
                        <p class="txt2">경기도 소상공인을 위한 맞춤형 종합 정책지원 사업이 준비되어 있습니다.</p>
                    </div>
                    <div class="group2">
                        <div class="main-search-wrap">
                            <input type="text" class="main-search" id="main-search" placeholder="검색어를 입력하세요">
                            <button type="button" class="btn-main-search" id="btn-main-search">검색</button>
                        </div>
                        <ul class="tag">
                            <li><a href="#">#전통시장</a></li>
                            <li><a href="#">#청년사관학교</a></li>
                            <li><a href="#">#푸드트럭</a></li>
                            <li><a href="#">#경기지역화폐</a></li>
                        </ul>
                    </div>
                    <div class="group3">
                        <p class="txt3">이미 신청하셨나요?</p>
                        <button type="button" class="btn-main-round" onclick="window.location.href='/mybiz/index.do'">신청 현황 확인하기</button>
                    </div>

                    <!-- 배너 슬라이드 //-->
                    <div class="main-banner">
                        <div class="ban-swiper">
                            <div class="swiper-wrapper">
                                <div class="swiper-slide" style="background-image: url(/images/secp/img_banner1.jpg);"></div>
                                <div class="swiper-slide" style="background-image: url(/images/secp/img_banner1.jpg);"></div>
                                <div class="swiper-slide" style="background-image: url(/images/secp/img_banner1.jpg);"></div>
                                <div class="swiper-slide" style="background-image: url(/images/secp/img_banner1.jpg);"></div>
                                <div class="swiper-slide" style="background-image: url(/images/secp/img_banner1.jpg);"></div>
                            </div>
                        </div>
                        <div class="swiper-pagination"></div>
                        <div class="swiper-navigation">
                            <div class="swiper-button-prev prev"></div>
                            <div class="swiper-button-next next"></div>
                        </div>
                    </div>
                    <!--// 배너 슬라이드 -->

                    <a href="#content" class="btn-scroll"><img src="/images/secp/ico_scrollguide.svg" alt="아래로 스크롤 하세요"></a>
                    
                </div>
            </div>
            <!--// 메인 헤드 내용 -->
            <div class="main-notice">
                <div class="content-width flexline">
                    <div class="tit"><img src="/images/secp/ico_speaker.svg" alt="">NOTICE</div>
                    <div class="newsticker">
                        <div class="notice-swiper">
                            <div class="swiper-wrapper" id="rlist">
                            
                            </div>                   
                        </div>
                    </div>
                    <div class="notice-btns">
                        <button type="button" class="noti-btn-left">이전</button>
                        <button type="button" class="noti-btn-right">다음</button>
                    </div>
                </div>
            </div>
        </div>
        <!--// 메인 상단 영역 -->

        <!-- 콘텐츠 영역 //-->
        <div class="main-content" id="content">
            
            <div class="apply-list-wrap">

                <div class="prj-catefilter">
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
                </div>

                <ul class="prj-list f-clear type1" id="prj-list">
                    <li>
                        <div class="prj-item" data-aos="fade-up">
                            <a href="#">
                                <div class="thumb" style="background-image: url(/images/secp/thumb1.jpg);">
                                    <div class="badge1">접수중</div>
                                </div>
                                <div class="txt">
                                    <p class="subject">(1단계) 역량강화_골목상권공동체_신규</p>
                                    <p class="date">2022.07.01 ~ 2022.12.31</p>
                                    <p class="view">자세히 보기 <span>+</span></p>
                                </div>
                            </a>
                        </div>
                    </li>
                </ul>
            </div>

        </div>

        <div class="main-bottom">
            <div class="content-width">
                <ul class="link-list">
                    <li>
                        <a href="/apply/list.do">
                            <h4>지원사업 신청</h4>
                            <p>공공 마이데이터 기반 비대면 신청 서비스를 제공합니다.</p>
                            <img src="/images/secp/ico_main_bottom1.svg" alt="">
                        </a>
                    </li>
                    <li>
                        <a href="/mybiz/index.do">
                            <h4>나의 신청 현황</h4>
                            <p>신청하신 사업의 처리 현황을 실시간으로 확인해 보세요.</p>
                            <img src="/images/secp/ico_main_bottom2.svg" alt="">
                        </a>
                    </li>
                    <li>
                        <a href="/intro/site-guide.do">
                            <h4>이용안내</h4>
                            <p>종합지원 포털에 대한 이용방법을 가이드 해 드립니다.</p>
                            <img src="/images/secp/ico_main_bottom3.svg" alt="">
                        </a>
                    </li>
                    <li>
                        <a href="/board/boardIndex.do?type=2">
                            <h4>자주 묻는 질문</h4>
                            <p>자주 물어보시는 질문에 대한 답변을 모아 보았습니다.</p>
                            <img src="/images/secp/ico_main_bottom4.svg" alt="">
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <button type="button" class="btn-top" title="맨 상단으로 이동"></button>

        <!--// 콘텐츠 영역 -->

        <!-- 푸터 영역 //-->
        <%@ include file="/WEB-INF/jsp/programs/footer.jsp" %>
        <!--// 푸터 영역 -->
    </div>
    
</body>

</html>