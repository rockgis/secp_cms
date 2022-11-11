<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="double-submit" uri="http://www.egovframe.go.kr/tags/double-submit/jsp" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" import="Kisinfo.Check.IPINClient" %>
<%@ page language="java" import="com.mc.web.service.Globals" %>
<%
	String home_url = request.getScheme() + "://"
	    +  request.getServerName()
	    +  ((request.getServerPort()==80||request.getScheme()=="https")?"":":"+request.getServerPort());

	/********************************************************************************************************************************************
		NICE평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED
		
		서비스명 : 가상주민번호서비스 (IPIN) 서비스
		페이지명 : 가상주민번호서비스 (IPIN) 호출 페이지
	*********************************************************************************************************************************************/
	
	//String sSiteCode				= "L226";			// IPIN 서비스 사이트 코드		(NICE평가정보에서 발급한 사이트코드)
	//String sSitePw					= "Child119";			// IPIN 서비스 사이트 패스워드	(NICE평가정보에서 발급한 사이트패스워드)

	String sSiteCode				= Globals.IPIN_SITE_CODE;			// IPIN 서비스 사이트 코드		(NICE평가정보에서 발급한 사이트코드)
	String sSitePw					= Globals.IPIN_SITE_PASS;			// IPIN 서비스 사이트 패스워드	(NICE평가정보에서 발급한 사이트패스워드)
	
	String urlPrefix = "";
	if (request.getRequestURL().toString().startsWith("https")) {
		urlPrefix = "https://";
	} else {
		urlPrefix = "http://";
	}
	/*
	┌ sReturnURL 변수에 대한 설명  ─────────────────────────────────────────────────────
		NICE평가정보 팝업에서 인증받은 사용자 정보를 암호화하여 귀사로 리턴합니다.
		따라서 암호화된 결과 데이타를 리턴받으실 URL 정의해 주세요.
		
		* URL 은 http 부터 입력해 주셔야하며, 외부에서도 접속이 유효한 정보여야 합니다.
		* 당사에서 배포해드린 샘플페이지 중, ipin_process.jsp 페이지가 사용자 정보를 리턴받는 예제 페이지입니다.
		
		아래는 URL 예제이며, 귀사의 서비스 도메인과 서버에 업로드 된 샘플페이지 위치에 따라 경로를 설정하시기 바랍니다.
		예 - http://www.test.co.kr/ipin_process.jsp, https://www.test.co.kr/ipin_process.jsp, https://test.co.kr/ipin_process.jsp
	└────────────────────────────────────────────────────────────────────
	*/
	String sReturnURL				= home_url+"/jsp/ipin/ipin_process.jsp";
	
	
	/*
	┌ sCPRequest 변수에 대한 설명  ─────────────────────────────────────────────────────
		[CP 요청번호]로 귀사에서 데이타를 임의로 정의하거나, 당사에서 배포된 모듈로 데이타를 생성할 수 있습니다.
		
		CP 요청번호는 인증 완료 후, 암호화된 결과 데이타에 함께 제공되며
		데이타 위변조 방지 및 특정 사용자가 요청한 것임을 확인하기 위한 목적으로 이용하실 수 있습니다.
		
		따라서 귀사의 프로세스에 응용하여 이용할 수 있는 데이타이기에, 필수값은 아닙니다.
	└────────────────────────────────────────────────────────────────────
	*/
	String sCPRequest				= "";
	
	
	
	// 객체 생성
	IPINClient pClient = new IPINClient();
	
	
	// 앞서 설명드린 바와같이, CP 요청번호는 배포된 모듈을 통해 아래와 같이 생성할 수 있습니다.
	sCPRequest = pClient.getRequestNO(sSiteCode);
	
	// CP 요청번호를 세션에 저장합니다.
	// 현재 예제로 저장한 세션은 ipin_result.jsp 페이지에서 데이타 위변조 방지를 위해 확인하기 위함입니다.
	// 필수사항은 아니며, 보안을 위한 권고사항입니다.
	session.setAttribute("CPREQUEST" , sCPRequest);
	
	
	// Method 결과값(iRtn)에 따라, 프로세스 진행여부를 파악합니다.
	int iRtn = pClient.fnRequest(sSiteCode, sSitePw, sCPRequest, sReturnURL);
	
	String sRtnMsg					= "";			// 처리결과 메세지
	String sEncData					= "";			// 암호화 된 데이타
	
	// Method 결과값에 따른 처리사항
	if (iRtn == 0)
	{
	
		// fnRequest 함수 처리시 업체정보를 암호화한 데이터를 추출합니다.
		// 추출된 암호화된 데이타는 당사 팝업 요청시, 함께 보내주셔야 합니다.
		sEncData = pClient.getCipherData();		//암호화 된 데이타
		
		sRtnMsg = "정상 처리되었습니다.";
	
	}
	else if (iRtn == -1 || iRtn == -2)
	{
		sRtnMsg =	"배포해 드린 서비스 모듈 중, 귀사 서버환경에 맞는 모듈을 이용해 주시기 바랍니다.<BR>" +
					"귀사 서버환경에 맞는 모듈이 없다면 ..<BR><B>iRtn 값, 서버 환경정보를 정확히 확인하여 메일로 요청해 주시기 바랍니다.</B>";
	}
	else if (iRtn == -9)
	{
		sRtnMsg = "입력값 오류 : fnRequest 함수 처리시, 필요한 4개의 파라미터값의 정보를 정확하게 입력해 주시기 바랍니다.";
	}
	else
	{
		sRtnMsg = "iRtn 값 확인 후, NICE평가정보 개발 담당자에게 문의해 주세요.";
	}

