<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="double-submit" uri="http://www.egovframe.go.kr/tags/double-submit/jsp" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>회원가입</title>
<script type="text/javascript">
$(function(){
	$("#all_chk").on("change", function(){
		if($(this).prop("checked")){
			$(".chk").prop("checked", true);
		}else{
			$(".chk").prop("checked", false);
		}
	});
});
function goSubmit(){
	if(!$("#agree1").prop("checked")){
		alert("약관에 동의해 주시기 바랍니다.");
		$("#agree1").focus();
		return false;
	}else if(!$("#agree2").prop("checked")){
		alert("개인정보 보호정책 방침 동의 주시기 바랍니다.");
		$("#agree2").focus();
		return false;
	}
	$("#frm").submit();
}
</script>
</head>
<body>
	
				<h3>약관동의</h3>
				<div class="join_wrap">
					<form id="frm" name="frm" action="join.do" method="post">
<sec:csrfInput />
					<div class="step1">
						<ol>
							<li>1. 본인인증/가입여부</li>
							<li class="on">2. 약관동의</li>
							<li class="line">3. 회원정보 입력</li>
							<li>4. 가입완료</li>
						</ol>
					</div>
					<div class="member_tit">
						<h4>약관동의</h4>
					</div>
					<div class="agree">
						<div class="all_chk">
							<p>약관에 동의해 주세요.</p>
							<span><label for="all_chk">모두 동의합니다.</label><input type="checkbox" id="all_chk"></span>
						</div>
						<div class="agree_txt">
							<div>
								<p>이용약관 동의</p>
								<span><label for="agree1">이용약관에 동의합니다.</label><input type="checkbox" class="chk" id="agree1" name="agree1" value="Y"></span>
							</div>
							<div>
							</div>
						</div>
						<div class="agree_txt">
							<div>
								<p>개인정보 보호정책 방침 동의</p>
								<span><label for="agree2">이용약관에 동의합니다.</label><input type="checkbox" class="chk" id="agree2" name="agree2" value="Y"></span>
							</div>
							<div>
							</div>
						</div>
					</div>
					
					<div class="btn_type1">
						<div class="center">
							<a href="javascript:goSubmit();" class="type1">다음</a>
						</div>
					</div>
					</form>
				</div>

</body>
</html>
