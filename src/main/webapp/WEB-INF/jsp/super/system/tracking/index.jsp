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
<title>관리자 트래킹</title>
<script type="text/javascript" src="<c:url value="/lib/js/angular.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/angular-route.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/angular-sanitize.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/filters/myFilter.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/filters/ngRange.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/services/myCommon.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/services/dialog-service.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/myUtil.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/myPagination.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/sortable.js"/>"></script>
<script type="text/javascript" src="/lib/js/bootstrap-colorpicker-module.js"></script>
<script type="text/javascript">
var app = angular.module("MyApp", ['dialogService', 'ngRoute', 'myUtil', 'myPagination', 'myCommon', 'ui.sortable', 'myFilter', 'ngRange', 'colorpicker.module', 'ngSanitize']);
app.run(function($rootScope){
	$rootScope.main = {};
	$rootScope.param = {
	};
});

app.controller("mainCtrl", function($scope, $window, $routeParams, $compile, ajaxService, dialogService, $filter) {
	$scope.board = {};
	$scope.param.cpage = $scope.param.cpage||1;
	
	$scope.param.start_date = $scope.param.start_date||$.datepicker.formatDate('yy-mm-dd', new Date());
	$scope.param.end_date = $scope.param.end_date||$.datepicker.formatDate('yy-mm-dd', new Date());
	
	$scope.board.go = function(n){
		$scope.param.cpage=n||1;
		$.blockUI();
		var promise = ajaxService.getSyncJSON('<c:url value="/super/system/tracking/list.do"/>', $scope.param, function(data){
			$scope.board.list = data.list;
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.pagination.totalcount;
			$scope.board.totalPage = data.pagination.totalpage;
		});
		promise.then($.unblockUI);
	};
	
	$scope.openLogDialog = function(item){
		var options = {
				autoOpen: false,
				modal: true,
				width: "1100",
				height: "790",
				close: function(event, ui) {
				}
		};
		dialogService.open("viewLog","viewLog.html", $.extend({"start_date":$scope.param.start_date,"end_date":$scope.param.end_date,"parent_seq":item.seq}, item), options)
		.then(
			function(result) {
			},
			function(error) {
			}
		);
	};
	
	$scope.openAuthDialog = function(item){
		var options = {
				autoOpen: false,
				modal: true,
				width: "500",
				height: "650",
				close: function(event, ui) {
				}
		};
		dialogService.open("viewAuth","viewAuth.html", item, options)
		.then(
			function(result) {
			},
			function(error) {
			}
		);
	};
});

app.controller("viewLogCtrl", function($scope, $window, $routeParams, $compile, ajaxService, dialogService, $filter, $sce) {
	$scope.board = {};
	$scope.param = $scope.model;
	$scope.param.cpage = $scope.param.cpage||1;
	
	$scope.board.go = function(n){
		$scope.param.cpage=n||1;
		ajaxService.getSyncJSON('<c:url value="/super/system/tracking/viewLog.do"/>', $scope.param, function(data){
			$scope.board.list = data.list;
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.pagination.totalcount;
			$scope.board.totalPage = data.pagination.totalpage;
		});
	};
});

