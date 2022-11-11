(function($) {
    let CUR_LVL = 0; // 현재 신청 단계
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
        			/*const isContinue = confirm('기존 신청 데이터가 있습니다. 이어서 작성하시겠습니까?');
        			if (isContinue) {
        				if (typeof data.rcpt_data !== 'undefined' && data.rcpt_data !== '') {
        					const json = JSON.parse(data.rcpt_data);
        					setApplyData(json);
        				}
        			}*/
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
//            const agreeEl = $('.apply-lvl-container .agree-item input[type="radio"]');
//            for (let i=0; i < agreeEl.length; i++) {
//                if (!agreeEl[i].checked && agreeEl[i].value === 'Y') {
//                    const agreeTit = $(agreeEl[i]).siblings('h3.agree-tit');
//                    console.log("next click!!!!!!!!!!!!!!");
//                    return {msg: '\'' + agreeTit[0].innerText + '\'에 동의해야 합니다.', result: false};
//                }
//            }

            return {msg: '', result: true}
        }
        
        /**
         * 명품점포 육성 지원 : 기본정보 유효성 검사
         */
        const validBasic = function(){
        	// 대표자명
//        	let repNm = $("#repNm").val().trim();
//        	if(repNm === '' || typeof repNm === 'undefined' || !/^[가-힣]+$/.test(repNm)) {
//        		return {msg: '올바른 대표자명을 입력하세요.', result: false};
//        	}
//        	
//        	// 연락처
//        	const tel = $('#tel').val().trim();
//        	if (!BIZ_CMM.validTel(tel)) {
//        		return {msg: '올바른 연락처를 입력하세요.', result: false};
//        	}
//        	
//        	// 상호명
//        	const storeNm = $('#storeNm').val().trim();
//        	if (storeNm === '' || typeof storeNm === 'undefined') {
//        		return {msg: '올바른 상호명을 입력하세요.', result: false};
//        	}
//        	
//        	// 사업자등록번호
//        	const bsnsNum = $('#bsnsNum').val().trim();
//        	if(!BIZ_CMM.validBsnsNum(bsnsNum)){
//        		return {msg: '올바른 사업자등록번호를 입력하세요.', result: false};
//        	}
//        	
//        	// 업태
//        	const storeType = $('#storeType').val().trim();
//        	if (storeType === '' || typeof storeType === 'undefined') {
//        		return {msg: '올바른 업태를 입력하세요.', result: false};
//        	}
//        	
//        	// 종목
//        	const storeType_type = $('#storeType_type').val().trim();
//        	if (storeType_type === '' || typeof storeType_type === 'undefined') {
//        		return {msg: '올바른 종목을 입력하세요.', result: false};
//        	}
//        	
//        	// 개업일
//        	const openDate = $('#openDate').val();
//        	if (!/^(?:(?:1[6-9]|[2-9]\d)?\d{2})(?:(?:(\/|-|\.)(?:0?[13578]|1[02])\1(?:31))|(?:(\/|-|\.)(?:0?[13-9]|1[0-2])\2(?:29|30)))$|^(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00)))(\/|-|\.)0?2\3(?:29)$|^(?:(?:1[6-9]|[2-9]\d)?\d{2})(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:0?[1-9]|1\d|2[0-8])$/.test(openDate)) {
//        		return {msg: '올바른 개업일을 입력하세요.', result: false};
//        	}
//        	
//        	// 세부아이템
//        	const detailItem = $('#detailItem').val().trim();
//        	if (detailItem === '' || typeof detailItem === 'undefined') {
//        		return {msg: '올바른 세부아이템을 입력하세요.', result: false};
//        	}
//        	
//        	// 소속시장명
//        	const belongMarket = $('#belongMarket').val().trim();
//        	if (belongMarket === '' || typeof belongMarket === 'undefined') {
//        		return {msg: '올바른 소속시장명을 입력하세요.', result: false};
//        	}
//        	
//        	// 사업장 주소
//        	const bsnsAddr = $('#bsnsAddr').val().trim();
//        	if (bsnsAddr === '' || typeof bsnsAddr === 'undefined') {
//        		return {msg: '올바른 사업장 주소를 입력하세요.', result: false};
//        	}
//        	
//        	// 점포형태
//        	const self = $('#self').prop('checked');
//        	const hire = $('#hire').prop('checked');
//        	if (!self && !hire) {
//        		return {msg: '점포형태를 선택하세요.', result: false};
//        	}
//        	
//        	// 점포면적 : 숫자만 입력 가능(jsp파일에 onKeyup)
//        	const storeArea = $("#storeArea").val().trim();
//        	if(storeArea === '' || typeof storeArea === 'undefined'){
//        		return {msg:'점포면적을 입력하세요.', resuult : false}
//        	}
//        	
//        	// 점포운영형태
//        	const independentStore = $('#independentStore').prop('checked');
//        	const communalStore = $('#communalStore').prop('checked');
//        	const historeInStorere = $('#historeInStorere').prop('checked');
//        	if (!independentStore && !communalStore && !historeInStorere) {
//        		return {msg: '점포운영형태를 선택하세요.', result: false};
//        	}
//        	
//        	// 상시 종업원 수
//        	const staffCnt = $('#staffCnt').val().trim();
//        	if (!/^[0-9]*$/.test(staffCnt) || staffCnt === '' || typeof staffCnt === 'undefined') {
//        		return {msg: '올바른 상시 종업원 수를 입력하세요.', result: false};
//        	}
//        	
//        	// 과표금액 : 숫자만 입력 가능(jsp파일에 onKeyup)
//        	const TaxBaseAmount1 = $("#TaxBaseAmount1").val().trim();
//        	const TaxBaseAmount2 = $("#TaxBaseAmount2").val().trim();
//        	const TaxBaseAmount3 = $("#TaxBaseAmount3").val().trim();
//        	if(TaxBaseAmount1 === '' || typeof TaxBaseAmount1 === 'undefined'){
//        		return {msg:'제작년 과세표준금액을 입력하세요.', resuult : false}
//        	}
//        	if(TaxBaseAmount2 === '' || typeof TaxBaseAmount2 === 'undefined'){
//        		return {msg:'작년 과세표준금액을 입력하세요.', resuult : false}
//        	}
//        	if(TaxBaseAmount3 === '' || typeof TaxBaseAmount3 === 'undefined'){
//        		return {msg:'올해 과세표준금액을 입력하세요.', resuult : false}
//        	}
        	return {msg: '', result: true};
        }
        
        /**
         * 명품점포 육성 지원 : 신청항목 정보 유효성 검사
         */
        const validApplicationItems = function(){
        	
        	// 신청구분
//        	const newApplication = $('#newApplication').prop('checked');
//        	const reCertification = $('#reCertification').prop('checked');
//        	if (!newApplication && !reCertification) {
//        		return {msg: '신청구분을 선택하세요.', result: false};
//        	}
//        	
//        	// 환경개선 지원항목
//            const environImproveCnt = $("input[name=environImprove]:checkbox:checked").length;
//            const environImproveEtc = $("input[id=environImproveEtc]:checkbox:checked").length;
//            const environImproveEtcInput = $("#environImproveEtcInput").val().trim();
//            if (environImproveCnt < 1) {
//              return {msg: '환경개선 지원항목 1개 이상을 선택하셔야 합니다.', result: false};
//            }else if(environImproveEtc > 0 && environImproveEtcInput === '' || typeof environImproveEtcInput === 'undefined'){
//            	return {msg: '기타를 고르셨을 경우 기타 사업지원금 활용계획을 입력 해주시기 바랍니다.', result: false};
//            }
        	return {msg: '', result: true};
        }
        
        /**
         * 명품점포 육성 지원 : 추진계획 작성 유효성 검사
         */
        const validImplementationPlans = function(){
			
        	// 맞춤형 환경개선사업 추진계획서 첨부파일
//        	const file1 = $('#file1').val().trim();
//        	if (file1 === '' || typeof file1 === 'undefined') {
//        		return {msg: '맞춤형 환경개선사업 추진계획서를 첨부해 주십시오.', result: false};
//        	}
        	return {msg: '', result: true};
        }
        
        /**
         * 명품점포 육성 지원 : 시공제작 유효성 검사
         */
        const validProductionInformation = function(){
        	/**
        	 * 간판
        	 */
        	// 시공업체명
//        	let companyNm = $("#companyNm").val().trim();
//        	if(companyNm === '' || typeof companyNm === 'undefined') {
//        		return {msg: '시공업체명을 입력하세요.', result: false};
//        	}
//        	
//        	// 사업자번호
//        	const bsnsNum2 = $('#bsnsNum2').val().trim();
//        	if(!BIZ_CMM.validBsnsNum(bsnsNum2)){
//        		return {msg: '올바른 사업자등록번호를 입력하세요.', result: false};
//        	}
//        	
//        	// 전화번호
//        	const tel2 = $('#tel2').val().trim();
//        	if (!BIZ_CMM.validTel(tel2)) {
//        		return {msg: '올바른 연락처를 입력하세요.', result: false};
//        	}
//        	
//        	// 시공(제작)내역
//        	let productionHistory = $("#productionHistory").val().trim();
//        	if(productionHistory === '' || typeof productionHistory === 'undefined') {
//        		return {msg: '시공 내역을 입력하세요.', result: false};
//        	}
//        	
//        	// 공급가
//        	const supplyPrice = $("#supplyPrice").val().trim();
//        	if(supplyPrice === '' || typeof supplyPrice === 'undefined'){
//        		return {msg:'공급가를 입력하세요.', resuult : false}
//        	}
//        	
//        	// 부가세
//        	const vat = $("#vat").val().trim();
//        	if(vat === '' || typeof vat === 'undefined'){
//        		return {msg:'부가세를 입력하세요.', resuult : false}
//        	}
//        	
//        	// 시공견적서
//        	const photoinp7 = $('#photoinp7').val().trim();
//        	if (photoinp7 === '' || typeof photoinp7 === 'undefined') {
//        		return {msg: '시공견적서를 첨부해 주십시오.', result: false};
//        	}
//        	
//        	// 사업자등록증
//        	const photoinp8 = $('#photoinp8').val().trim();
//        	if (photoinp8 === '' || typeof photoinp8 === 'undefined') {
//        		return {msg: '사업자등록증을 첨부해 주십시오.', result: false};
//        	}
        	
        	/**
        	 * 인테리어
        	 */
        	// 시공업체명
//        	let companyNm2 = $("#companyNm2").val().trim();
//        	if(companyNm2 === '' || typeof companyNm2 === 'undefined') {
//        		return {msg: '시공업체명을 입력하세요.', result: false};
//        	}
//        	
//        	// 사업자번호
//        	const bsnsNum3 = $('#bsnsNum3').val().trim();
//        	if(!BIZ_CMM.validBsnsNum(bsnsNum3)){
//        		return {msg: '올바른 사업자등록번호를 입력하세요.', result: false};
//        	}
//        	
//        	// 전화번호
//        	const tel3 = $('#tel3').val().trim();
//        	if (!BIZ_CMM.validTel(tel3)) {
//        		return {msg: '올바른 연락처를 입력하세요.', result: false};
//        	}
//        	
//        	// 시공(제작)내역
//        	let productionHistory2 = $("#productionHistory2").val().trim();
//        	if(productionHistory2 === '' || typeof productionHistory2 === 'undefined') {
//        		return {msg: '시공 내역을 입력하세요.', result: false};
//        	}
//        	
//        	// 공급가
//        	const supplyPrice2 = $("#supplyPrice2").val().trim();
//        	if(supplyPrice2 === '' || typeof supplyPrice2 === 'undefined'){
//        		return {msg:'공급가를 입력하세요.', resuult : false}
//        	}
//        	
//        	// 부가세
//        	const vat2 = $("#vat2").val().trim();
//        	if(vat2 === '' || typeof vat2 === 'undefined'){
//        		return {msg:'부가세를 입력하세요.', resuult : false}
//        	}
//        	
//        	// 시공견적서
//        	const photoinp9 = $('#photoinp9').val().trim();
//        	if (photoinp9 === '' || typeof photoinp9 === 'undefined') {
//        		return {msg: '시공견적서를 첨부해 주십시오.', result: false};
//        	}
//        	
//        	// 사업자등록증
//        	const photoinp10 = $('#photoinp10').val().trim();
//        	if (photoinp10 === '' || typeof photoinp10 === 'undefined') {
//        		return {msg: '사업자등록증을 첨부해 주십시오.', result: false};
//        	}
        	
        	return {msg: '', result: true};
        }
        
        /**
         * 명품점포 육성 지원 : 증빙서류 유효성 검사
         */
        const validDocumentaryEvidence = function(){
        	
        	// 사업자등록증
//        	const photoinp_1 = $('#photoinp_1').val().trim();
//        	if (photoinp_1 === '' || typeof photoinp_1 === 'undefined') {
//        		return {msg: '사업자등록증을 첨부해 주십시오.', result: false};
//        	}
//        	
//        	// 4대 보험 사업장 가입자명부
//        	const photoinp_2 = $('#photoinp_2').val().trim();
//        	if (photoinp_2 === '' || typeof photoinp_2 === 'undefined') {
//        		return {msg: '4대 보험 사업장 가입자명부를 첨부해 주십시오.', result: false};
//        	}
//        	
//        	// 건강보험 자격득실 확인서
//        	const photoinp_3 = $('#photoinp_3').val().trim();
//        	if (photoinp_3 === '' || typeof photoinp_3 === 'undefined') {
//        		return {msg: '건강보험 자격득실 확인서를 첨부해 주십시오.', result: false};
//        	}
//        	
//        	// 직전 3개년도 부과세과세표준증명원
//        	const photoinp_4 = $('#photoinp_4').val().trim();
//        	if (photoinp_4 === '' || typeof photoinp_4 === 'undefined') {
//        		return {msg: '직전 3개년도 부과세과세표준증명원을 첨부해 주십시오.', result: false};
//        	}
//        	
//        	// 지방세 납세증명서
//        	const photoinp_5 = $('#photoinp_5').val().trim();
//        	if (photoinp_5 === '' || typeof photoinp_5 === 'undefined') {
//        		return {msg: '지방세 납세증명서를 첨부해 주십시오.', result: false};
//        	}
//        	
//        	// (국세) 납세증명서
//        	const photoinp_6 = $('#photoinp_6').val().trim();
//        	if (photoinp_6 === '' || typeof photoinp_6 === 'undefined') {
//        		return {msg: '납세증명서를 첨부해 주십시오.', result: false};
//        	}
//        	
//        	// 심사·선정에 관한 점포대표 동의서
//        	const photoinp_7 = $('#photoinp_7').val().trim();
//        	if (photoinp_7 === '' || typeof photoinp_7 === 'undefined') {
//        		return {msg: '심사·선정에 관한 점포대표 동의서를 첨부해 주십시오.', result: false};
//        	}
//        	
//        	// 상인회 추천서
//        	const photoinp_8 = $('#photoinp_8').val().trim();
//        	if (photoinp_8 === '' || typeof photoinp_8 === 'undefined') {
//        		return {msg: '상인회 추천서를 첨부해 주십시오.', result: false};
//        	}
        	return {msg: '', result: true};
        }
        
        switch (CUR_LVL_ID) {
	        case 'agree': resultObj = validAgree(); break;
	        case '': resultObj = {msg: '', result: true}; break;
	        case 'basic': resultObj = validBasic(); break;	// 기본정보 유효성
	        case 'applicationItems': resultObj = validApplicationItems(); break;	// 신청항목 정보 유효성
	        case 'implementationPlans': resultObj = validImplementationPlans(); break;	// 추진계획 작성 유효성
	        case 'productionInformation': resultObj = validProductionInformation(); break;	// 시공제작 정보 유효성
	        case 'documentaryEvidence': resultObj = validDocumentaryEvidence(); break;	// 증빙서류 유효성
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
    		reqstRealmDtlData += $(reqstRealmDtl[i]).text().trim();
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
//    		url: '/apply/indvdl-save.do',	// orgin
    		url: '/apply/biz008/insert08.do',
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
                
                $('#bsnsAddr').val(roadAddr);
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