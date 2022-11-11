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
        	$('#btn-next').on('click', function(e) {
        		e.preventDefault();
        		const radioVal = $('input[name="agree"]:checked').val();
        		if (typeof radioVal === 'undefined' || radioVal === 'N' || radioVal === '') {
        			alert('마이데이터에 이용 동의를 해야 간편 접수를 진행할 수 있습니다.');
        		} else {
        			window.location.href = '/apply/easy/self-auth.do';
        		}
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
                <h2 class="tit1">경기도 소상공인 맞춤형 종합지원사업</h2>
                <h3 class="tit2">마이데이터 이용동의</h3>
                <p class="desc">※ 행정안전부에서 제공하는 마이데이터를 연계하여 <span class="c-orange">제출서류를 간소화</span>하여 접수 신청할 수 있습니다.</p>
                
                <div class="scrollbox">
                    마이데이터 이용동의 내용이 들어가는 자리입니다. 마이데이터 이용동의 내용이 들어가는 자리입니다. 마이데이터 이용동의 내용이 들어가는 자리입니다. 마이데이터 이용동의 내용이 들어가는 자리입니다. 마이데이터 이용동의 내용이 들어가는 자리입니다. 마이데이터 이용동의 내용이 들어가는 자리입니다. 마이데이터 이용동의 내용이 들어가는 자리입니다. 마이데이터 이용동의 내용이 들어가는 자리입니다. 마이데이터 이용동의 내용이 들어가는 자리입니다. 마이데이터 이용동의 내용이 들어가는 자리입니다. 마이데이터 이용동의 내용이 들어가는 자리입니다. <br>
                    마이데이터 이용동의 내용이 들어가는 자리입니다. 마이데이터 이용동의 내용이 들어가는 자리입니다. 마이데이터 이용동의 내용이 들어가는 자리입니다. 마이데이터 이용동의 내용이 들어가는 자리입니다. 마이데이터 이용동의 내용이 들어가는 자리입니다. 마이데이터 이용동의 내용이 들어가는 자리입니다. 마이데이터 이용동의 내용이 들어가는 자리입니다. 마이데이터 이용동의 내용이 들어가는 자리입니다. 
                </div>
                
                <div class="radio-wrap">
                    <div>
                        <label><input type="radio" name="agree" id="agree-y" value="Y"> 전체 동의내역에 동의합니다.</label>
                    </div>
                    <div>
                        <label><input type="radio" name="agree" id="agree-n" value="N" checked> 아니오. 동의하지 않습니다.</label>
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