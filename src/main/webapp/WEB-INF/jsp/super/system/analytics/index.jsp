<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="duf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>접속/페이지 통계</title>
<link rel="stylesheet" href="/lib/chart/angular-chart.css" />
<script type="text/javascript" src="<c:url value="/lib/js/angular.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/angular-route.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/angular-sanitize.min.js"/>"></script>
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
var app = angular.module("MyApp", ['routeResolverServices', 'dialogService', 'ngRoute', 'myUtil', 'myPagination', 'myCommon', 'ui.sortable', 'myFilter', 'ngRange', 'chart.js', 'ngSanitize']);
app.run(function($rootScope){
	$rootScope.promiseTimeout;
	$rootScope.main = {};
	$rootScope.param = {
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
	    .when('/intro', route.resolve("intro"))
	    .when('/day', route.resolve("day"))
	    .when('/time', route.resolve("time"))
	    .when('/page', route.resolve("page"))
		.otherwise({redirectTo: '/intro' });
}]);

app.controller("mainCtrl", function($scope, $timeout, $location, ajaxService, $filter) {
	//사이트리스트
	ajaxService.getSyncJSON("<c:url value="/super/member/site_list.do"/>", {}, function(data){
		$scope.main.site_list = data.site_list;
	});
	
	var angularDateFilter = $filter('myDate');
	$scope.list = function(){
		$location.path("/list");
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
		}
	});
	
	$scope.excel_down = function(){
		var params = "?start_dt="+$scope.param.start_dt+"&end_dt="+ $scope.param.end_dt;
		location.href="<c:url value="/super/analytics/execeldown.do"/>"+params;
	}
	
	$scope.openLink = function(url){
		var newWindow = window.open("about:blank");
		newWindow.location.href=url;
	}
});
</script>
</head>
<body>
	<div class="titlebar">
		<h2>접속/페이지 통계</h2>
		<div>
			<span>시스템 관리</span>&gt;<span>접속/통계</span>&gt; 
			<span class="bar_tx">접속/페이지 통계</span>
		</div>
	</div>
	<div data-ng-controller="mainCtrl">
		<div class="contents_wrap" data-ng-view data-ng-cloak></div>
	</div>
</body>
</html>