(function(ang, $){
	ang.module('wdFilter', [])	
	.service('wordFilterService',function($q, ajaxService, dialogService){
		this.check = function(form, menu_seq){
			var deferred = $q.defer();
			var cfrm = $.extend(true, {t_menu_seq : menu_seq}, form);
			var promise = ajaxService.getJSON("/filter/check.do", cfrm);
			
			promise.then(function(data){
				if(data.clean=="Y"){
					deferred.resolve();
				}else{
					var options = {
							autoOpen: false,
							modal: true,
							width: "770",
							height: "600",
							close: function(event, ui) {
							}
					};
					dialogService.open("wordFilterDialog", "/lib/js/partials/wordFailure.html", data, options)
					.then(
						function(result) {
							if(result=="y"){
								var p = {
									site_id : cfrm.site_id,
									cms_menu_seq : cfrm.t_menu_seq,
									jumin_cnt : data.juminList.length,
									busino_cnt : data.businoList.length,
									bubino_cnt : data.bubinoList.length,
									email_cnt : data.emailList.length,
									cell_cnt : data.cellList.length,
									tel_cnt : data.telList.length,
									card_cnt : data.cardList.length,
									jumin_conts : data.juminList.join(","),
									busino_conts : data.businoList.join(","),
									bubino_conts : data.bubinoList.join(","),
									email_conts : data.emailList.join(","),
									cell_conts : data.cellList.join(","),
									tel_conts : data.telList.join(","),
									card_conts : data.cardList.join(",")
								};
//								ajaxService.getJSON("/filter/report_record.do", p, function(){
									deferred.resolve();
//								});
							}else{
								deferred.reject();
							}
						},
						function(error) {
							deferred.reject();
						}
					);
				}
			});
			return deferred.promise;
		};
	})
	.controller("wordFailurCtrl", function($scope, dialogService) {
		var list1 = new Array();
		var list2 = new Array();
		arrayConcat($scope.model._jumin_yn, $scope.model.juminList);
		arrayConcat($scope.model._busino_yn, $scope.model.businoList);
		arrayConcat($scope.model._bubino_yn, $scope.model.bubinoList);
		arrayConcat($scope.model._email_yn, $scope.model.emailList);
		arrayConcat($scope.model._tel_yn, $scope.model.telList);
		arrayConcat($scope.model._cell_yn, $scope.model.cellList);
		arrayConcat($scope.model._card_yn, $scope.model.cardList);
		
		$scope.str1 = list1.join(" / ");
		$scope.str2 = list2.join(" / ");
		$scope.str3 = $scope.model.textList.join(" / ");
		$scope.pass = function(){
			dialogService.close("wordFilterDialog", "y");
		}
		$scope.close = function(){
			dialogService.close("wordFilterDialog", "n");
		}
	    
	    function arrayConcat(yn, dataList){
			if(dataList.length>0) {
				if(yn=="Y"){
					list1 = list1.concat(dataList);
				}else{
					list2 = list2.concat(dataList);
				}
			}
	    }
	});
})(angular, jQuery=(typeof window.jQuery=='undefined'?(function(){alert("jQuery 를 import 하세요."); return "";})():jQuery));