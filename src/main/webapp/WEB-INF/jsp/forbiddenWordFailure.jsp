<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="com.mc.common.util.RequestSnack" %>
<%@ page import="com.mc.web.service.Globals" %>
<%@page import="org.json.simple.JSONObject" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="robots" content="noindex,nofollow">
<style type="text/css">
/* 시스템 경고 */ 
.system_warning_box{overflow: hidden; padding-top: 50px; padding-left: 43px;}
.system_warning_box > p{display: block; float: left;}
.system_warning_box > p.system_warning_text_{font-weight: bold; font-size: 22px; color: #b03030; line-height: 180%; margin: 10px 0px 0px 45px;}
h4.system_warning_h4{background: url("/images/super/system_pop_07.png") no-repeat 0px 3px; padding-left: 15px; font-size: 16px; font-weight: bold;  margin-top: 45px;}
.system_warning_box2{ margin-top: 5px;}
.system_warning_textarea{width: 94%; height: 150px; overflow-y:scroll; padding: 3%;}
.system_warning_box2_text{color: #707070; padding: 5px 0px 0px 5px;}
.system_bot_bt{text-align: center; margin-top: 20px;}
.system_warning_bt1{border:none; background: url("/images/super/system_pop_01.png") no-repeat 0px 0px; width: 98px; height: 35px; text-indent: 999999px; cursor: pointer;}
.system_warning_bt2{border:none; background: url("/images/super/system_pop_02.png") no-repeat 0px 0px; width: 98px; height: 35px; text-indent: 999999px; cursor: pointer;}
.system_warning_h4_1{background: url("/images/super/system_pop_07.png") no-repeat 0px 3px; padding-left: 15px; font-size: 16px; font-weight: bold; margin-top: 45px;}
.system_warning_h4_2{background: url("/images/super/system_pop_07.png") no-repeat 0px 3px; padding-left: 15px; font-size: 16px; font-weight: bold; margin-top: 10px;}
.system_warning_textarea2{width: 96%; height: 40px; overflow-y:scroll; padding: 2%;}
.system_warning_textarea3{width: 96%; height: 60px; overflow-y:scroll; padding: 2%;}
</style>
<script language="javascript">
function fncGoAfterErrorPage(){
    history.back(-2);
}
</script>
</head>

<body>
	<div style="width: auto; min-height: 0px; max-height: none; height: 537px;">
	  <div class="system_warning_box">
	    <p><img src="/images/super/system_pop_03.png" alt="경고 아이콘"></p>
	    <p class="system_warning_text_">
	 등록하시려는 게시물의 본문에서<br>
	개인정보유출이 우려되는 내용이 <br>
	검출되었습니다.
	    </p>
	  </div>
	  <h4 class="system_warning_h4_1">검출된 문자열</h4>
	  <div class="system_warning_box2">
	    <div class="system_warning_textarea2 ng-binding" style="height:150px;">
	    	<c:forEach var="item" items="${rst.juminList }">
	    	${item }
	    	</c:forEach>
	    	<c:forEach var="item" items="${rst.emailList }">
	    	${item }
	    	</c:forEach>
	    	<c:forEach var="item" items="${rst.businoList }">
	    	${item }
	    	</c:forEach>
	    	<c:forEach var="item" items="${rst.bubinoList }">
	    	${item }
	    	</c:forEach>
	    	<c:forEach var="item" items="${rst.cardList }">
	    	${item }
	    	</c:forEach>
	    	<c:forEach var="item" items="${rst.telList }">
	    	${item }
	    	</c:forEach>
	    	<c:forEach var="item" items="${rst.cellList }">
	    	${item }
	    	</c:forEach>
	    	<c:forEach var="item" items="${rst.textList }">
	    	${item }
	    	</c:forEach>
	    </div>
	  </div>
	  <p class="system_bot_bt">
	  	<a href="javascript:fncGoAfterErrorPage();"><img src="<c:url value='/images/egovframework/com/cmm/go_history.jpg' />" width="90" height="29" alt="바로가기 버튼이미지"/></a>
	  </p>
	</div>
</body>
</html>
