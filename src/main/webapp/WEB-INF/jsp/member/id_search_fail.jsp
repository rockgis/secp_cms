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
	
	
				<div id="member_area">	
				<h3>아이디/비밀번호 찾기</h3>
				<div class="join_wrap">
					<div class="tab">
						<ul>
							<li class="on"><a href="id_search.do">아이디 찾기</a></li>
							<li><a href="pw_search.do">비밀번호 찾기</a></li>
						</ul>
					</div>
					
					<!-- 회원가입 정보시 start -->
					<div class="join_box mb3">
						<div class="finish_txt">요청하신 정보가 없습니다.</div>
						<p class="join_txt">회원님께서 입력하신 정보를 확인 할 수 없습니다.<br>입력하셨던 정보를 다시 확인해 주세요.</p>
					</div>
					<!-- 회원가입 정보시 end -->
					
					<div class="btn_area">
						<div class="center">
							<a href="id_search.do" class="v1">다시시도</a>
							<a href="/">홈으로</a>
							<a href="join_step1.do">회원가입</a>
						</div>
					</div>
				</div>
		
	       	</div>
		

</body>
</html>
