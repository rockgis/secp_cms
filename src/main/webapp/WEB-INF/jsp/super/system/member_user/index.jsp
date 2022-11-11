<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 및 그룹 관리</title>
<style type="text/css">
li.line_bottom{border-bottom: 2px solid red;}
ul.temp_ul{position:relative;}
ul.temp_ul::before{content:''; position:absolute; width:17px; height:14px; top:-23px; left:-24px; background:url("/images/cms/left/drag_01_on.png") no-repeat 0px 0px;}
.mCSB_outside+.mCSB_scrollTools {right: -15px;}
.mCustomScrollBox+.mCSB_scrollTools+.mCSB_scrollTools.mCSB_scrollTools_horizontal{bottom: -15px;}
.ui-state-highlight{height:20px;}

.ui-selecting {  background: #f3f3f3; }
.ui-selected {  background: #f3f3f3; }
tr.ui-selectee:hover{background:#f3f3f3;}
.ui-state-active { background: #FFF7D7;}

/* 회원관리 팝업 */
.popup_navi{overflow:hidden; /* margin-bottom:10px; padding-bottom:10px; border-bottom:1px solid #d9d9d9; */ font-family:"Doutm";}
.popup_navi span{}
.popup_navi b{color:#000;}
.popup_tit{position:relative; margin-bottom:10px;}
.popup_tit p{padding-top:3px; margin-bottom:10px; font-family:"Doutm"; font-size:16px;}
.popup_tit p b{color:#2C7BCA;}
.popup_tit p span{color:#666;}
.popup_tit select{position:absolute; top:20px; right:0;}
.popup_contents{border:1px solid #d9d9d9;}
.pop_stat{padding:2px 3px 3px 3px; margin-right:5px; color:#fff !important; font-size:12px; background:#20b9ae;}
.all_chk{margin-left:3px; font-size:11px !important; color:#777;}

.chk_list{margin-top:10px;}
.chk_list div{padding:10px; border: 1px solid #d9d9d9; height:80px; overflow: auto; background:#dadee5;}
.chk_list div span{display:inline-block; padding:3px 5px; margin:0 5px 5px 0; color:#fff !important; background:#658ed7; border-radius:3px;}

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
<script type="text/javascript" src="<c:url value="/lib/js/route/routeResolver.js"/>"></script>
<script type="text/javascript">
var app = angular.module("MyApp", ['routeResolverServices', 'dialogService', 'ngRoute', 'myUtil', 'myPagination', 'myCommon', 'ui.sortable', 'myFilter', 'myEditor', 'ngRange', 'ngSanitize']);
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
app.run(function($rootScope){
	$rootScope.main = {};
	$rootScope.param = {
	};
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
	    .when('/list', route.resolve("list"))
		.otherwise({redirectTo: '/list' });
}]);

app.controller("mainCtrl", function($scope, $location, $compile, ajaxService, dialogService, $filter, $timeout) {
	//전화번호 앞자리 공통코드
	ajaxService.getSyncJSON("<c:url value="/json/list/Code.codeList.do"/>", {code_group_seq : '1'}, function(data){
		$scope.main.tel1 = data;
	});
	//휴대폰 앞자리 공통코드
	ajaxService.getSyncJSON("<c:url value="/json/list/Code.codeList.do"/>", {code_group_seq : '2'}, function(data){
		$scope.main.cell1 = data;
	});
	//휴대폰 앞자리 공통코드
	ajaxService.getSyncJSON("<c:url value="/json/list/Code.codeList.do"/>", {code_group_seq : '3'}, function(data){
		$scope.main.email2 = data;
	});
	
	$scope.main.super_pw = null;
	
	$scope.scrollOption = {
		width : 400	
	};
	
	$scope.main.deptspace = function(lv){
		var rst = "";
		for(var i = 1;i < lv; i++){
			rst += "_";
		}
		return rst;
	}
	
	$scope.searchGroupNm = function(){
		var text = $scope.search_group;
		if(!text){
			$(".dept_container>ul>li li").show();
		}else{
			$(".dept_container>ul>li li").hide();
			$(".dept_container>ul>li li[data-group_nm*='"+text+"']").show().parents(".dept_container>ul>li li").show();
		}
	}
	
	//그룹목록
	$scope.group_list = function(){

		$(".dept_container").block();
		var promise = ajaxService.getJSON('<c:url value="/super/user_group/list.do"/>', {}, function(data){
			$scope.main.dept = data;
			$(".dept_container>ul>li>ul").remove();
			for (var i = 0; i < data.length; i++) {
				var item = data[i];
				var dept = makeTree(item);
				var sb = ".dept_container>ul>li";
				for (var j = 1; j < item.level; j++) {
					sb += ">ul>li";
				}
				var o = $(sb).last();
				if(o.children("ul").size()==0) 
					o.append("<ul>");
					
				o.children("ul").append($compile(dept)($scope));
			}
			$scope.param.group_seq = $scope.param.group_seq||$scope.main.dept[0].group_seq;
			$(".dept_container [data-group_seq="+$scope.param.group_seq+"]").addClass("on");
			$(".dept_container li[del_yn='Y']").remove();
			$(".dept_container ul").each(function(i,o){
				$(this).children("li:last").addClass("last");
			});
			$(".dept_container ul>li").each(function(i,o){
				if($("li", this).size()>0){
					$(this).prepend('<div class="hitarea expandable"></div>');
				}
			});
			$scope.group_move();
		});
		promise.then(function(){
			$(".dept_container").unblock();
		});
	}
	$scope.group_list();
	
	//그룹변경시 리스트 다시 가져오기
	$scope.$watch("param.group_seq", function(newVal, oldVal){
		$(".dept_container li").removeClass("on");
		$(".dept_container [data-group_seq="+newVal+"]").addClass("on");
		$location.search($scope.param);
	});
	
	$scope.group_move = function(){
		var clone, idx;
		$(".dept_container>ul>li>ul li").draggable({
			distance: 25,
			revert: "invalid",
			start : function(e, ui){
				clone = $(e.target).closest("ul");
				idx = clone.children("li").index(this);
			},
			helper: function(e) {
				var set = $("<span>"+$(">a", this).text()+"</span>")
				.css({
					zIndex : 999,
					cursor: 'pointer', display:'block', 'background-color':'#eee',
					height:"20px",width:'5px;'
				});
				return set;
			},
			cursorAt: {left: 25, top: 10}
		});
		
		$(".dept_container>ul>li li, .dept_container>ul>li a>span").droppable({
			greedy: true,
			over : function(e, ui){
					if($(ui.helper).get(0).tagName!="DIV"){
						$(".dept_container>ul>li li").removeClass("line_bottom");
						if($(e.target).get(0).tagName=="LI"){
							$(e.target).addClass("line_bottom");
						}
					}
				
			},
			out : function(e, ui){
				if($(ui.helper).get(0).tagName!="DIV"){
					$(".dept_container>ul>li li").removeClass("line_bottom");
					$(".dept_container>ul>li ul.temp_ul").remove();
				}
			},
			drop: function(e, ui) {
				$(ui.helper).hide();
				if($(ui.helper).get(0).tagName!="DIV"){
					if($(e.target).get(0).tagName=="LI"){
						$(e.target).after(ui.draggable);
					}else{
						$(e.target).closest("li").children("ul").append(ui.draggable);
					}
					$(".dept_container>ul>li li").removeClass("line_bottom");
					
					if(confirm('메뉴를 이동시키시겠습니까?')){
						
						var group_data = $.map($(".dept_container>ul ul>li"), function(item, i){
							return {
								order_seq : $(item).closest("ul").children("ul>li").index(item)
								, parent_seq : $(item).closest("ul").closest("li").attr("data-group_seq")|0
								, group_seq : $(item).attr("data-group_seq")
							}; 
						});
						ajaxService.getJSON("<c:url value="/super/member_user/updateOrder.do"/>", {jData : angular.toJson({group_list : group_data})}, function(data){
							if(data.rst == '1'){
				  				$scope.group_list();
				  			}
						});
						
					}else{
						if(clone.children("li:eq("+idx+")").size()==0){
							clone.append(ui.draggable);
						}else{
							clone.children("li:eq("+idx+")").before(ui.draggable);
						}
						$(".temp_ul").remove();
					}
				}else{
					var target = null;
					if($(e.target).get(0).tagName=="LI"){
						target = $(e.target);
					}else{
						target = $(e.target).closest("li");
					}
					var obj = $("span", ui.helper);
					var group_nm = target.children("a").text();
			    	var first_user_nm = obj.eq(0).text();
			    	var user_size = obj.size();
			    	var q;
			    	if(user_size==0){
			    		return;
			    	}else if(user_size>1){
			    		q = first_user_nm + " 외 "+ (user_size-1) +"명의 회원을 " + group_nm + "그룹으로 이동시키겠습니까?";
			    	}else{
			    		q = first_user_nm + " 회원을 " + group_nm + "그룹으로 이동시키겠습니까?";
			    	}
			    	if(!confirm(q)){
			    		return false;
			    	}
		    		var dataset = (function(list){
		    			var rst = [];
		    			list.each(function(i, o){
		    				rst.push({
		    					group_seq : target.attr("data-group_seq"),
		    					member_id : $(this).text()
		    				});
		    			});
		    			return rst;
		    		})(obj);
		    		
		    		ajaxService.getJSON("/super/member_user/updateGroup.do", {jData : angular.toJson({list : dataset})}, function(data){
		    			if(data.rst == '1'){
		    				$scope.param.rnd = Math.random();
		    				$location.search($scope.param);
		      			}
		    		});
				}
			}
		});
	}
	
	$scope.openGroupAdd = function(item){
		var options = {
				title : '그룹 추가',
				autoOpen: false,
				modal: true,
				width: "570",
				height: "auto",
				close: function(event, ui) {
				}
			};

		item.mode = 'ADD';
		dialogService.open("groupEditDialog", "/st_exclude/super/system/member_user/groupEditTemplete.do", item, options)
		.then(
			function(result) {
				alert("추가 되었습니다.");
				$scope.group_list();
			},
			function(error) {
			}
		);
	}
	
	$scope.openGroupMod = function(item, opt){
		var options = {
				title : '그룹 편집',
				autoOpen: false,
				modal: true,
				width: "570",
				height: "auto",
				close: function(event, ui) {
				}
			};
		
		item.mode = 'MOD';
		if(!!opt){
			item.opt = opt;
		}
		dialogService.open("groupEditDialog", "/st_exclude/super/system/member_user/groupEditTemplete.do", item, options)
		.then(
			function(result) {
				alert("수정 되었습니다.");
				$scope.group_list();
			},
			function(error) {
			}
		);
	}
	
	$scope.openGroupDel = function(item){
		var options = {
				title : '그룹 삭제',
				autoOpen: false,
				modal: true,
				width: "570",
				height: "auto",
				close: function(event, ui) {
				}
			};
		
		dialogService.open("groupDelDialog", "/st_exclude/super/system/member_user/groupDelTemplete.do", item, options)
		.then(
			function(result) {
				alert("그룹이 삭제 되었습니다.");
				$scope.group_list();
			},
			function(error) {
			}
		);
	}
	
	$scope.openSortMember = function(){
		var options = {
				autoOpen: false,
				modal: true,
				width: "670",
				height: "auto",
				close: function(event, ui) {
				}
			};
		dialogService.open("SortMemberDialog","/st_exclude/super/system/member_user/SortMemberTemplete.do", angular.copy($scope.param), options)
		.then(
			function(result) {
				$scope.group_list();
			},
			function(error) {
				$scope.group_list();
			}
		);
	}
	
	$scope.memberHistory = function(item){
		var options = {
				title : '로그보기',
				autoOpen: false,
				modal: true,
				width: "850",
				height: "auto",
				close: function(event, ui) {
				}
			};
		
		dialogService.open("memberHistoryDialog", "/st_exclude/super/system/member_user/memberHistoryTemplete.do", item, options)
		.then(
			function(result) {
				alert("수정 되었습니다.");
			},
			function(error) {
			}
		);
	}
	
	$scope.modify_pw = function(item){
		var options = {
				title : '비밀번호 변경',
				autoOpen: false,
				modal: true,
				width: "550",
				height: "auto"
			};
		dialogService.open("ModifyPwDialog", "/st_exclude/super/system/member_user/ModifyPwTemplete.do", {member_id : item.member_id}, options)
		.then(
			function(result) {
				alert("변경되었습니다.");
			},
			function(error) {
			}
		);
	}
	
	$scope.check_pw = function(){
		var options = {
				title : '관리자 확인',
				autoOpen: false,
				modal: true,
				width: "550",
				height: "auto"
			};
		dialogService.open("checkPwDialog", "/st_exclude/super/system/member_user/checkPwTemplete.do", {}, options)
		.then(
			function(result) {
				memberEditScope().save()
			},
			function(error) {
			}
		);
	}
	
	$scope.init_pw = function(item){
		if(!confirm("비밀번호를 초기화 하시겠습니까?")){
			return false;
		}
		ajaxService.getJSON("<c:url value="/super/member_user/init_pw.do"/>", item, function(data){
			if(data.rst == '1'){
				alert("초기화 되었습니다.");
			}else{
				alert(data.msg);
			}
		});
	}
	
	$scope.init_block = function(item){
	    if(!confirm("계정 잠금 상태를 해제 하시겠습니까?")){
			return false;
		}
		ajaxService.getJSON("<c:url value="/super/member_user/memberBlockInit.do"/>", {member_id: item.member_id}, function(data){
			alert("계정이 활성화 되었습니다.");
		});
	}

	$(document).on("click", ".hitarea", function(){
		$(this).swapClass("expandable", "expandable-hitarea");
		$(this).siblings("ul").toggle();
	});
	
});
app.controller("groupEditCtrl", function($scope, $window, ajaxService, dialogService) {
	
	if($scope.model.mode == 'ADD'){
		$scope.form = {
			parent_seq : ($scope.model.group_seq||"0"),
			use_yn : 'Y'
		};
	}else{
		ajaxService.getSyncJSON('<c:url value="/super/user_group/view.do"/>', $scope.model, function(data){
			$scope.form = data.view;
			$scope.form.staff_list = data.staff_list;
		});
		$scope.form.current_manage_seq = $scope.model.manage_seq;
	}
	
	$scope.groupPermission = function(){
		var options = {
				title : '접근권한',
				autoOpen: false,
				modal: true,
				width: "550",
				height: "auto",
				close: function(event, ui) {
				}
			};
		
		dialogService.open("groupPermissionDialog", "/st_exclude/super/system/member_user/groupPermissionTemplete.do", $scope.form, options)
		.then(
			function(result) {
				$scope.form.staff_list = result;
			},
			function(error) {
			}
		);
	}
	 
	$scope.save = function(){
		if($scope.groupFrm.$invalid){
			if($scope.groupFrm.$error.required){
				alert("필수값을 입력하여 주십시오.");
			}else{
				alert("값이 유효하지 않습니다.");
			}
			$("#groupFrm .ng-invalid")[0].focus();
			return false;
		}
		if($scope.model.mode == 'ADD'){
			ajaxService.getJSON('<c:url value="/super/user_group/write.do"/>', {jData : angular.toJson($scope.form)}, function(data){
				listCtrlScope().board.go(1);
				dialogService.close("groupEditDialog");
			});
		}else{
			ajaxService.getJSON('<c:url value="/super/user_group/modify.do"/>', {jData : angular.toJson($scope.form)}, function(data){
				listCtrlScope().board.go(1);
				dialogService.close("groupEditDialog");
			});
		}
	}
	if(!!$scope.model.opt){
		if($scope.model.opt=="p"){
			$scope.groupPermission();		
		}
	}
});
app.controller("groupDelCtrl", function($scope, $window, ajaxService, dialogService) {
	$scope.data = {
		mode : '',
		group_seq : '',
		move_group_seq : ''
	};
	
	$scope.yes = function(){
		$scope.data.mode = 'YES';
		$scope.data.group_seq = $scope.model.group_seq;
		$scope.del();
	}
	
	$scope.no = function(){
		var options = {
				title : '그룹선택',
				autoOpen: false,
				modal: true,
				width: "550",
				height: "350",
				close: function(event, ui) {
				}
			};
		
		dialogService.open("groupSelectDialog", "/st_exclude/super/system/member_user/groupSelectTemplete.do", $scope.model, options)
		.then(
			function(result) {
				$scope.data = {
					mode : 'NO',
					group_seq : $scope.model.group_seq,
					move_group_seq : result
				};
				$scope.del();
			},
			function(error) {
			}
		);
	}
	
	$scope.del = function(){
		ajaxService.getJSON('<c:url value="/super/user_group/del.do"/>', $scope.data, function(data){
			dialogService.close("groupDelDialog");
		});
	}
	
	$scope.cancel = function(){
		dialogService.cancel("groupDelDialog");
	}
});
app.controller("ModifyPwCtrl", function($scope, $window, ajaxService, dialogService) {
	$scope.form = {member_id : $scope.model.member_id};
	
	$scope.save = function(){
		if($scope.pFrm.$invalid){
			if($scope.pFrm.$error.required){
				alert("필수값을 입력하여 주십시오.");
			}else{
				alert("값이 유효하지 않습니다.");
			}
			$("#pFrm .ng-invalid")[0].focus();
			return false;
		}
		ajaxService.getJSON('/super/member_user/modify_pw.do', $scope.form, function(data){
			if(data.rst == "N") {
				alert("관리자의 비밀번호가 알맞지 않습니다.");
				return false;
			}
			dialogService.close("ModifyPwDialog");
		});
	}
});

app.controller("checkPwCtrl", function($scope, $window, ajaxService, dialogService) {
	$scope.save = function(){
		if($scope.pFrm.$invalid){
			if($scope.pFrm.$error.required){
				alert("필수값을 입력하여 주십시오.");
			}
			$("#pFrm .ng-invalid")[0].focus();
			return false;
		}
		$scope.main.super_pw = $scope.form.super_member_pw;
		dialogService.close("checkPwDialog");
	}
});

app.controller("groupSelectCtrl", function($scope, $window, $compile, ajaxService, dialogService) {

	$scope.scrollOption = {
		width : 300	
	};
	ajaxService.getJSON('<c:url value="/super/user_group/list.do"/>', {}, function(data){
		for (var i = 0; i < data.length; i++) {
			var item = data[i];
			if(item.group_seq == $scope.model.group_seq){
				continue;
			}
			var dept = makeSelectTree(item);
			var sb = "#select_tree>li";
			for (var j = 1; j < item.level; j++) {
				sb += ">ul>li";
			}
			var o = $(sb).last();
			if(o.children("ul").size()==0) 
				o.append("<ul>");
			o.children("ul").append($compile(dept)($scope));
		}
		
		$("#select_tree li[del_yn='Y']").remove();
		$("#select_tree ul").each(function(i,o){
			$(this).children("li:last").addClass("last");
		});
		$("#select_tree ul>li").each(function(i,o){
			if($("li", this).size()>0){
				$(this).prepend('<div class="hitarea expandable"></div>');
			}
		});
	});
	
	$scope.selectGroup = function(item){
		
		if(confirm("속한 회원들을 " + item.group_nm + "으로 이동시키겠습까?")){
			dialogService.close("groupSelectDialog", item.group_seq); 
		}
	}
	
	$scope.cancel = function(){
		dialogService.cancel("groupSelectDialog");
	}
});
app.controller("memberEditCtrl", function($scope, $window, ajaxService, dialogService) {
	$scope.form = {};
	if($scope.model.mode == 'ADD'){
		$scope.form.group_seq = $scope.model.group_seq;
	}else{
		ajaxService.getSyncJSON('<c:url value="/super/member_user/view.do"/>', $scope.model, function(data){
			$scope.form = data;
			$scope.form.group_seq = Number(data.group_seq);
		});
	}
	
	//id 중복 체크
	$scope.$watch("form.member_id", function(newVal, oldVal){
		if(angular.equals(newVal, oldVal)){
			return;
		}
		ajaxService.getJSON('<c:url value="/super/member_user/id_check.do"/>', {member_id : newVal}, function(data){
			if(data.rst == "Y"){
				$scope.memberFrm.member_id.$setValidity("idcheck", false);
			}else{
				$scope.memberFrm.member_id.$setValidity("idcheck", true);
			}
		});
		
	});
	
	$scope.init_pw = function(item){ 
		MainScope().init_pw(item);
	}
	
	$scope.modify_pw = function(item){ 
		MainScope().modify_pw(item);
	}
	
	$scope.memberHistory = function(item){ 
		MainScope().memberHistory(item);
	}
	
	$scope.init_block = function(item){ 
		MainScope().init_block(item);
	}
	
	$scope.checkForm = function(item){
		if($scope.memberFrm.$invalid){
			if($scope.memberFrm.$error.required){
				alert("필수값을 입력하여 주십시오.");
			}else{
				alert("값이 유효하지 않습니다.");
			}
			$("#memberFrm .ng-invalid")[0].focus();
			return false;
		}
	}
	
	$scope.save = function(){
		if($scope.model.mode == 'ADD'){
			var member_id = $("#member_id").val();
			if(member_id == "" || member_id == null) {
				alert("아이디를 입력하세요");
				return false;
			} else if(!( /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{4,}$/).test(member_id)){
				alert("아이디는 4자리 이상 영문/숫자 조합으로 가능합니다.");
				return false;
			}
			
			var member_pw = $("#member_pw").val();
			if(member_pw == "" || member_pw == null) {
				alert("비밀번호를 입력하세요");
				return false;
			} else if(!(/^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9_]).*$/).test(member_pw)){
				alert("비밀번호는 6~20자의 영문 대소문자, 숫자, 특수문자를 조합하여 사용하실 수 있습니다.");
				return false;
			}
			
			if($scope.checkForm() == false) return false; 
			if(!confirm("등록하시겠습니까?")){
				return false;
			}
			
			ajaxService.getJSON('<c:url value="/super/member_user/write.do"/>', $scope.form, function(data){
				dialogService.close("memberEditDialog");
			}, "회원등록");
		}else{
			if($scope.checkForm() == false) return false;
			if($scope.main.super_pw != null) {
				if(!confirm("수정하시겠습니까?")){
					return false;
				}
				$scope.form.super_pw = $scope.main.super_pw;
				ajaxService.getJSON('<c:url value="/super/member_user/modify.do"/>', $scope.form, function(data){
					if(data.rst == "Y"){
						dialogService.close("memberEditDialog");
						$scope.main.super_pw = null;
					}else{
						$scope.main.super_pw = null;
						alert("관리자 비밀번호가 일치하지 않습니다.");
					}
				}, "회원수정");
			} else {
				MainScope().check_pw();
			}
		}
	}
});

app.controller("groupPermissionCtrl", function($scope, $window, $compile, ajaxService, dialogService) {
	$scope.form = {
		group_seq : $scope.model.group_seq,
		group_nm : $scope.model.group_nm,
		staff_list : $.extend([],$scope.model.staff_list)||[],
		select_list : []
	};

	$scope.scrollOption = {
		width : 500
		/* 설정권한 지정 그룹목록 사이즈 */
	};
	
	$scope.makeTree = function(item){
		var html = "";
		html += "	<li class='expandable off' menu_seq='"+item.cms_menu_seq+"' menu_title='"+item.title+"' del_yn='"+item.del_yn+"' use_yn='"+item.use_yn+"'>";
		html += "		<span class='off'><a data-ng-click='selectMenu("+JSON.stringify(item)+")'>"+item.title+"</a></span> ";
		html += "	</li>";
		return html;
	}
	
	$scope.selectMenu = function(item){
		$(".permitDiv li[menu_seq='"+item.cms_menu_seq+"']").swapClass("on", "off");
		$(".permitDiv li[menu_seq='"+item.cms_menu_seq+"']").children("span").swapClass("on", "off");
		
		if($(".permitDiv li[menu_seq='"+item.cms_menu_seq+"'].off").size() > 0){
			$.each($scope.form.staff_list, function(i, o){
				if(item.cms_menu_seq == o.cms_menu_seq){
					$scope.form.staff_list.splice(i, 1);
					return false;
				}
			});
		}else{
			$scope.form.staff_list.push({cms_menu_seq : item.cms_menu_seq, title : item.title});
		}
		
		$scope.select_list_div();
	}
	
	ajaxService.getJSON('<c:url value="/super/member/site_list.do"/>', $scope.model, function(data){
		$scope.site_list = data.site_list;
		$scope.form.site_id = $scope.site_list[0].cms_menu_seq;
		$scope.changeSite();
	});
	
	$scope.changeSite = function(){
		ajaxService.getJSON('<c:url value="/super/homepage/left_list.do"/>', {site_id : $scope.form.site_id}, function(data){
			$(".permitDiv>ul>li>ul>li").remove();
			for (var i = 0; i < data.length; i++) {
				var item = data[i];
				var dept = $scope.makeTree(item);

				var sb = ".permitDiv";
				for (var j = 1; j <= item.menu_level; j++) {
					sb += ">ul>li";
				}
				var o = $(sb).last();
				
				if(o.children("ul").size()==0) 
					o.append("<ul>");
				o.children("ul").append($compile(dept)($scope));
			}
			$(".permitDiv li[del_yn='Y']").remove();
			$(".permitDiv li[use_yn='N']").remove();
			$(".permitDiv ul").each(function(i,o){
				$(this).children("li:last").addClass("last");
			});
			$(".permitDiv ul>li").each(function(i,o){
				if($("li", this).size()>0){
					$(this).prepend('<div class="hitarea expandable"></div>');
				}
			});
			
			$.each($scope.form.staff_list, function(i, o){
				$(".permitDiv li[menu_seq='"+o.cms_menu_seq+"']").swapClass("on", "off");
				$(".permitDiv li[menu_seq='"+o.cms_menu_seq+"']").children("span").swapClass("on", "off");
				$scope.select_list_div();
			})

			/*-----------
			ajaxService.getJSON('<c:url value="/super/user_group/menuGrantList.do"/>', {site_id:$scope.form.site_id, group_seq : $scope.form.group_seq}, function(data){
				$scope.permission_list = data;
				$.each($scope.permission_list, function(i, o){
					$(".permitDiv li[menu_seq='"+o.cms_menu_seq+"']").swapClass("on", "off");
					$(".permitDiv li[menu_seq='"+o.cms_menu_seq+"']").children("span").swapClass("on", "off");
					$scope.select_list_div();
				})
			});
			*/
		});
	}
	$scope.select_list_div = function(){
		$scope.form.select_list = [];
		$(".permitDiv li.on").each(function(i, o){
			$scope.form.select_list.push({cms_menu_seq : $(this).attr("menu_seq"), title:$(this).attr("menu_title")});
		})
	}
	
	$scope.save = function(){
		dialogService.close("groupPermissionDialog", $scope.form.staff_list);
		/*if(!confirm("저장하시겠습니까?")){
			return false;
		}
		var p = {jData : JSON.stringify({site_id:$scope.form.site_id, group_seq : $scope.form.group_seq, group_nm : $scope.form.group_nm, list : $scope.form.select_list})};
		ajaxService.getJSON('<c:url value="/super/user_group/updateMenuGrant.do"/>', p, function(data){
			if(data.rst=="1"){
				alert("저장되었습니다.");
			}
		});*/
	}
});

app.controller("memberHistoryCtrl", function($scope, $window, $compile, ajaxService, dialogService) {
	$scope.param = {
		member_id : $scope.model.member_id,
		member_nm : $scope.model.member_nm
	};
	
	//회원목록
	$scope.board = {};
	$scope.board.go = function(n){
		$scope.param.cpage=n;

		$("#listWrap").block();
		var promise = ajaxService.getJSON('<c:url value="/super/member_user/memberHistory.do"/>', $scope.param, function(data){
			$scope.board.list = data.list;
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.pagination.totalcount;
			$scope.board.totalPage = data.pagination.totalpage;
		});
		promise.then(function(){
			$("#listWrap").unblock();
		});
	};
	$scope.board.go(1);
	
	$scope.cancel = function(){
		dialogService.cancel("memberHistoryDialog");
	}
});
//삭제시 선택그룹 트리 그림
function makeSelectTree(item){
	var html = "";
	html += "	<li class='expandable' del_yn='"+item.del_yn+"'>";
	html += "		<span><a data-ng-click='selectGroup("+angular.toJson(item)+")'>"+item.group_nm+"</a></span> ";
	html += "	</li>";
	return html;
}
//그룹 트리 그림
function makeTree(item){
	var html = "";
	html += "	<li class='expandable' data-group_seq='"+item.group_seq+"' del_yn='"+item.del_yn+"' data-group_nm='"+item.group_nm+"'>";
	html += "		<a data-ng-click='param.group_seq="+item.group_seq+"' title='"+item.group_nm+" 그룹선택'><span>"+item.group_nm+"</span></a> ";
	if(item.group_seq == "1"){
		html += "		<span class='tree_util'><a class='tree_mod' data-ng-click='openGroupMod("+angular.toJson(item)+")' title='편집'>편집</a></span>";
	}else if(item.group_seq == "3"){
		html += "		<span class='tree_util'><a class='tree_mod' data-ng-click='openGroupMod("+angular.toJson(item)+")' title='편집'>편집</a></span>";		
	}else if(item.group_seq != "1" || item.group_seq != "3"){
		html += "		<span class='tree_util'><a class='tree_mod' data-ng-click='openGroupMod("+angular.toJson(item)+")' title='편집'>편집</a><a class='tree_del' data-ng-click='openGroupDel("+angular.toJson(item)+")' title='삭제'>삭제</a></span>";
	}
	html += "	</li>";
	return html;
}
//main컨트롤러 접근
function MainScope() {
    return angular.element(document.getElementById("mainDiv")).scope();
}

//memberEdit컨트롤러 접근
function memberEditScope() {
    return angular.element(document.getElementById("memberEditDiv")).scope();
}

//list컨트롤러 접근
function listCtrlScope() {
  return angular.element(document.getElementById("listCtrlDiv")).scope();
}
</script>
</head>
<body>
	<div class="titlebar">
		<h2>일반회원 및 그룹 관리</h2>
		<div>
			<span>시스템 관리</span>&gt;<span>회원관리</span>&gt;
			<span class="bar_tx">일반회원 및 그룹 관리</span>
		</div>
	</div>
	<div id="mainDiv" class="contents_wrap" data-ng-controller="mainCtrl">
		<div class="contents membercontents" >
			<div id="group_div" class="nav nav_style_1" scrollable="scrollOption" style="width:400px; height:530px;">
				<div class="group_sch">그룹검색  <input type="text" class="normal w175" ng-model="search_group" ng-change="searchGroupNm()"/></div>
				<div class="dept_container" >
					<ul class="list treeview">
						<li class="expandable">
							<a>그룹</a>
							<span class="tree_util"><a class="tree_add" data-ng-click="openGroupAdd({group_seq:''})">추가</a></span>
						</li>
					</ul>
				</div>
			</div>
			<div data-ng-view data-ng-cloak></div>
		</div>
	</div>

</body>
</html>