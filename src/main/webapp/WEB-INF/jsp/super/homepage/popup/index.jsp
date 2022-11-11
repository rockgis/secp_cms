<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>팝업관리 > 메인화면관리</title>
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
	$rootScope.param = {
		selecter : "1",
		site_id : "${param.site_id}"
	};
	$rootScope.main = {
		contextPath : "<c:url value="/"/>"=="/"?"":"<c:url value="/"/>".substring(0,"<c:url value="/"/>".length-1)
	};	
});

app.controller("mainCtrl", function($scope, $window, $routeParams, $compile, ajaxService, dialogService) {
	$scope.board = {};
	$scope.board.go = function(n){
		ajaxService.getJSON("<c:url value="/super/homepage/popup/list.do"/>", $scope.param, function(data){
			$scope.board.list = data.list;
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.pagination.totalcount;
			$scope.board.totalPage = data.pagination.totalpage;
		});
	};
	
	$scope.listDel = function(){
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
			ajaxService.getJSON("<c:url value="/super/homepage/popup/delete.do"/>", {jData : '{"popupzone_seq" : "'+del_seq+'"}'}, function(data){
				$scope.list();
			});
		}
	}
	
	$scope.Del = function(seq){
		del_seq = seq;
		if(confirm("삭제하시겠습니까?")){
			ajaxService.getJSON("<c:url value="/super/homepage/popup/delete.do"/>", {jData : '{"popupzone_seq" : "'+del_seq+'"}'}, function(data){
				$scope.list();
			});
		}
	}
	
	$scope.SortablList = function(){
		var options = {
				autoOpen: false,
				modal: true,
				width: "650",
				height: "600",
				close: function(event, ui) {
					$scope.board.go(1);
				}
			};
		dialogService.open("ListDialog","mainPopupList.html", angular.copy($scope.param), options)
		.then(
			function(result) {
			},
			function(error) {
			}
		);
	};
	
	$scope.write = function(){
		var options = {
				autoOpen: false,
				modal: true,
				width: "700",
				height: "500",
				close: function(event, ui) {
				}
			};
		dialogService.open("writeDialog","write.html", angular.copy($scope.param), options)
		.then(
			function(result) {
				$scope.board.go(1);
			},
			function(error) {
			}
		);
	};
	
	$scope.modify = function(item){
		var options = {
				autoOpen: false,
				modal: true,
				width: "700",
				height: "600",
				close: function(event, ui) {
					$scope.board.go(1);
				}
			};
		dialogService.open("modifyDialog","modify.html", {seq : item}, options)
		.then(
			function(result) {
				$scope.board.go(1);
			},
			function(error) {
			}
		);
	};
});

app.controller("writeCtrl", function($scope, $window, $routeParams, $rootScope, ajaxService, dialogService) {
	$scope.form = {
		selecter : $rootScope.param.selecter,
		site_id : $rootScope.param.site_id,
		files : []
	};
	
	$scope.uploadFile = function(){
		var filename = $("#file").val();
		filename = filename.slice(filename.indexOf(".") + 1).toLowerCase();
		if(filename == ""){
			return false;
		}
		if($.inArray(filename, ["gif", "jpg", "jpeg", "png", "bmp"]) < 0 ){
			alert("gif, jpg, jpeg, png, bmp 파일만 올려주시기 바랍니다.");
			return false;
		}
    	$("#wFrm").ajaxSubmit({
    		url : '<c:url value="/ajaxUpload.do"/>',
    		iframe: true,
    		dataType : "json",
    		uploadProgress : function(event, position, total, percentComplete){
    		},
    		success : function(data){
    			$scope.addFile(data);
    		},
    		error: function(e){
    			alert(e.responseText);
    		}
    	});
	}
	
	$scope.addFile = function(data){
		$scope.$apply(function(){
			$scope.form.files[0] = data;
		});
	}

	$scope.dt_bt = function(){
		if($scope.form.dt_bt == 'Y'){
			$scope.form.start_dt = '2016-01-01';
			$scope.form.end_dt = '2099-12-31';
		}else{
			$scope.form.start_dt = '';
			$scope.form.end_dt = '';
		}
	}
	
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
		ajaxService.getJSON("<c:url value="/super/homepage/popup/insert.do"/>", {jData : angular.toJson($scope.form)}, function(data){
			alert("등록이 완료되었습니다.");
			dialogService.close("writeDialog");
		});
	}
	
	$scope.close = function(){
		dialogService.close("writeDialog");
	}
});


