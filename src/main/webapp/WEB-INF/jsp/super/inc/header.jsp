<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>
<c:set var="site_id" value="${empty cookie.adh_menu_current_siteid ? '1' : cookie.adh_menu_current_siteid.value }"/>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/stickyfill/2.1.0/stickyfill.min.js"></script>
<script type="text/javascript">

$(function() {
	$("#site_id").on("change", function(){
		if(confirm($(this).find("option:selected").text()+"사이트 관리페이지로 이동하시겠습니까?")){
			$.cookie("adh_menu_current_siteid", $(this).val(), {path:"<c:url value="/super"/>", domain: document.domain, expires: 365});
			$("#linkFrm>input[name='site_id']").val($(this).val());
			location.href='<c:url value="/super/homepage/index.do"/>';
		}else{
			$("#site_id").find("option:eq("+this.oldIndex+")").prop("selected", true);
			return false;
		}
	});
	if(!sessionStorage.getItem("admtimeoutupdate")){//처음들어왔을때
		sessionStorage.setItem("admtimeout", new Date().getTime());
    	sessionStorage.setItem("admtimeoutupdate", "Y");
	}
	media.system.member.updateRemainingTime();
	<c:if test="${cms_member.group_seq eq '1' }">
	media.system.alram.init();
	</c:if>
	
	$(document).on("click", function(e){
		var _e = $(e.target).closest(".acnt_menu_open");		
		if(_e.size()>0 && !$('.adm_menu').is(":visible")){
			$('.adm_menu').slideDown(300);
		}else{
			$('.adm_menu').slideUp(200);
		}
	});
});

