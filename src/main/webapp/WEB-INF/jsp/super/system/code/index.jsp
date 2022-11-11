<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/lib/css/colorpicker.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.dropdown-menu {
    float: left;
    margin: 2px 0 0;
    background-color: #fff;
    -webkit-background-clip: padding-box;
    background-clip: padding-box;
    border: 1px solid #ccc;
    border: 1px solid rgba(0,0,0,.15);
    border-radius: 4px;
    -webkit-box-shadow: 0 6px 12px rgba(0,0,0,.175);
    box-shadow: 0 6px 12px rgba(0,0,0,.175);
}
.dropdown-menu {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
.close {
    float: right;
    font-size: 21px;
    font-weight: 700;
    line-height: 1;
    color: #000;
    text-shadow: 0 1px 0 #fff;
    filter: alpha(opacity=20);
    opacity: .2;
}
</style>
<title>공통코드 관리</title>
<script type="text/javascript" src="<c:url value="/lib/js/angular.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/angular-route.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/filters/myFilter.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/filters/ngRange.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/services/myCommon.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/services/dialog-service.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/myUtil.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/myPagination.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/sortable.js"/>"></script>
<script type="text/javascript" src="/lib/js/bootstrap-colorpicker-module.js"></script>
<script type="text/javascript">
var app = angular.module("MyApp", ['dialogService', 'ngRoute', 'myUtil', 'myPagination', 'myCommon', 'ui.sortable', 'myFilter', 'ngRange', 'colorpicker.module']);
app.run(function($rootScope){
	$rootScope.main = {};
	$rootScope.param = {
	};
});

app.controller("mainCtrl", function($scope, $window, $routeParams, $compile, ajaxService, dialogService, $filter) {
	$scope.group = {};
	$scope.code = {};
	$scope.group.go = function(n){
		ajaxService.getJSON('<c:url value="/super/code/list.do"/>?cpage='+n, $scope.param, function(data){
			$scope.group.list = data.list;
			$scope.group.currentPage = n;
			$scope.group.totalCount = data.pagination.totalcount;
			$scope.group.totalPage = data.pagination.totalpage;
		});
	};
	
	$scope.group.add = function(){
		var options = {
				title : '공통코드추가',
				autoOpen: false,
				modal: true,
				width: "450",
				height: "300",
				close: function(event, ui) {
// 					console.log("Predefined close");
				}
			};

		dialogService.open("groupFormDialog","groupDialogTemplete.html", {}, options)
		.then(
			function(result) {
				if(result=="1"){
					$scope.group.go(1);
				}
			},
			function(error) {
			}
		);
	}
	$scope.group.modify = function(item){
		var options = {
				title : '코드그룹수정',
				autoOpen: false,
				modal: true,
				width: "450",
				height: "300",
				close: function(event, ui) {
// 					console.log("Predefined close");
				}
			};
		
		var param = angular.copy(item);
		dialogService.open("groupFormDialog","groupDialogTemplete.html", param, options)
		.then(
			function(result) {
				if(result=="1"){
					$scope.group.go(1);
				}
			},
			function(error) {
			}
		);
	}
	$scope.group.remove = function(item){
		if(!confirm("정말 삭제하시겠습니까?")){
			return;
		}
		var param = angular.copy(item);
		ajaxService.getJSON("<c:url value="/super/code/group_del.do"/>", param, function(data){
			if(data.rst == '1'){
  				$scope.group.go($scope.group.currentPage);
  			}
		});
	}
	
	$scope.code.openDialog = function(item){
		
		var options = {
				autoOpen: false,
				modal: true,
				width: "850",
				height: "600",
				close: function(event, ui) {
// 					console.log("Predefined close");
				}
			};
		
		var param = angular.copy(item);
		dialogService.open("codeListDialog","codeListDialogTemplete.html", param, options)
		.then(
			function(result) {
				if(result=="1"){
					$scope.group.go(1);
				}
			},
			function(error) {
			}
		);
	};
});


app.controller('groupFormCtrl', function($scope, ajaxService, dialogService) {
	$scope.form = $scope.model;//파라미터
	$scope.rst = {};
	$scope.saveClick = function() {
		if($scope.gFrm.$invalid){
			if($scope.gFrm.$error.required){
				alert("필수값을 입력하여 주십시오.");
			}else{
				alert("값이 유효하지 않습니다.");
			}
			$("#gFrm .ng-invalid")[0].focus();
			return false;
		}
		
		var url = "<c:url value="/super/code/group_modify.do"/>";
		if(!$scope.form.code_group_seq){
			url = "<c:url value="/super/code/group_write.do"/>";
		}
		
		ajaxService.getJSON(url, $scope.form, function(data){
			dialogService.close("groupFormDialog", data.rst);
		});
	};

	$scope.cancelClick = function() {
		dialogService.cancel("groupFormDialog");
	};

});
app.controller('codeListCtrl', function($scope, ajaxService, dialogService) {
	$scope.rst = {};
	$scope.form = $scope.model;//파라미터
	$scope.getList = function(){
		ajaxService.getSyncJSON('<c:url value="/json/list/Code.codeList.do"/>', $scope.form, function(data){
			$scope.list = data;
		});
	}
	
	$scope.openCodeFormDialog = function(item){
		var options = {
				title : '코드 등록',
				autoOpen: false,
				modal: true,
				width: "450",
				height: "450",
				close: function(event, ui) {
// 					console.log("Predefined close");
				}
			};
		
		var param = (function(){
			var rst = {};
			if(!!item){
				rst = angular.copy(item);
				rst.group_nm = $scope.form.group_nm;
			}else{
				rst = {code_group_seq : $scope.form.code_group_seq};
			}
			return rst;
		})();
		dialogService.open("codeFormDialog","codeFormDialogTemplete.html", param, options)
		.then(
			function(result) {
				if(result=="1"){
					$scope.getList();
				}
			},
			function(error) {
			}
		);
	}
	
	$scope.sortableOptions = {
		realign : false,
		axis: 'y',
		placeholder: "ui-state-highlight",
		update: function(e, ui) {
			if(confirm("정렬 순서를 변경하시겠습니까?")){
				this.realign = true;
        	}else{
        		ui.item.sortable.cancel();
				this.realign = false;
        	}
		},
		stop : function(e, ui){
			if(this.realign){
				var dataset = $.map($scope.list, function(item, i){
					return {code_seq: item.code_seq, order_seq : i}; 
				});
				ajaxService.getJSON("<c:url value="/code/updateOrder.do"/>", {jData : angular.toJson({list : dataset})}, function(data){
					if(data.rst == '1'){
		  				alert("정상 처리 되었습니다.");
		  			}
				});
			}
		}
    };

	$scope.codeRemove = function(item) {
		if(!confirm("정말 삭제하시겠습니까?")){
			return;
		}
		var param = angular.copy(item);
		ajaxService.getJSON('<c:url value="/super/code/code_del.do"/>', param, function(data){
			$scope.getList();
		});
	};
	$scope.cancelClick = function() {
		dialogService.cancel("codeListDialog");
	};

});
app.controller('codeFormCtrl', function($scope, ajaxService, dialogService) {
	$scope.form = $scope.model;//파라미터
	$scope.rst = {};
	if(!$scope.form.use_yn){
		$scope.form.use_yn="Y";
	}
	$scope.saveClick = function() {
		if($scope.cFrm.$invalid){
			if($scope.cFrm.$error.required){
				alert("필수값을 입력하여 주십시오.");
			}else{
				alert("값이 유효하지 않습니다.");
			}
			$("#cFrm .ng-invalid")[0].focus();
			return false;
		}
		
		var url = "<c:url value="/super/code/code_modify.do"/>";
		if(!$scope.form.code_seq){
			url = "<c:url value="/super/code/code_write.do"/>";
		}
		
		ajaxService.getJSON(url, $scope.form, function(data){
			dialogService.close("codeFormDialog", data.rst);
		});
	};

	$scope.cancelClick = function() {
		dialogService.cancel("codeFormDialog");
	};

});
</script>
</head>
<body>
    <div class="titlebar">
		<h2>공통코드 관리</h2>
		<div>
			<span>시스템 관리</span>&gt; <span>시스템 설정 및 관리</span>&gt;
			<span class="bar_tx">공통코드 관리</span>
		</div>
	</div>
	<div class="contents_wrap" data-ng-controller="mainCtrl" data-ng-init="group.go(1)" data-ng-cloak>
		<div class="contents">
			<form name="searchFrm" method="post" data-ng-submit="group.go(1)">
	        <input type="submit" style="display:none;"/>
		    <table class="type1" style="margin-top:0;">
				<colgroup>
					<col style="width:200px;" />
					<col />
				</colgroup>
				<tr>
					<th scope="row">검색어</th>
					<td>
						<select title="회원 검색조건 선택" class="normal w100" data-ng-model="param.condition" data-ng-init="param.condition='code_group_seq'">
				            <option value="code_group_seq">그룹코드</option>
				            <option value="group_nm">그룹명</option>
				        </select>
						<input type="text" class="normal w175" data-ng-model="param.keyword"/>
					</td>
				</tr>
				<tr>
					<th scope="row" colspan="2" style="text-align:center; padding-left:0px; padding-right:0px;">
						<%-- <a data-ng-click="group.go(1)"><img src="<c:url value="/images/super/contents/s_btn_search.gif"/>" alt="검색" /></a> --%>
						<a class="bt_big_bt5" data-ng-click="group.go(1)">검색</a>
					</th>
				</tr>
			</table>
			<div style="overflow:hidden; margin-top:35px;">
		    	<div class="left_box_cms">
		    		<span class="board_listing">TOTAL : <span><b>{{group.totalCount|number}}</b></span> 건 </span><span style="font-size:12px;">({{group.currentPage|number}} / {{group.totalPage|number}} page)</span>
		        </div>
		        <div class="right_box_cms">
		        	<select class="normal w100" data-ng-model="param.rows" data-ng-init="param.rows='10'" data-ng-change="group.go(1)">
			            <option value="10">10건씩보기</option>
			            <option value="20">20건씩보기</option>
			            <option value="30">30건씩보기</option>
			            <option value="50">50건씩보기</option>
			            <option value="100">100건씩보기</option>
		          	</select>
		        </div>
		    </div>
		    </form>
		    
			<table class="type1">
	          	<colgroup>
	          		<col style="width:60px;" />
	          		<col style="width:320px;" />
	          		<col style="width:80px;" />
	          		<col />
	          		<col style="width:110px;" />
	          		<col style="width:120px;" />
	          		<col style="width:300px;" />
	          	</colgroup>
	          	<tr>
		            <th scope="col" class="center">번호</th>
		            <th scope="col" class="center">그룹명</th>
		            <th scope="col" class="center">그룹번호</th>
		            <th scope="col" class="center">그룹설명</th>
		            <th scope="col" class="center">코드등록수</th>
		            <th scope="col" class="center">등록일</th>
		            <th scope="col" class="center">관리</th>
	          	</tr>
	          	<tr data-ng-if="group.list.length==0"><td colspan="7" class="center">결과가 없습니다.</td></tr>
	          	<tr data-ng-repeat="item in group.list">
		            <td class="center">{{(group.totalCount|num) + 1 - (item.rn|num)}}</td>
		            <td class="member_nm left">{{item.group_nm}}</td>
		            <td class="center">{{item.code_group_seq}}</td>
		            <td class="center">{{item.conts}}</td>
		            <td class="center">{{item.code_cnt}}</td>
		            <td class="center">{{item.reg_dt|myDate:'yyyy-MM-dd'}}</td>
		            <td class="center">
		            	<button value="코드관리" class="bt_small code" data-ng-click="code.openDialog(item)">코드관리</button>
		            	<button value="그룹수정" class="bt_small modify" data-ng-click="group.modify(item)">그룹수정</button>
		            	<button value="삭제" class="bt_small delete" data-ng-click="group.remove(item)">삭제</button>
		            </td>
	          	</tr>
			</table>
	        
	        <pagination total-page="group.totalPage" current-page="group.currentPage" on-select-page="group.go(page)"></pagination>
			
			<div class="btn_bottom">
		    	<div class="r_btn">
					<input type="button" value="등록" class="bt_big_bt4" data-ng-click="group.add()"/>
		        </div>
		    </div>
		</div>
	</div>
	
<script type="text/ng-template" id="groupDialogTemplete.html">
	<div ng-controller="groupFormCtrl" title="그룹편집">
		<form id="gFrm" name="gFrm" method="post" novalidate="novalidate" data-ng-submit="saveClick()">
        <table class="type1">
        	<colgroup>
        		<col style="width:25%;" />
          		<col />
         	</colgroup>
          	<tr>
            	<th scope="row">그룹명칭</th>
            	<td><input type="text" data-ng-model="form.group_nm" class="normal" style="width:100%;" required></td>
          	</tr>
          	<tr>
            	<th scope="row">그룹설명</th>
            	<td><textarea style="width:100%; height:110px;" data-ng-model="form.conts"></textarea></td>
          	</tr>
        </table>
        <div class="btn_bottom">
	        <div class="r_btn">
	          	<input type="button" value="저장" class="bt_big_bt4" data-ng-click="saveClick()"/>
	          	<input type="button" value="취소" class="bt_big_bt3" data-ng-click="cancelClick()"/>
	        </div>
		</div>
		</form>		
	</div>
</script>
<script type="text/ng-template" id="codeListDialogTemplete.html">
	<div ng-controller="codeListCtrl" data-ng-init="getList()" title="공통코드수정">
        <div>
			<p style="margin:15px 0 10px 0; color:#333; font-size:15px;">{{model.group_nm}}</p>
			<span style="color:#555;">{{model.conts}}</span>
		</div>
		<table class="type1">
			<colgroup>
		  		<col style="width:10%" />
		  		<col style="width:11%" />
		  		<col style="width:12%" />
		  		<col style="width:13%" />
		  		<col style="width:13%" />
		  		<col style="width:13%" />
		  		<col style="width:10%" />
		  		<col/>
			</colgroup>
			<thead>
				<tr>
					<th scope="row" class="center">번호</th>
					<th scope="row" class="center">코드</th>
					<th scope="row" class="center">코드명</th>
					<th scope="row" class="center">값1</th>
					<th scope="row" class="center">값2</th>
					<th scope="row" class="center">COLOR</th>
					<th scope="row" class="center">사용여부</th>
					<th scope="row" class="center">관리</th>
				</tr>
			</thead>
			<tbody ui-sortable="sortableOptions" ng-model="list">
				<tr data-ng-if="list.length==0"><td colspan="8"  class="center">결과가 없습니다.</td></tr>
				<tr data-ng-repeat="item in list">
					<td class="center">{{item.code_seq}}</td>
					<td class="center">{{item.code}}</td>
					<td class="center">{{item.code_nm}}</td>
					<td class="center">{{item.val1}}</td>
					<td class="center">{{item.val2}}</td>
					<td class="center">{{item.etc}}</td>
					<td class="center">{{item.use_yn}}</td>
					<td class="center">
						<button value="수정" class="bt_small modify" data-ng-click="openCodeFormDialog(item)">수정</button>
						<button value="삭제" class="bt_small delete" data-ng-click="codeRemove(item)">삭제</button>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="btn_bottom">
	        <div class="r_btn">
	          	<input type="button" value="코드추가" class="bt_big_bt4" data-ng-click="openCodeFormDialog(model)"/>
	          	<input type="button" value="닫기" class="bt_big_bt2" data-ng-click="cancelClick()"/>
	        </div>
		</div>
	</div>
</script>
<script type="text/ng-template" id="codeFormDialogTemplete.html">
	<div ng-controller="codeFormCtrl" title="그룹편집">
		<form id="cFrm" name="cFrm" method="post" novalidate="novalidate" data-ng-submit="saveClick()">
        <table class="type1">
        	<colgroup>
            	<col style="width:120px;" />
            	<col />
            </colgroup>
        	<tr>
        		<th scope="row">그룹</th>
        		<td>{{form.group_nm}}</td>
        	</tr>
        	<tr>
        		<th scope="row">코드</th>
        		<td><input type="text" data-ng-model="form.code" class="normal w175" required/></td>
        	</tr>
        	<tr>
        		<th scope="row">코드명</th>
        		<td><input type="text" data-ng-model="form.code_nm" class="normal w175" required/></td>
       		</tr>
        	<tr>
        		<th scope="row">값1</th>
        		<td><input type="text" data-ng-model="form.val1" class="normal w175" /></td>
        	</tr>
        	<tr>
        		<th scope="row">값2</th>
        		<td><input type="text" data-ng-model="form.val2" class="normal w175" /></td>
        	</tr>
        	<tr>
        		<th scope="row">COLOR</th>
        		<td><input type="text" data-ng-model="form.etc" class="normal w175" colorpicker/></td>
        	</tr>
        	<tr>
        		<th scope="row">사용여부</th>
        		<td>
        			<ol class="select">
        	  			<li><label><input type="radio" data-ng-model="form.use_yn" value="Y"/>사용</label></li>
        	  			<li><label><input type="radio" data-ng-model="form.use_yn" value="N"/>사용안함</label></li>
        			</ol>
        		</td>
        	</tr>
        </table>
        <div class="btn_bottom">
	        <div class="r_btn">
	          	<input type="button" value="완료" class="bt_big_bt4" data-ng-click="saveClick()"/>
	          	<input type="button" value="취소" class="bt_big_bt3" data-ng-click="cancelClick()"/>
	        </div>
		</div>
		</form>		
	</div>
</script>
</body>
</html>