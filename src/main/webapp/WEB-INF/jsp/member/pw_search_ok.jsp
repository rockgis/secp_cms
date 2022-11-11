<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="double-submit" uri="http://www.egovframe.go.kr/tags/double-submit/jsp" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>회원가입</title>
<script type="text/javascript" src="/lib/js/validation/jquery.validate.js"></script>
<script type="text/javascript" src="/lib/js/validation/additional-methods.js"></script>
<script type="text/javascript" src="/lib/js/validation/messages_ko.js"></script>
</head>
<body>
	<div class="complete">
		<p class="tit">비밀번호 찾기 결과</p>
		<div class="id_pwd">
	    	<p>등록된 이메일로 <b>임시비밀번호</b>를 보내드렸습니다.<br>
           	 로그인 후 회원정보수정에서 비밀번호를 변경해주세요.</p>
		</div>
	</div>
	<div class="btn_area">
		<div class="center">
			<a href="login.do" class="v2 w200">로그인</a>
		</div>
	</div>
</body>
</html>
