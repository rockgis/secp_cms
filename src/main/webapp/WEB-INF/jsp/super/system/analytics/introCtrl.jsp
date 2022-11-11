<%@ page language="java" contentType="text/javascript; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf" %>
app.register.controller("introCtrl", function($rootScope, $scope, $timeout, $window, $routeParams, $location, ajaxService, dialogService) {
	var p = $location.search();
	angular.extend($scope.param, {
		start_dt : '${dtf:getTime('yyyy-MM-dd') }',
		end_dt : '${dtf:getTime('yyyy-MM-dd') }'
	});
	
	$scope.getData = function(){
		ajaxService.getSyncJSON('<c:url value="/super/analytics/intro.do"/>', $scope.param, function(data){
			$scope.data1 = data.data1;
			$scope.data2 = data.data2;
			$scope.browser = data.browser;
			$scope.os = data.os;
			$scope.promiseTimeout = $timeout(function(){
				if($location.$$path=="/intro"){
					$scope.getData();
				}
			}, 5000);
		});
	};
	$scope.getData();
	
	$scope.$on("$destroy", function () {
		$timeout.cancel($scope.promiseTimeout);    
	});
});
