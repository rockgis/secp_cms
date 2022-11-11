<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
// 	get_favorites();
	
	//페이지 이동시 클릭이벤트 버블링 해제
	$(".menu_scroll a").on("click", function(e){
		e.stopPropagation();
	});
	
	$(window).on("resize", function(){
		scrollable();
	});
});
// function get_favorites(){
// 	var data = localStorage.getItem("favorites_${sessionScope.cms_member.member_id}");
// 	if(data != null){
// 		$.each($.parseJSON(data).list, function(i, o){
// 			$(".bookmark>ul").append("<li><a href='"+o.url+"'>"+o.title+"</a></li>");
// 			$(".booker[menu_seq='"+o.menu_seq+"']>a").swapClass("on", "off");
// 		});
// 	}
// }

//메뉴열기
function openMenu(){
	$(".menu_scroll>ul>li>ul li").show(menuSave);
}
//메뉴닫기
function closeMenu(){
	$(".menu_scroll>ul>li>ul li").hide(menuSave);
}
//메뉴토글
function toggleMenu(){
	if($(this).siblings("ul").has("li").size()>0){
		$(this).siblings("ul").slideToggle(menuSave);
		$(">span:eq(0)>a", this).swapClass("on", "off")
		$(this).closest("li").swapClass("on", "off")
	}
}
//페이지 열리면 열고 닫은 정보 불러오기
function menuInit(){
	$(".menu_scroll li").filter(function(){
		return $(this).has("li").size()==0;
	}).addClass("last");

	var toggle_info = localStorage.getItem("ads_menu_${sessionScope.cms_member.member_id}");
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
	$(".menu_scroll ul").filter(":hidden").each(function(i, o){
		rst.push($(o).closest("li").attr("menu_seq"));
	});
	localStorage.setItem("ads_menu_${sessionScope.cms_member.member_id}", rst.join(","));
}
//스크롤
function scrollable(){
	$(window).scrollTop(0);
	var menu_box_top = $(".menu_box").offset().top;
	var initTop = localStorage.getItem("ads_scroll")==null ? 0 : localStorage.getItem("ads_scroll");
	var height = $(window).height() - menu_box_top;
	$(".menu_box").height(height).mCustomScrollbar({
		axis:"y",
		theme : "my-theme",
		scrollbarPosition:"inside",
		setTop:initTop-1+"px",
		callbacks : {
			onScroll : function(){
				localStorage.setItem("ads_scroll", this.mcs.top);
			},
			whileScrolling:function(){
				localStorage.setItem("ads_scroll", this.mcs.top);
			}
		}
	});
}
</script>

