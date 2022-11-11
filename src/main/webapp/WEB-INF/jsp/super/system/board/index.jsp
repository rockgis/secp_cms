<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 설정 및 관리</title>
<script type="text/javascript" src="<c:url value="/lib/js/angular.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/angular-route.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/filters/myFilter.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/filters/ngRange.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/services/myCommon.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/services/dialog-service.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/myUtil.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/myPagination.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/sortable.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/myEditor.js"/>"></script>
<script type="text/javascript">
var app = angular.module("MyApp", ['dialogService', 'ngRoute', 'myUtil', 'myPagination', 'myCommon', 'ui.sortable', 'myFilter', 'myEditor', 'ngRange']);

app.run(function($rootScope,$location,ajaxService){
	$rootScope.list = function(){
		$location.path("/");
	};
	$rootScope.param = {
		filter_set_seq : 1,
		use_yn : ''
	};
	
	$rootScope.boardType = {};
	ajaxService.getSyncJSON('<c:url value="/super/system/board/type_list.do"/>', {}, function(data){
		$rootScope.boardType = data;
	});
});
app.factory('linkListFactory', function(ajaxService, dialogService) {
	var service = {};
	service.getList = function(boardSeq){
		var rst = [];
		ajaxService.getSyncJSON('<c:url value="/super/system/board/menu_list.do"/>', {board_seq : boardSeq}, function(data){
			rst = data.list;
		});
		return rst;
	}
	service.openLink = function(url){
		var newWindow = window.open("about:blank");
		newWindow.location.href=url;
	}
	return service;
});

app.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
	$routeProvider
		.when('/list', {controller: 'listCtrl', templateUrl : 'st_exclude/list.do'})
		.when('/write', {controller: 'writeCtrl', templateUrl : 'st_exclude/write.do'})
		.when('/modify/:seq', {controller: 'modifyCtrl', templateUrl : 'st_exclude/modify.do'})
		.otherwise({redirectTo: '/list' });
}]);



app.controller("listCtrl", function($rootScope, $scope, $window, $routeParams, $compile, $location, ajaxService, dialogService, $filter) {
	$scope.board = {
		param : {
			cpage : 1,
			row : 10
		}	
	};
	$scope.board.go = function(n){
		$scope.board.param.cpage=n;
		ajaxService.getSyncJSON('<c:url value="/super/system/board/list.do"/>?cpage='+n, $scope.param, function(data){
			$scope.board.list = data.list;
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.pagination.totalcount;
			$scope.board.totalPage = data.pagination.totalpage;
		});
	};
	
	$scope.openLinkList = function(item){
		var options = {
				title : '메뉴 목록',
				autoOpen: false,
				modal: true,
				width: "630",
				height: "480",
				close: function(event, ui) {
				}
			};
		dialogService.open("LinkListDialog", "/st_exclude/super/system/board/LinkListTemplete.do", item, options)
		.then(
			function(result) {
			},
			function(error) {
			}
		);
	}
	
	/* $scope.board = {};
	var p = $location.search();
	angular.extend($scope.param, {
		rows : p.rows||10,
		cpage : p.cpage||1,
		condition : p.condition||'A.TITLE',
		keyword : p.keyword||'',
		del_yn : p.del_yn||'N'
	});
	ajaxService.getJSON('<c:url value="/super/system/board/list.do"/>', $scope.param, function(data){
		$scope.board.list = data.list;
		$scope.board.currentPage = $scope.param.cpage;
		$scope.board.totalCount = data.pagination.totalcount;
		$scope.board.totalPage = data.pagination.totalpage;
	});
	$scope.board.go = function(n){
		$scope.param.cpage=n;
		$location.search($scope.param);
	}; */
	
	$scope.bindBoardType = function(boardType){
		var returnName = "";
		$.each($scope.boardType,function(i,v){
			if(typeof v != "undefined"){
				if(v.type == boardType){
					returnName = v.name;
				}
			}
		});
		return returnName;
	};
	
	$scope.boardDel = function(item){
		if(item.user_page_cnt > 0){
			alert("사용중인 게시판은 삭제 할 수 없습니다. 연결을 해지 후 삭제 해 주세요.");
			return false;
		}
		if(confirm("선택하신 게시판을 삭제하시겠습니까?")){
			ajaxService.getJSON("<c:url value="/super/system/board/delete.do"/>", {board_seq : item.board_seq}, function(data){
				alert("삭제되었습니다.");
				$scope.board.go(1);
			});
		}
	}
	
	$scope.boardCreate = function(){
		var options = {
			autoOpen: false,
			modal: true,
			width: "700",
			height: "700",
			close: function(event, ui) {}
		};
			
		dialogService.open("adminBoardManagement","adminBoardManagement.html", {}, options).then(
			function(result) {
			},
			function(error) {}
		);
	}
});

