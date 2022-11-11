<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>메일설정 및 발송</title>
<script type="text/javascript" src="/lib/js/angular.min.js"></script>
<script type="text/javascript" src="/lib/js/angular-route.min.js"></script>
<script type="text/javascript" src="/lib/js/filters/myFilter.js"></script>
<script type="text/javascript" src="/lib/js/filters/ngRange.js"></script>
<script type="text/javascript" src="/lib/js/services/myCommon.js"></script>
<script type="text/javascript" src="/lib/js/services/dialog-service.js"></script>
<script type="text/javascript" src="/lib/js/directives/myUtil.js"></script>
<script type="text/javascript" src="/lib/js/directives/myPagination.js"></script>
<script type="text/javascript" src="/lib/js/directives/sortable.js"></script>
<script type="text/javascript" src="/lib/js/directives/myEditor.js"></script>
<script type="text/javascript">
var app = angular.module("MyApp", ['dialogService', 'ngRoute', 'myUtil', 'myPagination', 'myCommon', 'ui.sortable', 'myFilter', 'ngRange', 'myEditor']);
app.run(function($rootScope){
	$rootScope.main = {};
	$rootScope.param = {
	};
});
app.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
	$routeProvider
		.when('/list', {controller: 'listCtrl', templateUrl : 'st_exclude/list.do'})
		.when('/target_list', {controller: 'targetCtrl', templateUrl : 'st_exclude/target_list.do'})
		.when('/form_list', {controller: 'formCtrl', templateUrl : 'st_exclude/form_list.do'})
		.when('/smtp_list', {controller: 'smtpCtrl', templateUrl : 'st_exclude/smtp_list.do'})
		.when('/write', {controller: 'writeCtrl', templateUrl : 'st_exclude/write.do'})
		.when('/target_write', {controller: 'targetWriteCtrl', templateUrl : 'st_exclude/target_write.do'})
		.when('/form_write', {controller: 'formWriteCtrl', templateUrl : 'st_exclude/form_write.do'})
		.when('/smtp_write', {controller: 'smtpWriteCtrl', templateUrl : 'st_exclude/smtp_write.do'})
		.when('/modify/:seq', {controller: 'modifyCtrl', templateUrl : 'st_exclude/modify.do'})
		.when('/target_modify/:seq', {controller: 'targetModifyCtrl', templateUrl : 'st_exclude/target_modify.do'})
		.when('/form_modify/:seq', {controller: 'formModifyCtrl', templateUrl : 'st_exclude/form_modify.do'})
		.when('/smtp_modify/:seq', {controller: 'smtpModifyCtrl', templateUrl : 'st_exclude/smtp_modify.do'})
		.otherwise({redirectTo: '/list' });
}]);

app.controller("mainCtrl", function($scope, $location, ajaxService) {
	$scope.list = function(){
		$location.path("/list");
	}
});

app.factory('userSelectFactory', function(ajaxService, dialogService, $q) {
	var service = {};
	service.openDialog = function(){
		var options = {
				title : '회원검색',
				autoOpen: false,
				modal: true,
				width: "600",
				height: "550",
				close: function(event, ui) {
				}
			};

		var deferred = $q.defer();
		dialogService.open("UserSelectDialog", "/st_exclude/super/system/email/UserSelectTemplete.do", {}, options)
		.then(
			function(result) {
				deferred.resolve(result);
			},
			function(error) {
			}
		);
		return deferred.promise;
	}
	return service;
});

