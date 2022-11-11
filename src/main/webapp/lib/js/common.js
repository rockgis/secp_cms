//tab menu
function shwoTabNav(eName, totalNum, showNum) {
	for (i = 1; i <= totalNum; i++) {
		var zero = (i >= 10) ? "" : "0";
		var e = document.getElementById("tabNav" + eName + zero + i);
		var eTitle = document.getElementById("tabNavTitle" + eName + zero + i);
		e.style.display = "none";
		eTitle.className = "";
	}

	var zero = (showNum >= 10) ? "" : "0";
	var e = document.getElementById("tabNav" + eName + zero + showNum);
	var eTitle = document.getElementById("tabNavTitle" + eName + zero + showNum);
	e.style.display = "block";
	eTitle.className = "on";
}

$(document).ready(function(){
	// img on_off
	var imgBtn = $('a.btn');

	imgBtn.on('mouseenter', function(){
		var src = $(this).find('img').attr('src');
		$(this).find('img').attr('src', src.replace('_off', '_on'));
	});

	imgBtn.on('mouseleave', function(){
		var src = $(this).find('img').attr('src');
		$(this).find('img').attr('src', src.replace('_on', '_off'));
	});

	// mobile search

	$('.search_m').on('click', function(){
		$('#header').toggleClass('m_header_on');
		$('.h_search').slideToggle(0);
	});

});

//mobile side menu
$(function(){
	// drawer menu show hide
	var movePs = $("#naviMenu").outerWidth();
	$("#naviMenu").css('left', -1000).hide();

	function navClose() {
		$('#naviMenu').removeClass('open').css('top',0).find('>div').addBack().css('height',$(window).height());
		//$(".headerCom").removeClass("naviOpen");
		$("html, body").css({'overflow':'auto'});
		$(window).css({'overflow':'auto'});
		$(".wrap").css({'height':'auto', 'overflow':'auto'}).stop().animate({"left": 0}, 200);
		$("#naviMenu").css('top',0).stop().animate({'top':0, "left": -1000}, 200,function(){$(this).hide();});
		$(".dmm").remove();

		if($('#container').find('div').hasClass('lnbWrap')){
			//$('.lnbWrap, .prdList').css({'position':'fixed'});
		} else {
			//$('#lnb, .prdList').css({'position':'fixed'});
		}
	}

	function navOpen() {
		$('#naviMenu').css('top',0).find('>div').addBack().css('height',$(window).height());
		//$(".headerCom").addClass("naviOpen");
		$("html, body").css({'overflow':'hidden'});
		$(window).css({'overflow':'hidden'});
		$("body").append('<div class="dmm"></div>');
		$(".wrap").css({'height':$(window).height(), 'overflow':'hidden'}).stop().animate({"left": movePs}, 200);
		$("#naviMenu").addClass('open').css('top',0).show().stop().animate({'top':0, "left": 0}, 200);

		if($('#container').find('div').hasClass('lnbWrap')){
			//$('.lnbWrap, .prdList').css({'position':'fixed'});
		} else {
			//$('#lnb, .prdList').css({'position':'absolute'});
		}
		$('.dmm').click(function(){
			navClose();
		});

		setTimeout( gnbPostionSet, 200 );
	}

	function gnbPostionSet()
	{
		var arrTop = [56,133,210,287,364,441];
		var arrTopPos = [0,-75,-150,-225,-300,-375];

		$(".gnb").each( function ( i ) {
			var t = arrTop[i];
			$(this).css("top", t );
			$(this).find("a").css("background-position", "0px " + arrTopPos[i] + "px");
		});
	}

	$(window).resize(function(){
		if($('#naviMenu').hasClass('open')){
			$('#naviMenu').css({'top':0, 'left':0}).find('>div').addBack().css('height',$(window).height());
		} else {
			$('#naviMenu').css({'top':0, 'left':-1000}).find('>div').addBack().css('height',$(window).height());
		}
	});


	$(".btnCtg").click(function() {
		navOpen();
	});
	$("#naviMenu .close").click(function() {
		navClose();
	});


	// drawer menu click

	$(".menuCtg .gnb").click(function(){
		$("li").has($(this)).siblings("li").removeClass("on");
		$("li").has($(this)).addClass("on");
	});

	$(".menuCtg span.arrow").click(function(){
		$(this).parent().parent().siblings("li").removeClass("on");
		if ($(this).parent().find("ul").css('display') == 'block') {
			$(this).parent().removeClass("on");
		}else {
			$(this).parent().parent().addClass("on");
		}
	});

	$(".menuCtg .subTit").click(function(){
		$(this).parent().siblings("li").removeClass("on");
		if ($(this).parent().find(".sub").css('display') == 'block') {
			$(this).parent().removeClass("on");
		}else {
			$(this).parent().addClass("on");
		}
	});

	$(".menuCtg .subTit").each(function() {
		if ($(this).parent().find(".sub").length < 1) {
			$(this).parent().addClass("subNo");
		}
	});

	$(".sideMn").addClass("mn1");
	$(".menuCtg .gnb").bind("click", function (e) {
		var i = $("li").has($(this)).index();
		$(".sideMn").attr('class', 'sideMn');
		$(".sideMn").addClass("mn" + i);
	});
	
	//LANGUAGE
	$('.btn_family').click(function () {
		$(this).toggleClass('open');
		$('.familyList').toggleClass('open').slideToggle(300);
	});					

	$('.familyList a').click(function () {
		$(".btn_family").text($(this).text());

		$(this).toggleClass('open');
		$('.familyList').toggleClass('open').slideToggle(300);
	});
	
	//관련사이트
	$('.btn_family2').click(function () {
		$(this).toggleClass('open');
		$('.familyList2').toggleClass('open').slideToggle(300);
	});					

	$('.familyList2 a').click(function () {
		$(".btn_family2").text($(this).text());

		$(this).toggleClass('open');
		$('.familyList2').toggleClass('open').slideToggle(300);
	});

	//검색
	$("a.sch_btn").click(function(){
		$(".sch_form").css("display","block");
		$("a.sch_btn").css("display","none");
		$("a.close_btn").css("display","block");
	});
	$("a.close_btn").click(function(){
		$(".sch_form").css("display","none");
		$("a.sch_btn").css("display","block");
		$("a.close_btn").css("display","none");
	});	
	
});