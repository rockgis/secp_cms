<%@ page language="java" contentType="text/javascript; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
app.register.controller("menulistCtrl", function($rootScope, $scope, $timeout, $window, $routeParams, $location, ajaxService, dialogService) {
	$scope.board = {};
	
	var p = $location.search();
	angular.extend($scope.param, {
		rows : 5,
		cpage : p.cpage||1,
		start_dt : p.start_dt||'',
		end_dt : p.end_dt||'',
		date_duration : p.date_duration||''
	});
	ajaxService.getSyncJSON('<c:url value="/super/filter/menulistData.do"/>', $scope.param, function(data){
		
		$scope.board.list = data.list;
		$scope.board.currentPage = $scope.param.cpage;
		$scope.board.totalCount = data.pagination.totalcount;
		$scope.board.totalPage = data.pagination.totalpage;
	});
	
	$scope.board.go = function(n){
		$scope.param.cpage=n;
		$scope.param.rnd = Math.random();
		$location.search($scope.param);
	};
	
});
