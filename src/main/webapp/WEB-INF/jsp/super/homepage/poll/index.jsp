<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html data-ng-app="MyApp">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>McCMS</title>
<style type="text/css">
.nav {
    max-height: 250px;
}
/* .nav ul.list,
.nav ul.list ul {
    list-style-type: none;
    margin:0;
    padding:0;
    margin-left:10px; 
    position:relative;
    width:100%;
}
.nav ul.list ul:before {
    content:"";
    display:block;
    width:0;
    position:absolute;
    top:0;
    bottom:0;
    left:0;
    border-left:1px solid #ccc;
}
.nav ul.list li  {
    margin:0;
    padding:3px 12px;
    line-height:20px;
    position:relative;
    width:100%;
}
.nav ul.list li a { 
    line-height:20px;
    position:relative;
}
.nav ul.list li span>a:hover {
    color: #24c7fe;
}
.nav ul.list li.on > span>a {
    color: #24c7fe; 
}
.nav ul.list ul li:before {
    content:"";
    display:block;
    width:8px;
    height:0;
    border-top:1px solid #ccc;
    position:absolute;
    top:10px;
    left: 0;
}
.nav ul.list ul li:last-child:before { 
    background: #f8f8f8; 
    height: auto;
    top: 10px; 
    bottom: 0;
} */
.mCSB_outside+.mCSB_scrollTools {right: -15px;}
.mCustomScrollBox+.mCSB_scrollTools+.mCSB_scrollTools.mCSB_scrollTools_horizontal{bottom: -15px;}
</style>
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
<script type="text/javascript" src="<c:url value="/lib/js/directives/myEditor.js"/>"></script>
<script type="text/javascript">
var app = angular.module("MyApp", ['dialogService', 'ngRoute', 'myUtil', 'myFilter', 'myPagination', 'myCommon', 'ui.sortable', 'myEditor', 'ngSanitize']);
app.directive("scrollable", ["$timeout", function ($timeout) {
	return {
		link: function (scope, elem, attrs, ctrls) {
			$timeout(function(){
				var w = elem.width();
				elem.width(scope[attrs.scrollable].width);
				$("div.dept_container", elem).width(w);
				elem.mCustomScrollbar({
					axis:"yx",
					theme:"dark",
					scrollbarPosition:"outside"
				});
			});
		}
	};
}]);

app.run(function($rootScope,$location){
	$rootScope.param = {
		cms_menu_seq : '${param.cms_menu_seq}',
		parent_menu_seq : '${param.parent_menu_seq}',
		permit : '${param.permit }'
	};
	$rootScope.main = {};
	$rootScope.list = function(){
		$location.path("/");
	};
});

app.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
	$routeProvider
		.when('/list', {controller: 'listCtrl', templateUrl : 'st_exclude/list.do'})
		.when('/write', {controller: 'writeCtrl', templateUrl : 'st_exclude/write.do'})
		.when('/modify/:seq', {controller: 'modifyCtrl', templateUrl : 'st_exclude/modify.do'})
		.when('/result/:seq', {controller: 'resultCtrl', templateUrl : 'st_exclude/result.do'})
		.otherwise({redirectTo: '/list' });
}]);

app.controller("mainCtrl", function($scope, $location, $window, ajaxService) {});

app.controller("listCtrl", function($scope, $window, $routeParams, $rootScope, $compile, ajaxService, dialogService) {
	$scope.board = {};
	angular.extend($scope.param, {
			cpage : $scope.param.cpage||1,
			rows : $scope.param.rows||10,
			cms_menu_seq : $rootScope.param.cms_menu_seq,
			parent_menu_seq : $rootScope.param.parent_menu_seq,
			all : 'Y'
	});
	$scope.board.go = function(n){
		$scope.param.cpage=n;
		ajaxService.getJSON('<c:url value="/super/homepage/poll/list.do"/>?cpage='+n, $scope.param, function(data){
			$scope.board.list = data.list;
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.pagination.totalcount;
			$scope.board.totalPage = data.pagination.totalpage;
		});
	};
	
	$scope.deletes = function(){
		var del_seq = "";
		$($("#boardList input[type=checkbox]:checked").get().reverse()).each(function(){
			del_seq += $(this).val()+",";
		});
		if(del_seq == ""){
			alert("삭제하실 게시물을 선택해 주십시오.");
			return false;
		}
		del_seq = del_seq.substr(0,del_seq.length-1);
		if(confirm("삭제하시겠습니까?")){
			ajaxService.getJSON('<c:url value="/super/homepage/poll/delete.do"/>', {article_seq : del_seq}, function(data){
				$rootScope.list();
			});
		}
	}
});

