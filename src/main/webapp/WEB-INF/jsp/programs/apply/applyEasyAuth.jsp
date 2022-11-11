<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();
    
    String sSiteCode = "BQ042";				   // NICE로부터 부여받은 사이트 코드
    String sSitePassword = "iI0mOFhk7JGO";			 // NICE로부터 부여받은 사이트 패스워드
    
    String sRequestNumber = "REQ0000000001";        	// 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로 
                                                    	// 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
    sRequestNumber = niceCheck.getRequestNO(sSiteCode);
  	session.setAttribute("REQ_SEQ" , sRequestNumber);	// 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.
  	
   	String sAuthType = "";      	// 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서
   	
   	String popgubun 	= "N";		//Y : 취소버튼 있음 / N : 취소버튼 없음
		String customize 	= "";			//없으면 기본 웹페이지 / Mobile : 모바일페이지
		
    // CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
    String urlStr = request.getHeader("origin");
    String sReturnUrl = urlStr + "/apply/easy/kcp-success.do";      // 성공시 이동될 URL
    String sErrorUrl = urlStr + "/apply/easy/kcp-fail.do";          // 실패시 이동될 URL

    // 입력될 plain 데이타를 만든다.
    String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
                        "8:SITECODE" + sSiteCode.getBytes().length + ":" + sSiteCode +
                        "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
                        "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
                        "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +
                        "11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun +
                        "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize;
    
    String sMessage = "";
    String sEncData = "";
    
    int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
    if( iReturn == 0 ) {
        sEncData = niceCheck.getCipherData();
    } else if( iReturn == -1) {
        sMessage = "암호화 시스템 에러입니다.";
    } else if( iReturn == -2) {
        sMessage = "암호화 처리오류입니다.";
    } else if( iReturn == -3) {
        sMessage = "암호화 데이터 오류입니다.";
    } else if( iReturn == -9) {
        sMessage = "입력 데이터 오류입니다.";
    } else {
        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
    }
%>
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
        		window.location.href = '/apply/easy/prvlg.do';
        	});
        });
    </script>
    <script language='javascript'>
		window.name ="Parent_window";
		
		function fnPopup() {
			window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
			document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
			document.form_chk.target = "popupChk";
			document.form_chk.submit();
		}
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
                <h3 class="tit2">본인인증</h3>
                
                <div class="join-box">
                    <div>
                        <img src="/images/secp/ico_selfok.svg" alt="" class="ico-selfok">
                        <p>「개인정보보호법」 등 관련 법률(법령)에 의해 주민등록번호 수집·이용이 제한 및 기수집한 정보를 파기하여야 함에 따라 휴대폰 본인인증 으로 회원가입 및 로그인 하실 수 있습니다. 휴대폰 인증이란 주민등록번호 대체수단으로 회원님의 휴대전화를 통해 본인확인을 하는 서비스입니다.</p>
                        <form name="form_chk" method="post">
							<input type="hidden" name="m" value="checkplusSerivce">
							<input type="hidden" name="EncodeData" value="<%= sEncData %>">
						    
							<input type="hidden" name="param_r1" value="01">
							<input type="hidden" name="param_r2" value="">
							<input type="hidden" name="param_r3" value="">
						</form>
                        <button type="button" class="btn btn-mint" onclick="fnPopup()">본인인증</button>
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