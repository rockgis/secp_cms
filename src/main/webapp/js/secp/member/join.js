(function($) {
	let CUR_LVL = 0;
	let JOIN_DATA = {};
	let IS_ID_CONFIRM;
	let IS_BSNS_NUM_CONFIRM;
	
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
    }

    /**
     * 요소의 클릭(onclick), 선택(onselect) 등의 이벤트 관리.
     * 필수 작성.
     */
    const eventBind = function() {
    	$('#ckAgreeAll').on('click', onCkAgreeAllClickHandler);
    	$('#next-btn').on('click', onNextClickHandler);
    	$('#join-auth-btn').on('click', onJoinAuthClickHandler);
    	$('#join-addr-btn').on('click', onJoinAddrClickHandler);
    	$('#cplt-btn').on('click', onCpltClickHandler);
    	$('#cancel-btn').on('click', onJoinCancelClickHandler);
    	$('#join-id-confirm').on('click', onJoinIdConfirmClickHandler);
    	$('#bsns-num-search-btn').on('click', onBsnsNumSearchClickHandler);
    }
    
    /**
	 * 다음 버튼을 클릭할 때 동작하는 함수.
	 */
	const onNextClickHandler = function(e) {
		e.preventDefault();
        if (valid(CUR_LVL)) {
            CUR_LVL++;
            moveToLvl(CUR_LVL);
        }
	}
	
	/**
	 * 본인 인증 버튼 클릭 시 동작하는 함수
	 */
	const onJoinAuthClickHandler = function() {
		
	}
	
	/**
	 * 주소 검색 버튼 클릭 시 동작하는 함수
	 */
	const onJoinAddrClickHandler = function() {
		alert('주소검색');
	}
	
	/**
	 * 완료 버튼 클릭 시 동작하는 함수
	 */
	const onCpltClickHandler = function(e) {
		e.preventDefault();
		if (valid(CUR_LVL)) {
            CUR_LVL++;
            moveToLvl(CUR_LVL);
        }
		alert('제출하기');
	}
	
	/**
	 * 아이디 중복확인 버튼 클릭 시 동작하는 함수
	 */
	const onJoinIdConfirmClickHandler = function() {
		alert('아이디 중복 확인');
		//TODO: 아이디 중복 확인
		IS_ID_CONFIRM = true;
	}
	
	/**
	 * 사업자번호 조회 버튼 클릭 시 동작하는 함수
	 */
	const onBsnsNumSearchClickHandler = function() {
		alert('IS_BSNS_NUM_CONFIRM = true');
		IS_BSNS_NUM_CONFIRM = true;
	}
	
	const onJoinCancelClickHandler = function(e) {
		e.preventDefault();
		const isConfirm = confirm('회원가입을 취소하고 메인으로 돌아가시겠습니까?');
		if (isConfirm) {
			window.location.href = '/';
		}
	}
	
	/**
	 * 현재 입력 페이지의 유효성 검사를 수행하는 함수.
	 */
	const valid = function(CUR_LVL) {
        let resultObj;
        
        /**
         * 개인정보 활용동의 페이지 유효성 검사
         * @returns {{msg: string, result: boolean}}
         */
        const validAgree = function() {
            const agreeEl = $('.join-lvl-container[data-idx=0] .agree-item input[type="radio"]');
            for (let i=0; i < agreeEl.length; i++) {
                if (!agreeEl[i].checked && agreeEl[i].value === 'Y') {
                    const agreeTit = $(agreeEl[i]).siblings('h3.agree-tit');
                    return {msg: '\'' + agreeTit[0].innerText + '\'에 동의해야 합니다.', result: false};
                }
            }

            return {msg: '', result: true};
        }
        
        /**
         * 본인인증 페이지 유효성 검사
         */
        const validAuth = function() {
        	return {msg: '', result: true};
        }
        
        /**
         * 정보입력 페이지 유효성 검사
         */
        const validJoinInfo = function() {
        	// 아이디
        	const joinId = $('#join-id').val().trim();
        	if (joinId === '' || typeof joinId === 'undefined') {
        		return {msg: '아이디를 입력하세요.', result: false};
        	}
        	if (!/^([a-zA-Z]|[0-9]){6,20}$/.test(joinId)) {
        		return {msg: '아이디는 공백 없는 영문자와 숫자의 조합으로 6~20자로 만들어야 합니다.', result: false};
        	}
        	
        	// 아이디 중복
        	if (typeof IS_ID_CONFIRM === 'undefined') {
        		return {msg: '아이디 중복을 확인하세요.', result: false};
        	} else if (IS_ID_CONFIRM === 'N') {
        		return {msg: '중복된 아이디로 가입할 수 없습니다.', result: false};
        	}
        	
        	// 비밀번호
        	const joinPwd = $('#join-pwd0').val().trim();
        	const joinPwdConfirm = $('#join-pwd1').val().trim();
        	if (joinPwd === '' || typeof joinPwd === 'undefined') {
        		return {msg: '비밀번호를 입력하세요.', result: false};
        	} else if (joinPwdConfirm === '' || typeof joinPwdConfirm === 'undefined') {
        		return {msg: '비밀번호 재확인을 입력하세요.', result: false};
        	} else if (joinPwd !== joinPwdConfirm) {
        		return {msg: '비밀번호와 비밀번호 재확인이 일치하지 않습니다.', result: false};
        	} else if (/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{6,20}$/.test(joinPwd)) {
        		return {msg: '비밀번호는 영문자와 숫자의 조합으로 6~20자로 만들어야 합니다.', result: false};
        	}
        	
        	// 이름
        	const joinNm = $('#join-name').val().trim();
        	if (joinNm !== '' && !/^[가-힣]+$/.test(joinNm)) {
        		return {msg: '이름을 정확히 입력하세요.', result: false};
        	}
        	
        	// 생일
        	const joinBirth = $('#join-birth').val().trim();
        	if (joinBirth === '' || typeof joinBirth === 'undefined' 
        		|| !/^((?:19[2-9]\d{1})|(?:20(?:(?:0[0-9])|(?:1[0-8]))))((?:0?[1-9])|(?:1[0-2]))((?:0?[1-9])|(?:[1-2][0-9])|30|31)$/.test(birth)) {
        		return {msg: '올바른 생년월일을 입력하세요.', result: false};
        	}
        	
        	// 이메일
        	const email = $('#join-email').val().trim();
        	const emailHost = $('#join-email-host').val().trim();
        	if (email === '' || typeof email === 'undefined' || emailHost === '') {
        		return {msg: '이메일을 입력하세요.', result: false};
        	}
        	
        	// 전화번호
        	const phone = $('#join-phone0').val() + $('#join-phone1').val().trim() + $('#join-phone2').val().trim();
        	if (!/^[0-9]{2,3}[0-9]{3,4}[0-9]{4}$/.test(phone)) {
        		return {msg: '올바른 전화번호를 입력하세요.', result: false};
        	}
        	
        	// 주소
        	const addr = $('#join-addr').val().trim();
        	if (addr === '' || typeof addr === 'undefined') {
        		return {msg: '올바른 주소를 입력하세요.', result: false};
        	}
        	
        	// 회원유형
        	const userType = $('.join-user-type[checked="true"]');
        	if (userType.length === 0) {
        		return {msg: '회원유형을 선택하세요.', result: false};
        	}
        	
        	// 관심업종
        	const storeCate = $('#store-cate0').val();
        	const storeCateDtl = $('#store-cate1').val();
        	if (storeCate === '' || storeCateDtl === '') {
        		return {msg: '관심업종을 선택하세요.', result: false};
        	}
        	
        	// 관심지역
        	const favorRegion = $('#join-favor-region').val();
        	if (favorRegion === '' || typeof favorRegion === 'undefined') {
        		return {msg: '관심지역을 선택하세요.', result: false};
        	}
        	
        	// 관심분야
        	const favorSbj = $('#join-favor-sbj[checked="true"]');
        	if (favorSbj.length === 0) {
        		return {msg: '관심분야를 한 개 이상 선택하세요.', result: false};
        	}
        	
        	// 사업자등록번호
        	const bsnsNum = $('#join-bsns-num').val().trim();
        	if (typeof IS_BSNS_NUM_CONFIRM === 'undefined' || bsnsNum === '') {
        		return {msg: '올바른 사업자등록번호를 입력하세요.', result: false};
        	}
        	
        	// 사업개시일
        	const bsnsStartDate = $('#join-bsns-start-date').val().trim();
        	if (!/^(?:(?:1[6-9]|[2-9]\d)?\d{2})(?:(?:(\/|-|\.)(?:0?[13578]|1[02])\1(?:31))|(?:(\/|-|\.)(?:0?[13-9]|1[0-2])\2(?:29|30)))$|^(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00)))(\/|-|\.)0?2\3(?:29)$|^(?:(?:1[6-9]|[2-9]\d)?\d{2})(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:0?[1-9]|1\d|2[0-8])$/.test(bsnsStartDate)) {
        		return {msg: '올바른 사업개시일을 입력하세요.', result: false};
        	}
        	
        	// 사업장 전화번호
        	const storePhone = $('#join-store-phone0').val() + $('#join-store-phone1').val().trim() + $('#join-store-phone2').val().trim();
        	if (!/^[0-9]{2,3}[0-9]{3,4}[0-9]{4}$/.test(storePhone)) {
        		return {msg: '올바른 사업장 전화번호를 입력하세요.', result: false};
        	}
        	
        	return {msg: '', result: true};
        }
        
        switch (CUR_LVL) {
	        case 0: resultObj = validAgree(); break;
	        case 1: resultObj = validAuth(); break;
	        case 2: resultObj = validJoinInfo(); break;
	    }
	
	    if (!resultObj.result) {
	        alert(resultObj.msg);
	        return false;
	    }
	
	    return true;
	}
    
    /**
     * 메인 단계를 세팅하는 함수.
     * @param {number} lvlIdx
     */
    const setMainLvl = function(lvlIdx) {
    	initLvlActive();

    	const target = $('.step-list').children()[lvlIdx];
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
     * 정보 입력 영역 스크롤을 최상단으로 이동시키는 함수.
     */
    const goToContainerTop = function() {
        document.querySelector('#apply-write').scrollTo(0, 0);
    }
    
    /**
     * 레벨 컨테이너를 표시함.
     * @param {number} lvlIdx
     */
    const setContainerDisplay = function(lvlIdx) {
        $('.join-lvl-container').addClass('none');
        $('.join-lvl-container[data-idx="'+lvlIdx+'"]').removeClass('none');

        goToContainerTop();
    }
    
    /**
     * 화면 하단의 버튼을 단계에 맞게 세팅하는 함수.
     * @param {number} lvlIdx
     */
    const setBotBtn = function(lvlIdx) {
        $('.btn-step-wrap').children().addClass('none');

        if (lvlIdx === 0 || lvlIdx === 1) {
            $('#cancel-btn').removeClass('none');
            $('#next-btn').removeClass('none');
        } else if (lvlIdx === 2) {
        	$('#cancel-btn').removeClass('none');
        	$('#cplt-btn').removeClass('none');
        } else {
        	$('#main-btn').removeClass('none');
        	$('#login-btn').removeClass('none');
        }
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
     * 모든 약관에 동의 체크를 클릭할 때 동작하는 함수.
     */
    const onCkAgreeAllClickHandler = function() {
    	if ($('#ckAgreeAll').prop('checked')) {
    		$('div[data-idx="0"] input[type="radio"][value="Y"]').prop('checked', true);
    	} else {
    		$('div[data-idx="0"] input[type="radio"][value="N"]').prop('checked', true);
    	}
    }
})($);