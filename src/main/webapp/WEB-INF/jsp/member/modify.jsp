<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="double-submit" uri="http://www.egovframe.go.kr/tags/double-submit/jsp" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>정보변경</title>
<script type="text/javascript" src="/lib/js/validation/jquery.validate.js"></script>
<script type="text/javascript" src="/lib/js/validation/additional-methods.js"></script>
<script type="text/javascript" src="/lib/js/validation/messages_ko.js"></script>
<script type="text/javascript">
$(function(){
	
	$("#email2_select").on("change", function(){
		$("#email2").val($(this).val());
	});
	
	$.validator.addMethod("membernm", function(value, element) {
		var required = $.validator.methods.required.call( this, value, element );
		if(!required){
			$.validator.messages.membernm = "이름을 입력하여주시기 바랍니다.";
			return false;
		}
		return true;
	}, $.validator.messages.membernm);
	
	$.validator.addMethod("memberpw", function(value, element) {
		//var three = /^.*(?=.{8,15})(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9_]).*$/.test(value);
		//var two = /^.*(?=.{10,15})(?=.*[0-9])(?=.*[a-zA-Z])|(?=.{10,15})(?=.*[^a-zA-Z0-9_])(?=.*[a-zA-Z])|(?=.{10,15})(?=.*[^a-zA-Z0-9_])(?=.*[0-9]).*$/.test(value);
		var two = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9_]).*$/.test(value);
		
		var required = $.validator.methods.required.call( this, value, element );
		if(!required){
			$.validator.messages.memberpw = "비밀번호를 입력하여주시기 바랍니다.";
			return false;
		}
		if(!two){
			$.validator.messages.memberpw = "비밀번호는 6~20자의 영문 대소문자, 숫자, 특수문자를 조합하여 사용하실 수 있습니다.";
			return false;
		}
		return true;
	}, $.validator.messages.memberpw);
	
	$("#frm").validate({
		ignore: ':hidden',
        debug: false,// true일 경우 validation 후 submit을 수행하지 않음
		//onkeyup: false,
		//onfocusout: false,
		//onclick: false,
        submitHandler : function(frm){
        	if(!confirm("회원정보를 수정하시겠습니까?")) return;
        	frm.submit();
        },
        rules: {
            member_nm: {
            	required: true,
            	membernm : true
            },      
            member_pw: {
             	required: true,
             	memberpw : true
            },
            member_pw_confirm: {
            	required: true,
            	equalTo: "#member_pw"
            },
            tel1 : {
            	number : true
            },
            tel2 : {
            	number : true
            },
            cell2 : {
            	required: true,
            	number : true
            },
            cell3 : {
            	required: true,
            	number : true
            },
            email1 : {
            	required: true
            },
            email2 : {
            	required: true
            }
        }, messages: {
         	member_nm: {
        		membernm : function(){return $.validator.messages.membernm}
            },        	 
        	member_pw: {
        		memberpw : function(){return $.validator.messages.memberpw}
            },
            member_pw_confirm: {
        		required : '비밀번호 확인을 하여 주시기 바랍니다.',
            	equalTo: '비밀번호가 일치하지 않습니다.',
            },
            tel1 : {
            	number : '숫자만 입력하여주시기 바랍니다.'
            },
            tel2 : {
            	number : '숫자만 입력하여주시기 바랍니다.'
            },
            cell1 : {
        		required : '휴대폰 번호를 입력하여주시기 바랍니다.',
            	number : '숫자만 입력하여주시기 바랍니다.'
            },
            cell2 : {
        		required : '휴대폰 번호를 입력하여주시기 바랍니다.',
            	number : '숫자만 입력하여주시기 바랍니다.'
            },
            email1 : {
        		required : '이메일을 입력하여주시기 바랍니다.'
            },
            email2 : {
        		required : '이메일을 입력하여주시기 바랍니다.'
            }
        }
    });
	
});
function goSubmit(){
	$("#frm").submit();
}
</script>
</head>
<body>
	<div class="section">
		<h4 class="first">개인정보변경</h4>
		<form action="modifyProc.do" name="frm" id="frm" method="post">
<sec:csrfInput />
		<double-submit:preventer/>
			<input type="hidden" name="group_seq" value="${view.group_seq }"/><!-- 일반사용자는 1 -->
			<input type="hidden" name="member_id" value="${view.member_id }"/>
			<table class="sub_table mb2">
				<colgroup>
					<col width="22%">
					<col width="">
				</colgroup>
				<tbody>
					<tr>
						<th>아이디</th>
						<td class="table_input">
							 ${view.member_id }
						</td>
					</tr>
					<tr>
						<th>이름</th>
						<td class="table_input">
							<input type="text" name="member_nm" id="member_nm" value="${view.member_nm }"/>
						</td>
					</tr>
					<tr class="hidden">
						<th>비밀번호</th>
						<td class="table_input">
							<input type="password" name="member_pw" id="member_pw" onkeypress="capLock(event)" autocomplete="off"/>
							<!-- <p class="txt">비밀번호는 6~20자의 영문 대소문자, 숫자, 특수문자 조합으로 입력바랍니다.</p> -->
					    	<div id="capslock" style="display: none;">Caps Lock이 켜져 있습니다.</div>							
						</td>
					</tr>
					<tr>
						<th>비밀번호 확인</th>
						<td class="table_input">
							<input type="password" name="member_pw_confirm" id="member_pw_confirm" autocomplete="off"/>
						</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td class="table_input">
							<select name="tel1" id="tel1">
								<c:forEach var="item" items="${tel1 }">
									<option value="${item.code }" <c:if test="${view.tel1 eq item.code }">selected="selected"</c:if>>${item.code }</option>
								</c:forEach>
							</select>-
							<input type="text" name="tel2" id="tel2" maxlength="4" value="${view.tel2 }">-
							<input type="text" name="tel3" id="tel3" maxlength="4" value="${view.tel3 }">
						</td>
					</tr>
					<tr>
						<th>핸드폰</th>
						<td class="table_input">
							<select name="cell1" id="cell1">
								<c:forEach var="item" items="${cell1 }">
									<option value="${item.code }" <c:if test="${view.cell1 eq item.code }">selected="selected"</c:if>>${item.code }</option>
								</c:forEach>
							</select>-
							<input type="text" name="cell2" id="cell2" maxlength="4" value="${view.cell2 }">-
							<input type="text" name="cell3" id="cell3" maxlength="4" value="${view.cell3 }">
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td class="table_input">
							<input type="text" name="email1" id="email1" value="${view.email1 }">@
							<input type="text" name="email2" id="email2" value="${view.email2 }">
							<select id="email2_select">
								<option value="">직접입력</option>
								<c:forEach var="item" items="${email2 }">
									<option value="${item.code }" <c:if test="${view.email2 eq item.code }">selected="selected"</c:if>>${item.code }</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="btn_area">
				<div class="center">
					<a class="v2" href="javascript:goSubmit()">저장</a>
				</div>
            </div>
		</form>

	</div>
</body>
</html>
