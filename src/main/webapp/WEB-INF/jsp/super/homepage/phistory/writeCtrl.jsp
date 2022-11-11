<%@ page language="java" contentType="text/javascript; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
app.register.controller("writeCtrl", function($scope, $window, $routeParams, ajaxService, dialogService) {
	$scope.form = {
		gubun : $scope.param.gubun
	};

	$scope.save = function(){
		if(!confirm("저장하시겠습니까?")) return false;
		if($scope.wFrm.$invalid){
			if($scope.wFrm.$error.required){
				alert("필수값을 입력하여 주십시오.");
			}else{
				alert("값이 유효하지 않습니다.");
			}
			$("#wFrm .ng-invalid")[0].focus();
			return false;
		}
		
		ajaxService.getJSON("<c:url value="/super/phistory/write.do"/>", {jData : angular.toJson($scope.form)}, function(data){
			alert("저장되었습니다.");
			$scope.list();
		});
	}
});