app.controller("writeCtrl", function($scope, $window, $routeParams, $rootScope, ajaxService, dialogService) {
	var question_cnt = 0;
	
	$scope.form = {
		cms_menu_seq : $rootScope.param.cms_menu_seq,
		parent_menu_seq : $rootScope.param.parent_menu_seq,	
		lot_yn : 'N',
		groups : [],
		question : []		
	};
	
	$scope.openGroupSelect = function(){
		var options = {
				title : '그룹선택',
				autoOpen: false,
				modal: true,
				width: "440",
				height: "350",
				close: function(event, ui) {
				}
			};
		
		dialogService.open("groupSelectDialog", "groupSelectTemplete.html", {}, options)
		.then(
			function(result) {
				$scope.addGroup(result);
			},
			function(error) {
			}
		);
	};
	
	$scope.addGroup = function(item){
   		var list = $.map($scope.form.groups, function(item){
   				return item.group_seq; 
   			});
   		if($.inArray(item.group_seq, list) < 0){
   			$scope.form.groups.push({group_seq : item.group_seq, group_nm : item.group_nm});
   		}
	};
	
	$scope.removeGroup = function(idx){
		$scope.form.groups.splice(idx, 1);
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
		
		//등록삭제권한
		$scope.form.cud_group_seq = (function(list){
			var rst = [];
			for (var i = 0; i < list.length; i++) {
				var item = list[i];
				rst.push(item.group_seq+":"+item.group_nm);
			}
			return rst.join(",");
		})(angular.copy($scope.form.groups));
		
		ajaxService.getJSON("<c:url value="/super/homepage/poll/write.do"/>", {jData : angular.toJson($scope.form)}, function(data){
			$rootScope.list();
		});
	};
	
	$scope.changeType = function(idx){
		if($scope.form.question[idx].question_type == 'C'){
			$scope.form.question[idx].answers = [{answer : '주관식답변 ( 변경 불가 )', del_yn:'N', question_seq : idx, null_chk : 'N', jump_chk : 'N'}];
		}else{
			$scope.form.question[idx].answers = [{answer : '', del_yn:'N', question_seq : idx, null_chk : 'N', jump_chk : 'N'}];
		}
	};
	
	$scope.addQuestion = function(val){
		var idx = $scope.form.question.length;
		if(val == 'N'){
			question_cnt = question_cnt+1;
		}
		var data = {
				cnt : question_cnt,
				question_seq : idx,
				question : "",
				del_yn : 'N',
				question_type : "A",
				question_content : "",
				subject_yn : val,
				required_yn : "N",
				required_count : "0",
				required_count_controll : "U",
				answers : [
					{
						answer : '',
						del_yn : 'N',
						question_seq : idx,
						null_chk : 'N',
						jump_chk : 'N'
					}
				]
			};
		$scope.form.question.push(data);
	};
	
	$scope.addAnswer = function(item){
		item.answers.push({answer : '', del_yn:'N', question_seq : item.question_seq, null_chk : 'N', jump_chk : 'N'});
	};
	
	$scope.removeQuestion = function(idx, val){
		if(val == "N"){
			question_cnt = question_cnt - 1; 
		}
		$scope.form.question.splice(idx, 1);
		$.each($scope.form.question,function(i,v){
			if(val == "N"){
				v.cnt = v.cnt - 1; 
			}
			v.question_seq = i;
			$.each(v.answers,function(sub_i,sub_v){
				sub_v.question_seq = i;
			});
		});
	};
	
	$scope.removeAnswer = function(item,idx){
		item.answers.splice(idx, 1);
	};
});

