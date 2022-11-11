(function($) {
    let CUR_LVL = 0; // 현재 신청 단계
    let APPLY_DATA = {};
    
    /**
     * 페이지 로딩 후 이벤트 세팅.
     */
    $(document).ready(function() {
    	init();
    });

    /**
     * 페이지 로딩 시 실행하는 함수.
     */
    const init = function() {
        eventBind();
        getIsAgree();
    }

    /**
     * 요소의 클릭(onclick), 선택(onselect) 등의 이벤트 관리.
     */
    const eventBind = function() {
        $('#list-btn').on('click', onListClickHandler);
    	$('#prev-btn').on('click', onPrevClickHandler);
    	$('#next-btn').on('click', onNextClickHandler);
        $('#save-btn').on('click', onSaveClickHandler);
        $('#submit-btn').on('click', onSubmitClickHandler);
        $('#open-date').on('click', function() { $('#open-date').siblings('img.ui-datepicker-trigger').click(); });
        $('#open-date').on('change', onDateChangeHandler);
        $('#close-date').on('click', function() { $('#close-date').siblings('img.ui-datepicker-trigger').click(); });
        $('#close-date').on('change', onDateChangeHandler);
    }
    
    /**
     * 개업일 또는 폐업일 값이 바뀌면 동작하는 함수
     */
    const onDateChangeHandler = function() {
    	if (!validDateRange()) {
    		alert('개업일이 폐업일보다 빨라야합니다.');
			$(this).val('');
    	}
    }
    
    /**
     * 개업일과 폐업일의 날짜 범위 유효성 검사
     */
    const validDateRange = function() {
    	const open = $('#open-date').val();
    	const close = $('#close-date').val();
    	
    	if (open !== '' && close !== '') {
    		const openDate = new Date(open);
    		const closeDate = new Date(close);
    		
    		if (openDate > closeDate) {
    			return false;
    		}
    	}
    	return true;
    }
    
    /**
     * 폐업일 값이 바뀌면 동작하는 함수
     */
    const onCloseDateChangeHandler = function() {
    	console.log('good2');
    }
    
    /**
     * 개인정보활용동의 여부를 확인하는 함수.
     */
    const getIsAgree = function() {
    	//TODO: ajax 통신
        const isAgree = false; //TODO: 테스트용.
    	if (isAgree) {
            moveToLvl(1);
            getApplyData();
        } else {
            moveToLvl(0);
        }
    }

    /**
     * 지원 신청 데이터를 가져오는 함수.
     */
    const getApplyData = function() {
        //TODO: ajax 통신
        setApplyData();
    }

    /**
     * 지원 신청 데이터를 세팅하는 함수.
     * @param {Object} data getApplyData로 가져온 데이터.
     */
    const setApplyData = function(data) {
        //TODO: 데이터 세팅
    }
    
    /**
     * 메인 단계를 세팅하는 함수.
     * @param {number} lvlIdx
     */
    const setMainLvl = function(lvlIdx) {
    	initLvlActive();

    	const target = $('.step-list li[data-idx="'+lvlIdx+'"]');
    	$(target).addClass('active');

        const srcStr = $(target).children('img').attr('src');
        $(target).children('img').attr('src', srcStr.replace('.png', '_on.png'));
    }
    
    /**
     * 단계의 active를 초기화함.
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
         * 신청정보 유효성 검사
         */
        const validApplyType = function() {
        	// 상호명
        	const storeName = $('#store-name').val().trim();
        	if (storeName === '' || typeof storeName === '') {
        		return {msg: '', result: false};
        	}
        	
        	// 사업자등록번호
        	const bsnsNum = $('#bsns-num').val().trim();
        	if (!BIZ_CMM.validBsnsNum(bsnsNum)) {
        		return {msg: '', result: false};
        	}
        	
        	// 개업일, 폐업일
        	const openDate = $('#open-date').val();
        	const closeDate = $('#close-date').val();
        	if (openDate === '' || typeof openDate === 'undefined') {
        		return {msg: '', result: false};
        	}
        	if (closeDate === '' || typeof closeDate === 'undefined') {
        		return {msg: '', result: false};
        	}
        	if (!validDateRange()) {
        		return {msg: '', result: false};
        	}
        	
        	// 사업장 주소
        	const storeAddr = $('#store-addr').val().trim();
        	if (storeAddr === '' || typeof storeAddr === 'undefined') {
        		return {msg: '', result: false};
        	}
        	
        	// 대표자명
        	const repName = $('#rep-name').val().trim();
        	if (repName === '' || typeof repName === 'undefined') {
        		return {msg: '', result: false};
        	}
        	
        	// 연락처
        	const tel = $('#tel').val().trim();
        	if (!/^[0-9]{2,3}[0-9]{3,4}[0-9]{4}$/.test(tel)) {
        		return {msg: '올바른 연락처를 입력하세요.', result: false};
        	}
        	
        	// 주소
        	
        	// 근로현황
        	
        	// 주민등록 등본상 가구원 수
        	
        	// 사업지원금 활용계획
        	
        	return {msg: '', result: true};
        }
        
        /**
         * 추가서류 제출 유효성 검사
         */
        const validDocSubmit = function() {
        	return {msg: '', result: true};
        }

        switch (CUR_LVL) {
            case 0: resultObj = validAgree(); break;
            case 1: resultObj = {msg: '', result: true}; break;
            case 2: resultObj = validApplyType(); break;
            case 3: resultObj = validDocSubmit(); break;
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
        if (valid(CUR_LVL)) {
            CUR_LVL === 0 ? CUR_LVL = 0 : CUR_LVL--;
            moveToLvl(CUR_LVL);
        }
    }
    
    /**
	 * 다음 버튼을 클릭할 때 동작하는 함수.
	 */
	const onNextClickHandler = function(e) {
		e.preventDefault();
        if (valid(CUR_LVL)) {
        	if ($('.apply-lvl-container[data-idx="'+(CUR_LVL+1)+'"]').length === 0) {
        		CUR_LVL = CUR_LVL+2;
        	} else {
        		CUR_LVL++;
        	}
            moveToLvl(CUR_LVL);
        }
	}

    /**
     * 임시저장 버튼을 클릭할 때 동작하는 함수.
     * @param e
     */
    const onSaveClickHandler = function(e) {
    	e.preventDefault();
        if (valid(CUR_LVL)) {
        	formSubmit();
        }
    }

    /**
     * 제출하기 버튼을 클릭할 때 동작하는 함수.
     * @param e
     */
    const onSubmitClickHandler = function(e) {
    	e.preventDefault();
        if (valid(CUR_LVL)) {
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
    	
    	if (type === 'SUBMIT') {
    		fomrData.set('PRESENTN_COMPT_YN', 'Y');
    	} else {
    		fomrData.set('PRESENTN_COMPT_YN', '');
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
    	//TODO:
    	alert('주소검색 팝업');
    }

    /**
     * 특정 단계로 이동하는 함수.
     * @param {number} lvlIdx
     */
    const moveToLvl = function(lvlIdx) {
    	setMainLvl(lvlIdx);
    	
        setContainerDisplay(lvlIdx);
        setBotBtn(lvlIdx);
    }

    /**
     * 화면 하단의 버튼을 단계에 맞게 세팅하는 함수.
     * @param {number} lvlIdx
     */
    const setBotBtn = function(lvlIdx) {
        $('.btn-step-wrap').children().addClass('none');

        if (lvlIdx === 0 || lvlIdx === 1) {
            $('#list-btn').removeClass('none');
            $('#next-btn').removeClass('none');
        } else if (lvlIdx === 2) {
        	$('#save-btn').removeClass('none');
            $('#next-btn').removeClass('none');
        } else {
            $('#prev-btn').removeClass('none');
            $('#save-btn').removeClass('none');
            $('#next-btn').removeClass('none');
        }
    }
})($);

//TODO: 레벨 이동 리팩토링 필요.