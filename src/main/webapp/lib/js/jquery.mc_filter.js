/**
 * 필터링
 */
(function($) {
	$.fn.mcFilter = function(o, callback) {
	    o = $.extend({
	    	menu_seq : null
	    }, o || {});
	    
	    return this.each(function() {
	    	var _form = $(this);
	    	var site_id = $("meta[name='SiteID']").attr("content");

    		if(site_id==null){
    			alert("페이지의 메타태그가 빠져있습니다.<meta name=\"SiteID\" content=\"1\"/>와 같이 layout에 넣어주시기 바랍니다.");
    			return false;
    		}
    		if(o.menu_seq==null){
    			alert("페이지의 menu_seq 를 넣어주시기 바랍니다.");
    			return false;
    		}
    		getSyncJSON("/filter/check.do", $.extend({site_id: site_id, t_menu_seq : o.menu_seq}, _form.serializeObject()), function(data){
    			if(data.clean=="Y"){
					if(!!callback){
						callback(_form[0], data);
					}
    			}else{
    	        	var _deferred = $.Deferred();
    				var promise = showModal(_deferred, data);
    				promise.then(function(){
						if(!!callback){
							callback(_form[0], data);
						}
    				},function(){
    					//취소
    				});
    			}
    		});
	    	
	    	function showModal(_deferred, data){
				var list1 = new Array();
				var list2 = new Array();
				arrayConcat(data._jumin_yn, data.juminList);
				arrayConcat(data._busino_yn, data.businoList);
				arrayConcat(data._bubino_yn, data.bubinoList);
				arrayConcat(data._email_yn, data.emailList);
				arrayConcat(data._tel_yn, data.telList);
				arrayConcat(data._cell_yn, data.cellList);
				arrayConcat(data._card_yn, data.cardList);
				if($("body").find("#filterDialog").size()==0){
					$("body").append("<div id='filterDialog'></div>");
				}
		    	$("#filterDialog").load("/share/wordFailureIframe.do", {str1 : list1.join(" / "), str2 : list2.join(" / "), str3 : data.textList.join(" / ")}, function(){
		    		setTimeout(function(){
			    		$("#filterDialog").dialog({
							modal: true,
							title : '개인정보 필터',
							width: "770",
							height: "auto",
							buttons: getButton((data.textList==0 && list1.length==0), _deferred)
				    	});
		    		},200);
		    	});
			    
			    function arrayConcat(yn, dataList){
					if(dataList.length>0) {
						if(yn=="Y"){
							list1 = list1.concat(dataList);
						}else{
							list2 = list2.concat(dataList);
						}
					}
			    }
		    	return _deferred.promise();
		    }
		    
		    function getButton(flag, _deferred){
		    	var rst = [{
			        text: "닫기",
			        click: function() {
			        	_deferred.reject();
			            $(this).dialog("close");
			        }
			    }];
		    	if(flag){
		    		rst.unshift({
				        text: "계속진행",
				        click: function() {
				        	_deferred.resolve();
				            $(this).dialog("close");
				        }
				    });
		    	}
		    	
		    	return rst;
		    }
		})
	};
})(jQuery);