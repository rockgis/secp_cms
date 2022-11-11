<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="double-submit" uri="http://www.egovframe.go.kr/tags/double-submit/jsp" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<c:set var="birth" value="${fn:substring(sessionScope.birth, 0, 4) }"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>회원가입</title>
<script type="text/javascript" src="/lib/js/validation/jquery.validate.js"></script>
<script type="text/javascript" src="/lib/js/validation/additional-methods.js"></script>
<script type="text/javascript" src="/lib/js/validation/messages_ko.js"></script>
<script type="text/javascript">
$(function(){ 
	
	$("#member_id").on("change", function(){
		$("#check_id_result").val("Y");
		//$("#member_id_text").text("중복체크를 하여주시기 바랍니다.");
	});
	
	$("#email2_select").on("change", function(){
		$("#email2").val($(this).val());
	});
	
	$.validator.addMethod("memberid", function(value, element) {
	    /* 
		if(!this.optional(element) || /(^[a-zA-Z_]+[0-9]*[a-zA-Z0-9_]*$)/.test(value)) {
	    	$.validator.messages.memberid = '사용자 아이디는 영문,숫자를 이용해 6글자 이상 입력하세요.';
	    	return false;
	    }
	     */
		var one = /(^[a-zA-Z_]+[0-9]*[a-zA-Z0-9_]*$)/.test(value);
		var required = $.validator.methods.required.call( this, value, element );
		if(!required){
			$.validator.messages.memberid = "아이디를 입력하여주시기 바랍니다.";
			return false;
		}
		if(!one){
			$.validator.messages.memberid = "사용자 아이디는 영문,숫자를 이용해 4글자 이상 입력하세요.";
			return false;
		}
		return true;
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
//         onkeyup: false,
//         onfocusout: false,
//         onclick: false,
        submitHandler : function(frm){
        	if($("#check_id_result").val()!="N"){
        		alert("아이디 중복체크를 해주시기 바랍니다.");
        		return false;
        	}
        	if(!confirm("가입하시겠습니까?")) return;
        	frm.submit();
        },
		errorPlacement : function(error, element) {
			$(element).siblings(".sign1").text(error.text());
		},
		success: function(element) {
			$(element).siblings(".sign1").empty();        
		},
        rules: {
        	member_id:{
            	required: true,
            	memberid:  true,
            	rangelength: [6, 20]
        	},
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
        	member_id: {
        		memberid : function(){return $.validator.messages.memberid}
            },
        	/* 
        	member_id:{
        		required : '사용자 아이디는 영문, 숫자를 이용해 6글자 이상 입력하세요.',
            	rangelength :  $.validator.format("아이디는 {0}자이상, {1}자이하로 입력하세요."),
            	memberid :  '아이디는 영문으로 시작해야하며 특수문자는 포함하실수 없습니다.'
        	},
        	 */
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
function idCheck(){
	var member_id = $("#member_id").val();
	var id_chk = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{4,}$/;
	if(id_chk.test(member_id)) {
		getJSON("/member/id_check.do", {member_id : $("#member_id").val()}, function(data){
			if(data.rst=="Y"){//사용불가
				$("#check_id_result").val("Y");
				$("#member_id_text").text("사용하실수없는 아이디입니다.");
			}else{
				$("#check_id_result").val("N");
				$("#member_id_text").text("사용가능");
			}
		});
	} else {
		$("#member_id_text").text("사용자 아이디는 영문,숫자를 이용해 4글자 이상 입력하세요.");
	}
}
function goSubmit(){
	if($("#check_id_result").val() == "Y"){
		$("#member_id_text").text("중복체크를 하여주시기 바랍니다.");
		return false;
	}
	$("#frm").submit();
}
</script>
</head>
<body>
	<form action="joinProc.do" name="frm" id="frm" method="post">
<sec:csrfInput />
	<input type="hidden" id="check_id_result" value=""><!-- 중복체크 결과 -->
	<input type="hidden" name="gender" value="${sessionScope.gender }">
	<input type="hidden" name="birth" value="${sessionScope.birth }">
	<input type="hidden" name="di" value="${sessionScope.di }">
	<input type="hidden" name="agree1" value="${param.agree1 }">
	<input type="hidden" name="agree2" value="${param.agree2 }">
	<div class="join_2">
		<div class="globe_step">
           <ul>
             <li>
               <div>
                 <p>01</p>
               </div>
               <p class="step_text">약관동의</p>
             </li>
             <li class="step_on">
               <div>
                 <p>02</p>
               </div>
               <p class="step_text">회원정보 입력</p>
             </li>
             <li>
               <div>
                 <p>03</p>
               </div>
               <p class="step_text">회원가입 완료</p>
             </li>
           </ul>
        </div>
		<h4>회원정보</h4>
		<span class="required">회원가입에 필요한 필수사항입니다. 정확히 입력하시기 바랍니다.</span>
		<double-submit:preventer/>
			<table class="sub_table">
				<caption></caption>
				<colgroup>
					<col width="200px">
					<col width="">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><p><label for="member_id" class="required">아이디</label></p></th>
						<td class="table_input">
							<span class="form_area"><input type="text" name="member_id" id="member_id" class="inp1" title="아이디 입력" style="margin-right:7px;"/></span>
							<a href="javascript:idCheck()" class="table_btn">중복확인</a>
							<p id="member_id_text" class="txt"></p>
							<!-- 중복확인 문구 -->
							<span class="sign1"><!-- 경고메시지 표시영역 --></span>
						</td>
					</tr>
					<tr>
						<th scope="row"><p><label for="member_nm" class="required">이름</label></p></th>
						<td class="table_input">
							<input type="text" name="member_nm" id="member_nm" value="${sessionScope.name }"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><p><label for="member_pw" class="required">비밀번호</label></p></th>
						<td class="table_input">
							<input type="password" name="member_pw" id="member_pw" onkeypress="capLock(event)" autocomplete="off"/>
							<p class="txt">비밀번호는 6~20자의 영문 대소문자, 숫자, 특수문자 조합으로 입력바랍니다.</p>
					    	<div id="capslock" style="display: none;">Caps Lock이 켜져 있습니다.</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><p><label for="member_pw_confirm" class="required">비밀번호 확인</label></p></th>
						<td class="table_input">
							<input type="password" name="member_pw_confirm" id="member_pw_confirm" autocomplete="off"/>
							<!-- 비밀번호 일치여부 -->
							<p class="txt""><!-- 경고메시지 표시영역 --></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><p class="bg_none"><label for="tel1">전화번호</label></p></th>
						<td class="table_input">
							<select name="tel1" id="tel1" class="num_input" title="전화번호 첫째자리 선택">
								<c:forEach var="item" items="${tel1 }">
									<option value="${item.code }">${item.code }</option>
								</c:forEach>
							</select>
							<span class="ico">-</span>
							<input type="text" name="tel2" id="tel2" class="num_input" maxlength="4" title="전화번호 둘째자리 입력"/>
							<span class="ico">-</span>
							<input type="text" name="tel3" id="tel3" class="num_input" maxlength="4" title="전화번호 셋째자리 입력"/>
							<p class="txt"><!-- 경고메시지 표시영역 --></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><p><label for="cell1" class="required">휴대폰</label></p></th>
						<td class="table_input">
							<select name="cell1" id="cell1" class="num_input" title="휴대폰 번호 첫째자리 선택 ">
								<c:forEach var="item" items="${cell1 }">
									<option value="${item.code }">${item.code }</option>
								</c:forEach>
							</select>
							<span class="ico">-</span>
							<input type="text" name="cell2" id="cell2" class="num_input" maxlength="4" title="휴대폰번호 둘째자리 입력"/>
							<span class="ico">-</span>
							<input type="text" name="cell3" id="cell3" class="num_input" maxlength="4" title="휴대폰번호 셋째자리 입력"/>
							<div class="txt">
	                          <input type="checkbox" name="" id="phone_1">
	                          <label for="phone_1" style="margin-right:15px;">SMS 수신</label>
	                          <span>※서비스 진행상황을 문자로 알려드립니다.</span>
	                        </div>
							<p class="txt"><!-- 경고메시지 표시영역 --></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><p><label for="email1" class="required">이메일</label></p></th>
						<td class="table_input">
							<input type="text" name="email1" id="email1" class="mail_inp" title="이메일 아이디 입력"/>
							<span class="ico">@</span>
							<input type="text" name="email2" id="email2" class="mail_inp" title="이메일 도메인 입력" style="margin-right:5px;"/>
							<select id="email2_select" class="mail_select" title="이메일 도메인 선택">
								<c:forEach var="item" items="${email2 }">
									<option value="${item.code }">${item.code }</option>
								</c:forEach>
							</select>
							<div class="txt">
                          <input type="checkbox" name="" id="email_1">
                          <label for="email_1">이메일 수신</label>
                        </div>
							<p class="txt"><!-- 경고메시지 표시영역 --></p>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="btn_area">
			<div class="center">
				<a href="/" class="v1 w200">취소</a>
				<a href="javascript:goSubmit()" class="v2 w200">다음</a>
			</div>
		</div>
	</form>
</body>
</html>
