<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<c:set var="site_id" value="${empty cookie.adh_menu_current_siteid ? '1' : cookie.adh_menu_current_siteid.value }"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
.main_layout {width: 1100px; border: 1px dashed #CCC; position: relative;}
.main_layout>div {position:absolute; overflow:hidden; background:#ddd;}
.main_layout>div .ml_btn{float:right; margin:10px 10px 0 0;}
.main_layout>div .ml_btn a{display:inline-block; padding:2px 6px 1px 6px; font-size:12px; border:solid 1px #bbb;}
.main_layout>.ss-placeholder-child {background: transparent; border: 1px dashed blue;}
.ui-state-highlight{ width:100px; height:10px; }
</style>
<title>사이트 기본설정</title>
<script type="text/javascript" src="<c:url value="/lib/js/angular.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/angular-route.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/filters/myFilter.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/filters/ngRange.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/services/myCommon.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/services/dialog-service.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/myUtil.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/myPagination.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/route/routeResolver.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/myEditor.js"/>"></script>
<script type="text/javascript" src="${context_path }/lib/js/directives/sortable.js"></script>
<script type="text/javascript" src="/lib/js/jquery.shapeshift.js"></script>
<script type="text/javascript">
var app = angular.module("MyApp", ['routeResolverServices', 'dialogService', 'ngRoute', 'myUtil', 'myPagination', 'myCommon', 'myFilter', 'ngRange', 'myEditor', 'ui.sortable']);
app.directive('onFinishRender2', function ($timeout) {
	return {
        restrict: 'A',
        link: function (scope, elem, attrs) {
        	$timeout(function () {
        		var id = attrs['onFinishRender2'];
    			scope.$emit(id, scope.item);
        	}, 100);
        }
	}
})
app.directive("shapeshift", ["$timeout", function ($timeout, $compile, dialogService) {
	return {
		restrict: 'A',
		transclude: true,
		replace : true,
	    template :   '<div class="main_layout">'
	    			+'	<div class="module" data-ng-repeat="item in ngModel" uid="{{item.uid}}" data-ss-colspan="{{item.col}}" data-ss-rowspan="{{item.row}}" on-finish-render="load" on-finish-render2="load2">'
	    			+'		<div class="ml_btn"><a ng-click="modifyComponent($index);">수정</a> <a ng-click="removeComponent($index);">삭제</a></div>'
	    			+'		<div>{{item.title}}</div>'
	    			+'	</div>'
	    			+'</div>',
		scope:{
			ngModel : '=ngModel'
		},
		link: function (scope, elem, attrs, ctrls) {
			var box = 20;
			scope.$on("load", function(){
				elem.shapeshift({
					minColumns : 40,	
			        colWidth:box
				}).on("ss-drop-complete", function(e){
					elem.find(".module").each(function(i, o){
						var uid = $(this).attr("uid");
						$.each(scope.ngModel, function(j, obj){
							if(obj.uid == uid){
								scope.$apply(function(){
									obj.idx = i;
								});
								return false;
							}
						});
					});
					//저장시에 한번하고 넘길것
// 					scope.ngModel.sort(function(a,b){return a.idx-b.idx});
				});
			});
			scope.$on("load2", function(e){
				var idx = e.targetScope.$index;
				$(".module").eq(idx).resizable({
			    	maxWidth:1100,
				  	maxHeight:1100,
				  	minWidth:box,
				  	minHeight:box,
				  	create : function(e, ui){
				      	var colspan = $(this).attr("data-ss-colspan");
				      	var rowspan = $(this).attr("data-ss-rowspan");
				        $(this).css("width", (colspan*box)+((colspan-1)*10));
				        $(this).css("height", (rowspan*box)+((rowspan-1)*10));
				        scope.ngModel[idx].idx=idx;
				  	},
					resize : function(e, ui){
						var current_colspan = $(this).attr("data-ss-colspan");
						var current_rowspan = $(this).attr("data-ss-rowspan");
				      	var colspan = Math.round((ui.element.width()-((current_colspan-1)*10))/box);
				      	var rowspan = Math.round((ui.element.height()-((current_rowspan-1)*10))/box);
				      	$(this).attr("data-ss-colspan", colspan);        
				      	$(this).attr("data-ss-rowspan", rowspan);        
				        $(this).css("width", (colspan*box)+((colspan-1)*10));
				        $(this).css("height", (rowspan*box)+((rowspan-1)*10));
				        scope.$apply(function(){
					        scope.ngModel[idx].col=colspan;
					        scope.ngModel[idx].row=rowspan;
				        });
			      	},
					stop : function(e, ui){
						elem.trigger("ss-rearrange");
					}
			    });
			});
			
			scope.modifyComponent = function(idx){
				scope.$emit("modifyComponent", idx);
			}
			
			scope.removeComponent = function(idx){
				scope.ngModel.splice(idx, 1);
				$timeout(function(){
					elem.trigger("ss-rearrange");
				},100);
			}
			
			scope.comTypeName = function(com_type){
				if(com_type=="1"){
					return "html";
				}else{
					return "일반";
				}
			}
		}
	};
}]);

app.run(function($rootScope){
	$rootScope.param = {site_id : "${site_id}"};
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
	    .when('/modify', route.resolve("modify"))
		.otherwise({redirectTo: '/modify' });
}]);

app.controller("mainCtrl", function($scope, $location, ajaxService) {
});

app.controller("ComponentCtrl", function($scope, $window, ajaxService, dialogService) {
	$scope.form = {
			col:2, row:2,
			tab_yn : "N",
			modules : []
	};
	
	$.extend($scope.form, $scope.model);
	
	$scope.moduleSortable = {
		axis: 'x',
		placeholder: "ui-state-highlight"
	};
	
    $scope.openAddComponent = function(){
		var options = {
			autoOpen: false,
			modal: true,
			width: "1000",
			height: "650",
			close: function(event, ui) {}
		};
			
		dialogService.open("ComponentDetailDialog","ComponentDetail.html", {}, options).then(
			function(result) {
				$scope.addComponent(result);
			},
			function(error) {}
		);
	}
    
    $scope.addComponent = function(item){
   		$scope.form.modules.push(item);
    }
	
	$scope.removeComponent = function(idx){
		$scope.form.modules.splice(idx, 1);
	}
	
	$scope.ok = function(){
		if($scope.form.tab_yn=="Y"){
			if($scope.form.modules.length==0){
				alert("하나이상 모듈을 등록하셔야 합니다.");
				return false;
			}
		}else{
			if($scope.form.modules.length==0){
				alert("모듈을 등록하셔야 합니다.");
				return false;
			}else if($scope.form.modules.length>1){
				alert("모듈을 하나만 등록하셔야 합니다.");
				return false;
			}
		}
		var item = $scope.form;
		dialogService.close("ComponentDialog", item);
	}
	
	$scope.cancel = function(){
		dialogService.cancel("ComponentDialog");
	}
});

app.controller("ComponentDetailCtrl", function($scope, $window, ajaxService, dialogService) {
	$scope.module = {};
	
	$scope.onBoardPop = function(){
		var options = {
			autoOpen: false,
			modal: true,
			width: "600",
			height: "700",
			close: function(event, ui) {}
		};
			
		dialogService.open("adminBoardSelect","adminBoardSelect.html", {}, options).then(
			function(result) {
				$scope.module.board_nm = result.board_nm;
				$scope.module.board_seq = result.board_seq;
			},
			function(error) {}
		);
	}
	
	$scope.ok = function(){
		var item = $scope.module;
		dialogService.close("ComponentDetailDialog", item);
	}
	
	$scope.cancel = function(){
		dialogService.cancel("ComponentDetailDialog");
	}
});
app.controller("boardSelectCtrl", function($scope, $window, $routeParams, $compile, ajaxService, dialogService, $filter) {
	$scope.boardType = {};
	
	ajaxService.getSyncJSON('${context_path }/super/system/board/type_list.do', {}, function(data){
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
		dialogService.close("adminBoardSelect", item);		
	}
});
</script>
</head>
<body>
	<div class="titlebar">
		<h2>기본설정</h2>
		<div>
			<span>사이트설정</span>&gt;
			<span class="bar_tx">기본설정</span>
		</div>
	</div>
	<div data-ng-controller="mainCtrl">
		<div data-ng-view data-ng-cloak></div>
	</div>
	
<script type="text/ng-template" id="Component.html">
	<div ng-controller="ComponentCtrl" title="콤포넌트 편집" style="overflow:hidden; padding:15px;">
	<form id="fFrm" name="frm" method="post" novalidate="novalidate" enctype="multipart/form-data">
        <table class="type1" style="margin-top:20px;">
        	<colgroup>
        	  	<col width="100" />
        	  	<col width="*" />
        	</colgroup>
        	<tbody id="boardWrap">
        		<tr>
        			<th class="center">제목</th>
        			<td class="left">
        				<input type="text" class="bold" ng-model="form.title"/>
        			</td>
        		</tr>
        		<tr>
        			<th class="center">탭</th>
        			<td class="left">
						<ol class="select">
						<li class="first"><label><input type="radio" data-ng-model="form.tab_yn" value="Y"> 사용</label></li>
						<li><label><input type="radio" data-ng-model="form.tab_yn" value="N"> 사용안함</label></li>
						</ol>
        			</td>
        		</tr>
        		<tr>
        			<th class="center">모듈 선택</th>
        			<td class="left">
					    <div class="layout_g2">
					    	<span style="display:inline-block; float:left; margin:4px 7px 0 0; font-size:12px;">해당 콤포넌트에 추가될 모듈입니다.</span>
					        <input type="button" value="모듈 추가" class="btalls" data-ng-click="openAddComponent()">
					    </div>
					    <div class="layout_g1" ng-show="form.modules.length>0">
					        <span ui-sortable="moduleSortable" data-ng-model="form.modules">
					    		<span data-ng-repeat="item in form.modules" style="cursor: move">{{item.tab_title}}
					    			<a data-ng-click="removeComponent($index)"><img src="${context_path }/images/container/btn_del2_03.png" class="btn"></a>
					    		</span>
					        </span>
					    </div>
        			</td>
        		</tr>
        	</tbody>
        </table>
		<div class="btn_bottom">
			<div class="r_btn">
				<input type="button" value="저장" class="bt_big_bt4" data-ng-click="ok()">
				<input type="button" value="취소" class="bt_big_bt3" data-ng-click="cancel()">
			</div>
		</div>
	</form>
	</div>
</script>
	
<script type="text/ng-template" id="ComponentDetail.html">
	<div ng-controller="ComponentDetailCtrl" title="모듈추가" style="overflow:hidden; padding:15px;">
	<form id="fFrm" name="frm" method="post" novalidate="novalidate" enctype="multipart/form-data">
        <table class="type1" style="margin-top:20px;">
        	<colgroup>
        	  	<col width="100" />
        	  	<col width="*" />
        	</colgroup>
        	<tbody id="boardWrap">
        		<tr>
        			<th class="center">소제목</th>
        			<td class="left">
        				<input type="text" class="bold" ng-model="module.tab_title"/>
        			</td>
        		</tr>
        		<tr>
        			<th class="center">구분</th>
        			<td class="left">
						<ol class="select">
						<li class="first"><label><input type="radio" data-ng-model="module.com_type" value="1" ng-init="module.com_type='1'"> html</label></li>
						<li><label><input type="radio" data-ng-model="module.com_type" value="2"> 게시판</label></li>
						<li><label><input type="radio" data-ng-model="module.com_type" value="3"> 팝업존</label></li>
						</ol>
        			</td>
        		</tr>
        		<tr ng-if="module.com_type=='1'">
        			<th class="center">내용</th>
        			<td class="left">
        				<textarea ng-model="module.conts" global-editor ng-height="'300'"></textarea>
        			</td>
        		</tr>
			    <tr data-ng-if="module.com_type=='2'">
			    	<th rowspan="4" class="center">게시판 선택</th>
			    	<td>
			    		<input type="button" value="게시판 선택" class="btalls" data-ng-click="onBoardPop();">
			    	</td>
			    </tr>
			    <tr data-ng-if="module.com_type=='2'">
			    	<td class="left">{{module.board_nm}}</td>
			    </tr>
			    <tr data-ng-if="module.com_type=='2' && !!module.board_seq">
			    	<td class="left">
        				<input type="number" class="bold w75" ng-model="module.cnt" ng-init="module.cnt=5"/>건
					</td>
			    </tr>
			    <tr data-ng-if="module.com_type=='2' && !!module.board_seq">
			    	<td class="left">
        				<input type="text" class="bold w200" ng-model="module.link_url" placeholder="클릭시 이동할 페이지 URL입니다."/>
					</td>
			    </tr>
        	    </tbody>
        </table>
		<div class="btn_bottom">
			<div class="r_btn">
				<input type="button" value="등록" class="bt_big_bt4" data-ng-click="ok()">
				<input type="button" value="취소" class="bt_big_bt3" data-ng-click="cancel()">
			</div>
		</div>
	</form>
	</div>
</script>
<script type="text/ng-template" id="adminBoardSelect.html">
<div data-ng-controller="boardSelectCtrl" class="dialog" title="게시판 선택"  data-ng-cloak class="contents" data-ng-init="board.go(1)">
	<div class="fn_wrap" style="overflow:hidden; padding:10px 0 0 0;">
		<form name="searchForm" id="searchForm" method="post" >
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
				<th>검색어</th>
				<td>
					<input type="text" class="normal w175" style="width:100%;" data-ng-model="board.param.keyword" />
				</td>
			</tr>
			<tr>
				<th colspan="2" style="text-align:center; padding-left:0px; padding-right:0px;">
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
		</colgroup>
		<thead>
			<tr>
				<th class="center">게시판명</th>
				<th class="center">게시판타입</th>
				<th class="center">등록</th>
			</tr>
		</thead>
		<tbody id="boardWrap">
			<tr data-ng-if="board.list.length==0">
				<td colspan="4" class="center">결과가 없습니다.</td>
			</tr>
			<tr data-ng-repeat="item in board.list">
				<td>{{item.board_nm}}</td>
				<td class="center" data-ng-repeat="types in boardType" data-ng-if="types.board_type == item.board_type">{{types.name}}</td>
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