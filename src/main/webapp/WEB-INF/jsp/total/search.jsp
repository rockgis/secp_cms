<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="rgx" uri="/WEB-INF/tlds/RegexUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Cache-control" content="no-cache">
<title>통합검색</title>
<link href="/lib/css/jquery.datetimepicker.css" rel="stylesheet" type="text/css">
<style>
	.ui-widget.ui-widget-content{padding:12px 0; border:1px solid #ccc;}
	.ui-menu .ui-menu-item{}
	.ui-menu .ui-menu-item-wrapper{padding:8px 20px; font-size:15px;}
	.ui-menu .ui-menu-item-wrapper b{color:#536ea6 !important; font-family:'NanumBarunGothicB'; font-weight:normal;}
	.ui-menu .ui-menu-item-wrapper.ui-state-active{margin:0; background:#f5f5f5; border:none; color:#666;}
	.xdsoft_datetimepicker{padding:0; border:1px solid #ccc; box-shadow:0 0 0 0;}
	.xdsoft_datetimepicker .xdsoft_datepicker{margin-left:0; width:268px;}
	.xdsoft_datetimepicker .xdsoft_month{text-align:right; padding:10px 10px 10px 0; width:calc(50% - 54px); height:42px; font-size:13px; font-family:'NanumBarunGothic'; font-weight:normal; box-sizing:border-box;}
	.xdsoft_datetimepicker .xdsoft_label > .xdsoft_select.xdsoft_monthselect{top:34px; left:-1px; width:100%; box-sizing:border-box;}
	.xdsoft_datetimepicker .xdsoft_year{text-align:left; padding:10px 0 10px 10px; margin-left:0; width:calc(50% - 56px); height:42px; font-size:13px; font-family:'NanumBarunGothic'; font-weight:normal; box-sizing: border-box;}
	.xdsoft_datetimepicker .xdsoft_label > .xdsoft_select.xdsoft_yearselect{top:34px; left:1px; width:100%; box-sizing:border-box;}
	.xdsoft_datetimepicker .xdsoft_label > .xdsoft_select > div > .xdsoft_option.xdsoft_current{font-weight:normal; box-shadow:none;}
	.xdsoft_datetimepicker .xdsoft_today_button{margin-left:0; width:26px; height:42px; background-position:-67px 5px; border-right:1px solid #ccc !important; opacity:1;}
	.xdsoft_datetimepicker .xdsoft_prev{width:42px; height:42px; background:url(/images/total/calendar_prev.png) no-repeat center; border-right:1px solid #ccc !important; opacity:1;}
	.xdsoft_datetimepicker .xdsoft_next{transform:rotate(180deg); width:42px; height:42px; background:url(/images/total/calendar_prev.png) no-repeat center; border-right:1px solid #ccc !important; opacity:1;}
	.xdsoft_datetimepicker .xdsoft_label i{margin-left:6px;}
	.xdsoft_datetimepicker .xdsoft_calendar{border-top:1px solid #ccc;}
	.xdsoft_datetimepicker .xdsoft_calendar tbody::before{content:''; display:block; height:10px;}
	.xdsoft_datetimepicker .xdsoft_calendar tbody::after{content:''; display:block; height:10px;}
	.xdsoft_datetimepicker .xdsoft_calendar th{text-align:center; padding:10px 0; width:auto; background:#f5f5f5; border:none; color:#666; font-weight:normal;}
	.xdsoft_datetimepicker .xdsoft_calendar td{text-align:center; padding:8px 0; width:auto; background:#fff; border:none;}
	.xdsoft_datetimepicker .xdsoft_calendar td.xdsoft_current{background:#676b73; box-shadow:none;}
	.xdsoft_datetimepicker .xdsoft_calendar td:hover{position:relative; background:none !important; color:#666 !important;}
	.xdsoft_datetimepicker .xdsoft_calendar td:hover::before{content:''; position:absolute; top:0; bottom:0; left:0; right:0; border:1px solid #676b73;}
	.xdsoft_datetimepicker .xdsoft_calendar td > div{padding-right:0;}
</style>
<script type="text/javascript" src="/lib/js/jquery.datetimepicker.js"></script>
<script type="text/javascript">
(function(_media, dd, undfined){

	if(!_media.search){
		_media.search = {};
	}
	
	function rank(tab){
		$.getJSON("/total/rank.do", {gubun:tab}, function(data){
			$("#rank_list").empty();
			$.each(data.list, function(i, o){
				$("#rank_list").append('<li class="rank'+(("00" + (i+1)).slice(-2))+'"><a href="search.do?total_keyword='+encodeURIComponent(o.label)+'">'+o.label+'</a></li>');
			});
		})
	}
	
	function popup_link(siteName, qeury){
		var url = "";
		var qry = qeury;
		if(siteName == "naver"){
			url = "http://search.naver.com/search.naver?sm=tab_hty&where=nexearch&query="+qry;
		} else if(siteName == "google"){
			url = "http://www.google.co.kr/search?sclient=psy-ab&q="+qry;
		} else if(siteName == "daum"){
			url = "http://search.daum.net/search?w=tot&DA=YZRR&t__nil_searchbox=btn&sug=&q="+qry;
		}
		
		var pop = window.open(url);
		if(pop != null) {
			pop.focus();
		}
	}
	function sortSearch(tp){
		$("#sort").val(tp);
		$("#innerSearchFrm").submit();
	}
	function termSearch(tp){
		if(tp == "5"){
			var start_dt = $("#startdt").val();
			var end_dt = $("#enddt").val();
			$("#start_dt").val(start_dt);
			$("#end_dt").val(end_dt);
		}
		$("#term").val(tp);
		$("#innerSearchFrm").submit();
	}
	function fieldSearch(fields){
		$("#fields").val(fields);
		$("#innerSearchFrm").submit();
	}
	function initSearch(){
		$("#sort").val('');
		$("#term").val('');
		$("#start_dt").val('');
		$("#end_dt").val('');
		$(".ts_detail_sch li").not(":first").remove();
		$(".ts_detail_sch").find(".item").find("select,input:text").val('');
		
		$(".sort_text").text("정렬").removeClass("active");
		$(".term_text").text("기간").removeClass("active");
		$(".fields_text").text("영역").removeClass("active");
		$(".detail_text").text("상세검색").removeClass("active");
		$("#search_gubun").val("");
	}
	function search(gubun){
		$("#search_gubun").val(gubun);
		var list = [];
		var k,v;
		$(".ts_detail_sch li").each(function(i, o){
			k = $(this).find("[name='in_operator']>option:selected").val();
			v = $(this).find("[name='in_keyword']").val();
			if(!!k && !!v){
				list.push({operator : k, keyword : v});
			}
		});
		$("#jData").val(JSON.stringify(list));
		$("#innerSearchFrm").submit();
	}
	function remove(idx){
		$("#inKeywordDiv").find(".item").eq(idx).remove();
		if(idx==0){
			$(".ts_detail_sch").find(".item").eq(idx).find("select,input:text").val('');
		}else{
			$(".ts_detail_sch").find(".item").eq(idx).remove();
		}
	}
	
	
	_media.search = {
		rank : rank,
		popup_link : popup_link,
		sortSearch : sortSearch,
		termSearch : termSearch,
		fieldSearch : fieldSearch,
		initSearch : initSearch,
		search : search,
		remove : remove
	};
	
	window.media = _media;
}(window.media || {}, jQuery));

$(function(){
	//내가찾은 검색어
	var ck = $.cookie("searchkeyword").split(";");
	var _ul = $(".sch_rank");

	for (var i = 0; i < ((ck.length-1)>=10?10:(ck.length-1)); i++) {
		var o = ck[i];
		_ul.append('<li><span><a href="search.do?total_keyword='+o+'">'+o+'</a></span><a href="javascript:void(0)" class="keyword_del" title="검색어 삭제" cookie='+o+'><img src="/images/total/close.gif" alt="삭제" /></a></li>');
	}
	$("li:first", _ul).addClass("sch_first");
	
	$(".sch_rank>li>a").on("click", function(){
		var item = $(this).attr("cookie");
		var ck = $.cookie("searchkeyword");
		ck = ck.replace(item.concat(";"), "");
		$.cookie("searchkeyword", ck, {path:"/", domain:document.domain, expires: 15 });
		$(this).closest("li").remove();
	});
	
	//인기검색어
	$("#rank_ul>li>a").on("click", function(){
		$(this).closest("ul").find("li").removeClass("on");
		$(this).parent().addClass("on");
		rank($(this).attr("tab"));
	});
	media.search.rank("month");
	
	$("#total_keyword").autocomplete({
		search: function(event, ui) {
			var _this = this;
			setTimeout(function(){
				var w = $(_this).autocomplete("widget").find("li");
				var re = new RegExp("("+_this.value+")", "i");
				$.each(w, function(i, o){
					$(o).html($(o).html().replace(re, "<b style='color:red;'>$1</b>"));
				});
			}, 100);
		},
        source : function( request, response ) {
             $.ajax({
                    type: 'post',
                    url: "/total/autocomplete.do",
                    dataType: "json",
                    //request.term = $("#autocomplete").val()
                    data: { prefix : request.term },
                    success: function(data) {
                        //서버에서 json 데이터 response 후 목록에 뿌려주기 위함
                        response(data);
                    }
               });
            },
        //조회를 위한 최소글자수
        minLength: 2,
        select: function( event, ui ) {
            // 만약 검색리스트에서 선택하였을때 선택한 데이터에 의한 이벤트발생
        },
        focus: function(event, ui){ return false;} 
    });
	var _onkeyword = false;
	$(".keyword").on("mouseenter", function(){
		_onkeyword = true;
	})
	$(".keyword").on("mouseleave", function(){
		_onkeyword = false;
	})
	$("#total_keyword").on("focusin", function(){
		$(".keyword").show();
	});
	$("#total_keyword").on("focusout", function(){
		if(!_onkeyword){
			$(".keyword").hide();
		}
	});
	$("#total_keyword").on("keyup", function(){
		if($(this).val().length>=2){
			$(".keyword").hide();
		}
	});
	
	//검색옵션
	$('.ts_option .left > ul > li > p').on('click', function(){
		//$(this).toggleClass('active');
		$(this).next('div').slideToggle();
		//옵션명 클릭시 리스트 오픈
	});
	
	$('.option_list > ul > li').on('click', function(e){
		e = $(this).text();
		$(this).closest('div').prev('p').text(e);
		$(this).closest('div').prev('p').addClass('active');
		$(this).siblings('li').removeClass('on');
		$(this).addClass('on');
		//옵션명을 리스트 중 클릭한 값으로 변경
	});
	
	$('.ts_period > ul > li').on('click', function(){
		$('.date_input').hide('slide', {direction: 'left'}, 500);
		$('.direct_input').removeClass('on');
		//기간 설정 리스트 클릭시 열려있는 '직접입력' 박스 닫힘
	});
	
	$('.direct_input').on('click', function(){
		$('.date_input').toggle('slide', {direction: 'left'}, 500);
		$(this).toggleClass('on');
		$('.ts_period > ul > li').removeClass('on');
		$('.ts_period').prev('p').text('기간');
		//기간 설정 '직접입력' 박스 토글
	});
	
	$('.date_input .close').on('click', function(){
		$('.date_input').hide('slide', {direction: 'left'}, 500);
		$('.direct_input').removeClass('on');
		//기간 설정 '직접입력' 박스 닫기 버튼
	});
	
	$("#startdt, #enddt").datetimepicker({
		format :'Y-m-d',
		timepicker : false
		//기간 설정 '직접입력' 박스에 달력 구동
	});
	
	$('.ts_detail_sch div a.close').on('click', function(){
		$('.ts_detail_sch').slideUp();
		$('.ts_detail_sch').prev('p').removeClass('active');
		//상세검색 설정 닫기 버튼
	});
		
	if($(window).width() <= 768){
		$('.ts_menu_wrap ul li.last span').on('click', function(){
			$('.ts_option').slideToggle();
		});
		//768 사이즈 옵션 토글 버튼
	};
	
	$(document).on("click", ".ts_detail_sch .add", function(){
		if($(".ts_detail_sch li:last").find("[name='in_operator']").val()==''){
			$(".ts_detail_sch li:last").find("[name='in_operator']").focus();
			alert("연산자를 선택하여주시기 바랍니다.");
			return;
		}
		if($(".ts_detail_sch li:last").find("[name='in_keyword']").val()==''){
			$(".ts_detail_sch li:last").find("[name='in_keyword']").focus();
			alert("검색어를 입력하여 주시기기 바랍니다.");
			return;
		}
		
		var _clone = $(this).closest("li.item").clone();
		_clone.find("[name='in_keyword']").val('');
		_clone.find(".add").attr({"class":"del", "value":"삭제"});
		$(".ts_detail_sch>ul").append(_clone);
	});
	
	$(document).on("click", ".ts_detail_sch .del", function(){
		$(this).closest("li.item").remove();
	});
})
</script>
</head>
<body>

<c:if test="${empty param.search_gubun }">
	<c:set var="dit_count" value="${dit_page_info.totalcount }" scope="session"/>
	<c:set var="mem_count" value="${mem_page_info.totalcount }" scope="session"/>
	<c:set var="web_count" value="${web_page_info.totalcount }" scope="session"/>
	<c:set var="bbs_count" value="${bbs_page_info.totalcount }" scope="session"/>
	<c:set var="img_count" value="${img_page_info.totalcount }" scope="session"/>
	<c:set var="doc_count" value="${doc_page_info.totalcount }" scope="session"/>
</c:if>

<c:set var="total_cnt" value="${dit_count + mem_count + web_count + bbs_count + img_count + doc_count}"/>

<div id="search_wrap">

	<!-- 상단 검색 영역 -->
	<div class="ts_bar">
		<div class="ts_bar_wrap">
			<form action="search.do" method="post" name="innerSearchFrm" id="innerSearchFrm">
<sec:csrfInput />
				<input type="hidden" name="term" id="term" value="${param.term }">
				<input type="hidden" name="sort" id="sort" value="${param.sort }">
				<input type="hidden" name="fields" id="fields" value="${param.fields }">
				<input type="hidden" name="start_dt" id="start_dt" value="${param.start_dt }">
				<input type="hidden" name="end_dt" id="end_dt" value="${param.end_dt }">
				<input type="hidden" name="jData" id="jData" value="">
				<div class="insert_area">
					<label for="total_keyword">통합검색</label>
					<div>
						<select name="search_gubun" id="search_gubun">
							<option value="">전체</option>
							<option value="dit" <c:if test="${param.search_gubun eq 'dit'}">selected="selected"</c:if>>메뉴</option>
							<option value="mem" <c:if test="${param.search_gubun eq 'mem'}">selected="selected"</c:if>>직원</option>
							<option value="web" <c:if test="${param.search_gubun eq 'web'}">selected="selected"</c:if>>웹페이지</option>
							<option value="bbs" <c:if test="${param.search_gubun eq 'bbs'}">selected="selected"</c:if>>게시판</option>
							<option value="doc" <c:if test="${param.search_gubun eq 'doc'}">selected="selected"</c:if>>파일</option>
							<option value="img" <c:if test="${param.search_gubun eq 'img'}">selected="selected"</c:if>>이미지</option>
						</select>
						<input type="text" title="통합검색창" id="total_keyword" name="total_keyword" value="<c:out value="${param.total_keyword }" escapeXml="true"/>"/>
						
						<!-- 검색창 focus에 나타나고 input에 입력되는 순간(length > 0) 사라져야함(클래스 부여만 가능해도 css로 처리 가능) -->
						<div class="keyword" style="display:none;">
							<p>내가 찾은 검색어</p>
							<!-- 클릭으로 해당 검색어 검색 가능 -->
							<ul class="sch_rank">
							</ul>
							<p>추천 검색어</p>
							<ol>
								<li><a href="">추천 검색어</a></li>
								<li><a href="">검색어</a></li>
								<li><a href="">추천 검색어</a></li>
							</ol>
						</div>
					</div>
					<input type="image" src="/images/total/sch_btn.png" />
				</div>
				<div id="inKeywordDiv">
					<c:if test="${fn:length(keywordList) > 0 }">
					<c:forEach var="item" items="${keywordList }" varStatus="status">
						<div class="item">
						<c:if test="${item.operator eq 'AND' }">그리고 </c:if>
						<c:if test="${item.operator eq 'OR' }">또는 </c:if>
						${item.keyword }
						<a href="javascript:media.search.remove(${status.index })">X</a>
						</div>
					</c:forEach>
					</c:if>
				</div>
			</form>
		</div>
	</div>
	
	<!-- 메뉴 영역 -->
	<div class="ts_menu">
		<div class="ts_menu_wrap">
			<ul>
				<li<c:if test="${empty param.search_gubun }"> class="select"</c:if>><a href="javascript:media.search.search('')">전체검색<span>(${total_cnt })</span></a></li>
				<li<c:if test="${param.search_gubun eq 'dit' }"> class="select"</c:if>><a href="javascript:media.search.search('dit')">메뉴<span>(${dit_count })</span></a></li>
				<li<c:if test="${param.search_gubun eq 'mem' }"> class="select"</c:if>><a href="javascript:media.search.search('mem')">직원<span>(${mem_count })</span></a></li>
				<li<c:if test="${param.search_gubun eq 'web' }"> class="select"</c:if>><a href="javascript:media.search.search('web')">웹페이지<span>(${web_count })</span></a></li>
				<li<c:if test="${param.search_gubun eq 'bbs' }"> class="select"</c:if>><a href="javascript:media.search.search('bbs')">게시판<span>(${bbs_count })</span></a></li>
				<li<c:if test="${param.search_gubun eq 'doc' }"> class="select"</c:if>><a href="javascript:media.search.search('doc')">파일<span>(${doc_count })</span></a></li>
				<li<c:if test="${param.search_gubun eq 'img' }"> class="select"</c:if>><a href="javascript:media.search.search('img')">이미지<span>(${img_count })</span></a></li>
				<li class="last"><span>검색옵션</span></li>
			</ul>
		</div>
	</div>
	
	<!-- 검색 옵션 -->
	<div class="ts_option">
		<div class="ts_option_wrap">
			<div class="left">
				<ul class="option_menu">
					<li>
						<c:choose>
							<c:when test="${param.sort eq 'latest' }"><p class="sort_text active">최신순</p></c:when>
							<c:when test="${param.sort eq 'score' }"><p class="sort_text active">정확도순</p></c:when>
							<c:otherwise><p class="sort_text">정렬</p></c:otherwise>
						</c:choose>
						<div class="option_list">
							<ul class="list">
								<li><a href="javascript:media.search.sortSearch('latest')"><span>최신순</span></a></li>
								<li><a href="javascript:media.search.sortSearch('score')"><span>정확도순</span></a></li>
							</ul>
						</div>
					</li>
					<li>
						<c:choose>
							<c:when test="${param.term eq 'all' }"><p class="term_text active">전체</p></c:when>
							<c:when test="${param.term eq '1' }"><p class="term_text active">1일</p></c:when>
							<c:when test="${param.term eq '2' }"><p class="term_text active">1주</p></c:when>
							<c:when test="${param.term eq '3' }"><p class="term_text active">1개월</p></c:when>
							<c:when test="${param.term eq '4' }"><p class="term_text active">1년</p></c:when>
							<c:when test="${param.term eq '5' }"><p class="term_text active">${param.start_dt } ~ ${param.end_dt }</p></c:when>
							<c:otherwise><p class="term_text">기간</p></c:otherwise>
						</c:choose>
						<div class="option_list ts_period">
							<ul class="list">
								<li><a href="javascript:media.search.termSearch('all')"><span>전체</span></a></li>
								<li><a href="javascript:media.search.termSearch('1')"><span>1일</span></a></li>
								<li><a href="javascript:media.search.termSearch('2')"><span>1주</span></a></li>
								<li><a href="javascript:media.search.termSearch('3')"><span>1개월</span></a></li>
								<li><a href="javascript:media.search.termSearch('4')"><span>1년</span></a></li>
							</ul>
							<a href="javascript:void(0);" class="direct_input">직접입력</a>
							<div class="date_input">
								<h6>기간 직접 입력</h6>
								<div>
									<ul>
										<li>
											<label for="start_dt">시작일</label>
											<input type="text" id="startdt" value="${param.start_dt }" autocomplete="off"/>
										</li>
										<li>
											<label for="end_dt">종료일</label>
											<input type="text" id="enddt" value="${param.end_dt }" autocomplete="off"/>
										</li>
									</ul>
									<div class="btn">
										<a href="javascript:media.search.termSearch(5)" class="apply">적용</a>
										<a href="javascript:void(0);" class="close">닫기</a>
									</div>
								</div>
							</div>
						</div>
					</li>
					<li>
						<c:choose>
							<c:when test="${param.fields eq '' }"><p class="fields_text active">전체</p></c:when>
							<c:when test="${param.fields eq 'title' }"><p class="fields_text active">제목</p></c:when>
							<c:otherwise><p class="fields_text">영역</p></c:otherwise>
						</c:choose>
						<div class="option_list">
							<ul class="list">
								<li><a href="javascript:media.search.fieldSearch('')"><span>전체</span></a></li>
								<li><a href="javascript:media.search.fieldSearch('title')"><span>제목</span></a></li>
							</ul>
						</div>
					</li>
					<li>
						<c:choose>
							<c:when test="${!empty keywordList }"><p class="detail_text active">상세검색</p></c:when>
							<c:otherwise><p>상세검색</p></c:otherwise>
						</c:choose>
						<div class="ts_detail_sch">
							<ul>
								<c:if test="${fn:length(keywordList) == 0 }">
								<li class="item">
									<select name="in_operator">
										<option value="">선택</option>
										<option value="AND">그리고</option>
										<option value="OR">또는</option>
									</select>
									<input type="text" name="in_keyword" placeholder="검색어를 입력하세요." />
									<input type="button" class="add" value="추가" />
								</li>
								</c:if>
								<c:if test="${fn:length(keywordList) > 0 }">
								<c:forEach var="item" items="${keywordList }" varStatus="status">
								<li class="item">
									<select name="in_operator">
										<option value="">선택</option>
										<option value="AND" <c:if test="${item.operator eq 'AND' }">selected="selected"</c:if>>그리고</option>
										<option value="OR" <c:if test="${item.operator eq 'OR' }">selected="selected"</c:if>>또는</option>
									</select>
									<input type="text" name="in_keyword" placeholder="검색어를 입력하세요." value="${item.keyword }"/>
									<c:if test="${status.first }">
									<input type="button" class="add" value="추가" />
									</c:if>
									<c:if test="${!status.first }">
									<input type="button" class="del" value="삭제" />
									</c:if>
								</li>
								</c:forEach>
								</c:if>
							</ul>
							<div>
								<a href="javascript:media.search.search('')" class="search">검색</a>
								<a href="javascript:void(0);" class="close">닫기</a>
							</div>
						</div>
					</li>
				</ul>
			</div>
			<div class="right">
				<a href="javascript:media.search.initSearch()" title="검색조건을 초기화 합니다.">초기화</a>
			</div>
		</div>
	</div>
	
	<div class="ts_cont">
		<div class="ts_cont_wrap">
			
			<!-- 검색 내용 -->
			<div class="ts_result">
			
				<!-- 전체검색 결과가 없을때 이것만 띄움 -->
				<c:if test="${total_cnt == 0 }">
				<div class="no_result_all">
					<h6>검색결과가 없습니다.</h6>
					<div>
						<p>도움말</p>
						<ul>
							<li>단어의 철자가 정확한지 확인해 보세요.</li>
							<li>검색어의 단어 수를 줄이거나, 보다 일반적인 검색어로 다시 검색해 보세요.</li>
							<li>두 단어 이상의 검색어인 경우, 띄어쓰기를 확인해 보세요.</li>
						</ul>
					</div>
				</div>
				</c:if>
				
				<!-- 검색결과 존재할시 띄움 -->
				<c:if test="${total_cnt > 0 }">
				<div class="sch_stats">
					<b>'
					<c:choose>
						<c:when test="${param.in_keyword_yn eq 'Y' }">${in_keyword }, ${param.total_keyword }</c:when>
						<c:otherwise>${param.total_keyword }</c:otherwise>
					</c:choose>
					'</b>
					에 대한 전체 <span>${total_cnt }개</span>의 검색결과를 <span>${proc_time }초</span>에 찾았습니다.
				</div>
				
				<!-- 메뉴 -->
				<c:if test="${empty param.search_gubun or param.search_gubun eq 'dit' }">
				<div class="result">
					<div class="tit">
						<p>메뉴<span>(검색결과 ${dit_page_info.totalcount }개)</span></p>
						<c:if test="${empty param.search_gubun }">
						<a href="javascript:media.search.search('dit')">검색결과 더 보기</a>
						</c:if>
					</div>
					<c:choose>
						<c:when test="${dit_page_info.totalcount > 0 }">
							<ul>
								<c:forEach var="item" items="${dit_list }">
								<li>
									<a href="${item.id }">메뉴명메뉴명</a>
									<span>${item.page_navi }</span>
								</li>
								</c:forEach>
							</ul>
						</c:when>
						<c:otherwise>
							<div class="no_result">검색결과가 없습니다.</div>
						</c:otherwise>
					</c:choose>
				</div>
				</c:if>
				
				<!-- 직원 -->
				<c:if test="${empty param.search_gubun or param.search_gubun eq 'mem' }">
				<div class="result">
					<div class="tit">
						<p>직원<span>(검색결과 ${mem_page_info.totalcount }개)</span></p>
						<c:if test="${empty param.search_gubun }">
						<a href="javascript:media.search.search('mem')">검색결과 더 보기</a>
						</c:if>
					</div>
					<c:choose>
						<c:when test="${mem_page_info.totalcount > 0 }">
							<table>
								<caption></caption>
								<colgroup>
									<col />
									<col />
									<col />
									<col />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">부서</th>
										<th scope="col">담당자명</th>
										<th scope="col">연락처</th>
										<th scope="col">담당업무</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="item" items="${mem_list }">
									<tr>
										<td>${item.group_nm }</td>
										<td>${item.member_nm }</td>
										<td>${item.tel }</td>
										<td class="left">${item.responsibilities }</td>
									</tr>
									</c:forEach>
								</tbody>
							</table>
						</c:when>
						<c:otherwise>
							<div class="no_result">검색결과가 없습니다.</div>
						</c:otherwise>
					</c:choose>
				</div>
				</c:if>
				
				<!-- 웹페이지 -->
				<c:if test="${empty param.search_gubun or param.search_gubun eq 'web' }">
				<div class="result">
					<div class="tit">
						<p>웹페이지<span>(검색결과 ${web_page_info.totalcount }개)</span></p>
						<c:if test="${empty param.search_gubun }">
						<a href="javascript:media.search.search('web')">검색결과 더 보기</a>
						</c:if>
					</div>
					<c:choose>
						<c:when test="${web_page_info.totalcount > 0 }">
							<ul>
								<c:forEach var="item" items="${web_list }" varStatus="status">
								<c:set var="t_arr" value="${fn:split(item.title, '>') }"/>
								<li>
									<a href="${item.id }">${t_arr[fn:length(t_arr)-1 ] }</a>
									<p class="txt">${suf:clearXSS2(item.conts) }</p>
									<span>${suf:clearXSS2(item.page_navi) }</span>
								</li>
								</c:forEach>
							</ul>
						</c:when>
						<c:otherwise>
							<div class="no_result">검색결과가 없습니다.</div>
						</c:otherwise>
					</c:choose>
				</div>
				</c:if>
				
				<!-- 게시판 -->
				<c:if test="${empty param.search_gubun or param.search_gubun eq 'bbs' }">
				<div class="result">
					<div class="tit">
						<p>게시판<span>(검색결과 ${bbs_page_info.totalcount }개)</span></p>
						<c:if test="${empty param.search_gubun }">
						<a href="javascript:media.search.search('bbs')">검색결과 더 보기</a>
						</c:if>
					</div>
					<c:choose>
						<c:when test="${bbs_page_info.totalcount > 0 }">
							<ul>
								<c:forEach var="item" items="${bbs_list }">
								<li>
									<a href="${item.id }">${suf:clearXSS2(item.title) }<span>${item.reg_dt }</span></a>
									<p class="txt">${suf:clearXSS2(item.conts) }</p>
									<span>${suf:clearXSS2(item.page_navi) }</span>
								</li>
								</c:forEach>
							</ul>
						</c:when>
						<c:otherwise>
							<div class="no_result">검색결과가 없습니다.</div>
						</c:otherwise>
					</c:choose>
				</div>
				</c:if>
				
				<!-- 파일 -->
				<c:if test="${empty param.search_gubun or param.search_gubun eq 'doc' }">
				<div class="result">
					<div class="tit">
						<p>파일<span>(검색결과 ${doc_page_info.totalcount }개)</span></p>
						<c:if test="${empty param.search_gubun }">
						<a href="javascript:media.search.search('doc')">검색결과 더 보기</a>
						</c:if>
					</div>
					<c:choose>
						<c:when test="${doc_page_info.totalcount > 0 }">
							<ul>
								<c:forEach var="item" items="${doc_list }" varStatus="status">
								<li>
									<a href="${item.id }">${suf:clearXSS2(item.title) }<span>${item.reg_dt }</span></a>
									<div class="file">								
										<c:forEach var="file" items="${item.files }">
										<c:set var="tok" value="${fn:split(file, '^;') }"/>
										<p><a href="${tok[0] }" >${tok[1] }</a></p>
										</c:forEach>
									</div>
									<c:if test="${!empty item.page_navi }">
									<span>${suf:clearXSS2(item.page_navi) }</span>
									</c:if>
								</li>
								</c:forEach>
							</ul>
						</c:when>
						<c:otherwise>
							<div class="no_result">검색결과가 없습니다.</div>
						</c:otherwise>
					</c:choose>
				</div>
				</c:if>
				
				<!-- 이미지 -->
				<c:if test="${empty param.search_gubun or param.search_gubun eq 'img' }">
				<div class="result">
					<div class="tit">
						<p>이미지<span>(검색결과 ${img_page_info.totalcount }개)</span></p>
						<c:if test="${empty param.search_gubun }">
						<a href="javascript:media.search.search('img')">검색결과 더 보기</a>
						</c:if>
					</div>
					<c:choose>
						<c:when test="${img_page_info.totalcount > 0 }">
							<div class="album">
							<c:forEach var="item" items="${img_list }" varStatus="status">
								<c:forEach var="t" items="${item.imgs }">
								<div>
									<a href="${item.id }"><img src="/mc/common/thumbnails.do?filename=${t }&ratio=true&type=1&width=151" alt="추출이미지" /></a>
								</div>
								</c:forEach>
							</c:forEach>
							</div>
						</c:when>
						<c:otherwise>
							<div class="no_result">검색결과가 없습니다.</div>
						</c:otherwise>
					</c:choose>
				</div>
				</c:if>
				
				<c:set var="totalpage" value="" scope="page"/>
				<c:set var="rows" value="${param.rows }" scope="page"/>
				<c:choose>
					<c:when test="${param.search_gubun eq 'web' }">
					<c:set var="totalpage" value="${web_page_info.totalpage }" />
					<c:set var="rows" value="10" />
					</c:when>
					<c:when test="${param.search_gubun eq 'dit' }">
					<c:set var="totalpage" value="${dit_page_info.totalpage }" />
					<c:set var="rows" value="10" />
					</c:when>
					<c:when test="${param.search_gubun eq 'bbs' }">
					<c:set var="totalpage" value="${bbs_page_info.totalpage }" />
					<c:set var="rows" value="10" />
					</c:when>
					<c:when test="${param.search_gubun eq 'mem' }">
					<c:set var="totalpage" value="${mem_page_info.totalpage }" />
					<c:set var="rows" value="10" />
					</c:when>
					<c:when test="${param.search_gubun eq 'doc' }">
					<c:set var="totalpage" value="${doc_page_info.totalpage }" />
					<c:set var="rows" value="10" />
					</c:when>
					<c:when test="${param.search_gubun eq 'img' }">
					<c:set var="totalpage" value="${img_page_info.totalpage }" />
					<c:set var="rows" value="16" />
					</c:when>
				</c:choose>
				<c:if test="${!empty totalpage }">
				<jsp:include page="/share/paging_post.do">
					<jsp:param name="use_params" value="search_gubun,total_keyword,term,sort,fields,start_dt,end_dt,jData"/>
					<jsp:param name="cpage" value="${param.cpage }"/>
					<jsp:param name="rows" value="${rows }"/>
					<jsp:param name="totalpage" value="${totalpage + 1}"/>
				</jsp:include>
				</c:if>				
				
				</c:if>
			</div>
			
			<!-- 검색어 영역 -->
			<div class="ts_rank">
				<div class="popular">
					<p class="tit">인기검색어</p>
					<div class="pop_tab">
						<ul id="rank_ul">
							<li class="on"><a href="javascript:void(0);" tab='month'>월간</a></li>
							<li><a href="javascript:void(0);" tab='week'>주간</a></li>
							<li><a href="javascript:void(0);" tab='day'>일간</a></li>
						</ul>
					</div>
					<ol id="rank_list">
					</ol>
				</div>
				<div class="my_word">
					<p class="tit">내가 찾은 검색어</p>
					<!-- 클릭으로 해당 검색어 검색 가능 -->
					<ul class="sch_rank">
					</ul>
				</div>
				<div class="portal">
					<p class="tit" style="line-height:1.4;">포털 사이트에서 <br /><span>'${param.total_keyword }'</span> 검색</p>
					<ul>
						<li class="google"><a href="javascript:media.search.popup_link('google', '${suf:encodeURIComponent(param.total_keyword)}');" title="구글에서 ${param.total_keyword } 검색">구글에서 검색</a></li>
						<li class="naver"><a href="javascript:media.search.popup_link('naver', '${suf:encodeURIComponent(param.total_keyword)}');" title="네이버에서 ${param.total_keyword } 검색">네이버에서 검색</a></li>
						<li class="daum"><a href="javascript:media.search.popup_link('daum', '${suf:encodeURIComponent(param.total_keyword)}');" title="다음에서 ${param.total_keyword } 검색">다음에서 검색</a></li>
					</ul>
				</div>
			</div><!-- rank_wrap -->
			
		</div>
	</div>
</div>

</body>
</html>
