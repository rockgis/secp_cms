<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>비밀번호 확인</title>
<script type="text/javascript">
$(function(){
	$("#frm").on("submit", function(){
		if($("#member_pw").val() == ""){
			alert("현재 비밀번호를 입력하여 주시기 바립니다.");
			$("#member_pw").focus();
			return false;
		}
		else{
			frm.submit();
		}
		return false;
	});
});
function go(){
	$("#frm").submit();
}

function jf_cancel(){
	history.back();
}
</script>
</head>
<body>
		  

<form name="frm" id="frm" action="modify.do" method="post" >
<sec:csrfInput />
		<table class="board_view mb2">
			<caption>
				<strong>개인정보수정 - 본인인증</strong>
				<p>아이디 확인과 비밀번호 입력을통해 본인인증을 할 수 있습니다.</p>
			</caption>
			<colgroup>
				<col style="width:25%;"/>
				<col/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">아이디</th>
					<td>${member.member_id }</td>
				</tr>
				<tr>
					<th scope="row"><label for="member_pw">비밀번호</label></th>
					<td><input type="password" id="member_pw" class="inp6" name="member_pw" title="비밀번호 입력"></td>
				</tr>
			</tbody>
		</table>
		<div class="btn_area">
			<div class="center">
				<a href="javascript:void(0)" onclick="go();" class="v1">확인</a>
				<a href="javascript:void(0)" onclick="jf_cancel();">취소</a>
			</div>
		</div>
</form>
</body>
</html>
