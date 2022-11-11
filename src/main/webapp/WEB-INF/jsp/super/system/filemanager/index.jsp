<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<c:set var="site_id" value="${empty cookie.adh_menu_current_siteid ? '1' : cookie.adh_menu_current_siteid.value }"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/lib/js/jstree/themes/default/style.css" />
<style type="text/css">
.mCSB_outside+.mCSB_scrollTools {right: -7px;}

.tfilelist table{table-layout:fixed; border-bottom:1px solid #e3e5e6;background:#f8f8f8;}
.tfilelist table th{padding:10px; color:#777; background:#f8f8f8; border-bottom:solid 2px #e3e5e6;}

#filelist table{table-layout:fixed; border-bottom:1px solid #e3e5e6;}
#filelist table th{padding:10px; color:#777; background:#f8f8f8; border-bottom:solid 2px #e3e5e6;}
#filelist table td{padding:10px; border-bottom:1px solid #e3e5e6;}
#filelist table td.center{text-align:center;}
#filelist table tr:hover td{background:#f5f5f5;}
</style>
<title>홈페이지 소스 관리</title>
<script type="text/javascript" src="<c:url value="/lib/js/angular.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/angular-route.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/filters/myFilter.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/filters/ngRange.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/services/myCommon.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/services/dialog-service.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/myUtil.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/myPagination.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/route/routeResolver.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/myEditor.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jstree/jstree.js"/>"></script>
<script type="text/javascript" src="/lib/js/directives/sortable.js"></script>

<link rel="stylesheet" href="/lib/codemirror/lib/codemirror.css">
<script src="/lib/codemirror/lib/codemirror.js"></script>
<script src="/lib/codemirror/mode/xml/xml.js"></script>
<script src="/lib/codemirror/mode/javascript/javascript.js"></script>
<script src="/lib/codemirror/mode/css/css.js"></script>
<script src="/lib/codemirror/mode/htmlmixed/htmlmixed.js"></script>
<script type="text/javascript">
var app = angular.module("MyApp", ['routeResolverServices', 'dialogService', 'ngRoute', 'myUtil', 'myPagination', 'myCommon', 'myFilter', 'ngRange', 'myEditor']);
app.directive("scrollable", ["$timeout", function ($timeout) {
	return {
		link: function (scope, elem, attrs, ctrls) {
			$timeout(function(){
				var w = elem.width();
// 				elem.width(scope[attrs.scrollable].width);
// 				$("div.dept_container", elem).width(w);
				elem.mCustomScrollbar({
					axis:"yx",
					theme:"dark",
					scrollbarPosition:"outside"
				});
			});
		}
	};
}]);
app.run(function($rootScope){
	$rootScope.param = {site_id : "${site_id}"};
});

app.config(['$routeProvider', '$locationProvider', 'routeResolverProvider', '$controllerProvider', '$compileProvider', '$filterProvider', '$provide', function($routeProvider, $locationProvider, routeResolverProvider, $controllerProvider, $compileProvider, $filterProvider, $provide) {
	app.register =
    {
        controller: $controllerProvider.register,
        directive: $compileProvider.directive,
        filter: $filterProvider.register,
        factory: $provide.factory,
        service: $provide.service
    };
	var pathname = location.pathname;
	var path = pathname.substring(0, pathname.lastIndexOf("/"));
	routeResolverProvider.routeConfig.setBaseDirectories(path, path);
	
	var route = routeResolverProvider.route;
	
	$routeProvider
	    .when('/modify', route.resolve("modify"))
		.otherwise({redirectTo: '/modify' });
}]);
app.controller("mainCtrl", function($scope, $location, ajaxService) {
	$scope.main = {
	};
});
app.controller("FileModifyCtrl", function($scope, $window, $compile, ajaxService, dialogService) {
	$scope.form = {};
	var initTrue = true;
	$.extend($scope.param, {rows:10, file_path : $scope.model.file_path});

	ajaxService.getJSON("/super/system/filemanager/getRealFile.do", {file_path : $scope.model.file_path}, function(data){
		if(data.rst=="-1"){
			alert("열람하실수 없는 파일입니다.");
			$scope.cancel();
		}else{
			$scope.form.source = data.source;
			$scope.form.encoding = data.encoding;
		}
	});

	$scope.getPrevious = function(seq){
		ajaxService.getJSON("/super/system/filemanager/previous_source.do", {seq : seq}, function(data){
			$scope.form.source = data.code_text;
		});
	}
	
	$scope.board = {};
	$scope.board.go = function(n){
		$scope.param.cpage = n;
		ajaxService.getJSON('<c:url value="/super/system/filemanager/source_list.do"/>', $scope.param, function(data){
			$scope.board.list = data.list;
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.pagination.totalcount;
			$scope.board.totalPage = data.pagination.totalpage;
		});
	};
	$scope.board.go(1);
	
	$scope.save = function(){
		if(!confirm("저장하시겠습니까?")){
			return false;
		}
		var p = {jData : angular.toJson({file_path : $scope.model.file_path, source : $scope.form.source, encoding : $scope.form.encoding})};
		ajaxService.getJSON("/super/system/filemanager/modifyRealFile.do", p, function(data){
			if(data.rst=="-1"){
				alert("수정하실수 없는 파일입니다.");
				$scope.cancel();
			}else{
				$scope.cancel();
			}
		});
	}
	
	$scope.cancel = function(){
		dialogService.cancel("FileModifyDialog");
	}
});
app.controller("UploadFormCtrl", function($scope, $window, $compile, ajaxService, dialogService) {
	$scope.upload = function(ignore){
		var filename = $("#file").val();
		filename = filename.slice(filename.indexOf(".") + 1).toLowerCase();
		if(filename == ""){
			return false;
		}
		if($.inArray(filename, ["zip","alz","jpg","png","jpeg","gif","bmp","wav","wma","avi","mp3","mp4","asf","mpeg","wmv","hwp","txt","doc","xls","ppt","xlsx", "docx", "pptx","pdf"]) < 0 ){
			alert("올리실수 없는파일입니다.");			
			return false;
		}
    	$("#wFrm").ajaxSubmit({
    		url : '<c:url value="/super/system/filemanager/upload.do"/>',
    		iframe: true,
    		data : {file_path:$scope.model.path, file_name : 'file', ignore: ignore},
    		dataType : "json",
    		success : function(data){
    			if(data.rst=="D" && ignore!="Y"){
					if(confirm("같은파일명이 이미 존재합니다.\n덮어씌우시겠습니까?")){
						$scope.upload("Y");
					}else{
		    			dialogService.close("UploadFormDialog", data);
					}
				}else{
	    			dialogService.close("UploadFormDialog", data);
				}
    		},
    		error: function(e){
    			alert(e.responseText);
    		}
    	});
	};
	
	$scope.cancel = function(){
		dialogService.cancel("UploadFormDialog");
	}
});
</script>
</head>
<body>
	<div class="titlebar">
		<h2>홈페이지 소스 관리</h2>
		<div>
			<span>시스템 관리</span>&gt; <span>시스템 설정 및 관리</span>&gt;
			<span class="bar_tx">홈페이지 소스 관리</span>
		</div>
	</div>
	<div data-ng-controller="mainCtrl">
		<div style="overflow:hidden;" data-ng-view data-ng-cloak></div>
	</div>

<script type="text/ng-template" id="FileModify.html">
	<div ng-controller="FileModifyCtrl" title="소스 관리" style="overflow:hidden; padding:15px;">
	<style>div.CodeMirror{float:left; background:#ddd;}</style>
		<textarea ng-model="form.source" global-editor="mi-editor" ng-height="'500px'" ng-width="'700px'" style="overflow-y:scroll;"></textarea>
		<div class="history" style="float:right;">
			<table class="type2" style="width:250px; border:none;">
		 	 	<colgroup>
					<col width="50%">
					<col width="*">
					<col width="18%">
				</colgroup>
				<thead>
					<tr>
						<th colspan="3" class="center">수정이력</th>
					</tr>
				</thead>
				<tbody style="font-size:11px;">
					<tr data-ng-repeat="item in board.list">
						<td class="center"><span style="">{{item.reg_dt}}</span></td>
						<td class="center"><span style="">{{item.reg_nm}}</span></td>
						<td class="center"><a style="display:inline-block; padding:1px 5px 1px 4px; border-radius:3px; color:#fff; background:#20b9ae; text-decoration:none;" ng-click="getPrevious(item.seq)">복원</a></td>
					</tr>
				</tbody>
			</table>
			<pagination style="border-top:none;" total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)" ng-mode="mini"></pagination>
		</div>
		<div style="position:absolute; bottom:15px; right:15px;"><input type="button" class="bt_big_bt4" value="저장하기" ng-click="save()"></div>
	</div>
</script>

<script type="text/ng-template" id="UploadForm.html">
	<div ng-controller="UploadFormCtrl" title="파일추가" style="overflow:hidden; padding:15px;">
    <form id="wFrm" name="frm" method="post" novalidate="novalidate" enctype="multipart/form-data">
<sec:csrfInput />
    <table class="type1">
    	<colgroup>
          	<col width="20%" />
          	<col width="*" />
        </colgroup>
		<tr>
		  	<th>경로</th>
		  	<td ng-bind="model.path"></td>
		</tr>
		<tr>
		  	<th>
				파일
		  	</th>
		  	<td>
	        	<input type="file" name="file" id="file"/>
		  	</td>
		</tr>
    </table>
	<div class="btn_bottom">
        <div class="r_btn">
         	<input type="button" value="등록" class="bt_big_bt4" data-ng-click="upload()"/>
         	<input type="button" value="취소" class="bt_big_bt3" data-ng-click="cancel()"/>
        </div>
    </div>
	</form>   
	</div>
</script>
</body>
</html>