app.controller("writeCtrl", function($rootScope, $scope, $window, $routeParams, $compile, ajaxService, dialogService, $filter) {
	$scope.form = {
			cat_size : [],
			cat_nm: [],
			state_size : [],
			state_nm: [],
			custom: [],
			user_agree: [],
			rows_text : '10,20,30',
			cclnuri_yn : '',
			comment_yn : 'N',
			comment_target : 'U'
	};
	$scope.column_list = [];
	$scope.rowlist = [];
	
	$scope.rows_array = function(){
		var rows_text = $scope.form.rows_text;		
		if(!!rows_text){
			var rows = rows_text.split(",");
			if(rows.length > 0){
				$scope.rowlist = [];
				$.map(rows, function(i){
					$scope.rowlist.push(i);
				});
			}
		}
	}
	$scope.rows_array();
	
	ajaxService.getJSON('<c:url value="/super/system/board/customColumnList.do"/>', {}, function(data){
		$scope.column_list = data;
	});

	
	$scope.removeCat = function(idx){
		$scope.form.cat_size.splice(idx, 1);
		$scope.form.cat_nm.splice(idx, 1);
	}
	$scope.removeState = function(idx){
		$scope.form.state_size.splice(idx, 1);
		$scope.form.state_nm.splice(idx, 1);
	}
	$scope.removeElement = function(idx){
		$scope.form.custom.splice(idx, 1);
	}
	
	
	$scope.addCat = function(){
		$scope.form.cat_size.push({cat_nm:''});
		$scope.form.cat_nm.push({cat_nm:''});
	}
	$scope.addState = function(){
		$scope.form.state_size.push({state_nm:''});
		$scope.form.state_nm.push({state_nm:''});
	}
	$scope.addElement = function(){
		var elements = {
			element : '',
			column_name : '',
			user_list_element : 'Y',
			user_list_col : '10%',
			user_view_element : 'Y',
			user_insert_element : 'Y',
			user_modify_element : 'Y',
			admin_list_element : 'Y',
			admin_list_col : '10%',
			admin_insert_element : 'Y',
			admin_modify_element : 'Y'			
		}
		$scope.form.custom.push(elements);
	}
	
	$scope.baseElement = function(){
		var baseElements = [
			{
				element : '',
				column_name : 'title',
				user_list_element : 'Y',
				user_list_col : '10%',
				user_view_element : 'Y',
				user_insert_element : 'Y',
				user_modify_element : 'Y',
				admin_list_element : 'Y',
				admin_list_col : '10%',
				admin_insert_element : 'Y',
				admin_modify_element : 'Y',
				order_num : 999
			},
			{
				element : '',
				column_name : 'conts',
				user_list_element : 'Y',
				user_list_col : '10%',
				user_view_element : 'Y',
				user_insert_element : 'Y',
				user_modify_element : 'Y',
				admin_list_element : 'Y',
				admin_list_col : '10%',
				admin_insert_element : 'Y',
				admin_modify_element : 'Y',
				order_num : 999
			}
		];
		$scope.form.custom = baseElements;
	}
	
	
	$scope.catAdd = function(){
		if($scope.form.cat_yn == 'Y'){
			$("#catTr").css("display","");
		}else{
			$("#catTr").css("display","none");
			$scope.form.cat_size = [];
			$scope.form.cat_nm = [];
		}
	}
	
	$scope.stateAdd = function(){
		if($scope.form.board_type == 'C'){
			$("#stateTr").css("display","");
			$("#customTr").css("display","none");
			$("#agreeTr").css("display","none");
			$scope.form.comment_yn = 'Y';
			$scope.form.custom = [];
			$scope.form.user_agree = [];
			$scope.form.agree_yn = 'N';
		}else if($scope.form.board_type == 'F'){
			$("#customTr").css("display","");
			$("#agreeTr").css("display","");
			$("#stateTr").css("display","none");
			$scope.form.state_size = [];
			$scope.form.state_nm = [];
			$scope.baseElement();
		}else{
			$("#stateTr").css("display","none");
			$("#customTr").css("display","none");
			$("#agreeTr").css("display","none");
			$scope.form.custom = [];
			$scope.form.state_size = [];
			$scope.form.state_nm = [];
			$scope.form.user_agree = [];
			$scope.form.agree_yn = 'N';
		}
		
		if($scope.form.board_type == 'B'){
			$scope.form.file_yn = 'N';	
		}
		else if($scope.form.board_type == 'E'){
			$scope.form.file_yn = 'N';	
			$scope.form.insert_yn = 'N';	
		}
	}
	
	//+++++++++++++++++++++++++++++++++++++++++++++
	//사용자 등록허용(개인정보 수집 체크약관 체크)
	$scope.useAgree = function(){
		if($scope.form.agree_yn == 'Y'){
			$("#rp_wrap").css("display","");
		}else{
			$("#rp_wrap").css("display","none");
			$scope.form.user_agree = [];
		}
	}
	
	$scope.addAgree = function(){
		if($scope.form.user_agree.length<3){
			$scope.form.user_agree.push(
					{
						agree_tit:'',
						agree_cont:'',
						agree_check:'Y',
						agree_order : $scope.form.user_agree.length + 1
					});	
		}else{
			alert("최대 3개까지 추가 할 수 있습니다.");
		}				
	}
	
	$scope.removeAgree = function(idx){
		$scope.form.user_agree.splice(idx, 1);
		$.each($scope.form.user_agree,function(i){
			this.agree_order = i+1;
		});
	}	
	//+++++++++++++++++++++++++++++++++++++++++++++
	
	
	var temp_orderOption = {
			oldIndex : -1,
			newIndex : -1
	}; 
	$scope.temp_order = {}
	$scope.temp_order = temp_orderOption;
	
	$("#customTd > #tables").sortable({
		axis: 'y',
		placeholder: "ui-state-highlight",
		start : function(evnet, ui){
			var i = $(ui.item);
			$scope.temp_order.oldIndex = i.index();
		},
		stop : function(evnet, ui){
			$scope.$apply(function(){
				var i = $(ui.item);
				$scope.temp_order.newIndex = i.index();
				var toMove = $scope.form.custom[$scope.temp_order.oldIndex];
				$scope.form.custom.splice($scope.temp_order.oldIndex, 1);
				$scope.form.custom.splice($scope.temp_order.newIndex, 0, toMove);
				$.each($scope.form.custom,function(i){
					this.order_num = i;
				});
				$scope.form.custom = angular.copy($scope.form.custom);
			});			
		}
		
	}).disableSelection();
	
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
	
		ajaxService.getJSON('<c:url value="/super/system/board/insert.do"/>', {jData : angular.toJson($scope.form)}, function(data){
			alert("등록이 완료 되었습니다.");
			$rootScope.list();
		});
	}
});