<div class="menuwrap">
	<div class="menu_top">
		<!-- <p class="bt_open">메뉴펼치기/닫기</p>
		<p class="bt_re">메뉴펼치기/닫기</p> -->
		<!-- <p class="bt_none"></p> -->
	</div>
	<div class="menu_box">
		<div class="menu_scroll system_left">
			<ul>
				<li menu_seq="900">
					<div>
						<span class="name "><a href="<c:url value="/super/system/member/index.do?cms_menu_seq=901"/>" class="">회원관리</a></span>
					</div>
					<ul>
						<li menu_seq="901">
							<div>
								<span class="name system_01_1"><a href="<c:url value="/super/system/member/index.do?cms_menu_seq=901"/>" class="">관리자 회원 관리</a></span>
							</div>
						</li>
						<li menu_seq="902">
							<div>
								<span class="name system_15"><a href="<c:url value="/super/system/tracking/index.do?cms_menu_seq=902"/>">관리자 트래킹</a></span>
							</div>
						</li>
						<li menu_seq="903">
							<div>
								<span class="name system_01"><a href="<c:url value="/super/system/member_user/index.do?cms_menu_seq=903"/>" class="">일반회원 및 그룹 관리</a></span>
							</div>
						</li>
						<li menu_seq="904">
							<div>
								<span class="name system_19"><a href="<c:url value="/super/system/current_user/index.do?cms_menu_seq=904"/>">실시간 접속자 현황</a></span>
							</div>
						</li>
					</ul>
				</li>
				<li menu_seq="910">
					<div>
						<span class="name "><a href="<c:url value="/super/system/satisfaction/index.do?cms_menu_seq=911"/>" class="">접속/통계</a></span>
					</div>
					<ul>
						<li menu_seq="911">
							<div>
								<span class="name system_10"><a href="<c:url value="/super/system/satisfaction/index.do?cms_menu_seq=911"/>">페이지 만족도</a></span>
							</div>
						</li>
						<li menu_seq="912">
							<div>
								<span class="name system_14"><a href="<c:url value="/super/system/analytics/index.do?cms_menu_seq=912"/>">접속/페이지 통계</a></span>
							</div>
						</li>
					</ul>
				</li>
				
				<li menu_seq="930">
					<div>
						<span class="name "><a href="<c:url value="/super/system/ipcheck/index.do?cms_menu_seq=931"/>" class="">보안 설정</a></span>
					</div>
					<ul>
						<li menu_seq="931">
							<div>
								<span class="name system_05"><a href="<c:url value="/super/system/ipcheck/index.do?cms_menu_seq=931"/>">시스템 접근 IP 관리</a></span>
							</div>
						</li>
						<li menu_seq="933">
							<div>
								<span class="name system_23"><a href="<c:url value="/super/system/basic_setting/index.do?cms_menu_seq=933"/>">보안 설정</a></span>
							</div>
						</li>				
					</ul>
				</li>
				<li menu_seq="940">
					<div>
						<span class="name "><a href="<c:url value="/super/system/board/index.do?cms_menu_seq=941"/>" class="">시스템 설정 및 관리</a></span>
					</div>
					<ul>
						<li menu_seq="941">
							<div>
								<span class="name system_02"><a href="<c:url value="/super/system/board/index.do?cms_menu_seq=941"/>" >게시판 설정 및 관리</a></span>
							</div>
						</li>
						<li menu_seq="942">
							<div>
								<span class="name system_03"><a href="<c:url value="/super/system/code/index.do?cms_menu_seq=942"/>">공통코드 관리</a></span>
							</div>
						</li>
						<li menu_seq="943">
							<div>
								<span class="name system_04"><a href="<c:url value="/super/system/program/index.do?cms_menu_seq=943"/>">프로그램 관리</a></span>
							</div>
						</li>
						<li menu_seq="946">
							<div>
								<span class="name system_20"><a href="<c:url value="/super/system/style_guide/index.do?cms_menu_seq=946"/>">CMS 스타일 가이드</a></span>
							</div>
						</li>
						<li menu_seq="947">
							<div>
								<span class="name system_21"><a href="<c:url value="/super/system/filemanager/index.do?cms_menu_seq=947"/>">홈페이지 소스 관리</a></span>
							</div>
						</li>
						<li menu_seq="949">
							<div>
								<span class="name system_23"><a href="<c:url value="/super/system/cache/index.do?cms_menu_seq=949"/>">캐시 데이터 삭제</a></span>
							</div>
						</li>
					</ul>
				</li>
				<li menu_seq="920">
					<div>
						<span class="name "><a href="<c:url value="/super/system/wsi/EgovWebStandardInspection.do?cms_menu_seq=921"/>" class="">기타 설정</a></span>
					</div>
					<ul>
						<li menu_seq="922">
							<div>
								<span class="name system_09"><a href="<c:url value="/super/system/holiday/index.do?cms_menu_seq=922"/>">공휴일 설정 및 관리</a></span>
							</div>
						</li>
						<li menu_seq="923">
							<div>
								<span class="name system_06"><a href="<c:url value="/super/system/reserve/index.do?cms_menu_seq=923"/>">예약업데이트 관리</a></span>
							</div>
						</li>
					</ul>
				</li>
				<li menu_seq="950" class="last">
					<div>
						<span class="name system_21"><a href="<c:url value="/super/system/system_info/index.do?cms_menu_seq=950"/>">시스템정보</a></span>
					</div>
				</li>
			</ul>
		</div>
	</div>
</div>