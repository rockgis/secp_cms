<%@ page language="java" contentType="text/javascript; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
app.register.controller("modifyCtrl", function($rootScope, $scope, $timeout, $window, $routeParams, $location, ajaxService, dialogService) {
	$scope.form = {
		items : []
	};
	ajaxService.getJSON("/super/site/layout_setting/list.do", $scope.param, function(data){
		$scope.form.items = $.map(data.list, function(o){
			return $.extend(o, {uid : Math.random()});
		});;
	});
	
	$scope.$on("modifyComponent", function(event, idx){
		var options = {
				autoOpen: false,
				modal: true,
				width: "1000",
				height: "350",
				close: function(event, ui) {}
			};
			dialogService.open("ComponentDialog","Component.html", $scope.form.items[idx], options).then(
				function(result) {
					$scope.form.items[idx] = result;
				},
				function(error) {}
			);
	});
	
    $scope.openComponent = function(){
		var options = {
			autoOpen: false,
			modal: true,
			width: "1000",
			height: "350",
			close: function(event, ui) {}
		};
			
		dialogService.open("ComponentDialog","Component.html", {}, options).then(
			function(result) {
				$scope.addComponent(result);
			},
			function(error) {}
		);
    }
	
	$scope.addComponent = function(item){
		item.uid = Math.random();
		$scope.form.items.push(item);
	}
	
	$scope.save = function(){
		if($scope.wFrm.$invalid){
			if($scope.wFrm.$error.required){
				alert("필수값을 입력하여 주십시오.");
			}else{
				alert("값이 유효하지 않습니다.");
			}
			$("#wFrm .ng-invalid")[0].focus();
			return false;
		}
		 
		//$scope.form.items.sort(function(a,b){return a.idx-b.idx});
		if(!confirm("저장하시겠습니까?")){
			return false;
		}
		$.extend($scope.form, {site_id:$scope.param.site_id});
		ajaxService.getJSON("/super/site/layout_setting/modify.do", {jData : angular.toJson($scope.form)}, function(data){
			alert("정상처리 되었습니다.");
		});
	}
});

