<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf" %>
<c:set var="site_id" value="${empty cookie.adh_menu_current_siteid ? '1' : cookie.adh_menu_current_siteid.value }"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시물 관리</title>
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
<script type="text/javascript" src="<c:url value="/lib/js/directives/myComments.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/route/boardRouteResolver.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/services/filterService.js"/>"></script>
<script type="text/javascript">
var app = angular.module("MyApp", ['boardRouteResolverServices','dialogService', 'ngRoute', 'myUtil', 'myPagination', 'myCommon', 'ui.sortable', 'myFilter', 'ngRange', 'myEditor', 'ngSanitize', 'myComments', 'wdFilter']);

/* 예약등록용 datetimepicker */
app.directive("rsvdatetimepicker", ["$timeout", function ($timeout) {
	return {
		require : 'ngModel',
	    link : function (scope, elem, attrs, ctrl) {
	    	scope.$on("updateDateModel", function(){
	    		elem.focus();
	    	    var e = jQuery.Event("keydown");
	    	    e.which = 13;
				$timeout(function(){
	    	    	elem.trigger(e);
				},100);
	    	});
			elem.datetimepicker({
				inline:true,
				format:	'Y/m/d H:i',
				onChangeYear : changeDate,
				onChangeMonth : changeDate,
				onChangeDateTime : changeDate,
				onSelectDate : changeDate,
				defaultDate : "${dtf:getTime('yyyy/MM/dd') }",
				defaultTime : "${dtf:getTime('HH:mm') }"
			});
			function changeDate(date, o) {
				scope.$apply(function () {
                    ctrl.$setViewValue($(o).val());
                    scope.$emit("updateDateBox", {
                    	year:date.getFullYear()+""
                    	, month : (("00" + (date.getMonth()+1)).slice(-2) )
                    	, day : ("00" + date.getDate()).slice(-2)
                    	, hour : ("00" + date.getHours()).slice(-2)
                    	, minute : ("00" + date.getMinutes()).slice(-2)
                    });
                });
			}
	    	$(elem).css({
	    		display: "block"
		        ,top:" 65px"
		        ,position: "relative"
		        ,left: "20px"
		        ,zIndex: "-1"
	    	});	
		}
	};
}]).directive('tagnames', function() {
	return {
		restrict: 'A',
        require : 'ngModel',
	    link: function(scope, elem, attrs, ctrl) {
	    	elem.on('keyup', function(e) {
	    		if(e.keyCode==8){
	    			return;
	    		}
	    		var rst = [];
		        var list = $(this).val().split(",");
		        $.each(list, function(i, o){
		        	var v = $.trim(o);
					if(v.startsWith("#")){
						rst.push(v);
					}else{
						rst.push("#"+v);
					}
				});
		        if(rst.join(",")!=$(this).val()){
		        	$(this).val(rst.join(","));
		        }
	    	});
	    	elem.on('focusin', function() {
		        if($(this).val()==""){
		        	$(this).val("#");
		        }
	    	});
	    	elem.on('focusout', function() {
		        var list = $(this).val().split(",");
		        var lsatVal = $.trim(list[list.length-1]);
		        if(lsatVal=="" || lsatVal=="#"){
		        	list.splice(list.length-1, 1);
		        }
		        $(this).val(list.join(","));
        		scope.$apply(function(){
        			ctrl.$setViewValue(list.join(", "));
        		});
	    	});
	    }
	}
});

