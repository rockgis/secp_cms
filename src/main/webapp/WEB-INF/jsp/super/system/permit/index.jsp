<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>공통코드관리</title>
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

app.controller("mainCtrl", function($scope, $location, ajaxService) {

	//사이트리스트
	ajaxService.getSyncJSON("<c:url value="/super/member/site_list.do"/>", {}, function(data){
		$scope.main.site_list = data.site_list;
	});
	
	$scope.list = function(){
		$location.path("/list");
	}
	$scope.depthStyle = function(o){
		var rst = {'padding-left': (o.menu_level*15)+"px"};
		if(o.menu_level==1){
			rst["font-weight"] = "bold";
		}
		if(!o.menu_level){
			rst["color"] = "blue";
		}
		return rst;
	}
});
app.controller("listCtrl", function($scope, $window, $routeParams, $compile, $location, ajaxService, dialogService) {
	$scope.board = {};

	var p = $location.search();
	angular.extend($scope.param, {
		rows : p.rows||10,
		cpage : p.cpage||1,
		condition : p.condition||'title',
		keyword : p.keyword||'',
		site_id : $scope.main.site_list[0].cms_menu_seq
	});
	ajaxService.getSyncJSON('<c:url value="/super/permit/list.do"/>', $scope.param, function(data){
		$scope.board.list = data.list;
		$scope.board.currentPage = $scope.param.cpage;
		$scope.board.totalCount = data.pagination.totalcount;
		$scope.board.totalPage = data.pagination.totalpage;
	});
	
	$scope.board.go = function(n){
		$scope.param.cpage=n;
		$location.search($scope.param);
	};
	$scope.del = function(item){
		if($.inArray(item.seq, [0,1])>-1){
			alert("기본권한은 삭제하실수 없습니다.");
			return false;
		}		
		if(!confirm("정말 삭제 하시겠습니까?")){
			return false;
		}
		ajaxService.getJSON("<c:url value="/super/permit/del.do"/>", item, function(data){
			if(data.rst == '1'){
				$scope.board.go(1);
			}else{
				alert(data.msg);
			}
		},"삭제");
	}
});
app.controller("writeCtrl", function($scope, $window, $routeParams, ajaxService, dialogService) {
	$scope.form={
		site_id : $scope.main.site_list[0].cms_menu_seq	
	};
	$scope.menuList = function(){
		ajaxService.getJSON("<c:url value="/super/permit/menu_list.do"/>", {site_id : $scope.form.site_id}, function(data){
			$scope.form.list = data;
		});
	}
	$scope.menuList();
	
	$scope.all_chk = function(tp, yn){
		var item = "";
		if(tp == "1"){
			item = "add_yn";
		}else if(tp == "2"){
			item = "mod_yn";
		}else if(tp == "3"){
			item = "view_yn";
		}
		$.each($scope.form.list, function(i, o){
			o[item] = (yn?"Y":"N");
		});
	}
	
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
		
		ajaxService.getJSON("<c:url value="/super/permit/write.do"/>", {jData : angular.toJson($scope.form)}, function(data){
			$scope.list();
		});
	}
});
app.controller("modifyCtrl", function($scope, $window, $routeParams, ajaxService, dialogService) {
	$scope.form={
		list : [],
		site_id : $scope.main.site_list[0].cms_menu_seq	
	};
	$scope.menuList = function(){
		ajaxService.getJSON("<c:url value="/super/permit/view.do"/>", {site_id : $scope.form.site_id, seq : $routeParams.seq}, function(data){
			data.view.site_id = $scope.form.site_id;
			$scope.form = data.view;
			$scope.form.list = data.list;
		});
	}
	$scope.menuList();
	
	$scope.all_chk = function(tp, yn){
		var item = "";
		if(tp == "1"){
			item = "add_yn";
		}else if(tp == "2"){
			item = "mod_yn";
		}else if(tp == "3"){
			item = "view_yn";
		}
		$.each($scope.form.list, function(i, o){
			o[item] = (yn?"Y":"N");
		});
	}
	
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
		
		ajaxService.getJSON("<c:url value="/super/permit/modify.do"/>", {jData : angular.toJson($scope.form)}, function(data){
			$scope.list();
		},"저장");
	}
	
});

</script>
</head>
<body>
	<div class="titlebar">
		<h2>메뉴권한 관리</h2>
		<div>
			<span>시스템관리</span>&gt;
			<span class="bar_tx">메뉴권한 관리</span>
		</div>
	</div>
	<div data-ng-controller="mainCtrl">
		<div data-ng-view data-ng-cloak></div>
	</div>
</body>
</html>