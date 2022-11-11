<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>비밀번호 재설정</title>
<script type="text/javascript">
$(function(){
	$("#frm").on("submit", function(){
		if($("#current_pw").val() == ""){
			alert("현재 비밀번호를 입력하여 주시기 바립니다.");
			$("#current_pw").focus();
			return false;
		}
		else{
			frm.submit();
		}
		return false;
	});
});
function go(){
	if (confirm("회원을 탈퇴하시겠습니까?")){
		$("#frm").submit();
	}
}

function cancel(){
	location.href = "/";
}
</script>
</head>
<body>
		  
<form name="frm" id="frm" action="/member/leave.do" method="post" >
<sec:csrfInput />
		<div class="section1">
			<h4>회원을 탈퇴하시겠습니까?</h4>
			<table class="board_view mb2">
				<caption>
					<strong>회원탈퇴 - 정보입력</strong>
					<p>아이디 확인과 비밀번호 입력을 통해 회원탈퇴를 할 수 있습니다.</p>
				</caption>
				<colgroup>
					<col style="width:15%;"/>
					<col style="width:35%;"/>
					<col style="width:15%;"/>
					<col/>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">아이디</th>
						<td>${member.member_id }</td>
						<th scope="row"><label for="current_pw">비밀번호</label></th>
						<td><input type="password" id="current_pw" class="inp6" name="current_pw" title="비밀번호 입력" style="width:80%;"> </td>
					</tr>
					<tr>
						<th scope="row">사유</th>
						<td colspan="3">
							<select id="gubun" style="width:100%; margin-bottom:10px">
								<option value="1">ㅇㅇㅇㅇ</option>
							</select>
							<textarea name="leave_cont" style="width:100%; height:100px;" placeholder="500자 이내로 입력해주세요."></textarea>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="btn_area">
			<div class="center">
				<a href="javascript:void(0)" onclick="go();" class="v2">확인</a>
				<a href="javascript:void(0)" onclick="cancel();">취소</a>
			</div>
		</div>	
</form>


</body>
</html>