app.controller("modifyCtrl", function($scope, $window, $routeParams, ajaxService, dialogService) {
	$scope.form = {
			files : []
	};
	
	ajaxService.getJSON("<c:url value="/super/homepage/popup/view.do"/>", {popupzone_seq : $scope.model.seq}, function(data){
		$scope.form = data.view;
		$scope.form.files = data.files;
		$scope.form.removeFiles = [];
		if(data.view["start_dt"] == "2016-01-01" && data.view["end_dt"] == "2099-12-31"){
			$scope.form.dt_bt = 'Y';
		}else{
			$scope.form.dt_bt = 'N';
		}
	});
	
	$scope.addFile = function(data){
		$scope.$apply(function(){
			$scope.form.files[0] = data;
		});
	}
	
	$scope.dt_bt = function(){
		if($scope.form.dt_bt == 'Y'){
			$scope.form.start_dt = '2016-01-01';
			$scope.form.end_dt = '2099-12-31';
		}else{
			$scope.form.start_dt = '';
			$scope.form.end_dt = '';
		}
	}
	
	$scope.uploadFile = function(){
		var filename = $("#file").val();
		filename = filename.slice(filename.indexOf(".") + 1).toLowerCase();
		if(filename == ""){
			return false;
		}
		if($.inArray(filename, ["gif", "jpg", "jpeg", "png", "bmp"]) < 0 ){
			alert("gif, jpg, jpeg, png, bmp 파일만 올려주시기 바랍니다.");
			return false;
		}
    	$("#wFrm").ajaxSubmit({
    		url : '<c:url value="/ajaxUpload.do"/>',
    		iframe: true,
    		dataType : "json",
    		uploadProgress : function(event, position, total, percentComplete){
    		},
    		success : function(data){
    			$scope.addFile(data);
    		},
    		error: function(e){
    			alert(e.responseText);
    		}
    	});
	}
	
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
		ajaxService.getJSON("<c:url value="/super/homepage/popup/modify.do"/>", {jData : angular.toJson($scope.form)}, function(data){
			alert("수정이 완료되었습니다.");
			dialogService.close("modifyDialog");
		});
	}
	
	$scope.del = function(){
		if(confirm("삭제하시겠습니까?")){
			ajaxService.getJSON("<c:url value="/super/homepage/popup/delete.do"/>", {jData : angular.toJson($scope.form)}, function(data){
				alert("삭제가 완료되었습니다.");
				dialogService.close("modifyDialog");
			});
		}
	}
	
	$scope.close = function(){
		dialogService.close("modifyDialog");
	}
});

