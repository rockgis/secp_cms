<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>개인정보 필터링 관리</title>
<link rel="stylesheet" href="/lib/chart/angular-chart.css" />
<link rel="stylesheet" href="/lib/switch/ios-switch.css">
<link rel="stylesheet" href="/lib/css/button.css">
<script type="text/javascript" src="<c:url value="/lib/js/angular.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/angular-route.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/filters/myFilter.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/filters/ngRange.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/services/myCommon.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/services/dialog-service.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/myUtil.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/myPagination.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/sortable.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/route/routeResolver.js"/>"></script>
<script type="text/javascript" src="/lib/chart/Chart.js"></script>
<script type="text/javascript" src="/lib/chart/angular-chart.js"></script>
<script type="text/javascript">
var app = angular.module("MyApp", ['routeResolverServices', 'dialogService', 'ngRoute', 'myUtil', 'myPagination', 'myCommon', 'ui.sortable', 'myFilter', 'ngRange', 'chart.js']);
app.directive('iosSwitch', function () {
	return {
	    require: 'ngModel',
	    restrict: 'A',
	    template: '<span class="iosSwitchInner"><span class="iosSwitchHandle"></span></span>'
	};
});
app.run(function($rootScope){
	$rootScope.main = {};
	$rootScope.param = {
		site_id : '1'
	};
});
app.config(['$routeProvider', '$locationProvider', 'routeResolverProvider', '$controllerProvider', '$compileProvider', '$filterProvider', '$provide', function($routeProvider, $locationProvider, routeResolverProvider, $controllerProvider, $compileProvider, $filterProvider, $provide) {
	app.register =
    {
        controller: $controllerProvider.register,
        directive: $compileProvider.directive,
        filter: $filterProvider.register,
        factory: $provide.factory,
        service: $provide.service
    };
	var pathname = location.pathname;
	var path = pathname.substring(0, pathname.lastIndexOf("/"));
	routeResolverProvider.routeConfig.setBaseDirectories(path, path);
	
	var route = routeResolverProvider.route;
	
	$routeProvider
	    .when('/dashboard', route.resolve("dashboard"))
	    .when('/daylist', route.resolve("daylist"))
	    .when('/menulist', route.resolve("menulist"))
	    .when('/setting', route.resolve("setting"))
	    .when('/report', route.resolve("report"))
	    .when('/detail/:cms_menu_seq', route.resolve("detail"))
		.otherwise({redirectTo: '/dashboard' });
}]);

app.controller("mainCtrl", function($scope, $location, ajaxService, $filter) {
	//사이트리스트
	ajaxService.getSyncJSON("<c:url value="/super/member/site_list.do"/>", {}, function(data){
		$scope.main.site_list = data.site_list;
	});
	
	var angularDateFilter = $filter('myDate');

	$scope.allday = function(){
		$scope.param.start_dt = "";
		$scope.param.end_dt = "";
	}

	$scope.week = function(){
		var sdt = new Date().setDate(new Date().getDate() -7);
		var edt = new Date();
		$scope.param.start_dt = angularDateFilter(sdt, 'yyyy-MM-dd');
		$scope.param.end_dt = angularDateFilter(edt, 'yyyy-MM-dd');
	}
	
	$scope.half = function(){
		var sdt = new Date().setDate(new Date().getDate() -15);
		var edt = new Date();
		$scope.param.start_dt = angularDateFilter(sdt, 'yyyy-MM-dd');
		$scope.param.end_dt = angularDateFilter(edt, 'yyyy-MM-dd');
	}
	
	$scope.prevMonth = function(){
		var today = new Date();
		var sdt = new Date(today.getFullYear(), today.getMonth()-1, 1).setDate(1);
		var edt = new Date().setDate(0);
		$scope.param.start_dt = angularDateFilter(sdt, 'yyyy-MM-dd');
		$scope.param.end_dt = angularDateFilter(edt, 'yyyy-MM-dd');
	}
	
	$scope.thisMonth = function(){
		var today = new Date();
		var sdt = new Date().setDate(1);
		var edt = new Date(today.getFullYear(), today.getMonth()+1, 1).setDate(0);
		$scope.param.start_dt = angularDateFilter(sdt, 'yyyy-MM-dd');
		$scope.param.end_dt = angularDateFilter(edt, 'yyyy-MM-dd');
	}
	
	$scope.$watch("param.date_duration", function(newVal, oldVal){
		if(newVal == "1"){
			$scope.week();
		}else if(newVal == "2"){
			$scope.half();
		}else if(newVal == "3"){
			$scope.prevMonth();
		}else if(newVal == "4"){
			$scope.thisMonth();
		}else if(newVal == ""){
			$scope.allday();
		}
	});
	
	$scope.excel_down = function(){
		var params = "?start_dt="+$scope.param.start_dt+"&end_dt="+ $scope.param.end_dt;
		location.href="<c:url value="/super/analytics/execeldown.do"/>"+params;
	}
});

