<%@ page language="java" contentType="text/javascript; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
app.register.controller("settingCtrl", function($rootScope, $scope, $timeout, $window, $routeParams, $location, ajaxService, dialogService) {
	var p = $location.search();
	angular.extend($scope.param, {
		rows : 10,
		cpage : p.cpage||1,
		condition : p.condition||'A.TITLE',
		keyword : p.keyword||'',
		filter_yn : p.filter_yn||'',
		menu_type : p.menu_type||'1'
	});
	$scope.board = {
	};
	$scope.board.go = function(n){
		$scope.param.cpage=n;
		$scope.param.rnd = Math.random();
		$location.search($scope.param);
	};
	ajaxService.getSyncJSON('<c:url value="/super/filter/settingList.do"/>', $scope.param, function(data){
		$.each(data.list, function(i, o){
			if(o.filter_yn == 'Y') {
				o.filter_status = true;
			}else{
				o.filter_status = false;
			}
		});
		$scope.form = data.default_filter||{};
		$scope.form.site_id = $scope.param.site_id;
		$scope.board.list = data.list;
		$scope.board.currentPage = $scope.param.cpage;
		$scope.board.totalCount = data.pagination.totalcount;
		$scope.board.totalPage = data.pagination.totalpage;
	});
	
	$scope.setDefaultFilter = function(){
		if(
			$scope.form.jumin_yn == 'N' & 
			$scope.form.email_yn == 'N' &
			$scope.form.card_yn == 'N' &
			$scope.form.busino_yn == 'N' &
			$scope.form.bubino_yn == 'N' &
			$scope.form.tel_yn == 'N' &
			$scope.form.cell_yn == 'N'
			)
		{
			alert("기본필터를 선택하여 주십시오.");
			$scope.board.go($scope.param.cpage);
			return false;
		}
		
		ajaxService.getJSON('<c:url value="/super/filter/set_default_filter.do"/>', {jData : angular.toJson($scope.form)}, function(data){
			alert("필터설정이 완료 되었습니다.");
			$scope.board.go($scope.param.cpage);
		});
	}
	
	$scope.setMenuFilter = function(item){
		item.filter_status = !item.filter_status;
  		if(item.filter_status) {
  			$scope.form.filter_yn = 'Y';
  		}else{
  			$scope.form.filter_yn = 'N';
  		}
  		$scope.form.cms_menu_seq = item.cms_menu_seq;
		ajaxService.getJSON('<c:url value="/super/filter/set_menu_filter.do"/>', {jData : angular.toJson($scope.form)}, function(data){
			$scope.board.go($scope.param.cpage);
		});
	}
	
	$scope.eachPersonalFilter = function(item){
		var options = {
				autoOpen: false,
				modal: true,
				width: "750",
				height: "250",
				close: function(event, ui) {
				}
		};
		dialogService.open("viewFilter","eachPersonalFilter.html", {"cms_menu_seq" : item.cms_menu_seq}, options)
		.then(
			function(result) {
				$scope.board.go($scope.param.cpage);
			},
			function(error) {
			}
		);
	};
});
