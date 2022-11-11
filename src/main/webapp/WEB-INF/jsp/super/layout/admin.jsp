<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<c:set var="requestURI" value="${servlet_path == null ? requestScope['javax.servlet.forward.servlet_path'] : servlet_path}"/>
<c:set var="leftMenu" value="${fn:split(requestURI,'/')[1] }"/>
<c:if test="${empty sessionScope.cms_member}">
	<!-- 파라미터 -->
	<c:url var="returnURL" value="${requestURI }">
		<c:forEach var="item" items="${pageContext.request.parameterNames}">
		<c:param name="${item }" value="${param[item] }"></c:param>
		</c:forEach>
	</c:url>
</c:if>
<c:set var="site_id" value="${empty cookie.adh_menu_current_siteid ? '1' : cookie.adh_menu_current_siteid.value }"/>
<!DOCTYPE HTML>
<html data-ng-app="MyApp">
<head>
<sec:csrfMetaTags/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10" />
<title>CMS 관리자 <sitemesh:write property='title'/></title>
<link rel="shortcut icon" href="/images/common/favicon.ico">
<link href="<c:url value="/lib/css/jquery.mCustomScrollbar.min.css"/>" rel="stylesheet" type="text/css" />
<link href="<c:url value="/lib/css/base/jquery-ui-1.12.1.css"/>" rel="stylesheet" type="text/css" />
<link href="<c:url value="/lib/css/base/jquery-ui.theme.css"/>" rel="stylesheet" type="text/css" />
<link href="<c:url value="/lib/css/jquery.datetimepicker.css"/>" rel="stylesheet" type="text/css" />
<link href="<c:url value="/lib/css/common.css"/>" rel="stylesheet" type="text/css" />
<link href="<c:url value="/lib/css/cmsadmin.css"/>" rel="stylesheet" type="text/css" />
<link href="<c:url value="/lib/css/admin.css"/>" rel="stylesheet" type="text/css" />
<link href="<c:url value="/lib/css/cmscustom.css"/>" rel="stylesheet" type="text/css" /><!-- 추가 개발되는 기관/업체 전용 css -->
<link href="<c:url value="/lib/css/jquery.bxslider.css"/>" rel="stylesheet" type="text/css" />



<script type="text/javascript" src="/AUIGrid/js/ajax.js"></script>
<script type="text/javascript" src="/AUIGrid/js/common.js"></script>

<!-- AUIGrid 테마 CSS 파일입니다. 그리드 출력을 위해 꼭 삽입하십시오. -->
<!-- 원하는 테마가 있다면, 다른 파일로 교체 하십시오. -->
<link href="/AUIGrid/AUIGrid_style.css" rel="stylesheet">

<!-- AUIGrid 라이센스 파일입니다. 그리드 출력을 위해 꼭 삽입하십시오. -->
<script type="text/javascript" src="/AUIGrid/AUIGridLicense.js"></script>

<!-- 실제적인 AUIGrid 라이브러리입니다. 그리드 출력을 위해 꼭 삽입하십시오.--> 
<script type="text/javascript" src="/AUIGrid/AUIGrid.js"></script>
<script type="text/javascript" src="/AUIGrid/AUIGrid.pdfkit.js"></script>

<script type="text/javascript" src="/js/admin/js-xlsx/shim.min.js"></script>
<script type="text/javascript" src="/js/admin/js-xlsx/jszip.js"></script>
<script type="text/javascript" src="/js/admin/js-xlsx/xlsx.full.min.js"></script>