(function(_media, $, undfined){

	if(!_media.system){
		_media.system = {};
	}
	
	//로그아웃타이머작동
	function updateRemainingTime(){
		var timeout = "${pageContext.session.maxInactiveInterval}";
		var currentTime = Math.round(new Date().getTime());
		var creationTime = sessionStorage.getItem("admtimeout");
		var runningTime = Math.round((currentTime-creationTime)/1000);
		var remainingTime = timeout-runningTime;
		var output = "";
		if (remainingTime < 60) {
			output = remainingTime + '초';
		} else if (remainingTime < 3600){
			output = Math.floor(remainingTime%3600/60) + '분 ' + remainingTime%60 + '초';
		} else {
			output = Math.floor(remainingTime/3600) + '시간 ' + Math.floor((remainingTime % 3600)/60) + '분 ' + remainingTime%60 + '초';
		}
		$(".logout_timer").text(output);
		if(remainingTime <= 0){
			location.href="/super/login/logout.do?redirectUrl=/super/login/index.do";
		}
		var onpopup = sessionStorage.getItem("admtimeout_pop");
		if(onpopup!="Y" && remainingTime <= 300){//1분전알림
			$("#timeout-dialog-confirm").dialog({
				resizable: false,
			    height: "auto",
			    width: 350,
			    modal: true,
			    buttons: {
				    "예": function() {
				    	var _this = $(this);
				    	var promise = session_keep(); 
				    	promise.then(function(){
							_this.dialog( "close" );
				    	});
				    },
				    "아니오": function() {
				    	sessionStorage.setItem("admtimeout_pop", "Y");
				    	sessionStorage.setItem("admtimeoutupdate", "N");
				    	$( this ).dialog( "close" );
				    }
				}
			});
		}
		setTimeout(updateRemainingTime, 1000);
	}
	
	function session_keep(){
		return getSyncJSON("/super/login/session_keep.do", {}, function(){
	    	sessionStorage.setItem("admtimeout", new Date().getTime());
	    	sessionStorage.setItem("admtimeoutupdate", "Y");
			sessionStorage.removeItem("admtimeout_pop");
		});
	}
	function logout_extension(){
		if(confirm("로그인시간을 연장하시겠습니까?")){
			getSyncJSON("/super/login/session_keep.do", {}, function(){
		    	sessionStorage.setItem("admtimeout", new Date().getTime());
		    	sessionStorage.setItem("admtimeoutupdate", "Y");
				sessionStorage.removeItem("admtimeout_pop");
			});
		}
	}
	
	function logout(){
		if(confirm("관리시스템을 로그아웃 하시겠습니까?")){
			location.href="<c:url value='/super/login/logout.do?redirectUrl=/super/login/index.do'/>";
		}
	}
	
	_media.system.member = {
		logout : logout,
		session_keep : session_keep,
		logout_extension : logout_extension,
		updateRemainingTime : updateRemainingTime,
	};

	var alram_list = [];	
	function getList(){
		getJSON("/super/inc/overplus.do", {}, function(data){
			$("#online_count").text(data.online_count+ "명");
			$("#alram_count").text(data.alram_list.length+ "건");
			$("ul#alram_list").empty();
			alram_list = data.alram_list;
			$.each(data.alram_list, function(i, o){
				var htm = "";
				htm += '<li class="on">';
				htm += '	<div class="top">';
				htm += '		<p>개인정보 의심 필터링 검출<span>'+ o.reg_dt +'</span></p>';
				htm += '	</div>';
				htm += '	<div class="bottom">';
				htm += '		<p>'+ o.page_nm +' 게시판에 개인정보로 의심되는 정보가 있습니다.</p>';
				htm += '		<ul>';
				htm += '			<li>제목 : '+ o.title +'</li>';
				htm += '		<li>작성자 : '+ o.reg_nm +'</li>';
				htm += '		<li>작성일 : '+ o.reg_dt +'</li>';
				htm += '		</ul>';
				htm += '		<input type="button" value="확인" onclick="media.system.alram.alramLink(\''+ o.cms_menu_seq +'\', \''+ o.parent_menu_seq +'\', \''+ o.board_type +'\', \''+ o.article_seq +'\');"/>';
				htm += '	</div>';
				htm += '</li>';
				$("ul#alram_list").append(htm);
			});
		});
	}
	function alramLink(cms_menu_seq, parent_menu_seq, board_type, article_seq){
		var promise = this.alramClose("FILTER", article_seq);
		promise.done(function(){
			location.href="/super/homepage/bbs/index.do?cms_menu_seq="+ cms_menu_seq +"&parent_menu_seq="+ parent_menu_seq +"&permit=Y#!/modify/"+ board_type +"/"+ article_seq;
			getList();
		});
	}
	function alramClose(table_cd, article_seq){
		var promise = getJSON("/super/alram/alram_close.do", {table_cd: 'FILTER', article_seq : article_seq});
		return promise;
	}
	function alramAllClose(){
		var promiseArr = [];
		$.each(alram_list, function(i, o){
			promiseArr.push(getSyncJSON("/super/alram/alram_close.do", {table_cd: 'FILTER', article_seq : o.article_seq}));
		});
		$.when(promiseArr).done(function(){
			getList();
		});
	}
	function init(){
		getList();
		$(document).on("click", function(e){
			if($(e.target).is(".alarm :button") && $(".newAlarm").is(":hidden") == true){
				$('.newAlarm').slideDown(300);
			}else{
				$('.newAlarm').slideUp(200);
			}
		});
	}

	_media.system.alram = {
		init : init,
		getList : getList,
		alramLink : alramLink,
		alramClose : alramClose,
		alramAllClose : alramAllClose
	};

	window.media = _media;

}(window.media || {}, jQuery));

//left 메뉴 색상변경
$(document).ready(function() {
		
	$('.color_swap').click(function() {
		let el = $('.left_wrap');
		el.toggleClass('light_color');
		localStorage.setItem('switch-color', el.hasClass('light_color'));
	});
	
	if (localStorage.getItem('switch-color') && localStorage.getItem('switch-color') === "true") {
		$('.left_wrap').addClass('light_color');
	}
	
});

