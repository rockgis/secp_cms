<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta property="og:image" content="">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>경기도 소상공인 종합지원 플랫폼</title>

    <link rel="stylesheet" type="text/css" href="/css/secp/jquery.splitter.css">
    <link rel="stylesheet" type="text/css" href="/css/secp/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="/css/secp/common.css">

	<script src="/js/secp/jquery-1.12.4.min.js"></script>
    <script src="/js/secp/jquery.splitter.js"></script>
    <script src="/js/secp/jquery-ui.min.js"></script>
    <script src="/js/secp/common.js"></script>
    <script>
        $(function () {

            // 메뉴 초기화
            $(function () {
                $.initmenu(2,2);
            });

        });
        
        $(document).ready(function() {
        	// 중간시연을 위한 임시 프로세스
        	setTimeout(function() {
				$('.lading-step li').removeClass('active');
				$('#lvl-proc').addClass('active');
				
				setTimeout(function() {
					$('.lading-step li').removeClass('active');
					$('#lvl-valid').addClass('active');
				}, 2000);
			}, 1000);
        	
        	/* $.ajax({
        		url: '',
        		type: 'POST',
        		data: {},
        		success: function(data) {
        			console.log(data);
        		},
        		error: function(e) {
        			console.error(e);
        		}
        	}); */
        });
    </script>
</head>

<body>
    <div class="wrap">
        <!-- 상단 영역 //-->
        <%@ include file="/WEB-INF/jsp/programs/header.jsp" %>
        <!--// 상단 영역 -->

        <!-- 서브 헤드 //-->
        <div class="sub-head sub2">
            <div class="content-width">
                <h2>간편접수</h2>
                <ul class="linemap">
                    <li><a href="/"><img src="/images/secp/ico_home_w.png" alt="홈"></a></li>
                    <li>지원 신청</li>
                    <li>간편 접수</li>
                </ul>
            </div>
        </div>
        <!--// 서브헤드 -->

        <!-- 콘텐츠 영역 //-->
        <div class="sub-content">
            <div class="easyapply-wrap">
                <h3 class="tit2">필수 자격 확인</h3>
                
                <div class="loading-wrap">
                    <img src="/images/secp/loading-top.jpg" alt="" class="loading-head">
                    <p>행정안전부에서 제공하는 <span class="c-orange">마이데이터</span> 서비스를 이용하여 정보를 확인하는 중입니다.</p>
                    <p>잠시만 기다려주세요.</p>
                    <div class="loadingbar">
                        <div class="area">
                            <div class="dot1"></div>
                            <div class="dot2"></div>
                            <div class="dot3"></div>
                        </div>
                    </div>   
                    <ul class="lading-step">
                        <li class="active" id="lvl-req">마이데이터 요청중</li>
                        <li id="lvl-proc">마이데이터 처리중</li>
                        <li id="lvl-valid">필수자격 확인중</li>
                    </ul>
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