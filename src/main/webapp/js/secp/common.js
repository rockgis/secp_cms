$(function(){
	
	// 모바일 메뉴 버튼
	$(".btn-menu").on("click", function(){
        $(".nav-wrap").toggleClass("active");
		$('body').toggleClass("noscroll");
	});

	// 메뉴 동작
	$(".nav-wrap > ul > li").on("mouseover", function(){
		$(this).parent("ul").addClass("active");
	});
	$(".nav-wrap > ul > li").on("mouseleave", function(){
		$(this).parent("ul").removeClass("active");
	});

    // 메뉴 현재위치 표시
	$.initmenu = function(a,b){
		if (a) {
			$(".nav-wrap a").removeClass("active");
			var a = a - 1;
			var activeA = $(".nav-wrap > ul > li:eq(" + a + ") > a");
			activeA.addClass("active");
		}
		if (b) {
			var b = b - 1;
			var activeB = $(".nav-wrap > ul > li:eq(" + a + ") > ul > li:eq(" + b + ") > a");
			activeB.addClass("active");
		}
	}

    // datepicker	
    let obj = {
		showOn: 'button',
        buttonImage: '/images/secp/icon_calendar.png',
        buttonImageOnly: true,
        dateFormat: 'yy-mm-dd',
        prevText: '이전 달',
        nextText: '다음 달',
        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        dayNames: ['일','월','화','수','목','금','토'],
        dayNamesShort: ['일','월','화','수','목','금','토'],
        dayNamesMin: ['일','월','화','수','목','금','토'],
        showMonthAfterYear: true,
        changeMonth: true,
        changeYear: true,
        yearSuffix: '년',
        beforeShow: function(input, inst){
            inst.dpDiv.css({ marginLeft: input.offsetWidth - 250 + 'px'});
        }	
    }
    
    // 오늘부터 선택가능
    const dateObj1 = Object.assign({}, obj);
    dateObj1.minDate = 0;
    $( ".fromdatepicker").datepicker(dateObj1);

    // 오늘까지 선택가능
    const dateObj2 = Object.assign({}, obj);
    dateObj2.maxDate = '+0d';
    $( ".datepicker").datepicker(dateObj2);
    
    // 제한 없이 선택가능
    $( ".basicdatepicker").datepicker(obj);
    
    // 반응형 테이블 처리
    $('.scrollable table').each(function() {
        var element = $(this);
        var scrollWrapper = $('<div />', {
            'class': 'scrollable',
            'html': '<div />'
        }).insertBefore(element);
        element.data('scrollWrapper', scrollWrapper);
        element.appendTo(scrollWrapper.find('div'));
        if (element.outerWidth() > element.parent().outerWidth()) {
            element.data('scrollWrapper').addClass('has-scroll');
        }
        $(window).on('resize orientationchange', function() {
            if (element.outerWidth() > element.parent().outerWidth()) {
                element.data('scrollWrapper').addClass('has-scroll');
            } else {
                element.data('scrollWrapper').removeClass('has-scroll');
            }
        });
    });

    // 상단 검색버튼 클릭시 & 닫기 버튼 클릭시
    $(".header .btn-search").on("click", function(){
        $(".pop-gnb-search").addClass("active");
        $(".dim").addClass("active");
    });
    $(".btn-search-close").on("click", function(){
        $(".pop-gnb-search").removeClass("active");
        $(".dim").removeClass("active");
        $(".nav-wrap").removeClass("active");
    });

	// 컨텐츠 부드럽게
	function isElementUnderBottom(elem, triggerDiff) {
//        const { top } = elem.getBoundingClientRect();
        const { innerHeight } = window;
        return top > innerHeight + (triggerDiff || 0);
    }

    function handleScroll() {
        const elems = document.querySelectorAll('.up-on-scroll');
        elems.forEach(elem => {
            if (isElementUnderBottom(elem, -20)) {
	            elem.style.opacity = "0";
	            elem.style.transform = 'translateY(250px)';
            } else {
	            elem.style.opacity = "1";
	            elem.style.transform = 'translateY(0px)';
            }
        })
    }
    window.addEventListener('scroll', handleScroll);
    
    // ajax csrf 헤더 세팅
    const CSRF_HEADER = $('meta[name="_csrf_header"]').attr('content');
    const CSRF_TOKEN = $('meta[name="_csrf"]').attr('content');
    
    let header = {};
    header[CSRF_HEADER] = CSRF_TOKEN;
    
    $.ajaxSetup({
    	headers: header
    });
    
    // 헤더 검색
    $('#header-search-btn').on('click', function() {
    	const keyword = $('#gnb-search').val().trim();
    	search(keyword);
    });
    
    $('#gnb-search').on('keyup', function(e) {
    	const key = e.key || e.keyCode;
    	if (key === 'Enter' || key === 13) {
    		search($(this).val());
    	}
    });
    
    const search = function(keyword) {
		if (typeof keyword === 'undefined' || keyword === '') {
			alert('검색어를 입력하세요.');
			return;
		}
		
		const _keyword = keyword.trim();
		
		window.location.href = '/search.do?keyword='+_keyword+'&filter=ALL';
	}
    
    $('.tag li').on('click', function() {
    	const keyword = $(this).text().trim();
		const _keyword = keyword.replace('#', '');
		search(_keyword);
    });
});
