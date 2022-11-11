(function($) {
	$(document).ready(function() {
		init();
		search();
	});
	
	const init = function() {
		eventBind();
		setKeyword();
	}
	
	const eventBind = function() {
		$('#input-keyword').on('keyup', onKeywordKeyupHandler);
	}
	
	const setKeyword = function() {
		const queryString = window.location.search;
		if (queryString !== '' && typeof queryString !== 'undefined') {
			const params = new URLSearchParams(queryString);
			const keyword = params.get('keyword');
			$('#input-keyword').val(keyword);
			$('#keyword').text('"'+keyword+'"');
		}
	}
	
	/**
	 * 검색어 입력 창에 키를 입력하면 동작하는 함수
	 */
	const onKeywordKeyupHandler = function(e) {
		const keyword = $(this).val().trim();
		
		const key = e.key || e.keyCode;
		if (key === 13 || key === 'Enter') {
			if (keyword !== '') {
				search(keyword);
			}
		}
	}
	
	/**
	 * 검색 요청
	 */
	const search = function() {
		const queryString = window.location.search;
		if (queryString !== '' && typeof queryString !== 'undefined') {
			const params = new URLSearchParams(queryString);
			const keyword = params.get('keyword');
			const filter = params.get('filter') === null ? 'ALL' : params.get('filter');
			
			if (keyword !== '' && typeof keyword !== 'undefined') {
				$.ajax({
					url: '/search.do',
					type: 'POST',
					data: {keyword: keyword, filter: filter},
					success: function(data) {
						console.log(data);
						
						const apply = data.apply;
						const board = data.board;
						const file = data.file;
						
						if (apply.length > 0) {
							const len = apply.length > 3 ? 3 : apply.length;
							let html = '';
							for (let i=0; i < len; i++) {
								html += '<li>';
								html += '	<a href="#">';
								html += '		<h4>' + apply[i].BIZ_NM + '</h4>';
								html += '		<p>'+ apply[i].PRGRS + '</p>';
								html += '	</a>';
								html += '</li>';
							}
							$('#apply-list').html(html);
							
							$('#apply-cnt').text('('+apply.length+'건)');
						}
						
						if (board.length > 0) {
							const len = board.length > 3 ? 3 : board.length;
							let html = '';
							for (let i=0; i < len; i++) {
								html += '<li>';
								html += '	<a href="#">';
								html += '		<h4>' + board[i].TITLE + '</h4>';
								html += '		<p>'+ board[i].CONTS + '</p>';
								html += '		<p class="date">'+ board[i].REG_DT + '</p>';
								html += '	</a>';
								html += '</li>';
							}
							$('#board-list').html(html);
							
							$('#board-cnt').text('('+board.length+'건)');
						}
						
						if (file.length > 0) {
							const len = file.length > 3 ? 3 : file.length;
							let html = '';
							for (let i=0; i < len; i++) {
								html += '<li class="f">';
								html += '	<img src="/images/secp/ico_file.svg" alt="" class="ico"><a href="#" class="subject">'+file[i].FILE_NM+'</a>';
								html += '	<p class="date">'+ file[i].REG_DT + '</p>';
								html += '</li>';
							}
							$('#file-list').html(html);
							
							$('#file-cnt').text('('+file.length+'건)');
						}
						
						$('#total-cnt').text(apply.length + board.length + file.length);
					},
					error: function(e) {
						console.error(e);
					}
				});
			}
		}
	}
})($);