%>

<%
    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();
    
    //String cSiteCode = "G8429";				// NICE로부터 부여받은 사이트 코드
    //String cSitePassword = "YQ5YS18WWNEX";		// NICE로부터 부여받은 사이트 패스워드
    String cSiteCode = Globals.NICE_SITE_CODE;				// NICE로부터 부여받은 사이트 코드
    String cSitePassword = Globals.NICE_SITE_PASS;		// NICE로부터 부여받은 사이트 패스워드

    String sRequestNumber = "REQ0000000001";        	// 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로 
    sRequestNumber = niceCheck.getRequestNO(cSiteCode);
  	session.setAttribute("REQ_SEQ" , sRequestNumber);	// 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.
  	
   	String sAuthType = "";      	// 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서
   	
   	String popgubun 	= "N";		//Y : 취소버튼 있음 / N : 취소버튼 없음
		String customize 	= "";			//없으면 기본 웹페이지 / Mobile : 모바일페이지
		
    // CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
    String sReturnUrl = home_url + "/jsp/checkplus/checkplus_success.jsp";      // 성공시 이동될 URL
    String sErrorUrl = home_url + "/jsp/checkplus/checkplus_fail.jsp";          // 실패시 이동될 URL

    // 입력될 plain 데이타를 만든다.
    String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
                        "8:SITECODE" + cSiteCode.getBytes().length + ":" + cSiteCode +
                        "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
                        "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
                        "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +
                        "11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun +
                        "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize;
    
    String sMessage = "";
    String cEncData = "";
    
    int iReturn = niceCheck.fnEncode(cSiteCode, cSitePassword, sPlainData);
    if( iReturn == 0 )
    {
        cEncData = niceCheck.getCipherData();
    }
    else if( iReturn == -1)
    {
        sMessage = "암호화 시스템 에러입니다.";
    }    
    else if( iReturn == -2)
    {
        sMessage = "암호화 처리오류입니다.";
    }    
    else if( iReturn == -3)
    {
        sMessage = "암호화 데이터 오류입니다.";
    }    
    else if( iReturn == -9)
    {
        sMessage = "입력 데이터 오류입니다.";
    }    
    else
    {
        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=10" />
<title>회원가입</title>
<script language='javascript'>
window.name ="Parent_window";
function fnPopup(){
	window.open('', 'popupIPIN2', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
	document.form_ipin.target = "popupIPIN2";
	document.form_ipin.action = "https://cert.vno.co.kr/ipin.cb";
	document.form_ipin.submit();
}

function cfnPopup(){
	window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
	document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
	document.form_chk.target = "popupChk";
	document.form_chk.submit();
}
function ok(){
	alert("휴면계정이 해지 되었습니다.\n로그인 후 이용하실 수 있습니다.");
	location.href="/web/lay4/program/S1T2C4/member/login.do?returnURL=/";
}
</script>
</head>
<body>
	
				<h3>휴면계정</h3>
				<div class="join_wrap">
					<div class="member_tit">
						<h4>휴먼계정 해지</h4>
					</div>
					<div class="join_box mb3">
						<p class="finish_txt"><b>${param.member_id }</b>님은 ${param.dormancy_day }일이상 로그인 되지 않아 휴면 상태로 전환되었습니다.</p>						
						<p class="join_txt2">안전한 개인정보보호를 위한 장기간 비사용 아이디는 휴면계정으로 전환하고 있습니다.<br>휴면계정은 본인인증을 통해 해지 후 로그인 할 수 있습니다.</p>
					</div>					
					<div class="certification mb3">
						<div class="mobile">
							<div>
								<h5>휴대폰 본인인증</h5>
								<p>본인 명의의 휴대전화를 통해 본인 인증을 <span>진행하실 경우 아래 버튼을 클릭하여 주십시오.</span></p>
							</div>
							<%if( iReturn == 0 ) {%>
								<a href="#" onclick="return cfnPopup();" title="휴대폰 인증 새창열림">휴대폰 인증하기</a>
							<%} else {%>
								<a href="#" onclick="alert('모듈이 제대로 동작되지 않습니다. 관리자에게 문의하시기 바랍니다.');return false;" title="휴대폰 인증 새창열림">휴대폰 인증하기</a>
							<%}%>
						</div>
						<div class="ipin">
							<div>
								<h5>아이핀 본인인증</h5>
								<p>본인 명의의 I-PIN 계정을 통해 인증을 확인하여
								<span>정보가 제공됩니다.</span>
								<span>타인 명의 I-PIN 계정을 통해서는 본인인증이</span>
								<span>불가합니다.</span>
								</p>
							</div>
							<%if( iRtn == 0 ) {%>
								<a href="#" onclick="return fnPopup();" title="아이핀 인증 새창열림">아이핀 인증하기</a>
							<%} else {%>
								<a href="#" onclick="alert('모듈이 제대로 동작되지 않습니다. 관리자에게 문의하시기 바랍니다.');return false;" title="아이핀 인증 새창열림">아이핀 인증하기</a>
							<%}%>
						</div>
					</div>
				</div>


<!-- 가상주민번호 서비스 팝업을 호출하기 위해서는 다음과 같은 form이 필요합니다. -->
<form name="form_ipin" method="post">
    <input type="hidden" name="m" value="pubmain">						<!-- 필수 데이타로, 누락하시면 안됩니다. -->
    <input type="hidden" name="enc_data" value="<%= sEncData %>">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
    
    <!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
    	 해당 파라미터는 추가하실 수 없습니다. -->
    <input type="hidden" name="param_r1" value="04">
    <input type="hidden" name="param_r2" value="">
    <input type="hidden" name="param_r3" value="">
</form>

<!-- 가상주민번호 서비스 팝업 페이지에서 사용자가 인증을 받으면 암호화된 사용자 정보는 해당 팝업창으로 받게됩니다.
	 따라서 부모 페이지로 이동하기 위해서는 다음과 같은 form이 필요합니다. -->
<form name="vnoform" method="post">
	<input type="hidden" name="enc_data">								<!-- 인증받은 사용자 정보 암호화 데이타입니다. -->
	
	<!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
    	 해당 파라미터는 추가하실 수 없습니다. -->
    <input type="hidden" name="param_r1" value="">
    <input type="hidden" name="param_r2" value="">
    <input type="hidden" name="param_r3" value="">
</form>

<!-- 본인인증 서비스 팝업을 호출하기 위해서는 다음과 같은 form이 필요합니다. -->
<form name="form_chk" method="post">
        <input type="hidden" name="m" value="checkplusSerivce">						<!-- 필수 데이타로, 누락하시면 안됩니다. -->
        <input type="hidden" name="EncodeData" value="<%= cEncData %>">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->

    	<!-- 
    	 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
         해당 파라미터는 추가하실 수 없습니다.  
         
         03 : 회원가입 등록화면으로 이동
         
         -->
        <input type="hidden" name="param_r1" value="04">
        <input type="hidden" name="param_r2" value="">
        <input type="hidden" name="param_r3" value="">
</form>
</body>
</html>
