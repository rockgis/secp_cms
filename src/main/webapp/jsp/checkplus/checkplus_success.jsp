<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page language="java" import="com.mc.web.service.Globals" %> 
<script type="text/javascript" src="<c:url value="/lib/js/jquery-3.5.1.min.js"/>"></script>
<%
    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

    String sEncodeData = requestReplace(request.getParameter("EncodeData"), "encodeData");
    String sReserved1  = requestReplace(request.getParameter("param_r1"), "");
    String sReserved2  = requestReplace(request.getParameter("param_r2"), "");
    String sReserved3  = requestReplace(request.getParameter("param_r3"), "");

    //String sSiteCode = "G8429";				   // NICE�κ��� �ο����� ����Ʈ �ڵ�
    //String sSitePassword = "YQ5YS18WWNEX";			 // NICE�κ��� �ο����� ����Ʈ �н�����
    String sSiteCode = Globals.NICE_SITE_CODE;				   // NICE�κ��� �ο����� ����Ʈ �ڵ�
    String sSitePassword = Globals.NICE_SITE_PASS;			 // NICE�κ��� �ο����� ����Ʈ �н�����

    String sCipherTime = "";				 // ��ȣȭ�� �ð�
    String sRequestNumber = "";			 // ��û ��ȣ
    String sResponseNumber = "";		 // ���� ������ȣ
    String sAuthType = "";				   // ���� ����
    String sName = "";							 // ����
    String sDupInfo = "";						 // �ߺ����� Ȯ�ΰ� (DI_64 byte)
    String sConnInfo = "";					 // �������� Ȯ�ΰ� (CI_88 byte)
    String sBirthDate = "";					 // ����
    String sGender = "";						 // ����
    String sNationalInfo = "";       // ��/�ܱ������� (���߰��̵� ����)
    String sMessage = "";
    String sPlainData = "";
    
    int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

    if( iReturn == 0 )
    {
        sPlainData = niceCheck.getPlainData();
        sCipherTime = niceCheck.getCipherDateTime();
        
        // ����Ÿ�� �����մϴ�.
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
            sMessage = "���ǰ��� �ٸ��ϴ�. �ùٸ� ��η� �����Ͻñ� �ٶ��ϴ�.";
            sResponseNumber = "";
            sAuthType = "";
        }
        session.setAttribute("name", sName);
        session.setAttribute("gender", sGender);
        session.setAttribute("birth", sBirthDate);
        session.setAttribute("di", sDupInfo);

        if("01".equals(sReserved1)) {//ȸ������
			%>
     		<script language='javascript'>
     			var memDI = "<%=sDupInfo %>";
     			
     			// ȸ�������� �ߺ�üũ
     			$.ajax({
     			 	url: "/member/niceDIChk.do",
     			 	type: "POST",
     				data: {di : memDI},
     				success:function (data) { 

     					 if( data.rst == "Y" ){ 
     						alert("�̹� ��ϵ� ȸ���Դϴ�.\n���̵� ã�⳪ ��й�ȣ ã�⸦ �̿����ּ���.");
     						self.close();
     					 } else {
     						opener.location.href = "/web/lay4/program/S1T2C4/member/join_step2.do";
     						self.close();
     					 }
     			 	 },
     			 	error:function(request,status,error){
     					//ajax ������õ� �����߻��� Ȯ�� ����
     		        	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
     		       }
     			});
     		</script>
			<%
		}else if("02".equals(sReserved1)){//���̵� ã��
			%>
     		<script language='javascript'>
				var memDI = "<%=sDupInfo %>";
     			
     			// ȸ�������� �ߺ�üũ
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
     					//ajax ������õ� �����߻��� Ȯ�� ����
     		        	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
     		       }
     			});
     		</script>
			<%
		}else if("03".equals(sReserved1)){//��й�ȣ ã��
			%>
     		<script language='javascript'>
				var memDI = "<%=sDupInfo %>";
     			
     			// ȸ�������� �ߺ�üũ
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
     					//ajax ������õ� �����߻��� Ȯ�� ����
     		        	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
     		       }
     			});
     		</script>
			<%
		}else if("04".equals(sReserved1)){//�޸����
			session.setAttribute("dormancy", "pass");//�޸���� �н�
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
        sMessage = "��ȣȭ �ý��� �����Դϴ�.";
    }    
    else if( iReturn == -4)
    {
        sMessage = "��ȣȭ ó�������Դϴ�.";
    }    
    else if( iReturn == -5)
    {
        sMessage = "��ȣȭ �ؽ� �����Դϴ�.";
    }    
    else if( iReturn == -6)
    {
        sMessage = "��ȣȭ ������ �����Դϴ�.";
    }    
    else if( iReturn == -9)
    {
        sMessage = "�Է� ������ �����Դϴ�.";
    }    
    else if( iReturn == -12)
    {
        sMessage = "����Ʈ �н����� �����Դϴ�.";
    }    
    else
    {
        sMessage = "�˼� ���� ���� �Դϴ�. iReturn : " + iReturn;
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
    <title>NICE������ - CheckPlus �Ƚɺ������� �׽�Ʈ</title>
</head>
<body>
</body>
</html>