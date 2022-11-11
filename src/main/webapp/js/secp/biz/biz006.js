(function($) {
    let CUR_LVL = 0; // 현재 신청 단계
    let CUR_LVL_ID = 'agree';
    let SAVE_TYPE = 'I';
    let APPLY_TYPE = 'ONLINE';
    
    let obj = { //datepicker
    		showOn: 'button',
            buttonImage: '/images/secp/icon_calendar.png',
            buttonImageOnly: true,
            dateFormat: 'yy-mm-dd',
            prevText: '이전 달',
            nextText: '다음 달',
            monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
            monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
            dayNames: ['일','월','화','수','목','금','토'],
            dayNamesShort: ['일','월','화','수','목','금','토'],
            dayNamesMin: ['일','월','화','수','목','금','토'],
            showMonthAfterYear: true,
            changeMonth: true,
            changeYear: true,
            yearSuffix: '년',
            beforeShow: function(input, inst){
                inst.dpDiv.css({ marginLeft: input.offsetWidth - 250 + 'px'});
            }	
        }
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
        $('#list-btn').on('click', onListClickHandler);
    	$('#prev-btn').on('click', onPrevClickHandler);
    	$('#next-btn').on('click', onNextClickHandler);
        $('#save-btn').on('click', onSaveClickHandler);
        $('#submit-btn').on('click', onSubmitClickHandler);
        $('.sttuType').on('click', onEtcValueCheck); //창업분야 기타 활성화 
        $('#addr-search').on('click', onAddrSearchclickHandler); //자택주소
        $('#addrowBtn1').on('click', onRowAddBtn1); //파일 행추가1
        $('#addrowBtn2').on('click', onRowAddBtn2); //파일 행추가2
        $('#birth').on('keyup', inNumber); //숫자만 입력가능
        $('#tel').on('keyup', inNumber); //숫자만 입력가능
        
        //datepicker
        $('.datepicker').on('click', function(e) {
        	let target = e.currentTarget;
        	$(target).next().click();
        	console.log('click!!')
        	console.log(e)
        	});
        $('.datepicker').on('click', function(e) { $('#cars_date + img').click() });
        
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
//        			const isContinue = confirm('기존 신청 데이터가 있습니다. 이어서 작성하시겠습니까?');
//        			if (isContinue) {
        			if (data.rcpt_step !== '01') {
        				// 신청 단계가 아니면 모든 입력란을 readonly로 변경함.
        				setDisabled();
        			}
    				if (typeof data.rcpt_data !== 'undefined' && data.rcpt_data !== '') {
    					const json = JSON.parse(data.rcpt_data);
    					setApplyData(json);
    				}
//        			}
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
         * null 체크 확인
         * @returns  boolean
         */        
        const gIsEmpty = function(v) {
        	return (v===""||v===null||v===undefined||( v!=null && typeof v=="object" && !Object.keys(v).length))
		}
        
        /**
         * 기본정보 페이지 유효성 검사
         * @returns {{msg: string, result: boolean}}
         */
        const validBasic = function() {
        	let alert = {msg:'', result: true}; 
        	//창업 분야.
//        	const sttuType = $('.sttuType:radio:checked').length;
//        	const typeValue = $('.sttuType:checked').val();
//        	const etcDetail = $('#etc-detail').val().trim();
//        	if (sttuType < 1 ||gIsEmpty(sttuType)){
//        		return {msg: '창업분야를 선택해주세요.', result: false};
//        	}else if(typeValue == "etc" && etcDetail == "" ){
//        		return {msg: '기타 창업분야를 입력해 주세요.', result: false};
//        	}
//        	
//        	// 아이템명
//        	const itemNm = $('#item-name').val().trim();
//    		if (gIsEmpty(itemNm)) {
//        		return {msg: '올바른 아이템명을 입력하세요.', result: false};
//        	}
//        	
//        	//창업예정지 (시/군)
//        	const region = $('#region-type').val();
//        	if (gIsEmpty(region)) {
//        		return {msg: '창업예정지의 시/군을 선택하세요.', result: false};
//        	}
//        	
//        	// 성명
//        	const repNm = $('#rep-name').val().trim();
//        	if (gIsEmpty(repNm) || !/^[가-힣]+$/.test(repNm)) {
//        		return {msg: '올바른 성명을 입력하세요.', result: false};
//        	}
//        	
//        	// 생년월일 
//        	const birth = $('#birth').val().trim();
//        	const reg =/^(\d{4})(\d{1,2})(\d{1,2})$/;
//
//        	if (gIsEmpty(birth) || !reg.test(birth)) {
//        		$('#birth').focus();
//        		return {msg: '올바른 생년월일을 8자리를 입력하세요.', result: false};
//        	}else {
//        		var age = age_kor(birth);
//        		if(age > 39 || age < 20){
//        			return {msg: '주민등록등본,초본의 거주지를 기준으로 20세 이상 39세 이하여야 합니다 ', result: false};
//        		}
//        	}
//        	//이메일
//        	const email = $('#email-id').val().trim();
//        	const emailDomain = $('#email-domain').val();
//        	
//        	if(gIsEmpty(email)){
//        		return {msg: '', result: true};
//    		}else if(!/^[a-zA-z0-9._%+-]+$/.test(email)){
//        		$('#email').val("");
//        		$('#email').focus();
//        		return {msg: '올바른 이메일을 입력하세요.', result: false};
//        	}
//        	
//        	// 연락처
//        	const tel = $('#tel').val().trim();
//        	if (gIsEmpty(tel)||!/^[0-9]{2,3}[0-9]{3,4}[0-9]{4}$/.test(tel)) {
//        		return {msg: '올바른 연락처를 입력하세요.', result: false};
//        	}
//        	
//        	//자택주소
//        	const addr = $('#addr').val().trim();
//        	const sido =  $('#sido').val().trim();
//        	if (gIsEmpty(addr)) {
//        		return {msg: '자택 주소를 입력하세요.', result: false};
//        	}else{
//        		if(sido !== "경기"){
//        			return {msg: '주민등록등본,초본의 거주지를 기준으로 경기도에 거주하는 청년이어야 합니다.', result: false};
//        			}	
//        		}
//        	
//        	//경력사항 기간 start
//        	const careerList = document.querySelectorAll(".career-row"); //경력사항 테이블 tr추출
//        	
//        	//tr개수만큼 반복
//        	careerList.forEach(function(ele, idx) {
//        		const $tdInput = $(ele).find("input"); 	//tr의 input태그 찾기
//        		const $tdInputCnt = $tdInput.length;	//찾은 input태그의 길이(개수)
//        		
//        		let count = 0, sIdx = ""; 	// count - 값이 입력되었을 때마다 체크, sIdx - 값이 입력된 input의 순번 저장
//        		// 찾은 tr 안에 input 태그수 만큼 반복
//        		$tdInput.each(function(i2, e2) {
//					const sValue = $(this).val(); // 현 input 태그 값
//					// 태그 값 존재 여부 확인
//					if (!gIsEmpty(sValue)) { 
//						//태그값이 존재할때 진입
//						count++;
//					}
//				});
//        		// 한줄 input 태그를 하나라도 입력했을 경우 빈값이 있으면 안됨
//        		if (count > 0 && count < $tdInputCnt) {
//        			alert = {msg:'경력사항을 모두입력하세요.', result: false};
//        			return false;
//				}
//        		// 인풋 태그 관련 확인 부분 - tr에서 찾은 input태그 수 만큼 반복
//        		$tdInput.each(function(i2, e2) {
//        			const $target = $(this); 					// 현 input
//        			const targetVal = $(this).val(); 			// 현 input 값
//        			const targetTh = $target.attr("data-th"); 	// 현 input attr data-th
//        			// input 태그 datepicker 확인
//        			if ($target.attr("class").includes("datepicker")) {
//        				// input 태그 시작일 확인
//        				if($target.attr("class").includes("cars-date")) {
//        					//input 태그가 cars-data(=시작일) 속성을 포함할때 진입
//        					const targetVal2 =  $target.parent().find(".care-date").val(); 	// 종료일 값 추출
//        					const stDt = new Date(targetVal), edDt = new Date(targetVal2);  // 시작일 ,종료일 Date에 담기	
//        					// 시작일이 끝일 보다 큰지 확인
//        					if (stDt > edDt) {
//        						//시작일 > 종료일 일때 진입.
//        						alert = {msg:'기간을 잘못 입력했습니다.', result: false};
//        	        			return false;
//							}
//        				}
//        			}
//        		});
//        	}); //경력사항 기간 end
//        	
//        	//유사 사업 start
//        	const simbizList = document.querySelectorAll(".simbiz-row");
//        	
//        	//tr개수 만큼 반복
//        	simbizList.forEach(function(ele,idx){
//        		const $tdInput = $(ele).find('input'); 	//tr의 input태그 찾기
//        		const $tdInputCnt = $tdInput.length;	//찾은 input의 개수
//        		
//        		let cnt = 0;
//        		let stringIdx = "";
//        		$tdInput.each(function(i2, e2) {
//					const sValue = $(this).val(); // 현 input 태그 값
//					// 태그 값 존재 여부 확인
//					if (!gIsEmpty(sValue)) { 
//						//태그값이 존재할때 진입
//						cnt++;
//					}
//				});
//        		// 한줄 input 태그를 하나라도 입력했을 경우 빈값이 있으면 안됨
//        		if (cnt > 0 && cnt < $tdInputCnt) {
//        			alert = {msg:'유사사업 신청/지원여부 란을 모두입력하세요.', result: false};
//        			return false;
//				}
//        		// 인풋 태그 관련 확인 부분 - tr에서 찾은 input태그 수 만큼 반복
//        		$tdInput.each(function(i2, e2) {
//        			const $target = $(this); 					// 현 input
//        			const targetVal = $(this).val(); 			// 현 input 값
//        			const targetTh = $target.attr("data-th"); 	// 현 input attr data-th
//        			// input 태그 datepicker 확인 -날짜속성인지 확인
//        			if ($target.attr("class").includes("datepicker")) {
//        				// input 태그 날짜 속성일때 진입
//        				if($target.attr("class").includes("sims-date")) {
//        					//input 태그가 cars-data(=시작일) 속성을 포함할때 진입
//        					const targetVal2 =  $target.parent().find(".sime-date").val(); 	// 종료일 값 추출
//        					const stDt = new Date(targetVal), edDt = new Date(targetVal2);  // 시작일 ,종료일 Date에 담기	
//        					// 시작일이 끝일 보다 큰지 확인
//        					if (stDt > edDt) {
//        						//시작일 > 종료일 일때 진입.
//        						alert = {msg:'유사사업 신청/지원여부 기간을 잘못 입력했습니다.', result: false};
//        	        			return false;
//							}
//        				}
//        			}
//        		});
//        	}); //유사 사업 end

	    	return alert;
//	    	return {msg: '', result: true};
	    }
        
        /**
         * 청년사관학교 창업계획서 파일첨부 유효성 검사
         */
        const validPlan = function() {

        	const docPlan = $('#doc-plan').val();
        	var ext = docPlan.split('.').pop().toLowerCase(); //확장자분리
        	if (docPlan === '' || typeof docPlan === 'undefined') {
        		return {msg: '창업계획서를 업로드하세요.', result: false};
        	}else if($.inArray(ext, ['pdf']) == -1){
        		return {msg: "창업계획서는'pdf' 파일만 업로드 할수 있습니다.", result: false};
        	}else {
        		return {msg: '', result: true};
        	}
        }
        


        /**
         * 추가서류 제출 유효성검사.
         */
        const validDocSubmit = function() {
    	// 필수 서류
        	// 주민등록 초본
        	const docReg = $('#doc-reg').val();
        	var ext_reg = docReg.split('.').pop().toLowerCase(); //확장자분리
        	if (docReg === '' || typeof docReg === 'undefined') {
        		return {msg: '주민등록 초본을 업로드하세요.', result: false};
        	}else if($.inArray(ext_reg, ['pdf']) == -1){
        		return {msg: "주민등록 초본은'pdf' 파일만 업로드 할수 있습니다.", result: false};
        	}else {
        		return {msg: '', result: true};
        	}
        	
        	// 사실증명(총사업자등록내용)
        	const docFact = $('#doc-fact').val();
        	var ext_fact = docFact.split('.').pop().toLowerCase(); //확장자분리
        	if (docFact === '' || typeof docFact === 'undefined') {
        		return {msg: '사실증명(총사업자등록내용)을 업로드하세요.', result: false};
        	}else if($.inArray(ext_fact, ['pdf']) == -1){
        		return {msg: "사실증명(총사업자등록내용)은'pdf' 파일만 업로드 할수 있습니다.", result: false};
        	}else {
        		return {msg: '', result: true};
        	}
        	
    	// 우대사항(가점) 서류 	
        	// 조리학 관련 학위 보유
        	const docCook = $('#doc-cook').val();
        	var ext_fact = docCook.split('.').pop().toLowerCase(); //확장자분리
        	if($.inArray(ext_fact, ['pdf']) == -1){
        		return {msg: "사실증명(총사업자등록내용)은'pdf' 파일만 업로드 할수 있습니다.", result: false};
        	}else {
        		return {msg: '', result: true};
        	}
        	//창업 아이템
        	const docItem = $('#doc-item').val();
        	var ext_fact = docItem.split('.').pop().toLowerCase(); //확장자분리
        	if($.inArray(ext_fact, ['pdf']) == -1){
        		return {msg: "사실증명(총사업자등록내용)은'pdf' 파일만 업로드 할수 있습니다.", result: false};
        	}else {
        		return {msg: '', result: true};
        	}
        	//음식조리 관련 자격증 보유
        	const docFood = $('#doc-food').val();
        	var ext_fact = docFood.split('.').pop().toLowerCase(); //확장자분리
        	if($.inArray(ext_fact, ['pdf']) == -1){
        		return {msg: "사실증명(총사업자등록내용)은'pdf' 파일만 업로드 할수 있습니다.", result: false};
        	}else {
        		return {msg: '', result: true};
        	}
        	//정부/지자체 시행 음식 경진대회 입상 경력
        	const docAward = $('#doc-award').val();
        	var ext_fact = docAward.split('.').pop().toLowerCase(); //확장자분리
        	if($.inArray(ext_fact, ['pdf']) == -1){
        		return {msg: "사실증명(총사업자등록내용)은'pdf' 파일만 업로드 할수 있습니다.", result: false};
        	}else {
        		return {msg: '', result: true};
        	}
        	//기타 우대조건
        	const docEtc = $('#doc-etc').val();
        	var ext_fact = docEtc.split('.').pop().toLowerCase(); //확장자분리
        	if($.inArray(ext_fact, ['pdf']) == -1){
        		return {msg: "사실증명(총사업자등록내용)은'pdf' 파일만 업로드 할수 있습니다.", result: false};
        	}else {
        		return {msg: '', result: true};
        	}
        	
            return {msg: '', result: true};
        }

        switch (CUR_LVL_ID) {
            case 'agree': resultObj = validAgree(); break;
            case '': resultObj = {msg: '', result: true}; break;
            case 'basic': resultObj = validBasic(); break;
            case 'startUpPlan': resultObj = validPlan(); break;
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
//        if (valid(CUR_LVL_ID)) {
            CUR_LVL === 0 ? CUR_LVL = 0 : CUR_LVL--;
            moveToLvl(CUR_LVL);
//        }
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
     * form submit 제출하기.
     * @param {string} type 
     */
    const formSubmit = function(type) {
    	setCsrf();
    	const formData = new FormData($('#form')[0]);
    	
    	
    	if (type === 'SUBMIT') {
    		formData.set('PRESENTN_COMPT_YN', 'Y');
    	} else {
    		formData.set('PRESENTN_COMPT_YN', '');
    	}
    	
    	$.ajax({
//    		url: '/apply/indvdl-save.do',
    		url: '/apply/biz006/indvdl-save.do',
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
     * 특정 단계로 이동하는 함수. - 알맞은 step-list 단계를 표시해주는 함수.
     * @param {number} lvlIdx 
     */
    const moveToLvl = function(lvlIdx) {
    	const target = $('.apply-lvl-container[data-idx="'+lvlIdx+'"]');
    	const targetData = $(target).data('lvl');
    	
    	if (APPLY_TYPE === 'ONLINE') {
    		if (lvlIdx > 0 && lvlIdx < 2) {
    			setMainLvl(1);
    			
    			const subIdx = $(target).index('div.apply-lvl-container[data-lvl="sub"]');
    			setSubLvl(subIdx);
    		} else if (lvlIdx === 0) {
    			setMainLvl(0);
    		} else if (lvlIdx === 2) {
    			setMainLvl(2);
    		}
    	} else {
    		
    	}
        setContainerDisplay(lvlIdx);
        setBotBtn(lvlIdx);
        
        setCurLvlId();
    }
	/**
	 * 현재 페이지 ID 세팅
	 */
	const setCurLvlId = function() {
		CUR_LVL_ID = $('.apply-lvl-container:not(.none)').data('lvl-id');
	}
    /**
     * 화면 하단의 버튼을 단계에 맞게 세팅하는 함수.
     * @param {number} lvlIdx
     */
    const setBotBtn = function(lvlIdx) {
        $('.btn-step-wrap').children().addClass('none');
        
//        const lvlMax = ($('.apply-lvl-container').length) - 1 ;
       
        
        let txt = '<strong>청년사관학교 </strong> 지원을 신청하세요';
        if (APPLY_TYPE === 'ONLINE') {
        	if (lvlIdx === 0) {
        		// 처음 신청단계
        		$('#list-btn').removeClass('none');
        		$('#next-btn').removeClass('none');
        		txt = '<strong>개인정보 활용</strong>에 <strong>동의</strong>해 주세요.';
        	} else if (lvlIdx === 1) {
        		$('#save-btn').removeClass('none');
        		$('#next-btn').removeClass('none');

        	} else if (lvlIdx > 1 && lvlIdx < 3) {
        		$('#prev-btn').removeClass('none');
        		$('#save-btn').removeClass('none');
                $('#next-btn').removeClass('none');
        	}else {
        		// 마지막 신청단계
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
        	} else if (lvlIdx > 1 && lvlIdx < 2) {
        		$('#prev-btn').removeClass('none');
        		$('#save-btn').removeClass('none');
                $('#next-btn').removeClass('none');
        	} else {
        		$('#prev-btn').removeClass('none');
        		$('#save-btn').removeClass('none');
                $('#submit-btn').removeClass('none');
        	}
        }
        
        $('#headTxt').html(txt);
    }
    
    /**
     * 창업계획 파일 업로드
     */
    const StartUpPlanjFileUpload = function() {
    	//TODO
    }
    
    
    /** 추가서류 파일 업로드
     * 
     */
    const docFileUpload = function() {
    	//TODO
    }
    /** 기본 정보 - 테이블행 추가 함수
     * 
     */
  
    //경력사항 행추가 함수.
    const onRowAddBtn1 = function(){
    	var trCnt = $('#tbl-career tr').length;
    	var row = "";
    		row += '<tr class="career-row"><td><input type="text" class="inp datepicker careerDate cars-date career career-date" data-th="시작일" name="CSDATE" style="width: 6em;" readonly="readonly">';
    		row += '<span class="ml5 mr5" style="width: 1em;">-</span>';
    		row +='<input type="text" class="inp datepicker careerDate care-date career career-date" data-th="종료일" name="CEDATE" style="width: 6em;" readonly="readonly"></td>';
    		row += '<td><input type="text" class="inp w100p career" data-th="단체명" name="CORG"></td>';
    		row += '<td><input type="text" class="inp w100p career" data-th="관련분야" name="CTYPE"></td>';
    		row += '<td><input type="text" class="inp w100p career" data-th="상세내용" name="CCONTENT"></td>';
    		row += '<td><button type="button" class="btn btn-gray delrowbtn">-</button></td></tr>';
    		
    		$('#tbl-career > tbody').append(row);
    		$('.delrowbtn').on('click', onRowDelBtn1); //파일 행삭제1
    		
		 //동적추가 요소에 달력 호출 하기 (오늘까지)
    	    const dateObj2 = Object.assign({}, obj);
    	    dateObj2.maxDate = '+0d';
    	    $( ".careerDate").datepicker(dateObj2);
    	    
            $('.careerDate').on('click', function(e) {
            	let target = e.currentTarget;
            	$(target).next().click();
            	console.log('click!!')
            	console.log(e)
//            	$(' + img').click() 
            	});
    }
    const onRowAddBtn2 = function(){
    	var row = "";
		row = "";
		row += '<tr class="simbiz-row"><td><input type="text" class="inp w100p simbiz simbiz-name" data-th="사업명" name="SBIZNAME"></td>';
		row += '<td><input type="text" class="inp datepicker simbizDate simbiz sims-date" data-th="시작년도" name="SBIZSTART" style="width: 6em;" readonly="readonly">';
		row += '<span class="ml5 mr5" style="width: 1em;">-</span>';
		row += '<input type="text" class="inp datepicker simbizDate simbiz sime-date" data-th="종료년도" name="SBIZEND" style="width: 6em;" readonly="readonly"></td>';
		row += '<td><input type="text" class="inp w100p simbiz-org" data-th="주관기관" name="SMIZORG"></td>';
		row += '<td><button type="button" class="btn btn-gray delrowbtn2">-</button></td></tr>';
		
		$('#tbl-simbiz > tbody').append(row);
		$('.delrowbtn2').on('click', onRowDelBtn2); //파일 행삭제2
		
		//동적추가 요소에 달력 호출 하기 
	    const dateObj2 = Object.assign({}, obj);
	    dateObj2.maxDate = '+0d';
	    $( ".simbizDate").datepicker(dateObj2);
	    
        $('.simbizDate').on('click', function(e) {
        	let target = e.currentTarget;
        	$(target).next().click();
        	});
		     
    }
    /** 기본 정보 - 테이블행 삭제 함수
     * 
     */

    const onRowDelBtn1 = function(){
    	var trCnt = $('#tbl-career tr').length;
    	let btnRemove = $(".delrowbtn");
    	console.log("trCnt = "+trCnt); //TODO 삭제
    	
    	
    	if(trCnt > 2){
    		//$('#tbl-career > tbody > tr:last').remove();
    		 var trHtml = $(this).parent().parent();
    		 trHtml.remove();
    	}else if(trCnt = 2){
    		return false;
    	}
    	
    }
    const onRowDelBtn2 = function(){
    	var trCnt = $('#tbl-simbiz tr').length;
    	if(trCnt > 2){
   		 var trHtml = $(this).parent().parent();
		 trHtml.remove();
    	}else{
    		return false;
    	}
    	
    }

    /** 기본정보 창업분야 기타 클릭시 기타입력 input창 활성화 함수
     * 
     */
    const onEtcValueCheck =  function(){
    	let etc = $('.sttuType:checked').val();
    	
            if(etc == "etc") {
                $("#etc-detail").attr("disabled",false);
                $('#etc-detail').focus(); 
                
            }  else {
                $("#etc-detail").attr("disabled",true);
            }
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
                var sidoVal = data.sido;

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
                
                $('#addr').val(roadAddr);
                $('#sido').val(sidoVal);
            }
        }).open();
    }
    
    /**
     * 만나이 계산 함수
     */
    function age_kor(birth) {
    	
    	   let today = new Date(); // 오늘 날짜를 가져옴
    	   let yearNow = String(today.getFullYear()); // Date 객체의 년도를 가져옵니다.
    	   let monthNow = String(today.getMonth() + 1); // 객체의 월 정보를 가져옵니다. 1월은 0으로 표현됨을 주의해야 합니다. (0~11)
    	   let dayNow = String(today.getDate()); // Date 객체의 일자 정보를 가져옵니다. (0~31)
    	   
    	   monthNow = (monthNow < 10) ? '0' + monthNow : monthNow;
    	   dayNow = (dayNow < 10) ? '0' + dayNow : dayNow;
    	   
    	   today = Number(yearNow + monthNow + dayNow);   // 오늘날짜 숫자형으로 변환

    	   let age = Math.floor((today - birth) / 10000);  // 소수점 버림
    	   
    	   return age;
    	}
    /**
     * input 입력 제한 함수
     */    
    //숫자만 입력가능.
    function inNumber(){
    	$(this).val($(this).val().replace(/[^0-9]/g, ""));
    }	


})($);