app.run(function($rootScope, ajaxService, $location){
	
	$rootScope.main = {};
	$rootScope.param = {
		site_id : '${site_id}',			
		parent_menu_seq : '${param.parent_menu_seq}',
		cms_menu_seq : '${param.cms_menu_seq}',
		permit : '${param.permit}',
		get_my_permission_page : '${sessionScope.cms_member.get_my_permission_page}'
	};

	ajaxService.getSyncJSON("<c:url value="/super/bbs/info.do"/>", {cms_menu_seq : $rootScope.param.cms_menu_seq}, function(data){
		angular.extend($rootScope.param, {
			board_type : data.info.board_type,
			board_seq : data.info.board_seq,
			file_yn : data.info.file_yn,
			cat_yn : data.info.cat_yn,
			file_limit : data.info.file_limit,
			limit_file_size : data.info.limit_file_size,
			comment_yn : data.info.comment_yn,
			del_yn : 'N',
			public_yn : data.info.public_yn,
			cclnuri_yn : data.info.cclnuri_yn,
			tag_yn : data.info.tag_yn,
			editor_yn : data.info.editor_yn
		});
		if(!!$location.path()){
			$location.path($location.path());
		}else{
			$location.path("/list/"+data.info.board_type+"/");
			$location.replace("/list/"+data.info.board_type+"/");
		}
	});
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
	    .when('/write/:type', route.resolve("write"))
	    .when('/modify/:type/:seq', route.resolve("modify"))
	    .when('/reply/:type/:seq', route.resolve("reply"))
	    .when('/list/:type', route.resolve("list"));
}]);

app.controller("mainCtrl", function($scope, $route, $location, ajaxService, dialogService) {
	//1:1게시판 대기
	$scope.statelist = [];
	$scope.$on('putStatelist', function(event, data) {
		$scope.statelist = data.list;
    });
	
	$scope.list = function(){
		$location.path("/list/"+$scope.param.board_type);
		$route.reload();
	}
	
	if($scope.param.cat_yn == 'Y'){
		ajaxService.getSyncJSON('<c:url value="/super/bbs/catlist.do"/>', {board_seq : $scope.param.board_seq}, function(data){
			$scope.catlist = data;
		});
	};
	
	$scope.deletes = function(){
		var seqs = [];
		$($("#boardList input[type=checkbox]:checked").get().reverse()).each(function(){
			if($(this).val() != 'on'){
				seqs.push($(this).val());
			}
		});
		if(seqs.length==0){
			alert("삭제하실 게시물을 선택해 주십시오.");
			return false;
		}
		if(confirm("삭제하시겠습니까?")){
			ajaxService.getJSON('<c:url value="/super/bbs/delete.do"/>', {article_seq : seqs.join(",")}, function(data){
				$scope.list();
			});
		}
	}
	
	$scope.move = function(){
		var seqs = [];
		$($("#boardList input[type=checkbox]:checked").get().reverse()).each(function(){
			if($(this).val() != 'on'){
				seqs.push($(this).val());
			}
		});
		if(seqs.length==0){
			alert("이동하실 게시물을 선택해 주십시오.");
			return false;
		}
		
		var options = {
			autoOpen: false,
			modal: true,
			width: "750",
			height: "700",
			close: function(event, ui) {}
		};
			
		dialogService.open("articleMove","articleMove.html", {article_seq : seqs.join(","), board_seq : $scope.param.board_seq}, options).then(
			function(result) {
				$scope.list();
			},
			function(error) {}
		);
	}
	
	$scope.copy = function(){
		var seqs = [];
		$($("#boardList input[type=checkbox]:checked").get().reverse()).each(function(){
			if($(this).val() != 'on'){
				seqs.push($(this).val());
			}
		});
		if(seqs.length==0){
			alert("복사하실 게시물을 선택해 주십시오.");
			return false;
		}
		
		var options = {
			autoOpen: false,
			modal: true,
			width: "750",
			height: "700",
			close: function(event, ui) {}
		};
			
		dialogService.open("articleCopy","articleCopy.html", {article_seq : seqs.join(","), board_seq : $scope.param.board_seq}, options).then(
			function(result) {
				$scope.list();
			},
			function(error) {}
		);
	}
	
	$scope.copyView = function(seq){
		var seqs = [];
		seqs.push(seq);
		if(seqs.length==0){
			alert("복사하실 게시물이 없습니다.");
			return false;
		}
		
		var options = {
			autoOpen: false,
			modal: true,
			width: "750",
			height: "700",
			close: function(event, ui) {}
		};
			
		dialogService.open("articleCopy","articleCopy.html", {article_seq : seqs.join(","), board_seq : $scope.param.board_seq}, options).then(
			function(result) {
				$scope.list();
			},
			function(error) {}
		);
	}
	
	$scope.db_delete = function(){
		var del_seq = "";
		$($("#boardList input[type=checkbox]:checked").get().reverse()).each(function(){
			if($(this).val() != 'on'){
				del_seq += $(this).val()+",";
			}
		});
		if(del_seq == ""){
			alert("완전 삭제하실 게시물을 선택해 주십시오.");
			return false;
		}
		del_seq = del_seq.substr(0,del_seq.length-1);
		if(confirm("완전 삭제하시겠습니까?")){
			ajaxService.getJSON('<c:url value="/super/bbs/articleDelete.do"/>', {cms_menu_seq: $scope.param.cms_menu_seq, article_seq : del_seq}, function(data){
				$scope.list();
			});
		}
	}
	
	$scope.restore = function(){
		var re_seq = "";
		$($("#boardList input[type=checkbox]:checked").get().reverse()).each(function(){
			if($(this).val() != 'on'){
				re_seq += $(this).val()+",";
			}
		});
		if(re_seq == ""){
			alert("복구하실 게시물을 선택해 주십시오.");
			return false;
		}
		re_seq = re_seq.substr(0,re_seq.length-1);
		if(confirm("복구하시겠습니까?")){
			ajaxService.getJSON('<c:url value="/super/bbs/articleRestore.do"/>', {article_seq : re_seq}, function(data){
				$scope.list();
			});
		}
	}

	$scope.db_delete_one = function(seq){
		if(confirm("완전 삭제하시겠습니까?")){
			ajaxService.getJSON('<c:url value="/super/bbs/articleDelete.do"/>', {cms_menu_seq: $scope.param.cms_menu_seq, article_seq : seq}, function(data){
				$scope.list();
			});
		}
	}
	
	$scope.restore_one = function(seq){
		if(confirm("복구하시겠습니까?")){
			ajaxService.getJSON('<c:url value="/super/bbs/articleRestore.do"/>', {article_seq : seq}, function(data){
				$scope.list();
			});
		}
	}
});