app.controller('popupListCtrl', function($scope, ajaxService, dialogService) {
	$scope.model.rows = '999999';	
	$scope.list = {};
	$scope.getList = function(){
		ajaxService.getJSON("<c:url value="/super/homepage/popup/list.do"/>", $scope.model, function(data){
			$scope.list = data.list;
			$scope.list.totalCount = data.pagination.totalcount;
		});
	};
	
	
	
	$scope.sortableOptions = {
		realign : false,
		axis: 'y',
		placeholder: "ui-state-highlight",
		update: function(e, ui) {
			this.realign = true;
		},
		stop : function(e, ui){
			$scope.list = $.map($scope.list, function(item, i){
				item.order_seq = i+1;
				return item;
			});
		}
    };
	
	$scope.save = function(){
		$scope.list = $.map($scope.list, function(item, i){
			item.order_seq = i+1;
			return item;
		});
		ajaxService.getJSON("<c:url value="/super/homepage/popup/sort.do"/>", {jData : angular.toJson({list : $scope.list})}, function(data){
			if(data.rst == '1'){
  				alert("정상 처리 되었습니다.");
  				dialogService.close("ListDialog");
  			}
		});
	}
	
	$scope.close = function(){
		dialogService.close("ListDialog");
	}
});
</script>
</head>
<body>
	<div class="titlebar">
		<h2>팝업관리</h2>
		<div>
			<span>사이트관리</span>&gt;
			<span class="bar_tx">팝업관리 > 일반팝업관리</span>
		</div>
	</div>
	<div data-ng-controller="mainCtrl" data-ng-init="board.go(1)" >
	<div class="contents" data-ng-cloak>
    <form name="searchFrm" method="post" data-ng-submit="board.go(1)">
      <div class="l_btn">
          <span class="bt_all"><span><input type="button" value="메인이미지" class="btall" data-ng-click="param.selecter = 1;board.go(1);"/></span></span>
		  <span class="bt_all"><span><input type="button" value="팝업존" class="btall" data-ng-click="param.selecter = 2;board.go(1);"/></span></span>
		  <span class="bt_all"><span><input type="button" value="하단롤링" class="btall" data-ng-click="param.selecter = 3;board.go(1);"/></span></span>
		  <span class="bt_all"><span><input type="button" value="레이어팝업" class="btall" data-ng-click="param.selecter = 10;board.go(1);"/></span></span>
      </div>
      <div class="btn_bottom">
        <div class="top_list1">
          <span class="board_listing">총 <span>{{board.totalCount|number}}</span> 건</span> / 
          <select title="건별보기 선택" data-ng-model="param.rows" data-ng-init="param.rows='10'" data-ng-change="board.go(1)">
            <option value="10">10건씩보기</option>
            <option value="15">15건씩보기</option>
            <option value="20">20건씩보기</option>
          </select>
        </div>
        <div class="top_list2">
          <select title="공지사항 검색조건 선택" data-ng-model="param.condition" data-ng-init="param.condition='title'">
            <option value="title">제목</option>
          </select> 
          <input type="text" class="input_1" data-ng-model="param.keyword"/>
          <span><a data-ng-click="board.go(1)"><img src="<c:url value="/images/super/contents/s_btn_search.gif"/>" alt="검색" /></a></span>
        </div>
        
      </div>
    </form>
      <table class="style_3" id="boardList">
         <colgroup>
          <col width="5%" />
          <col width="5%" />
          <col width="*" />
          <col width="10%" />
          <col width="10%" />
          <col width="6%" />
          <col width="6%" />
          <col width="6%" />
          <col width="6%" />
        </colgroup>
        <tr>
          <th>선택</th>
          <th>번호</th>
          <th>제목</th>
          <th>시작일</th>
          <th>종료일</th>
          <th>사용여부</th>
          <th>순서</th>
          <th>삭제</th>
        </tr>
        <tr data-ng-if="board.list.length==0"><td colspan="8">결과가 없습니다.</td></tr>
        <tr data-ng-repeat="item in board.list">
          <td><input type="checkbox" value="{{item.popupzone_seq}}"/></td>
          <td>{{(board.totalCount|num) + 1 - (item.rn|num)}}</td>
          <td class="left" style="color:#2c7bca "><a href="javascript:void(0);" data-ng-click="modify(item.popupzone_seq)"><img data-ng-src="{{main.contextPath+item.file_path}}" alt="{{item.alt}}" style="width:125px;height:60px;"/>&nbsp;&nbsp;{{item.title}}</a></td>
          <td>{{item.start_dt|myDate:'yyyy/MM/dd'}}</td>
          <td>{{item.end_dt|myDate:'yyyy/MM/dd'}}</td>
          <td>{{item.use_yn == 'Y' ? '사용' : '미사용'}}</td>
          <td>{{item.order_seq}}</td>
          <td><input type="button" value="삭제" data-ng-click="Del(item.popupzone_seq)" class="bt_small_bt7"/></td>
        </tr>
      </table>
      <pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
       <div class="btn_bottom">
        <div class="r_btn">
         <input type="button" value="등록" class="bt_big_bt10" data-ng-click="write()"/>
         <input type="button" value="정렬하기" class="bt_big_bt6" data-ng-click="SortablList()"/>
         <input type="button" value="선택삭제" class="bt_big_bt15" data-ng-click="listDel()"/>
        </div>
      </div>
    </div>