<style type="text/css">
<c:if test="${cookie.adh_left_toggle.value=='1'}">
.menuwrap{display:none;}
.left_wrap{left:-260px;}
#main{margin-left:21px;}
</c:if>
<c:if test="${cookie.adh_right_toggle.value=='1'}">
.topBar_inner{display:none;}
.ct_wrap{margin-right:0;}
</c:if>
</style>
<script type="text/javascript" src="<c:url value="/lib/js/jquery-3.5.1.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery-migrate-1.4.1.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery-ui-1.12.1.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.cookie.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.form.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.mCustomScrollbar.concat.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.datetimepicker.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.blockUI.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.lck.util.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/mc.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/prettydate/prettydate.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/prettydate/prettydate.zh-KO.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.bxslider.min.js"/>"></script>
<sitemesh:write property='head'/>
<script type="text/javascript" src="<c:url value="/lib/js/require.js"/>"></script>
<script type="text/javascript">
var contextPath = "<c:url value='/'/>".replace(/\/$/, "");
$(function(){
	$(".toggleLeftBtn").toggle(function(){
		$(".menutap > div a").css("transform", "rotate(180deg)");
		$(".menuwrap").hide("slide", { direction: "left" }, 500);
		$(".left_wrap").animate({
			left:-263
		}, 500);
		$("#main").animate({
			marginLeft:18
		}, 500);
		$.cookie("adh_left_toggle", "1", {path:"<c:url value="/super"/>", domain:document.domain, expires: 365})
	},function(){
		$(".menutap > div a").css("transform", "rotate(0deg)");
		$(".menuwrap").show("slide", { direction: "left" }, 500);
		$(".left_wrap").animate({
			left:0
		}, 500);
		$("#main").animate({
			marginLeft:281
		}, 500);
		$.cookie("adh_left_toggle", "0", {path:"<c:url value="/super"/>", domain:document.domain, expires: -1})
	});
	if($.cookie("adh_left_toggle")=="1"){
		$(".toggleLeftBtn").trigger("click");
	}
	
	$(document).on("click", ".optBtn", function(){
		if($(".topBar_inner").is(":visible")){
			$(".optBtn a img").css("transform", "rotate(180deg)");
			$(".topBar_inner").hide("slide", { direction: "right" }, 500);
			$(".ct_wrap").animate({
				marginRight:10
			}, 500);
			$.cookie("adh_right_toggle", "1", {path:"<c:url value="/super"/>", domain:document.domain, expires: 365})
		}else{
			$(".optBtn a img").css("transform", "rotate(0deg)");
			$(".topBar_inner").show("slide", { direction: "right" }, 500);
			$(".ct_wrap").animate({
				marginRight:242
			}, 500);
			$.cookie("adh_right_toggle", "0", {path:"<c:url value="/super"/>", domain:document.domain, expires: -1})
		}
	});
});
/* 
//사이트관리 / 시스템관리에서는 btn_bottom이 긴 스크롤에 fixed로 뜨지 않도록 함
/* $(document).ready(function(){
	function btnBottom(){
		var $footer = $('.btn_bottom');
		if($footer.length == 0){
			setTimeout(function(){
				btnBottom();
			}, 500);
			return false;
		}
		var $win = $(window);
		var wpos, space;
		var otop = $footer.offset().top;
		function h(e) {
			wpos = $win.scrollTop();
			space = $win.height() - $footer.height();
			if (wpos + space < otop) {
				$footer.addClass('fixed');
			} else {
				$footer.removeClass('fixed');
			}
		}
		$(window).ready(h).resize(h).scroll(h);
	}
	btnBottom();
}); */
</script>
</head>
<body>
<div class="wrap">

	<sitemesh:decorate decorator="/super/inc/header.do" />

  <div class="container">

	  <div class="left_wrap">
	
	  	<!-- 메뉴관리탭부분 -->
		<div class="menutap">
		  	<ul class="site_setting">
			    <li class="leftmenu1_1"><a href="<c:url value="/super/homepage/index.do"/>" <c:if test="${leftMenu eq 'homepage'}">class="on"</c:if>>메뉴관리</a></li>
			    <c:if test="${sessionScope.cms_member.group_seq eq '1' || sessionScope.cms_member.group_seq eq '2'}">
			    <%-- <li class="leftmenu1_2"><a href="<c:url value="/super/user/index.do"/>" <c:if test="${leftMenu eq 'user'}">class="on"</c:if>>회원관리</a></li> --%>
			    <li class="leftmenu1_2"><a href="<c:url value="/super/site/index.do"/>" <c:if test="${leftMenu eq 'site'}">class="on"</c:if>>사이트관리</a></li>
			    </c:if>
			    <c:if test="${sessionScope.cms_member.group_seq eq '1' }">
			    <li class="leftmenu1_3"><a href="<c:url value="/super/system/index.do"/>" <c:if test="${leftMenu eq 'system'}">class="on"</c:if>>시스템관리</a></li>
			    </c:if>
		  	</ul>
			<div><a href="#" class="toggleLeftBtn">메뉴닫기</a></div>
		</div>
		<!-- 레프트메뉴부분 -->
		<c:choose>
			<c:when test="${leftMenu == 'system' }">
				<sitemesh:decorate decorator="/super/system/left.do" />
			</c:when>
			<c:when test="${leftMenu == 'user' }">
				<sitemesh:decorate decorator="/super/user/left.do" />
			</c:when>
			<c:when test="${leftMenu == 'site' }"><!-- 사용안함 -->
				<sitemesh:decorate decorator="/super/site/left.do" />
			</c:when>
			<c:otherwise>
				<sitemesh:decorate decorator="/super/homepage/left.do" />
			</c:otherwise>
		</c:choose>
		</div>
		<div id="main">
			<sitemesh:write property='body'/>
			<div class="menual" style="display:none;">
				<div class="dim_layer"></div>
				<div class="inner">	
								
					<div class="header">
						<p>상단메뉴</p>
						<ul class="menu">
							<li class="on"><a href="javascript:void(0);">상단메뉴</a></li>
							<li><a href="javascript:void(0);">좌측메뉴</a></li>
							<li><a href="javascript:void(0);">메뉴관리</a></li>
							<li><a href="javascript:void(0);">콘텐츠 등록</a></li>
							<li><a href="javascript:void(0);">홈페이지 이미지 등록</a></li>
						</ul>
					</div>
					<div class="con" style="display:block;">
						<ul class="nav">
							<li>메인화면 상단메뉴</li>
						</ul>
						<ul>
							<li><img src="/images/super/menual01.gif" alt="" /></li>
						</ul>
					</div>
					<div class="con">
						<ul class="nav">
							<li>메인화면 좌측메뉴</li>
						</ul>
						<ul>
							<li><img src="/images/super/menual02.gif" alt="" /></li>
						</ul>
					</div>
					<div class="con">
						<ul class="menual_slide">
							<li><img src="/images/super/menual03_01.gif" alt="" /></li>
							<li><img src="/images/super/menual03_02.gif" alt="" /></li>
						</ul>
					</div>
					<div class="con">
						<ul class="menual_slide">
							<li><img src="/images/super/menual04_01.gif" alt="" /></li>
							<li><img src="/images/super/menual04_02.gif" alt="" /></li>
						</ul>
					</div>
					<div class="con">
						<ul class="nav">
							<li>사이트관리</li>
							<li>메인 이미지 관리/팝업관리</li>
						</ul>
						<ul class="menual_slide">
							<li><img src="/images/super/menual05_01.gif" alt="" /></li>
							<li><img src="/images/super/menual05_02.gif" alt="" /></li>
						</ul>
					</div>					
					<div class="btn"><a href="javascript:void(0);" class="close"><img src="/images/super/close_ico.png" alt="" /></a></div>
				</div>
			</div>
			<!-- 메뉴얼 버튼 -->
			<%--
			<div class="menual_btn"><a href="javascript:void(0);"><span>메뉴얼</span></a></div> 
			 --%>
		</div>
	</div>
