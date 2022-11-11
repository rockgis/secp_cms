<%@ page language="java" contentType="text/javascript; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf" %>
app.register.controller("daylistCtrl", function($rootScope, $scope, $timeout, $window, $routeParams, $location, ajaxService, dialogService) {
	$scope.board = {};
	$scope.chartData = {
		labels : ['1'],
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
					stacked: true
				}]
			}
	    },
	    filterset :{}
	};
	
	var p = $location.search();
	angular.extend($scope.param, {
		site_id : p.site_id||1,
		year : p.year||'${dtf:getTime('yyyy') }',
		month : p.month||'${dtf:getTime('MM') }'
	});
	
	$scope.getData = function(){
		ajaxService.getSyncJSON('<c:url value="/super/filter/daylistData.do"/>', $scope.param, function(data){
			var labels = [];
			
			var dataset = new Array([],[],[],[],[],[],[]);
			$.each(data.daylistData, function(i, o){
				labels.push((i+1)+"일");
				dataset[0].push(o.jumin_total);
				dataset[1].push(o.email_total);
				dataset[2].push(o.card_total);
				dataset[3].push(o.busino_total);
				dataset[4].push(o.bubino_total);
				dataset[5].push(o.tel_total);
				dataset[6].push(o.cell_total);
			});
			$.extend($scope.chartData, {
				labels : labels,
				data:dataset
			});
		});
	}
	$scope.getData();
	
	$scope.changeDate = function(){
		$scope.getData();
	}
	
});
