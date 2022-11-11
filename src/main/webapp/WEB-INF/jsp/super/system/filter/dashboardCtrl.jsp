<%@ page language="java" contentType="text/javascript; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
app.register.controller("dashboardCtrl", function($rootScope, $scope, $timeout, $window, $routeParams, $location, ajaxService, dialogService) {
	$scope.board = {};
	$scope.chartData1 = {
		options : {
			legend: {
				display: true,
				position: 'right'
			}
		},
		labels : ["주민번호", "이메일", "카드번호", "사업자번호", "법인번호", "휴대전화번호", "일반전화번호"],
		data : [0, 0, 0, 0, 0, 0, 0],
		total : 0
	};
	$scope.chartData2 = {
		labels : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		series : ["주민번호", "이메일", "카드번호", "사업자번호", "법인번호", "휴대전화번호", "일반전화번호"],
		data : [
			 [0, 0, 0, 0, 0, 0, 0],
			 [0, 0, 0, 0, 0, 0, 0],
			 [0, 0, 0, 0, 0, 0, 0],
			 [0, 0, 0, 0, 0, 0, 0],
			 [0, 0, 0, 0, 0, 0, 0],
			 [0, 0, 0, 0, 0, 0, 0],
			 [0, 0, 0, 0, 0, 0, 0]
		],
		options : {
	      	scales: {
				xAxes: [{
					stacked: true
				}],
				yAxes: [{
					ticks:{
						beginAtZero: true
					},
					stacked: true
				}]
			}
	    },
	    filterset :{}
	};
	
	var p = $location.search();
	angular.extend($scope.param, {
		site_id : p.site_id||1,
		rows : 5,
		cpage : p.cpage||1,
		start_dt : p.start_dt||'',
		end_dt : p.end_dt||'',
		date_duration : p.date_duration||'4'
	});
	ajaxService.getSyncJSON('<c:url value="/super/filter/dashboardData.do"/>', $scope.param, function(data){
		$.extend($scope.chartData1, {
			data : [data.dashboardChart1.jumin_total, data.dashboardChart1.email_total, data.dashboardChart1.card_total, data.dashboardChart1.busino_total, data.dashboardChart1.bubino_total, data.dashboardChart1.tel_total, data.dashboardChart1.cell_total],
			total : data.dashboardChart1.total
		});
		if(data.dashboardChart1.total == 0){//값이 없을경우 차트보이기위해
			$.extend($scope.chartData1, {
				options : {
					legend: {
						display: true,
						position: 'right'
					}
				},
				labels : ["감지된 데이터가 없습니다."],
				data : [1],
				total : 0
			});
		}
		
		var dataset = new Array([],[],[],[],[],[],[]);
		
		$.each(data.dashboardChart2, function(i, o){
			dataset[0].push(o.jumin_total);
			dataset[1].push(o.email_total);
			dataset[2].push(o.card_total);
			dataset[3].push(o.busino_total);
			dataset[4].push(o.bubino_total);
			dataset[5].push(o.tel_total);
			dataset[6].push(o.cell_total);
		});
		if(data.dashboardChart2.length == 0){//값이 없을경우 차트보이기위해
			dataset[0].push(0);
			dataset[1].push(0);
			dataset[2].push(0);
			dataset[3].push(0);
			dataset[4].push(0);
			dataset[5].push(0);
			dataset[6].push(0);
		}
		$.extend($scope.chartData2.data, dataset);
		$.extend($scope.chartData2.filterset, data.dashboardSetStatus);
	});
	
	$scope.board.go = function(){
		$scope.param.rnd = Math.random();
		$location.search($scope.param);
	};
	
});
