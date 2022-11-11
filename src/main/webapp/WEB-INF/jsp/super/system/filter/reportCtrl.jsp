<%@ page language="java" contentType="text/javascript; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
app.register.controller("reportCtrl", function($rootScope, $scope, $timeout, $window, $routeParams, $location, ajaxService, dialogService) {
	$scope.board = {};
	$scope.chartData1 = {};
	$scope.chartData2 = {};
	$scope.thisMonth();
	
	var p = $location.search();
	angular.extend($scope.param, {
		rows : 5,
		cpage : p.cpage||1,
		start_dt : p.start_dt||'',
		end_dt : p.end_dt||'',
		date_duration : p.date_duration||'4'
	});
	ajaxService.getSyncJSON('<c:url value="/super/filter/reportList.do"/>', $scope.param, function(data){
		var menu_nm = [];
		var total = [];
		var jumin_total = 0;
		var email_total = 0;
		var card_total = 0;
		var busino_total = 0;
		var bubino_total = 0;
		var cell_total = 0;
		var tel_total = 0;
		
		$scope.board.list = data.list;
		$scope.board.currentPage = $scope.param.cpage;
		$scope.board.totalCount = data.pagination.totalcount;
		$scope.board.totalPage = data.pagination.totalpage;
		
		$.each(data.total_list, function(i, o){
			menu_nm.push(o.menu_nm);
			total.push(o.total);
			jumin_total = jumin_total + o.jumin_total; 
			email_total = email_total + o.email_total;
			card_total = card_total + o.card_total;
			busino_total = busino_total + o.busino_total; 
			bubino_total = bubino_total + o.bubino_total; 
			cell_total = cell_total + o.cell_total; 
			tel_total = tel_total + o.tel_total; 
		});
		
		$scope.chartData1 = {
			    labels: menu_nm,
		 	    series: ['메뉴별 필터링 통계'],
			    data: [total]
		};
		
		$scope.chartData2 = {
				labels : ["주민번호", "이메일", "카드번호", "사업자번호", "법인번호", "휴대전화번호", "일반전화번호"],
				data : [jumin_total, email_total, card_total, busino_total, bubino_total, cell_total, tel_total]			
		};			
	});
	
	$scope.board.go = function(n){
		$scope.param.cpage=n;
		$scope.param.rnd = Math.random();
		$location.search($scope.param);
	};
	
	$scope.excel_export = function(){
		location.href="<c:url value="/super/filter/report_excel.do"/>?"+$.param($scope.param);
	}
	
});
