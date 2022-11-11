(function($) {
	$(document).ready(function() {
		init();
		isAuth();
	});
	
	/**
	 * 로그인이 필요한 페이지에서 넘어왔다면 경고를 표시.
	 */
	const isAuth = function() {
		const queryString = window.location.search;
		if (queryString !== '' && typeof queryString !== 'undefined') {
			const params = new URLSearchParams(queryString);
			const isAuth = params.get('isAuth');
			if (isAuth === 'true') {
				alert('로그인이 필요한 페이지입니다.');
			}
		}
	}
	
	const init = function() {
		eventBind();
	}
	
	const eventBind = function() {
		$('.btn-login').on('click', valid);
		$('#login-id').on('keyup', loginKeyup);
		$('#pwd').on('keyup', loginKeyup);
	}
	
	/**
	 * 로그인 keyup 이벤트
	 */
	const loginKeyup = function(e) {
		const key = e.key || e.keyCode;
		if (key === 'Enter' || key === 13) {
			valid(e);
		}
	}
	
	/**
	 * 유효성 검사
	 */
	const valid = function(e) {
		e.preventDefault();
		
		const loginId = typeof $('#login-id').val() === 'undefined' ? '' : $('#login-id').val();
		const pwd = typeof $('#pwd').val() === 'undefined' ? '' : $('#pwd').val();
		if (loginId === '') {
			alert('아이디를 입력하세요.');
		} else if (pwd === '') {
			alert('비밀번호를 입력하세요.');
		} else {
			login(loginId, pwd);
		}
	}
	
	/**
	 * 로그인
	 */
	const login = function(id, pwd) {
		$.ajax({
			url: '/member/user-login.do',
			type: 'POST',
			data: {loginId: id, pwd: pwd},
			success: function(data) {
				if (data.result) {
					window.location.href = '/';
				} else {
					alert('로그인 정보가 정확하지 않습니다.');
				}
			},
			error: function(e) {
				console.error(e);
			}
		});
	}
})($);