app.controller("catSelectCtrl", function($scope, $window, $routeParams, $compile, ajaxService, dialogService) {
	$scope.catlist = {};
	ajaxService.getSyncJSON('<c:url value="/super/bbs/catlist.do"/>', {board_seq : $scope.model.board_seq}, function(data){
		$scope.catlist = data;
	});
	$scope.catSelect = function(item){
		dialogService.close("catSelect", item);
	}
});

app.controller("moveCtrl", function($scope, $window, $routeParams, $compile, ajaxService, dialogService) {
	$scope.boardType = {};
	ajaxService.getJSON('<c:url value="/super/system/board/type_list.do"/>', {}, function(data){
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
		ajaxService.getJSON('<c:url value="/super/system/board/list.do"/>', $scope.board.param, function(data){
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
		var deferred = $.Deferred();
		var params = {"board_seq" : item.board_seq, "article_seq" : $scope.model.article_seq, "board_type":item.board_type};
		if(item.cat_yn=="Y"){
			var options = {
				autoOpen: false,
				modal: true,
				width: "400",
				height: "400",
				close: function(event, ui) {}
			};
				
			dialogService.open("catSelect","catSelect.html", {board_seq: item.board_seq}, options).then(
				function(result) {
					params.cat = result.board_cat_seq;
					deferred.resolve();
				},
				function(error) {
					deferred.reject();
					dialogService.close("catSelect");
				}
			);
		}else{
			deferred.resolve();
		}
		deferred.promise().done(function(){
			if(confirm("게시물의 형식이 맞지 않을 경우 오류가 발생할 수 있습니다.\n"+item.board_nm+" 게시판으로 게시물을 이동하시겠습니까?")){
				ajaxService.getJSON('<c:url value="/super/bbs/move.do"/>', params, function(data){
					alert(data.msg);
				});
				dialogService.close("articleMove");
			}
		});
	}
});

app.controller("copyCtrl", function($scope, $window, $routeParams, $compile, ajaxService, dialogService) {
	$scope.boardType = {};
	ajaxService.getJSON('<c:url value="/super/system/board/type_list.do"/>', {}, function(data){
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
		ajaxService.getJSON('<c:url value="/super/system/board/list.do"/>', $scope.board.param, function(data){
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
		var deferred = $.Deferred();
		var params = {"board_seq" : item.board_seq, "article_seq" : $scope.model.article_seq, "board_type":item.board_type};
		if(item.cat_yn=="Y"){
			var options = {
				autoOpen: false,
				modal: true,
				width: "400",
				height: "400",
				close: function(event, ui) {}
			};
				
			dialogService.open("catSelect","catSelect.html", {board_seq: item.board_seq}, options).then(
				function(result) {
					params.cat = result.board_cat_seq;
					deferred.resolve();
				},
				function(error) {
					deferred.reject();
					dialogService.close("catSelect");
				}
			);
		}else{
			deferred.resolve();
		}
		deferred.promise().done(function(){
			if(confirm("게시물의 형식이 맞지 않을 경우 오류가 발생할 수 있습니다.\n"+item.board_nm+" 게시판으로 게시물을 복사하시겠습니까?")){
				ajaxService.getJSON('<c:url value="/super/bbs/copy.do"/>', params, function(data){
					alert(data.msg);
				});
				dialogService.close("articleCopy");
			}
		});
	}
});

/* 게시물 예약 */
app.controller("reserveCtrl", function($scope, $window, $routeParams, $compile, ajaxService, dialogService, $timeout, $filter) {
	$scope.form = {
		year : "${dtf:getTime('yyyy') }"
		,month : "${dtf:getTime('MM') }"
		,day : "${dtf:getTime('dd') }"
		,hour : "${dtf:getTime('HH') }"
		,minute : "${dtf:getTime('mm') }"
	};
	$scope.lastDay = function(){
		 return (new Date($scope.form.year, $scope.form.month ,0)).getDate();
	}
	ajaxService.getJSON('${context_path }/super/homepage/page_navi.do?cms_menu_seq='+$scope.param.cms_menu_seq, {}, function(data){
		$scope.form.page_navi = (function(str){
			var div="<div>";
			var list = str.split(">");
			for(var i=0; i<list.length; i++){
				div += (i==0?"":"&gt;")+"<span>"+$.trim(list[i])+"</span>";
			}
			div += "</div>";
			var rst = $(div);
			rst.children("span").first().addClass("b_sp_first");
			rst.children("span").last().addClass("b_sp_last");
			return rst.html();
		})(data.page_navi.page_navi);
	});

	$scope.changeDate = function(){
		$scope.form.reserve_dt = $scope.form.year+"/"+$scope.form.month+"/"+$scope.form.day+" "+$scope.form.hour+":"+$scope.form.minute;
		$scope.lastDay();
		$scope.$emit("updateDateModel");
	}
	
	$scope.$on("updateDateBox", function(e, data){
		angular.extend($scope.form, data);
		$scope.form.reserve_dt = $scope.form.year+"/"+$scope.form.month+"/"+$scope.form.day+" "+$scope.form.hour+":"+$scope.form.minute;
	});
	
	$scope.ok = function(){
		if($scope.rFrm.$invalid){
			if($scope.rFrm.$error.required){
				alert("필수값을 입력하여 주십시오.");
			}else{
				alert("값이 유효하지 않습니다.");
			}
			$("#rFrm .ng-invalid")[0].focus();
			return false;
		}
		if (!$scope.form.reserve_dt) {
			alert('예약 시간 선택후 등록가능합니다.');
			return;
		}
		dialogService.close("reserveDialog", {reserve_dt : $scope.form.reserve_dt, page_navi : $($scope.form.page_navi).text()});
	}
});


</script>
</head>
<body>
	<div class="titlebar">
		<h2>게시물 관리</h2>
		<div>
			&gt; 게시물 관리
		</div>
	</div>
	<div data-ng-controller="mainCtrl">
		<div data-ng-view data-ng-cloak></div>
	</div>
<script type="text/ng-template" id="articleMove.html">
<div data-ng-controller="moveCtrl" class="dialog" title="게시판 선택"  data-ng-cloak class="contents" data-ng-init="board.go(1)">
	<div class="fn_wrap" style="overflow:hidden; padding-bottom:0;">
		<form name="searchForm" id="searchForm" method="post" >
          <div class="fn_right">
				<select data-ng-model="board.param.condition" id="condition" class="normal" data-ng-init="board.param.condition = 'BOARD_NM'">
					<option value="BOARD_NM">게시판명</option>
				</select>
				<input type="text" data-ng-model="board.param.keyword" class="normal w150" style="font:13.3333px Arial;" />
				<span><input type="button" value="검색" data-ng-click="board.go(1);" class="btalls2" /></span>
          </div>
		</form>
        </div>
		<table class="type1">
			<colgroup>
		  		<col width="*" />
		  		<col width="15%" />
		  		<col width="10%" />
		  	</colgroup>
			<thead>
				<tr>
					<th class="center">게시판명</th>
					<th class="center">게시판타입</th>
					<th class="center">선택</th>
				</tr>
			</thead>
			<tbody id="boardWrap">
				<tr data-ng-if="board.list.length==0">
					<td colspan="3" class="center">결과가 없습니다.</td>
				</tr>
				<tr data-ng-repeat="item in board.list">
					<td>{{item.board_nm}}</td>
					<td class="center" data-ng-repeat="types in boardType" data-ng-if="types.board_type == item.board_type">{{types.name}}</td>
					<td class="center">
						<span><input type="button" value="선택" data-ng-click="boardSelect(item);" class="btalls"/></span>
					</td>
				</tr>
			</tbody>
		</table>
		<pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
	</div>
</script>
<script type="text/ng-template" id="articleCopy.html">
<div data-ng-controller="copyCtrl" class="dialog" title="게시판 선택"  data-ng-cloak class="contents" data-ng-init="board.go(1)">
	<div class="fn_wrap" style="overflow:hidden; padding-bottom:0;">
		<form name="searchForm" id="searchForm" method="post" >
	        <!-- <div class="fn_left">
				<select data-ng-model="param.all_yn" class="normal" data-ng-change="board.go(1);" data-ng-init="param.all_yn = 'BOARD_NM'">
					<option value="Y" >전체</option>
					<option value="N" >미사용 중인 게시판</option>					
				</select>
          </div> -->
          <div class="fn_right">
				<select data-ng-model="board.param.condition" id="condition" class="normal" data-ng-init="board.param.condition = 'BOARD_NM'">
					<option value="BOARD_NM">게시판명</option>
				</select>
				<input type="text" data-ng-model="board.param.keyword" class="normal w150" style="font:13.3333px Arial;" />
				<span><input type="button" value="검색" data-ng-click="board.go(1);" class="btalls2" /></span>
          </div>
		</form>
        </div>
		<table class="type1">
			<colgroup>
		  		<col width="*" />
		  		<col width="15%" />
		  		<col width="10%" />
		  	</colgroup>
			<thead>
				<tr>
					<th class="center">게시판명</th>
					<th class="center">게시판타입</th>
					<th class="center">선택</th>
				</tr>
			</thead>
			<tbody id="boardWrap">
				<tr data-ng-if="board.list.length==0">
					<td colspan="3" class="center">결과가 없습니다.</td>
				</tr>
				<tr data-ng-repeat="item in board.list">
					<td>{{item.board_nm}}</td>
					<td class="center" data-ng-repeat="types in boardType" data-ng-if="types.board_type == item.board_type">{{types.name}}</td>
					<td class="center">
						<span><input type="button" value="선택" data-ng-click="boardSelect(item);" class="btalls"/></span>
					</td>
				</tr>
			</tbody>
		</table>
		<pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
	</div>
</script>
<script type="text/ng-template" id="psn_filter.html">
<div id="dialog2" title="시스템 경고" data-ng-controller="dialogCtrl">
  <div class="system_warning_box">
    <p><img src="/images/super/system_pop_03.png" alt="경고 아이콘" /></p>
    <p class="system_warning_text_">
 등록하시려는 게시물의 본문에서<br/>
개인정보유출이 우려되는 내용이 <br/>
검출되었습니다.
    </p>
  </div>
  <h4 class="system_warning_h4_1">검출된 문자열</h4>
  <div class="system_warning_box2">
    <div class="system_warning_textarea2" style="height:150px;" ng-bind-html="model.filter"></div>
  </div>
  <p class="system_bot_bt">
    <input type="button" value="등록" class="system_warning_bt2" data-ng-click="save()" />
    <input type="button" value="닫기" class="system_warning_bt1" data-ng-click="close2()" />
  </p>
</div>
</script>
<script type="text/ng-template" id="cts_filter.html">
<div id="dialog2" title="시스템 경고" data-ng-controller="dialogCtrl">
  <div class="system_warning_box">
    <p><img src="/images/super/system_pop_03.png" alt="경고 아이콘" /></p>
    <p class="system_warning_text_">등록하시려는 게시물의 본문에서 <br/>
시스템 관리자가 지정한<br/>
욕설 및 비속어가 검출되었습니다.</p>
  </div>
  <h4 class="system_warning_h4_1">검출된 문자열</h4>
  <div class="system_warning_box2">
    <div class="system_warning_textarea2" style="height:150px;" ng-bind-html="model.filter"></div>
  </div>
  <p class="system_bot_bt">
    <input type="button" value="닫기" class="system_warning_bt1" data-ng-click="close1()" />
  </p>
</div>
</script>

<script type="text/ng-template" id="reserveTemplete.html">
	<div ng-controller="reserveCtrl" title="콘텐츠 예약배포 설정">
		<form id="rFrm" name="rFrm" method="post" novalidate="novalidate" data-ng-submit="ok()">
        <div>
	<div class="backup_temple back_margin" ng-bind-html="form.page_navi"></div>
		<div class="backup_temple2">
        <div>
          	<p>직접입력</p>
          	<div class="skj_box" style="overflow:hidden; text-align:left; border-bottom:none;">
          		<select class="normal" style="float:left;" title="년" id="tyear" data-ng-model="form.year" data-ng-options="item as item for item in [1950, 2050]|range:4" ng-change="changeDate()"></select>
            	<span style="float:left; margin:7px 0 0 3px;">년</span>
            	<select class="normal" style="float:left;" title="월" id="tmonth" data-ng-model="form.month" data-ng-options="item as item for item in [1, 12]|range:2" ng-change="changeDate()"></select>
          		<span style="float:left; margin:7px 0 0 3px;">월</span>
            	<select class="normal" style="float:left;" title="일" id="tday" data-ng-model="form.day" data-ng-options="item as item for item in [1, lastDay()]|range:2" ng-change="changeDate()"></select>
           		<span style="float:left; margin-top:7px;"> / </span>
            	<select class="normal" style="float:left;" title="시" id="thour" data-ng-model="form.hour" data-ng-options="item as item for item in [0, 23]|range:2" ng-change="changeDate()"></select>
          		<span style="float:left; margin:7px 0 0 3px;">시</span> 
            	<select class="normal" style="float:left;" title="분" id="tminute" data-ng-model="form.minute" data-ng-options="item as item for item in [0, 59]|range:2" ng-change="changeDate()"></select>
            	<span style="float:left; margin:7px 0 0 3px;">분</span>
        	</div>
        <div class="skj_box2">
          	<p>스케쥴러 선택</p>
        </div>
        <div class="skj_box3">
          	<input type="text" data-ng-model="form.reserve_dt" rsvdatetimepicker/>
        </div>
      </div>
    </div>
    <div class="btn_bottom">
		<div class="r_btn">
			<input type="button" value="등록" class="bt_big_bt4" data-ng-click="ok()"/>
		</div>
	</div>    
		</form>
	</div>
</script>
<script type="text/ng-template" id="catSelect.html">
	<div data-ng-controller="catSelectCtrl" class="dialog" title="카테고리 선택"  data-ng-cloak class="contents" data-ng-init="board.go(1)">
		<table class="type1">
			<colgroup>
		  		<col width="20%" />
		  		<col width="*" />
		  		<col width="20%" />
		  	</colgroup>
			<thead>
				<tr>
					<th class="center">번호</th>
					<th class="center">카테고리명</th>
					<th class="center">선택</th>
				</tr>
			</thead>
			<tbody id="boardWrap">
				<tr data-ng-if="catlist.length==0">
					<td colspan="3" class="center">결과가 없습니다.</td>
				</tr>
				<tr data-ng-repeat="item in catlist">
					<td>
						<label>
							{{$index+1}}
						</label>
					</td>
					<td class="center">{{item.cat_nm}}</td>
					<td class="left">
						<span><input type="button" value="선택" data-ng-click="catSelect(item);" class="btalls"/></span>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</script>
</body>
</html>