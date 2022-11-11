<%@ page language="java" contentType="text/html; charset=UTF-8" buffer="none"%>
<%@page import="java.util.*"  %>
<%@page import="java.util.regex.*"  %>
<%@page import="java.text.*"  %>
<%@page import="java.io.*"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<title>웹표준 자동 검사</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link href="<c:url value="/css/egovframework/com/cmm/utl/com.css"/>" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<c:url value="/js/egovframework/com/uss/ion/rss/jquery.js"/>"></script>
<script type="text/javaScript" language="javascript">
/* ********************************************************
 * 저장처리화면
******************************************************** a*/
function fn_egov_init_WebStandardInspection(){




}
/* ********************************************************
 * 화면 검사
******************************************************** a*/
function fn_egov_submit_WebStandardInspection(form, nNmm){

	document.getElementById('divErr'+nNmm).innerHTML='';
	document.getElementById('divWar'+nNmm).innerHTML='';

	//url 검사 모드시
	/*
	if(form.rdoUri[1].checked){
		var name=form.uri.value;
		var reg_name=/(127\.0\.0\.1|localhost)/g;

		if( reg_name.test(name) ){
		alert("Url 검사 에서는[localhost/127.0.0.1] 해당 주소를 검사 할수 없습니다.!");
		return false;
		}

	}
	*/

	if(form.uri.value == ''){
		alert('웹표준검사 URL을 입력해주세요!');
		form.uri.focus();
		return false;
	}

	if(form.rdoUri[0].checked == true){
		form.action='<c:url value="/super/system/wsi/EgovWebStandardInspectionUriDirect.do"/>';
	}
	else{
		form.action='<c:url value="/super/system/wsi/EgovWebStandardInspectionUri.do"/>';
	}

	return true;

}

/* ********************************************************
 * 상세보기 스크립트
******************************************************** */
function fn_egov_submit_WebStandardInspectionLink(form){

	if(form.uri.value == ''){
		alert('웹표준검사 URL을 입력해주세요!');
		form.uri.focus();
		return;
	}

	document.formHidden.uri.value = form.uri.value;

		if(form.rdoUri[0].checked == true){
			document.formHidden.action = "<c:url value="/super/system/wsi/EgovWebStandardInspectionUriDirectLink.do"/>";
	}
	else{
		document.formHidden.action = "http://validator.w3.org/check";
	}

	document.formHidden.submit();
}

</script>
<style type="text/css">
.btnNew {
	border : 0 solid #000;
	color : #000000;
	background-image : url(<c:url value="/images/egovframework/com/cmm/uss/umt/button/bu2_bg.gif"/>);
	cursor : pointer;
}
</style>
</head>
<body onLoad="fn_egov_init_WebStandardInspection()">
<div class="titlebar">
  <h2>웹표준 자동 검사</h2>
  <div> <span>시스템관리</span>&gt; <span>기타 설정</span>&gt; <span class="bar_tx">웹표준 자동 검사</span> </div>
</div>
<div class="contents_wrap">
  <DIV id="content" class="contents"> 
    <!-- noscript 테그 -->
    <noscript class="noScriptTitle">
    자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.
    </noscript>
    
    <!--  상단  등롬폼 영역 START -->
    <table class="type1" style="margin-top:0;">
    	<caption>이 표는 웹표준검사 대상 정보를 제공하며, URL명, Public IP 여부, Warniing, 상세보기 정보로 구성되어 있습니다 .</caption>
      	<colgroup>
	      	<col />
	      	<col style="width:350px;" />
	      	<col style="width:230px;" />
	      	<col style="width:230px;" />
	      	<col style="width:150px;" />
      	</colgroup>
      	<tr>
	        <th scope="col" class="center">URL명</th>
	        <th scope="col" class="center">공인 IP 여부</th>
	        <th scope="col" class="center">Errors</th>
	        <th scope="col" class="center">Warning</th>
	        <th scope="col" class="center">상세보기</th>
      	</tr>
    </table>
    <%
    for(int i=1 ; i<10; i++){
    %>
    <form name="webInspection" method="post" action="<c:url value="/super/system/wsi/EEgovWebStandardInspectionUri.do"/>" target="ifr_hidden">
      	<table class="type1">
        	<colgroup>
		      	<col />
		      	<col style="width:350px;" />
		      	<col style="width:230px;" />
		      	<col style="width:230px;" />
		      	<col style="width:150px;" />
	      	</colgroup>
        	<tr class="over">
          		<td><input name="uri" type="text" value="" maxlength="250" class="normal" style="width:100%;" placeholder="ex) http://www.naver.com" /></td>
          		<td class="center">
          			<div style="display:inline-block; width:130px; vertical-align:middle;">
              			<label><input type="radio" name="rdoUri" value="dUri"> 내부&nbsp;&nbsp;</label>
              			<label><input type="radio" name="rdoUri" value="uri" checked> 공인</label>
            		</div>
            		<div style="display:inline-block; vertical-align:middle;"> 
              			<button value="검색" class="bt_small search" name="btnSearch" onClick="if(fn_egov_submit_WebStandardInspection(this.form,'<%=i%>') == false){return false;};">검색</button>
            		</div>
            	</td>
          		<td><div id="divErr<%=i%>">&nbsp;</div></td>
          		<td><div id="divWar<%=i%>">&nbsp;</div></td>
          		<td class="center">
            		<button value="보기" class="bt_small view" name="btnSearch" onClick="fn_egov_submit_WebStandardInspectionLink(this.form);" >보기</button>
            		<input name="num" type="hidden" value="<%=i%>">
            	</td>
        	</tr>
      	</table>
    </form>
    <%
    }
    %>
    
    <!--  Hiden frame  visibility: hidden;  -->
    <iframe name="ifr_hidden" id="ifr_hidden1" src="about:blank;" style="width:100%;height:400px;visibility: hidden;"></iframe>
    <form name="formHidden" id="formHidden" action="http://validator.w3.org/check" method="post" target="_blank" >
      	<input name="uri" type="hidden" value="">
    </form>
  </DIV>
</div>
</body>
</html>
