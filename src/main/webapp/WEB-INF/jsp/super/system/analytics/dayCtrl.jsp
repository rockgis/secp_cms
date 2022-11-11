<%@ page language="java" contentType="text/javascript; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf" %>
app.register.controller("dayCtrl", function($rootScope, $scope, $timeout, $window, $routeParams, $location, ajaxService, dialogService) {
	$scope.chart = {
		labels : [],
		colors : [],
		series : ['방문자수', '방문횟수','페이지뷰'],
		data : [
			[],
			[],
			[]
		]
	};
	$scope.browser = {
		options : {
			legend: {
				display: true,
				position: 'right'
			}
		},
		labels : [],
		data : []
	};
	$scope.os = {
		options : {
			legend: {
				display: true,
				position: 'right'
			}
		},
		series  : ['OS'],
		labels : [],
		data : [
				   []
				]
	};
	
	var p = $location.search();
	angular.extend($scope.param, {
		start_dt : p.start_dt||'${dtf:getTime('yyyy-MM') }-01',
		end_dt : p.end_dt||"${dtf:getLastMonthDay(dtf:getTime('yyyy-MM-dd'), 'yyyy-MM-dd') }",
		date_duration : p.date_duration||'4'
	});
	
	$scope.getData = function(){
		ajaxService.getSyncJSON('<c:url value="/super/analytics/day.do"/>', $scope.param, function(data){
			$scope.boardlist = data.data1;
			
			angular.extend($scope.chart, {
					labels : [],
					data : [
						[],[],[]
					]
				});
			$.each(data.data1, function(i, o){
				$scope.chart.labels.push(o.dis);
				$scope.chart.data[0].push(o.visit_cnt);
				$scope.chart.data[1].push(o.visitant_cnt);
				$scope.chart.data[2].push(o.view_cnt);
			});
			
			angular.extend($scope.browser, {
					labels : [],
					data : []
				});
			$.each(data.browser, function(i, o){
				$scope.browser.labels.push(o.browser||'etc');
				$scope.browser.data.push(o.cnt);
			});
			
			angular.extend($scope.os, {
					labels : [],
					data : [
					   []
					]
				});
			$.each(data.os, function(i, o){
				$scope.os.labels.push(o.os);
				$scope.os.data[0].push(o.cnt);
			});
		});
	};
	$scope.getData();
	
	$scope.getPage = function(){
		$scope.param.rnd = Math.random();
		$location.search($scope.param);
	};
});
