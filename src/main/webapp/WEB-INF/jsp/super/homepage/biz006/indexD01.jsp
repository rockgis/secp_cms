<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>bizmanage 관리</title>
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
		parent_menu_seq : '${param.parent_menu_seq}',
		cms_menu_seq : '${param.cms_menu_seq}',
		permit : '${param.permit}'
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
	    .when('/introD01', route.resolve("introD01"))
		.otherwise({redirectTo: '/introD01' });
}]);

//app.controller("mainCtrl", function($scope, $location, ajaxService) {
app.controller("mainCtrl", function($scope, $location, $compile, ajaxService, dialogService, $filter, $timeout) {
	

// 	ajaxService.getJSON("<c:url value="/json/list/Code.codeList.do"/>", {code_group_seq : '5'}, function(data){
// 		$scope.main.codeList = data;
// 		//console.log("#### codeList : "+data);
// 	});
	
	$scope.list = function(){
		$location.path("/introD01");
	}
});
</script>

	<script type="text/javascript" src="<c:url value="/js/admin/common.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/admin/biz006/introD.js"/>"></script>

</head>
<body>
	<div class="titlebar">
		<h2>지원사업 관리</h2>
		<div>
			
		</div>
	</div>
	<div data-ng-controller="mainCtrl">
		<div data-ng-view data-ng-cloak style=""></div>
	</div>
</body>
</html>