</script>
<style>
.mCSB_inside>.mCSB_container{margin-right:15px;}
#timeout-dialog-confirm p:last-child{margin-top:5px;}
#timeout-dialog-confirm p span.logout_timer{font-family:"NanumBarunGothicB"; font-size:14px;}
</style>
<div id="timeout-dialog-confirm" title="로그인연장 사용" style="height:0;">
  <p><span class="ui-icon ui-icon-alert" style="float:left;display:none;"></span>로그인 시간을 연장하시겠습니까?</p>
  <p><span class="logout_timer"></span> 후 로그아웃 됩니다.</p>
</div>

  <div id="headerwrap">
    <div class="headerlogo_wrap">
      <h1>
      	<a href="<c:url value="/super/"/>"><img src="<c:url value="/images/cms/header/gg.png"/>" alt="" /></a>
<!--       	<span>MC@CMS<span> eGov Pro <b>v1.5.0</b></span></span> -->
			<span>소상공인 종합지원 포털 관리자 페이지</span>
      </h1>
      <div class="admin_profile">
        <ul>
        	<%--
        	<li class="connect">
        		<input type="button" class="color_swap" value="변경" />
        		<p>메뉴색상전환</p>
        	</li>
        	--%>
        	<c:if test="${cms_member.group_seq eq '1' }">
        	<li class="connect">
        		<input type="button" value="접속현황" onclick="location.href='/super/site/current_user/index.do?cms_menu_seq=806'"/>
        		<p>접속중인 관리자 : <span id="online_count"></span></p>
        	</li>
        	</c:if>
        	<c:if test="${cms_member.group_seq eq '1' }">
        	<li class="alarm">
        		<input type="button" value="보기"/>
        		<p>알림 : <span id="alram_count"></span></p>
        		<div class="newAlarm" style="display:none;">
        			<div class="tit">
        				<p>새로운 알림</p>
        				<a href="javascript:media.system.alram.alramAllClose()">새알림 모두 확인</a>
        			</div>
        			<div class="con mCustomScrollbar alarm_box _mCS_1 mCS_no_scrollbar">
	       				<ul id="alram_list">
	       				</ul>
       				</div>
        		</div>
        	</li>
        	</c:if>
        	<li class="menual_btn">
        		<p>도움말</p>
        		<a href="javascript:void(0)">보기</a>
        	</li>
			<c:if test="${fn:length(site_list) > 0 }">
        	<li class="site_select">
      			<p>사이트선택</p>
				<div class="admin_topsel">
					<select name="site_id" id="site_id" onfocus="this.oldIndex=this.selectedIndex">
						<c:forEach var="item" items="${site_list }">
						<option value="${item.cms_menu_seq }" <c:if test="${site_id eq item.cms_menu_seq }">selected="selected"</c:if>>${suf:clearXSS(item.title, '')}(${item.sub_path })</option>
						</c:forEach>
					</select>
				</div>
        	</li>
			</c:if>
			<li class="the_latest"><p>(최근접속 : ${cms_member.last_login }[<span prettydate data-auto-update="true" data-duration="10000">${cms_member.last_login }</span>])</p></li>
        	<li class="timer">
        		<input type="button" value="연장" onclick="media.system.member.logout_extension()"/>
        		<p class="logout_timer"></p>
        	</li>
        	<li class="acnt_menu_open">
        		<p class="profileico">${sessionScope.cms_member.member_nm }</p>
        		<span style="color:#fff;"> 님</span>
        		<ul class="adm_menu">
        			<li><a class="acnt_set" href="/super/homepage/member/index.do" alt="정보수정">정보수정</a></li>
        			<li><a class="log_out" href="javascript:media.system.member.logout();" alt="로그아웃">로그아웃</a></li>
        		</ul>
        	</li>
        </ul>
      </div>
    </div>
  </div>
  <script>
	  var element = document.getElementById('headerwrap'); // position: sticky 속성을 적용한 엘리먼트 선택
	  Stickyfill.add(element);
  </script>