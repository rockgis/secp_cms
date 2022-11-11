(function($) {
	/* - StringBuffer - */ 
    function StringBuffer(){ 
        this.content = new Array; 
    } 
    StringBuffer.prototype.append = function( str ){ 
        this.content.push( str ); 
    } 
    StringBuffer.prototype.toString = function(){ 
        return this.content.join(""); 
    }
    /* //- StringBuffer - */ 
    
    /**
     * 페이지 로딩 후 이벤트 세팅.
     */
    $(document).ready(function() {
    	init();
    	initNoticeSwiper(); 
    });

    /**
     * 페이지 로딩 시 실행하는 함수.
     */
    const init = function() {
        eventBind();
        rollingList(); //게시판 목록 조회
    }

    /**
     * 요소의 클릭(onclick), 선택(onselect) 등의 이벤트 관리.
     * 필수 작성.
     */
    const eventBind = function() {
    	$('#btn-main-search').on('click', search);
		$('#main-search').on('keyup', searchKeyup);
		$('.tag li').on('click', tagClick);
		$('#btn-logout').on('click', logout);
    }
    
    const getApplyList = function() {
		$.ajax({
			url: '/apply/get-list.do',
			type: 'POST',
			success: function(data) {
				console.log(data);
				if (data.length > 0) {
					setApplyList(data);
				}
			},
			error: function(e) {
				console.error(e);
			}
		});
	}
	
	const setApplyList = function(data) {
		let html = '';
		
		for (let i=0; i < data.length; i++) {
			html += '<li>';
			html += '	<div class="prj-item" data-aos="fade-up">';
			html += '		<a href="#">';
			html += '			<div class="thumb" style="background-image: url(/images/secp/thumb1.jpg);">';
			html += '				<div class="badge1">접수중</div>';
			html += '			</div>';
			html += '			<div class="txt">';
			html += '				<p class="subject">(1단계) 역량강화_골목상권공동체_신규</p>';
			html += '				<p class="date">2022.07.01 ~ 2022.12.31</p>';
			html += '				<p class="view">자세히 보기 <span>+</span></p>';
			html += '			</div>';
			html += '		</a>';
			html += '	</div>';
			html += '</li>';
		}
		
		$('#prj-list').html(html);
	}
	
	/**
	 * 키워드 검색에서 
	 */
	const searchKeyup = function(e) {
		const key = e.key || e.keyCode;
		if (key === 'Enter' || key === 13) {
			const keyword = $(this).val();
			search(keyword);
		}
	}
	
	/**
	 * 메인 페이지에서 키워드 검색
	 */
	const search = function(keyword) {
		if (typeof keyword === 'undefined' || keyword.trim() === '') {
			alert('검색어를 입력하세요.');
			return;
		}
		
		const _keyword = keyword.trim();
		
		window.location.href = '/search.do?keyword='+_keyword+'&filter=ALL';
	}
	
	/**
	 * 검색어 태그를 클릭할 때 동작하는 함수.
	 */
	const tagClick = function() {
		const keyword = $(this).text().trim();
		const _keyword = keyword.replace('#', '');
		search(_keyword);
	}
    
    //메인화면 롤링 - 필독 공지사항 슬라이드.
    function initNoticeSwiper() {
        var notice_swiper = new Swiper('.notice-swiper', {
            direction: "vertical",
            effect: 'slide',
            speed: 1000,
            loop:true,
            navigation: {
                nextEl: '.noti-btn-right',
                prevEl: '.noti-btn-left',
            },
            autoplay: {
                delay: 2000,
            },
            pauseOnMouseEnter: true,
            loop: true,
        });
    }
    
    //메인화면 롤링 - 필독공지사항 게시판 목록 조회
    const rollingList = function() {
    	const url = "/web/boardRlist.do";
    	$.ajax({
	        type: "GET",
	        url: url, 
	        dataType:"json",
	        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
	        error: function(e) {
	          console.error(e);
	        },
			success : function(data) {
				let sb = new StringBuffer(); 
		    	let content = data['rlist'];
		    	content.forEach(function(el) {
		    		let as = el.article_seq;
		    		sb.append(
	    				'<div class="swiper-slide">' +
	   		            	'<a href="/board/boardDetail.do?as='+as+'">' + el.title + '</a>' +
	   		            	'<img src="/images/secp/ico_new2.svg" alt="NEW" class="ico">'+
	   		            '</div>'               
		    		);
				});
		    	let text = sb.toString();
				$('#rlist').append(text);  
				initNoticeSwiper(); 
			}

	    });
    }
    
    /**
     * 로그아웃
     */
    const logout = function(e) {
    	e.preventDefault();
    	
    	$.ajax({
    		url: '/member/user-logout.do',
    		type: 'POST',
    		success: function() { window.location.href = '/'; },
    		error: function() { window.location.href = '/'; }
    	});
    }
})($);