<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page language="java" import="com.mc.web.service.Globals" %> 
<script type="text/javascript" src="<c:url value="/lib/js/jquery-3.5.1.min.js"/>"></script>
<%
    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

    String sEncodeData = requestReplace(request.getParameter("EncodeData"), "encodeData");
    String sReserved1  = requestReplace(request.getParameter("param_r1"), "");
    String sReserved2  = requestReplace(request.getParameter("param_r2"), "");
    String sReserved3  = requestReplace(request.getParameter("param_r3"), "");

    //String sSiteCode = "G8429";				   // NICE로부터 부여받은 사이트 코드
    //String sSitePassword = "YQ5YS18WWNEX";			 // NICE로부터 부여받은 사이트 패스워드
    String sSiteCode = Globals.NICE_SITE_CODE;				   // NICE로부터 부여받은 사이트 코드
    String sSitePassword = Globals.NICE_SITE_PASS;			 // NICE로부터 부여받은 사이트 패스워드

    String sCipherTime = "";				 // 복호화한 시간
    String sRequestNumber = "";			 // 요청 번호
    String sResponseNumber = "";		 // 인증 고유번호
    String sAuthType = "";				   // 인증 수단
    String sName = "";							 // 성명
    String sDupInfo = "";						 // 중복가입 확인값 (DI_64 byte)
    String sConnInfo = "";					 // 연계정보 확인값 (CI_88 byte)
    String sBirthDate = "";					 // 생일
    String sGender = "";						 // 성별
    String sNationalInfo = "";       // 내/외국인정보 (개발가이드 참조)
    String sMessage = "";
    String sPlainData = "";
    
    int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

    if( iReturn == 0 )
    {
        sPlainData = niceCheck.getPlainData();
        sCipherTime = niceCheck.getCipherDateTime();
        
        // 데이타를 추출합니다.
        java.util.HashMap mapresult = niceCheck.fnParse(sPlainData);
        
        sRequestNumber  = (String)mapresult.get("REQ_SEQ");
        sResponseNumber = (String)mapresult.get("RES_SEQ");
        sAuthType 			= (String)mapresult.get("AUTH_TYPE");
        sName 					= (String)mapresult.get("NAME");
        sBirthDate 			= (String)mapresult.get("BIRTHDATE");
        sGender 				= (String)mapresult.get("GENDER");
        sNationalInfo  	= (String)mapresult.get("NATIONALINFO");
        sDupInfo 				= (String)mapresult.get("DI");
        sConnInfo 			= (String)mapresult.get("CI");
        
        String session_sRequestNumber = (String)session.getAttribute("REQ_SEQ");
        if(!sRequestNumber.equals(session_sRequestNumber))
        {
            sMessage = "세션값이 다릅니다. 올바른 경로로 접근하시기 바랍니다.";
            sResponseNumber = "";
            sAuthType = "";
        }
        session.setAttribute("name", sName);
        session.setAttribute("gender", sGender);
        session.setAttribute("birth", sBirthDate);
        session.setAttribute("di", sDupInfo);

        if("01".equals(sReserved1)) {//회원가입
			%>
     		<script language='javascript'>
     			var memDI = "<%=sDupInfo %>";
     			
     			// 회원인증값 중복체크
     			$.ajax({
     			 	url: "/member/niceDIChk.do",
     			 	type: "POST",
     				data: {di : memDI},
     				success:function (data) { 

     					 if( data.rst == "Y" ){ 
     						alert("이미 등록된 회원입니다.\n아이디 찾기나 비밀번호 찾기를 이용해주세요.");
     						self.close();
     					 } else {
     						opener.location.href = "/web/lay4/program/S1T2C4/member/join_step2.do";
     						self.close();
     					 }
     			 	 },
     			 	error:function(request,status,error){
     					//ajax 실행관련된 오류발생시 확인 구문
     		        	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
     		       }
     			});
     		</script>
			<%
		}else if("02".equals(sReserved1)){//아이디 찾기
			%>
     		<script language='javascript'>
				var memDI = "<%=sDupInfo %>";
     			
     			// 회원인증값 중복체크
     			$.ajax({
					url: "/member/getDiMember.do",
     			 	type: "POST",
     				data: {di : memDI},
     				success:function (data) { 
						if(data.rst=="Y"){
							opener.ok(data.info);
     						self.close();
						}else{
     						opener.location.href = "/web/lay4/program/S1T2C4/member/id_search_fail.do";
     						self.close();
						}
     			 	},
     			 	error:function(request,status,error){
     					//ajax 실행관련된 오류발생시 확인 구문
     		        	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
     		       }
     			});
     		</script>
			<%
		}else if("03".equals(sReserved1)){//비밀번호 찾기
			%>
     		<script language='javascript'>
				var memDI = "<%=sDupInfo %>";
     			
     			// 회원인증값 중복체크
     			$.ajax({
					url: "/member/getDiMember.do",
     			 	type: "POST",
     				data: {di : memDI},
     				success:function (data) { 
						if(data.rst=="Y"){
							opener.ok(data.info);
     						self.close();
						}else{
     						opener.location.href = "/web/lay4/program/S1T2C4/member/pw_search_fail.do";
     						self.close();
						}
     			 	},
     			 	error:function(request,status,error){
     					//ajax 실행관련된 오류발생시 확인 구문
     		        	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
     		       }
     			});
     		</script>
			<%
		}else if("04".equals(sReserved1)){//휴면계정
			session.setAttribute("dormancy", "pass");//휴면계정 패스
			%>
     		<script language='javascript'>
     		opener.ok();
			self.close();
     		</script>
			<%
		}
        
    }
    else if( iReturn == -1)
    {
        sMessage = "복호화 시스템 에러입니다.";
    }    
    else if( iReturn == -4)
    {
        sMessage = "복호화 처리오류입니다.";
    }    
    else if( iReturn == -5)
    {
        sMessage = "복호화 해쉬 오류입니다.";
    }    
    else if( iReturn == -6)
    {
        sMessage = "복호화 데이터 오류입니다.";
    }    
    else if( iReturn == -9)
    {
        sMessage = "입력 데이터 오류입니다.";
    }    
    else if( iReturn == -12)
    {
        sMessage = "사이트 패스워드 오류입니다.";
    }    
    else
    {
        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
    }
   
