<%@ page language="java" contentType="text/javascript; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
app.register.controller("listCtrl", function($rootScope, $scope, $timeout, $window, $routeParams, $location, ajaxService, dialogService) {
	$scope.board = {};
	$scope.form = {};
	
	var p = $location.search();
	angular.extend($scope.param, {
	});
	
	$scope.status = function(){
		ajaxService.getSyncJSON("/admin/gathring/crawling.do", {}, function(data){
			$scope.form = {
				status : data.status,
				count : data.count,
				time : data.time,
				last_update : data.last_update,
				minute : data.time / 60
			}; 
		});
	}
	
	$scope.update_search = function(){
		if(!confirm("검색 갱신하시겠습니까?")) {
			return false;
		}
		ajaxService.getJSON("/admin/gathring/crawling.do", {update:'Y'}, function(data){
			$scope.form = {
				status : data.status
			}; 
		});
	}
	$scope.status();
	
});