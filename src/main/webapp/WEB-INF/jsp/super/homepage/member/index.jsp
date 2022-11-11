<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자정보 수정</title>
<script type="text/javascript" src="<c:url value="/lib/js/angular.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/angular-route.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/filters/myFilter.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/filters/ngRange.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/services/myCommon.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/services/dialog-service.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/myUtil.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/myPagination.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/sortable.js"/>"></script>
<script type="text/javascript">
var app = angular.module("MyApp", ['dialogService', 'ngRoute', 'myUtil', 'myPagination', 'myCommon', 'ui.sortable', 'myFilter', 'ngRange']);
app.run(function($rootScope){
	$rootScope.main = {};
	$rootScope.param = {
	};
});
app.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
	$routeProvider
		.when('/modify', {controller: 'modifyCtrl', templateUrl : 'st_exclude/modify.do'})
		.otherwise({redirectTo: '/modify' });
}]);

app.controller("mainCtrl", function($scope, $location, ajaxService) {

	//전화번호 앞자리 공통코드
	ajaxService.getJSON("<c:url value="/json/list/Code.codeList.do"/>", {code_group_seq : '1'}, function(data){
		$scope.main.tel1 = data;
	});
	//휴대폰 앞자리 공통코드
	ajaxService.getJSON("<c:url value="/json/list/Code.codeList.do"/>", {code_group_seq : '2'}, function(data){
		$scope.main.cell1 = data;
	});
	//휴대폰 앞자리 공통코드
	ajaxService.getJSON("<c:url value="/json/list/Code.codeList.do"/>", {code_group_seq : '3'}, function(data){
		$scope.main.email2 = data;
	});
});
app.controller("modifyCtrl", function($scope, $timeout, $window, $routeParams, ajaxService, $location) {
	$scope.form = {};
	ajaxService.getSyncJSON('<c:url value="/super/member/view.do"/>', {member_id : '${sessionScope.cms_member.member_id}'}, function(data){
		$scope.form = data.view;
	});

	$scope.on_pw_check = function(){
		$timeout(function(){
			$scope.wFrm.member_pw_check.$setValidity("pwcheck", false);
		},100);
	}
	$scope.pw_check = function(){
		$("#pw_div").block();
		var pormise = ajaxService.getSyncJSON('<c:url value="/super/member/pw_check.do"/>', {member_id : $scope.form.member_id, member_pw : $scope.form.member_pw_check}, function(data){
			if(data.rst == "Y"){
				$scope.wFrm.member_pw_check.$setValidity("pwcheck", true);
			}else{
				$scope.wFrm.member_pw_check.$setValidity("pwcheck", false);
			}
		});
		pormise.then(function(){
			$timeout(function(){
				$("#pw_div").unblock();
			},1000);
		});
	}
	$scope.pw_confirm = function(){
		if($scope.form.member_pw == $scope.form.member_pw_confirm){
			$scope.wFrm.member_pw_confirm.$setValidity("pwconfirm", true);
		}else{
			$scope.wFrm.member_pw_confirm.$setValidity("pwconfirm", false);
		}
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
		ajaxService.getJSON('<c:url value="/super/member/modify.do"/>', {jData : angular.toJson($scope.form)}, function(data){
			alert("정상적으로 회원정보를 수정하였습니다.");
			location.reload();
		}, "회원수정");
	}
	
});
</script>
</head>
<body>
	<div class="titlebar">
		<h2>관리자 정보 수정</h2>
		<div>
			&gt; 
			<span class="bar_tx">관리자 정보 수정</span>
		</div>
	</div>
	<div data-ng-controller="mainCtrl">
		<div data-ng-view data-ng-cloak></div>
	</div>
</body>
</html>