app.controller("modifyCtrl", function($scope, $window, $routeParams, $rootScope, ajaxService, dialogService) {
	var question_cnt = 0;
	$scope.form = {
		cms_menu_seq : $rootScope.param.cms_menu_seq,
		parent_menu_seq : $rootScope.param.parent_menu_seq,	
		groups : [],
		question : []		
	};
	
	ajaxService.getJSON('<c:url value="/super/homepage/poll/view.do"/>', {poll_seq : $routeParams.seq}, function(data){
		
		data.view.question = [];
		$scope.form = data.view;
		$scope.form.groups = (function(list){
			var rst = [];
			if(!!list){
				var list = list.split(",");
				for (var i = 0; i < list.length; i++) {
					var item = list[i].split(":");
					rst.push({group_seq : item[0], group_nm:item[1]});
				}
			}
			return rst;
		})(data.view.cud_group_seq);
		
		var question_data = [];
		var data_question_cnt = 0;
		$.each(data.question,function(i,v){
			if(v.seq == -1){
				if(v.subject_yn == "N"){
					data_question_cnt = data_question_cnt+1;
					question_cnt = question_cnt+1; 
				}
				v.cnt = data_question_cnt;
				v.answers = [];
				v.new_yn = 'N';
				question_data.push(v);
			}
		})
		$.each(question_data,function(x,d){
			$.each(data.question,function(i,v){
				if(v.seq != -1 && d.question_seq == v.seq){
					var answer = {
						new_yn : 'N',
						del_yn : v.del_yn,
						answer : v.question,
						question_seq : v.seq,
						null_chk : v.null_chk,
						jump_chk : v.jump_chk
					};
					d.answers.push(answer);
				}
			})
		});
		$scope.form.question = question_data;
	});
		
	$scope.openGroupSelect = function(){
		var options = {
				title : '그룹선택',
				autoOpen: false,
				modal: true,
				width: "440",
				height: "350",
				close: function(event, ui) {
				}
			};
		
		dialogService.open("groupSelectDialog", "groupSelectTemplete.html", {}, options)
		.then(
			function(result) {
				$scope.addGroup(result);
			},
			function(error) {
			}
		);
	};
	
	$scope.addGroup = function(item){
   		var list = $.map($scope.form.groups, function(item){
   				return item.group_seq; 
   			});
   		if($.inArray(item.group_seq, list) < 0){
   			$scope.form.groups.push({group_seq : item.group_seq, group_nm : item.group_nm});
   		}
	};
	
	$scope.removeGroup = function(idx){
		$scope.form.groups.splice(idx, 1);
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
		
		//등록삭제권한
		$scope.form.cud_group_seq = (function(list){
			var rst = [];
			for (var i = 0; i < list.length; i++) {
				var item = list[i];
				rst.push(item.group_seq+":"+item.group_nm);
			}
			return rst.join(",");
		})(angular.copy($scope.form.groups));
		
		ajaxService.getJSON("<c:url value="/super/homepage/poll/modify.do"/>", {jData : angular.toJson($scope.form)}, function(data){
			$rootScope.list();
		});
	};
	
	$scope.changeType = function(idx){
		if($scope.form.question[idx].question_type == 'C'){
			$scope.form.question[idx].answers = [{answer : '주관식답변 ( 변경 불가 )', del_yn:'N', question_seq : idx, null_chk : 'N', jump_chk : 'N'}];
		}else{
			$scope.form.question[idx].answers = [{answer : '', del_yn:'N', question_seq : idx, null_chk : 'N', jump_chk : 'N'}];
		}
	}
	
	$scope.addQuestion = function(val){
		var idx = $scope.form.question.length;
		if(val == "N"){
			question_cnt = question_cnt+1;
		}
		var data = {
				cnt : question_cnt,
				new_yn : 'Y',
				del_yn:'N', 
				question_seq : idx,
				question : "",
				question_type : "A",
				question_content : "",
				subject_yn : val,
				required_yn : "N",
				required_count : "0",
				required_count_controll : "U",
				answers : [
					{
						new_yn : 'Y',
						del_yn:'N', 
						answer : '',
						question_seq : idx,
						null_chk : 'N',
						jump_chk : 'N'
					}
				]
			}
		$scope.form.question.push(data);
	}
	
	$scope.addAnswer = function(item){
		item.answers.push({new_yn : 'Y', answer : '', del_yn:'N', question_seq : item.question_seq, null_chk : 'N', jump_chk : 'N'});
	}
	
	$scope.removeQuestion = function(item, idx, val){
		if(val == "N"){
			question_cnt = question_cnt - 1; 
		}
		if(item.new_yn == 'Y'){
			$scope.form.question.splice(idx, 1);	
		}else{
			item.del_yn = 'Y';	
		}
		var data_question_cnt = 0;
		$.each($scope.form.question,function(i,v){
			if(v.subject_yn == "N" && v.del_yn == "N"){
				data_question_cnt = data_question_cnt + 1;
			}
			v.cnt = data_question_cnt;
			v.question_seq = i;
			$.each(v.answers,function(sub_i,sub_v){
				sub_v.question_seq = i;
			});
		});
	};
	
	$scope.removeAnswer = function(item,idx){
		if(item.new_yn == 'Y'){
			item.answers.splice(idx, 1);	
		}else{
			item.answers[idx].del_yn = 'Y';
		}
	}

	$scope.initResult = function(){
		if(confirm("조사가 완료된 데이터를 초기화 하시겠습니까?\n※삭제된 데이터는 복구가 불가능합니다.※")){
			ajaxService.getJSON('<c:url value="/super/homepage/poll/resultInit.do"/>', {poll_seq : $routeParams.seq}, function(data){
				if(data.rst == 1){
					alert("초기화가 완료 되었습니다.");
				}else{
					alert("초기화에 실패하였습니다.");
				}
			});
		}
	};
	
});


