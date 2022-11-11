jQuery(function($){
	// LNB
/*
	$('.lnb>ul>li').mouseover(function() {
		var menu_id = $(this).attr('class');
		//alert(menu_id);
		$('.lnb>ul>li').children('ul').hide();
		$('.lnb>ul>li').children('.s'+menu_id).show();
		$('.lnb>ul>li').children('span').removeClass('active');
		$(this).children('span').addClass('active');
	});
	$('.lnb>ul>li>ul>li').mouseover(function() {
		var sub_id = $(this).attr('class');
		//alert(sub_id);
		$('.lnb>ul>li>ul>li').removeClass('active');
		$(this).addClass('active');
	});
	$('.lnb>ul>li').focusin(function() {
		var smenu_id = $(this).attr('class');
		$('.lnb>ul>li').children('ul').hide();
		$('.lnb>ul>li').children('.s'+smenu_id).show();
		$('.lnb>ul>li').children('span').removeClass('active');
		$(this).children('span').addClass('active');
	});

	// NOWLNB
	var tab = $('.tab_face');
	tab.removeClass('js_off');
	function onSelectTab(){
		var t = $(this);
		var myclass = [];
		t.parentsUntil('.tab_face:first').filter('li').each(function(){
			myclass.push( $(this).attr('class') );
		});
		myclass = myclass.join(' ');
		if (!tab.hasClass(myclass)) tab.attr('class','tab_face').addClass(myclass);
	}
	tab.find('li>a').mouseover(onSelectTab).focus(onSelectTab);
*/
	
	// style1 전체메뉴 펼치기
	/*
	$(function(){
		var lnbHr = $('.lnb');
		
		lnbHr.find('>ul>li>ul').hide();
		lnbHr.find('>ul>li>a')
			.mouseover(function(){
				lnbHr.animate({height:'275px'}, 0.0001);
				lnbHr.find('>ul>li>ul').slideDown(0.0001).end();
				lnbHr.find('>ul>li').removeClass('active').end();
				lnbHr.find('>ul>li>ul').removeClass('active').end();
				lnbHr.find('>ul>li>ul>li').removeClass('active').end();
				$(this).parent('li').addClass('active');
				$(this).parent('li').children('ul').addClass('active');
				$('.lnb_bg').show();
			})
			.focus(function(){
				$(this).mouseover();
			})
			.end()
			.mouseleave(function(){
				lnbHr.animate({height:'54px'}, 0.0001);
				lnbHr.find('>ul>li').removeClass('active').end();
				lnbHr.find('>ul>li>ul').removeClass('active').end();
				lnbHr.find('>ul>li>ul>li').removeClass('active').end();
				lnbHr.find('>ul>li>ul').slideUp(0.0001);
				$('.lnb_bg').hide();
			});
		lnbHr.find('>ul>li>ul>li>a')
			.mouseover(function(){
				lnbHr.find('ul').removeClass('active').end();
				lnbHr.find('li').removeClass('active').end();
				$(this).parent('li').addClass('active').end();
				$(this).parent('li').parent('ul').addClass('active').end();
				$(this).parent('li').parent('ul').parent('li').addClass('active').end();
			})
			.focus(function(){
				$(this).mouseover();
			})
			.end()
			.mouseleave(function(){
				lnbHr.animate({height:'54px'}, 0.0001);
				lnbHr.find('ul').removeClass('active').end();
				lnbHr.find('li').removeClass('active').end();
			});
			
			lnbHr.find('>ul>li>ul>li:last').addClass('last');
		
			lnbHr.find('>ul>li>ul>li.last').on('focusout', function(){
				$(this).mouseleave();
			});
	});
	*/
	
	// style2 일부메뉴 펼치기
	$("#lnb > ul > li").on("mouseenter",function(){
		var lnb_bg = "<div class='lnb_bg'></div>";
		var lnb_bg_ht = $(this).find(".lnb_sub").height();
		$(".lnb_bg").remove();
		$("#header").prepend(lnb_bg);
		$(".lnb_bg").css({"height":lnb_bg_ht+60});
		$(this).addClass("active");
		$("#lnb > ul > li").children(".lnb_sub").hide();
		$(this).children(".lnb_sub").show();
	});
	$("#lnb > ul > li").on("mouseleave",function(){
		$(".lnb_bg").remove();
		$("#lnb ul > li").removeClass("active");
		$("#lnb ul > li").children(".lnb_sub").hide();
	});
	$("#lnb > ul > li > a").on("focusin",function(){
		var lnb_bg = "<div class='lnb_bg'></div>";
		var lnb_bg_ht = $(this).siblings(".lnb_sub").height();
		$(".lnb_bg").remove();
		$("#header").prepend(lnb_bg);
		$(".lnb_bg").css({"height":lnb_bg_ht+60});
		$("#lnb > ul > li").children(".lnb_sub").hide();
		$(this).parent("active");
		$(this).siblings(".lnb_sub").css("display","block");
		// $(this).siblings(".lnb_sub").children("ul").children("li").last().children("ul").children("li").last().children("a").addClass("la");
	});
	// $(".lnb_sub > ul > li").on("focusout"," a.la", function(){
	// 	$(".lnb_bg").remove();
	// 	$("#lnb > li").removeClass("active");
	// 	$("#lnb > li").children(".lnb_sub").css("display","none");
	// });
	// lnb end
	
	

});







