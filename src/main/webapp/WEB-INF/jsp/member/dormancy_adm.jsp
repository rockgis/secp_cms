<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.HashMap,java.util.Map"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<sec:csrfMetaTags/>
<link href="<c:url value="/lib/css/cmsbase.css" />" rel="stylesheet" type="text/css" />
<link href="<c:url value="/lib/css/admin.css" />" rel="stylesheet" type="text/css" />
<link href="<c:url value="/lib/css/cmsadmin.css" />" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<c:url value="/lib/js/jquery-3.5.1.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery-migrate-1.4.1.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.form.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/mc.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/validation/jquery.validate.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/validation/additional-methods.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/validation/messages_ko.js"/>"></script>
<script type="text/javascript">
$(function(){
	
	$("#email2_select").on("change", function(){
		$("#email2").val($(this).val());
	});
	
	$("#frm").validate({
		ignore: ':hidden',
        debug: false,// true일 경우 validation 후 submit을 수행하지 않음
        onkeyup: false,
        onfocusout: false,
        onclick: false,
        submitHandler : function(frm){
        	$(frm).ajaxSubmit({
        		iframe: false,
        		dataType : "json",
        		success : function(data){
        			if(data.rst=="X"){
        				alert(data.msg);
        			}else if(data.rst=="Y"){
        				alert("휴면계정이 해지되었습니다. 다시 로그인하여주시기 바랍니다.");
        				self.close();
        			}
        		},
        		error: function(e){
        			alert(e.responseText);
        		},
        		complete : function(){
        		}
        	});
        },
		showErrors : function(error, element) {
			if(this.numberOfInvalids()){ // show error
				alert(element[0].message);
			    $(element[0].element).focus();
			}
		},
        rules: {
            member_nm : {
            	required: true
            },
            email1 : {
            	required: true
            },
            email2 : {
            	required: true
            }
        }, messages: {
        	member_nm : {
        		required : '이름을 입력하여주시기 바랍니다.'
            },
            email1 : {
        		required : '이메일을 입력하여주시기 바랍니다.'
            },
            email2 : {
        		required : '이메일을 입력하여주시기 바랍니다.'
            }
        }
    });
	
})

function goSubmit(){
	$("#frm").submit();
}
</script>
</head>
<body style="background:#fff;">
<div style="padding:15px;">
	<form id="frm" name="frm" action="/member/dormancy_adm_init.do" method="post">
	<sec:csrfInput />
	<input type="hidden" name="member_id" value="${param.member_id }"/>
		<h3 style="font-size:13px;">휴면계정 해제</h3>
		<table class="type1">
			<colgroup>
	       		<col width="120">
	       		<col width="">
	       	</colgroup>
	       	<tr>
	       		<th>이름</th>
	       		<td><input type="text" name="member_nm" class="normal w200" id="member_nm"/></td>
	       	</tr>
			<tr>
				<th>이메일</th>
				<td>
					<input type="text" name="email1" id="email1" class="normal w100" title="이메일 아이디 입력"/> @ <input type="text" name="email2" id="email2" class="normal w100" title="이메일 도메인 입력" style="margin-right:5px;"/>
					<select id="email2_select" class="normal w100" title="이메일 도메인 선택">
						<option value="">직접입력</option>
						<c:forEach var="item" items="${email2 }">
							<option value="${item.code }">${item.code }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</table>
		<div class="btn_bottom">
		  	<div class="r_btn">
				<input type="button" value="휴면 해제" class="bt_big_bt4" onclick="goSubmit()"/>
		  	</div>	
		</div>
	</form>
</div>
</body>
</html>