app.controller("resultCtrl", function($scope, $window, $routeParams, $rootScope, $sce, ajaxService, dialogService) {
	$scope.form = {
		cms_menu_seq : $rootScope.param.cms_menu_seq,
		parent_menu_seq : $rootScope.param.parent_menu_seq,	
		groups : [],
		question : []		
	};
	
	ajaxService.getJSON('<c:url value="/super/homepage/poll/result.do"/>', {poll_seq : $routeParams.seq}, function(data){
		data.view.question = [];
		$scope.form = data.view;
		$scope.form.groups = (function(list){
			var rst = [];
			if(!!list){
				var list = list.split(",");
				for (var i = 0; i < list.length; i++) {
					var item = list[i].split(":");
					rst.push({group_seq : item[0], group_nm:item[1]});
				}
			}
			return rst;
		})(data.view.cud_group_seq);
		
		var question_data = [];
		var data_question_cnt = 0;
		$.each(data.question,function(i,v){
			if(v.subject_yn == "N"){
				data_question_cnt = data_question_cnt+1;
			}
			v.cnt = data_question_cnt;
			v.answers = [];
			question_data.push(v);
		});
		
		$.each(question_data,function(x,d){
			$.each(data.answers,function(i,v){
				if(d.question_seq == v.question_seq){
					var answer = v;
					answer.percent = d.total == 0 ? 0+" %" : ((v.cnt / d.total) * 100).toFixed(1)+" %";
					answer.result_text = [];
					if(d.question_type == 'C' || (d.question_type == 'E' && answer.jump_chk == 'Y')){
						console.log(d);
						ajaxService.getJSON('<c:url value="/super/homepage/poll/result_detail.do"/>', v, function(data){
							answer.result_text = data.list;
						});
					}
					d.answers.push(answer);
				}
			})
		});
		$scope.form.question = question_data;
	});
	
	$scope.bindHTML = function(info){
		return $sce.trustAsHtml(info);
	}
	
	$scope.result_textarea = function(item){
		var options = {
				title : '결과',
				autoOpen: false,
				modal: true,
				width: "800",
				height: "700",
				close: function(event, ui) {
				}
			};
		var datas = "";
		dialogService.open("resultDetail", "resultDetail.html", item.result_text, options)
		.then(
			function(result) {
			},
			function(error) {
			}
		);
	};
	
	$scope.excel_down = function(item){
		location.replace("/super/homepage/poll/result_excel.do?poll_seq=" + item.poll_seq);
	}	
});




app.controller("resultDetailCtrl", function($scope, $window, $compile, $sce, ajaxService, dialogService) {
	$scope.answerText = function(info){
		return info.replace(/\n+/g,"<br/>");	
	}
});



//관리그룹 선택 컨트롤
app.controller("groupSelectCtrl", function($scope, $window, $compile, ajaxService, dialogService) {
	$scope.param = {};

	$scope.scrollOption = {
		width : 400	
	};
	
	$scope.makeTree = function(item){
		var html = "";
		html += "	<li data-group_seq='"+item.group_seq+"' del_yn='"+item.del_yn+"'>";
		html += "		<span><a data-ng-click='selectGroup("+angular.toJson(item)+")'>"+item.group_nm+"</a></span> ";
		html += "	</li>";
		return html;
	}
	
	ajaxService.getJSON('<c:url value="/super/group/list.do"/>', {}, function(data){
		data.unshift({group_seq:'0', group_nm:'비회원', parent_seq:'0', use_yn:'Y',order_seq:'0', reg_dt:'', level:'1'});
		data.unshift({group_seq:'-1', group_nm:'실명인증', parent_seq:'0', use_yn:'Y',order_seq:'0', reg_dt:'', level:'1'});
		for (var i = 0; i < data.length; i++) {
			var item = data[i];
			var dept = $scope.makeTree(item);
			var o;
			if(item.level == '1'){
				o = $(".dept_container>ul>li").last();
			}else if(item.level == '2'){
				o = $(".dept_container>ul>li>ul>li").last();
			}else if(item.level == '3'){
				o = $(".dept_container>ul>li>ul>li>ul>li").last();
			}else if(item.level == '4'){
				o = $(".dept_container>ul>li>ul>li>ul>li>ul>li").last();
			}else if(item.level == '5'){
				o = $(".dept_container>ul>li>ul>li>ul>li>ul>li>ul>li").last();
			}
			if(o.children("ul").size()==0) 
				o.append("<ul>");
			o.children("ul").append($compile(dept)($scope));
		}
		$(".dept_container li[del_yn='Y']").remove();
	});
	
	$scope.selectGroup = function(item){
		dialogService.close("groupSelectDialog", item);
	}
	
	$scope.cancel = function(){
		dialogService.cancel("groupSelectDialog");
	}
});
</script>
</head>
<body data-ng-controller="mainCtrl">
	<div class="titlebar">
		<h2>프로그램 관리</h2>
		<div>
			
		</div>
	</div>
	<div data-ng-controller="mainCtrl">
		<div data-ng-view data-ng-cloak></div>
	</div>
</body>
</html>
