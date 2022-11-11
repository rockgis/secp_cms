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
		var mode = $("#mode").val();
		if(mode != "later") {
			if($("#current_pw").val() == ""){
				alert("현재 비밀번호를 입력하여 주시기 바립니다.");
				$("#current_pw").focus();
				return false;
			}
			
			if($("#mode").val()=="later"){//한달후 알림
				$.cookie("advise_pw_later_"+$("#member_id").val(), "done", {path:"/", domain: document.domain, expires: 31 });
				$("#member_pw").val($("#current_pw").val())
				return true;
			}
			
			if($("#member_pw").val() == ""){
				alert("새로운 비밀번호를 입력하여 주시기 바립니다.");
				$("#member_pw").focus();
				return false;
			}
	
			var member_pw = $("#member_pw").val();
			var three = /^.*(?=.{8,15})(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9_]).*$/.test(member_pw);
			var two = /^.*(?=.{10,15})(?=.*[0-9])(?=.*[a-zA-Z])|(?=.{10,15})(?=.*[^a-zA-Z0-9_])(?=.*[a-zA-Z])|(?=.{10,15})(?=.*[^a-zA-Z0-9_])(?=.*[0-9]).*$/.test(member_pw);
			
			if(!three && !two){
				alert("비밀번호 10자리이상 2조합 or 8자리 이상 3조합으로 입력바랍니다.");
				$("#member_pw").focus();
				return false;
			}
			console.log($("#member_pw").val());
			console.log($("#member_pw_confirm").val());
			if($("#member_pw").val() != $("#member_pw_confirm").val()){
				alert("새로운 비밀번호를 확인하여 주시기 바립니다.");
				$("#member_pw_confirm").focus();
				return false;
			}
	
			$("#made_yn").val("N");
			var promise = getSyncJSON("/member/modify_pw.do", $("#frm").serializeObject());
			promise.then(function(data){
				if(data.rst == "Y"){
					return true;
				}else{
					return false;
					alert(data.msg);
				}
			});
		}
	});
});

function go(mode){
	$("#mode").val(mode);
	$("#frm").submit();
}
</script>
</head>
<body>
		  

<form name="frm" id="frm" action="/loginProcess.do" method="post" >
<sec:csrfInput />
	<input type="hidden" id="mode" name="mode">
	<input type="hidden" id="made_yn" name="made_yn" value="" />
	<input type="hidden" name="returnURL" value="/"/>
	<input type="hidden" id="member_id" name="member_id" value="${param.member_id }">
	<input type="hidden" id="member_pw" name="member_pw" value="${param.member_pw }">
		<div class="terms">
			<p class="tit">비밀번호 재설정</p>
			<table class="board_view mb2">
				<caption></caption>
				<colgroup>
					<col style="width:25%;"/>
					<col/>
				</colgroup>
				<tbody>
					<tr>
						<th scope="col"><label for="current_pw" title="현재 비밀번호를 입력하세요">현재 비밀번호</label></th>
						<td class="table_input"><input type="password" id="current_pw" class="inp1" name="current_pw" title="현재 비밀번호 입력" autocomplete="off"></td>
					</tr>
					<tr>
						<th scope="col"><label for="member_pw" title="새로운 비밀번호를 입력하세요">새로운 비밀번호 입력</label></th>
						<td class="table_input"><input type="password" id="member_pw" class="inp1" name="member_pw" title="새로운 비밀번호 입력" autocomplete="off"></td>
					</tr>
					<tr>
						<th scope="col"><label for="member_pw_confirm" title="새로운 비밀번호를 재입력 해주세요">새로운 비밀번호 확인</label></th>
						<td class="table_input"><input type="password" id="member_pw_confirm" class="inp1" name="member_pw_confirm" title="새로운 비밀번호 재입력" autocomplete="off"></td>
					</tr>
				</tbody>
			</table>
			<!--  
			<div class="join_wrap">
				<fieldset>
					<ul class="pw_change">
						<li>
							<label for="current_pw" title="현재 비밀번호를 입력하세요">현재 비밀번호</label>
							<input type="password" id="current_pw" class="inp6" name="current_pw" title="현재 비밀번호 입력" autocomplete="off">
						</li>
						<li>					
							<label for="member_pw" title="새로운 비밀번호를 입력하세요">새로운 비밀번호 입력</label>
							<input type="password" id="member_pw" class="inp6" name="member_pw" title="새로운 비밀번호 입력" autocomplete="off">
						</li>
						<li>
							<label for="member_pw_confirm" title="새로운 비밀번호를 재입력 해주세요">새로운 비밀번호 확인</label>
							<input type="password" id="member_pw_confirm" class="inp6" name="member_pw_confirm" title="새로운 비밀번호 재입력" autocomplete="off">
						</li>
					</ul>
				</fieldset>
			</div>
			 -->
		</div>
					    			 	
		<div class="btn_area">
			<div class="center">
				<a href="javascript:go('later');" class="v2">다음에 변경하기</a>
				<a href="javascript:go('change');">비밀번호 변경</a>
			</div>
		</div>	
</form>




</body>
</html>
