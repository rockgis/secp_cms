<%@ page language="java" contentType="text/javascript; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
app.register.controller("listCtrl", function($scope, $timeout, $window, $routeParams, $location, ajaxService, dialogService) {
	$scope.board = {};
	
	var p = $location.search();
	angular.extend($scope.param, {
		rows : 5,
		cpage : p.cpage||1,
		start_dt : p.start_dt||'',
		end_dt : p.end_dt||'',
		condition : p.condition||'title'
	});
	ajaxService.getSyncJSON('<c:url value="/super/site/list.do"/>', $scope.param, function(data){
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
	
	$scope.del = function(item){
		if(item.cms_menu_seq == '1'){
			alert("Main 사이트는 삭제 하실수 없습니다.");
			return false;
		}
		if(!confirm("정말 삭제 하시겠습니까?")){
			return false;
		}
		ajaxService.getJSON("<c:url value="/super/site/del.do"/>", item, function(data){
			if(data.rst == '1'){
				$scope.board.go(1);
			}else{
				alert(data.msg);
			}
		});
	}
});