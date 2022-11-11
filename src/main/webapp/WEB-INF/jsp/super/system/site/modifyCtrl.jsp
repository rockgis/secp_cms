<%@ page language="java" contentType="text/javascript; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
app.register.controller("modifyCtrl", function($scope, $window, $routeParams, ajaxService, dialogService) {
	$scope.form = {
		staff_list : []
	};
	ajaxService.getSyncJSON("<c:url value="/super/site/view.do"/>", {cms_menu_seq : $routeParams.seq}, function(data){
		angular.extend($scope.form, data.view);
		angular.extend($scope.form.staff_list, data.staff_list);
	});
	
	$scope.openStaffSelect = function(item){
		var options = {
				title : '담당자 선택',
				autoOpen: false,
				modal: true,
				width: "900",
				height: "825",
				close: function(event, ui) {
				}
			};
		
		dialogService.open("staffSelectDialog", "/st_exclude/super/system/site/staffSelectTemplete.do", {staff_list: item.staff_list}, options)
		.then(
			function(result) {
				$scope.form.staff_list = result;
			},
			function(error) {
			}
		);
	}
	
	$scope.removeStaff = function(idx){
		$scope.form.staff_list.splice(idx, 1);
	}
	
	$scope.save = function(){
		if($scope.wFrm.$invalid){
			if($scope.wFrm.$error.required){
				alert("필수값을 입력하여 주십시오.");
			}else{
				alert("값이 유효하지 않습니다.");
			}
			$("#wFrm .ng-invalid")[0].focus();
			return false;
		}
		
		ajaxService.getJSON("<c:url value="/super/site/modify.do"/>", {jData : angular.toJson($scope.form)}, function(data){
			$scope.list();
		});
	}
	
});