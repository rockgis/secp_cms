<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<c:set var="site_id" value="${empty cookie.adh_menu_current_siteid ? '1' : cookie.adh_menu_current_siteid.value }"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>사이트 기본설정</title>
<script type="text/javascript" src="<c:url value="/lib/js/angular.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/angular-route.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/filters/myFilter.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/filters/ngRange.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/services/myCommon.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/services/dialog-service.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/myUtil.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/myPagination.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/route/routeResolver.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/myEditor.js"/>"></script>
<script type="text/javascript">
var app = angular.module("MyApp", ['routeResolverServices', 'dialogService', 'ngRoute', 'myUtil', 'myPagination', 'myCommon', 'myFilter', 'ngRange', 'myEditor']);

app.run(function($rootScope){
	$rootScope.param = {site_id : "${site_id}"};
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
	    .when('/modify', route.resolve("modify"))
		.otherwise({redirectTo: '/modify' });
}]);
app.controller("mainCtrl", function($scope, $location, ajaxService) {
	$scope.main = {
	};
	ajaxService.getJSON("/super/site/js_css/js_css_main.do", $scope.param, function(data){
		$scope.main.common_css = $scope.getMyItem(data, 'common.css');
		$scope.main.main_css = $scope.getMyItem(data, 'main.css');
		$scope.main.sub_css = $scope.getMyItem(data, 'sub.css');
		$scope.main.article_css = $scope.getMyItem(data, 'article.css');
		$scope.main.common_js = $scope.getMyItem(data, 'common.js');
		$scope.main.main_js = $scope.getMyItem(data, 'main.js');
		$scope.main.sub_js = $scope.getMyItem(data, 'sub.js');
	});
	$scope.getMyItem = function(data, file_name){
		var rst = {};
		$.each(data.data, function(i, o){
			if(o.file_name == file_name){
				rst = o;
				return false;
			}
		});
		return rst;
	}
});
app.controller("jsCssManageCtrl", function($scope, $window, $compile, ajaxService, dialogService) {
	var initTrue = true;
	$.extend($scope.param, {rows:10, file_name : $scope.model.file_name});
	
	$scope.getView = function(seq){
		ajaxService.getJSON("/super/site/js_css/js_css_get_item.do", {seq : seq}, function(data){
			$scope.form = data.view;
		});
	}
	
	$scope.board = {};
	$scope.board.go = function(n){
		$scope.param.cpage = n;
		ajaxService.getJSON('<c:url value="/super/site/js_css/js_css_list.do"/>', $scope.param, function(data){
			$scope.board.list = data.list;
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.pagination.totalcount;
			$scope.board.totalPage = data.pagination.totalpage;
			if(initTrue && $scope.board.list.length>0){
				initTrue = false;
				$scope.getView($scope.board.list[0].seq);
			}
		});
	};
	$scope.board.go(1);
	
	$scope.save = function(){
		if(!confirm("저장하시겠습니까?")){
			return false;
		}
		var p = {jData : angular.toJson({site_id : $scope.param.site_id, file_name : $scope.model.file_name, code_text : $scope.form.code_text})}
		ajaxService.getJSON("/super/site/js_css/js_css_write.do", p, function(data){
			dialogService.cancel("JsCssManageDialog");
		});
	}
	
	$scope.cancel = function(){
		dialogService.cancel("JsCssManageDialog");
	}
});
</script>
</head>
<body>
	<div class="titlebar">
		<h2>기본설정</h2>
		<div>
			<span>사이트설정</span>&gt;
			<span class="bar_tx">기본설정</span>
		</div>
	</div>
	<div data-ng-controller="mainCtrl">
		<div data-ng-view data-ng-cloak></div>
	</div>

<script type="text/ng-template" id="JsCssManage.html">
	<div ng-controller="jsCssManageCtrl" title="CSS/JS 관리" style="overflow:hidden; padding:15px;">
		<textarea style="overflow-y:scroll; float:left; padding:5px; width:700px; height:500px; background:#ddd; border:none; outline:0; resize:none;" ng-model="form.code_text"></textarea>
		<div class="history" style="float:right;">
			<table class="type2" style="width:250px; border:none;">
		 	 	<colgroup>
					<col width="50%">
					<col width="*">
					<col width="18%">
				</colgroup>
				<thead>
					<tr>
						<th colspan="3" class="center">수정이력</th>
					</tr>
				</thead>
				<tbody style="font-size:11px;">
					<tr data-ng-repeat="item in board.list">
						<td><span style="">{{item.reg_dt}}</span></td>
						<td class="center"><span style="">{{item.reg_nm}}</span></td>
						<td><a style="display:inline-block; padding:1px 5px 1px 4px; border-radius:3px; color:#fff; background:#20b9ae; text-decoration:none;" ng-click="getView(item.seq)">복원</a></td>
					</tr>
				</tbody>
			</table>
			<pagination style="border-top:none;" total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)" ng-mode="mini"></pagination>
		</div>
		<div style="position:absolute; bottom:15px; right:15px;"><input type="button" class="bt_big_bt4" value="저장하기" ng-click="save()"></div>
	</div>
</script>
</body>
</html>