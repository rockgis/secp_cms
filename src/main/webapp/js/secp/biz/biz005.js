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
     * 필수 작성.
     */
    const eventBind = function() {
    	$('#bsns-addr-search').on('click', onAddrSearchclickHandler);//사업장주소
    	$('#factory-addr-search').on('click', onAddrSearchclickHandler);//공장주소    	
        $('#list-btn').on('click', onListClickHandler);
    	$('#prev-btn').on('click', onPrevClickHandler);
    	$('#next-btn').on('click', onNextClickHandler);
        $('#save-btn').on('click', onSaveClickHandler);
        $('#submit-btn').on('click', onSubmitClickHandler);       
        $(':radio[name="registerFactory"]').on('click', onRegisterClickHandler);//공장등록      
        $('#open-date').on('click', function() { $('.ui-datepicker-trigger').click() });
        $('#ptm-online').on('click', onOnlineDownloadClickHandler);//온라인 판로개척 지원 양식 다운로드
        $('#ptm-offline').on('click', onOfflineDownloadClickHandler);//오프라인 판로개척 지원 양식 다운로드
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
    	initLvlActive('SUB');
        $('.step-list2').removeClass('none');
        $('.step-list2 li:nth-child('+(lvlIdx-1)+')').addClass('active');
    }
    
    /**
     * 단계의 active를 초기화함.
     * @param {string} type MAIN 또는 SUB
     */
    const initLvlActive = function(type) {
    	if (type === 'MAIN') {
            const mainTarget = $('.step-list').children();
            $(mainTarget).removeClass('active');
            const srcStr = $(mainTarget).children('img').attr('src');
            $(mainTarget).children('img').attr('src', srcStr.replace('_on', ''));
        }

        $('.step-list2').addClass('none');
        if (type === 'SUB') {
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
        	/* 대표자 */
        	//대표자명
        	const repNm = $('#rep-name').val().trim();
        	if (repNm === '' || typeof repNm === 'undefined' || !/^[가-힣]{2,10}$/.test(repNm)) {
        		return {msg: '올바른 대표자명을 입력하세요.', result: false};
        	}
        	//성별
        	const male = $('#gender-male').prop('checked');
        	const female = $('#gender-female').prop('checked');
        	if (!male && !female) {
        		return {msg: '대표자 성별을 선택하세요.', result: false};
        	}
        	//연락처
        	const tel = $('#tel').val().trim();
        	if (!/^[0-9]{2,3}[0-9]{3,4}[0-9]{4}$/.test(tel)) {
        		return {msg: '올바른 대표자 연락처를 입력하세요.', result: false};
        	}
        	//이메일
        	const email = $('#email-id').val().trim();
        	const emailDomain = $('#email-domain').val();
        	
        	console.log(`email type ${typeof email !== "undefined"} --- null ${email !== null}
        	--- '' ${email !== ""} ---  0 ${email.length !== 0}`)
        	
        	if(email.length !== 0){ 
        		if (!/^[a-zA-z0-9._%+-]+$/.test(email)) {
            		return {msg: '올바른 대표자 이메일을 입력하세요.', result: false};
            	}
            	if (emailDomain === '' || typeof emailDomain === 'undefined') {
            		return {msg: '올바른 대표자 이메일을 선택하세요.', result: false};
            	}
        	}
        	
        	/* 신청인 */
        	//신청인명
        	const applyRepNm = $('#apply-rep-name').val().trim();
        	if (applyRepNm === '' || typeof applyRepNm === 'undefined' || !/^[가-힣]{2,10}$/.test(applyRepNm)) {
        		return {msg: '올바른 신청인명을 입력하세요.', result: false};
        	}
        	//성별
        	const applyMale = $('#apply-gender-male').prop('checked');
        	const applyFemale = $('#apply-gender-female').prop('checked');
        	if (!applyMale && !applyFemale) {
        		return {msg: '신청인 성별을 선택하세요.', result: false};
        	}
        	//연락처
        	const applyTel = $('#apply-tel').val().trim();
        	if (!/^[0-9]{2,3}[0-9]{3,4}[0-9]{4}$/.test(applyTel)) {
        		return {msg: '올바른 신청인 연락처를 입력하세요.', result: false};
        	}
        	//이메일
        	const applyEmail = $('#apply-email-id').val().trim();
        	const applyEmailDomain = $('#apply-email-domain').val();
        	if(applyEmail.length !== 0){
        		if (!/^[a-zA-z0-9._%+-]+$/.test(applyEmail)) {
            		return {msg: '올바른 신청인 이메일을 입력하세요.', result: false};
            	}
        		if (applyEmailDomain === '' || typeof applyEmailDomain === 'undefined') {
            		return {msg: '올바른 대표자 이메일을 선택하세요.', result: false};
            	}
        	}
        	
        	/* 사업자 정보 */
        	//상호명
        	const storeNm = $('#store-name').val().trim();
        	if (storeNm === '' || typeof storeNm === 'undefined') {
        		return {msg: '올바른 상호명을 입력하세요.', result: false};
        	}
        	//사업자등록번호
        	const bsnsNum = $('#bsns-num').val().trim();
        	if(!BIZ_CMM.validBsnsNum(bsnsNum)){
        		return {msg: '올바른 사업자등록번호를 입력하세요.', result: false};
        	}
        	//업태
        	const storeType = $('#store-type').val().trim();
        	if (storeType === '' || typeof storeType === 'undefined') {
        		return {msg: '올바른 업태을 입력하세요.', result: false};
        	}
        	//종목
        	const storeCate = $('#store-cate').val().trim();
        	if (storeCate === '' || typeof storeCate === 'undefined') {
        		return {msg: '올바른 종목을 입력하세요.', result: false};
        	}
        	//개업일
        	const openDate = $('#open-date').val();
        	if (!/^(?:(?:1[6-9]|[2-9]\d)?\d{2})(?:(?:(\/|-|\.)(?:0?[13578]|1[02])\1(?:31))|(?:(\/|-|\.)(?:0?[13-9]|1[0-2])\2(?:29|30)))$|^(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00)))(\/|-|\.)0?2\3(?:29)$|^(?:(?:1[6-9]|[2-9]\d)?\d{2})(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:0?[1-9]|1\d|2[0-8])$/.test(openDate)) {
        		return {msg: '올바른 개업일을 입력하세요.', result: false};
        	}
        	//정업원 수
        	const staffCnt = $('#staff-cnt').val().trim();
        	if (!/^[0-9]*$/.test(staffCnt) || staffCnt === '' || typeof staffCnt === 'undefined') {
        		return {msg: '올바른 상시 종업원 수를 입력하세요.', result: false};
        	}
        	//홈페이지
        	const homepage = $('#homepage').val().trim();
        	if(homepage.length !== 0) {               
        		if (!/(file|gopher|news|nntp|telnet|https?|ftps?|sftp):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/.test(homepage)) {
            		return {msg: '올바른 홈페이지 주소를 입력하세요.', result: false};
            	}
            }        	
        	//사업장 주소
        	const bsnsAddr = $('#bsns-addr').val().trim();
        	if (bsnsAddr === '' || typeof bsnsAddr === 'undefined') {
        		return {msg: '올바른 사업장 주소를 입력하세요.', result: false};
        	}else {
        		if(bsnsAddr.indexOf('경기도') == -1 ){
        			return {msg: '경기도 소재  사업장만 신청하실 수 있습니다 ', result: false};
        		}
        	}
        	//공장 등록
        	const regFacFalse = $('#reg-fac-false').prop('checked');
        	const regFacTrue = $('#reg-fac-true').prop('checked');
        	if (!regFacFalse && !regFacTrue) {
        		return {msg: '공장 등록 구분을 선택하세요.', result: false};
        	}
        	//공장 주소
        	if (regFacTrue) {
        		const factoryAddr = $('#factory-addr').val().trim();
        		if (factoryAddr === '' || typeof factoryAddr === 'undefined') {
            		return {msg: '올바른 공장주소를 입력하세요.', result: false};
            	}else {
            		if(factoryAddr.indexOf('경기도') == -1 ){
            			return {msg: '경기도 소재  공장주소만 신청하실 수 있습니다 ', result: false};
            		}
            	}
        	}
        	
        	return {msg: '', result: true};
        }
        
        /**
         * 추진계획서 유효성 검사
         */
        const validPushPlan = function() {  
        	const reg = new RegExp('\.(pdf|PDF)$', 'i');
        	
        	//온라인 판로개척 지원
        	let onlineFile = $('#onlineFile').val();
        	if(onlineFile === '' || typeof onlineFile === 'undefined') {                
                return {msg: '온라인 판로개척 지원관련 계획서를 업로드하세요.', result: false};
            }else{
                if(!(reg.test(onlineFile))){                       
                    return {msg: '온라인 판로개척 지원관련 계획서를 pdf파일로  업로드하세요.', result: false};
                }
            }
        	//오프라인 판로개척 지원
    		let offlineFile = $('#offlineFile').val();
    		if(offlineFile === '' || typeof offlineFile === 'undefined') {                
                return {msg: '오프라인 판로개척 지원관련 계획서를 업로드하세요.', result: false};
            }else{
                if(!(reg.test(offlineFile))){                       
                    return {msg: '오프라인 판로개척 지원관련 계획서를 pdf파일로 업로드하세요.', result: false};
                }
            }
    		
            return {msg: '', result: true};
        }

        /**
         * 증빙서류 제출 유효성검사.
         */
        const validDocSubmit = function() {  
        	const reg = new RegExp('\.(pdf|PDF)$', 'i');
        	/* 필수 서류 */
        	//사업자등록증
        	let licenseFile = $('#licenseFile').val(); 
        	if(licenseFile === '' || typeof licenseFile === 'undefined') {                
                return {msg: '사업자등록증을 업로드하세요.', result: false};
            }else{
                if(!(reg.test(licenseFile))){                       
                    return {msg: '사업자등록증을 pdf파일로 업로드하세요.', result: false};
                }
            }
        	//소상공인 확인서
        	let atmaFile = $('#atmaFile').val();
        	if(atmaFile === '' || typeof atmaFile === 'undefined') {                
                return {msg: '소상공인 확인서를 업로드하세요.', result: false};
            }else{
                if(!(reg.test(atmaFile))){                       
                    return {msg: '소상공인 확인서를 pdf파일로 업로드하세요.', result: false};
                }
            }
        	
        	/* 가점 서류*/
        	//최근 3년 간 가점 대상 수혜 사업
        	let benefitFile = $('#benefitFile').val();
        	if(benefitFile.length !== 0) {        
                if(!(reg.test(benefitFile))){                  
                    return {msg: '소상공인 청년사관학교 수료증을 pdf파일로 업로드하세요.', result: false};
                }
        	}
        	//소공인 집적지구 입점 기업
        	let launchFile = $('#launchFile').val();
        	if(launchFile.length !== 0) {               
                if(!(reg.test(launchFile))){                       
                    return {msg: '경기도 소재 공장 등록증을 pdf파일로 업로드하세요.', result: false};
                }
            }
        	//최근 2년 간 일자리 창출기업
        	let createFile = $('#createFile').val();
        	if(createFile.length !== 0) {               
                if(!(reg.test(createFile))){                       
                    return {msg: '4대 사회보험 사업장 가입자 가입명부를 pdf파일로 업로드하세요.', result: false};
                }
            }
        	//경기도 창업
        	let eduFile = $('#eduFile').val();
        	if(eduFile.length !== 0) {               
                if(!(reg.test(eduFile))){                       
                    return {msg: '경기도 자영업아카데미 수료증을 pdf파일로 업로드하세요.', result: false};
                }
            }
        	//기타 우대 서류
        	let etcFile = $('#etcFile').val();
        	if(etcFile.length !== 0) {               
                if(!(reg.test(etcFile))){                       
                    return {msg: '기타 우대 서류를 pdf파일로 업로드하세요.', result: false};
                }
            }
        	
            return {msg: '', result: true};
        }

        switch (CUR_LVL) {
        	// 기본정보 단계
	        case 0: resultObj = validAgree(); break;
            case 1: resultObj = {msg: '', result: true}; break;
            case 2: resultObj = validBasic(); break;
            case 3: resultObj = validPushPlan(); break;
            case 4: resultObj = validDocSubmit(); break;
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
        //TODO: ajax 통신
        valid(CUR_LVL);
        alert('임시저장');
    }

    /**
     * 제출하기 버튼을 클릭할 때 동작하는 함수.
     * @param e
     */
    const onSubmitClickHandler = function(e) {
        e.preventDefault();
        //TODO: ajax 통신
        valid(CUR_LVL);
        alert('제출하기');
    }
    
    /**
     * 오프라인 판로개척 지원 양식 다운로드
     */
    const onOfflineDownloadClickHandler = function() {
        //TODO: ajax 통신
        alert('오프라인 양식 다운로드');
    }
    
    /**
     * 온라인 판로개척 지원 양식 다운로드
     */
    const onOnlineDownloadClickHandler = function() {
        //TODO: ajax 통신
        alert('온라인 양식 다운로드');
    }
    
    /**
     * 공장 등록에 따른 공장주소 노출 결정하는 함수.
     */
    const onRegisterClickHandler = function() {
    	let id = $(this).attr('id');
    	let facAddr = $('.fac-addr') 
    	id.indexOf('true') == -1 ? facAddr.removeClass('on'): facAddr.addClass('on');  		
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
    	let stpIdx = $('.step-list li').length-1;
    	if (lvlIdx > 1 && lvlIdx < 4) {
        	const mainLvl = window.APPLY_TYPE === 'MYDATA' ? 2 : 1
        	setMainLvl(mainLvl);
            setSubLvl(lvlIdx);
        } else if(lvlIdx === 4){
        	setMainLvl(stpIdx);
        } else {
        	setMainLvl(lvlIdx);
        }

        setContainerDisplay(lvlIdx);
        setBotBtn(lvlIdx);
    }

    /**
     * 화면 하단의 버튼을 단계에 맞게 세팅하는 함수.
     * @param {number} lvlIdx
     */
    const setBotBtn = function(lvlIdx) {    	
        $('.btn-step-wrap').children().addClass('none');

        if (lvlIdx === 0) {
            $('#list-btn').removeClass('none');
            $('#next-btn').removeClass('none');
        } else if (lvlIdx === 1) {
        	$('#save-btn').removeClass('none');
            $('#next-btn').removeClass('none');
        } else if (lvlIdx === 4) {
        	$('#prev-btn').removeClass('none');
            $('#save-btn').removeClass('none');
            $('#submit-btn').removeClass('none')
        } else {
        	$('.btn-step-wrap').children().addClass('none');
        	if(window.APPLY_TYPE === 'MYDATA' && lvlIdx === 2){
        		$('#prev-btn').removeClass('none');
        	}else if(lvlIdx === 3){
        		$('#prev-btn').removeClass('none');
        	}
            $('#save-btn').removeClass('none');
            $('#next-btn').removeClass('none');
        }
    }
})($);

//TODO: 레벨 이동 리팩토링 필요.