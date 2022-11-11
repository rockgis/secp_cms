<%@ page language="java" contentType="text/javascript; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf" %>
app.register.controller("pageCtrl", function($rootScope, $scope, $timeout, $window, $routeParams, $location, ajaxService, dialogService) {
	$scope.board = {};
	$scope.board.go = function(n){
		$scope.param.cpage=n;
		$scope.param.rnd = Math.random();
		$location.search($scope.param);
	};
	
	var p = $location.search();
	angular.extend($scope.param, {
		condition : p.condition||'title',
		start_dt : p.start_dt||'${dtf:getTime('yyyy-MM') }-01',
		end_dt : p.end_dt||"${dtf:getLastMonthDay(dtf:getTime('yyyy-MM-dd'), 'yyyy-MM-dd') }",
		sort : p.sort||'asc',
		sort_nm : p.sort_nm||'',
		cpage : p.cpage||'1',
		date_duration : p.date_duration||'4'
	});

	//정렬
	$scope.board.sort = function(sort_nm, $event){
		var eq = 0;
		if(angular.equals(sort_nm, $scope.param.sort_nm)){
			if($scope.param.sort == 'asc'){
				$scope.param.sort = 'desc';
				eq=1;
			}else{
				$scope.param.sort = 'asc';
			}
		}else{
			$scope.param.sort = 'asc';
			$scope.param.sort_nm = sort_nm;
		}
		$($event.target).closest("tr").find(".arrow_box>span").removeClass("arrow_on");
		$($event.target).find("span").eq(eq).addClass("arrow_on");
		$scope.board.go(1);
	}
	
	ajaxService.getSyncJSON('<c:url value="/super/analytics/page.do"/>', $scope.param, function(data){
		$scope.board.list = data.list;
		$scope.board.currentPage = $scope.param.cpage;
		$scope.board.totalCount = data.pagination.totalcount;
		$scope.board.totalPage = data.pagination.totalpage;
	});
});
