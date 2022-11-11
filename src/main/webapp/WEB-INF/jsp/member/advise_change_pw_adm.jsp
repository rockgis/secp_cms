<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<sec:csrfMetaTags/>
<title>홈 비밀번호 변경</title>
<link href="<c:url value="/lib/css/cmsbase.css" />" rel="stylesheet" type="text/css" />
<link href="<c:url value="/lib/css/admin.css" />" rel="stylesheet" type="text/css" />
<link href="<c:url value="/lib/css/cmsadmin.css" />" rel="stylesheet" type="text/css" /> 
<script type="text/javascript" src="<c:url value="/lib/js/jquery-3.5.1.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery-migrate-1.4.1.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.cookie.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.lck.util.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.form.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/common.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/mc.js"/>"></script>
<title>비밀번호 재설정</title>
<script type="text/javascript">
function go(mode){
	
	if(mode == "later"){
		$.cookie("adm_advise_pw_later_"+$("#member_id").val(), "done", {path:"/", domain: document.domain, expires: 31 });
		opener.frm.submit();
		self.close();
	}else{
		var member_pw = $("#member_pw").val();
		var three = /^.*(?=.{8,15})(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9_]).*$/.test(member_pw);
		var two = /^.*(?=.{10,15})(?=.*[0-9])(?=.*[a-zA-Z])|(?=.{10,15})(?=.*[^a-zA-Z0-9_])(?=.*[a-zA-Z])|(?=.{10,15})(?=.*[^a-zA-Z0-9_])(?=.*[0-9]).*$/.test(member_pw);
		
		if(!three && !two){
			alert("비밀번호 10자리이상 2조합 or 8자리 이상 3조합으로 입력바랍니다.");
			return false;
		}
		
		if(member_pw != $("#member_pw_confirm").val()){
			alert("새로운 비밀번호를 확인하여 주시기 바립니다.");
			$("#member_pw_confirm").focus();
			return false;
		}
		
		var promise = getJSON("/member/modify_pw_adm.do", $("#frm").serializeObject());
		promise.done(function(data){
			if(data.rst == "Y"){
				opener.frm.member_pw.value = $("#member_pw").val();
				opener.frm.submit();
				self.close();
			}else{
				alert(data.msg);
			}
		});
	}
	
}
</script>
</head>
<body style="background:#fff;">
<div style="padding:15px;">
	<form name="frm" id="frm" method="post" >
	<sec:csrfInput />
	<input type="hidden" id="member_id" name="member_id" value="${param.member_id }">
		<h3 style="font-size:13px;">비밀번호 재설정</h3>
		<table class="type1">
			<colgroup>
	       		<col width="180">
	       		<col width="">
	       	</colgroup>
	       	<tr>
	       		<th><label for="member_pw" title="새로운 비밀번호를 입력하세요">새로운 비밀번호 입력</label></th>
	       		<td><input type="password" id="member_pw" class="normal w150" name="member_pw" title="새로운 비밀번호 입력" autocomplete="off"></td>
	       	</tr>
	       	<tr>
	       		<th><label for="member_pw_confirm" title="새로운 비밀번호를 재입력 해주세요">새로운 비밀번호 확인</label></th>
	       		<td><input type="password" id="member_pw_confirm" class="normal w150" name="member_pw_confirm" title="새로운 비밀번호 재입력" autocomplete="off"></td>
	       	</tr>
		</table>
		<div class="btn_bottom">
		  	<div class="r_btn">
				<input type="button" value="비밀번호 변경" class="bt_big_bt4" onclick="go('change')"/>
				<input type="button" value="다음에 변경" class="bt_big_bt2" onclick="go('later')"/>
		  	</div>	
		</div>
	</form>
</div>



</body>
</html>
