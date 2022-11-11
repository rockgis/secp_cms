(function(ang, $){
	ang.module('myCommon', [])	
	.service('ajaxService',function($q, $log, $http){
		this.getJSON = function(targetURL, params, callback, tracking){
			var deferred = $q.defer();

			var promise = $.ajax({
				url : targetURL, 
				type: "POST", 
				data : params, 
				dataType : "json", 
				async: true, 
				cache : false,
				success : function(data){
					deferred.resolve(data);
				}
			});
			promise.fail(this.errorProc);
			
			deferred.promise.then(function(data){
				if(!!callback){
					callback(data);
				}
			});
		
			if(!!tracking){
				deferred.promise.then(this.trackingF(tracking, params));
			}
			return deferred.promise;
		};
		this.getSyncJSON = function(targetURL, params, callback, tracking){
			var deferred = $q.defer();

			var promise = $.ajax({
				url : targetURL, 
				type: "POST", 
				data : params, 
				dataType : "json", 
				async: false, 
				cache : false,
				success : function(data){
					deferred.resolve(data);
				}
			});
			promise.fail(this.errorProc);
			promise.done(function(data){
				if(!!callback){
					callback(data);
				}
			});
		
			if(!!tracking){
				deferred.promise.then(this.trackingF(tracking, params));
			}
			return deferred.promise;
		};
		this.getJSONP = function(targetURL, params, callback, tracking){
			var deferred = $q.defer();

			var promise = $.ajax({
				url : targetURL, 
				data : params, 
				dataType : "jsonp", 
				jsonp : 'callback',
				timeout:10000,
				async: false, 
				cache : false,
				success : function(data){
					deferred.resolve(data);
				}
			});
			promise.fail(this.errorProc);
			
			deferred.promise.then(function(data){
				if(!!callback){
					callback(data);
				}
			});
		
			if(!!tracking){
				deferred.promise.then(this.trackingF(tracking, params));
			}
			return deferred.promise;
		};
		this.getXML = function(targetURL, params, callback){
			var deferred = $q.defer();

			var promise = $.ajax({
				url : targetURL, 
				type: "POST", 
				data : params, 
				dataType : "xml", 
				async: true, 
				cache : false
			});
			promise.fail(this.errorProc);
			if(!!callback){
				promise.done(function(data){
					callback(data);
				});
			}
			return promise;
		};
		//ajax에러처리
		this.errorProc = function(jqXHR, textStatus, errorThrown){
			if(jqXHR.status == 401){
				var returnURL = location.pathname + location.search;
				if(confirm("세션이 끊어졌습니다.\n로그인 후 다시 시도해 주세요.\n로그인페이지로 이동하시겠습니까?")){
					window.top.location.href = "/super/login/index.do?returnURL="+returnURL;
				}
			}else if(jqXHR.status == 403){
				var returnURL = location.pathname + location.search;
				if(confirm("새로운 사용자가 로그인하였거나, 로그아웃되었습니다.\n로그인페이지로 이동하시겠습니까?")){
					window.top.location.href = "/super/login/index.do?returnURL="+returnURL;
				}
			}else if(jqXHR.status == 404){
				alert("요청하신 페이지를 찾을수 없습니다.");
			}else{
				var msg = $.parseJSON(jqXHR.responseText);
				if("Y"==msg.debug){
					alert("=================에러코드("+jqXHR.status+")=================\n"+jqXHR.statusText+" 자세한 에러내용은 콘솔확인\n====================END====================");
					$log.error(msg.error_message);
				}else{
					alert("==============="+jqXHR.statusText+"================\n관리자에게 문의하십시오\n=====================END====================");
				}
			}
		}
		
		this.trackingF = function(job, params){
			var p = typeof(params)=="string"?params:JSON.stringify(params);
			var title = $(".titlebar>div").text().trim().replace(/\n|\t/gim, '')+":"+job;
			$.ajax({
				url : "/super/tracking.do", 
				type: "POST", 
				data : {"url":location.pathname+location.search,"title":title, "job":job, "params":p}, 
				dataType : "json", 
				async: true, 
				cache : false
			});
		}
	});
})(angular, jQuery=(typeof window.jQuery=='undefined'?(function(){alert("jQuery 를 import 하세요."); return "";})():jQuery));