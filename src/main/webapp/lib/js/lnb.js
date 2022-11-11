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
	$(function(){
		var lnbHr = $('.lnb');
		lnbHr.find('>ul>li>ul').hide();
		lnbHr.find('>ul>li>a')
			.mouseover(function(){
				lnbHr.animate({height:'354px'}, 0.0001);
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
				lnbHr.animate({height:'48px'}, 0.0001);
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
				lnbHr.animate({height:'48px'}, 0.0001);
				lnbHr.find('ul').removeClass('active').end();
				lnbHr.find('li').removeClass('active').end();
			});
			
			lnbHr.find('>ul>li>ul>li:last').addClass('last');
		
			lnbHr.find('>ul>li>ul>li.last').on('focusout', function(){
				$(this).mouseleave();
			});
		
			
/*
		$('.lnb_all>a').focusin(function() {
			lnbHr.find('>ul>li>ul').hide();
			lnbHr.animate({height:'40px'}, 0.0001);
			lnbHr.find('ul').removeClass('active').end();
			lnbHr.find('li').removeClass('active').end();
			$('.lnb_all>a').addClass('active').end();
		});				
*/
		
	});
	
	

});






