/**
 * 지원 신청 공통 함수
 * @param $ jquery
 */
const bizCmm = (function($) {
	
	/**
	 * 사업자등록번호 유효성검사.
	 * @param {string} 사업자등록번호
	 */
	const validBsnsNum = function(bsnsNum) {
		if (typeof bsnsNum === 'undefined') {
			return false;
		}
		
		const _bsnsNum = bsnsNum.trim();
		
		if(_bsnsNum.length === 10){
			var multiply = new Array(1, 3, 7, 1, 3, 7, 1, 3, 5);
			var checkSum = 0;

			for (var i = 0; i < multiply.length; ++i) {
				checkSum += multiply[i] * _bsnsNum[i];
			}

			checkSum += parseInt((multiply[8] * _bsnsNum[8]) / 10, 10);
			if(Math.floor(_bsnsNum[9]) !== ((10 - (checkSum % 10)) % 10)){
				return false;
			}
		}else{
			return false;
		}

		return true;
	}
	
	/**
	 * 전화번호 유효성검사.
	 * @param {string} 전화번호
	 */
	const validTel = function(tel) {
		const _tel = tel.trim();
		if (!/^[0-9]{2,3}[0-9]{3,4}[0-9]{4}$/.test(_tel)) {
			return false;
		}
		return true;
	}
	
	return {
		validBsnsNum: function(bsnsNum) { return validBsnsNum(bsnsNum) },
		validTel: function(tel) { return validTel(tel) }
	}
})($);

$(document).ready(function() { window['BIZ_CMM'] = bizCmm });