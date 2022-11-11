<%@ page language="java" contentType="text/javascript; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
app.register.controller("modifyCtrl", function($rootScope, $scope, $timeout, $window, $routeParams, $location, ajaxService, dialogService) {
	$scope.openJsCssManage = function(fileName){
		var options = {
			autoOpen: false,
			modal: true,
			width: "1000",
			height: "569",
			close: function(event, ui) {}
		};
			
		dialogService.open("JsCssManageDialog","JsCssManage.html", {file_name : fileName}, options).then(
			function(result) {
			},
			function(error) {}
		);
	}

});
