<%@ page language="java" contentType="text/javascript; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
app.register.controller("modifyCtrl", function($rootScope, $scope, $timeout, $window, $routeParams, $location, ajaxService, dialogService) {
	ajaxService.getJSON("/super/site/view.do", $scope.param, function(data){
		$scope.form = data.view;
	});
	
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
		ajaxService.getJSON("/super/site/modify.do", {jData : angular.toJson($scope.form)}, function(data){
			alert("정상처리 되었습니다.");
			location.reload();
		});
	}
});
