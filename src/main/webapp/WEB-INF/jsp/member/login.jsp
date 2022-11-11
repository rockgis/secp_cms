<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>로그인</title>
<link href="/lib/css/jquery.datetimepicker.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/lib/js/jquery.datetimepicker.js"></script>
<script type="text/javascript">
$(function(){
	
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
			$.cookie("login_id", $("#member_id").val(), {path:"/", domain: document.domain, expires: 365 });
		}else{
			$.cookie("login_id", "", {path:"/", domain: document.domain, expires: -1 });
		}
		
		var promise = getSyncJSON("/login/check_id.do", {member_id : $("#member_id").val(), member_pw : $("#member_pw").val()});
		var rst = false;
		promise.done(function(data){
			if(data.rst == "UX"){
				/* alert("존재하지 않는 아이디입니다."); */
				alert("일치하는 계정정보가 존재하지 않습니다.");
			}else if(data.rst == "X"){
				/* alert("입력하신 비밀번호가 일치하지 않습니다.\n확인하시고 다시 로그인 해주세요.("+data.fail_cnt+"회 오류)\n5회 오류시 로그인이 제한됩니다."); */
				alert("일치하는 계정정보가 존재하지 않습니다.");
			}else if(data.rst == "P" || data.rst == "M"){
				location.href="advise_change_pw.do?member_id="+$("#member_id").val() + "&member_pw="+$("#member_pw").val();
				rst = false;
			}else if(data.rst == "J"){
				location.href="dormancy.do?member_id="+$("#member_id").val();
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
			}else if(data.rst == "G"){
			    alert("사용중지 된 그룹의 계정입니다.\n관리자에게 문의하세요.");
			    rst = false;
			}else if(data.rst == "D"){
			    alert("삭제 된 그룹의 계정입니다.\n관리자에게 문의하세요.");
			    rst = false;
			}
		});
		
		return rst;
	});
	
	$("#startDate1, #endDate1").datetimepicker({
		format :"Y-m-d H:m",
		timepicker : true
	});
	
	$("#startDate2, #endDate2").datetimepicker({
		format :"Y-m-d",
		timepicker : false
	});

});
</script>
</head>
<body class="loginbody">
  <!-- <div id="login_wrap">  -->
      <div class="login_wrap">
     	  <div class="l_img">
                <img src="/images/new/sub/login.gif" alt="">
                <p class="tit">L<span>O</span>GIN</p>
                <p class="txt">"환영합니다."</p>
          </div>
		  <form id="frm" name="frm" method="post" action="/loginProcess.do"><!-- 스프링 시큐리티 로그인사용 바꾸지마세요 -->
		  <sec:csrfInput />
		  		<input type="hidden" name="returnURL" value="${empty param.returnURL ? '/' : param.returnURL }"/>
		      <fieldset>
		        <legend>로그인</legend>
			      <div class="l_input">		  
					    <div>
						    <div>
						   		<label for="member_id">아이디</label>
						    	<input type="text" name="member_id" id="member_id" placeholder="아이디">
						    </div>
						    <div>
						    	<label for="member_pw">비밀번호</label>
						    	<input type="password" name="member_pw" id="member_pw" placeholder="비밀번호" autocomplete="off">
						    </div>
					    </div>
					    <span class="login_btn">
					    	<input type="submit" value="로그인" class="btn_b"/>
					    </span>
					    <!-- <div class="id_check">
					      <label>
					        <input type="checkbox" class="check" id="id_check"/> <span>아이디저장</span>
					      </label>
					    </div> -->
				  </div>	  
		      </fieldset>
		  </form>
		  
		  <br/><br/>
		  <input type="text" id="startDate1" style="padding:10px;"> ~ <input type="text" id="endDate1" style="padding:10px;"><br/><br/>
		  <input type="text" id="startDate2" style="padding:10px;"> ~ <input type="text" id="endDate2" style="padding:10px;"><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
		  
		  <div class="link_box">
			  <div class="left">
			    <div>
			      <p class="tit">아직 회원이 아니신가요?</p><!--   /web2/lay1/program/S339T387C389/member/join_step1.do    	/web/lay1/program/S1T2C3/member/join_step1.do -->
			      <p class="txt">회원가입을 하시면 신청, 조회, 보너스포인트 지급 등의<br>서비스를 보다 편리하게 제공받으실 수 있습니다.</p>
			    </div>
			    <a href="join_step1.do" class="btn_g">회원가입<br>바로가기</a>
			  </div>
			  <div class="right">
			    <div>
			      <p class="tit">아이디 또는 비밀번호를 잊으셨나요?</p><!--  /web2/lay1/S339T387C438/contents.do      /web/lay1/S1T2C440/contents.do -->
			      <p class="txt">회원가입시 등록한 [이메일 주소]를 통해<br> 아이디, 비밀번호를 확인하실 수 있습니다.</p>
			    </div>
			    <a href="id_search.do" class="btn_g">아이디/비밀번호 찾기</a>
			  </div>
		</div>
	  </div>
  <!-- </div> -->
</body>
</html>
