<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>실시간 접속자 현황</title>
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
<script type="text/javascript">
var app = angular.module("MyApp", ['routeResolverServices', 'dialogService', 'ngRoute', 'myUtil', 'myPagination', 'myCommon', 'ui.sortable', 'myFilter', 'ngRange']);
app.run(function($rootScope){
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
	    .when('/list', route.resolve("list"))
		.otherwise({redirectTo: '/list' });
}]);

app.controller("mainCtrl", function($scope, $location, ajaxService) {
	$scope.list = function(){
		$location.path("/list");
	}
});
</script>
</head>
<body>
	<div class="titlebar">
		<h2>실시간 접속자 현황</h2>
		<div>
			<span>사이트 관리</span>&gt;
			<span class="bar_tx">실시간 접속자 현황</span>
		</div>
	</div>
	<div data-ng-controller="mainCtrl">
		<div class="contents_wrap" data-ng-view data-ng-cloak></div>
	</div>
</body>
</html>