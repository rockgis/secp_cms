(function($) {
	$(document).ready(function() {
		init();
	});
	
	const init = function() {
		eventBind();
	}
	
	const eventBind = function() {
		$('#btn-cancel').on('click', function() { window.close(); });
		$('#btn-submit').on('click', valid);
		$('.btn-close').on('click', function() { window.close(); });
	}
	
	const valid = function(e) {
		/*const selected = $('input[name="category"]');
		if (typeof selected === 'undefined' || selected === '') {
			alert('신청분야를 선택하세요.');
		}*/
		e.preventDefault();
		const reason = $('#reason').val();
		if (typeof reason === 'undefined' || reason === '') {
			alert('포기사유를 입력하세요.');
			return;
		}
		
		sendSubmit();
	}
	
	/**
	 * 신청 정보를 가져옴.
	 */
	const getApplyData = function() {
		
	}
	
	const setApplyData = function(data) {
		$('')
	}
	
	/**
	 * 포기 데이터 제출.
	 */
	const sendSubmit = function() {
		$.ajax({
			url: '/mybiz/biz001/give-up.do',
			type: 'POST',
			success: function(data) {
				console.log(data);
				if (typeof data.result === 'undefined' || data.result === '') {
					alert('신청에 실패했습니다.\n관리자에게 문의하세요.');
				} else {
					window.close();
				}
			},
			error: function(e) {
				console.error(e);
				alert('신청에 실패했습니다.\n관리자에게 문의하세요.');
			}
		})
	}
})($);