<%@ page language="java" contentType="text/javascript; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
app.register.controller("modifyCtrl", function($scope, $timeout, $window, $routeParams, ajaxService, wordFilterService) {
	$scope.form = {
		site_id : $scope.param.site_id,
		width : "200",
		height : "150",
		cms_menu_seq : $scope.param.cms_menu_seq,
		article_seq : $routeParams.seq,
		files : [],
		reports : []
	};
	ajaxService.getSyncJSON("<c:url value="/super/bbs/B/view.do"/>", {article_seq : $routeParams.seq, board_seq : $scope.param.board_seq, del_yn : $scope.param.del_yn}, function(data){
		angular.extend($scope.form, data.view);
		$scope.form.files = data.files;
		$scope.form.removeFiles = [];
		$scope.form.reports = data.reports;
	});
	
	/*썸네일 이미지 업로드*/
	$scope.uploadThumbFile = function(){
		$scope.form.width = "200";
		$scope.form.height = "150";
		$scope.$apply();
		
		var filename = $("#thumbfile").val();
		filename = filename.slice(filename.indexOf(".") + 1).toLowerCase();
		if(filename == ""){
			return false;
		}
		/*if($.inArray(filename, ["gif", "jpg", "jpeg", "png", "bmp"]) < 0 ){
			alert("gif, jpg, jpeg, png, bmp 파일만 올려주시기 바랍니다.");
			return false;
		}
		*/
		if($scope.param.file_limit != 'N'){
			if(parseInt($scope.form.files.length) >= parseInt($scope.param.file_limit)){
				alert("최대 파일 갯수는 "+$scope.param.file_limit+"개 입니다.");
				return false;
			}			
		}
		
		if(!fileSizeCheck($("#thumbfile"), $scope.param.limit_file_size)){
    		alert("최대 용량을 초과하였습니다.\n최대 용량은 "+$scope.param.limit_file_size+"MB 입니다.");
			return false;
		}
		
    	$("#wFrm").ajaxSubmit({
    		url : '<c:url value="/ajaxThumbUpload.do"/>',
    		iframe: true,
    		dataType : "json",
    		uploadProgress : function(event, position, total, percentComplete){
    		},
    		success : function(data){
    			$scope.addThumbFile(data);
    		},
    		error: function(e){
    			alert($.trim(e.responseText));
    		}
    	});
	}
	
	$scope.addThumbFile = function(data){
		$scope.$apply(function(){
			$scope.form.thumb = "<spring:eval expression="@config['upload.thumb']" />"+"/"+data.uuid;
		});
	}
	
	$scope.removeThumbFile = function(idx){
		$scope.form.removeFiles.push($scope.form.files[idx]);
		$scope.form.files.splice(idx, 1);
	}
	
	
	
	/*일반 파일 업로드*/
	$scope.uploadFile = function(){
		$scope.form.width = "0";
		$scope.form.height = "0";
		$scope.$apply();
		
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
			    	
			    	$scope.form.width = "200";
					$scope.form.height = "150";
					$scope.$apply();
    		},
    		error: function(e){
    			alert($.trim(e.responseText));
    		}    		
    	});
	}

	$scope.addFile = function(data){
		$scope.$apply(function(){
			$scope.form.files.push(data);
		});
	}
	
	$scope.removeFile = function(idx){
		$scope.form.removeFiles.push($scope.form.files[idx]);
		$scope.form.files.splice(idx, 1);
	}
	
	
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
			
			if(!$scope.form.thumb){
				var img_array = $($scope.form.conts).find('img');
    			var domain = location.origin;
    			$scope.form.thumb = "";
    			$.each(img_array, function(idx){
    				if($scope.form.thumb != "") return;
    				if(this.src.indexOf(domain) == -1) return;
    				$scope.form.thumb = this.src.substring(domain.length);
    				return false;
    			});
			}
		
			ajaxService.getJSON("<c:url value="/super/bbs/B/modify.do"/>", {jData : angular.toJson($scope.form)}, function(data){
				if(data.rst == -1){
					alert(data.msg)
				}else{
					$scope.list();
				}
			});
		});
	}
	
	$scope.del = function(){
		if(confirm("삭제하시겠습니까?")){
			ajaxService.getJSON('<c:url value="/super/bbs/delete.do"/>', $scope.form, function(data){
				$scope.list();
			});
		}
	}
	
});
