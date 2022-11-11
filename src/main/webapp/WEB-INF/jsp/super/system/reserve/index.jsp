<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>예약업데이트 관리</title>
<script type="text/javascript" src="<c:url value="/lib/js/angular.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/angular-route.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/filters/myFilter.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/filters/ngRange.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/services/myCommon.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/services/dialog-service.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/myUtil.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/myPagination.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/sortable.js"/>"></script>
<script type="text/javascript">
var app = angular.module("MyApp", ['dialogService', 'ngRoute', 'myUtil', 'myPagination', 'myCommon', 'ui.sortable', 'myFilter', 'ngRange']);
app.run(function($rootScope){
	$rootScope.main = {};
	$rootScope.param = {
		site_id : "",
		status : ''
	};
});
app.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
	$routeProvider
		.when('/list', {controller: 'listCtrl', templateUrl : 'st_exclude/list.do'})
		.otherwise({redirectTo: '/list' });
}]);

app.controller("mainCtrl", function($scope, $location, ajaxService) {
	//사이트리스트
	ajaxService.getSyncJSON("<c:url value="/super/member/site_list.do"/>", {}, function(data){
		$scope.main.site_list = data.site_list;
	});
	
	$scope.list = function(){
		$location.path("/list");
	}
});
app.controller("listCtrl", function($scope, $window, $routeParams, $compile, ajaxService, dialogService) {
	$scope.board = {};
	$scope.board.go = function(n){
		ajaxService.getSyncJSON('<c:url value="/super/reserve/list.do"/>?cpage='+n, $scope.param, function(data){
			$scope.board.list = data.list;
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.pagination.totalcount;
			$scope.board.totalPage = data.pagination.totalpage;
		});
	};
	$scope.getLinkUrl = function(item){
		if(!!item.menu_url){
			var newWindow = window.open("about:blank");
			if(item.gubun=="B"){
				var url = item.menu_url.replace('list.do', 'view.do?article_seq='+item.article_seq);
				newWindow.location.href = url ;
			}else{	//일반페이지
				newWindow.location.href = menu_url ;
			}
		}else{
			alert("아직 적용전이거나 이미 삭제된 페이지 입니다.");
		}
	}
	$scope.del = function(item){
		if(!confirm("정말 삭제 하시겠습니까?")){
			return false;
		}
		ajaxService.getJSON("<c:url value="/super/reserve/del.do"/>", item, function(data){
			if(data.rst == '1'){
				$scope.board.go(1);
			}else{
				alert(data.msg);
			}
		});
	}
});
</script>
</head>
<body>
	<div class="titlebar">
		<h2>예약업데이트 관리</h2>
		<div>
			<span>시스템관리</span>&gt; <span>기타 설정</span>&gt; 
			<span class="bar_tx">예약업데이트 관리</span>
		</div>
	</div>
	<div data-ng-controller="mainCtrl">
		<div class="contents_wrap" data-ng-view data-ng-cloak></div>
	</div>
</body>
</html>