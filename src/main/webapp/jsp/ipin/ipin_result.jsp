<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page language="java" import="Kisinfo.Check.IPINClient" %>
<script type="text/javascript" src="<c:url value="/lib/js/jquery-3.5.1.min.js"/>"></script>
<%
	/********************************************************************************************************************************************
		NICE������ Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED
		
		���񽺸� : �����ֹι�ȣ���� (IPIN) ����
		�������� : �����ֹι�ȣ���� (IPIN) ��� ������
	*********************************************************************************************************************************************/
	
	String sSiteCode				= "L226";			// IPIN ���� ����Ʈ �ڵ�		(NICE���������� �߱��� ����Ʈ�ڵ�)
	String sSitePw					= "Child119";			// IPIN ���� ����Ʈ �н�����	(NICE���������� �߱��� ����Ʈ�н�����)
	
		
		// ����� ���� �� CP ��û��ȣ�� ��ȣȭ�� ����Ÿ�Դϴ�.
    String sResponseData = requestReplace(request.getParameter("enc_data"), "encodeData");
    String sReservedParam1  = requestReplace(request.getParameter("param_r1"), "");
    String sReservedParam2  = requestReplace(request.getParameter("param_r2"), "");
    
    // CP ��û��ȣ : ipin_main.jsp ���� ���� ó���� ����Ÿ
    String sCPRequest = (String)session.getAttribute("CPREQUEST");

    
    // ��ü ����
	IPINClient pClient = new IPINClient();
	
	
	/*
	�� ��ȣȭ �Լ� ����  ��������������������������������������������������������������������������������������������������������������������
		Method �����(iRtn)�� ����, ���μ��� ���࿩�θ� �ľ��մϴ�.
		
		fnResponse �Լ��� ��� ����Ÿ�� ��ȣȭ �ϴ� �Լ��̸�,
		'sCPRequest'���� �߰��� �����ø� CP��û��ȣ ��ġ���ε� Ȯ���ϴ� �Լ��Դϴ�. (���ǿ� ���� sCPRequest ����Ÿ�� ����)
		
		���� �ͻ翡�� ���ϴ� �Լ��� �̿��Ͻñ� �ٶ��ϴ�.
	������������������������������������������������������������������������������������������������������������������������������������������
	*/
	int iRtn = pClient.fnResponse(sSiteCode, sSitePw, sResponseData);
	//int iRtn = pClient.fnResponse(sSiteCode, sSitePw, sResponseData, sCPRequest);
	
	String sRtnMsg					= "";									// ó����� �޼���
	String sVNumber				= pClient.getVNumber();			// �����ֹι�ȣ (13�ڸ��̸�, ���� �Ǵ� ���� ����)
	String sName					= pClient.getName();				// �̸�
	String sDupInfo					= pClient.getDupInfo();				// �ߺ����� Ȯ�ΰ� (DI - 64 byte ������)
	String sAgeCode				= pClient.getAgeCode();			// ���ɴ� �ڵ� (���� ���̵� ����)
	String sGenderCode			= pClient.getGenderCode();		// ���� �ڵ� (���� ���̵� ����)
	String sBirthDate				= pClient.getBirthDate();			// ������� (YYYYMMDD)
	String sNationalInfo			= pClient.getNationalInfo();		// ��/�ܱ��� ���� (���� ���̵� ����)
	String sCPRequestNum			= pClient.getCPRequestNO();		// CP ��û��ȣ
	String sCiInfo					= pClient.getCipherData();	
			
	// Method ������� ���� ó������
	if (iRtn == 1)
	{
		/*
			������ ���� ����� ������ ������ �� �ֽ��ϴ�.
			����ڿ��� �����ִ� ������, '�̸�' ����Ÿ�� ���� �����մϴ�.
		
			����� ������ �ٸ� ���������� �̿��Ͻ� ��쿡��
			������ ���Ͽ� ��ȣȭ ����Ÿ(sResponseData)�� ����Ͽ� ��ȣȭ �� �̿��Ͻǰ��� �����մϴ�. (���� �������� ���� ó�����)
			
			����, ��ȣȭ�� ������ ����ؾ� �ϴ� ��쿣 ����Ÿ�� ������� �ʵ��� ������ �ּ���. (����ó�� ����)
			form �±��� hidden ó���� ����Ÿ ���� ������ �����Ƿ� �������� �ʽ��ϴ�.
		*/
		
		// ����� ���������� ���� ����
		
// 		out.println("�����ֹι�ȣ : " + sVNumber + "<BR>");
// 		out.println("�̸� : " + sName + "<BR>");
// 		out.println("�ߺ����� Ȯ�ΰ� (DI) : " + sDupInfo + "<BR>");
// 		out.println("������ȣ Ȯ�ΰ� (CI) : " + sDupInfo + "<BR>");
// 		out.println("���ɴ� �ڵ� : " + sAgeCode + "<BR>");
// 		out.println("���� �ڵ� : " + sGenderCode + "<BR>");
// 		out.println("������� : " + sBirthDate + "<BR>");
// 		out.println("��/�ܱ��� ���� : " + sNationalInfo + "<BR>");
// 		out.println("CP ��û��ȣ : " + sCPRequestNum + "<BR>");
// 		out.println("***** ��ȣȭ �� ������ �������� Ȯ���� �ֽñ� �ٶ��ϴ�.<BR><BR><BR><BR>");
		
		sRtnMsg = "���� ó���Ǿ����ϴ�.";
               
                session.setAttribute("name", sName);
                session.setAttribute("gender", sGenderCode);
                session.setAttribute("birth", sBirthDate);
                session.setAttribute("di", sDupInfo);
//                 session.setAttribute("ci", sCiInfo);
//                 session.setAttribute("cprno", sCPRequestNum);
                
                
                if("01".equals(sReservedParam1)) {//ȸ������
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
				}else if("02".equals(sReservedParam1)){//���̵� ã��
					%>
             		<script language='javascript'>
						var memDI = "<%=sDupInfo %>";
             			
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
				}else if("03".equals(sReservedParam1)){//��й�ȣ ã��
					%>
		     		<script language='javascript'>
						var memDI = "<%=sDupInfo %>";
		     			
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
				}else if("04".equals(sReservedParam1)){//�޸����
					session.setAttribute("dormancy", "pass");//�޸���� �н�
					%>
		     		<script language='javascript'>
		     		opener.ok();
					self.close();
		     		</script>
					<%
				}
	
	}
	else if (iRtn == -1 || iRtn == -4)
	{
		sRtnMsg =	"iRtn ��, ���� ȯ�������� ��Ȯ�� Ȯ���Ͽ� �ֽñ� �ٶ��ϴ�.";
	}
	else if (iRtn == -6)
	{
		sRtnMsg =	"���� �ѱ� charset ������ euc-kr �� ó���ϰ� ������, euc-kr �� ���ؼ� ����� �ֽñ� �ٶ��ϴ�.<BR>" +
					"�ѱ� charset ������ ��Ȯ�ϴٸ� ..<BR><B>iRtn ��, ���� ȯ�������� ��Ȯ�� Ȯ���Ͽ� ���Ϸ� ��û�� �ֽñ� �ٶ��ϴ�.</B>";
	}
	else if (iRtn == -9)
	{
		sRtnMsg = "�Է°� ���� : fnResponse �Լ� ó����, �ʿ��� �Ķ���Ͱ��� ������ ��Ȯ�ϰ� �Է��� �ֽñ� �ٶ��ϴ�.";
	}
	else if (iRtn == -12)
	{
		sRtnMsg = "CP ��й�ȣ ����ġ : IPIN ���� ����Ʈ �н����带 Ȯ���� �ֽñ� �ٶ��ϴ�.";
	}
	else if (iRtn == -13)
	{
		sRtnMsg = "CP ��û��ȣ ����ġ : ���ǿ� ���� sCPRequest ����Ÿ�� Ȯ���� �ֽñ� �ٶ��ϴ�.";
	}
	else
	{
		sRtnMsg = "iRtn �� Ȯ�� ��, NICE������ ���� ����ڿ��� ������ �ּ���.";
	}
        
        if (iRtn != 1)
            response.sendRedirect("/jsp/part_02_01.jsp");

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
	<title>NICE������ �����ֹι�ȣ ����</title>
	<style type="text/css">
	BODY
	{
		COLOR: #7f7f7f;
		FONT-FAMILY: "Dotum","DotumChe","Arial";
		BACKGROUND-COLOR: #ffffff;
	}
	</style>
</head>

<body>
<%-- iRtn : <%= iRtn %> - <%= sRtnMsg %><br><br> --%>

<!-- ����� ������ '�̸�' �ܿ��� ȭ�鿡 �����Ͻø� �ȵ˴ϴ�.
	 ����� ������ ����ؾ� �ϴ� ��쿣, �Ʒ��� ���� ��ȣȭ ������ ��� �� ��ȣȭ�Ͽ� �̿��Ͻñ� �ٶ��ϴ�.
	 ����, ��ȣȭ �� ����Ÿ�� ����ؾ� �ϴ� ��쿡�� ���������� ���Ͽ� ������ �ֽñ� �ٶ��ϴ�. -->
<%-- 	 
<table border="0">
<tr>
	<td>�̸� : <%= sName %></td>
</tr>

<form name="user" method="post">
	<input type="hidden" name="enc_data" value="<%=sResponseData %>"><br>
</form>
</table>
 --%>
</body>
</html>