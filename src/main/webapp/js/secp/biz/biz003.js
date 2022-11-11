(function($) {
    let CUR_LVL = 0; // 현재 신청 단계
    let CUR_LVL_ID = 'agree';
    let SAVE_TYPE = 'I';

    /**
     * 페이지 로딩 후 이벤트 세팅.
     */
    $(document).ready(function() {
    	init();
    });

    const isEmpty = function(v){
    	return ( v===""||v===null||v===undefined||( v!=null && typeof v=="object" && !Object.keys(v).length));
    }
    
    /**
     * 페이지 로딩 시 실행하는 함수.
     */
    const init = function() {
        eventBind();
        setApplyLvlIdx();
        getIsAgree();
    }

    /**
     * 요소의 클릭(onclick), 선택(onselect) 등의 이벤트 관리.
     * 필수 작성.
     */
    const eventBind = function() {
    	$('#addr-search').on('click', onAddrSearchclickHandler);
        $('#list-btn').on('click', onListClickHandler);
    	$('#prev-btn').on('click', onPrevClickHandler);
    	$('#next-btn').on('click', onNextClickHandler);
        $('#save-btn').on('click', onSaveClickHandler);
        $('#submit-btn').on('click', onSubmitClickHandler);
        $('#close-date').on('click', function() { $('#close-date + img').click() });
        $('#dms-date').on('click', function() { $('#dms-date + img').click() });
        $('#dme-date').on('click', function() { $('#dme-date + img').click() });
        
        $('.number').on('keyup', function(){
        	this.value = this.value.replace(/^[0]|[^0-9]/g, '');
        })
    }

    /**
     * 개인정보활용동의 여부를 확인하는 함수.
     */
    const getIsAgree = function() {
    	const isAgree = window.IS_AGREE;
    	moveToLvl(0)
    	if (isAgree === 'Y') {
            getApplyData();
        }
    }

    /**
     * apply-lvl-container 클래스에 data-idx 속성을 추가하는 함수.
     */
    const setApplyLvlIdx = function() {
    	const lvlCont = $('.apply-lvl-container');
    	for (let i=0; i < lvlCont.length; i++) {
    		$(lvlCont[i]).attr('data-idx', i);
    	}
    }

    /**
     * 지원 신청 데이터를 가져오는 함수.
     */
    const getApplyData = function() {
    	let bizYr = '';
    	let bizNo = '';
    	let bizCycl = '';
    	let indvdlGrpSeCd = '';
    	const queryString = window.location.search;
		if (queryString !== '' && typeof queryString !== 'undefined') {
			const params = new URLSearchParams(queryString);
			bizYr = params.get('bizYr');
			bizNo = params.get('bizNo');
			bizCycl = params.get('bizCycl');
			indvdlGrpSeCd = params.get('indvdlGrpSeCd');
		}
		const url = indvdlGrpSeCd === '01' ? '/apply/indvdl-get.do' : '/apply/grp-get.do';
		
        $.ajax({
        	url: url,
        	type: 'POST',
        	data: {
        		bizYr: bizYr, 
        		bizNo: bizNo, 
        		bizCycl: bizCycl
        	},
        	success: function(data) {
        		if (data !== '') {
        			if(data.PRESENTN_COMPT_YN === 'Y') {  // 접수완료 
        				 alert('이미 접수 완료된 사업입니다.')
        				 return history.back(); 
        			}
        			SAVE_TYPE='U';
        			const isContinue = confirm('기존 신청 데이터가 있습니다. 이어서 작성하시겠습니까?');
        			if (isContinue) {
        				if (typeof data.rcpt_data !== 'undefined' && data.rcpt_data !== '') {
        					const json = JSON.parse(data.rcpt_data);
        					setApplyData(json);
        				}
        			}
        		} else {
        			SAVE_TYPE='I';
        		}
        	},
        	error: function(e) {
        		console.error(e);
        	}
        });
    }

    /**
     * 지원 신청 데이터를 세팅하는 함수.
     * @param {Object} data getApplyData로 가져온 데이터.
     */
    const setApplyData = function(data) {
    	const keys = Object.keys(data);
        for (let i=0; i < keys.length; i++) {
        	$('[name="'+keys[i]+'"]').val(data[keys[i]]);
        }
    }
    
    /**
     * 메인 단계를 세팅하는 함수.
     * @param {number} lvlIdx
     */
    const setMainLvl = function(lvlIdx) {
    	initLvlActive();

    	const target = $('.step-list').children()[lvlIdx];
    	$(target).addClass('active');

    	let lenght = $('.step-list li').length;
    	for (let i = 0; i < lenght; i++) {
    		$('.step-list li:eq("'+i+'") img').attr('src', '/images/secp/ico_step'+(i+1)+'.png');
		}
    	
        const srcStr = $(target).children('img').attr('src');
        $(target).children('img').attr('src', srcStr.replace('.png', '_on.png'));
    }
    
    
    /**
     * 단계의 active를 초기화함.
     * @param {string} type MAIN
     */
    const initLvlActive = function() {
        const mainTarget = $('.step-list').children();
        $(mainTarget).removeClass('active');
        const srcStr = $(mainTarget).children('img').attr('src');
        $(mainTarget).children('img').attr('src', srcStr.replace('_on', ''));
    }

    /**
     * 레벨 컨테이너를 표시함.
     * @param {number} lvlIdx
     */
    const setContainerDisplay = function(lvlIdx) {
        $('.apply-lvl-container').addClass('none');
        $('.apply-lvl-container[data-idx="'+lvlIdx+'"]').removeClass('none');

        goToContainerTop();
    }

    /**
     * 데이터 임시저장, 제출 전에 현재 입력 페이지의 유효성 검사를 수행하는 함수.
     * 필수 작성.
     * @returns boolean
     */
    const valid = function(CUR_LVL) {
        let resultObj;

        /**
         * 개인정보 활용동의 페이지 유효성 검사
         * @returns {{msg: string, result: boolean}}
         */
        const validAgree = function() {
            const agreeEl = $('.apply-lvl-container[data-idx=0] .agree-item input[type="radio"]');
            for (let i=0; i < agreeEl.length; i++) {
                if (!agreeEl[i].checked && agreeEl[i].value === 'Y') {
                    const agreeTit = $(agreeEl[i]).siblings('h3.agree-tit');
                    return {msg: '\'' + agreeTit[0].innerText + '\'에 동의해야 합니다.', result: false};
                }
            }

            return {msg: '', result: true}
        }
        
        /**
         * 기본정보 페이지 유효성 검사
         * @returns {{msg: string, result: boolean}}
         */
        const validBasic = function() {
        	// 대표자명
        	const repNm = $('#rep-name').val().trim();
        	if (repNm === '' || typeof repNm === 'undefined' || !/^[가-힣]+$/.test(repNm)) {
        		return {msg: '올바른 대표자명을 입력하세요.', result: false};
        	}
        	
        	// 연락처
        	const tel = $('#tel').val().trim();
        	if (!BIZ_CMM.validTel(tel)) {
        		return {msg: '올바른 연락처를 입력하세요.', result: false};
        	}
        	
        	//이메일
        	const email = $('#email-id').val().trim();
        	const emailDomain = $('#email-domain').val();
        	
        	if(email.length !== 0){ 
        		if (!/^[a-zA-z0-9._%+-]+$/.test(email)) {
            		return {msg: '올바른 대표자 이메일을 입력하세요.', result: false};
            	}
            	if (emailDomain === '' || typeof emailDomain === 'undefined') {
            		return {msg: '올바른 대표자 이메일을 선택하세요.', result: false};
            	}
        	}        
        	
        	// 주소
        	const bsnsAddr = $('#bsns-addr').val().trim();
        	if (bsnsAddr === '' || typeof bsnsAddr === 'undefined') {
        		return {msg: '올바른 주소를 입력하세요.', result: false};
        	}
        	
        	// 상호명
        	const storeNm = $('#store-name').val().trim();
        	if (storeNm === '' || typeof storeNm === 'undefined') {
        		return {msg: '올바른 상호명을 입력하세요.', result: false};
        	}
        	
        	const reg = /^(?:(?:1[6-9]|[2-9]\d)?\d{2})(?:(?:(\/|-|\.)(?:0?[13578]|1[02])\1(?:31))|(?:(\/|-|\.)(?:0?[13-9]|1[0-2])\2(?:29|30)))$|^(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00)))(\/|-|\.)0?2\3(?:29)$|^(?:(?:1[6-9]|[2-9]\d)?\d{2})(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:0?[1-9]|1\d|2[0-8])$/;

        	// 폐업예정일
        	const closeDate = $('#close-date').val();
        	if(!reg.test(closeDate)){
        		return {msg: '올바른 폐업예정일을 입력하세요.', result: false};
        	}

        	//철거공사일자
        	const start = $('#dms-date').val();
        	const end   = $('#dme-date').val();
        	
        	if(!isEmpty(start) && reg.test(start)){ 
        		console.log('11111111')
        		console.log('end ' + end)
        		if (isEmpty(end) || !reg.test(end)) {
        			console.log('2222222')
        			$('#dms-date').val('');
        			$('#dme-date').val('');
            		return {msg: '올바른 철거 공사 기간을 입력하세요.', result: false};
            	} 
        		
        		let sd = new Date(start);
        		let ed = new Date(end);
        		
        		if(sd > ed){
        			console.log('3333333')
        			$('#dms-date').val('');
        			$('#dme-date').val('');
            		return {msg: '올바른 철거 공사 기간을 입력하세요.', result: false};
            	}
        	} else {
        		$('#dms-date').val('');
    			$('#dme-date').val('');
        	}  
        	
        	// 시공업체명
        	const constNm = $('#cnstrt0-name').val().trim();
        	if (constNm === '' || typeof constNm === 'undefined') {
        		return {msg: '올바른 시공업체명을 입력하세요.', result: false};
        	}
        	
        	// 사업자등록번호
        	const bsnsNum = $('#cnstrt0-bsns-num').val().trim();
        	if(!BIZ_CMM.validBsnsNum(bsnsNum)){
        		return {msg: '올바른 사업자등록번호(시공업체)를 입력하세요.', result: false};
        	}
        	
        	// 연락처
        	const tel2 = $('#cnstrt0-tel').val().trim();
        	if (!BIZ_CMM.validTel(tel2)) {
        		return {msg: '올바른 전화번호를 입력하세요.', result: false};
        	}

        	// 공급가
            let cnstrtPymt = $('#cnstrt0-pymt').val();
            if (cnstrtPymt === '' || typeof cnstrtPymt === 'undefined') {
                return {msg: '공급가를 정확히 입력하세요.', result: false};
            }

            // 경상원 지원신청금
            let spymt = $('#spt-pymt').val();
            if (spymt === '' || typeof spymt === 'undefined') {
                return {msg: '경상원 지원신청금을 정확히 입력하세요.', result: false};
            }
        	
            // 예금주
        	const accholder = $('#acc-holder').val().trim();
        	if (accholder === '' || typeof accholder === 'undefined' || !/^[가-힣]+$/.test(accholder)) {
        		return {msg: '올바른 예금주를 입력하세요.', result: false};
        	}
        	
        	// 은행명
        	const bank = $('#bank').val().trim();
        	if (bank === '' || typeof bank === 'undefined' || !/^[가-힣|a-z|A-Z]+$/.test(bank)) {
        		return {msg: '올바른 은행명을 입력하세요.', result: false};
        	}
        	
        	// 계좌번호
        	const accRex = /[0-9,\-]{3,6}\-[0-9,\-]{2,6}\-[0-9,\-]/;
        	const acc = $('#acc').val().trim();
        	if (acc === '' || typeof acc === 'undefined' || !accRex.test(acc)) {
        		return {msg: '올바른 계좌번호를 입력하세요.', result: false};
        	}

        	return {msg: '', result: true};
        }
        
        /**
         * 증빙서류 제출 유효성검사.
         */
        const validDocSubmit = function() {
        	// 철거견적서
        	const docEst = $('#doc-est').val();
        	if (docEst === '' || typeof docEst === 'undefined') {
        		return {msg: '철거 견적서를 업로드하세요.', result: false};
        	}
        	
        	// 임대차계약서 사본
        	const docLease = $('#doc-lease').val();
        	if (docLease === '' || typeof docLease === 'undefined') {
        		return {msg: '임대차계약서 사본을 업로드하세요.', result: false};
        	}
        	
        	// 철거 견적 업체 사업자등록증
        	const docBsns = $('#doc-const-bsns').val();
        	if (docBsns === '' || typeof docBsns === 'undefined') {
        		return {msg: '철거 견적 업체 사업자등록증을 업로드하세요.', result: false};
        	}
        	
        	// 지원금 수령 통장 사본
        	const docBacc = $('#doc-bacc').val();
        	if (docBacc === '' || typeof docBacc === 'undefined') {
        		return {msg: '지원금 수령 통장 사본을 업로드하세요.', result: false};
        	}
        	
            return {msg: '', result: true};
        }

        switch (CUR_LVL_ID) {
	        case 'agree'	 : resultObj = validAgree(); break;
	        case ''			 : resultObj = {msg: '', result: true}; break;
	        case 'basic'	 : resultObj = validBasic(); break;
	        case 'doc'		 : resultObj = validDocSubmit(); break;
	    }

        if (!resultObj.result) {
            alert(resultObj.msg);
            return false;
        }

        return true;
    }

    /**
     * 목록으로 버튼을 클릭할 때 동작하는 함수.
     * @param e
     */
    const onListClickHandler = function(e) {
        e.preventDefault();
        window.location.href = '/apply/list.do';
    }

    /**
     * 이전 버튼을 클릭할 때 동작하는 함수.
     * @param e
     */
    const onPrevClickHandler = function(e) {
    	e.preventDefault();
        CUR_LVL === 0 ? CUR_LVL = 0 : CUR_LVL--;
        moveToLvl(CUR_LVL);
    }
    
    /**
	 * 다음 버튼을 클릭할 때 동작하는 함수.
	 */
	const onNextClickHandler = function(e) {
		e.preventDefault();
        if (valid(CUR_LVL_ID)) {
        	CUR_LVL++;
            moveToLvl(CUR_LVL);
        }
	}

	/**
	 * 현재 페이지 ID 세팅
	 */
	const setCurLvlId = function() {
		CUR_LVL_ID = $('.apply-lvl-container:not(.none)').data('lvl-id');
	}
	
    /**
     * 임시저장 버튼을 클릭할 때 동작하는 함수.
     * @param e
     */
    const onSaveClickHandler = function(e) {
        e.preventDefault();
        if (valid(CUR_LVL_ID)) {
        	formSubmit();
        }
    }

    /**
     * 제출하기 버튼을 클릭할 때 동작하는 함수.
     * @param e
     */
    const onSubmitClickHandler = function(e) {
        e.preventDefault();
        if (valid(CUR_LVL_ID)) {
        	formSubmit('SUBMIT');
        }
    }
    
    /**
     * CSRF 토큰 세팅
     */
    const setCsrf = function() {
    	if ($('meta[name="_csrf"]').length !== 0) {
    		$('#csrf').val($('meta[name="_csrf"]').attr('content'));
    	}
    }
    
    /**
     * form submit
     * @param {string} type 
     */
    const formSubmit = function(type) {
    	setCsrf();
    	const formData = new FormData($('#form')[0]);
 	
    	const files = $('input[type=file]');
    	let fileNms = '';
    	for(let j = 0; j < files.length; j++) {
    		if(!isEmpty($(files[j]).val())){
    			fileNms += files[j].getAttribute('name');
    			
    			if(j < (files.length-1)) { fileNms += ','; }
    		}
    	}
    	
    	formData.set('FILENMS', fileNms);
    	
    	if (type === 'SUBMIT') {
    		formData.set('PRESENTN_COMPT_YN', 'Y');
    	} else {
    		formData.set('PRESENTN_COMPT_YN', '');
    	}
    	
    	$.ajax({
    		url: '/apply/indvdl-save.do',
    		type: 'POST',
    		data: formData,
    		encType: 'multipart/form-data',
    		processData: false,
    		contentType: false,
    		success: function(data) {
    			console.log(data);
    		},
    		error: function(e) {
    			console.log(e);
    		}
    	});
    }
    
    /**
     * 정보 입력 영역 스크롤을 최상단으로 이동시키는 함수.
     */
    const goToContainerTop = function() {
        document.querySelector('#apply-write').scrollTo(0, 0);
    }
    
    /**
     * 주소검색 버튼을 클릭할 때 동작하는 함수
     */
    const onAddrSearchclickHandler = function() {
    	new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                
                $('#bsns-addr').val(roadAddr);
            }
        }).open();
    }

    /**
     * 특정 단계로 이동하는 함수.
     * @param {number} lvlIdx
     */
    const moveToLvl = function(lvlIdx) {
    	setMainLvl(lvlIdx);
        setContainerDisplay(lvlIdx);
        setBotBtn(lvlIdx);
        setCurLvlId();
    }

    /**
     * 화면 하단의 버튼을 단계에 맞게 세팅하는 함수.
     * @param {number} lvlIdx
     */
    const setBotBtn = function(lvlIdx) {
        $('.btn-step-wrap').children().addClass('none');

        const lvlMax = ($('.apply-lvl-container').length) - 1 ;
        $('#save-btn').removeClass('none');
        let txt = '<strong>소상공인 사업정리 점포 철거비 지원</strong>을 신청하세요';
        if (lvlIdx === 0) {
        	// 처음 신청단계
            $('#list-btn').removeClass('none');
            $('#next-btn').removeClass('none');
            txt = '<strong>개인정보 활용</strong>에 <strong>동의</strong>해 주세요.';
        } else if (lvlIdx === lvlMax) {
        	// 마지막 신청단계
            $('#prev-btn').removeClass('none');
            $('#submit-btn').removeClass('none');
        } else {
        	// 중간 신청단계
            $('#prev-btn').removeClass('none');
            $('#next-btn').removeClass('none');
        }
        
        $('#headTxt').html(txt);
    }
})($);