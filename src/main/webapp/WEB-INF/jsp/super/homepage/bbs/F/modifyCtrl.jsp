<%@ page language="java" contentType="text/javascript; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
app.register.controller("modifyCtrl", function($scope, $timeout, $window, $routeParams, ajaxService, wordFilterService, $rootScope, $sce, $compile, dialogService) {
	$scope.catlist = [];
	$scope.form = {
		site_id : $scope.param.site_id,
		width : "200",
		height : "150",
		cms_menu_seq : $rootScope.param.cms_menu_seq,
		article_seq : $routeParams.seq,
		thumb_yn : 'N',
		files : [],
		reports : []
	};
	$scope.custom = [];
	$scope.tellist = [];
	$scope.celllist = [];
	$scope.emaillist = [];
	
	ajaxService.getJSON('<c:url value="/json/list/Code.codeList.do"/>', {code_group_seq : 1}, function(data){
		$scope.tellist = data;
	});
	ajaxService.getJSON('<c:url value="/json/list/Code.codeList.do"/>', {code_group_seq : 2}, function(data){
		$scope.celllist = data;
	});
	ajaxService.getJSON('<c:url value="/json/list/Code.codeList.do"/>', {code_group_seq : 3}, function(data){
		$scope.emaillist = data;
	});
	
	ajaxService.getJSON('<c:url value="/super/system/board/element_list.do"/>', {'board_seq':$scope.param.board_seq,'view_focus':'a_modify'}, function(data){
		$scope.custom = data;
		
		for(var col in data){
			if(data[col].column_name == 'thumb'){
				$scope.form.thumb_yn = 'Y';
			}
		}	    
	});
	
	if($rootScope.param.cat_yn == 'Y'){
		ajaxService.getJSON('<c:url value="/super/bbs/catlist.do"/>', {board_seq : $rootScope.param.board_seq}, function(data){
			$scope.catlist = data;
		});
	};
	
	$scope.commentform = {
		article_seq : ''	
	}
	
	<%-- ajaxService.getJSON("<c:url value="/super/bbs/F/view.do"/>", {article_seq : $routeParams.seq, board_seq : $scope.param.board_seq, del_yn : $scope.param.del_yn}, function(data){
		angular.extend($scope.form,data.view);
		$scope.commentform.article_seq = data.view.article_seq;
		$scope.form.files = data.files;
		$scope.form.removeFiles = []; --%>
	ajaxService.getJSON("<c:url value="/super/bbs/F/view.do"/>", {article_seq : $routeParams.seq, board_seq : $scope.param.board_seq, del_yn : $scope.param.del_yn}, function(data){
		angular.extend($scope.form, data.view);
		$scope.form.files = data.files;
		$scope.form.removeFiles = [];
		$scope.form.reports = data.reports;
	});
	
	$scope.removeFile = function(idx){
		$scope.form.removeFiles.push($scope.form.files[idx]);
		$scope.form.files.splice(idx, 1);
	}
	
	$scope.addFile = function(data){
		$scope.$apply(function(){
			$scope.form.files.push(data);
		});
	}
	
	$scope.uploadFile = function(){
		$scope.form.width = "0";
		$scope.form.height = "0";
		$scope.$apply();
		
		var filename = $("#file").val();
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
			
			ajaxService.getJSON("<c:url value="/super/bbs/F/modify.do"/>", {jData : angular.toJson($scope.form)}, function(data){
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
	
<%--
	if($rootScope.param.comment_yn == 'Y'){
		ajaxService.getJSON("<c:url value="/super/bbs/F/commentList.do"/>", {article_seq : $routeParams.seq}, function(data){
			$scope.comment = data.list;
		});
	}
	
	$scope.commentSubmit = function(){
		if($scope.cfrm.$invalid){
			if($scope.cfrm.$error.required){
				alert("필수값을 입력하여 주십시오.");
			}else{
				alert("값이 유효하지 않습니다.");
			}
			$("#cFrm .ng-invalid")[0].focus();
			return false;
		}
		$scope.cfrm.article_seq = $routeParams.seq;
		ajaxService.getJSON("<c:url value="/super/homepage/bbs/F/commentInsert.do"/>", {jData : JSON.stringify($scope.cfrm)}, function(data){
			ajaxService.getJSON("<c:url value="/super/homepage/bbs/F/commentList.do"/>", {article_seq : $routeParams.seq}, function(data){
				$scope.cfrm.conts = "";
				$scope.comment = data.list;
			});
		});	
	}
		
	$scope.commentReplyOpen = function(idx){
		$(".comment_reply").css("display","none");
		$("#cp"+idx).val("");
		$("#c"+idx).css("display","block");
		return false;		
	}

	$scope.commentReplyClose = function(idx){
		$("#c"+idx).css("display","none");
		return false;		
	}

	$scope.commentReply = function(item){
		var textarea = $("#cp"+item.comment_seq).val();
		if(textarea != ""){
			var array = {
				conts : textarea,
				comment_seq : item.comment_seq,
				reg_id : item.reg_id,
				article_seq : $routeParams.seq,
				ref_num : item.ref_num,
				step_num : item.step_num,
				depth_num : item.depth_num
			}
			ajaxService.getJSON("<c:url value="/super/homepage/bbs/F/commentReply.do"/>", {jData : JSON.stringify(array)}, function(data){
				ajaxService.getJSON("<c:url value="/super/homepage/bbs/F/commentList.do"/>", {article_seq : $routeParams.seq}, function(data){
					$scope.comment = data.list;
				});
			});				
		}
	}

	$scope.commentDel = function(item){
		if(confirm("정말 삭제하시겠습니까?")){
			ajaxService.getJSON("<c:url value="/super/homepage/bbs/F/commentDelete.do"/>", {jData : JSON.stringify(item)}, function(data){
				ajaxService.getJSON("<c:url value="/super/homepage/bbs/F/commentList.do"/>", {article_seq : $routeParams.seq}, function(data){
					$scope.comment = data.list;
				});
			});	
		}
	}

	$scope.commentUpdateWindow = function(items){
		var options = {
			autoOpen: false,
			modal: true,
			width: "750",
			height: "180",
			close: function(event, ui) {}
		};
		dialogService.open("commentUpdate","<c:url value="/lib/js/partials/adminComment.html"/>", angular.copy(items), options).then(
			function(result) {
				ajaxService.getJSON("<c:url value="/super/homepage/bbs/F/commentList.do"/>", {article_seq : $routeParams.seq}, function(data){
					$scope.comment = data.list;
				});
			},
			function(error) {}
		);
	}
	
 	$scope.commentUpdate = function(){
		ajaxService.getJSON("<c:url value="/super/homepage/bbs/F/commentReplyUpdate.do"/>", {jData : JSON.stringify($scope.model)}, function(data){
			dialogService.close("commentUpdate", "");
		});
	}
 --%>
	
});
