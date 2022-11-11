<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="double-submit" uri="http://www.egovframe.go.kr/tags/double-submit/jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>회원가입</title>
<script type="text/javascript">
</script>
</head>
<body>	
<div class="complete">
	<p class="tit">아이디 찾기 결과</p>
	<p class="txt">입력하신 정보와 일치하는 <span> 아이디입니다.</span></p>
	<div class="id_pwd">
    	<p>회원님의 아이디는<b> ${member_id }</b> 입니다.</p>
	</div>
</div>
<div class="btn_area">
	<div class="center">
	    <a href="pw_search.do" class="v1 w200">비밀번호 찾기</a>
		<a href="login.do" class="v2 w200">로그인</a>
	</div>
</div>
</body>
</html>
