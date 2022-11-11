<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<sec:csrfMetaTags/>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta property="og:image" content="">
<meta name="keywords" content="">
<meta name="description" content="">
<meta http-equiv="refresh" content="600"><!-- csrf 시간만료 방지 5분마다 페이지 갱신 -->
<title>소상공인 종합지원 포털 CMS Log-In</title>

<!-- ggbaro -->
	<style type="text/css">
		.loginbody {padding: 0; margin: 0;}
		#login_wrap {width: calc( 100vw - 450px ); height: 100vh; background: url(/images/super/ggbaro/login_bg.jpg) no-repeat center center / cover;}
		.loginbox {width: 450px; height: 100vh; background: #00419b; color: #fff; position: fixed; top: 0; right: 0; padding: 30px; box-sizing: border-box;}
		.login_logo {position: absolute; top: 50%; left: calc( (100% - 450px) / 2 ); transform: translate(-50%, -50%); text-align: center;}
		.login_logo p {font-size: 30px; font-weight: 600; color: #003176; margin: 20px 0 0 0;}
		.copyright {position: absolute; bottom: 30px; left: calc( (100% - 450px) / 2 ); transform: translate(-50%, -50%); text-align: center; color: #767f97; opacity: .5; text-transform: uppercase; font-size: 14px;}
		.input_lo {background: #fff; height: 60px; line-height: 60px; padding: 0 20px; border: 0; width: 100%; box-sizing: border-box; border-radius: 5px; font-size: 18px; color: #333;}
		.input_lo::placeholder {color: #ccc;}
		.memberlogin fieldset {border: none; position: absolute; top: 45%; transform: translateY(-50%); padding: 0; width: calc( 100% - 60px );}
		.memberlogin fieldset legend {text-align: center; margin: 0 0 50px;}
		.login_btn input {background: #02983b; color: #fff; font-size: 18px; display: block; height: 60px; line-height: 60px; text-align: center; border: 0; width: 100%; border-radius: 5px; transition: all .3s; cursor: pointer;}
		.login_btn input:hover {background: #00ba47;}
		.id_check {padding: 20px 0 15px; color: rgba(255,255,255,.6);}
		.id_check input {width: 20px; height: 20px; vertical-align: middle; margin-top: -1px; border: 1px solid rgba(255,255,255,.4); background-color: rgba(255,255,255,.4); border-radius: 3px; appearance: none;}
		.id_check input:checked {background: url(/images/super/ggbaro/ico_check_w.svg) no-repeat center / cover #f5a700; border: 1px solid #f5a700;}
	</style>
<script type="text/javascript" src="<c:url value="/lib/js/jquery-3.5.1.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery-migrate-1.4.1.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/mc.js" />"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.cookie.js" />"></script>
<script type="text/javascript">
$(function(){
	sessionStorage.removeItem("admtimeout_pop");
	sessionStorage.removeItem("admtimeoutupdate");
	sessionStorage.removeItem("admtimeout");
	
	if(!!$.cookie("login_id")){
		$("#member_id").val($.cookie("login_id"));
		$("#id_check").prop("checked", true);
	}

	$("#frm").on("submit", function(){
		if($("#member_id").val() == ""){
			alert("아이디를 입력하여 주시기 바립니다.");
			$("#member_id").focus();
			return false;
		}
		if($("#member_pw").val() == ""){
			alert("비밀번호를 입력하여 주시기 바립니다.");
			$("#member_pw").focus();
			return false;
		}
		
		if($("#id_check").prop("checked")){
			$.cookie("login_id", $("#member_id").val(), {path:"/super", domain:document.domain, expires: 365 });
		}else{
			$.cookie("login_id", "", {path:"/super", domain:document.domain, expires: -1 });
		}
		
		var promise = getSyncJSON("/super/login/check_id.do", {member_id : $("#member_id").val(), member_pw : $("#member_pw").val()});
		var rst = false;
		promise.done(function(data){
			if(data.rst == "UX"){
				/* alert("존재하지 않는 아이디입니다."); */
				alert("일치하는 계정정보가 존재하지 않습니다.");
			}else if(data.rst == "X"){
				/* alert("입력하신 비밀번호가 일치하지 않습니다.\n확인하시고 다시 로그인 해주세요.("+data.fail_cnt+"회 오류)\n5회 오류시 로그인이 제한됩니다."); */
				alert("일치하는 계정정보가 존재하지 않습니다.");
			}else if(data.rst == "P" || data.rst == "M"){
				window.open("/member/advise_change_pw_adm.do?member_id="+$("#member_id").val(), 'twtlogin', 'width=550, height=350, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
				rst = false;
			}else if(data.rst == "J"){
				window.open("/member/dormancy_adm.do?member_id="+$("#member_id").val(), 'twtlogin', 'width=550, height=350, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
				rst = false;
			}else if(data.rst == "N"){
				rst = true;
			}else if(data.rst == "Y"){
				if(!confirm("이미 접속중인 사용자가 있습니다. 기존 접속을 종료시킨 후 진행하시겠습니까?")){
					rst = false;
				}else{
					rst = true;
				}
			}else if(data.rst == "B"){
			    alert("사용중지 된 계정입니다.\n관리자에게 문의하세요.");
			    rst = false;
			}
		});
		
		return rst;
	});
	
	
});
</script>
</head>
<body class="loginbody">
	<div id="login_wrap">
		<div class="login_logo">
			<img src="/images/super/ggbaro/login_logo.png" alt="경기도">
			<p>소상공인 종합지원 플랫폼 관리자</p>
		</div>
    	<div class="loginbox">
	    	<div class="memberlogin">
		  		<form id="frm" name="frm" method="post" action="/loginProcess.do"><!-- 스프링 시큐리티 로그인사용 바꾸지마세요 -->
<sec:csrfInput />
		  			<input type="hidden" name="returnURL" value="${empty param.returnURL ? '/super/homepage/index.do' : param.returnURL }"/>
		      		<fieldset>
		        		<legend><img src="/images/super/ggbaro/login_tit.png" alt="로그인"></legend>
			      		<div class="memboxlogin">		  
						    <input type="text" name="member_id" id="member_id" class="input_lo" style="margin-bottom:15px;" placeholder="아이디">
						    <input type="password" name="member_pw" id="member_pw" class="input_lo" placeholder="비밀번호" onkeypress="capLock(event)">
					    	<div id="capslock" style="display: none;">Caps Lock이 켜져 있습니다.</div>
						    <div class="id_check">
						      	<label>
						        	<input type="checkbox" class="check" id="id_check"/> <span>아이디저장</span>
						      	</label>
					    	</div>
					    	<span class="login_btn"><input type="submit" value="Log-In" /></span>
				  		</div>	  
		      		</fieldset>
		  		</form>
	  		</div>
		<p class="copyright">Copyright(c)2022 GMRA. All Rights Reserved.</p>
		</div>	  
	</div>
</body>
</html>
