<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="site_id" value="${empty cookie.adh_menu_current_siteid ? '1' : cookie.adh_menu_current_siteid.value }"/>
<style>
<!--
.mCS-my-theme .mCSB_container{ margin-right:9px;  }
.mCS-my-theme.mCSB_scrollTools{ margin-right: -3px  }
.mCS-my-theme.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar{ background-color: white; width: 5px;}
.mCS-my-theme.mCSB_scrollTools .mCSB_draggerRail{ background-color: #161c28; } 
-->
</style>
<script type="text/javascript">
$(function() {
	menuInit();
	$(".bt_open").on("click", openMenu);
	$(".bt_re").on("click", closeMenu);
	$(".menu_scroll>ul>li div").on("click", toggleMenu);
	scrollable();
	get_favorites();
	
	//페이지 이동시 클릭이벤트 버블링 해제
	$(".menu_scroll a").on("click", function(e){
		e.stopPropagation();
	});
});
function get_favorites(){
	var data = localStorage.getItem("favorites_${sessionScope.cms_member.member_id}");
	if(data != null){
		$.each($.parseJSON(data).list, function(i, o){
			$(".bookmark>ul").append("<li><a href='"+o.url+"'>"+o.title+"</a></li>");
			$(".booker[menu_seq='"+o.menu_seq+"']>a").swapClass("on", "off");
		});
	}
}

//메뉴열기
function openMenu(){
	$(".menu_scroll>ul>li>ul li").show();
	menuSave();
}
//메뉴닫기
function closeMenu(){
	$(".menu_scroll>ul>li>ul li").hide();
	menuSave();
}
//메뉴토글
function toggleMenu(){
	$(this).siblings("ul").children("li").toggle();
	menuSave();
}
//페이지 열리면 열고 닫은 정보 불러오기
function menuInit(){
	$(".menu_scroll li").filter(function(){
		return $(this).has("li").size()==0;
	}).addClass("last");

	var toggle_info = localStorage.getItem("adc_menu_${sessionScope.cms_member.member_id}");
	if(!!toggle_info){
		var data = toggle_info.split(",");
		for (var i = 0; i < data.length; i++) {
			$("li[menu_seq='"+data[i]+"']").children("ul").hide();
		}
	}
	$(".menu_scroll li").each(function(){
		if($(">ul>li:visible", this).size()>0){
			$(this).swapClass("on", "off");
			$(">div>span:first>a", this).swapClass("on", "off");
		}
	});
	$("li[menu_seq='${empty param.cms_menu_seq ? param.parent_menu_seq : param.cms_menu_seq}']").addClass("active").parents(".menu_scroll li").addClass("active").end().parents(".menu_scroll ul").show();
}
//메뉴 열고닫은 정보를 다음페이지에서도 유지하기 위해 사용
function menuSave(){
	var rst = [];
	$(".menu_scroll>ul>li>ul li").filter(":hidden").each(function(i, o){
		rst.push($(o).attr("menu_seq"));
	});
	localStorage.setItem("adc_menu_${sessionScope.cms_member.member_id}", rst.join(","));
}
//스크롤
function scrollable(){
	$(window).scrollTop(0);
	var menu_box_top = $(".menu_box").offset().top;
	var initTop = localStorage.getItem("adc_scroll")==null ? 0 : localStorage.getItem("adc_scroll");
	var height = $(window).height() - menu_box_top;
	$(".menu_box").height(height).mCustomScrollbar({
		axis:"y",
		theme : "my-theme",
		scrollbarPosition:"inside",
		setTop:initTop-1+"px",
		callbacks : {
			onScroll : function(){
				localStorage.setItem("adc_scroll", this.mcs.top);
			},
			whileScrolling:function(){
				localStorage.setItem("adc_scroll", this.mcs.top);
			}
		}
	});
}
</script>

<div class="menuwrap">
	<div class="menu_top">
		<!-- <p class="bt_open">메뉴펼치기/닫기</p>
		<p class="bt_re">메뉴펼치기/닫기</p>
		<p class="bt_none"></p>-->
	</div> 
	<div class="menu_box">
		<div class="menu_scroll site_left">
			<ul>
				<li menu_seq="800" class="last">
					<div>
						<span class="name"><a href="/super/site/site_setting/index.do?site_id=${site_id}&cms_menu_seq=800" class="">홈페이지 기본 설정</a></span>
					</div>
				</li>
<!-- 				<li menu_seq="800" class="last"> -->
<!-- 					<div> -->
<%-- 						<span class="name"><a href="<c:url value="/super/site/layout_setting/index.do?cms_menu_seq=800"/>" class="">레이아웃구성</a></span> --%>
<!-- 					</div> -->
<!-- 				</li> -->
<!-- 				<li menu_seq="801" class="last"> -->
<!-- 					<div> -->
<%-- 						<span class="name"><a href="<c:url value="/super/site/basic_setting/index.do?cms_menu_seq=801"/>" class="">기본설정</a></span> --%>
<!-- 					</div> -->
<!-- 				</li> -->
<!-- 				<li menu_seq="802" class="last"> -->
<!-- 					<div> -->
<%-- 						<span class="name"><a href="<c:url value="/super/site/js_css/index.do?cms_menu_seq=802"/>" class="">CSS/JS관리</a></span> --%>
<!-- 					</div> -->
<!-- 				</li> -->
				<li menu_seq="803" class="last">
					<div>
						<span class="name"><a href="/super/site/screen/index.do?site_id=${site_id}&cms_menu_seq=803" class="">메인 이미지 관리</a></span>
					</div>
				</li>
				<li menu_seq="803_1" class="last">
					<div>
						<span class="name"><a href="/super/site/popup/index.do?site_id=${site_id}&cms_menu_seq=803_1" class="">팝업관리</a></span>
					</div>
				</li>
				<li menu_seq="804" class="last">
					<div>
						<span class="name"><a href="<c:url value="/super/site/reserve/index.do?cms_menu_seq=804"/>" class="">예약업데이트 관리</a></span>
					</div>
				</li>
				<%-- <li menu_seq="805" class="last">
					<div>
						<span class="name"><a href="<c:url value="/super/site/analytics/index.do?cms_menu_seq=805"/>" class="">접속/페이지 통계</a></span>
					</div>
				</li> --%>
				<%-- <c:if test="${cms_member.group_seq eq '1' }">
				<li menu_seq="806" class="last">
					<div>
						<span class="name"><a href="<c:url value="/super/site/current_user/index.do?cms_menu_seq=806"/>" class="">실시간 접속자 현황</a></span>
					</div>
				</li>
				</c:if> --%>
			</ul>
		</div>
	</div>
</div>