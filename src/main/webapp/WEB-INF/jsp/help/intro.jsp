<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<c:set var="site_id" value="${empty param.site_id ? '1' : param.site_id }"/>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>도움말</title>
<link rel="stylesheet" href="/lib/css/common.css" type="text/css" />
<link rel="stylesheet" href="/lib/css/sub.css" type="text/css" />
<script type="text/javascript" src="<c:url value="/lib/js/jquery-3.5.1.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery-migrate-1.4.1.min.js"/>"></script>
<script type="text/javascript" src="/lib/js/jquery.lck.util.js"></script>
<script type="text/javascript" src="/lib/js/jquery.form.js"></script>
<script type="text/javascript">
function addHilight(str, list){
	if(str==undefined || list.length==0){
		return str;	
	}
	
	$.each(list, function(i, o){
		str = str.replace(o, '<b>$&</b>')
	})
	return str;
}
$(function(){
	var hilight_list = [];
	
	$('.help_wrap .left_cont ul li.has_sub_2 > span.arrow_2').on('click', function(){
		$(this).next().next('ul').slideToggle('fast');
		$(this).parent().toggleClass('open');
	});
	
	$('.help_wrap .left_cont .title h5:first a').on('click', function(){
		$(this).parent().addClass('on');
		$('.help_wrap .left_cont .title h5:last a').parent().removeClass('on')
		$('.search').css("display","none");
		$('.table_of_contents').css("display","block");
	});
	$('.help_wrap .left_cont .title h5:last a').on('click', function(){
		$(this).parent().addClass('on')
		$('.help_wrap .left_cont .title h5:first a').parent().removeClass('on')
		$('.search').css("display","block");
		$('.table_of_contents').css("display","none");
	});
	
	$('#searchFrm').ajaxForm({
		url : "/help/search.do",
		data : {
			site_id : '${site_id}',
			keyword : $("#keyword").val()
		},
		dataType : "json",
		success : function(data){
			hilight_list = data.hilight_list;
			$("#search_list").empty();
			$.each(data.list, function(i, o){
				$("#search_list").append("<li><a href='#' class='a_link' menu_seq='"+o.cms_menu_seq+"' site_id='"+o.site_id+"'>"+addHilight(o.title, hilight_list)+"</a></li>");
			})
		}
	});
	
	$(document).on("click", ".left_boundary a.a_link", function(e){
		e.preventDefault();
		e.stopPropagation();
		var menu_seq = $(this).attr("menu_seq");
		$.ajax({
			type : "GET",
			url : "/help/contents.do",
			async: false,
			data : {
				site_id : $(this).attr("site_id"),
				cms_menu_seq : menu_seq
			},
			dataType : "json",
			success : function(data){
				$(".help_contents").empty().html(addHilight(data.contents.help_cont, hilight_list));
				$.each(data.navi.page_navi.split(">"), function(i, o){
					if(i==0){
						$(".help_state ul").empty();
						$(".help_state ul").append("<li><strong>RUCOS</strong></li>");
					}else{
						$(".help_state ul").append("<li><span>></span>"+o+"</li>");
					}
				});
			},
			complete : function(){
				$(".left_boundary li").removeClass("on");
				$(".a_link[menu_seq='"+menu_seq+"']").parents(".left_boundary li").addClass("on");
			}
		});	
	});
	<c:if test="${!empty param.cms_menu_seq}">
	$(".left_boundary a.a_link[menu_seq='${param.cms_menu_seq}']").trigger("click");
	</c:if>
});
</script>
</head>
<body>
<div class="wrap">

					<!-- contents -->
						<div class="help_wrap">
							<div class="left_cont">
								<div class="title">
									<h5 class="on"><a href="#">목차</a></h5>
									<h5><a href="#">검색</a></h5>
								</div>
								<div class="table_of_contents left_boundary">
									<c:out value="${leftmenu }" escapeXml="false"/>
								</div>
								<div class="search" style="display:none;">
									<div class="search_box">
										<form id="searchFrm" method="post">
										<span style="margin-bottom:10px;">
											<input type="text" id="keyword" name="keyword" placeholder="찾을 키워드를 입력해주세요"> 
										</span>
										<span style="display:inline-block; text-align:right;">
											<a href="javascript:$('#searchFrm').submit();">검색</a>
										</span>
										</form>
									</div>
									<ul id="search_list" class="left_boundary">
									</ul>
								</div>
							</div>
							<div class="right_cont">
								<div class="cont">
									<div class="help_state">
										<ul>										
											<li><strong>RUCOS</strong></li>	
										</ul>
									</div>
									<div class="help_contents">
									<!-- contents -->
									<!-- //contents -->
								</div>
								</div>
							</div>
						</div>
					
					<!-- //contents -->
					</div>
</body>
</html>