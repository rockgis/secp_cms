/**
 * Captcha  
 * 
 * = = = = = Example Using = = = = =
 * var captchaObj = null;
 * $(document).ready(function(){
 * 		captchaObj = $('#captcha').mcCaptcha({imageWidth : '150', imageHeight : '50', charLength : true, imageButton : '#imageButton', imageText : '재생성', soundButton : '#soundButton', soundText : '소리로 듣기'});
 * });
 * = = = = = Example Using = = = = =
 * 
 * 
 * 
 * = = = = = Form Submit Before = = = = =
 * if(captchaObj.checkload() == 'N'){
 * 	alert('The input character is not the same as Captcha.');//Captcha 불일치 메세지
 *  captchaObj.inputFocus()//Captcha Input Box로 포커스 위치
 *  captchaObj.inputInit()//Captcha Input Box Value 초기화  
 *  return;
 * }
 * = = = = = Form Submit Before = = = = =
 * 
 * - by. ost0831 -
 */
(function($) {
	var captchaImageUrl = "/captcha_image.do";
	var captchaSoundUrl = "/captcha_sound.do";
	var captchaCheckUrl = "/captcha_check.do";
	var captchaInputBox = document.createElement("INPUT");
	captchaInputBox.setAttribute("type", "text");
	captchaInputBox.setAttribute("name", "mcCaptcha");
	$(captchaInputBox).attr("id","mcCaptcha");
	$(captchaInputBox).attr("class","mcCaptchaInput");
	var imageEl = $('<div class="mcCaptchaImage">문자를 생성중입니다.</div>');
	
	var defaults = {
		imageWidth : "150",	// 이미지 넓이
	    imageHeight : "50", // 이미지 높이
	    charLength : "6", // Captcha 문자 갯수
	    controls : true, // 컨트롤러
	    imageControl : true, //이미지 재생성 컨트롤 사용유무
	    imageButton : null, // 이미지 재생성 버튼
	    imageText : "변경", // 이미지 재생성 텍스트
	    soundControl : false, //사운드 재생 컨트롤 사용유무
	    soundButton : null, // 사운드 재생 버튼
	    soundText : "재생", // 사운드 재성 텍스트
	    imageEl : null, // JQuery 제어
	    captchaInputBox : null, // JQuery 제어
	    ctr : {} // JQuery 제어
	};
	
	$.fn.mcCaptcha = function(options) {
		el = this;
		
		var o = $.extend({}, defaults, options);
		
		function init(){
			o.imageEl = imageEl;
			$(captchaInputBox).attr("maxlength", o.charLength);
			o.captchaInputBox = captchaInputBox;
			o.ctr = {};
			var imageUrl = captchaImageUrl+"?width="+o.imageWidth+"&height="+o.imageHeight+"&length="+o.charLength+"&rand="+ Math.random();
	    	$(o.imageEl).html("<img src=\""+imageUrl+"\"/>");
	    	
	    	$(el).append(o.imageEl)
			if(o.controls){appendControls()}
			$(el).append(o.captchaInputBox);
		}
		
	    var appendControls = function(){
			o.ctr.imageObj = $('<a class="mcCaptchaImageChange" href="">' + o.imageText + '</a>');
			o.ctr.soundObj = $('<a class="mcCaptchaSoundPlay" href="">' + o.soundText + '</a>');
			o.ctr.soundPalyer = $('<div style="display:none;"/>');
			
			o.ctr.imageObj.bind('click', changeCaptcha);
			o.ctr.soundObj.bind('click', audioCaptcha);
			
			if(o.imageControl){
				if(o.imageButton){
					$(o.imageButton).append(o.ctr.imageObj);
				}
			}
			if(o.soundControl){			
				if(o.soundButton){
					$(o.soundButton).append(o.ctr.soundObj);
					$(o.soundButton).append(o.ctr.soundPalyer);
				}
			}
			
			if(!o.imageButton && !o.soundButton){
				o.ctr.El = $('<div class="mcCaptcha-controls" />');
				if(o.imageControl){
					o.ctr.El.append(o.ctr.imageObj);
				}
				if(o.soundControl){
					o.ctr.El.append(o.ctr.soundObj).append(o.ctr.soundPalyer);
				}
				$(el).append(o.ctr.El);
			}
	    };
	    
	    /* 
	     * Captcha Image 요청
	     * [주의] IE의 경우 /captcha_image.do 호출시 매번 변하는 임의의 값(의미없는 값)을 파라미터로 전달하지 않으면
	     * '새로고침'버튼을 클릭해도 /captcha_image.do가 호출되지 않는다. 즉, 이미지가 변경되지 않는 문제가 발생한다. 
	     *  그러나 크롭의 경우에는 파라미터 전달 없이도 정상 호출된다.
	     */
	    var changeCaptcha = function(e){//IE에서 '새로고침'버튼을 클릭시 captcha_image.do가 호출되지 않는 문제를 해결하기 위해 "?rand='+ Math.random()" 추가
	    	e.preventDefault();
	    	var imageUrl = captchaImageUrl+"?width="+o.imageWidth+"&height="+o.imageHeight+"&length="+o.charLength+"&rand="+ Math.random();
	    	$(o.imageEl).html("<img src=\""+imageUrl+"\"/>");
	    	$(o.captchaInputBox).val("");
	    };
	    
	    var audioCaptcha = function(e){
	    	e.preventDefault();
	    	var htmlString = "";
	    	var soundUrl = captchaSoundUrl+"?rand="+ Math.random();
	    	var uAgent = navigator.userAgent.toLowerCase();
	    	if (uAgent.indexOf('trident') > -1 || uAgent.indexOf('msie') > -1) {//IE일 경우 호출
	    		htmlString += '<object type="audio/x-wav" data="'+soundUrl+'" width="0" height="0">';
	    		htmlString += '	<param name="src" value="'+soundUrl+'"/>';
	    		htmlString += '	<param name="autostart" value="true" />';
	    		htmlString += '	<param name="controller" value="false" />';
	    		htmlString += '</object>';
	    		$(o.ctr.soundPalyer).html(htmlString);
	    	}else if(uAgent.indexOf("mac os") > -1){//Apple기기에서는  현재 작동하지 않음
	    		alert("사용 중인 브라우저에서는 지원하지 않는 기능입니다.");
	    	}else{
	    		htmlString += '<audio controls autoplay style="height:0px;width:0px;" src="'+soundUrl+'" type="audio/wav"></audio>';
    			$(o.ctr.soundPalyer).html(htmlString);
	    	}
	    };
	    
	    /* Captcha Check Method */
	    el.checkload = function(){//Captcha 일치 확인 Y or N
	    	var param = {val : $(o.captchaInputBox).val()};
	    	var returnValue = "N";
			getSyncJSON(captchaCheckUrl, param, function(data){
				returnValue = data.rst;
    		});
			return returnValue;
		}
	    
	    el.inputFocus = function(){//Captcha Input Box로 포커스 위치
	    	$(o.captchaInputBox).focus();
	    }
	    
	    el.inputInit = function(){//Captcha Input Box Value 초기화
	    	$(o.captchaInputBox).val("");
	    }
	    
	    init();
	    return this;
	};
})(jQuery);