<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>프로그램 관리</title>
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
	};
});
app.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
	$routeProvider
		.when('/list', {controller: 'listCtrl', templateUrl : 'st_exclude/list.do'})
		.when('/write', {controller: 'writeCtrl', templateUrl : 'st_exclude/write.do'})
		.when('/modify/:seq', {controller: 'modifyCtrl', templateUrl : 'st_exclude/modify.do'})
		.otherwise({redirectTo: '/list' });
}]);
app.factory('linkListFactory', function(ajaxService, dialogService) {
	var service = {};
	service.getList = function(menuUrl){
		var rst = [];
		ajaxService.getSyncJSON('<c:url value="/super/program/menu_list.do"/>', {menu_url : menuUrl}, function(data){
			rst = data.list;
		});
		return rst;
	}
	service.openLink = function(url){
		var newWindow = window.open("about:blank");
		newWindow.location.href=url;
	}
	return service;
});

app.controller("mainCtrl", function($scope, $location, ajaxService) {
	$scope.list = function(){
		$location.path("/list");
	}
});
app.controller("listCtrl", function($scope, $window, $routeParams, $compile, $location, ajaxService, dialogService) {
	$scope.board = {};

	var p = $location.search();
	angular.extend($scope.param, {
		rows : p.rows||10,
		cpage : p.cpage||1,
		condition : p.condition||'A.TITLE',
		keyword : p.keyword||''
	});
	ajaxService.getSyncJSON('<c:url value="/super/program/list.do"/>', $scope.param, function(data){
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
	
	$scope.openLinkList = function(item){
		var options = {
				title : '메뉴 목록',
				autoOpen: false,
				modal: true,
				width: "630",
				height: "480",
				close: function(event, ui) {
				}
			};
		dialogService.open("LinkListDialog", "/st_exclude/super/system/program/LinkListTemplete.do", item, options)
		.then(
			function(result) {
			},
			function(error) {
			}
		);
	}
	
	$scope.del = function(item){
		if(item.user_page_cnt > 0){
			alert("메뉴연결중인 프로그램은 삭제 할 수 없습니다. 연결을 해지 후 삭제 해 주세요.");
			return false;
		}
		if(!confirm("정말 삭제 하시겠습니까?")){
			return false;
		}
		ajaxService.getJSON("<c:url value="/super/program/del.do"/>", item, function(data){
			if(data.rst == '1'){
				$scope.board.go(1);
			}else{
				alert(data.msg);
			}
		});
	}
});
app.controller("writeCtrl", function($scope, $window, $routeParams, ajaxService, dialogService) {
	$scope.form={
		create_file_yn : "N"
	};
	
	$scope.save = function(){
		if($scope.wFrm.$invalid){
			if($scope.wFrm.$error.required){
				alert("필수값을 입력하여 주십시오.");
			}else{
				alert("값이 유효하지 않습니다.");
			}
			$("#wFrm .ng-invalid")[0].focus();
			return false;
		}
		
		ajaxService.getJSON("<c:url value="/super/program/write.do"/>", {jData : angular.toJson($scope.form)}, function(data){
			if($scope.form.create_file_yn=="Y"){
				alert("로컬PC에 개발에 필요한 파일들이 추가되었습니다.\nwas 재가동후 "+$scope.form.url+"에 접속하시어 내용을 확인하시기 바랍니다.");
				alert("또한 수정또는 삭제시에는 관련 파일들에대해 혼란을 방지하기 위하여 직접 수정 또는 삭제 하시기 바랍니다.");
			}else{
				alert("프로그램을 생성했습니다.");
			}
			$scope.list();
		});
	}
});
app.controller("modifyCtrl", function($scope, $window, $routeParams, ajaxService, dialogService, linkListFactory) {

	ajaxService.getSyncJSON("<c:url value="/super/program/view.do"/>", {seq : $routeParams.seq}, function(data){
		$scope.form = data;
	});
	
	$scope.menuList = linkListFactory.getList($scope.form.url);
	$scope.openLink = linkListFactory.openLink;
	
	$scope.save = function(){
		if($scope.wFrm.$invalid){
			if($scope.wFrm.$error.required){
				alert("필수값을 입력하여 주십시오.");
			}else{
				alert("값이 유효하지 않습니다.");
			}
			$("#wFrm .ng-invalid")[0].focus();
			return false;
		}
		
		ajaxService.getJSON("<c:url value="/super/program/modify.do"/>", {jData : angular.toJson($scope.form)}, function(data){
			$scope.list();
		});
	}
	
});
app.controller("linkListCtrl", function($scope, $window, ajaxService, dialogService, linkListFactory) {
	$scope.menuList = linkListFactory.getList($scope.model.url);
	$scope.openLink = linkListFactory.openLink;
	
	$scope.close = function(){
		dialogService.close("LinkListDialog");
	}
	
});
</script>
</head>
<body>
	<div class="titlebar">
		<h2>프로그램 관리</h2>
		<div>
			<span>시스템 관리</span>&gt; <span>시스템 설정 및 관리</span>&gt;
			<span class="bar_tx">프로그램 관리</span>
		</div>
	</div>
	<div data-ng-controller="mainCtrl">
		<div class="contents_wrap" data-ng-view data-ng-cloak></div>
	</div>
</body>
</html>