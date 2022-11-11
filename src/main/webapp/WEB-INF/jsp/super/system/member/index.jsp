<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자 회원 관리</title>
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
				$(".mCSB_draggerRail").css("height", "0");
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
		var promise = ajaxService.getJSON('<c:url value="/super/group/list.do"/>', {}, function(data){
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
	
	$scope.group_move = function(){
		var clone, idx;
		$(".dept_container>ul>li>ul li[data-group_seq=3] li").draggable({
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
				if($(e.target).closest("li[data-group_seq=3]").size()>0){
					if($(ui.helper).get(0).tagName!="DIV"){
						$(".dept_container>ul>li li").removeClass("line_bottom");
						if($(e.target).get(0).tagName=="LI"){
							$(e.target).addClass("line_bottom");
						}else{
							if($(e.target).closest("li").has("ul").size()==0){
								$(e.target).closest("li").append("<ul class='temp_ul'></ul>");
							}
						}	
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
				if($(e.target).closest("li[data-group_seq=3]").size()>0 && $(ui.helper).get(0).tagName!="DIV"){
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
						ajaxService.getJSON("<c:url value="/super/member/updateOrder.do"/>", {jData : angular.toJson({group_list : group_data})}, function(data){
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
		    		
		    		ajaxService.getJSON("/super/member/updateGroup.do", {jData : angular.toJson({list : dataset})}, function(data){
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
		dialogService.open("groupEditDialog", "/st_exclude/super/system/member/groupEditTemplete.do", item, options)
		.then(
			function(result) {
				alert("추가 되었습니다.");
				$scope.group_list();
				$scope.param.rnd = Math.random();
				$location.search($scope.param);
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
		dialogService.open("groupEditDialog", "/st_exclude/super/system/member/groupEditTemplete.do", item, options)
		.then(
			function(result) {
				alert("수정 되었습니다.");
				$scope.group_list();
				$scope.param.rnd = Math.random();
				$location.search($scope.param);
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
		
		dialogService.open("groupDelDialog", "/st_exclude/super/system/member/groupDelTemplete.do", item, options)
		.then(
			function(result) {
				alert("그룹이 삭제 되었습니다.");
				$scope.group_list();
				$scope.param.rnd = Math.random();
				$location.search($scope.param);
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
		dialogService.open("SortMemberDialog","/st_exclude/super/system/member/SortMemberTemplete.do", angular.copy($scope.param), options)
		.then(
			function(result) {
				$scope.group_list();
			},
			function(error) {
				$scope.group_list();
			}
		);
	}
	
	//그룹변경시 리스트 다시 가져오기
	$scope.$watch("param.group_seq", function(newVal, oldVal){
		$(".dept_container li").removeClass("on");
		$(".dept_container [data-group_seq="+newVal+"]").addClass("on");
		$location.search($scope.param);
	});
	
	$scope.openMoveMemberGroup = function(){
		var options = {
				title : '회원부서 변경',
				autoOpen: false,
				modal: true,
				width: "350",
				height: "auto",
				close: function(event, ui) {
				}
			};

		var member_list = [];
		$("#board_div tbody#listWrap input[type=checkbox]:checked").each(function(){
			member_list.push({member_id:$(this).val()});
		})
		
		if(member_list.length==0){
			alert("부서이동할 회원을 선택하여주시기 바랍니다.");
			return false;
		}
		
		dialogService.open("moveMemberGroupDialog", "/st_exclude/super/system/member/moveMemberGroupTemplete.do", {group_seq : $scope.param.group_seq, member_list : member_list}, options)
		.then(
			function(result) {
				alert("회원부서정보가 변경 되었습니다.");
				$scope.param.rnd = Math.random();
				$location.search($scope.param);
			},
			function(error) {
			}
		);
	}
	/*
	$scope.permission = function(item){
		var options = {
				title : '설정지정',
				autoOpen: false,
				modal: true,
				width: "600",
				height: "auto",
				close: function(event, ui) {
				}
			};
		
		dialogService.open("permissionDialog", "/st_exclude/super/system/member/permissionTemplete.do", item, options)
		.then(
			function(result) {
				alert("수정 되었습니다.");
			},
			function(error) {
			}
		);
	}

	$scope.staff = function(item){
		var options = {
				title : '담당자지정',
				autoOpen: false,
				modal: true,
				width: "600",
				height: "auto",
				close: function(event, ui) {
				}
			};
		
		dialogService.open("staffDialog", "/st_exclude/super/system/member/staffTemplete.do", item, options)
		.then(
			function(result) {
				alert("수정 되었습니다.");
			},
			function(error) {
			}
		);
	}*/
	
	/* 이거 안쓰는거 같아서 일단 주석
	$scope.memberPermit = function(item){
		var options = {
				title : '개인권한',
				autoOpen: false,
				modal: true,
				width: "850",
				height: "auto",
				close: function(event, ui) {
				}
			};
		
		dialogService.open("memberPermitDialog", "/st_exclude/super/system/member/memberPermitTemplete.do", item, options)
		.then(
			function(result) {
				alert("수정 되었습니다.");
			},
			function(error) {
			}
		);
	}
	*/
	
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
		
		dialogService.open("memberHistoryDialog", "/st_exclude/super/system/member/memberHistoryTemplete.do", item, options)
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
		dialogService.open("ModifyPwDialog", "/st_exclude/super/system/member/ModifyPwTemplete.do", {member_id : item.member_id}, options)
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
		dialogService.open("checkPwDialog", "/st_exclude/super/system/member/checkPwTemplete.do", {}, options)
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
		ajaxService.getJSON("<c:url value="/super/member/init_pw.do"/>", item, function(data){
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
		ajaxService.getJSON("<c:url value="/super/member/memberBlockInit.do"/>", {member_id: item.member_id}, function(data){
			alert("계정이 활성화 되었습니다.");
		});
	}

	$(document).on("click", ".hitarea", function(){
		$(this).swapClass("expandable", "expandable-hitarea");
		$(this).siblings("ul").toggle();
	});
	
});

app.controller("SortMemberCtrl", function($scope, $window, $compile, ajaxService, dialogService) {
	$scope.param = $scope.model;

	$scope.scrollOption = {
		width : 300	
	};
	
	$scope.makeTree = function(item){
		var html = "";
		html += "	<li class='expandable' data-group_seq='"+item.group_seq+"' del_yn='"+item.del_yn+"'>";
		html += "		<span><a data-ng-click='selectGroup("+angular.toJson(item)+")'>"+item.group_nm+"</a></span> ";
		html += "	</li>";
		return html;
	}
	
	ajaxService.getJSON('<c:url value="/super/group/list.do"/>', {}, function(data){
		for (var i = 0; i < data.length; i++) {
			var item = data[i];
			var dept = $scope.makeTree(item);

			var sb = ".sort";
			for (var j = 1; j <= item.level; j++) {
				sb += ">ul>li";
			}
			var o = $(sb).last();
			
			if(o.children("ul").size()==0) 
				o.append("<ul>");
			o.children("ul").append($compile(dept)($scope));
		}
		$(".dept_container li[del_yn='Y']").remove();
		$(".dept_container ul").each(function(i,o){
			$(this).children("li:last").addClass("last");
		});
		$(".dept_container ul>li").each(function(i,o){
			if($("li", this).size()>0){
				$(this).prepend('<div class="hitarea expandable"></div>');
			}
		});
		
	});
	
	//회원목록
	$scope.board = {};
	$scope.board.go = function(){
		ajaxService.getJSON('<c:url value="/super/member/list.do?has_child=N&rows=99999&sort_nm=order_seq"/>', $scope.param, function(data){
			$scope.board.list = data.list;
		});
	};
	
	//그룹변경시 리스트 다시 가져오기
	$scope.$watch("param.group_seq", function(newVal, oldVal){
		$(".sort li").removeClass("on");
		$(".sort [data-group_seq="+newVal+"]").addClass("on");
		$scope.board.go();
	});
	
	$scope.selectGroup = function(item){
		$scope.param.group_seq = item.group_seq;
	}
	
	$scope.save = function(){
		if(!confirm("정렬 순서를 변경 하시겠습니까?")){
			return false;
		}
		var user_data = $.map($scope.board.list, function(item, i){
			return {member_id: item.member_id, order_seq : i}; 
		});
		ajaxService.getJSON("<c:url value="/super/member/updateOrder.do"/>", {jData : angular.toJson({list : user_data})}, function(data){
			if(data.rst == '1'){
				listCtrlScope().board.go();
  				$scope.board.go();
  			}
		});
	}
	
	$scope.cancel = function(){
		dialogService.cancel("SortMemberDialog");
	}
	
	$scope.sortableOptions = {
		axis: 'y',
		placeholder: "ui-state-highlight"
	};

});
app.controller("ModifyPwCtrl", function($scope, $window, ajaxService, dialogService) {
	$scope.form = {
			member_id : $scope.model.member_id,
			session_member_id : "${sessionScope.cms_member.member_id }"
		};
	
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
		ajaxService.getJSON('/super/member/modify_pw.do', $scope.form, function(data){
			if(data.rst == "N") {
				alert("기존 비밀번호가 일치하지 않습니다.");
				return false;
			}
			dialogService.close("ModifyPwDialog");
		});
	}
});

app.controller("checkPwCtrl", function($scope, $window, ajaxService, dialogService) {
	$scope.enter = function(){
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

app.controller("moveMemberGroupCtrl", function($scope, $window, ajaxService, dialogService) {

	$scope.form = {
		group_seq : ($scope.model.group_seq.toString()=="0"?"2":$scope.model.group_seq.toString())
	};
	
	$scope.save = function(){
		if($scope.mgFrm.$invalid){
			if($scope.mgFrm.$error.required){
				alert("필수값을 입력하여 주십시오.");
			}else{
				alert("값이 유효하지 않습니다.");
			}
			$("#pFrm .ng-invalid")[0].focus();
			return false;
		}
		if(confirm("선택한 회원들의 부서를 변경하시겠습니까?")){
			var dataset = $.map($scope.model.member_list, function(item){
				return {group_seq : $scope.form.group_seq, member_id : item.member_id}; 
			});
			ajaxService.getJSON("/super/member/updateGroup.do", {jData : angular.toJson({list : dataset})}, function(data){
				if(data.rst == '1'){
					dialogService.close("moveMemberGroupDialog");
	  			}
			});
		}
		
	}
});
app.controller("groupEditCtrl", function($scope, $window, ajaxService, dialogService) {
	$scope.form = {
		staff_list : []
	};
	
	
	if($scope.model.mode == 'ADD'){
		$scope.form = {
			parent_seq : ($scope.model.group_seq||"0"),
			use_yn : 'Y'
		};
	}else{
		ajaxService.getSyncJSON('<c:url value="/super/group/view.do"/>', $scope.model, function(data){
			$scope.form = data.view;
			$scope.form.staff_list = data.staff_list;
		});
		$scope.form.current_manage_seq = $scope.model.manage_seq;
	}
	
	$scope.groupStaff = function(){
		var options = {
				title : '그룹선택',
				autoOpen: false,
				modal: true,
				width: "550",
				height: "auto",
				close: function(event, ui) {
				}
			};
		
		dialogService.open("groupStaffDialog", "/st_exclude/super/system/member/groupStaffTemplete.do", $scope.form, options)
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
			ajaxService.getJSON('<c:url value="/super/group/write.do"/>', {jData : angular.toJson($scope.form)}, function(data){
				dialogService.close("groupEditDialog");
			});
		}else{
			ajaxService.getJSON('<c:url value="/super/group/modify.do"/>', {jData : angular.toJson($scope.form)}, function(data){
				dialogService.close("groupEditDialog");
			});
		}
	}
	if(!!$scope.model.opt){
		if($scope.model.opt=="p"){
			$scope.groupStaff();		
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
		
		dialogService.open("groupSelectDialog", "/st_exclude/super/system/member/groupSelectTemplete.do", $scope.model, options)
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
		ajaxService.getJSON('<c:url value="/super/group/del.do"/>', $scope.data, function(data){
			dialogService.close("groupDelDialog");
		});
	}
	
	$scope.cancel = function(){
		dialogService.cancel("groupDelDialog");
	}
});
app.controller("groupSelectCtrl", function($scope, $window, $compile, ajaxService, dialogService) {

	$scope.scrollOption = {
		width : 300	
	};
	ajaxService.getJSON('<c:url value="/super/group/list.do"/>', {}, function(data){
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
	$scope.form = {
		staff_list : [],
		permission_list : []
	};
	if($scope.model.mode == 'ADD'){
		$scope.form.group_seq = $scope.model.group_seq;
	}else{
		ajaxService.getSyncJSON('<c:url value="/super/member/view.do"/>', $scope.model, function(data){
			$scope.form = data.view;
			$scope.form.staff_list = data.staff_list;
			$scope.form.permission_list = data.permission_list;
			$scope.form.group_seq = Number(data.view.group_seq);
		});
	}
	
	//id 중복 체크
	$scope.$watch("form.member_id", function(newVal, oldVal){
		if(angular.equals(newVal, oldVal)){
			return;
		}
		ajaxService.getJSON('<c:url value="/super/member/id_check.do"/>', {member_id : newVal}, function(data){
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

	$scope.permission_init = function(){
		$scope.form.permission_list = [];
		alert("초기화되었습니다.");
	}
	
	$scope.permission = function(item){
		var options = {
				title : '설정지정',
				autoOpen: false,
				modal: true,
				width: "600",
				height: "auto",
				close: function(event, ui) {
				}
			};
		
		dialogService.open("permissionDialog", "/st_exclude/super/system/member/permissionTemplete.do", item, options)
		.then(
			function(result) {
				$scope.form.permission_list = result;
			},
			function(error) {
			}
		);
	}

	$scope.staff_init = function(){
		$scope.form.staff_list = [];
		alert("초기화되었습니다.");
	}
	
	$scope.staff = function(item){
		var options = {
				title : '담당자지정',
				autoOpen: false,
				modal: true,
				width: "600",
				height: "auto",
				close: function(event, ui) {
				}
			};
		
		dialogService.open("staffDialog", "/st_exclude/super/system/member/staffTemplete.do", item, options)
		.then(
			function(result) {
				$scope.form.staff_list = result;
			},
			function(error) {
			}
		);
	}
	
	$scope.del = function(item){
		if(!confirm("["+item.member_nm + "] 회원을 삭제 하시겠습니까?")){
			return false;
		}
		ajaxService.getJSON("<c:url value="/super/member/del.do"/>", {member_list : item.member_id}, function(data){
			if(data.rst == '1'){
				alert("["+item.member_nm + "] 회원을 삭제 처리되었습니다.");
				dialogService.close("memberEditDialog");
			}else{
				alert(data.msg);
			}
		}, "회원삭제");
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
			ajaxService.getJSON('<c:url value="/super/member/write.do"/>', {jData : angular.toJson($scope.form)}, function(data){
				alert("회원정보를 등록하였습니다.");
				dialogService.close("memberEditDialog");
			}, "회원등록");
		}else{
			if($scope.checkForm() == false) return false;
			if($scope.main.super_pw != null) {
				if(!confirm("수정하시겠습니까?")){
					return false;
				}
				$scope.form.super_pw = $scope.main.super_pw;
				ajaxService.getJSON('<c:url value="/super/member/modify.do"/>', {jData : angular.toJson($scope.form)}, function(data){
					if(data.rst == "Y"){
						alert("수정이 완료되었습니다.");
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
			/* 
			ajaxService.getJSON('<c:url value="/super/member/modify.do"/>', {jData : angular.toJson($scope.form)}, function(data){
				alert("회원정보를 수정하였습니다.");
				dialogService.close("memberEditDialog");
			}, "회원수정");
			 */
		}
	}
	if(!!$scope.model.opt){
		if($scope.model.opt=="p"){
			$scope.staff($scope.form);		
		}else if($scope.model.opt=="a"){
			$scope.permission($scope.form);	
		}
	}
});
app.controller("staffCtrl", function($scope, $window, $compile, ajaxService, dialogService) {
	$scope.form = {
		member_id : $scope.model.member_id,
		staff_list : $.extend([],$scope.model.staff_list)||[],
		select_list : []
	};

	$scope.scrollOption = {
		width : 570
	};
	
	$scope.makeTree = function(item){
		var html = "";
		html += "	<li class='expandable off' menu_seq='"+item.cms_menu_seq+"' menu_title='"+item.title+"' del_yn='"+item.del_yn+"' use_yn='"+item.use_yn+"'>";
		html += "		<span class='off'><a data-ng-click='selectMenu("+angular.toJson(item)+")'>"+item.title+"</a></span> ";
		html += "	</li>";
		return html;
	}
	
	$scope.selectMenu = function(item){
		$(".staffDiv li[menu_seq='"+item.cms_menu_seq+"']").swapClass("on", "off");
		$(".staffDiv li[menu_seq='"+item.cms_menu_seq+"']").children("span").swapClass("on", "off");
		
		if($(".staffDiv li[menu_seq='"+item.cms_menu_seq+"'].off").size() > 0){
			$.each($scope.form.staff_list, function(i, o){
				if(item.cms_menu_seq == o.cms_menu_seq){
					$scope.form.staff_list.splice(i, 1);
					return false;
				}
			});
		}else{
			$scope.form.staff_list.push({cms_menu_seq : item.cms_menu_seq, member_id : $scope.form.member_id});
		}
		
		$scope.select_list_div();
	}
	
	ajaxService.getJSON('<c:url value="/super/member/staff.do"/>', $scope.model, function(data){
		$scope.site_list = data.site_list;
		$scope.form.site_id = $scope.site_list[0].cms_menu_seq;
		$scope.changeSite();
	});
	
	$scope.changeSite = function(){
		ajaxService.getJSON('<c:url value="/super/homepage/left_list.do"/>', {site_id : $scope.form.site_id}, function(data){
			$(".staffDiv>ul>li>ul>li").remove();
			for (var i = 0; i < data.length; i++) {
				var item = data[i];
				var dept = $scope.makeTree(item);

				var sb = ".staffDiv";
				for (var j = 1; j <= item.menu_level; j++) {
					sb += ">ul>li";
				}
				var o = $(sb).last();
				
				if(o.children("ul").size()==0) 
					o.append("<ul>");
				o.children("ul").append($compile(dept)($scope));
			}
			$(".staffDiv li[del_yn='Y']").remove();
			$(".staffDiv li[use_yn='N']").remove();
			$(".staffDiv ul").each(function(i,o){
				$(this).children("li:last").addClass("last");
			});
			$(".staffDiv ul>li").each(function(i,o){
				if($("li", this).size()>0){
					$(this).prepend('<div class="hitarea expandable"></div>');
				}
			});
			
			$.each($scope.form.staff_list, function(i, o){
				$(".staffDiv li[menu_seq='"+o.cms_menu_seq+"']").swapClass("on", "off");
				$(".staffDiv li[menu_seq='"+o.cms_menu_seq+"']").children("span").swapClass("on", "off");
				$scope.select_list_div();
			})
			/*-----------
			ajaxService.getJSON('<c:url value="/super/member/staff_list.do"/>', {site_id : $scope.form.site_id, member_id : $scope.form.member_id}, function(data){
				$scope.staff_list = data.list;
				$.each($scope.staff_list, function(i, o){
					$(".staffDiv li[menu_seq='"+o.cms_menu_seq+"']").swapClass("on", "off");
					$(".staffDiv li[menu_seq='"+o.cms_menu_seq+"']").children("span").swapClass("on", "off");
					$scope.select_list_div();
				})
			});
			*/
		});
	}
	$scope.select_list_div = function(){
		$scope.form.select_list = [];
		$(".staffDiv li.on").each(function(i, o){
			$scope.form.select_list.push({cms_menu_seq : $(this).attr("menu_seq"), title:$(this).attr("menu_title")});
		})
	}
	
	$scope.save = function(){
		dialogService.close("staffDialog", $scope.form.staff_list);
		/*
		var add_list = [];
		var remove_list = [];
		$.each($(".staffDiv li.on"), function(i, o){
			var a = Number($(this).attr("menu_seq"));
			if($.inArray(a, $.map($scope.staff_list, function(item){return item.cms_menu_seq} )) < 0){
				add_list.push({
					member_id : $scope.model.member_id, 
					member_nm : $scope.model.member_nm, 
					group_seq : $scope.model.group_seq, 
					group_nm : $scope.model.group_nm, 
					cms_menu_seq: a, 
				});
			}
		});
		
		$.each($(".staffDiv li.off"), function(i, o){
			var a = Number($(this).attr("menu_seq"));
			if($.inArray(a, $.map($scope.staff_list, function(item){return item.cms_menu_seq} )) > -1){
				remove_list.push({
					member_id : $scope.model.member_id, 
					cms_menu_seq: a, 
				});
			}
		});
		
		ajaxService.getJSON("<c:url value="/super/member/updateStaff.do"/>", {jData : angular.toJson({add_list : add_list, remove_list : remove_list})}, function(data){
			if(data.rst == '1'){
  				alert("정상 반영되었습니다.");
  			}
		});*/
	}
});
app.controller("memberPermitCtrl", function($scope, $window, $compile, ajaxService, dialogService) {
	$scope.form = {
		member_id : $scope.model.member_id,
		list : [],
		select_list : []
	};

	$scope.scrollOption = {
		width : 820
	};
	
	$scope.depthStyle = function(o){
		var rst = {'padding-left': (o.menu_level*15)+"px"};
		if(o.menu_level==1){
			rst["font-weight"] = "bold";
		}
		return rst;
	}
	
	$scope.all_chk = function(tp, yn){
		var item = "";
		if(tp == "1"){
			item = "add_yn";
		}else if(tp == "2"){
			item = "mod_yn";
		}else if(tp == "3"){
			item = "view_yn";
		}
		$.each($scope.form.list, function(i, o){
			o[item] = (yn?"Y":"N");
		});
	}
	
	ajaxService.getJSON('<c:url value="/super/member/site_list.do"/>', $scope.model, function(data){
		$scope.site_list = data.site_list;
		$scope.form.site_id = $scope.site_list[0].cms_menu_seq;
		$scope.changeSite();
	});
	
	$scope.changeSite = function(){
		ajaxService.getJSON("<c:url value="/super/member/memberPermitList.do"/>", {site_id : $scope.form.site_id,member_id : $scope.model.member_id}, function(data){
			$scope.form.list = data.list;
			$scope.form.md = data.md;
		});
	}
	
	$scope.save = function(){
		if(!confirm("저장하시겠습니까?")){
			return false;
		}
		ajaxService.getJSON("<c:url value="/super/member/updateMemberPermission.do"/>", {jData : angular.toJson($scope.form)}, function(data){
			if(data.rst == '1'){
  				alert("정상 반영되었습니다.");
  			}
		});
	}
});
app.controller("permissionCtrl", function($scope, $window, $compile, ajaxService, dialogService) {
	$scope.form = {
		member_id : $scope.model.member_id,
		permission_list : $.extend([],$scope.model.permission_list)||[],
		select_list : []
	};

	$scope.scrollOption = {
		width : 570
	};
	
	$scope.makeTree = function(item){
		var html = "";
		html += "	<li class='expandable off' menu_seq='"+item.cms_menu_seq+"' menu_title='"+item.title+"' del_yn='"+item.del_yn+"' use_yn='"+item.use_yn+"'>";
		html += "		<span class='off'><a data-ng-click='selectMenu("+angular.toJson(item)+")'>"+item.title+"</a></span> ";
		html += "	</li>";
		return html;
	}
	
	$scope.selectMenu = function(item){
		$(".permitDiv li[menu_seq='"+item.cms_menu_seq+"']").swapClass("on", "off");
		$(".permitDiv li[menu_seq='"+item.cms_menu_seq+"']").children("span").swapClass("on", "off");
		
		if($(".permitDiv li[menu_seq='"+item.cms_menu_seq+"'].off").size() > 0){
			$.each($scope.form.permission_list, function(i, o){
				if(item.cms_menu_seq == o.cms_menu_seq){
					$scope.form.permission_list.splice(i, 1);
					return false;
				}
			});
		}else{
			$scope.form.permission_list.push({cms_menu_seq : item.cms_menu_seq, member_id : $scope.form.member_id});
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
			
			$.each($scope.form.permission_list, function(i, o){
				$(".permitDiv li[menu_seq='"+o.cms_menu_seq+"']").swapClass("on", "off");
				$(".permitDiv li[menu_seq='"+o.cms_menu_seq+"']").children("span").swapClass("on", "off");
				$scope.select_list_div();
			})
			/*--------
			ajaxService.getJSON('<c:url value="/super/member/permission_list.do"/>', {site_id : $scope.form.site_id, member_id : $scope.form.member_id}, function(data){
				$scope.permission_list = data.list;
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
		dialogService.close("permissionDialog", $scope.form.permission_list);
		/*
		var add_list = [];
		var remove_list = [];
		$.each($(".permitDiv li.on"), function(i, o){
			var a = Number($(this).attr("menu_seq"));
			if($.inArray(a, $.map($scope.permission_list, function(item){return item.cms_menu_seq} )) < 0){
				add_list.push({
					member_id : $scope.model.member_id, 
					member_nm : $scope.model.member_nm, 
					group_seq : $scope.model.group_seq, 
					group_nm : $scope.model.group_nm, 
					cms_menu_seq: a, 
				});
			}
		});
		
		$.each($(".permitDiv li.off"), function(i, o){
			var a = Number($(this).attr("menu_seq"));
			if($.inArray(a, $.map($scope.permission_list, function(item){return item.cms_menu_seq} )) > -1){
				remove_list.push({
					member_id : $scope.model.member_id, 
					cms_menu_seq: a, 
				});
			}
		});
		
		ajaxService.getJSON("<c:url value="/super/member/updatePermission.do"/>", {jData : angular.toJson({add_list : add_list, remove_list : remove_list})}, function(data){
			if(data.rst == '1'){
  				alert("정상 반영되었습니다.");
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
		var promise = ajaxService.getJSON('<c:url value="/super/member/memberHistory.do"/>', $scope.param, function(data){
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

app.controller("groupStaffCtrl", function($scope, $window, $compile, ajaxService, dialogService) {
	$scope.form = {
		group_seq : $scope.model.group_seq,
		group_nm : $scope.model.group_nm,
		staff_list : $.extend([],$scope.model.staff_list)||[],
		select_list : []
	};

	$scope.scrollOption = {
		width : 500
	};
	
	$scope.makeTree = function(item){
		var html = "";
		html += "	<li class='expandable off' menu_seq='"+item.cms_menu_seq+"' menu_title='"+item.title+"' del_yn='"+item.del_yn+"' use_yn='"+item.use_yn+"'>";
		html += "		<span class='off'><a data-ng-click='selectMenu("+JSON.stringify(item)+")'>"+item.title+"</a></span> ";
		html += "	</li>";
		return html;
	}
	
	$scope.selectMenu = function(item){
		$(".staffDiv li[menu_seq='"+item.cms_menu_seq+"']").swapClass("on", "off");
		$(".staffDiv li[menu_seq='"+item.cms_menu_seq+"']").children("span").swapClass("on", "off");
		
		if($(".staffDiv li[menu_seq='"+item.cms_menu_seq+"'].off").size() > 0){
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
			$(".staffDiv>ul>li>ul>li").remove();
			for (var i = 0; i < data.length; i++) {
				var item = data[i];
				var dept = $scope.makeTree(item);

				var sb = ".staffDiv";
				for (var j = 1; j <= item.menu_level; j++) {
					sb += ">ul>li";
				}
				var o = $(sb).last();
				
				if(o.children("ul").size()==0) 
					o.append("<ul>");
				o.children("ul").append($compile(dept)($scope));
			}
			$(".staffDiv li[del_yn='Y']").remove();
			$(".staffDiv li[use_yn='N']").remove();
			$(".staffDiv ul").each(function(i,o){
				$(this).children("li:last").addClass("last");
			});
			$(".staffDiv ul>li").each(function(i,o){
				if($("li", this).size()>0){
					$(this).prepend('<div class="hitarea expandable"></div>');
				}
			});
			
			$.each($scope.form.staff_list, function(i, o){
				$(".staffDiv li[menu_seq='"+o.cms_menu_seq+"']").swapClass("on", "off");
				$(".staffDiv li[menu_seq='"+o.cms_menu_seq+"']").children("span").swapClass("on", "off");
				$scope.select_list_div();
			})

			/*-----------
			ajaxService.getJSON('<c:url value="/super/group/staffList.do"/>', {site_id:$scope.form.site_id, group_seq : $scope.form.group_seq}, function(data){
				$scope.permission_list = data;
				$.each($scope.permission_list, function(i, o){
					$(".staffDiv li[menu_seq='"+o.cms_menu_seq+"']").swapClass("on", "off");
					$(".staffDiv li[menu_seq='"+o.cms_menu_seq+"']").children("span").swapClass("on", "off");
					$scope.select_list_div();
				})
			});
			*/
		});
	}
	$scope.select_list_div = function(){
		$scope.form.select_list = [];
		$(".staffDiv li.on").each(function(i, o){
			$scope.form.select_list.push({cms_menu_seq : $(this).attr("menu_seq"), title:$(this).attr("menu_title")});
		})
	}
	
	$scope.save = function(){
		dialogService.close("groupStaffDialog", $scope.form.staff_list);
		/* if(!confirm("저장하시겠습니까?")){
			return false;
		}
		var p = {jData : JSON.stringify({site_id:$scope.form.site_id, group_seq : $scope.form.group_seq, group_nm : $scope.form.group_nm, list : $scope.form.select_list})};
		ajaxService.getJSON('<c:url value="/super/group/updateGroupStaff.do"/>', p, function(data){
			if(data.rst=="1"){
				alert("저장되었습니다.");
			}
		}); */
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
	if(item.group_seq == "3"){
		html += "		<span class='tree_util'><a class='tree_add' data-ng-click='openGroupAdd("+angular.toJson(item)+")' title='추가'>추가</a></span>";
	}else if(item.group_seq != "1" && item.group_seq != "2"){
		html += "		<span class='tree_util'><a class='tree_mod' data-ng-click='openGroupMod("+angular.toJson(item)+")' title='편집'>편집</a><a class='tree_del' data-ng-click='openGroupDel("+angular.toJson(item)+")' title='삭제'>삭제</a><a class='tree_add' data-ng-click='openGroupAdd("+angular.toJson(item)+")' title='추가'>추가</a></span>";
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
		<h2>관리자 회원 관리</h2>
		<div>
			<span>시스템 관리</span>&gt;<span>회원관리</span>&gt;
			<span class="bar_tx">관리자 회원 관리</span>
		</div>
	</div>
	<div id="mainDiv" class="contents_wrap" data-ng-controller="mainCtrl" data-ng-init="group_list()" data-ng-cloak>
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