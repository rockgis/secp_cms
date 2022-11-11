<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>
<c:set var="site_id" value="${empty cookie.adh_menu_current_siteid ? '1' : cookie.adh_menu_current_siteid.value }"/>
<style type="text/css">
<!--
li.line_bottom{
	border-bottom:1px solid #2196f3 !important;
}
/* ul.temp_ul{ */
/* 	border-bottom: 2px solid #1c222d; */
/* 	z-index:9999; */
/* 	position: relative; */
/* } */

.mCS-my-theme .mCSB_container{ margin-right:9px;  }
.mCS-my-theme.mCSB_scrollTools{ margin-right: -3px  }
.mCS-my-theme.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar{ background-color: white; width: 5px;}
.mCS-my-theme.mCSB_scrollTools .mCSB_draggerRail{ background-color: #161c28; } 
-->
</style>
<script type="text/javascript">
var myleft;
$(function() {
	myleft = new media.system.homepage.left();
});
(function(_media, $, undfined){

	if(!_media.system){
		_media.system = {};
	}

	if(!_media.system.homepage){
		_media.system.homepage = {};
	}
	
	function authorization(){
		var my_manage_page = ${my_manage_page };
		var my_permission_page = ${my_permission_page };
		var my_menu_view = $.unique(my_manage_page.concat(my_permission_page));
		$.each(my_menu_view, function(i, menu_seq){
			$(".menu_box li[menu_seq='"+menu_seq+"']").attr({"my_menu_view":'Y', "only_view":"N"}).parents(".menu_box li").attr({"my_menu_view":'Y', "only_view":"Y"});
			$(".menu_box li[menu_seq='"+menu_seq+"']").find("li").attr({"my_menu_view":'Y', "only_view":"N"});
		});
		$(".menu_box li:not([my_menu_view])").remove();
		
		$(".menu_box li[only_view=N]").each(function(i, o){
			if($.inArray(Number($(this).attr("menu_seq")), my_permission_page)>-1){//설정권한있으면 설정화면
				return true;	
			}else if($.inArray($(this).attr("menu_type"), ["4", "5"])>-1){//내용없는 타입
				$(">div>span:first>a", this).prop("href", "javascript:alert('컨텐츠 내용이 없는 페이지 입니다.');");
				return true;
			}else if($(this).attr("menu_type") == "2"){
				$(">div>span:first>a", this).prop("href", "${context_path }/super/homepage/bbs/index.do?cms_menu_seq="+$(this).attr("menu_seq")+"&parent_menu_seq="+$(this).attr("parent_menu_seq")+"&menu_level="+$(this).attr("menu_level"));
			}else if($(this).attr("menu_type") == "3" && !!$(this).attr("manage_url")){
				$(">div>span:first>a", this).prop("href", "${context_path }"+$(this).attr("manage_url")+"?cms_menu_seq="+$(this).attr("menu_seq")+"&parent_menu_seq="+$(this).attr("parent_menu_seq")+"&menu_level="+$(this).attr("menu_level"));
			}else{//컨텐츠 변경페이지
				$(">div>span:first>a", this).prop("href", "${context_path }/super/homepage/contentFrm.do?cms_menu_seq="+$(this).attr("menu_seq")+"&parent_menu_seq="+$(this).attr("parent_menu_seq")+"&menu_level="+$(this).attr("menu_level"));
			}
		});
		
		$(".menu_scroll a").not(".favorite").on("click", function(e){
			if($(this).closest("li").attr("only_view") == "Y"){
				alert("수정권한이 없습니다.");
				return false;
			}
		});
	}
	//왼쪽 메뉴 html 생성 
	function makeLeft(){
		getSyncJSON('<c:url value="/super/homepage/left_list.do"/>', {site_id : "${site_id}"}, function(data){
			for (var i = 0; i < data.length; i++) {
				var item = data[i];
				var menu = makeTree(item);

				var sb = ".menu_scroll";
				for (var j = 1; j < item.menu_level; j++) {
					sb += ">ul>li";
				}
				var o = $(sb).last();
				
				if(o.children("ul").size()==0)
					o.append("<ul>");
				o.children("ul").append(menu);
			}
			$(".menu_scroll").find("li[del_yn='Y']").remove();
			$(".menu_scroll").find("li[use_yn='N']").find("span.name>a").css("text-decoration", "line-through");
			$(".menu_scroll ul").each(function(i, o){//ul에 자식이 없으면 ul태그 삭제
				if($("li", this).size()==0){
					$(this).remove();
				}
			});
			//상단메뉴없는건 구분을 주고자 색으로 표시
			$("li[top_yn='N'],li[top_yn='N'] li").addClass("type_2");
		});
	}
	function makeTree(item){
		var html = "";
		html += "	<li menu_seq='"+item.cms_menu_seq+"' parent_menu_seq='"+item.parent_menu_seq+"' menu_type='"+item.menu_type+"' manage_url='"+item.manage_url+"' menu_level='"+item.menu_level+"' child_type='"+item.child_type+"' top_yn='"+item.top_yn+"' del_yn='"+item.del_yn+"' use_yn='"+item.use_yn+"' class='off'>";
		html += "		<div>";
		html += "			<span class='name'><a href=\"<c:url value="/super/homepage/modifyFrm.do"/>?cms_menu_seq="+item.cms_menu_seq+"&parent_menu_seq="+item.parent_menu_seq+"&menu_level="+item.menu_level+"&permit=Y\" class='off'>" + item.title + "</a></span>";
		<c:if test="${suf:inArray(fn:split('1,2', ','), sessionScope.cms_member.group_seq)}">
			html += "		<span class='nameplus booker out' menu_seq='"+item.cms_menu_seq+"'>";
			if(item.menu_level != "1"){
				html += "		<a href='#' class='off favorite'>즐겨찾기</a>";
			}
			html += "			<a href='javascript:myleft.addchild("+JSON.stringify(item)+")'>하위메뉴추가</a>";
			html += "		</span>";
		</c:if>
		<c:if test="${!suf:inArray(fn:split('1,2', ','), sessionScope.cms_member.group_seq)}">
			if(item.menu_level != "1"){
				html += "	<span class='nameplus booker out' menu_seq='"+item.cms_menu_seq+"'>";
				html += "		<a href='#' class='off favorite'>즐겨찾기</a>";
				html += "	</span>";
			}
		</c:if>
		html += "		</div>";
		html += "	</li>";
		return html;
	}

	//하위 메뉴 추가
	function addchild(item){
		<c:if test="${!suf:inArray(fn:split('1,2', ','), sessionScope.cms_member.group_seq)}">
		alert("메뉴 생성 권한이 없습니다.\n새로운 메뉴를 생성하시려면 생성권한이 있는 관리자에게 문의하여 주시기 바랍니다.");
		return;
		</c:if>
		
		if(item.menu_level > 4){
			var child_type = $(".menu_scroll li[menu_seq='"+item.cms_menu_seq+"']").attr("child_type");
			if(child_type == "2"){
				if(item.menu_level > 5){
					alert("더이상 하위 메뉴를 추가 하실수 없습니다.");
					return;
				}
			}else{
				alert("더이상 하위 메뉴를 추가 하실수 없습니다.");
				return;
			}
		}
		var parent_child_type = $(".menu_scroll li[menu_seq='"+item.parent_menu_seq+"']").attr("child_type");
		if(parent_child_type == "2"){
			alert("하위메뉴구조가 탭구조인경우 더이상 메뉴를 추가하실수 없습니다.");
			return;
		}
		location.href="<c:url value="/super/homepage/writeFrm.do"/>?parent_menu_seq="+item.cms_menu_seq;
	}

	//메뉴 이동
	function menumove(){
		var clone, idx;
		$(".menu_scroll:eq(0) li").draggable({
			distance: 25,
			revert: "invalid",
			start : function(e, ui){
				clone = $(e.target).closest("ul");
				idx = clone.children("li").index(this);
				$(this).addClass("selected");
			},
			helper: function(e) {
				var set = $('<span>'+$(">div>span:first", this).text()+'</span>')
				.css({
					cursor:'pointer', display:'block', padding:'3px 5px', 'background-color':'#ffc107', 'z-ndex':999, 'color':'#000', 'border-radius':'2px'
				});
				return set;
			},
			stop : function(e, ui){
				$(this).removeClass("selected");
			},
			cursorAt: {left: 25, top: 10}
		});
		
		$(".menu_scroll:eq(0) li, .menu_scroll:eq(0) li>div>span.name").droppable({
			greedy: true,
			over : function(e, ui){
				if($(e.target).get(0).tagName=="LI"){
					$(e.target).addClass("line_bottom");
				}else{
					if($(e.target).closest("li").has("ul").size()==0){
						$(e.target).closest("li").append("<ul class='temp_ul'></ul>");
					}
					$(e.target).closest("div").addClass("on2");
				}
			},
			out : function(e, ui){
				if($(e.target).get(0).tagName=="LI"){
					$(e.target).removeClass("line_bottom");
				}else{
					$(e.target).closest("li").removeClass("line_bottom");
				}
				$("ul.temp_ul").remove();
				$(".menu_scroll:eq(0) div").removeClass("on2");
			},
			drop: function(e, ui) {
				$(ui.helper).hide();
				if($(e.target).get(0).tagName=="LI"){
					$(e.target).after(ui.draggable);
				}else{
					$(e.target).closest("li").children("ul").append(ui.draggable);
				}
				
				if(confirm('메뉴를 이동시키시겠습니까?')){
					var dataset = $.map($(".menu_scroll:eq(0) ul>li"),function(item){
						return {
							menu_order : $(item).closest("ul").children("ul>li").index(item)
							, cms_menu_seq : $(item).attr("menu_seq")
							, parent_menu_seq : $(item).closest("ul").closest("li").attr("menu_seq")||"${site_id}"
						};
					});
					getJSON("<c:url value="/super/homepage/menu_move.do"/>", {jData : JSON.stringify({list : dataset})}, function(data){
						if(data.rst == '1'){
							location.reload();
			  			}
					});
				}else{
					if(clone.children("li:eq("+idx+")").size()==0){
						clone.append(ui.draggable);
					}else{
						clone.children("li:eq("+idx+")").before(ui.draggable);
					}
					$("ul.temp_ul").remove();
				}
				$(".menu_scroll:eq(0) li").removeClass("line_bottom");
				$(".menu_scroll:eq(0) div").removeClass("on2");
			}
		});
	}

	//메뉴토글
	function allMenuToggle(){
		
		$(".bt_toggle").on("click", function(){
			if($(this).hasClass("close")){
				$(this).removeClass("close");
				$(this).addClass("open");
				$(this).find("span").text("모든메뉴닫기");
				openMenu();
			}else{
				$(this).removeClass("open");
				$(this).addClass("close");
				$(this).find("span").text("모든메뉴열기");
				closeMenu();
			}
		});
		
		if($(".menu_scroll ul li").find("ul:hidden").size()==0){
			$(".bt_toggle").trigger("click");
		}
	}
	//메뉴열기
	function openMenu(){
		$(".menu_scroll>ul>li ul").show(menuSave);
	}
	//메뉴닫기
	function closeMenu(){
		$(".menu_scroll>ul>li ul").hide(menuSave);
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
		
		var toggle_info = localStorage.getItem("adh_menu_${sessionScope.cms_member.member_id}_${site_id}");
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
		makeTitle();
	}
	//타이틀 생성
	function makeTitle(){
		$(".titlebar>div").prepend("<span>메뉴관리</span>");
		$($(".menu_scroll>ul li.active>div>span.name").get().reverse()).each(function(i, o){
			$(".titlebar>div>span").first().after("><span>"+$(this).text()+"</span>");
		});
		$(".titlebar>div>span").last().addClass("bar_tx");
	}
	//메뉴 열고닫은 정보를 다음페이지에서도 유지하기 위해 사용
	function menuSave(){
		var rst = [];
		$(".menu_scroll>ul>li ul").filter(":hidden").each(function(i, o){
			rst.push($(o).closest("li").attr("menu_seq"));
		});
		localStorage.setItem("adh_menu_${sessionScope.cms_member.member_id}_${site_id}", rst.join(","));
	}
	//스크롤
	function scrollable(){
		$(window).scrollTop(0);
		var menu_box_top = $(".menu_box").offset().top;
		var initTop = localStorage.getItem("adh_scroll")==null ? 0 : localStorage.getItem("adh_scroll");
		var height = $(window).height() - menu_box_top;
		$(".menu_box").height(height).mCustomScrollbar({
			axis:"y",
			theme : "my-theme",
			scrollbarPosition:"inside",
			setTop:initTop-1+"px",
			callbacks : {
				onScroll : function(){
					localStorage.setItem("adh_scroll", this.mcs.top);
				},
				whileScrolling:function(){
					localStorage.setItem("adh_scroll", this.mcs.top);
				}
			}
		});
	}

	
	_media.system.homepage.left = function(){
		makeLeft();
		menuInit();
		menumove();
		scrollable();
		<c:if test="${!suf:inArray(fn:split('1,2', ','), sessionScope.cms_member.group_seq)}">
		authorization();
		</c:if>
		allMenuToggle();
		$(".menu_scroll>ul>li div").on("click", toggleMenu);
		
		//페이지 이동시 클릭이벤트 버블링 해제
		$(".menu_scroll a").on("click", function(e){
			e.stopPropagation();
		});
		
		$("#menu_search").on("keyup", function(){
			var text = $(this).val();
			if(!text){
				$(".menu_scroll>ul li").show();
			}else{
				$(".menu_scroll>ul li").hide();
				$(".menu_scroll>ul li a:contains('"+text+"')").show().parents(".menu_scroll>ul li").show();
			}
		});
		
		$(window).on("resize", function(){
			scrollable();
		});
			
		return {
			authorization : authorization,
			makeLeft : makeLeft,
			makeTree : makeTree,
			addchild : addchild,
			menumove : menumove,
			allMenuToggle : allMenuToggle,
			openMenu : openMenu,
			closeMenu : closeMenu,
			menuInit : menuInit,
			makeTitle : makeTitle,
			menuSave : menuSave,
			scrollable : scrollable,
		}
	};
	
	window.media = _media;

}(window.media || {}, jQuery));

//메뉴관리에서만  btn_bottom이 긴 스크롤에 fixed로 뜨도록 함
$(document).ready(function(){
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
});

</script>
<div class="menuwrap">
	<div class="menu_top">
		<p class="bt_toggle new close"><span>모든메뉴열기</span></p>
		<p class="bt_add new" onclick="location.href='<c:url value="/super/homepage/writeFrm.do"/>?parent_menu_seq=${site_id }&menu_level=1';"><span>대메뉴생성</span></p>
	</div>
	<div class="menu_sch">
		<input type="text" id="menu_search" placeholder="메뉴검색"/>
	</div>
	<div class="menu_box">
		<div class="menu_scroll">
		</div>
	</div>
</div>