%>
<%!

	public String requestReplace (String paramValue, String gubun) {

        String result = "";
        
        if (paramValue != null) {
        	
        	paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

        	paramValue = paramValue.replaceAll("\\*", "");
        	paramValue = paramValue.replaceAll("\\?", "");
        	paramValue = paramValue.replaceAll("\\[", "");
        	paramValue = paramValue.replaceAll("\\{", "");
        	paramValue = paramValue.replaceAll("\\(", "");
        	paramValue = paramValue.replaceAll("\\)", "");
        	paramValue = paramValue.replaceAll("\\^", "");
        	paramValue = paramValue.replaceAll("\\$", "");
        	paramValue = paramValue.replaceAll("'", "");
        	paramValue = paramValue.replaceAll("@", "");
        	paramValue = paramValue.replaceAll("%", "");
        	paramValue = paramValue.replaceAll(";", "");
        	paramValue = paramValue.replaceAll(":", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll("#", "");
        	paramValue = paramValue.replaceAll("--", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll(",", "");
        	
        	if(gubun != "encodeData"){
        		paramValue = paramValue.replaceAll("\\+", "");
        		paramValue = paramValue.replaceAll("/", "");
            paramValue = paramValue.replaceAll("=", "");
        	}
        	
        	result = paramValue;
            
        }
        return result;
  }
%>

<html>
<head>
    <title>NICE평가정보 - CheckPlus 안심본인인증 테스트</title>
</head>
<body>
</body>
</html>