app.controller("modifyCtrl", function($rootScope, $scope, $window, $routeParams, $compile, ajaxService, dialogService, $filter, linkListFactory) {
	$scope.form = {
			cat_size : [],
			cat_nm: [],
			remove_cat : [],
			state_size : [],
			state_nm: [],
			remove_state : [],
			custom:[],
			user_agree:[],
			rows_text : '10,20,30'
	};
	$scope.column_list = [];
	$scope.rowlist = [];

	$scope.rows_array = function(){
		var rows_text = $scope.form.rows_text;		
		if(!!rows_text){
			var rows = rows_text.split(",");
			if(rows.length > 0){
				$scope.rowlist = [];
				$.map(rows, function(i){
					$scope.rowlist.push(i);
				});
			}
		}
	}	
	
	ajaxService.getSyncJSON('<c:url value="/super/system/board/customColumnList.do"/>', {}, function(data){
		$scope.column_list = data;
	});
	
	var data_info = {};
	ajaxService.getSyncJSON('<c:url value="/super/system/board/info.do"/>', {board_seq:$routeParams.seq}, function(data){
		data_info = data.info;
		$scope.form = data.info;
		if($scope.form.cat_yn == 'Y'){
			$("#addBtn").css("display","");
			$("#catTr").css("display","");
			$scope.form.cat_nm = data.cat_info;
			$scope.form.cat_size = data.cat_info;
		}else{
			$scope.form.cat_size = [];
			$scope.form.cat_nm = $scope.form.cat_size;
		}
		if($scope.form.board_type == 'C'){
			$("#stateTr").css("display","");
			$scope.form.state_nm = data.state_info;
			$scope.form.state_size = data.state_info;
		}else if($scope.form.board_type == 'F'){
			if($scope.form.agree_yn == 'Y'){
				$("#agreeTr").css("display","");
				$scope.form.user_agree = data.agree_info;	
			}else{
				$("#agreeTr").css("display","");
				$scope.form.user_agree = [];
			}
			
			$("#customTr").css("display","");
			ajaxService.getJSON('<c:url value="/super/system/board/element_list.do"/>', {board_seq:$routeParams.seq}, function(data){
				$scope.form.custom = data;
			});
		}else{
			$scope.form.state_size = [];
			$scope.form.state_nm = $scope.form.state_size;
		}
		$scope.form.remove_cat = [];
		$scope.form.remove_state = [];
		$scope.rows_array();

	});
	
	//+++++++++++++++++++++++++++++++++++++++++++++
	//사용자 등록허용(개인정보 수집 체크약관 체크)
	$scope.useAgree = function(){
		if($scope.form.agree_yn == 'Y'){
			$("#rp_wrap").css("display","");
		}else{
			$("#rp_wrap").css("display","none");
			$scope.form.user_agree = [];
		}
	}
	
	$scope.addAgree = function(){
		if($scope.form.user_agree.length<3){
			$scope.form.user_agree.push(
					{
						agree_tit:'',
						agree_cont:'',
						agree_check:'Y',
						agree_order:$scope.form.user_agree.length + 1
					});	
		}else{
			alert("최대 3개까지 추가 할 수 있습니다.");
		}				
	}
	
	$scope.removeAgree = function(idx){
		$scope.form.user_agree.splice(idx, 1);
		$.each($scope.form.user_agree,function(i){
			this.agree_order = i+1;
		});
	}	
	//+++++++++++++++++++++++++++++++++++++++++++++
	
	var temp_orderOption = {
			oldIndex : -1,
			newIndex : -1
	}; 
	$scope.temp_order = {}
	$scope.temp_order = temp_orderOption;
	
	$("#customTd > #tables").sortable({
		axis: 'y',
		placeholder: "ui-state-highlight",
		start : function(evnet, ui){
			var i = $(ui.item);
			$scope.temp_order.oldIndex = i.index();
		},
		stop : function(evnet, ui){
			$scope.$apply(function(){
				var i = $(ui.item);
				$scope.temp_order.newIndex = i.index();
				var toMove = $scope.form.custom[$scope.temp_order.oldIndex];
				$scope.form.custom.splice($scope.temp_order.oldIndex, 1);
				$scope.form.custom.splice($scope.temp_order.newIndex, 0, toMove);
				$.each($scope.form.custom,function(i){
					this.order_num = i;
				});
				$scope.form.custom = angular.copy($scope.form.custom);
			});			
		}
		
	}).disableSelection();
	
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
		
		ajaxService.getJSON('<c:url value="/super/system/board/modify.do"/>', {jData : angular.toJson($scope.form)}, function(data){
			alert("수정이 완료 되었습니다.");
			$rootScope.list();
		});
	}
	
	
	$scope.addCat = function(){
		$scope.form.cat_size.push({cat_nm:''});
	}
	
	$scope.removeCat = function(idx){
		$scope.form.remove_cat.push($scope.form.cat_nm[idx]);
		$scope.form.cat_nm.splice(idx, 1);
	}
	$scope.removeElement = function(idx){
		$scope.form.custom.splice(idx, 1);
	}
	
	$scope.addElement = function(){
		var elements = {
			element : '',
			column_name : '',
			user_list_element : 'Y',
			user_list_col : '',
			user_view_element : 'Y',
			user_insert_element : 'Y',
			user_modify_element : 'Y',
			admin_list_element : 'Y',
			admin_list_col : '',
			admin_insert_element : 'Y',
			admin_modify_element : 'Y',
			del_yn : 'Y',
			order_num : $scope.form.custom.length 
		}
		$scope.form.custom.push(elements);
	}
	
	$scope.baseElement = function(){
		var baseElements = [
			{
				element : '',
				column_name : 'title',
				user_list_element : 'Y',
				user_list_col : '',
				user_view_element : 'Y',
				user_insert_element : 'Y',
				user_modify_element : 'Y',
				admin_list_element : 'Y',
				admin_list_col : '',
				admin_insert_element : 'Y',
				admin_modify_element : 'Y'
			},
			{
				element : '',
				column_name : 'conts',
				user_list_element : 'Y',
				user_list_col : '',
				user_view_element : 'Y',
				user_insert_element : 'Y',
				user_modify_element : 'Y',
				admin_list_element : 'Y',
				admin_list_col : '',
				admin_insert_element : 'Y',
				admin_modify_element : 'Y'
			}
		];
		$scope.form.custom = baseElements;
	}
	
	$scope.catAdd = function(){
		if($scope.form.cat_yn == 'Y'){
			$("#catTr").css("display","");
		}else{
			$("#catTr").css("display","none");
			$.each($scope.form.cat_nm,function(k,v){
				$scope.form.remove_cat.push(v);				
			});			
			$scope.form.cat_size = [];
			$scope.form.cat_nm = [];
		}
	}
	
	
	$scope.addState = function(){
		$scope.form.state_size.push({state_nm:''});
		//$scope.form.state_nm.push({state_nm:''});
	}
	
	$scope.removeState = function(idx){
		$scope.form.remove_state.push($scope.form.state_nm[idx]);
		$scope.form.state_nm.splice(idx, 1);
	}
	
	$scope.stateAdd = function(){
		if($scope.form.board_type == 'C'){
			$("#stateTr").css("display","");
			$scope.form.comment_yn = 'Y';
		}else if($scope.form.board_type == 'B'){
			$scope.form.file_yn = 'N';
		}else if($scope.form.board_type == 'E'){
			$scope.form.file_yn = 'N';	
			$scope.form.insert_yn = 'N';
		}else if($scope.form.board_type == 'F'){
			$("#customTr").css("display","");
			$scope.baseElement();
		}
		
		if($scope.form.board_type != 'C'){
			$("#stateTr").css("display","none");
			$scope.form.state_size = [];
			$scope.form.state_nm = [];
		}
	}
	
	$scope.menuList = linkListFactory.getList($scope.form.board_seq);
	$scope.openLink = linkListFactory.openLink;
});


