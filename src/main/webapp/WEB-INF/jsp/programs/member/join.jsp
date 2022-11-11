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
    String sReturnUrl = urlStr + "/member/kcp-success.do";      // 성공시 이동될 URL
    String sErrorUrl = urlStr + "/member/kcp-fail.do";          // 실패시 이동될 URL

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
    <link rel="stylesheet" type="text/css" href="/css/secp/common.css">

	<script src="/js/secp/jquery-1.12.4.min.js"></script>
    <script src="/js/secp/jquery-ui.min.js"></script>
    <script src="/js/secp/common.js"></script>
    <script src="/js/secp/member/join.js"></script>
    <script language='javascript'>
		window.name ="Parent_window";
		
		function fnPopup(){
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
        <div class="sub-head sub5">
            <div class="content-width">
                <h2>회원가입</h2>
                <ul class="linemap">
                    <li><a href="index.html"><img src="/images/secp/ico_home_w.png" alt="홈"></a></li>
                    <li>회원가입</li>
                </ul>
            </div>
        </div>
        <!--// 서브헤드 -->

        <!-- 콘텐츠 영역 //-->
        <div class="sub-content">
            
            <div class="join-wrap">
                <div class="apply-write" id="apply-write">
                    <div class="apply-write-inner">
                        <ul class="step-list">
                            <li class="active"><img src="/images/secp/ico_step1_on.png" alt="">약관동의</li>
                            <li><img src="/images/secp/ico_step2.png" alt="">본인인증</li>
                            <li><img src="/images/secp/ico_step3.png" alt="">정보입력</li>
                            <li><img src="/images/secp/ico_step4.png" alt="">가입완료</li>
                        </ul>
                        <div class="join-lvl-container" data-idx="0">
	                        <div class="agree-item">
	                            <h3 class="agree-tit">개인정보 수집 · 이용 동의</h3>
	                            <input type="radio" name="radio1" id="radio1-1" value="Y">
	                            <label for="radio1-1">동의합니다</label>
	                            <input type="radio" name="radio1" id="radio1-2" value="N">
	                            <label for="radio1-2">동의하지 않습니다</label>
	                            <div class="agree-txt">
	                                내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 
	                                내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 
	                            </div>
	                        </div>
	                        <div class="agree-item">
	                            <h3 class="agree-tit">서비스 이용약관</h3>
	                            <input type="radio" name="radio2" id="radio2-1" value="Y">
	                            <label for="radio2-1">동의합니다</label>
	                            <input type="radio" name="radio2" id="radio2-2" value="N">
	                            <label for="radio2-2">동의하지 않습니다</label>
	                            <div class="agree-txt">
	                                내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 
	                                내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 
	                            </div>
	                        </div>
	                        
	                        <div class="ckagreeall">
	                            <input name="ckAgreeAll" type="checkbox" id="ckAgreeAll">
	                            <label for="ckAgreeAll">모든 이용약관에 동의합니다.</label>
	                        </div>
                        </div>
                        
                        <div class="join-lvl-container none" data-idx="1">
							<form name="form_chk" method="post">
								<input type="hidden" name="m" value="checkplusSerivce">
								<input type="hidden" name="EncodeData" value="<%= sEncData %>">
							    
								<input type="hidden" name="param_r1" value="01">
								<input type="hidden" name="param_r2" value="">
								<input type="hidden" name="param_r3" value="">
							</form>
                        	<div class="join-box">
	                            <h2 class="stit">본인인증</h2>
	                            <div>
	                                <img src="/images/secp/ico_selfok.svg" alt="" class="ico-selfok">
	                                <p>「개인정보보호법」 등 관련 법률(법령)에 의해 주민등록번호 수집·이용이 제한 및 기수집한 정보를 파기하여야 함에 따라 휴대폰 본인인증 으로 회원가입 및 로그인 하실 수 있습니다. 휴대폰 인증이란 주민등록번호 대체수단으로 회원님의 휴대전화를 통해 본인확인을 하는 서비스입니다.</p>
	                                <button type="button" class="btn btn-mint" id="join-auth-btn" onclick="fnPopup()">본인인증</button>
	                            </div>
	                        </div>
                        </div>
                        
                        <div class="join-lvl-container none" data-idx="2">
                        	<div class="apply-write-item">
	                            <h4 class="write-stit2">개인 정보 입력</h4>
	                            <table class="tbl-basic pd">
	                                <colgroup>
	                                    <col style="width: 30%;">
	                                    <col>
	                                </colgroup>
	                                <caption>개인 정보 입력</caption>
	                                <tbody>
	                                    <tr>
	                                        <th><span class="i-require">*</span> ID</th>
	                                        <td><div class="flexline"><input type="text" class="inp w100p" id="join-id"><button type="button" class="btn btn-black ml5" id="join-id-confirm">아이디 중복확인</button></div>
	                                            <p class="small mt10 c-red">* 아이디는 공백 없는 영문자(a~Z) 또는 숫자(0~9) 조합의 6자 이상 20자 이하이어야 합니다.</p>
	                                        </td>
	                                    </tr>
	                                    <tr>
	                                        <th><span class="i-require">*</span> 비밀번호</th>
	                                        <td><input type="password" class="inp w100p" id="join-pwd0"><br>
	                                            <p class="small mt10 c-red">* 비밀번호를 공백 없는 영문자(a~Z)와 숫자(0~9), 특수문자 (!@#$%^*) 조합의 6~20자 내에서 입력하여 주십시오.</p>
	                                        </td>
	                                    </tr>
	                                    <tr>
	                                        <th><span class="i-require">*</span> 비밀번호 재확인</th>
	                                        <td><input type="password" class="inp w100p" id="join-pwd1">
	                                        </td>
	                                    </tr>
	                                    <tr>
	                                        <th>이름</th>
	                                        <td><input type="text" class="inp w100p" id="join-name" value=""></td>
	                                    </tr>
	                                    <tr>
	                                        <th><span class="i-require">*</span> 생년월일<span class="small">(8자리 입력)</span></th>
	                                        <td><input type="text" class="inp w100p" value="" id="join-birth"></td>
	                                    </tr>
	                                    <tr>
	                                        <th><span class="i-require">*</span> 이메일</th>
	                                        <td>
	                                            <div class="flexline">
	                                                <input type="text" class="inp w50p" id="join-email">
	                                                <span class="ml5 mr5"> @ </span>
	                                                <select class="w50p" id="join-email-host">
	                                                	<option value="" selected="selected"></option>
	                                                    <option>naver.com</option>
	                                                </select>    
	                                            </div>
	                                        </td>
	                                    </tr>
	                                    <tr>
	                                        <th><span class="i-require">*</span> 휴대전화번호</th>
	                                        <td>
	                                            <div class="flexline">
	                                                <select class="w50p" id="join-phone0">
	                                                    <option>010</option>
	                                                </select>
	                                                <span class="ml5 mr5">-</span>
	                                                <input type="text" class="inp w50p" id="join-phone1" value="">
	                                                <span class="ml5 mr5">-</span>
	                                                <input type="text" class="inp w50p" id="join-phone2" value="">
	                                            </div>
	                                        </td>
	                                    </tr>
	                                    <tr>
	                                        <th><span class="i-require">*</span> 주소</th>
	                                        <td>
	                                            <div class="flexline mb10">
	                                                <input type="text" class="inp w100p" id="join-addr">
	                                                <button type="button" class="btn btn-gray ml5" id="join-addr-btn">주소검색</button>
	                                            </div>
	                                            <input type="text" class="inp w100p mb10">
	                                            <input type="text" class="inp w100p">
	                                        </td>
	                                    </tr>
	                                    <tr>
	                                        <th>이메일 수신 여부</th>
	                                        <td>
	                                            <label class="mr20"><input type="radio" name="radio1" checked="checked"> 예</label>
	                                            <label><input type="radio" name="radio1"> 아니오</label>
	                                            <br>
	                                            <p class="small">* 경기도시장상권진흥원에서 제공하는 유용한 정보 받음</p>
	                                        </td>
	                                    </tr>
	                                    <tr>
	                                        <th>문자 수신 여부</th>
	                                        <td>
	                                            <label class="mr20"><input type="radio" name="radio2" checked="checked"> 예</label>
	                                            <label><input type="radio" name="radio2"> 아니오</label>
	                                            <br>
	                                            <p class="small">* 경기도시장상권진흥원에서 제공하는 유용한 정보 받음</p>
	                                        </td>
	                                    </tr>
	                                    <tr>
	                                        <th><span class="i-require">*</span> 회원유형</th>
	                                        <td>
	                                            <label class="mr20"><input type="radio" name="radio3" class="join-user-type"> 예비창업</label>
	                                            <label class="mr20"><input type="radio" name="radio3" class="join-user-type"> 소상공인</label>
	                                            <label class="mr20"><input type="radio" name="radio3" class="join-user-type"> 전통시장</label>
	                                            <label class="mr20"><input type="radio" name="radio3" class="join-user-type"> 경영지원(컨설턴트)</label>
	                                            <label class="mr20"><input type="radio" name="radio3" class="join-user-type"> 폐업예정</label>
	                                        </td>
	                                    </tr>
	                                    <tr>
	                                        <th><span class="i-require">*</span> 관심업종</th>
	                                        <td>
	                                            <select id="store-cate0">
	                                                <option value="" selected="selected">업종 선택</option>
	                                            </select>
	                                            <select id="store-cate1">
	                                                <option value="" selected="selected">세부업종 선택</option>
	                                            </select>
	                                        </td>
	                                    </tr>
	                                    <tr>
	                                        <th><span class="i-require">*</span> 관심지역</th>
	                                        <td>
	                                            <select id="join-favor-region">
	                                                <option value="" selected="selected">선택</option>
	                                            </select>
	                                        </td>
	                                    </tr>
	                                    <tr>
	                                        <th><span class="i-require">*</span> 관심분야</th>
	                                        <td>
	                                            <label class="mr20"><input type="checkbox" name="checkbox1" class="join-favor-sbj"> 전체</label>
	                                            <label class="mr20"><input type="checkbox" name="checkbox1" class="join-favor-sbj"> 환경개선</label>
	                                            <label class="mr20"><input type="checkbox" name="checkbox1" class="join-favor-sbj"> 교육</label>
	                                            <label class="mr20"><input type="checkbox" name="checkbox1" class="join-favor-sbj"> 창업지원</label>
	                                            <label class="mr20"><input type="checkbox" name="checkbox1" class="join-favor-sbj"> 성장지원</label>
	                                            <label class="mr20"><input type="checkbox" name="checkbox1" class="join-favor-sbj"> 재기지원</label>
	                                            <label class="mr20"><input type="checkbox" name="checkbox1" class="join-favor-sbj"> 전통시장</label>
	                                            <label class="mr20"><input type="checkbox" name="checkbox1" class="join-favor-sbj"> 컨설팅</label>
	                                            <label class="mr20"><input type="checkbox" name="checkbox1" class="join-favor-sbj"> 기타</label>
	                                        </td>
	                                    </tr>
	                                </tbody>
	                            </table>
	
	                            <br><br>
	
	                            <h4 class="write-stit2">사업자 정보 입력</h4>
	                            <table class="tbl-basic pd">
	                                <colgroup>
	                                    <col style="width: 30%;">
	                                    <col>
	                                </colgroup>
	                                <caption>업체 정보 입력</caption>
	                                <tbody>
	                                    <tr>
	                                        <th>업체명</th>
	                                        <td><input type="text" class="inp w100p" id="join-store-name"></td>
	                                    </tr>
	                                    <tr>
	                                        <th>사업자등록번호</th>
	                                        <td><div class="flexline"><input type="text" class="inp w100p" id="join-bsns-num"><button type="button" class="btn btn-black ml5" id="bsns-num-search-btn">사업자번호 조회</button></div>
	                                            <p class="small mt10 c-red">예시) 123-45-67890</p>
	                                        </td>
	                                    </tr>
	                                    <tr>
	                                        <th>사업개시일<br><span class="small">(사업자등록증 기준)</span></th>
	                                        <td><input type="text" class="inp w100p" id="join-bsns-start-date">
	                                            <p class="small mt10 c-red">예시) 2019-02-21</p>
	                                        </td>
	                                    </tr>
	                                    <tr>
	                                        <th>사업장 소재지</th>
	                                        <td><input type="text" class="inp w100p" id="join-store-region">
	                                            <p class="small mt10 c-red">예시) 수원시 팔달구 경수대로446번길 24</p>
	                                        </td>
	                                    </tr>
	                                    <tr>
	                                        <th>사업장 전화번호</th>
	                                        <td>
	                                            <div class="flexline">
	                                                <select class="w50p" id="join-store-phone0">
	                                                    <option>010</option>
	                                                </select>
	                                                <span class="ml5 mr5">-</span>
	                                                <input type="text" class="inp w50p" id="join-store-phone1" value="">
	                                                <span class="ml5 mr5">-</span>
	                                                <input type="text" class="inp w50p" id="join-store-phone2" value="">
	                                            </div>
	                                        </td>
	                                    </tr>
	                                </tbody>
	                            </table>
	                        </div>
                        </div>
                        
                        <div class="join-lvl-container none" data-idx="3">
                        	<div class="join-box">
	                            <h2 class="stit">가입완료</h2>
	                            <div class="inbl">
	                                <img src="/images/secp/ico_complete.svg" alt="" class="ico-complete">
	                                <p class="txt">경기도 소상공인 종합지원 포털 <br>회원가입이 완료되었습니다.</p>
	                            </div>
	                        </div>
                        </div>
                        
                        <div class="btn-step-wrap">
                            <a href="#" class="btn-step-round gray" id="cancel-btn">취소</a>
                            <a href="#" class="btn-step-round" id="next-btn">다음 <img src="/images/secp/ico_bt_arrow_right.svg" alt=""></a>
                            <a href="#" class="btn-step-round none" id="cplt-btn">완료 <img src="/images/secp/ico_bt_arrow_right.svg" alt=""></a>
                            <a href="#" class="btn-step-round btn-white none" id="main-btn">메인으로 가기 <img src="/images/secp/ico_bt_arrow_right_black.svg" alt=""></a>
                            <a href="/member/login.do" class="btn-step-round none" id="login-btn">로그인 하러 가기 <img src="/images/secp/ico_bt_arrow_right.svg" alt=""></a>
                        </div>
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