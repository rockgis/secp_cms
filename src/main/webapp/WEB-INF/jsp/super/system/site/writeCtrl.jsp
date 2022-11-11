<%@ page language="java" contentType="text/javascript; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
app.register.controller("writeCtrl", function($scope, $window, $routeParams, ajaxService, dialogService) {
	$scope.form = {
		create_file_yn : "N",
		staff_list : []
	};
	
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
		
		ajaxService.getJSON("<c:url value="/super/site/write.do"/>", {jData : angular.toJson($scope.form)}, function(data){
			alert("로컬PC에 개발에 필요한 파일들이 추가되었습니다.\nwas 재가동후 "+$scope.form.sub_path+"에 접속하시어 내용을 확인하시기 바랍니다.");
			alert("또한 수정또는 삭제시에는 관련 파일들에대해 혼란을 방지하기 위하여 직접 수정 또는 삭제 하시기 바랍니다.");
			$scope.list();
		});
	}
});