app.controller("userSelectCtrl", function($scope, $window, $routeParams, $compile, ajaxService, dialogService) {
	$scope.result = [];
	$scope.param = {
		use_yn : '',
		group_list : []
	};
	ajaxService.getJSON('<c:url value="/super/user_group/list.do"/>', {}, function(data){
		$scope.group_list = data;
	});
	
	$scope.board = {};
	$scope.board.go = function(n){
		ajaxService.getSyncJSON('/super/system/email/user_list.do', $.extend({group_seqs : $scope.param.group_list.join(",")}, $scope.param), function(data){
			$scope.board.list = data.list;
		});
	};

	$scope.chk_all_btn = function(){
		$("#listWrap input[type=checkbox]").each(function(){
			if($scope.board.chk_all){
				$.each($scope.board.list, function(i, o){
					o.chk_yn = true;
				});
			}else{
				$.each($scope.board.list, function(i, o){
					o.chk_yn = false;
				});
			}
		})
	}
	
	$scope.select = function(){
		var list = [];
		$.each($scope.board.list, function(i, o){
			if(o.chk_yn){
				list.push(o);
			}
		});
		dialogService.close("UserSelectDialog", {rst : 'Y', list : list});
	}
	
	$scope.close = function(){
		dialogService.close("UserSelectDialog");
	}
	
});
app.controller("listCtrl", function($scope, $window, $routeParams, $compile, ajaxService, dialogService) {
	$scope.param = {
		condition:"title"
	};
	$scope.board = {};
	$scope.board.go = function(n){
		ajaxService.getSyncJSON('/super/system/email/list.do?cpage='+n, $scope.param, function(data){
			$scope.board.list = data.list;
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.pagination.totalcount;
			$scope.board.totalPage = data.pagination.totalpage;
		});
	};
	$scope.del = function(item){
		if(!confirm("정말 삭제 하시겠습니까?")){
			return false;
		}
		ajaxService.getJSON("/super/system/email/del.do", item, function(data){
			if(data.rst == '1'){
				$scope.board.go(1);
			}else{
				alert(data.msg);
			}
		});
	}
	
	$scope.open_mail_queue = function(item){
		var options = {
				title : '발송 상세보기',
				autoOpen: false,
				modal: true,
				width: "400",
				height: "550",
				close: function(event, ui) {
				}
			};

		dialogService.open("mailQueueDialog", "mailQueueTemplete.html", item, options)
		.then(
			function(result) {
			},
			function(error) {
			}
		);
	}
	
	$scope.update_mail_queue = function(item){
		if(!confirm("수신자그룹을 갱신하시겠습니까?")) return false;
		ajaxService.getJSON('/super/system/email/queue_update.do', item, function(data){
			alert("수신자 그룹이 갱신되었습니다.")
			$scope.board.go(1);
		});
	}
	
	$scope.send_mail = function(item){
		if(!confirm("메일을 발송하시겠습니까?")) return;
		
		ajaxService.getJSON("/super/system/email/send_mail.do", item, function(data){
			if(data.rst=="P"){
				alert("진행중인 발송건이 있어 잠시후에 다시 시도해 주시기 바랍니다.\n현재 "+data.cnt+"건 발송되었습니다.");
			}else{
				$scope.board.go(1);
			}
		});
	}
});
app.controller("targetCtrl", function($scope, $window, $routeParams, $compile, ajaxService, dialogService) {
	$scope.param = {
		condition:"title"
	};
	$scope.board = {};
	$scope.board.go = function(n){
		ajaxService.getSyncJSON('/super/system/email/target_list.do?cpage='+n, $scope.param, function(data){
			$scope.board.list = data.list;
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.pagination.totalcount;
			$scope.board.totalPage = data.pagination.totalpage;
		});
	};
	$scope.del = function(item){
		if(!confirm("정말 삭제 하시겠습니까?")){
			return false;
		}
		ajaxService.getJSON("/super/system/email/target_del.do", item, function(data){
			if(data.rst == '1'){
				$scope.board.go(1);
			}else{
				alert(data.msg);
			}
		});
	}
});
app.controller("formCtrl", function($scope, $window, $routeParams, $compile, ajaxService, dialogService) {
	$scope.param = {
			condition:"title"
		};
	$scope.board = {};
	$scope.board.go = function(n){
		ajaxService.getSyncJSON('/super/system/email/form_list.do?cpage='+n, $scope.param, function(data){
			$scope.board.list = data.list;
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.pagination.totalcount;
			$scope.board.totalPage = data.pagination.totalpage;
		});
	};
	$scope.del = function(item){
		if(!confirm("정말 삭제 하시겠습니까?")){
			return false;
		}
		ajaxService.getJSON("/super/system/email/form_del.do", item, function(data){
			if(data.rst == '1'){
				$scope.board.go(1);
			}else{
				alert(data.msg);
			}
		});
	}
});
app.controller("smtpCtrl", function($scope, $window, $routeParams, $compile, ajaxService, dialogService) {
	$scope.param = {
			condition:"title"
		};
	$scope.board = {};
	$scope.board.go = function(n){
		ajaxService.getSyncJSON('/super/system/email/smtp_list.do?cpage='+n, $scope.param, function(data){
			$scope.board.list = data.list;
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.pagination.totalcount;
			$scope.board.totalPage = data.pagination.totalpage;
		});
	};
	$scope.test = function(item){
		ajaxService.getJSON("/super/system/email/smtp_test.do", {seq:item.seq}, function(data){
			if(data.rst == '1'){
				alert("성공");
			}else{
				alert(data.msg);
			}
		});
	}
	$scope.del = function(item){
		if(!confirm("정말 삭제 하시겠습니까?")){
			return false;
		}
		ajaxService.getJSON("/super/system/email/smtp_del.do", item, function(data){
			if(data.rst == '1'){
				$scope.board.go(1);
			}else{
				alert(data.msg);
			}
		});
	}
});
app.controller("writeCtrl", function($scope, $window, $routeParams, ajaxService, dialogService) {

	ajaxService.getSyncJSON("/super/system/email/target_list.do", {}, function(data){
		$scope.target_list = data.list;
	});
	ajaxService.getSyncJSON("/super/system/email/form_list.do", {}, function(data){
		$scope.form_list = data.list;
	});
	$scope.formSelect = function(){
		if(!!$scope.form.form_seq){
			$.each($scope.form_list, function(i, o){
				if(o.seq == $scope.form.form_seq){
					$scope.form.conts = o.conts;
					return false;
				}
			});
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
		
		ajaxService.getJSON("/super/system/email/write.do", $scope.form, function(data){
			$scope.list();
		});
	}
});
app.controller("targetWriteCtrl", function($scope, $window, $routeParams, $location, ajaxService, dialogService, userSelectFactory) {
	$scope.form = {
		target_list : [],
		target_cnt : 0,
		temp_email : "",
		temp_name : ""
	};
	
	$scope.openUserSelect = function(){
		var promise = userSelectFactory.openDialog();
		promise.then(function(result){
			if(result.rst == "Y"){
				$.each(result.list, function(i, o){
					$scope.form.target_list.push({user_name:o.member_nm, user_email:o.email});
				});
			}
		});
	}
	
	$scope.save = function(){
		$scope.form.target_cnt = $scope.form.target_list.length;
		if($scope.wFrm.$invalid){
			if($scope.wFrm.$error.required){
				alert("필수값을 입력하여 주십시오.");
			}else{
				alert("값이 유효하지 않습니다.");
			}
			$("#wFrm .ng-invalid")[0].focus();
			return false;
		}
		
		ajaxService.getJSON("/super/system/email/target_write.do", {jData : angular.toJson($scope.form)}, function(data){
			$location.path("/target_list");
		});
	}
	
	$scope.upload = function(){
		var filename = $("#excelfile").val();
		filename = filename.slice(filename.indexOf(".") + 1).toLowerCase();
		if(filename==""){
			alert("업로드할 파일을 올려주시기 바랍니다.");
			return false;
		}
		if($.inArray(filename, ["xls"]) < 0 ){
			alert("xls 파일만 올려주시기 바랍니다.");
			return false;
		}
		
    	$("#wFrm").ajaxSubmit({
    		url : '/super/system/email/targetExcelUpload.do',
    		data : {},
    		iframe: false,
    		dataType : "json",
    		success : function(data){
    			$scope.$apply(function(){
    				var t_list = $scope.form.target_list.concat(data.list);
    				$scope.form.target_list = t_list;
    			});
    		},
    		error: function(e){
    			alert(e.responseText);
    		},
    		complete : function(){
//     			$("#excelfile").val('');
    		}
    	});
	};
	
	$scope.addEmail = function(){
		if($scope.form.temp_name==""){
			alert("성명을 입력해주시기 바랍니다.");
			return;
		}
		if($scope.form.temp_email=="" || $scope.form.temp_email==undefined){
			alert("이메일형식에 맞게 입력해주시기 바랍니다.");
			return;
		}
		
		$scope.form.target_list.push({user_name:$scope.form.temp_name, user_email:$scope.form.temp_email});
		$scope.form.temp_name="";
		$scope.form.temp_email="";
	}
	
	$scope.removeEmail = function(idx){
		$scope.form.target_list.splice(idx, 1);
	}
	
	$scope.sampleDownload = function(){
		location.href="/direct_download.do?path=/upload/sample&file_nm=target_sample.xls";
	}
});
app.controller("formWriteCtrl", function($scope, $window, $routeParams, $location, ajaxService, dialogService) {

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
		
		ajaxService.getJSON("/super/system/email/form_write.do", $scope.form, function(data){
			$location.path("/form_list");
		});
	}
});
app.controller("smtpWriteCtrl", function($scope, $window, $routeParams, $location, ajaxService, dialogService) {

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
		
		ajaxService.getJSON("/super/system/email/smtp_write.do", $scope.form, function(data){
			$location.path("/smtp_list");
		});
	}
});
app.controller("modifyCtrl", function($scope, $window, $routeParams, ajaxService, dialogService) {

	ajaxService.getJSON("/super/system/email/target_list.do", {}, function(data){
		$scope.target_list = data.list;
	});
	ajaxService.getJSON("/super/system/email/form_list.do", {}, function(data){
		$scope.form_list = data.list;
	});
	$scope.formSelect = function(){
		if(!!$scope.form.form_seq){
			$.each($scope.form_list, function(i, o){
				if(o.seq == $scope.form.form_seq){
					$scope.form.conts = o.conts;
					return false;
				}
			});
		}
	}

	ajaxService.getJSON("/super/system/email/view.do", {seq : $routeParams.seq}, function(data){
		$scope.form = data;
	});
	
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
		
		ajaxService.getJSON("/super/system/email/modify.do", $scope.form, function(data){
			$scope.list();
		});
	}
	
});
app.controller("targetModifyCtrl", function($scope, $window, $routeParams, $location, ajaxService, dialogService, userSelectFactory) {
	$scope.form = {
		target_list : []
	};
	
	ajaxService.getJSON("/super/system/email/target_view.do", {seq : $routeParams.seq}, function(data){
		$.extend($scope.form, data.view);
		$.extend($scope.form.target_list, data.target_list);
	});
	
	$scope.openUserSelect = function(){
		var promise = userSelectFactory.openDialog();
		promise.then(function(result){
			if(result.rst == "Y"){
				$.each(result.list, function(i, o){
					$scope.form.target_list.push({user_name:o.member_nm, user_email:o.email});
				});
			}
		});
	}
	
	$scope.save = function(){
		$scope.form.target_cnt = $scope.form.target_list.length;
		if($scope.wFrm.$invalid){
			if($scope.wFrm.$error.required){
				alert("필수값을 입력하여 주십시오.");
			}else{
				alert("값이 유효하지 않습니다.");
			}
			$("#wFrm .ng-invalid")[0].focus();
			return false;
		}
		
		ajaxService.getJSON("/super/system/email/target_modify.do", {jData : angular.toJson($scope.form)}, function(data){
			$location.path("/target_list");
		});
	}
	
	$scope.upload = function(){
		var filename = $("#excelfile").val();
		filename = filename.slice(filename.indexOf(".") + 1).toLowerCase();
		if(filename==""){
			alert("업로드할 파일을 올려주시기 바랍니다.");
			return false;
		}
		if($.inArray(filename, ["xls"]) < 0 ){
			alert("xls 파일만 올려주시기 바랍니다.");
			return false;
		}
		
    	$("#wFrm").ajaxSubmit({
    		url : '/super/system/email/targetExcelUpload.do',
    		data : {},
    		iframe: false,
    		dataType : "json",
    		success : function(data){
    			$scope.$apply(function(){
    				var t_list = $scope.form.target_list.concat(data.list);
    				$scope.form.target_list = t_list;
    			});
    		},
    		error: function(e){
    			alert(e.responseText);
    		},
    		complete : function(){
    			//$("#excelfile").val('');
    		}
    	});
	};
	
	$scope.addEmail = function(){
		if($scope.form.temp_name=="" || $scope.form.temp_name==undefined){
			alert("성명을 입력해주시기 바랍니다.");
			return;
		}
		if($scope.form.temp_email=="" || $scope.form.temp_email==undefined){
			alert("이메일형식에 맞게 입력해주시기 바랍니다.");
			return;
		}
		
		$scope.form.target_list.push({user_name:$scope.form.temp_name, user_email:$scope.form.temp_email});
		$scope.form.temp_name="";
		$scope.form.temp_email="";
	}
	
	$scope.removeEmail = function(idx){
		$scope.form.target_list.splice(idx, 1);
	}
	
	$scope.sampleDownload = function(){
		location.href="/direct_download.do?path=/upload/sample&file_nm=target_sample.xls";
	}
	
});
app.controller("formModifyCtrl", function($scope, $window, $routeParams, $location, ajaxService, dialogService) {

	ajaxService.getJSON("/super/system/email/form_view.do", {seq : $routeParams.seq}, function(data){
		$scope.form = data;
	});
	
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
		
		ajaxService.getJSON("/super/system/email/form_modify.do", $scope.form, function(data){
			$location.path("/form_list");
		});
	}
	
});
app.controller("smtpModifyCtrl", function($scope, $window, $routeParams, $location, ajaxService, dialogService) {

	ajaxService.getJSON("/super/system/email/smtp_view.do", {seq : $routeParams.seq}, function(data){
		$scope.form = data;
	});
	
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
		
		ajaxService.getJSON("/super/system/email/smtp_modify.do", $scope.form, function(data){
			$location.path("/smtp_list");
		});
	}
	
});
app.controller('mailQueueCtrl', function($scope, ajaxService, dialogService) {
	ajaxService.getJSON('<c:url value="/super/system/email/queue_list.do"/>', {seq:$scope.model.seq}, function(data){
		$scope.queue_list = data.list;
	});
	
	$scope.cancelClick = function() {
		dialogService.cancel("mailQueueDialog");
	};

});
</script>
</head>
<body>
	<div class="titlebar">
		<h2>메일발송 관리</h2>
		<div>
			<span>시스템관리</span>&gt; <span>기타 설정</span>&gt; 
			<span class="bar_tx">메일설정 및 발송</span>
		</div>
	</div>
	<div data-ng-controller="mainCtrl">
		<div class="contents_wrap" data-ng-view data-ng-cloak></div>
	</div>
<script type="text/ng-template" id="mailQueueTemplete.html">
	<div ng-controller="mailQueueCtrl" title="발송내역">
        <table class="type1">
        	<colgroup>
            	<col style="width:25%;" />
            	<col />
            	<col style="width:20%;" />
        	</colgroup>
        	<tr>
        		<th scope="col" class="center">이름</th>
        		<th scope="col" class="center">이메일</th>
        		<th scope="col" class="center">상태</th>
        	</tr>
        	<tr data-ng-repeat="item in queue_list">
				<td class="center">{{item.user_name}}</td>
				<td class="center">{{item.user_email}}</td>
				<td class="center">{{item.status_nm}}</td>
			</tr>
        </table>
	</div>
</script>
</body>
</html>