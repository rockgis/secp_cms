<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="double-submit" uri="http://www.egovframe.go.kr/tags/double-submit/jsp" %>
<c:set var="birth" value="${fn:substring(sessionScope.birth, 0, 4) }"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>회원가입</title>
<script type="text/javascript">
</script>
</head>
<body>
	<div class="globe_step">
        <ul>
          <li>
            <div>
              <p>01</p>
            </div>
            <p class="step_text">약관동의</p>
          </li>
          <li>
            <div>
              <p>02</p>
            </div>
            <p class="step_text">회원정보 입력</p>
          </li>
          <li class="step_on">
            <div>
              <p>03</p>
            </div>
            <p class="step_text">회원가입 완료</p>
          </li>
        </ul>
    </div>
	<div class="complete">
		<p class="tit"><b>${param.member_nm }</b>님, 회원가입이 완료되었습니다.</p>
		<table class="sub_style_1">
		<caption></caption>
		<colgroup>
			<col style="width:20.55%">
			<col style="width:79.45%">
		</colgroup>
			<tbody>
				<tr>
				  <th>아이디</th>
				  <td>${param.member_id }</td>
				</tr>
				<tr>
				  <th>성명</th>
				  <td>${param.member_nm}</td>
				</tr>
				<tr>
				  <th>이메일</th>
				  <td>${param.email1 }@${param.email2 }</td>
				</tr>
			</tbody>
		</table>
	</div>					
	<div class="btn_area">
		<div class="center">
			<a href="/${site eq null ? 'web' : site}/index.do" class="v2 w200">확인</a>
		</div>
	</div>
</body>
</html>