app.controller("eachFilterCtrl", function($rootScope, $scope, $window, $routeParams, $compile, ajaxService, dialogService, $filter) {
	$scope.board = {};
 	$scope.form = {
 		site_id : $scope.param.site_id,
		cms_menu_seq : $scope.model.cms_menu_seq,
		jumin_yn : 'N',
		email_yn : 'N',
		card_yn : 'N',
		busino_yn : 'N',
		bubino_yn : 'N',
		tel_yn : 'N',
		cell_yn : 'N'
	};
	ajaxService.getSyncJSON('<c:url value="/super/filter/get_menu_filter.do"/>', $scope.model, function(data){
		if(!!data){
			$.extend($scope.form, data);
		}
	});	
		
	$scope.setPersonalFilter = function(){
		$scope.form.filter_yn = 'N';
		$scope.form.cms_menu_seq = $scope.model.cms_menu_seq;
		ajaxService.getJSON('<c:url value="/super/filter/set_each_filter.do"/>', {jData : angular.toJson($scope.form)}, function(data){
			alert("필터설정이 완료 되었습니다.");
			dialogService.close("viewFilter");
		});
	}
	
});
</script>
</head>
<body>
	<div class="titlebar">
		<h2>개인정보 필터링 관리</h2>
		<div>
			<span>시스템 관리</span>&gt; <span>보안 설정</span>&gt;
			<span class="bar_tx">개인정보 필터링 관리</span>
		</div>
	</div>
	<div data-ng-controller="mainCtrl">
		<div class="contents_wrap" data-ng-view data-ng-cloak></div>
	</div>
	
<script type="text/ng-template" id="eachPersonalFilter.html">
<div id="dialog" title="개별필터 설정" data-ng-controller="eachFilterCtrl" data-ng-cloak>
	<table class="type1">
		<colgroup>
			<col style="width:100px;" />
			<col />
		</colgroup>
		<tr>
			<th scope="row">필터링</th>
			<td>
				<ol class="select">
					<li class="first"><label><input type="checkbox" data-ng-model="form.jumin_yn" ng-true-value="'Y'" ng-false-value="'N'"/> 주민번호</label></li>
					<li><label><input type="checkbox" data-ng-model="form.email_yn" ng-true-value="'Y'" ng-false-value="'N'"/> 이메일</label></li>
					<li><label><input type="checkbox" data-ng-model="form.card_yn" ng-true-value="'Y'" ng-false-value="'N'"/> 카드번호</label></li>
					<li><label><input type="checkbox" data-ng-model="form.busino_yn" ng-true-value="'Y'" ng-false-value="'N'"/> 사업자번호</label></li>
					<li><label><input type="checkbox" data-ng-model="form.bubino_yn" ng-true-value="'Y'" ng-false-value="'N'"/> 법인번호</label></li>
					<li><label><input type="checkbox" data-ng-model="form.tel_yn" ng-true-value="'Y'" ng-false-value="'N'"/> 전화번호</label></li>
					<li><label><input type="checkbox" data-ng-model="form.cell_yn" ng-true-value="'Y'" ng-false-value="'N'"/> 휴대전화</label></li>
				</ol>
			</td>
		</tr>
		<tr>
			<td colspan="2" class="center">
				<input type="button" data-ng-click="setPersonalFilter();" value="적용" class="btalls" style="font-size:11px;" />
			</td>
		</tr>
	</table>
</div>
</script>
</body>
</html>