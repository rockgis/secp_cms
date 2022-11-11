<%@ page language="java" contentType="text/javascript; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf" %>
app.register.controller("listCtrl", function($rootScope, $scope, $timeout, $window, $routeParams, $location, ajaxService, dialogService) {
	$scope.board = {};
	
	var p = $location.search();
	angular.extend($scope.param, {
		rows : p.rows||'10',
		cpage : p.cpage||1,
		start_dt : p.start_dt||'',
		end_dt : p.end_dt||'',
		condition : p.condition||'TITLE',
		keyword : p.keyword||''
	});
	
	ajaxService.getJSON('<c:url value="/super/satisfaction/list.do"/>', $scope.param, function(data){
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

	$scope.excel_down = function(){
		location.replace("<c:url value="/super/satisfaction/execeldown.do"/>?"+$.param($scope.param));
	};
	
	$scope.openEtc = function(item){
		var options = {
				title : '만족도 의견보기',
				autoOpen: false,
				modal: true,
				width: "650",
				height: "auto",
				close: function(event, ui) {
				}
			};
		
		dialogService.open("EtcDialog", "/st_exclude/super/system/satisfaction/etc.do", item, options)
		.then(
			function(result) {
			},
			function(error) {
			}
		);
	}
	$scope.openResult = function(item){
		var options = {
				title : '결과보기',
				autoOpen: false,
				modal: true,
				width: "650",
				height: "auto",
				close: function(event, ui) {
				}
			};
		
		dialogService.open("ResultDialog", "/st_exclude/super/system/satisfaction/result.do", item, options)
		.then(
			function(result) {
			},
			function(error) {
			}
		);
	}
});

app.register.controller("etcCtrl", function($scope, $timeout, $window, $routeParams, $location, ajaxService, dialogService) {
	$scope.param = {
		rows : 10,
		cpage : 1,
		cms_menu_seq : $scope.model.cms_menu_seq
	};
	$scope.etc = {};
	
	$scope.etc.go = function(n){
		$scope.param.cpage = n;
		ajaxService.getJSON('<c:url value="/super/satisfaction/etclist.do"/>', $scope.param, function(data){
			$scope.etc.list = data.list;
			$scope.etc.currentPage = $scope.param.cpage;
			$scope.etc.totalCount = data.pagination.totalcount;
			$scope.etc.totalPage = data.pagination.totalpage;
		});
	};
	$scope.etc.go(1);
	
	$scope.close = function(){
		dialogService.close("EtcDialog");
	}
});

app.register.controller("resultCtrl", function($scope, $timeout, $window, $routeParams, $location, ajaxService, dialogService) {
	$scope.param = {
		rows : 10,
		cpage : 1,
		cms_menu_seq : $scope.model.cms_menu_seq
	};
	$scope.result = {};
	$scope.result.go = function(n){
		$scope.param.cpage = n;
		ajaxService.getJSON('<c:url value="/super/satisfaction/result.do"/>', $scope.param, function(data){
			$scope.result.list = data.list;
			$scope.result.currentPage = $scope.param.cpage;
			$scope.result.totalCount = data.pagination.totalcount;
			$scope.result.totalPage = data.pagination.totalpage;
		});
	};
	$scope.result.go(1);
	
	$scope.close = function(){
		dialogService.close("ResultDialog");
	}

	$scope.excel_down = function(){
		location.replace("<c:url value="/super/satisfaction/detail_execeldown.do"/>?cms_menu_seq="+$scope.model.cms_menu_seq);
	};
});