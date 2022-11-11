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
    <script src="/js/secp/biz/bizCmm.js"></script>
    <script>
        $(function () {

            // 메뉴 초기화
            $(function () {
                $.initmenu(2,2);
            });

        });
        
        $(document).ready(function() {
        	$('#btn-next').on('click', function(e) {
        		e.preventDefault();
        		
        		const regiNum1 = $('#regi-num-1').val();
        		const regiNum2 = $('#regi-num-2').val();
        		if (regiNum1.length !== 6 || regiNum2.length !== 7) {
        			alert('올바른 주민등록번호를 입력하세요.');
        			return;
        		}
        		
        		const bsnsNum = $('#bsns-num').val();
        		if (bsnsNum !== '') {
	        		if (!window['BIZ_CMM'].validBsnsNum(bsnsNum)) {
	        			alert('올바른 사업자등록번호를 입력하세요.');
	        			return;
	        		}
        		}
        		
        		window.location.href = '/apply/easy/mydata-req.do';
        	});
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
                <p class="desc">※ 행정안전부에서 제공하는 마이데이터 서비스를 이용하여 필요서류를 확인합니다. <br>
                    서비스 이용자수에 따라 다소 시간이 소요될수 있습니다.</p>
                
                <div class="input-wrap">
                    <h3 class="tit3">주민번호</h3>
                    <div class="flexline">
                        <input type="text" class="inp w50p" id="regi-num-1" maxlength="6">
                        <span class="ml5 mr5">-</span>
                        <input type="password" class="inp w50p" id="regi-num-2" maxlength="7">
                    </div>
                    <br>
                    <h3 class="tit3">사업자등록번호</h3>
                    <div class="flexline">
                        <input type="text" class="inp w100p" id="bsns-num" placeholder="숫자만 입력하세요.">
                    </div>
                </div>

                <div class="btn-step-wrap">
                    <a href="#" class="btn-step-round" id="btn-next">다음 단계 <img src="/images/secp/ico_bt_arrow_right.svg" alt=""></a>
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