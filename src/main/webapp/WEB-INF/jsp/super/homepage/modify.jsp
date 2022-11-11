<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<c:set var="site_id" value="${empty cookie.adh_menu_current_siteid ? '1' : cookie.adh_menu_current_siteid.value }"/>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.nav {
    max-height: 250px;
}
.mCSB_outside+.mCSB_scrollTools {right: -15px;}
.mCustomScrollBox+.mCSB_scrollTools+.mCSB_scrollTools.mCSB_scrollTools_horizontal{bottom: -15px;}
.ui-state-highlight{ width:60px; height:12px; background:none !important; border:dotted 2px #658ed7;}

.chk_list{margin-top:390px;}
.chk_list div{padding:10px; border: 1px solid #d9d9d9; height:120px; overflow: auto; background:#dadee5;}
.chk_list div span{display:inline-block; padding:3px 5px; margin:0 5px 5px 0; color:#fff !important; background:#658ed7; border-radius:3px;}

</style>
<title>홈페이지 메뉴관리</title>
<script type="text/javascript" src="${context_path }/lib/js/angular.min.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/angular-route.min.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/filters/myFilter.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/filters/ngRange.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/services/myCommon.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/services/dialog-service.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/directives/myUtil.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/directives/myPagination.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/directives/sortable.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/directives/myEditor.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/html2canvas.js"></script>

<script type="text/javascript">
var contextPath = "<c:url value='/'/>".replace(/\/$/, "");
</script>
<script type="text/javascript">
$(document).on("click", ".hitarea", function(){
	$(this).swapClass("expandable", "expandable-hitarea");
	$(this).siblings("ul").toggle();
});

var app=angular.module("MyApp", ['dialogService', 'ngRoute', 'myUtil', 'myPagination', 'myCommon', 'ui.sortable', 'myFilter', 'myEditor', 'ngRange']);
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
app.run(function($rootScope, $timeout){
	$rootScope.param={
		cms_menu_seq : "${param.cms_menu_seq}",
		parent_menu_seq : "${param.parent_menu_seq}",
		menu_level : "${param.menu_level}",
	};
});
app.controller("modifyCtrl", function($scope, $window, $compile, ajaxService, dialogService, $filter, $timeout, $rootScope) {
	
	$scope.form = {
		libs : []
	};
	
	ajaxService.getJSON("${context_path }/super/homepage/view.do", $scope.param, function(data){
		$scope.form = data.view;
		if (!$scope.form.inner_yn) {
			$scope.form.inner_yn = "N";
		}
		$scope.form.site_id = "${site_id}";
		$scope.form.menu_level = $scope.param.menu_level;
		$scope.form.staffs = data.staffs;
		$rootScope.staffs = $scope.form.staffs;
		$scope.form.staff_group = data.staff_group;
		$rootScope.groups = $scope.form.staff_group;
		$scope.form.permissions = data.permissions;
		$rootScope.permissions = $scope.form.permissions;
		$scope.form.libs = data.libs;
		/* $scope.form.groups1 = (function(list){
			var rst = [];
			if(!!list){
				var list = list.split(",");
				for (var i = 0; i < list.length; i++) {
					var item = list[i].split(":");
					rst.push({group_seq : item[0], group_nm:item[1]});
				}
			}
			return rst;
		})(data.view.r_group_seq);
		$scope.form.groups2 = (function(list){
			var rst = [];
			if(!!list){
				var list = list.split(",");
				for (var i = 0; i < list.length; i++) {
					var item = list[i].split(":");
					rst.push({group_seq : item[0], group_nm:item[1]});
				}
			}
			return rst;
		})(data.view.cud_group_seq); */
		$scope.form.menu_type_org = $scope.form.menu_type;
		
		ajaxService.getJSON("${context_path }/json/request/Menu.view.do", {cms_menu_seq : $scope.param.parent_menu_seq}, function(data){
			if(!!data){
				$scope.form.parent_child_type = data.child_type;
			}
		});
		if(!$.inStringArray($scope.form.menu_url, ["/member/","/search.do","/super/"]) && !$.inStringArray($scope.form.menu_type, ["4", "5"])){
			$scope.currentPageView();
		}
	});

	//화면 캡쳐 보기
	$scope.currentPageView = function(){
		$("#previewFrame").prop("src", "${context_path }"+$scope.form.menu_url+"#currentview").load(function(){
		 	html2canvas($("#previewFrame").contents().find("body"), {onrendered : function(canvas){
		 		var org_w = $("#previewDiv").width();
		 		var org_h = ((canvas.width-(canvas.width-org_w))*canvas.height)/canvas.width
		 		var after_w = 150;
		 		var after_h = ((org_w-(org_w-after_w))*org_h)/org_w;
		 		$(canvas).toggle(function(){		 			
		 			$(canvas).css({width : after_w, height: after_h, background: 'url("${context_path }/images/super/icon_circle_plus.png") 50% 50% no-repeat'});
		 		}, function(){
		 			$(canvas).css({width : org_w, height: org_h, background: 'url("${context_path }/images/super/icon_circle_minus.png") 50% 50% no-repeat'});
		 		}).trigger("click");
				$("#previewDiv").html(canvas)
			}});
		});
	}
	
	$scope.tab = function(n){
		if(n == '1'){
			alert("1뎁스는 탭메뉴로 구성할 수 없습니다.");
			$scope.form.child_type = 1;
			return false;
		}
	}
	
	$scope.save = function(){
		/* //열람권한
		$scope.form.r_group_seq = (function(list){
			var rst = [];
			for (var i = 0; i < list.length; i++) {
				var item = list[i];
				rst.push(item.group_seq+":"+item.group_nm);
			}
			return rst.join(",");
		})($scope.form.groups1);
		//등록삭제권한
		$scope.form.cud_group_seq = (function(list){
			var rst = [];
			for (var i = 0; i < list.length; i++) {
				var item = list[i];
				rst.push(item.group_seq+":"+item.group_nm);
			}
			return rst.join(",");
		})($scope.form.groups2); */
		if (!($scope.form.title || ($scope.form.title === ""))) {
			alert("메뉴명을 입력해주세요.");
			$("#title").focus();
			return false;
		}
		if (/<script>|<\/script>|<|>|&lt;script&gt;|&lt;\/script&gt;|&lt;|&gt;/.test($scope.form.title)) {
			alert("메뉴명에 등록할 수 없는 태그가 포함되어 있습니다.");
			$("#title").focus();
			return false;
		}
		if (($scope.form.menu_type === "2") && (!$scope.form.b_program_nm || $scope.form.b_program_nm === "")) {
			alert("게시판을 선택해주세요.");
			return false;
		}
		if (($scope.form.menu_type === "3") && ((!$scope.form.program_nm || $scope.form.program_nm === "") || (!$scope.form.target_url || $scope.form.target_url === ""))) {
			alert("프로그램을 선택해주세요.");
			return false;
		}
		if (($scope.form.menu_type === "3" && $scope.form.inner_yn === "Y") &&  (!$scope.form.manage_url || $scope.form.manage_url === "")) {
			alert("프로그램 관리URL을 입력해주세요.");
			$("#manage_url").focus();
			return false;
		}
		if (($scope.form.menu_type === "4") && (!$scope.form.target_url || $scope.form.target_url === "")) {
			alert("링크 주소를 입력해주세요.");
			$("#target_url").focus();
			return false;
		}
		if (($scope.form.menu_type === "4") && (/<script>|<\/script>|<|>|&lt;script&gt;|&lt;\/script&gt;|&lt;|&gt;/.test($scope.form.target_url))) {
			alert("링크 주소에 등록할 수 없는 태그가 포함되어 있습니다.");
			$("#target_url").focus()
			return false;
		}
		if(!confirm('설정내용을 저장하시겠습니까?')){
			return false;
		}
		ajaxService.getJSON("${context_path }/super/homepage/modify.do", {jData : angular.toJson($scope.form)}, function(data){
			alert("저장이 완료되었습니다.");
			location.reload();
		});
	}
	$scope.del = function(){
		if(!confirm("정말 삭제 하시겠습니까?")){
			return false;
		}
		ajaxService.getJSON("${context_path }/super/homepage/del.do", $scope.param, function(data){
			if(data.rst == '1'){
				alert("정상 처리되었습니다.");
				location.href="modifyFrm.do?cms_menu_seq="+$scope.param.parent_menu_seq;
			}else{
				alert(data.msg);
			}
		});
	}
	
	$scope.onBoardPop = function(){
		var options = {
			autoOpen: false,
			modal: true,
			width: "750",
			height: "730",
			close: function(event, ui) {}
		};
			
		dialogService.open("adminBoardSelect","adminBoardSelect.html", {}, options).then(
			function(result) {
				$scope.form.b_program_nm = result.board_nm;
				$scope.form.board_seq = result.board_seq;
				$scope.form.board_type = result.board_type;
			},
			function(error) {}
		);
	}
	
	//프로그램 선택
	$scope.onProgramPop = function(){
		var options = {
			autoOpen: false,
			modal: true,
			width: "750",
			height: "730",
			close: function(event, ui) {}
		};
			
		dialogService.open("adminBoardSelect","${context_path }/lib/js/partials/adminProgramSelect.jsp", {}, options).then(
			function(result) {
				$scope.form.program_nm = result.program_nm;
				$scope.form.target_url = result.url;
				$scope.form.manage_url = result.manage_url;
			},
			function(error) {}
		);
	}
	
	//페이지 담당자 선택
	$scope.openStaffsSelect = function(){
		var options = {
				title : '담당자 선택',
				autoOpen: false,
				modal: true,
				width: "900",
				height: "825",
				close: function(event, ui) {
				}
			};
		
		dialogService.open("staffsSelectDialog", "staffsSelectTemplate.html", {staffs : $scope.form.staffs}, options)
		.then(
			function(result) {
				$scope.form.staffs = result;
			},
			function(error) {
			}
		);
	};

	//페이지 권한 선택
	$scope.openPermissionsSelect = function(){
		var options = {
			title : '권한 선택',
			autoOpen: false,
			modal: true,
			width: "900",
			height: "825",
			close: function(event, ui) {
			}
		};

		dialogService.open("permissionsSelectDialog", "permissionsSelectTemplate.html", {permissions : $scope.form.permissions}, options)
		.then(
			function(result) {
				$scope.form.permissions = result;
			},
			function(error) {
			}
		);
	};
	
	$scope.removeStaff = function(idx){
		$scope.form.staffs.splice(idx, 1);
	};

	$scope.removePermission = function(idx){
		$scope.form.permissions.splice(idx, 1);
	};
	
	$scope.staffSortable = {
// 		axis: 'x',
		placeholder: "ui-state-highlight"
	};
	
	$scope.addStaffGroup = function(item){
   		var list = $.map($scope.form.staff_group, function(item){
   				return item.group_seq; 
   			});
   		if($.inArray(item.group_seq, list) < 0){
   			$scope.form.staff_group.push({group_seq : item.group_seq, group_nm : item.group_nm});
   		}
	}
	
	$scope.removeStaffGroup = function(idx){
		$scope.form.staff_group.splice(idx, 1);
	}
	
	//관리그룹 선택
	$scope.openGroupSelect = function(tp){
		var options = {
				title : '그룹선택',
				autoOpen: false,
				modal: true,
				width: "450",
				height: "450",
				close: function(event, ui) {
				}
			};
		
		dialogService.open("groupSelectDialog", "groupSelectTemplete.html", {type : tp}, options)
		.then(
			function(result) {
				if(tp == '3'){
					$scope.addStaffGroup(result);
				}else{
					$scope.addGroup(tp, result);
				}
			},
			function(error) {
			}
		);
	}
	
	$scope.addGroup = function(tp, item){
   		var list = $.map($scope.form["groups"+tp], function(item){
   				return item.group_seq; 
   			});
   		if($.inArray(item.group_seq, list) < 0){
   			$scope.form["groups"+tp].push({group_seq : item.group_seq, group_nm : item.group_nm});
   		}
	}
	
	$scope.removeGroup = function(tp, idx){
		$scope.form["groups"+tp].splice(idx, 1);
	}
	
	$scope.openJsCssDialog = function(){
		var options = {
				title : '파일선택',
				autoOpen: false,
				modal: true,
				width: "450",
				height: "450"
			};
		
		dialogService.open("jsCssDialog", "jsCssTemplete.html", {}, options)
		.then(
			function(result) {
				if(result.tp == 'F'){//파일
					result.org_file_name = result.attach_nm;
					result.sys_file_name = result.uuid;
	    			$scope.addLib(result);
				}else{
					var regex = /(\w+\.\w+)(?=\?|$)/;
					result.org_file_name = result.full_path.match(regex)[0];
					$scope.addLib(result);
				}
			},
			function(error) {
			}
		);
	}
	
	//JavaScript/CSS 선택	
	$scope.libsSortable = {
// 		axis: 'x',
		placeholder: "ui-state-highlight"
	};
	
	$scope.addLib = function(data){
		$scope.form.libs.push(data);
	}
	
	$scope.removeLib = function(idx){
		$scope.form.libs.splice(idx, 1);
	}
	
	$scope.$on("backupLoad", function(o, item){
		$.extend($scope.form, angular.copy(item));
	});
	
	$scope.validUrl = function(url){
		url = url.replace(/\?/g, "&");
		url = url.replace("&", "?");
		return contextPath+url;
	}
});
//페이지 담당자 선택 컨트롤
app.controller("staffsSelectCtrl", function($scope, $window, $compile, ajaxService, dialogService, $rootScope) {
	$scope.param = {
		cms_menu_seq: $rootScope.param.cms_menu_seq
	};
	$scope.staffs = $.extend([], $scope.model.staffs);
	
	$scope.scrollOption = {
		width : 250	
	};
	$scope.group_list = {};
	
	$scope.makeTree = function(item){
		var check = false;
		var group_list = $.grep($scope.staffs, function(o ,i){
			return o.group_seq == item.group_seq;
		});
		var cnt = group_list.length;
		var html = "";
		html += "	<li class='expandable' data-group_seq='"+item.group_seq+"' del_yn='"+item.del_yn+"'>";
		html += "		<span><a data-ng-click='selectGroup("+angular.toJson(item)+")'";
		if (cnt > 0) {
			html += "style='text-decoration: underline !important; font-weight: bold !important'>" +item.group_nm + "(" + cnt + "명)</a></span> ";
		} else {
			html += ">" + item.group_nm + "</a></span> ";	
		}
		html += "	</li>";
		return html;
	}

	$scope.param.exceptAdmin = "Y";
	ajaxService.getJSON('${context_path }/super/group/list.do', $scope.param, function(data){
		$scope.group_list = data;
		for (var i = 0; i < data.length; i++) {
			var item = data[i];
			var dept = $scope.makeTree(item);

			var sb = ".dept_container";
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
	/* 
	$(document).on("click", ".hitarea", function(){
		$(this).swapClass("expandable", "expandable-hitarea");
		$(this).siblings("ul").toggle();
	});
	 */
	//회원목록
	$scope.board = {};
	$scope.board.go = function(n){
		$scope.param.cms_menu_seq = $rootScope.param.cms_menu_seq;
		$scope.param.cpage=n;
		
		ajaxService.getSyncJSON('${context_path }/super/member/list.do', $scope.param, function(data){
			
			$scope.board.list = data.list;
			
			var list = $.map($scope.staffs, function(o){
				return o.member_id; 
			});
			
			$.each($scope.board.list, function (idx, obj) {
				if($.inArray(obj.member_id, list) > -1){
					$scope.board.list[idx].chk = true;
		   		}
			});
			
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.pagination.totalcount;
			$scope.board.totalPage = data.pagination.totalpage;
		});
	};
	$scope.board.go(1);
	
	$scope.myFunct = function(keyEvent) {
		if (keyEvent.which === 13) {
			$scope.board.go(1);
		}
	};
	
	//부서변경시 리스트 다시 가져오기
	$scope.$watch("param.group_seq", function(newVal, oldVal){
		if(!newVal || (newVal==oldVal)) return false;
		$(".dept_container li").removeClass("on");
		$(".dept_container [data-group_seq="+newVal+"]").addClass("on");
		$scope.board.go(1);
	});
	
	$scope.selectGroup = function(item){
		$scope.param.group_seq = item.group_seq;
	}
	
	
	// 담당자 추가/삭제
	$scope.clickMember = function (item) {
		var memberId = item.member_id;
		if(item.chk) {
			$scope.staffs.push({
				group_seq : item.group_seq,
				group_nm : item.group_nm, 
				member_id : item.member_id, 
				member_nm : item.member_nm
			});
		} else {
			$.each($scope.staffs, function(idx, o){
				if(o.member_id==memberId){
					$scope.staffs.splice(idx, 1);
					return false;
				}
			});
		}
	};
	$scope.selecterMember = function(){
		dialogService.close("staffsSelectDialog", $scope.staffs);
	}
	$scope.cancel = function(){
		dialogService.cancel("staffsSelectDialog");
	}
});

//페이지 권한 선택 컨트롤
app.controller("permissionsSelectCtrl", function($scope, $window, $compile, ajaxService, dialogService, $rootScope) {
	$scope.param = {
		cms_menu_seq: $rootScope.param.cms_menu_seq
	};
	$scope.permissions = $.extend([], $scope.model.permissions);

	$scope.scrollOption = {
		width : 250
	};
	$scope.group_list = {};

	$scope.makeTree = function(item){
		var group_list = $.grep($scope.permissions, function(o ,i){
			return o.group_seq == item.group_seq;
		});
		var cnt = group_list.length;
		var html = "";
		html += "	<li class='expandable' data-group_seq='"+item.group_seq+"' del_yn='"+item.del_yn+"'>";
		html += "		<span><a data-ng-click='selectGroup("+angular.toJson(item)+")'";
		if (cnt > 0) {
			html += "style='text-decoration: underline !important; font-weight: bold !important'>" +item.group_nm + "(" + cnt + "명)</a></span> ";
		} else {
			html += ">" + item.group_nm + "</a></span> ";
		}
		html += "	</li>";
		return html;
	}

	$scope.param.exceptAdmin = "Y";
	ajaxService.getJSON('${context_path }/super/group/list.do', $scope.param, function(data){
		$scope.group_list = data;
		for (var i = 0; i < data.length; i++) {
			var item = data[i];
			var dept = $scope.makeTree(item);

			var sb = ".dept_container";
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
/* 
	$(document).on("click", ".hitarea", function(){
		$(this).swapClass("expandable", "expandable-hitarea");
		$(this).siblings("ul").toggle();
	});
 */
	//회원목록
	$scope.board = {};
	$scope.board.go = function(n){
		$scope.param.cms_menu_seq = $rootScope.param.cms_menu_seq;
		$scope.param.cpage=n;

		ajaxService.getSyncJSON('${context_path }/super/member/list.do', $scope.param, function(data){

			$scope.board.list = data.list;

			var list = $.map($scope.permissions, function(o){
				return o.member_id;
			});

			$.each($scope.board.list, function (idx, obj) {
				if($.inArray(obj.member_id, list) > -1){
					$scope.board.list[idx].chk = true;
				}
			});

			$scope.board.currentPage = n;
			$scope.board.totalCount = data.pagination.totalcount;
			$scope.board.totalPage = data.pagination.totalpage;
		});
	};
	$scope.board.go(1);

	$scope.myFunct = function(keyEvent) {
		if (keyEvent.which === 13) {
			$scope.board.go(1);
		}
	};

	//부서변경시 리스트 다시 가져오기
	$scope.$watch("param.group_seq", function(newVal, oldVal){
		if(!newVal || (newVal==oldVal)) return false;
		$(".dept_container li").removeClass("on");
		$(".dept_container [data-group_seq="+newVal+"]").addClass("on");
		$scope.board.go(1);
	});

	$scope.selectGroup = function(item){
		$scope.param.group_seq = item.group_seq;
	}


	// 담당자 추가/삭제
	$scope.clickMember = function (item) {
		var memberId = item.member_id;
		if(item.chk) {
			$scope.permissions.push({
				group_seq : item.group_seq,
				group_nm : item.group_nm,
				member_id : item.member_id,
				member_nm : item.member_nm
			});
		} else {
			$.each($scope.permissions, function(idx, o){
				if(o.member_id==memberId){
					$scope.permissions.splice(idx, 1);
					return false;
				}
			});
		}
	};
	$scope.selecterMember = function(){
		dialogService.close("permissionsSelectDialog", $scope.permissions);
	}
	$scope.cancel = function(){
		dialogService.cancel("permissionsSelectDialog");
	}
});

//관리그룹 선택 컨트롤
app.controller("groupSelectCtrl", function($scope, $window, $compile, ajaxService, dialogService, $rootScope) {
	$scope.param = {};
	
	$scope.scrollOption = {
		width : 400	
	};
		
	$scope.group = {};
	
	
	$scope.makeTree = function(item){
		var html = "";
		html += "	<li class='expandable' data-group_seq='"+item.group_seq+"'>";
		html += "		<span><a data-ng-click='selectGroup("+angular.toJson(item)+")'"
		var cntFlag = false;
		$.each($rootScope.groups, function (idx, obj) {
			if (obj.group_seq == item.group_seq) {
				cntFlag = true;
			}
		});
		if (cntFlag) {
			html += "style='text-decoration: underline !important; font-weight: bold !important'>" + item.group_nm + "</a></span> ";
		} else {
			html += ">" + item.group_nm + "</a></span> ";
		}
		html += "	</li>";
		return html;
	};
	
	$scope.myFunct = function(keyEvent) {
		if (keyEvent.which === 13) {
			$scope.group.go(1);
		}
	};
	
	$scope.group.go = function(n){
		 $scope.param.cms_menu_seq = $rootScope.cms_menu_seq;
		 $scope.param.exceptAdmin = "Y";
		 ajaxService.getJSON('${context_path }/super/group/list.do', $scope.param, function(data){
			if($scope.model.type != '3'){
				data.unshift({group_seq:'0', group_nm:'비회원', parent_seq:'0', use_yn:'Y',order_seq:'0', reg_dt:'', level:'1'});
				data.unshift({group_seq:'-1', group_nm:'실명인증', parent_seq:'0', use_yn:'Y',order_seq:'0', reg_dt:'', level:'1'});
			}
			
			$(".dept_container li>ul").remove();
			
			for (var i = 0; i < data.length; i++) {
				var item = data[i];
				var dept = $scope.makeTree(item);
	
				var sb = ".dept_container";
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
	};
	/*
	$(document).on("click", ".hitarea", function(){
		$(this).swapClass("expandable", "expandable-hitarea");
		$(this).siblings("ul").toggle();
	});
	*/
	$scope.selectGroup = function(item){
		dialogService.close("groupSelectDialog", item);
	}
	
	$scope.cancel = function(){
		dialogService.cancel("groupSelectDialog");
	}
});

app.controller("programCtrl", function($scope, $window, $routeParams, $compile, ajaxService, dialogService, $filter) {
	
	ajaxService.getJSON('${context_path }/json/list/Program.list.do', {rows:9999}, function(data){
		$scope.programs = data;
	});
	
	$scope.programSelect = function(item){
		dialogService.close("adminBoardSelect", item);		
	}
});
app.controller("boardSelectCtrl", function($scope, $window, $routeParams, $compile, ajaxService, dialogService, $filter) {
	$scope.boardType = {};
	ajaxService.getJSON('${context_path }/super/system/board/type_list.do', {}, function(data){
		$scope.boardType = data;
	});
	
	$scope.board = {
		param : {
			cpage : 1,
			use_yn : 'Y'
		}		
	};
	$scope.board.go = function(n){
		$scope.board.param.cpage=n;
		ajaxService.getJSON('${context_path }/super/system/board/list.do', $scope.board.param, function(data){
			$scope.board.list = data.list;
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.pagination.totalcount;
			$scope.board.totalPage = data.pagination.totalpage;
		});
	};
	
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
	
	$scope.boardSelect = function(item){
		if(confirm(item.board_nm + " 게시판을 선택하시겠습니까?")){
			dialogService.close("adminBoardSelect", item);		
		}
	}
});
app.controller("jsCssCtrl", function($scope, $window, $routeParams, $compile, ajaxService, dialogService, $filter) {
	$scope.model.extension="js";
	$scope.model.tp="F";

	$scope.libFileUpload = function(o){
		var filename = $(o).val();
		if(filename == ""){
			return false;
		}
		if($scope.model.extension=="js"){
			if(!/.*\.(js)$/.test(filename.toLowerCase())){
				alert("js 파일만 올려주시기 바랍니다.");
				return false;
			}
		}else{
			if(!/.*\.(css)$/.test(filename.toLowerCase())){
				alert("css 파일만 올려주시기 바랍니다.");
				return false;
			}
		}
    	$("#fFrm").ajaxSubmit({
    		url : '${context_path }/ajaxUpload.do',
    		iframe: true,
    		data:{file_name : $(o).attr("name")},
    		dataType : "json",
    		uploadProgress : function(event, position, total, percentComplete){
    		},
    		success : function(data){
    			$.extend(data, $scope.model);
    			dialogService.close("jsCssDialog", data);
    		},
    		error: function(e){
    			alert(e.responseText);
    		}
    	});
	}
	
	$scope.ok = function(){
		dialogService.close("jsCssDialog", $scope.model);
	}
	$scope.cancel = function(item){
		dialogService.close("jsCssDialog");		
	}
});

app.controller("backupCtrl", function($scope, $window, $compile, ajaxService, dialogService, $filter) {
	$scope.board = {
		param : {
			cms_menu_seq : $scope.param.cms_menu_seq
		}
	};
	$scope.board.go = function(n){
		$scope.board.param.cpage=n;
		ajaxService.getJSON('${context_path }/super/homepage/backup_list.do?cpage='+n, $scope.board.param, function(data){
			$scope.board.list = data.list;
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.pagination.totalcount;
			$scope.board.totalPage = data.pagination.totalpage;
		});
	};
	
	$scope.goHistory = function(item){
		if(confirm('이전설정 내용을 불러오시겠습니까?')){
			$scope.$emit("backupLoad", item);
		}
	}
});
</script>
</head>
<body>
<div class="titlebar">
	<h2>${view.title }</h2>
	<div>&gt;<span class="bar_tx">메뉴관리</span></div>
</div>
<div class="contents_wrap" data-ng-controller="modifyCtrl" data-ng-cloak>
	<div class="ct_wrap">
		<div class="conwrap_tap">
			<ul>
				<li class="on"><a href="#"><span>메뉴관리</span></a></li>
				<li data-ng-if="form.menu_type_org == '1'"><a href="${context_path }/super/homepage/contentFrm.do?cms_menu_seq={{form.cms_menu_seq}}&amp;parent_menu_seq={{form.parent_menu_seq}}&amp;permit=${param.permit}"><span>콘텐츠관리</span></a></li>
				<li data-ng-if="form.menu_type_org == '2'"><a href="${context_path }/super/homepage/bbs/index.do?cms_menu_seq={{form.cms_menu_seq}}&amp;parent_menu_seq={{form.parent_menu_seq}}&amp;permit=${param.permit}"><span>게시물관리</span></a></li>
				<li data-ng-if="form.menu_type_org == '3' && !!form.manage_url">
					<a data-ng-if="form.inner_yn=='Y'" href="{{validUrl(form.manage_url + '&cms_menu_seq=' + form.cms_menu_seq+ '&parent_menu_seq=' + form.parent_menu_seq+ '&menu_level=' + form.menu_level+'&permit=${param.permit}' + '&'+ form.add_param)}}"><span>프로그램관리</span></a>
					<%--<a data-ng-if="form.inner_yn=='N'" href="{{form.manage_url}}"><span>프로그램관리</span></a>--%>
				</li>
		   	</ul>
		</div>
	    <div class="contents">
		<form id="wFrm" name="frm" method="post" novalidate="novalidate" enctype="multipart/form-data">
<sec:csrfInput />
	    <table class="type1" style="margin-top:0;">
		    <colgroup>
			    <col width="200px" />
			    <col width="*" />
		    </colgroup>
	    	<caption>메뉴관리</caption>
	    	<tr>
				<th>메뉴명</th>
				<td colspan="3">
				<input type="text" data-ng-model="form.title" id="title" class="bold" style="width:100%;" required="required"/>
				</td>
			</tr>
	    	<tr>
				<th>현재화면</th>
				<td colspan="3">
				<div id="previewDiv"></div>
				</td>
			</tr>
			<tr>
				<th>메뉴 URL</th>
				<td colspan="3" style="color:#3e70c9;">
				{{form.menu_url}}
				</td>
			</tr>
			<tr>
				<th>사용여부</th>
				<td colspan="3">
				<ol class="select">
				<li class="first"><label><input type="radio" data-ng-model="form.use_yn" value="Y"/> 사용 </label></li>
				<li><label><input type="radio" data-ng-model="form.use_yn" value="N"/> 사용안함</label></li>
				</ol>
				</td>
			</tr>
			<tr>
				<th>타겟</th>
				<td colspan="3">
					<ol class="select">
						<li>
							<label>
								<input type="radio" data-ng-model="form.blank_yn" value="Y"/> 새창
								<img src="${context_path }/images/super/target1.gif" alt="새창" />
							</label>
						</li>
						<li>
							<label>
								<input type="radio" data-ng-model="form.blank_yn" value="N"/> 현재창
								<img src="${context_path }/images/super/target2.gif" alt="현재창" />
							</label>
						</li>
					</ol>
				</td>
			</tr>
			<tr data-ng-if="param.menu_level=='1'"><!-- 큰메뉴 사용여부 주소입력으로만 들어갈수있게끔 설정여부-->
				<th>상단메뉴감춤</th>
				<td colspan="3">
				<ol class="select">
					<li>
						<label>
							<input type="radio" data-ng-model="form.top_yn" value="Y"/> 보임
							<img src="${context_path }/images/super/hidden1.gif" alt="보임" />
						</label>
					</li>
					<li>
						<label>
							<input type="radio" data-ng-model="form.top_yn" value="N"/> 안보임
							<img src="${context_path }/images/super/hidden2.gif" alt="안보임" />
						</label>
					</li>
				</ol>
				</td>
			</tr>
			<tr data-ng-if="form.parent_child_type=='1'">
				<th>하위메뉴 구조</th>
				<td colspan="3">
					<span style="display:block; margin:0 0 5px 0; font-size:12px;">하위메뉴의 정렬방식에 대한 선택입니다.</span>
					<ol class="select">
						<li>
							<label>
								<input type="radio" data-ng-model="form.child_type" ng-value="1"/> 트리
								<img src="${context_path }/images/super/treeMenu.gif" alt="트리" />
							</label>
						</li>
						<li data-ng-if="form.menu_level=='1'">
							<label>
								<!-- <input type="radio" data-ng-model="form.child_type" ng-value="2" data-ng-click="form.menu_type='5';"/>  -->대메뉴는 탭메뉴 구조를 선택하실 수 없습니다.
								<img src="${context_path }/images/super/tabMenu.gif" alt="탭" />
							</label>
						</li>
						<li data-ng-if="form.menu_level!='1'">
							<label>
								<input type="radio" data-ng-model="form.child_type" ng-value="2" data-ng-click="form.menu_type='5';"/> 탭
								<img src="${context_path }/images/super/tabMenu.gif" alt="탭" />
							</label>
						</li>						
					</ol>
				</td>
			</tr>
			<tr>
				<th>담당그룹</th>
				<td colspan="3">
					<div class="layout_g2">
						<span style="display:inline-block; margin:4px 7px 0 0; font-size:12px;">그룹별로 메뉴에대한 메뉴관리를 제외한 권한(콘텐츠관리, 게시물관리,프로그램관리)을 지정할 수 있습니다.</span><br/>
						<input type="button" value="그룹 선택" class="btalls" data-ng-click="openGroupSelect(3)"></span>
					</div>
					<div class="layout_g1" data-ng-show="form.staff_group.length>0">
					    <span data-ng-model="form.staff_group">
							<span data-ng-repeat="item in form.staff_group">
								{{item.group_nm}}
								<a data-ng-click="removeStaffGroup($index)"><img src="${context_path }/images/container/btn_del2_03.png" class="btn"></a>
							</span>
					    </span>
					</div>
				</td>
			</tr>
			<tr>
				<th>페이지 담당</th>
				<td colspan="3">
					<div class="layout_g2">
						<span style="display:inline-block; margin:4px 7px 0 0; font-size:12px;">관리자별로 사용자페이지 콘텐츠 하단에 보여질 페이지 담당자를 지정할 수 있습니다.</span><br/>
					   	<input type="button" value="담당자 선택" class="btalls" data-ng-click="openStaffsSelect()">
					</div>
					<div class="layout_g1" data-ng-show="form.staffs.length>0">
					    <span ui-sortable="staffSortable" data-ng-model="form.staffs">
							<span data-ng-repeat="item in form.staffs">
								{{item.group_nm}} > {{item.member_nm}}
								<a data-ng-click="removeStaff($index)"><img src="${context_path }/images/container/btn_del2_03.png" class="btn"></a>
							</span>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th>페이지 권한</th>
				<td colspan="3">
					<div class="layout_g2">
						<span style="display:inline-block; margin:4px 7px 0 0; font-size:12px;">관리자별로 메뉴에대한 메뉴관리 권한을 지정 할 수 있습니다.</span><br/>
						<input type="button" value="권한 선택" class="btalls" data-ng-click="openPermissionsSelect()">
					</div>
					<div class="layout_g1" data-ng-show="form.permissions.length>0">
					    <span ui-sortable="staffSortable" data-ng-model="form.permissions">
							<span data-ng-repeat="item in form.permissions">
								{{item.group_nm}} > {{item.member_nm}}
								<a data-ng-click="removePermission($index)"><img src="${context_path }/images/container/btn_del2_03.png" class="btn"></a>
							</span>
						</span>
					</div>
				</td>
			</tr>
			<tr style="display:none;">
				<th>레이아웃</th>
				<td colspan="3">
				<ol class="select">
					<li class="first"><label><input type="radio" data-ng-model="form.template_type" ng-value="1"/> 기본(좌측메뉴)
						<img src="${context_path }/images/super/layout1.gif" alt="레이아웃1" />
					</label>
					</li>
					<li><label><input type="radio" data-ng-model="form.template_type" ng-value="2"/> 좌측메뉴없음
						<img src="${context_path }/images/super/layout2.gif" alt="레이아웃2" />
					</label>
					</li>
				</ol>
				</td>
			</tr>
			<tr style="display:none;">
				<th>JavaScript/CSS 등록</th>
				<td colspan="3">
					<div class="layout_g2">
						<span style="display:inline-block; margin:4px 7px 0 0; font-size:12px;">해당 메뉴에서만 필요한 JavaScript/CSS 파일을 등록하여 이용 할 수 있습니다.(등록된 파일은 다른메뉴에 영향이 없습니다.)</span><br>
					    <input type="button" value="파일 선택" class="btalls" data-ng-click="openJsCssDialog()">
					    
					<div class="layout_g1" ng-show="form.libs.length>0">
					    <span ui-sortable="libsSortable" data-ng-model="form.libs">
							<span data-ng-repeat="item in form.libs">{{item.org_file_name}}
								<a data-ng-click="removeLib($index)"><img src="${context_path }/images/container/btn_del2_03.png" class="btn"></a>
							</span>
						</span>
					</div>
				</td>
			</tr>	
			
			<tr>
				<th>타입</th>
				<td colspan="3">
					<ol class="select">
						<li><label><input type="radio" data-ng-model="form.menu_type" value="1"/> 페이지</label></li>
						<li><label><input type="radio" data-ng-model="form.menu_type" value="2" /> 게시판</label></li>
						<li><label><input type="radio" data-ng-model="form.menu_type" value="3" /> 프로그램</label></li>
						<li><label><input type="radio" data-ng-model="form.menu_type" value="4" /> 링크</label></li>
						<li data-ng-if="form.parent_child_type=='1'"><label><input type="radio" data-ng-model="form.menu_type" value="5" /> 하위메뉴 링크</label></li>
					</ol>
					<ol class="sign1" data-ng-switch="form.menu_type">
						<li data-ng-switch-default>- 콘텐츠 타입으로 사업소개, 내용소개등을 표시 할 수 있습니다.</li>
						<li data-ng-switch-when="2">- 시스템에서 생성한 게시판을 선택하여 이용 할 수 있습니다.</li>
						<li data-ng-switch-when="3">- 시스템에서 기본 제공되는 프로그램과 추가적으로 개발된 프로그램을 선택 할 수 있습니다.(개발자만 사용을 권장 합니다.)</li>
						<li data-ng-switch-when="4">- 해당 메뉴를 클릭시 지정된 페이지로 이동시에 이용 합니다.</li>
						<li data-ng-switch-when="5">- 해당 메뉴 하위 계층으로 메뉴가 있을시에 선택 합니다.(자동으로 하위메뉴로 이동)</li>
					</ol>
				</td>
			</tr>
			
			<tr data-ng-if="form.menu_type=='2'">
				<th>게시판 선택</th>
				<td colspan="3"><input type="button" value="게시판 선택" class="btalls" data-ng-click="onBoardPop();"></td>
			</tr>
			<tr data-ng-if="form.menu_type=='2'">
				<th>게시판명</th>
				<td colspan="3"><input type='text' class='normal readonly' style="width:100%;" data-ng-model='form.b_program_nm' id='b_program_nm' readonly /></td>
			</tr>
	
			<tr data-ng-if="form.menu_type=='3'">
				<th>프로그램 선택</th>
				<td colspan="3"><input type="button" value="프로그램 선택" class="btalls" data-ng-click="onProgramPop();"></td>
			</tr>
			<tr data-ng-if="form.menu_type=='3'">
			  <th>프로그램명</th>
			  <td colspan="3"><input type='text' class='normal readonly' style='width:100%;' data-ng-model='form.program_nm' readonly><!-- required="required" --></td></tr>
			<tr data-ng-if="form.menu_type=='3'">
			  <th>프로그램 URL</th>
			  <td colspan="3"><input type='text' class='normal readonly' style='width:100%;' data-ng-model='form.target_url' readonly/></td></tr>
			<tr data-ng-if="form.menu_type=='3' && form.inner_yn === 'Y'">
			  <th>프로그램 관리URL</th>
			  <td colspan="3"><input type='text' id="manage_url" class='normal' style='width:100%;' data-ng-model='form.manage_url' required="required" /></td></tr>
			<tr data-ng-if="form.menu_type=='3'">
			  <th>메뉴관리에 포함</th>
			  <td colspan="3">
				  <ol class="select">
					  <li class="first"><label><input type="radio" data-ng-model="form.inner_yn" value="Y"/> 포함 </label></li>
					  <li><label><input type="radio" data-ng-model="form.inner_yn" value="N"/> 미포함</label></li>
					  <%--<li><label><input type="radio" data-ng-model="form.inner_yn" value="X"/> 사용안함</label></li>
				  </ol>
			  </td>
			</tr>
	
			<%-- 삭제예정<tr data-ng-if="form.menu_type=='2' || form.menu_type=='3'">
				<th>열람권한</th>
				<td  colspan="3">
					<div class="layout_g1" ng-show="form.groups1.length>0">
					    <span style="display:block; padding:5px 0 0 0; margin:0px;">
						<span style="display:block;height:20px;" data-ng-repeat="item in form.groups1">{{item.group_nm}}
							<a data-ng-click="removeGroup(1, $index)"><img src="${context_path }/images/container/btn_del2_03.png" class="btn"></a>
						</span>
			     		</span>
					</div>
					<div class="layout_g2">
					    <input type="button" value="그룹 선택" class="btalls" data-ng-click="openGroupSelect(1)">
					    <span>해당 메뉴의 열람권한 지정 선택입니다.</span>
					</div>
				</td>
			</tr>
			<tr data-ng-if="form.menu_type=='2' || form.menu_type=='3'">
				<th>등록수정권한</th>
				<td colspan="3">
					<div class="layout_g1" ng-show="form.groups2.length>0">
					    <span style="display:block; padding:5px 0 0 0; margin:0px;">
						<span style="display:block;height:20px;" data-ng-repeat="item in form.groups2">{{item.group_nm}}
							<a data-ng-click="removeGroup(2, $index)"><img src="${context_path }/images/container/btn_del2_03.png" class="btn"></a>
						</span>
					    </span>
					</div>
					<div class="layout_g2">
					    <input type="button" value="그룹 선택" class="btalls" data-ng-click="openGroupSelect(2)">
						<span>해당 메뉴의 등록수정권한 지정 선택입니다.</span>
					</div>
					
				</td>
			</tr> --%>
			<tr data-ng-if="form.menu_type=='4'">
				<th>링크 주소</th>
				<td colspan="3">
					<span style="display:inline-block; margin:4px 7px 0 0; font-size:12px;">외부주소 링크일 경우 https://domain/을 포함하여 입력해주세요. 예시) https://www.mediacore.kr/xxxxx/xxxx.do</span><br/>
					<input type='text' id="target_url" class='normal' style='width:100%;' data-ng-model='form.target_url' size='70' required="required"/>
				</td>
			</tr>
			<tr>
				<th>추가 파라미터</th>
				<td colspan="3">
					<span style="display:block; margin:0 0 5px 0; font-size:12px;">파라미터 값이 필요한 경우 사용 할 수 있습니다.(잘못된 값을 입력 할 경우 오류가 발생 할 수 있으니 주의 필요)</span>
					<input type="text" class="normal" style="width:100%;" data-ng-model="form.add_param"/>
				</td>
			</tr>

			<tr>
				<th>머리글</th>
				<td colspan="3"><textarea data-ng-model="form.head_html" global-editor ng-height="'300px'"></textarea>
				</td>
			</tr>
	    </table>
	    
	    <div class="btn_bottom">
	    	<div class="r_btn">
	<!--           <span class="bt_all"> -->
	<!--           	<span><input type="button" value="예약적용" class="btall" data-ng-click="reserve()"/></span> -->
	<!--           </span> -->
	<input type="button" value="수정" class="bt_big_bt4" data-ng-click="save()"/>
	<input type="button" value="삭제" class="bt_big_bt3" data-ng-click="del()"/>
	        </div>
	    </div>
	    
		</form>
	    </div> 
    </div>
    
    <div id="topBar">
    	<div class="topBar_inner">
			<div class="history" data-ng-controller="backupCtrl" data-ng-init="board.go(1)">
				<dl id="history_dl">
					<dt>메뉴 수정이력</dt>
					<dd data-ng-if="board.list.length==0" style="margin-left:15px;">수정이력이 없습니다.</dd>
					<dd data-ng-repeat="item in board.list">
						<span class="history_1">{{item.mod_dt|myDate:'yyyy-MM-dd HH:mm'}}</span>
						<span class="history_btn" data-ng-click="goHistory(item)">복원</span>
						<span class="history_2">{{item.mod_nm}}</span>
					</dd>
				</dl>
				<pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)" ng-mode="mini"></pagination>
			</div>
			<bookmark userid="${sessionScope.cms_member.member_id }"></bookmark>
		</div>
		<span class="optBtn"><a href="javascript:void(0)"><img src="/images/cms/opt_close.gif" alt=""></a></span>
    </div>
</div>
<div style="height:0px;">
<iframe id="previewFrame" style="width:100%; height:1px;" sandbox="allow-pointer-lock allow-same-origin"></iframe><!-- 화면캡쳐용 iframe -->
</div>
<script type="text/ng-template" id="staffsSelectTemplate.html">
	<div ng-controller="staffsSelectCtrl" title="그룹선택">
		<div style="padding-left: 270px;">
		<div class="nav nav_style_1" scrollable="scrollOption" style="width:250px; height:444px; max-height:444px;">
			<div class="dept_container" style="width:230px;" >
			<ul class="list treeview2">
				<li>
					<span>그룹</span>
				</li>
			</ul>
			</div>
        
		</div>
		<form name="searchFrm" method="post">
			<table class="type1" style="margin-top:13px;">
		    	<colgroup>
		    		<col width="25%" />
		    		<col width="*" />
		    	</colgroup>
		    	<caption>담당자 선택</caption>
		    	<tr>
					<th>검색구분</th>
					<td>
						<select title="검색구분" class="normal w150" data-ng-model="param.condition" data-ng-init="param.condition=''">
							<option value="">선택하세요</option>
		            		<option value="member_id">아이디</option>
		            		<option value="group_nm">그룹</option>
							<option value="member_nm">이름</option>
		          		</select> 
					</td>
				</tr>
				<tr>
					<th>그룹</th>
					<td>
						<select title="그룹" class="normal w150" data-ng-model="param.group_seq" data-ng-init="param.group_seq=''" data-ng-options="item.group_seq as item.group_nm for item in group_list">
		            		<option value="">선택하세요</option>
		          		</select> 
					</td>
				</tr>
				<tr>
					<th>검색어</th>
					<td>
						<input type="text" class="normal w150" data-ng-model="param.keyword"/>
					</td>
				</tr>
				<tr>
					<th colspan="2" style="text-align:center; padding-left:0px; padding-right:0px;">
						<%-- <a data-ng-click="board.go(1)"><img src="<c:url value="/images/super/contents/s_btn_search.gif"/>" alt="검색" /></a> --%>
						<a class="bt_big_bt5" data-ng-click="board.go(1)">검색</a>
					</th>
				</tr>
		    </table>
		</form>
		<table class="type1" style="margin-top:13px;" id = "boardList">
		  	<colgroup>
				<col width="8%">
		  		<col width="20%">
		  		<col width="*">
		  		<col width="20%">
			</colgroup>
			<thead>
				<tr>
					<th class="center"></th>
					<th class="center">아이디</th>
					<th class="center">그룹</th>
					<th class="center">성명</th>
				</tr>
			</thead>
			<tbody>
				<tr data-ng-if="board.list.length==0"><td colspan="4" class="center">결과가 없습니다.</td></tr>
				<tr data-ng-repeat="item in board.list">
					<td class="center" style="padding:8px;"><input type="checkbox" data-ng-model="item.chk"  data-ng-change="clickMember(item)"/></td>
					<td class="left" style="padding:8px;">{{item.member_id}}</td>
					<td class="center" style="padding:8px;">{{item.group_nm}}</td>
					<td class="center" style="padding:8px;">{{item.member_nm}}</td>
				</tr>
			</tbody>
		</table>
		<pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)" style="margin-top: 10px;"></pagination>
		</div>

		<div class="btn_bottom">
			<div class="r_btn">
				<input type="button" value="선택인원 일괄 지정" class="bt_big_bt4" data-ng-click="selecterMember()"/>
				<input type="button" value="취소" class="bt_big_bt3" data-ng-click="cancel()"/>
			</div>
		</div>
	</div>
</script>
<script type="text/ng-template" id="permissionsSelectTemplate.html">
	<div ng-controller="permissionsSelectCtrl" title="그룹선택">
		<div style="padding-left: 270px;">
			<div class="nav nav_style_1" scrollable="scrollOption" style="width:250px; height:444px; max-height:444px;">
				<div class="dept_container" style="width:230px;" >
					<ul class="list treeview2">
						<li>
							<span>그룹</span>
						</li>
					</ul>
				</div>

			</div>
			<form name="searchFrm" method="post">
				<table class="type1" style="margin-top:13px;">
					<colgroup>
						<col width="25%" />
						<col width="*" />
					</colgroup>
					<caption>권한 선택</caption>
					<tr>
						<th>검색구분</th>
						<td>
							<select title="검색구분" class="normal w150" data-ng-model="param.condition" data-ng-init="param.condition=''">
								<option value="">선택하세요</option>
								<option value="member_id">아이디</option>
								<option value="group_nm">그룹</option>
								<option value="member_nm">이름</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>그룹</th>
						<td>
							<select title="그룹" class="normal w150" data-ng-model="param.group_seq" data-ng-init="param.group_seq=''" data-ng-options="item.group_seq as item.group_nm for item in group_list">
								<option value="">선택하세요</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>검색어</th>
						<td>
							<input type="text" class="normal w150" data-ng-model="param.keyword"/>
						</td>
					</tr>
					<tr>
						<th colspan="2" style="text-align:center; padding-left:0px; padding-right:0px;">
							<%-- <a data-ng-click="board.go(1)"><img src="<c:url value="/images/super/contents/s_btn_search.gif"/>" alt="검색" /></a> --%>
							<a class="bt_big_bt5" data-ng-click="board.go(1)">검색</a>
						</th>
					</tr>
				</table>
			</form>
			<table class="type1" style="margin-top:13px;">
				<colgroup>
					<col width="8%">
					<col width="20%">
					<col width="*">
					<col width="20%">
				</colgroup>
				<thead>
				<tr>
					<th class="center"></th>
					<th class="center">아이디</th>
					<th class="center">그룹</th>
					<th class="center">성명</th>
				</tr>
				</thead>
				<tbody>
				<tr data-ng-if="board.list.length==0"><td colspan="4" class="center">결과가 없습니다.</td></tr>
				<tr data-ng-repeat="item in board.list">
					<td class="center" style="padding:8px;"><input type="checkbox" data-ng-model="item.chk"  data-ng-change="clickMember(item)"/></td>
					<td class="left" style="padding:8px;">{{item.member_id}}</td>
					<td class="center" style="padding:8px;">{{item.group_nm}}</td>
					<td class="center" style="padding:8px;">{{item.member_nm}}</td>
				</tr>
				</tbody>
			</table>
			<pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)" style="margin-top: 10px;"></pagination>
		</div>

		<div class="btn_bottom">
			<div class="r_btn">
				<input type="button" value="선택인원 일괄 지정" class="bt_big_bt4" data-ng-click="selecterMember()"/>
				<input type="button" value="취소" class="bt_big_bt3" data-ng-click="cancel()"/>
			</div>
		</div>
	</div>
</script>
<script type="text/ng-template" id="groupSelectTemplete.html">
	<div ng-controller="groupSelectCtrl" title="그룹선택" data-ng-init="group.go(1)">
	<form name="searchForm" method="post" >
		<input type="hidden" name="condition" value="group_nm" />
		<input type="text" class="normal w175" style="width:100%; margin-left: 5px;" data-ng-model="param.keyword" data-ng-keypress="myFunct($event)" />
		<a class="bt_big_bt5" style="height: 13px;" data-ng-click="group.go(1)">검색</a>

		<div class="nav nav_style_1" scrollable="scrollOption" style="width:400px; height:350px; max-height:350px; margin-top: 20px;">
			<div class="dept_container" >
			<ul class="list treeview2">
				<li>
					<span>그룹</span>
				</li>
			</ul>
			</div>
		</div>
	</form>
	</div>
</script>
<script type="text/ng-template" id="jsCssTemplete.html">
	<div ng-controller="jsCssCtrl" title="파일선택">
	<form id="fFrm" name="frm" method="post" novalidate="novalidate" enctype="multipart/form-data">
		<sec:csrfInput />
        <table class="type1" style="margin-top:20px;">
        	<colgroup>
        	  	<col width="100" />
        	  	<col width="*" />
        	</colgroup>
        	<tbody>
        		<tr>
        			<th class="center">확장자</th>
        			<td class="left">
        				<ol class="select">
        				    <li><label><input type="radio" ng-model="model.extension" value="js"/> JS</label></li>
        					<li><label><input type="radio" ng-model="model.extension" value="css"/> CSS</label></li>
        				</ol>
        			</td>
        		</tr>
        		<tr>
        			<th class="center">타입</th>
        			<td class="left">
        				<ol class="select">
        				    <li><label><input type="radio" ng-model="model.tp" value="L"/> 링크</label></li>
        					<li><label><input type="radio" ng-model="model.tp" value="F"/> 직접 업로드</label></li>
        				</ol>
        			</td>
        		</tr>
        		<tr ng-if="model.tp=='F'">
        			<th class="center">업로드</th>
        			<td class="left">
        				<input type="file" name="libfile" onchange="angular.element(this).scope().libFileUpload(this)"/>
        			</td>
        		</tr>
        		</tr>
        		<tr ng-if="model.tp=='L'">
        			<th class="center">링크</th>
        			<td class="left">
        				<input type="text" class="normal" style="width:100%;" ng-model="model.full_path"/>
        			</td>
        		</tr>
        	</tbody>
        </table>
		<div class="btn_bottom">
			<div class="r_btn">
				<input type="button" value="저장" class="bt_big_bt4" data-ng-click="ok()" ng-if="model.tp=='L'">
				<input type="button" value="취소" class="bt_big_bt3" data-ng-click="cancel()">
			</div>
		</div>
	</form>
	</div>
</script>
<script type="text/ng-template" id="adminBoardSelect.html">
<div data-ng-controller="boardSelectCtrl" class="dialog" title="게시판 선택"  data-ng-cloak class="contents" data-ng-init="board.go(1)">
	<div class="fn_wrap" style="overflow:hidden; padding:10px 0 0 0;">
		<form name="searchForm" method="post" >
		<table class="type1">
		    <colgroup>
		    	<col width="25%" />
		    	<col width="*" />
		    </colgroup>
		    <caption>게시판 선택</caption>
			<tr>
				<th>게시판 타입</th>
				<td>
					<select class="normal w175" data-ng-model="board.param.board_type" data-ng-options="item.board_type as item.name for item in boardType">
						<option value="">전체</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>생성일</th>
				<td>
					<input type="text" class="normal w175" style="width:100%;" data-ng-model="board.param.reg_dt" datetimepicker/>
				</td>
			</tr>
			<tr>
				<th>검색어</th>
				<td>
					<input type="text" class="normal w175" style="width:100%;" data-ng-model="board.param.keyword" />
				</td>
			</tr>
			<tr>
				<th colspan="2" style="text-align:center; padding-left:0px; padding-right:0px;">
					<%-- <a data-ng-click="board.go(1)"><img src="<c:url value="/images/super/contents/s_btn_search.gif"/>" alt="검색" /></a> --%>
					<a class="bt_big_bt5" data-ng-click="board.go(1)">검색</a>					
				</th>
			</tr>
		</table>
		</form>
    </div>

	<table class="type1" style="margin-top:20px;">
		<colgroup>
		  	<col width="*" />
		  	<col width="15%" />
		  	<col width="15%" />
		  	<col width="15%" />
		</colgroup>
		<thead>
			<tr>
				<th class="center">게시판명</th>
				<th class="center">게시판타입</th>
				<th class="center">생성일</th>
				<th class="center">선택</th>
			</tr>
		</thead>
		<tbody>
			<tr data-ng-if="board.list.length==0">
				<td colspan="4" class="center">결과가 없습니다.</td>
			</tr>
			<tr data-ng-repeat="item in board.list">
				<td>{{item.board_nm}}</td>
				<td class="center" data-ng-repeat="types in boardType" data-ng-if="types.board_type == item.board_type">{{types.name}}</td>
				<td class="center">{{item.reg_dt}}</td>
				<td class="center">
					<input type="button" value="선택" data-ng-click="boardSelect(item);" class="btalls"/>
				</td>
			</tr>
		</tbody>
	</table>
	<pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
</div>
</script>
</body>
</html>