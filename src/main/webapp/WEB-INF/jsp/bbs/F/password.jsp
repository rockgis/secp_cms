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
  <table class="board_write">
    <colgroup>
	    <col style="width:20%"/>
	    <col/>
    </colgroup>
    <tbody>
      <tr>
        <th scope="row"><label for="password">비밀번호</label></th>
        <td><input type="password" id="password" name="password" class="inp_6" value="" autocomplete="off"/></td>
      </tr>
    </tbody>
  </table>
  <div class="btn_area">
  	<div class="center">
	  	<input type="submit" value="확인"/>
	  	<a href="list.do?cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }">취소</a>
  	</div>
  </div>
</form>
</body>
</html>