app.controller("viewAuthCtrl", function($scope, $window, $routeParams, $compile, ajaxService, dialogService, $filter) {
	$scope.board = {};
	$scope.param = $scope.model;
	$scope.param.cpage = $scope.param.cpage||1;
	$scope.board.go = function(n){
		$scope.param.cpage=n||1;

		$.blockUI();
		var promise = ajaxService.getSyncJSON('<c:url value="/super/system/tracking/viewAuth.do"/>', $scope.param, function(data){
			$scope.board.list = data.list;
// 			$scope.board.currentPage = n;
// 			$scope.board.totalCount = data.pagination.totalcount;
// 			$scope.board.totalPage = data.pagination.totalpage;
		});
		promise.then($.unblockUI);
	};
	
	$scope.close = function(){
		dialogService.close("viewAuth");
	}
});
</script>
</head>
<body>
	<div class="titlebar">
	
		<h2>관리자 트래킹</h2>
		<div>
			<span>시스템 관리</span>&gt;<span>회원관리</span>&gt;
			<span class="bar_tx">관리자 트래킹</span>
		</div>
	</div>
	<div class="contents_wrap" data-ng-controller="mainCtrl" data-ng-init="board.go(param.cpage)" data-ng-cloak>
		<div class="contents">
			<form name="searchFrm" method="post" data-ng-submit="board.go(1)">
			<table class="type1" style="margin-top:0;">
				<colgroup>
					<col style="width:200px;" />
					<col />
				</colgroup>
				<tr>
					<th scope="row">접속기간</th>
					<td>
						<input type="text" class="normal w175" style="position:relative; z-index:100; margin-right:3px;" data-ng-model="param.start_date" datetimepicker date_max_model="param.end_date" required/>
						<span>~</span>
						<input type="text" class="normal w175" style="position:relative; z-index:100; margin-right:3px;" data-ng-model="param.end_date" datetimepicker date_min_model="param.start_date" required/>
					</td>
				</tr>
				<tr>
					<th scope="row">검색어</th>
					<td>
						<select data-ng-model="param.condition" id="condition" class="normal w125" data-ng-init="param.condition = 'member_id'">
							<option value="member_id">아이디</option>
							<option value="member_name">이름</option>
						</select>
						<input type="text" class="normal w175" data-ng-model="param.keyword"/>
					</td>
				</tr>
				<tr>
					<th scope="row" colspan="2" style="text-align:center; padding-left:0px; padding-right:0px;">
						<%-- <a data-ng-click="board.go(1)"><img src="<c:url value="/images/super/contents/s_btn_search.gif"/>" alt="검색" /></a> --%>
						<a class="bt_big_bt5" data-ng-click="board.go(1)">검색</a>
					</th>
				</tr>
			</table>
			
			</form>
			
			<div style="overflow:hidden; margin-top:35px;">
				<div class="left_box_cms">
					<span class="board_listing">TOTAL : <span><b>{{board.totalCount|number}}</b></span> 건 </span><span style="font-size:12px;">(<b>{{board.currentPage|number}}</b> / {{board.totalPage|number}} page)</span>
				</div>
				<div class="right_box_cms">
					<select class="normal w100" title="건별보기 선택" data-ng-model="param.rows" data-ng-change="board.go(1)" data-ng-init="param.rows = '10'">
						<option value="10">10건씩보기</option>
						<option value="15">15건씩보기</option>
						<option value="20">20건씩보기</option>
					</select>
				</div>
			</div>
			
			<table class="type1">
				<colgroup>
					<col style="width:6%;">
					<col>
					<col style="width:8%;">	
					<col style="width:8%;">
					<col style="width:14%;">
					<col style="width:10%;">
					<col style="width:8%;">
					<col style="width:8%;">
				</colgroup>
				<thead>
		          	<tr>
			            <th class="center">번호</th>
			            <th class="center">관리중인 홈페이지</th>
			            <th class="center">관리자 아이디</th>
			            <th class="center">관리자 이름</th>
			            <th class="center">접속IP</th>
			            <th class="center">마지막 접속일</th>
			            <th class="center">권한보기</th>
			            <th class="center">로그보기</th>
		          	</tr>
	          	</thead>
	          	<tbody>
	          		<tr data-ng-if="board.list.length==0"><td colspan="8" class="center">결과가 없습니다.</td></tr>
		          	<tr data-ng-repeat="item in board.list">
			            <td class="center">{{(board.totalCount|num) + 1 - (item.rn|num)}}</td>
			            <td class="left member_nm" >{{item.group_seq == '1' ? '전체' : item.title}}</td>
			            <td class="center">{{item.member_id}}</td>
			            <td class="center">{{item.member_name}}</td>
			            <td class="center default">{{item.login_ip}}</td>
		            	<td class="center">{{item.login_date|myDate:'yyyy-MM-dd'}}</td>
			            <td class="center">
			            	<button value="권한보기" class="bt_small authority" data-ng-click="openAuthDialog(item);">권한보기</button>
			            </td>
			            <td class="center">
			            	<button value="이동추적" class="bt_small log" data-ng-click="openLogDialog(item);">이동추적</button>
			            </td>
		          	</tr>
	          	</tbody>
	        </table>
	        <pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
		</div>
	</div>
	