</div>
<script type="text/ng-template" id="write.html">
<div class="contents" ng-controller="writeCtrl" data-ng-cloak title="팝업 등록">
    <form id="wFrm" name="frm" method="post" novalidate="novalidate" enctype="multipart/form-data">
      <table class="type1">
        <colgroup>
          <col width="20%" />
          <col width="*" />
        </colgroup>
        <tr>
          <th>제목</th>
          <td><input type="text" class="input_1" style="width:98%" data-ng-model="form.title" required/></td>
        </tr>
        <tr>
          <th>링크사용</th>
          <td>
			<label><input type="radio" data-ng-model="form.link_yn" value="Y" data-ng-init="form.link_yn = 'Y'"/><span>사용</span></label>
            <label><input type="radio" data-ng-model="form.link_yn" value="N" /><span>사용안함</span></label>
            <label><input type="checkbox" data-ng-model="form.link_target" ng-true-value="'_blank'" ng-false-value="'_self'" data-ng-init="form.link_target = '_self'"/><span>새창으로 열림</span></label>
          </td>
        </tr>
        <tr>
          <th>링크 URL</th>
          <td><input type="text" class="input_1" data-ng-model="form.link_url" style="width: 98%;" data-ng-required="form.link_yn == 'Y'" placeholder=" URL 입력 ex) http://abcd.com"/></td>
        </tr>
        <tr>
          <th>
			이미지 <br/>
			<a href="https://pixlr.com/editor/" target="_blank"><img src="/images/super/img_modify_03.png" alt="이미지 편집기" /></a>
		  </th>
		  <td>
	        <div style="margin:10px 0 10px 0;"><img data-ng-if="!!form.files[0].uuid" data-ng-src="<c:url value="/upload/temp/"/>{{form.files[0].uuid}}" alt="사진" style="width:250px; height:120px;"/></div>
	        <input type="file" name="file" id="file" onchange="angular.element(this).scope().uploadFile()"/>
		  </td>
        </tr>
        <tr>
          <th>이미지설명</th>
          <td><input type="text" class="input_1" data-ng-model="form.alt" style="width:98%;" required/></td>
        </tr>
		<tr data-ng-if="form.selecter == '10'">
          <th>레이어 위치</th>
          <td>
          	TOP : <input type="text" class="input_1" data-ng-model="form.y_coord" style="width:35px;" required/> px &nbsp;&nbsp; / &nbsp;&nbsp; LEFT : <input type="text" class="input_1" data-ng-model="form.x_coord" style="width:35px;" required/> px
          </td>
        </tr>
        <tr>
          <th>기간</th>
          <td>
		  	<label><input type="radio" data-ng-model="form.dt_bt" value="Y" data-ng-change="dt_bt();" data-ng-init="form.dt_bt='N'"/>항상</label>
		  	<label><input type="radio" data-ng-model="form.dt_bt" value="N" data-ng-change="dt_bt();"/>기간설정</label>
			<input type="text" class="input_1 date" style="width:80px;position:relative;z-index:100000;" data-ng-model="form.start_dt" datetimepicker date_max_model="form.end_dt" required /> ~ <input type="text" class="input_1 date" style="width:80px;position:relative;z-index:100000;" data-ng-model="form.end_dt" datetimepicker date_min_model="form.start_dt" required/></td>
        </tr>
        <tr>
          <th>사용여부</th>
          <td>
            <label>
              <input type="radio" data-ng-model="form.use_yn" value="Y" data-ng-init="form.use_yn = 'Y'" /><span>사용</span>  
            </label>
            <label>
              <input type="radio" data-ng-model="form.use_yn" value="N" /><span>사용안함</span>  
            </label>
          </td>
        </tr>
      </table>
	   <div class="btn_bottom">
        <div class="r_btn">
          <input type="button" value="등록" class="bt_big_bt10" data-ng-click="save()"/>
          <input type="button" value="취소" class="bt_big_bt3" data-ng-click="close()"/>
        </div>
      </div>
	</form>      
    </div>
