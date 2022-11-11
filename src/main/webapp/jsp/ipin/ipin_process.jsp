<%@ page contentType="text/html;charset=euc-kr" %>

<%
	/*********************************************************************************************
		NICE������ Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED
		
		���񽺸� : �����ֹι�ȣ���� (IPIN) ����
		�������� : �����ֹι�ȣ���� (IPIN) ����� ���� ���� ó�� ������
		
				   ���Ź��� ������(�������)�� ����ȭ������ �ǵ����ְ�, close�� �ϴ� ��Ȱ�� �մϴ�.
	**********************************************************************************************/
	
	// ����� ���� �� CP ��û��ȣ�� ��ȣȭ�� ����Ÿ�Դϴ�. (ipin_main.jsp ���������� ��ȣȭ�� ����Ÿ�ʹ� �ٸ��ϴ�.)
	String sResponseData = requestReplace(request.getParameter("enc_data"), "encodeData");
	
	// ipin_main.jsp ���������� ������ ����Ÿ�� �ִٸ�, �Ʒ��� ���� Ȯ�ΰ����մϴ�.
	String sReservedParam1  = requestReplace(request.getParameter("param_r1"), "");
	String sReservedParam2  = requestReplace(request.getParameter("param_r2"), "");
	String sReservedParam3  = requestReplace(request.getParameter("param_r3"), "");
    
    
    // ��ȣȭ�� ����� ������ �����ϴ� ���
    if (!sResponseData.equals("") && sResponseData != null)
    {

%>

<html>
<head>
	<title>NICE������ �����ֹι�ȣ ����</title>
	<script language='javascript'>
		function fnLoad()
		{
			// ��翡���� �ֻ����� �����ϱ� ���� 'parent.opener.parent.document.'�� �����Ͽ����ϴ�.
// 			// ���� �ͻ翡 ���μ����� �°� �����Ͻñ� �ٶ��ϴ�.
<%-- 			parent.opener.parent.document.vnoform.enc_data.value = "<%= sResponseData %>"; --%>
			
<%-- 			parent.opener.parent.document.vnoform.param_r1.value = "<%= sReservedParam1 %>"; --%>
<%-- 			parent.opener.parent.document.vnoform.param_r2.value = "<%= sReservedParam2 %>"; --%>
<%-- 			parent.opener.parent.document.vnoform.param_r3.value = "<%= sReservedParam3 %>"; --%>
			
// 			parent.opener.parent.document.vnoform.target = "Parent_window";
			
// 			// ���� �Ϸ�ÿ� ��������� �����ϰ� �Ǵ� �ͻ� Ŭ���̾�Ʈ ��� ������ URL
// 			parent.opener.parent.document.vnoform.action = "/jsp/ipin/ipin_result.jsp";
// 			parent.opener.parent.document.vnoform.submit();
			
			
			document.vnoform.enc_data.value = "<%= sResponseData %>"; 
						
			document.vnoform.param_r1.value = "<%= sReservedParam1 %>";
			document.vnoform.param_r2.value = "<%= sReservedParam2 %>";
			document.vnoform.param_r3.value = "<%= sReservedParam3 %>";
						
// 			document.vnoform.target = "Parent_window";
			
			// ���� �Ϸ�ÿ� ��������� �����ϰ� �Ǵ� �ͻ� Ŭ���̾�Ʈ ��� ������ URL
			document.vnoform.action = "/jsp/ipin/ipin_result.jsp";
			document.vnoform.submit();
			
// 			self.close();
		}
	</script>
</head>
<body onLoad="fnLoad()">

<%
	} else {
%>

<html>
<head>
	<title>NICE������ �����ֹι�ȣ ����</title>
	<body onLoad="self.close()">

<%
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
<!-- �����ֹι�ȣ ���� �˾� ���������� ����ڰ� ������ ������ ��ȣȭ�� ����� ������ �ش� �˾�â���� �ްԵ˴ϴ�.
	 ���� �θ� �������� �̵��ϱ� ���ؼ��� ������ ���� form�� �ʿ��մϴ�. -->
<form name="vnoform" method="post">
	<input type="hidden" name="enc_data">								<!-- �������� ����� ���� ��ȣȭ ����Ÿ�Դϴ�. -->
	
	<!-- ��ü���� ����ޱ� ���ϴ� ����Ÿ�� �����ϱ� ���� ����� �� ������, ������� ����� �ش� ���� �״�� �۽��մϴ�.
    	 �ش� �Ķ���ʹ� �߰��Ͻ� �� �����ϴ�. -->
    <input type="hidden" name="param_r1" value="">
    <input type="hidden" name="param_r2" value="">
    <input type="hidden" name="param_r3" value="">
</form>
</body>
</html>