app.controller("managementCtrl", function($rootScope, $scope, $window, $routeParams, $compile, ajaxService, dialogService, $filter) {
	$scope.board = {};
	$scope.boardList = angular.copy($rootScope.boardType);
	$scope.save = function(item){
		$.each(item,function(i,v){
			if(v == null || v == ""){
				alert("값을 입력하시기 바랍니다.");
				return false;
			}
		});
		ajaxService.getJSON('<c:url value="/super/system/board/type_modify.do"/>', {jData : angular.toJson(item)}, function(data){
			alert(data.msg);
			$rootScope.boardType = data.list;
			$scope.boardList = angular.copy($rootScope.boardType);
		});
	}
	
	$scope.del = function(item){
		if(confirm("선택하신 타입을 삭제하시겠습니까?")){
			ajaxService.getJSON('<c:url value="/super/system/board/type_delete.do"/>', {jData : angular.toJson(item)}, function(data){
				alert(data.msg);
				$rootScope.boardType = data.list;
				$scope.boardList = angular.copy($rootScope.boardType);
			});
		}
	}
	
	$scope.create = function(){
		if($scope.frm.$invalid){
			if($scope.frm.$error.required){
				alert("필수값을 입력하여 주십시오.");
			}else{
				alert("값이 유효하지 않습니다.");
			}
			$("#wFrm .ng-invalid")[0].focus();
			return false;
		}
		ajaxService.getJSON('<c:url value="/super/system/board/type_insert.do"/>', {jData : angular.toJson($scope.obj)}, function(data){
			alert(data.msg);
			$rootScope.boardType = data.list;
			$scope.boardList = angular.copy($rootScope.boardType);
			dialogService.close("adminBoardManagement");
		});
	}
});
app.controller("linkListCtrl", function($scope, $window, ajaxService, dialogService, linkListFactory) {
	$scope.menuList = linkListFactory.getList($scope.model.board_seq);
	$scope.openLink = linkListFactory.openLink;
	
	$scope.close = function(){
		dialogService.close("LinkListDialog");
	}
});
</script>
</head>
<body data-ng-controller="mainCtrl">
	<div data-ng-view data-ng-cloak></div>