</script>	
<script type="text/ng-template" id="modify.html">
<div class="contents" ng-controller="modifyCtrl" data-ng-cloak title="팝업 수정">
    <form id="wFrm" name="frm" method="post" novalidate="novalidate" enctype="multipart/form-data">
      <table class="type1">
        <colgroup>
          <col width="20%" />
          <col width="*" />
        </colgroup>
        <tr>
          <th>제목</th>
          <td><input type="text" class="input_1" style="width:98%" data-ng-model="form.title" required/></td>
        </tr>
        <tr>
          <th>링크사용</th>
          <td>
			<label><input type="radio" data-ng-model="form.link_yn" value="Y" data-ng-init="form.link_yn = 'Y'"/><span>사용</span></label>
            <label><input type="radio" data-ng-model="form.link_yn" value="N" /><span>사용안함</span></label>
            <label><input type="checkbox" data-ng-model="form.link_target" ng-true-value="'_blank'" ng-false-value="'_self'"/><span>새창으로 열림</span></label>
          </td>
        </tr>
		<tr>
          <th>링크 URL</th>
          <td><input type="text" class="input_1" data-ng-model="form.link_url" style="width: 98%;" data-ng-required="form.link_yn == 'Y'" placeholder=" URL 입력 ex) http://abcd.com"/></td>
        </tr>
		<tr>
		  <th>
			이미지 <br/>
			<a href="https://pixlr.com/editor/" target="_blank"><img src="/images/super/img_modify_03.png" alt="이미지 편집기" /></a>
		  </th>
		  <td>
	        <div style="margin:10px 0 10px 0;">
				<img data-ng-src="{{main.contextPath+form.file_path}}" alt="사진" style="width:250px; height:120px;" data-ng-show="form.files == ''"/>
				<img data-ng-src="<c:url value="/upload/temp/"/>{{form.files[0].uuid}}" alt="사진" style="width:250px;height:120px;" data-ng-show="form.files != ''"/>
			</div>
	        <input type="file" name="file" id="file" onchange="angular.element(this).scope().uploadFile()"/>
		  </td>
		</tr>
        <tr>
          <th>이미지설명</th>
          <td><input type="text" class="input_1" data-ng-model="form.alt" style="width: 98%;" required/></td>
        </tr>
		<tr data-ng-if="form.selecter == '10'">
          <th>레이어 위치</th>
          <td>
          	TOP : <input type="text" class="input_1" data-ng-model="form.y_coord" style="width:35px;" required/> px &nbsp;&nbsp; / &nbsp;&nbsp; LEFT : <input type="text" class="input_1" data-ng-model="form.x_coord" style="width:35px;" required/> px
          </td>
        </tr>
        <tr>
          <th>기간</th>
          <td>
		  	<label><input type="radio" data-ng-model="form.dt_bt" value="Y" data-ng-change="dt_bt();"/>항상</label>
		  	<label><input type="radio" data-ng-model="form.dt_bt" value="N" data-ng-change="dt_bt();"/>기간설정</label>
			<input type="text" class="input_1 date" style="width:80px;position:relative;z-index:100000;" data-ng-model="form.start_dt" datepicker required/> ~ <input type="text" class="input_1 date" style="width:80px;position:relative;z-index:100000;" data-ng-model="form.end_dt" datepicker required/></td>
        </tr>
        <tr>
          <th>사용여부</th>
          <td>
            <label>
              <input type="radio" data-ng-model="form.use_yn" value="Y" /><span>사용</span>  
            </label>
            <label>
              <input type="radio" data-ng-model="form.use_yn" value="N" /><span>사용안함</span>  
            </label>
          </td>
        </tr>
      </table>
	   <div class="btn_bottom">
        <div class="r_btn">
         <input type="button" value="수정" class="bt_big_bt4" data-ng-click="save()"/>
         <input type="button" value="삭제" class="bt_big_bt2" data-ng-click="del()"/>
         <input type="button" value="취소" class="bt_big_bt3" data-ng-click="close()"/>
        </div>
      </div>
	</form>      
    </div>
</script>
<script type="text/ng-template" id="mainPopupList.html">
	<div ng-controller="popupListCtrl" data-ng-init="getList()" title="팝업 순서 목록">
		<table class="style_2">
		  <col width="80" />
		  <col width="120" />
		  <col width="*" />
		  <col width="50" />
		  <col width="80" />
			<thead>
				<tr>
					<th class="center">번호</th>
					<th class="center">이미지</th>
					<th class="center">제목</th>
					<th class="center">사용여부</th>
					<th class="center">순서</th>
				</tr>
			</thead>
			<tbody ui-sortable="sortableOptions" ng-model="list">
				<tr data-ng-if="list.length==0"><td colspan="8">결과가 없습니다.</td></tr>
				<tr data-ng-repeat="item in list">
					<td class="center">{{(list.length - $index)}}</td>
					<td class="center"><img data-ng-src="{{item.file_path}}" alt="{{item.alt}}" style="width:125px;height:60px;"/></td>
					<td>{{item.title}}</td>
					<td class="center">{{item.use_yn}}</td>
					<td class="center">{{item.order_seq}}</td>
				</tr>
			</tbody>
		</table>
		<div class="btn_bottom">
			<div class="r_btn">
<input type="button" value="저장" class="bt_big_bt11" data-ng-click="save()"/>
<input type="button" value="취소" class="bt_big_bt3" data-ng-click="close()"/>
			</div>
		</div>
	</div>
</script>
</body>
</html>
