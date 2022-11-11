(function($) {
	$(document).ready(function() {
		init();
	});
	
	const init = function() {
		eventBind();
		getList();
	}
	
	const eventBind = function() {
		$('.prj-cate li a').on('click', onCateClickHandler);
		$('.prj-filter ul li a').on('click', onFilterClickHandler);
	}
	
	/**
	 * 온라인 접수 지원사업 목록 데이터 가져오기.
	 */
	const getList = function() {
		$.ajax({
			url: '/apply/get-list.do',
			type: 'POST',
			success: function(data) {
				console.log(data);
				if (data.length > 0) {
					setListData(data);
				}
			},
			error: function(e) {
				console.error(e);
			}
		});
	}
	
	/**
	 * 온라인 접수 지원사업 목록 데이터 세팅.
	 */
	const setListData = function(data) {
		let html = '';
		
		for (let i=0; i < data.length; i++) {
			// 임시 url
//			const url = '/apply/'+data[i].bsns_cnnc_url+'/index.do'
//				+'?applyType=ONLINE&bizYr='
//				+ data[i].biz_yr
//				+ '&bizNo=' + data[i].biz_no
//				+ '&bizCycl=' + data[i].biz_cycl
//				+ '&indvdlGrpSeCd=' + data[i].indvdl_grp_se_cd;
				
			const bgngDay = data[i].rcpt_bgngday.substr(0, 4)+'.'
				+ data[i].rcpt_bgngday.substr(4, 2)+'.'
				+ data[i].rcpt_bgngday.substr(6, 2)+'.';
			const endDay = data[i].rcpt_endday.substr(0, 4)+'.'
				+ data[i].rcpt_endday.substr(4, 2)+'.'
				+ data[i].rcpt_endday.substr(6, 2)+'.';
				
			html += '<li>';
			html += '	<div class="prj-item">';
			html += '		<input type="hidden" name="bsnsCnncUrl" value="'+data[i].bsns_cnnc_url+'">';
			html += '		<input type="hidden" name="applyType" value="ONLINE">';
			html += '		<input type="hidden" name="bizYr" value="'+data[i].biz_yr+'">';
			html += '		<input type="hidden" name="bizNo" value="'+data[i].biz_no+'">';
			html += '		<input type="hidden" name="bizCycl" value="'+data[i].biz_cycl+'">';
			html += '		<input type="hidden" name="indvdlGrpSeCd" value="'+data[i].indvdl_grp_se_cd+'">';
			html += '		<a href="#">';
			html += '			<div class="thumb" style="background-image: url(/images/secp/thumb1.jpg);">';
			html += '				<div class="badge1">접수중</div>';
			html += '			</div>';
			html += '			<p class="subject">'+data[i].biz_nm+'</p>';
			html += '			<p class="date">'+bgngDay+' ~ '+endDay+'</p>';
			html += '		</a>';
			html += '	</div>';
			html += '</li>';
		}
		
		$('#prj-list').html(html);
		
		$('.prj-list .prj-item').on('click', onItemClickhandler);
	}
	
	/**
	 * 카테고리 클릭 시 동작하는 함수.
	 */
	const onCateClickHandler = function(e) {
		e.preventDefault();
		initCateActive();
		
		$(this).addClass('active');
	}
	
	/**
	 * 카테고리 active 초기화.
	 */
	const initCateActive = function() {
		$('.prj-cate li a').removeClass('active');
	}
	
	/**
	 * 필터 클릭 시 동작하는 함수.
	 */
	const onFilterClickHandler = function(e) {
		e.preventDefault();
		initFilterActive(this);
		
		$(this).addClass('active');
	}
	
	/**
	 * 필터 active 초기화.
	 * @param {HTMLElement} obj
	 */
	const initFilterActive = function(obj) {
		const siblings = $(obj).siblings();
		$(obj).parent().siblings().children().removeClass('active');
	}
	
	/**
	 * 지원 사업 목록을 클릭하면 동작하는 함수.
	 */
	const onItemClickhandler = function(e) {
		e.preventDefault();
		
		let obj = {};
		const params = $(this).children('input[type="hidden"]');
		for (let i=0; i < params.length; i++) {
			obj[params[i].name] = params[i].value;
		}
		
		// 이미 신청한 데이터인지 확인
		$.ajax({
			url: '/apply/indvdl-get.do',
			type: 'POST',
			data: {
				bizYr: obj.bizYr,
				bizNo: obj.bizNo,
				bizCycl: obj.bizCycl
			},
			success: function(data) {
				console.log(data);
				
				const url = '/apply/'+obj.bsnsCnncUrl+'/index.do'
				+'?applyType=ONLINE&bizYr='
				+ obj.bizYr
				+ '&bizNo=' + obj.bizNo
				+ '&bizCycl=' + obj.bizCycl
				+ '&indvdlGrpSeCd=' + obj.indvdlGrpSeCd;

				if (typeof data.rcpt_stts !== 'undefined' && data.rcpt_stts !== '') {
					if (data.rcpt_stts === '01') {
						// 임시저장 상태인 경우
						const isConfirm = confirm('이미 신청 중인 데이터가 있습니다.\n확인을 클릭하면 이어서 작성합니다.\n새로 신청하려면 나의 신청 현황에서 신청을 취소하세요.');
						if (isConfirm) {
							window.location.href = url;
						}
					} else {
						const isConfirm = confirm('이미 신청한 내역이 있습니다.\n확인을 클릭하면 나의 신청 현황으로 이동합니다.');
						if (isConfirm) {
							window.location.href = '/mybiz/index.do';
						}
					}
				} else {
					// 기신청 내용이 없는 것으로 간주하여 신청 페이지로 넘어감.
					//alert('잘못된 요청입니다.');
					window.location.href = url;
				}
			},
			error: function(e) {
				console.error(e);
			}
		});
	}
})($);