<script type="text/ng-template" id="adminBoardManagement.html">
<div class="contents" data-ng-controller="managementCtrl">
<div class="fn_wrap">
	<div style="color:red; font-weight:bold;">※ 타입생성은 개발PC에서 하시기바랍니다.
	<h4>개발PC에서 생성시 개발에 필요한 java,jsp파일을 자동생성합니다.</h4>
	<h4>자동생성된 게시판은 일반게시판(A)타입과 동일하며 개발자가 커스트마이징하여 사용가능합니다.</h4>
	<h4>타입코드는 알파벳 대문자 한자리를 원칙으로 합니다.</h4>
	<h4>변경 삭제시에는 개발자가 직접 소스수정을 해주어야 합니다.</h4>
	</div>
</div>
<form id="wFrm" name="frm" method="post" novalidate="novalidate">
<table class="type1">
  <col width="133px" />
  <col width="*" />
  <col width="70px" />
	<thead>
		<tr>
			<th class="center">타입코드</th>
			<th class="center">타입명</th>
			<th class="center">등록</th>
		</tr>
	</thead>
	<tbody id="listWrap">
		<tr>
			<td class="center"><input type="text" class="normal" data-ng-model="obj.board_type" style="width:100%;" ng-Maxlength="2" maxlength="2" required/></td>
			<td class="center"><input type="text" class="normal" data-ng-model="obj.name" style="width:100%;" required/></td>
			<td class="center">
				<input type="button" data-ng-click="create()" class="btalls" value="등록"/></span>
			</td>
		</tr>
	</tbody>
</table>
</form>
<table class="type1">
  <col width="8%" />
  <col width="12%" />
  <col width="%" />
  <col width="22%" />
	<thead>
		<tr>
			<th class="center">번호</th>
			<th class="center">타입코드</th>
			<th class="center">타입명</th>
			<th class="center">관리</th>
		</tr>
	</thead>
	<tbody id="listWrap">
		<tr data-ng-if="boardList.length==0"><td colspan="3" class="center">결과가 없습니다.</td></tr>
		<tr data-ng-repeat="item in boardList">
			<td class="center">{{$index+1}}</td>
			<td class="center"><input type="text" class="normal" data-ng-model="item.board_type" value="{{item.board_type}}" style="width:100%;" maxlength="2" /></td>
			<td class="center"><input type="text" class="normal" data-ng-model="item.name" value="{{item.name}}" style="width:100%;" maxlength="30" /></td>
			<td class="center">
				<button data-ng-click="save(item)" class="bt_small modify" value="수정">수정</button>
				<button data-ng-click="del(item)" class="bt_small delete" value="삭제">삭제</button>
			</td>
		</tr>
	</tbody>
</table>
</div>
</script>
</body>
</html>