<%@ page language="java" contentType="text/javascript; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
app.register.controller("writeCtrl", function($scope, $timeout, $window, $routeParams, ajaxService, wordFilterService, dialogService) {
	$scope.form = {
		site_id : $scope.param.site_id,
		board_seq : $scope.param.board_seq,
		cms_menu_seq : $scope.param.cms_menu_seq,
		files : []
	};
	
	$scope.uploadFile = function(){
		var filename = $("#file").val();
		filename = filename.slice(filename.indexOf(".") + 1).toLowerCase();
		if(filename == ""){
			return false;
		}
		if($scope.param.file_limit != 'N'){
			if(parseInt($scope.form.files.length) >= parseInt($scope.param.file_limit)){
				alert("최대 파일 갯수는 "+$scope.param.file_limit+"개 입니다.");
				return false;
			}			
		}
		
		if(!fileSizeCheck($("#file"), $scope.param.limit_file_size)){
    		alert("최대 용량을 초과하였습니다.\n최대 용량은 "+$scope.param.limit_file_size+"MB 입니다.");
			return false;
		}
    	$("#wFrm").ajaxSubmit({
    		url : '<c:url value="/ajaxUpload.do"/>',
    		iframe: true,
    		dataType : "json",
    		uploadProgress : function(event, position, total, percentComplete){
    		},
    		success : function(data){
    			$scope.addFile(data);
    		},
    		error: function(e){
    			alert($.trim(e.responseText));
    		}
    	});
	};
	
	$scope.addFile = function(data){
		$scope.$apply(function(){
			$scope.form.files.push(data);
		});
	};
	
	$scope.removeFile = function(idx){
		$scope.form.files.splice(idx, 1);
	};
	
	$scope.save = function(){
		if($scope.frm.$invalid){
			if($scope.frm.$error.required){
				alert("필수값을 입력하여 주십시오.");
			}else{
				alert("값이 유효하지 않습니다.");
			}
			$("#wFrm .ng-invalid")[0].focus();
			return false;
		}
		var promise = wordFilterService.check($scope.form, $scope.form.cms_menu_seq);
		promise.then(function(){
		
			if($scope.form.reserve == "Y"){
				ajaxService.getJSON("${context_path }/super/reserve/write_bbs_reserve.do", {jData : angular.toJson($scope.form)}, function(data){
					if(data.rst == -1){
						alert(data.msg)
					}else{
						alert("예약이 완료되었습니다.");
						$scope.list();
					}
				});
			}else{
				ajaxService.getJSON("<c:url value="/super/bbs/D/write.do"/>", {jData : angular.toJson($scope.form)}, function(data){
					if(data.rst == -1){
						alert(data.msg)
					}else{
						$scope.list();
					}
				});
			}			
			
		});
	};
	
	//예약저장
	$scope.reserve = function(){
		var options = {
				autoOpen: false,
				modal: true,
				width: "461",
				height: "540",
				close: function(event, ui) {
				}
			};
		
		dialogService.open("reserveDialog", "reserveTemplete.html", {}, options)
		.then(
			function(result) {
				$scope.form.reserve_dt = result.reserve_dt;
				$scope.form.reserve_title = result.page_navi + ">" + $scope.form.title;
				$scope.form.reserve = "Y";
				$scope.form.article_yn = "Y";	//게시물 예약용
				$scope.save();
			},
			function(error) {
			}
		);
	};
	
});