</div>
<script type="text/javascript">
var loadBx1 = null;

$(document).ready(function(){
	$(".menual_btn a").on("click", function(){ /* focusin */  
		  if($(".menual").css("display") == "none"){
			  $(".menual").fadeIn(300);
		  } else {
			  $(".menual").fadeOut();
		  } 
	});  
	
	$(".close").on("click", function(){  
		  if($(".menual").css("display") == "block"){
			  $(".menual").fadeOut();
		  } 
	});
	
	$(".dim_layer").on("click", function(){  
		  if($(".menual").css("display") == "block"){
			  $(".menual").fadeOut();
		  } 
	});
	
	$(".menu li").each(function(i){
		$(this).on("click", function(){
			$(".menual .inner .con").css("display","none");
			$(".menual .inner .con:eq("+i+")").css("display","block");
		});
	});
	
	
	var slider = $('.menual_slide').bxSlider({
		slideWidth: 1019,
		minSlides: 1,
		maxSlides: 2,
		moveSlides: 1,
		slideMargin: 0,
		speed : 500,
		mode : "fade",
		pager : false,
		infiniteLoop : false,
		hideControlOnEnd : true		
	});
	

	$(".menu li").on("click",function(e){
		e.preventDefault();
		$(".menu li").removeClass("on");
		$(this).addClass("on");		
		$(".menual .inner .header p").text($('.menu li.on').text());
		
		if($(e.target).attr("class") === "on"){
			slider.reloadSlider();
		}
		
	});
	
});
</script>
<script type="text/javascript">
$(document).ready(function(){
	setTimeout(function(){
		if($.inArray(location.pathname, ["/super/system/index.do", "/super/homepage/index.do", "/super/site/index.do"]) < 0){
			var title = $(".titlebar>div").text().trim().replace(/\n|\t| /gim, '');
			tracking_params = {"url":location.pathname+location.search,"title":title, "job":"이동"};
			getJSON("/super/tracking.do", tracking_params);	
		}
	},500);
})
</script>
</body>
</html>
