(function($) {
    let CUR_LVL = 0;
    let CUR_LVL_ID = 'agree';
    let SAVE_TYPE = 'I';
    let APPLY_TYPE = 'ONLINE';
    
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
        setApplyLvlIdx();
        getIsAgree();
        setSellYear();
        setApplyType();
    }
    
    const setApplyType = function() {
    	const queryString = window.location.search;
		if (queryString !== '' && typeof queryString !== 'undefined') {
			const params = new URLSearchParams(queryString);
			APPLY_TYPE = params.get('applyType');
		}
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
        $('.apply-type').on('click', onApplyTypeChngHandler);
        $('.apply-type-dtl').on('click', onApplyTypeDtlChngHandler)
        $('#open-date').on('click', function() { $('.ui-datepicker-trigger').click() });
        $('.cnstrt-price').on('focusout', onCnstrtPriceFocusoutHandler);
    }
    
    /**
     * 시공계획의 공급가, 부가세에 입력할 때 동작하는 함수.
     */
    const onCnstrtPriceFocusoutHandler = function(e) {
    	const idx = $(this).data('idx');
    	
    	if ( !/^([0-9].*|)$/.test($(this).val().trim()) ) {
    		alert('숫자만 입력할 수 있습니다.');
    		$(this).val('');
    		return;
    	}
    	
    	let total = parseInt($('#cnstrt'+idx+'-pymt').val()) + parseInt($('#cnstrt'+idx+'-tax').val());
    	
    	if (isNaN(total)) {
    		total = 0;
    	}
    	
    	$('#cnstrt'+idx+'-pymt-total').val(total);
    }
    
    /**
     * 매출정보 과세구분 연도 세팅
     */
    const setSellYear = function() {
    	const today = new Date();
    	const year = today.getFullYear();
    	$('#sell-type0').text(year);
    	$('#sell-type1').text(year-1);
    }
    
    /**
     * 모든 input, select를 disabled로 변경. 
     */
    const setDisabled = function() {
    	$('input').prop('readonly', true);
    	$('select').prop('readonly', true);
    	$('textarea').prop('readonly', true);
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
        			SAVE_TYPE='U';
        			if (data.rcpt_step !== '01') {
        				// 신청 단계가 아니면 모든 입력란을 readonly로 변경함.
        				setDisabled();
        			}
        			if (typeof data.rcpt_data !== 'undefined' && data.rcpt_data !== '') {
    					const json = JSON.parse(data.rcpt_data);
    					setApplyData(json);
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
    	initLvlActive('MAIN');
    	
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
     * 서브 단계를 세팅하는 함수.
     * @param {number} lvlIdx
     */
    const setSubLvl = function(lvlIdx) {
    	const mainId = $('.step-list2').data('main-id');
        setMainLvl($('#'+mainId).index());
    	
    	initLvlActive('SUB');
        $('.step-list2').removeClass('none');
        $('.step-list2 li').eq(lvlIdx).addClass('active');
    }
    
    /**
     * 단계의 active를 초기화함.
     * @param {string} type MAIN 또는 SUB
     */
    const initLvlActive = function(type) {
        if (type === 'MAIN') {
        	$('.step-list2').addClass('none');
            const mainTarget = $('.step-list').children();
            $(mainTarget).removeClass('active');
            const srcStr = $(mainTarget).children('img').attr('src');
            $(mainTarget).children('img').attr('src', srcStr.replace('_on', ''));
        }
        
        if (type === 'SUB') {
        	$('.step-list2').addClass('none');
            const subTarget = $('.step-list2').children();
            $(subTarget).removeClass('active');
        }
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
    const valid = function(CUR_LVL_ID) {
        let resultObj;

        /**
         * 개인정보 활용동의 페이지 유효성 검사
         * @returns {{msg: string, result: boolean}}
         */
        const validAgree = function() {
            const agreeEl = $('.apply-lvl-container .agree-item input[type="radio"]');
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
        	
        	// 생년월일
        	const birth = $('#birth').val().trim();
        	if (birth === '' || typeof birth === 'undefined' 
        		|| !/^((?:19[2-9]\d{1})|(?:20(?:(?:0[0-9])|(?:1[0-8]))))((?:0?[1-9])|(?:1[0-2]))((?:0?[1-9])|(?:[1-2][0-9])|30|31)$/.test(birth)) {
        		return {msg: '올바른 생년월일을 입력하세요.', result: false};
        	}
        	
        	// 성별
        	const male = $('#gender-male').prop('checked');
        	const female = $('#gender-female').prop('checked');
        	if (!male && !female) {
        		return {msg: '성별을 선택하세요.', result: false};
        	}
        	
        	// 연락처
        	const tel = $('#tel').val().trim();
        	if (!BIZ_CMM.validTel(tel)) {
        		return {msg: '올바른 연락처를 입력하세요.', result: false};
        	}
        	
        	// 상호명
        	const storeNm = $('#store-name').val().trim();
        	if (storeNm === '' || typeof storeNm === 'undefined') {
        		return {msg: '올바른 상호명을 입력하세요.', result: false};
        	}
        	
        	// 사업자등록번호
        	const bsnsNum = $('#bsns-num').val().trim();
        	if(!BIZ_CMM.validBsnsNum(bsnsNum)){
        		return {msg: '올바른 사업자등록번호를 입력하세요.', result: false};
        	}
        	
        	// 사업장 주소
        	const bsnsAddr = $('#bsns-addr').val().trim();
        	if (bsnsAddr === '' || typeof bsnsAddr === 'undefined') {
        		return {msg: '올바른 사업장 주소를 입력하세요.', result: false};
        	}
        	
        	// 과세유형
        	const taxType = $('#tax-type').val();
        	if (taxType === '' || typeof taxType === 'undefined') {
        		return {msg: '올바른 과세유형을 선택하세요.', result: false};
        	}
        	
        	// 업종
        	const storeCate = $('#store-cate').val().trim();
        	if (storeCate === '' || typeof storeCate === 'undefined') {
        		return {msg: '올바른 업종을 입력하세요.', result: false};
        	}
        	
        	// 업태
        	const storeType = $('#store-type').val().trim();
        	if (storeType === '' || typeof storeType === 'undefined') {
        		return {msg: '올바른 업태를 입력하세요.', result: false};
        	}
        	
        	// 개업일
        	const openDate = $('#open-date').val();
        	if (!/^(?:(?:1[6-9]|[2-9]\d)?\d{2})(?:(?:(\/|-|\.)(?:0?[13578]|1[02])\1(?:31))|(?:(\/|-|\.)(?:0?[13-9]|1[0-2])\2(?:29|30)))$|^(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00)))(\/|-|\.)0?2\3(?:29)$|^(?:(?:1[6-9]|[2-9]\d)?\d{2})(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:0?[1-9]|1\d|2[0-8])$/.test(openDate)) {
        		return {msg: '올바른 개업일을 입력하세요.', result: false};
        	}
        	
        	// 상시 종업원 수
        	const staffCnt = $('#staff-cnt').val().trim();
        	if (!/^[0-9]*$/.test(staffCnt)) {
        		return {msg: '올바른 상시 종업원 수를 입력하세요.', result: false};
        	}
        	
        	// 과세금액1
        	const tax0 = $('#tax0').val().trim();
        	if (tax0 === '' || typeof tax0 === 'undefined') {
        		return {msg: '올바른 과세금액을 입력하세요.', result: false};
        	}
        	
        	// 과세금액2
        	const tax1 = $('#tax1').val().trim();
        	if (tax1 === '' || typeof tax1 === 'undefined') {
        		return {msg: '올바른 과세금액을 입력하세요.', result: false};
        	}
        	
        	// 매출기간1
        	const sellDate0 = $('#sell-date0').val().trim();
        	if (!(sellDate0 === '')) {
        		let sellDate = sellDate0.split('~');
        		if(sellDate[0] !== '' && sellDate[1] !== ''){
        			if (!/^(?:(?:1[6-9]|[2-9]\d)?\d{2})(?:(?:(\/|-|\.)(?:0?[13578]|1[02])\1(?:31))|(?:(\/|-|\.)(?:0?[13-9]|1[0-2])\2(?:29|30)))$|^(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00)))(\/|-|\.)0?2\3(?:29)$|^(?:(?:1[6-9]|[2-9]\d)?\d{2})(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:0?[1-9]|1\d|2[0-8])$/.test(sellDate[0])) {
            			return {msg: '올바른 매출기간을 입력하세요.', result: false};
            		}
        			if (!/^(?:(?:1[6-9]|[2-9]\d)?\d{2})(?:(?:(\/|-|\.)(?:0?[13578]|1[02])\1(?:31))|(?:(\/|-|\.)(?:0?[13-9]|1[0-2])\2(?:29|30)))$|^(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00)))(\/|-|\.)0?2\3(?:29)$|^(?:(?:1[6-9]|[2-9]\d)?\d{2})(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:0?[1-9]|1\d|2[0-8])$/.test(sellDate[1])) {
        				return {msg: '올바른 매출기간을 입력하세요.', result: false};
            		}
        		}else{
        			return {msg: '올바른 매출기간을 입력하세요.', result: false};
        		}
        	}
        	
        	// 매출기간2
        	const sellDate1 = $('#sell-date1').val().trim();
        	if (!(sellDate1 === '')) {
    			if (!/^(?:(?:1[6-9]|[2-9]\d)?\d{2})(?:(?:(\/|-|\.)(?:0?[13578]|1[02])\1(?:31))|(?:(\/|-|\.)(?:0?[13-9]|1[0-2])\2(?:29|30)))$|^(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00)))(\/|-|\.)0?2\3(?:29)$|^(?:(?:1[6-9]|[2-9]\d)?\d{2})(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:0?[1-9]|1\d|2[0-8])$/.test(sellDate1)) {
        			return {msg: '올바른 매출기간을 입력하세요.', result: false};
        		}
        	}
        	
        	return {msg: '', result: true};
        }
        
        /**
         * 신청분야 유효성 검사
         */
        const validApplyType = function() {
        	const selectedGrp = $('.apply-type:checked').data('grp');
        	const dtlChk = $('.apply-type-dtl:checked[data-grp="'+selectedGrp+'"]');
        	if (dtlChk.length > 2 || dtlChk.length === 0) {
        		return {msg: '세부분야는 최소 1개, 최대 2개까지 선택할 수 있습니다.', result: false};
        	}
        	
        	return {msg: '', result: true};
        }
        
        /**
         * 추진계획 작성 유효성 검사
         */
        const validBizPlan = function() {
        	const bizPlan = $('#biz-plan').val().trim();
        	if (bizPlan === '' || typeof bizPlan === 'undefined') {
        		return {msg: '사업추진 계획을 입력하세요.', result: false};
        	}
        	
        	const picInside = $('#store-inside').get(0).files.length;
        	const picOutside = $('#store-outside').get(0).files.length;
        	if (picInside === 0 || picOutside === 0) {
        		return {msg: '사업장 현황 사진을 모두 업로드하세요.', result: false};
        	}
        	
        	let fixCnt = 0;
        	const imprvFiles = $('.imprv-file');
        	for (let i=0; i < imprvFiles.length; i++) {
        		if (imprvFiles[i].files.length == 1) {
        			let imprvName = imprvFiles[i].name;
        			let num = imprvName.substr(imprvName.length-1);
        			let txt = $('textarea[name="IMPRVM_CN_'+num+'"]').val().trim();
        			if (txt === '') {
        				return {msg: '모든 사진에 설명을 작성해주세요.', result: false};
        			}
        			fixCnt++;
        		}
        	}
        	if (fixCnt < 3) {
        		return {msg: '개선할 부분의 사진이 최소 3장 이상 필요합니다.', result: false};
        	}
        	

            return {msg: '', result: true};
        }
        
        /**
         * 시공계획 정보 유효성 검사
         */
        const validCnstrtPlan = function() {
            for (let i=0; i < 2; i++) {
            	// 시공업체명
                let cnstrtNm = $('#cnstrt' + i + '-name').val();
                if (cnstrtNm === '' || typeof cnstrtNm === 'undefined') {
                    return {msg: (i+1) + ' 번 시공업체명을 정확히 입력하세요.', result: false};
                }

                // 사업자번호
                let cnstrtBsnsNum = $('#cnstrt' + i + '-bsns-num').val();
                if (cnstrtBsnsNum === '' || typeof cnstrtBsnsNum === 'undefined' || !BIZ_CMM.validBsnsNum(cnstrtBsnsNum)) {
                    return {msg: (i+1) + ' 번 사업자번호를 정확히 입력하세요.', result: false};
                }

                // 전화번호
                let cnstrtTel = $('#cnstrt' + i + '-tel').val();
                if (!BIZ_CMM.validTel(cnstrtTel)) {
                    return {msg: (i+1) + ' 번 전화번호를 정확히 입력하세요.', result: false};
                }

                // 시공내역
                let cnstrtWork = $('#cnstrt' + i + '-work').val();
                if (cnstrtWork === '' || typeof cnstrtWork === 'undefined') {
                    return {msg: (i+1) + ' 번 시공내역을 정확히 입력하세요.', result: false};
                }

                // 공급가
                let cnstrtPymt = $('#cnstrt' + i + '-pymt').val();
                if (cnstrtPymt === '' || typeof cnstrtPymt === 'undefined' || !/[0-9].*/g.test(cnstrtPymt)) {
                    return {msg: (i+1) + ' 번 공급가를 정확히 입력하세요.', result: false};
                }

                // 부가세
                let cnstrtTax = $('#cnstrt' + i + '-tax').val();
                if (cnstrtTax === '' || typeof cnstrtTax === 'undefined' || !/[0-9].*/g.test(cnstrtTax)) {
                    return {msg: (i+1) + ' 번 부가세를 정확히 입력하세요.', result: false};
                }

                // 시공견적서
                let cnstrtEstimt = $('#cnstrt' + i + '-estimt').val();
                if (cnstrtEstimt === '' || typeof cnstrtEstimt === 'undefined') {
                    return {msg: (i+1) + ' 번 시공견적서를 업로드하세요.', result: false};
                }
            }

            return {msg: '', result: true};
        }

        /**
         * 증빙서류 제출 유효성검사.
         */
        const validDocSubmit = function() {
        	// 사업자등록증
        	const docBsns = $('#doc-bsns').val();
        	if (docBsns === '' || typeof docBsns === 'undefined') {
        		return {msg: '사업자등록증을 업로드하세요.', result: false};
        	}
        	
        	// 부가가치세 과세표준증명원
        	const docTaxStd = $('#doc-tax-std').val();
        	if (docTaxStd === '' || typeof docTaxStd === 'undefined') {
        		return {msg: '부가가치세 과세표준증명원을 업로드하세요.', result: false};
        	}
        	
        	// 법인 증빙 추가서류
        	const docCorp = $('#doc-corp').val();
        	if (docCorp === '' || typeof docCorp === 'undefined') {
        		return {msg: '법인 증빙 추가서류를 업로드하세요.', result: false};
        	}
        	
            return {msg: '', result: true};
        }

        switch (CUR_LVL_ID) {
            case 'agree': resultObj = validAgree(); break;
            case '': resultObj = {msg: '', result: true}; break;
            case 'basic': resultObj = validBasic(); break;
            case 'reqstRealm': resultObj = validApplyType(); break;
            case 'prtnPlan': resultObj = validBizPlan(); break;
            case 'cnstrct': resultObj = validCnstrtPlan(); break;
            case 'doc': resultObj = validDocSubmit(); break;
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
        formSubmit();
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
    	
    	const reqstRealmDtl = $('.apply-type-dtl:checked');
    	let reqstRealmDtlData = '';
    	for (let i=0; i < reqstRealmDtl.length; i++) {
    		reqstRealmDtlData += $(reqstRealmDtl[i]).parent().text().trim();
    		if (i !== length) {
    			reqstRealmDtlData += ',';
    		}
    	}
    	formData.set('REQST_REALM_DTL', reqstRealmDtlData);
    	
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
     * 신청분야를 선택할 때 동작하는 함수.
     */
    const onApplyTypeChngHandler = function(e) {
    	// 모든 세부분야 초기화
    	$('.apply-type-dtl').prop('checked', false);
    	$('.apply-type-dtl').prop('disabled', true);
    	
    	// 선택한 신청분야의 세부분야만 활성화
    	const selectedGrp = $('.apply-type:checked').data('grp');
    	$('.apply-type-dtl[data-grp="'+selectedGrp+'"]').prop('disabled', false);
    }
    
    const onApplyTypeDtlChngHandler = function(e) {
    	const selectedGrp = $('.apply-type:checked').data('grp');
    	const chkCnt = $('.apply-type-dtl:checked[data-grp="'+selectedGrp+'"]').length;
    	if (chkCnt > 2) {
    		alert('세부분야는 최대 2개까지 선택할 수 있습니다.');
    		$(this).prop('checked', false);
    	}
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
    	const target = $('.apply-lvl-container[data-idx="'+lvlIdx+'"]');
    	const targetData = $(target).data('lvl');
    	
    	if (APPLY_TYPE === 'ONLINE') {
    		if (lvlIdx > 0 && lvlIdx < 5) {
    			setMainLvl(1);
    			
    			const subIdx = $(target).index('div.apply-lvl-container[data-lvl="sub"]');
    			setSubLvl(subIdx);
    		} else if (lvlIdx === 0) {
    			setMainLvl(0);
    		} else if (lvlIdx === 5) {
    			setMainLvl(2);
    		}
    	} else {
    		
    	}
    	
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
        
        if (APPLY_TYPE === 'ONLINE') {
        	if (lvlIdx === 0) {
        		$('#list-btn').removeClass('none');
        		$('#next-btn').removeClass('none');
        	} else if (lvlIdx === 1) {
        		$('#save-btn').removeClass('none');
                $('#next-btn').removeClass('none');
        	} else if (lvlIdx > 1 && lvlIdx < 5) {
        		$('#prev-btn').removeClass('none');
        		$('#save-btn').removeClass('none');
                $('#next-btn').removeClass('none');
        	} else {
        		$('#prev-btn').removeClass('none');
        		$('#save-btn').removeClass('none');
                $('#submit-btn').removeClass('none');
        	}
        } else {
        	if (lvlIdx === 0) {
        		$('#list-btn').removeClass('none');
        		$('#next-btn').removeClass('none');
        	} else if (lvlIdx === 1) {
        		$('#save-btn').removeClass('none');
                $('#next-btn').removeClass('none');
        	} else if (lvlIdx > 1 && lvlIdx < 5) {
        		$('#prev-btn').removeClass('none');
        		$('#save-btn').removeClass('none');
                $('#next-btn').removeClass('none');
        	} else {
        		$('#prev-btn').removeClass('none');
        		$('#save-btn').removeClass('none');
                $('#submit-btn').removeClass('none');
        	}
        }
    }
})($);