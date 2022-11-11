<%@ page language="java" contentType="text/javascript; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
app.register.controller("modifyCtrl", function($rootScope, $scope, $timeout, $window, $routeParams, $location, ajaxService, dialogService) {
	
	$scope.clearCache = function(){
		if(!confirm("캐시를 비우시겠습니까?")) return false;
		ajaxService.getJSON("/super/site/basic_setting/clear_chche.do", {}, function(data){
			if(data.rst=="1"){
				alert("캐시가 정상적으로 비워졌습니다.")
			}
		});
	};
});
