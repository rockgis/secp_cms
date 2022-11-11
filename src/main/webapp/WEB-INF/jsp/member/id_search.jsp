<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="double-submit" uri="http://www.egovframe.go.kr/tags/double-submit/jsp" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" import="Kisinfo.Check.IPINClient" %>
<%@ page language="java" import="com.mc.web.service.Globals" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>회원가입</title>
<script language='javascript'>
window.name ="Parent_window";
function fnJoin(){ 
	document.form_chk.action = "/join.do";
	document.form_chk.submit();
}
function ok(){
	document.frm.submit();
}
</script>
</head>
<body>
	<div class="find_wrap">
		<div class="tab_ul">
			<ul>
				<li class="left on"><a href="id_search.do">아이디 찾기</a></li>
				<li class="right"><a href="pw_search.do">비밀번호 찾기</a></li>
			</ul>
		</div>
		<div class="find_input">
			<p>가입하신 회원 아이디(뒤 세자리는 보안 처리)를 알려드립니다.</p>
			<form id="frm" name="frm" action="id_find.do" method="post">
				<sec:csrfInput />
				<input type="text" id="member_nm" name="member_nm" placeholder="성명" class="name" title="성명 입력란">
				<input type="text" id="email" name="email" placeholder="이메일" title="이메일 입력란">
				<div class="btn_area">
					<div class="center">
						<a href="javascript:void(0);" class="v2 w200" onclick="ok()">아이디 찾기</a>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