<script type="text/ng-template" id="viewLog.html">
	<div id="dialog" title="관리자 접속로그 상세보기" data-ng-controller="viewLogCtrl" data-ng-init="board.go(param.cpage)" data-ng-cloak>
		<p style="margin-top:17px; font-size:15px; font-family:'NanumBarunGothicB';">계정명 : {{param.member_name}}({{param.member_id}})</p>        
		<table class="type1" style="table-layout:fixed;">
            <colgroup>
            	<col style="width:5%;" />
                <col style="width:23%;" />
                <col style="width:7%;" />
                <col style="width:15%" />
                <col style="width:25%;" />
				<col style="width:25%;" />
            </colgroup>
            <tr>
                <th class="center">순번</th>
                <th class="center">메뉴명</th>
                <th class="center">내용</th>
                <th class="center">접속시간</th>
                <th class="center">접속URL</th>
                <th class="center">요청파라미터</th>
            </tr>
            <tbody id="dialogOrderWrap">
				<tr data-ng-if="board.list.length==0">
					<td colspan="6" style="text-align:center;">결과가 없습니다.</td>
				</tr>
				<tr data-ng-repeat="item in board.list">
					<td class="center default">{{(board.totalCount|num) + 1 - (item.rn|num)}}</td>
					<td class="default" ng-bind-html="item.title"></td>
					<td class="center default">{{item.job}}</td>
					<td class="center default">{{item.ltime}}</td>
					<td class="default"><a href="{{item.url}}" target="_blank">{{item.url}}</a></td>
					<td class="default"><textarea style='width:100%;height:40px;' readonly="readonly">{{item.params}}</textarea></td>
				</tr>
			</tbody>
        </table>
        <pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
    </div>
</script>
<script type="text/ng-template" id="viewAuth.html">
	<div id="dialog" title="관리자 권한 상세보기" data-ng-controller="viewAuthCtrl" data-ng-init="board.go(param.cpage)" data-ng-cloak>
		<p style="margin-top:17px; font-size:15px; font-family:'NanumBarunGothicB';">계정명 : {{param.member_name}}({{param.member_id}})</p>
        <table class="type1" style="table-layout:fixed;">
            <colgroup>
            	<col />
            </colgroup>
			<thead>
            	<tr>
                	<th class="center">권한받은 메뉴</th>
            	</tr>
			</thead>
            <tbody id="dialogOrderWrap" ng-if="param.group_seq.toString() == '1'">
				<tr>
					<td>"슈퍼관리자"는 모든 권한을 가지고 있습니다.(메뉴관리,사이트관리,시스템관리)</td>
				</tr>
			</tbody>
            <tbody id="dialogOrderWrap" ng-if="param.group_seq.toString() != '1'">
				<tr data-ng-if="board.list.length==0">
					<td style="text-align:center;">결과가 없습니다.</td>
				</tr>
				<tr data-ng-repeat="item in board.list">
					<td class="member">{{item.page_navi}}</td>
				</tr>
			</tbody>
        </table>
		<p style="height:15px; padding:12px 0 12px 10px; margin-top:10px; background-color:#f3f3f3; border-left:5px solid #d5d5d5;">권한변경은 관리자 회원관리에서 가능합니다.</p>
		<div class="btn_bottom">
			<div class="r_btn">
				<input type="button" value="닫기" class="bt_big_bt2" data-ng-click="close()"/>
			</div>
		</div>
    </div>
</script>
</body>
</html>