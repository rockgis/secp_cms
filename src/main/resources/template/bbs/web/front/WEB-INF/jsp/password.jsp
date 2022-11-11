<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<html>
<head>
<meta name="robots" content="noindex,nofollow">
</head>
<body>

${boardInfo.conts }

<form name="wFrm" id="wFrm" action="${param.servlet_path}" method="post" >
<sec:csrfInput />
  <input type="hidden" name="article_seq" value="${params.article_seq }"/>
  <table class="write_style_1">
    <colgroup>
    <col width="20%">
    <col width="">
    </colgroup>
    <tbody>
      <tr>
        <th scope="row"><label for="password">비밀번호</label></th>
        <td><input type="password" id="password" name="password" class="input_3" value="" style="width:100px;" autocomplete="off"/></td>
      </tr>
    </tbody>
  </table>
  <div class="btn_type1">
  	<div class="center">
	  	<input type="submit" value="확인" class="b_btn_1"/>
	  	<a href="list.do?cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }" class="b_btn_1">취소</a>
  	</div>
  </div>
</form>
</body>
</html>