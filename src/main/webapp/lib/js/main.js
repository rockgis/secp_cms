var opt1={slideWidth: 340, minSlides: 1, maxSlides: 1, moveSlides: 1, slideMargin: 0, auto: true, autoControls: true, pager: false, pause : 4000}
var opt2={slideWidth: 340, minSlides: 2, maxSlides: 3, moveSlides: 1, slideMargin: 5, auto: false, autoControls: false, autoControlsCombine: false, pager: false, pause : 4000, touchEnabled : true}
var resizeBx = null;
var main_speed = 800;
var main_pause = 5500;
var progress_time = main_pause+main_speed;

$(document).ready(function(){
	
	if(!$.cookie("sb_footer_"+$.datepicker.formatDate('ymmdd', new Date()))){
		if($("#sky_banner_zone").length > 0){
			$(".wrap").addClass("main_banner");
			$(".sky_banner").css({"margin-top":"0px"});
		}
	}
	
	var width = $(window).width();
	$('.press_slide').bxSlider({
		slideWidth: (width < 768) ? width : 223,
		minSlides: 1,
		maxSlides: (width < 768) ? 1 : 3,
		moveSlides: 1,
		slideMargin: 86,
		auto: true,
		mode: 'horizontal',
		pager: false,
		touchEnabled: (navigator.maxTouchPoints > 0)
	});
	
	
	// banner
	$(".sb_slide").bxSlider({
		auto: true,
		pager:false,
		autoControls: false,
		responsive: true,
		minSlides: 1,
		maxSlides: 1,
		moveSlides: 1,
		speed : main_speed,
		pause : main_pause,
		onSliderLoad : function(){
			$("#sky_banner_zone").css("visibility","visible");
		}
	});
	$(".sb_footer button").on("click",function(){
		if($("#banner_chk").is(":checked")){
	  		$.cookie("sb_footer_"+$.datepicker.formatDate('ymmdd', new Date()), 'done', {path:"/", expires: 1 });
		}
		$(".wrap").removeClass("main_banner");
		$(".sky_banner").css({"margin-top":"-140px"});
		$(".sky_banner").css({"visibility":"hidden"});
	});
	// banner end
	
	//layer popup
	var slider = $('.lp_slide').bxSlider({
		slideWidth: 1100,
		minSlides: 1,
		maxSlides: 1,
		moveSlides: 1,
		slideMargin: 0,
		adaptiveHeight: true,
		pause: 5000,
		speed: 1000,
		pager: false,
		autoHover: true,
		auto: true,
		autoControls: false,
		//웹접근성(.bx-clone에 초점 방지)
		onSliderLoad: function(){
			$(".bx-clone").find("a").prop("tabIndex","-1");
		},
		onSlideAfter: function(){
			slider.stopAuto();
			slider.startAuto();
			//웹접근성(.bx-clone에 초점 방지)
			$(".lp_slide").children("li").each(function(){
				if($(this).attr("aria-hidden") == "false"){
					$(this).find("a").attr("tabIndex","0");
				}else{
					$(this).find("a").attr("tabIndex","-1");
				}
			});
		}
	});
	
	//웹접근성(.bx-clone에 초점 방지)
	$('.lp_slide a').focusin(function () {
		mainSlider.stopAuto();
	});
	
	//main visual
	$('.slide_wrap').bxSlider({
		slideWidth: 1920,
		minSlides: 1,
		maxSlides: 1,
		moveSlides: 1,
		slideMargin: 0,
		mode:'fade',
		speed:1000,
		auto: true,
		autoControls: false,
		controls: false
	});
	
	$(".popup_zone > ul").bxSlider({
		slideWidth: 400,
		minSlides:1,
		maxSlides:1,
		moveSlides:1,
		auto:true,
		autoControls:true,
		autoControlsCombine:true,
		touchEnabled: false,
		pager:false,
		autoControlsCombine:true
	});


	if($(window).width() <= 768){
		resizeBx = $('.pz_slide').bxSlider(opt2);
	}else{
		resizeBx = $('.pz_slide').bxSlider(opt1);
	}
	
	//news	
	$('.news > .slide ul').bxSlider({
		slideWidth: 360,
		minSlides: 1,
		maxSlides: 1,
		moveSlides: 1,
		slideMargin: 0,
		mode: 'fade',
		pager: false,
		speed :0.5
	});
	
	$('#bannerList').bxSlider({
		slideWidth: 1050/6,
		minSlides: 1,
		maxSlides: 6,
		moveSlides: 6,
		auto: false,
		pager: false,
		hideControlOnEnd: false
	});
	
});

function shwoTabNav(eName, totalNum, showNum) {
	for(i=1; i<=totalNum; i++){
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

$(window).on('resize', function(){
	if($(window).width() <= 768){
		resizeBx.destroySlider();
		resizeBx = $('.pz_slide').bxSlider(opt2);
	}else{        
		resizeBx.destroySlider();
		resizeBx = $('.pz_slide').bxSlider(opt1);
	} 
});