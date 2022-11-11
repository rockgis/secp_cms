<%@ page language="java" contentType="text/javascript; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
app.register.controller("detailCtrl", function($rootScope, $scope, $timeout, $window, $routeParams, $location, ajaxService, dialogService) {
	var p = $location.search();
	angular.extend($scope.param, {
		cms_menu_seq : $routeParams.cms_menu_seq,
		rows : 10,
		cpage : p.cpage||1,
		condition : p.condition||'A.TITLE',
		keyword : p.keyword||'',
		date_duration : p.date_duration||''
	});
	$scope.board = {
	};
	$scope.board.go = function(n){
		$scope.param.cpage=n;
		$scope.param.rnd = Math.random();
		$location.search($scope.param);
	};
	
	$scope.list = function(){
		$location.path("/menulist");
	}
	ajaxService.getSyncJSON('<c:url value="/super/filter/detailList.do"/>', $scope.param, function(data){
		$scope.board.list = data.list;
		$scope.board.currentPage = $scope.param.cpage;
		$scope.board.totalCount = data.pagination.totalcount;
		$scope.board.totalPage = data.pagination.totalpage;
	});
	
	$scope.excel_export = function(){
		location.href="<c:url value="/super/filter/detail_excel.do"/>?"+$.param($scope.param);
	}
});
