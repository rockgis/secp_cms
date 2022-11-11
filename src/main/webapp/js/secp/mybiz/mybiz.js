(function($) {
	$(document).ready(function() {
		init();
	});
	
	const init = function() {
		eventBind();
		getList();
	}
	
	const eventBind = function() {
		
	}
	
	/**
	 * 사업 목록 데이터를 가져오는 함수.
	 */
	const getList = function() {
		$.ajax({
			url: '/mybiz/get-biz-list.do',
			type: 'POST',
			success: function(data) {
				console.log(data);
				setListData(data);
			},
			error: function(e) {
				console.error(e);
			}
		});
	}
	
	/**
	 * 사업 목록 데이터 세팅
	 */
	const setListData = function(data) {
		const progData = data.PROGRESS;
		if (progData.length > 0) {
			setProgData(progData);
		}
		
		const compData = data.COMPLETE;
		if (compData.length > 0) {
			setCompData(compData);
		}
	}
	
	/**
	 * 진행 중인 사업 목록 세팅
	 * @param {Array} data 데이터 리스트
	 */
	const setProgData = function(data) {
		let html = '';
		for (let i=0; i < data.length; i++) {
			let bizNm = data[i].biz_nm;
			let bizDate = data[i].rcpt_bgngday.substr(0, 4)+'-'
				+ data[i].rcpt_bgngday.substr(4, 2)+'-'
				+ data[i].rcpt_bgngday.substr(6, 2)
				+ ' ~ '
				+ data[i].rcpt_endday.substr(0, 4)+'-'
				+ data[i].rcpt_endday.substr(4, 2)+'-'
				+ data[i].rcpt_endday.substr(6, 2);
			let regDt = data[i].reg_dt.substr(0, 4)+'-'
				+ data[i].reg_dt.substr(4, 2)+'-'
				+ data[i].reg_dt.substr(6, 2);
			let rcptStts = data[i].rcpt_stts;
			let bsnsProgrsKnd = data[i].bsns_progrs_knd;
			let rcptSttsNm = data[i].rcpt_stts_nm;
			const bsnsCnncUrl = data[i].bsns_cnnc_url;
			
			html += '<tr>';
			html += '	<td>2023-010-01-00001</td>';
			html += '	<td>'+bizNm+'</td>';
			html += '	<td>'+bizDate+'</td>';
			html += '	<td>'+regDt+'</td>';
			html += '	<td><span class="c-blue bold">'+rcptSttsNm+'</span></td>';
			html += '	<td>';
			html += setProgBtn(data[i]);
			html += '	</td>';
			html += '</tr>';
		}
		$('#prog-list').html(html);
		
		progBtnEventBind();
	}
	
	/**
	 * 사업 진행상태에 따라 진행중인 사업의 버튼들을 세팅함.
	 * @param {object} data 사업 데이터
	 */
	const setProgBtn = function(data) {
		let html = '';
		const rcptStts = data.rcpt_stts;
		const bsnsCnncUrl = data.bsns_cnnc_url;
		
		// 임시저장, 보완요청, 접수완료
		if (rcptStts === '01' || rcptStts === '02' || rcptStts === '03') {
			const url = '/apply/'+data.bsns_cnnc_url+'/index.do'
				+'?applyType=ONLINE&bizYr='
				+ data.biz_yr
				+ '&bizNo=' + data.biz_no
				+ '&bizCycl=' + data.biz_cycl
				+ '&indvdlGrpSeCd=' + data.indvdl_grp_se_cd;
			html += '<button type="button" class="btn btn-blue biz-view" data-bsns-cnnc-url="'+bsnsCnncUrl+'" data-url="'+url+'">보기/수정</button>';
		}
		
		// 임시저장, 보완요청
		if (rcptStts === '01' || rcptStts === '02') {
			html += '<button type="button" class="btn btn-red biz-apply-cancel" data-bsns-cnnc-url="'+bsnsCnncUrl+'">신청취소</button>';
		}
		
		// 접수완료, 선정, 변경승인
		if (rcptStts === '03' || rcptStts === '05' || rcptStts === '10') {
			html += '<button type="button" class="btn btn-red biz-give-up" data-bsns-cnnc-url="'+bsnsCnncUrl+'">포기신청</button>';
		}
		
		// 평가 중, 미선정, 포기승인
		if (rcptStts === '04' || rcptStts === '06' || rcptStts === '08') {
			html += '-';
		}
		
		// 포기신청
		if (rcptStts === '07') {
			html += '<button type="button" class="btn btn-black biz-give-up-cancel" data-bsns-cnnc-url="'+bsnsCnncUrl+'">포기취소</button>';
		}
		
		// 선정, 변경승인
		if (rcptStts === '05' || rcptStts === '10') {
			html += '<button type="button" class="btn btn-mint biz-change" data-bsns-cnnc-url="'+bsnsCnncUrl+'">변경신청</button>';
		}
		
		// 변경신청
		if (rcptStts === '09') {
			html += '<button type="button" class="btn btn-black biz-change-cancel" data-bsns-cnnc-url="'+bsnsCnncUrl+'">변경취소</button>';
		}
		
		// 선정, 변경승인, 진행 중
		if (rcptStts === '05' || rcptStts === '10' || rcptStts === '11') {
			html += '<button type="button" class="btn btn-black biz-rpt" data-bsns-cnnc-url="'+bsnsCnncUrl+'">완료보고</button>';
		}
		
		// 검토완료
		if (rcptStts === '12') {
			html += '<button type="button" class="btn btn-white biz-pay" data-bsns-cnnc-url="'+bsnsCnncUrl+'">지급신청</button>';
		}
		
		// 지급신청
		if (rcptStts === '13') {
			html += '승인검토 중';
		}
		
		// 완료보고
		if (rcptStts === '15') {
			html += '보고서 검토 중';
		}
		
		return html;
	}
	
	/**
	 * 진행 중인 사업 목록의 각 버튼들에 이벤트 할당.
	 */
	const progBtnEventBind = function() {
		
		const btns = $('#prog-list tr td button');
		for (let i=0; i < btns.length; i++) {
			const bsnsCnncUrl = $(btns[i]).data('bsns-cnnc-url');
			
			// 보기/수정
			$('.biz-view').on('click', function() {
				window.location.href = $(this).data('url');
			});
			
			$('.biz-apply-cancel').on('click', function() {
				const isConfirm = confirm('지원사업 신청을 취소하시겠습니까? 다시 신청하면 처음 단계부터 진행합니다.');
				if (isConfirm) {
					//TODO: 신청취소 ajax
					alert('신청취소');
				}
			});
			
			// 포기신청
			$('.biz-give-up').on('click', function() {
				window.open('/mybiz/'+bsnsCnncUrl+'/popup/give-up.do', 'view', 'height=500, width=1000');
			});
			
			// 포기취소
			$('.biz-give-up-cancel').on('click', function() {
				const isConfirm = confirm('지원사업 포기신청을 취소하시겠습니까?');
				if (isConfirm) {
					//TODO: 포기신청 취소 ajax
					alert('포기신청 취소');
				}
			});
			
			// 변경신청
			$('.biz-change').on('click', function() {
				window.open('/mybiz/'+bsnsCnncUrl+'/popup/change.do', 'view', 'height=500, width=1000');
			});
			
			// 파일첨부
			$('.biz-rpt').on('click', function() {
				window.open('/mybiz/'+bsnsCnncUrl+'/popup/rpt.do', 'view', 'height=500, width=1000');
			});
			
			// 미리보기
			$('.biz-file').on('click', function() {
				window.open('/mybiz/'+bsnsCnncUrl+'/popup/file.do', 'view', 'height=500, width=1000');
			});
		}
	}
	
	const setCompData = function(data) {
		let html = '';
		for (let i=0; i < data.length; i++) {
			let bizNm = data[i].biz_nm;
			let bizDate = data[i].rcpt_bgngday.substr(0, 4)+'-'
				+ data[i].rcpt_bgngday.substr(4, 2)+'-'
				+ data[i].rcpt_bgngday.substr(6, 2)
				+ ' ~ '
				+ data[i].rcpt_endday.substr(0, 4)+'-'
				+ data[i].rcpt_endday.substr(4, 2)+'-'
				+ data[i].rcpt_endday.substr(6, 2);
			let regDt = data[i].reg_dt.substr(0, 4)+'-'
				+ data[i].reg_dt.substr(4, 2)+'-'
				+ data[i].reg_dt.substr(6, 2);
			let rcptSttsNm = data[i].rcpt_stts_nm;
			
			html += '<tr>';
			html += '	<td>2023-010-01-00001</td>';
			html += '	<td>'+bizNm+'</td>';
			html += '	<td>'+bizDate+'</td>';
			html += '	<td>'+regDt+'</td>';
			html += '	<td><span class="c-black bold">'+rcptSttsNm+'</span></td>';
			html += '	<td><button type="button" class="btn btn-black">보기</button></td>';
			html += '	<td><button type="button" class="btn btn-white">미리보기</button></td>';
			html += '</tr>';
		}
		$('#comp-list').html(html);
	}
	
	const setCompBtn = function() {
		
	}
})($);