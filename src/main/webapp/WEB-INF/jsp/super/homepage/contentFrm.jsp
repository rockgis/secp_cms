<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf" %>
<c:set var="site_id" value="${empty cookie.adh_menu_current_siteid ? '1' : cookie.adh_menu_current_siteid.value }"/>
<!DOCTYPE html>
<html>
<head>
<title>홈페이지 메뉴관리</title>
<script type="text/javascript" src="${context_path }/lib/js/angular.min.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/angular-route.min.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/angular-sanitize.min.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/filters/myFilter.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/filters/ngRange.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/services/myCommon.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/services/dialog-service.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/directives/myUtil.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/directives/myPagination.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/directives/sortable.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/directives/myEditor.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/html2canvas.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/jquery.blockUI.js"></script>
<script type="text/javascript">
var contextPath = "<c:url value='/'/>".replace(/\/$/, "");
</script>

<script type="text/javascript">
var app=angular.module("MyApp", ['dialogService', 'ngRoute', 'myUtil', 'myPagination', 'myCommon', 'ui.sortable', 'myFilter', 'myEditor', 'ngRange', 'ngSanitize']);
app.config(function($provide){
	//datetimepicker 오버라이드
// 	$provide.decorator('datetimepickerDirective', ['$delegate', function($delegate) {
//         $delegate.shift();
//         return $delegate;
//     }]);
});
app.directive("datetimepicker2", function ($timeout) {
	return {
		scope: false,
		restrict: 'A',
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
}).directive('tagnames', function() {
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
app.run(function($rootScope, $timeout){
	$rootScope.param={
		cms_menu_seq : "${param.cms_menu_seq}",
		parent_menu_seq : "${param.parent_menu_seq}",
		menu_level : "${param.menu_level}"
	};
});
app.controller("modifyCtrl", function($scope, $window, $compile, ajaxService, dialogService, $filter, $timeout) {
	
	ajaxService.getSyncJSON("${context_path }/super/homepage/view.do", $scope.param, function(data){
		$scope.form = data.view;
		if($scope.form.temp_conts != undefined && $scope.form.temp_conts != ""){
			$timeout(function(){
				if(confirm("임시저장된 내용을 불러올까요?")){
					$scope.form.conts = $scope.form.temp_conts;
				}
			},500);
		}
	});
	
	$scope.save = function(){
		if(!confirm('내용을 저장하시겠습니까?')){
			return false;
		}
		if($scope.frm.$invalid){
			if($scope.frm.$error.required){
				alert("필수값을 입력하여 주십시오.");
			}else{
				alert("값이 유효하지 않습니다.");
			}
			$("#wFrm .ng-invalid")[0].focus();
			return false;
		}
		if($scope.form.reserve == "Y"){
			var cform = {
					site_id : $scope.form.site_id,
					cms_menu_seq : $scope.form.cms_menu_seq
					, conts : $scope.form.conts
					, reserve_dt : $scope.form.reserve_dt
					, reserve_title : $scope.form.reserve_title
				};
			ajaxService.getJSON("${context_path }/super/reserve/modify_reserve.do", {jData : angular.toJson(cform)}, function(data){
				alert("예약이 완료되었습니다.");
			});
		}else{
			ajaxService.getJSON("${context_path }/super/homepage/contentSave.do", {jData : angular.toJson($scope.form)}, function(data){
				alert("저장이 완료되었습니다.");
			});
		}
	}
	
	//예약저장
	$scope.reserve = function(){
		var options = {
				autoOpen: false,
				modal: true,
				width: "461",
				height: "540",
				close: function(event, ui) {
				}
			};
		
		dialogService.open("reserveDialog", "reserveTemplete.html", {}, options)
		.then(
			function(result) {
				$scope.form.reserve_dt = result.reserve_dt;
				$scope.form.reserve_title = result.page_navi;
				$scope.form.reserve = "Y";
				$scope.save();
			},
			function(error) {
			}
		);
	}
	
	//임시저장
	$scope.temp_save = function(){
		$.blockUI({
			css: { 
	            border: 'none', 
	            padding: '15px', 
	            backgroundColor: '#000', 
	            '-webkit-border-radius': '10px', 
	            '-moz-border-radius': '10px', 
	            opacity: .5, 
	            color: '#fff' 
        	},
        	message : '임시저장'
		});
		ajaxService.getJSON("${context_path }/super/homepage/temp_save.do", {jData : angular.toJson($scope.form)}, function(data){
			$timeout($.unblockUI,500);
		});
	}
	
	$scope.$on("load", function(e, data){
		$scope.form.conts = data;
	});
	
	$scope.validUrl = function(url){
		url = url.replace(/\?/g, "&");
		url = url.replace("&", "?");
		return "${context_path }"+url;
	}
});

app.controller("backupCtrl", function($scope, $window, $compile, ajaxService, dialogService, $filter) {
	$scope.form={};
	$scope.board = {
		param : {
			cms_menu_seq : $scope.param.cms_menu_seq
		}
	};
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
	$scope.board.go = function(n){
		$scope.board.param.cpage=n;
		ajaxService.getJSON('${context_path }/super/homepage/content_backup_list.do?rows=5&cpage='+n, $scope.board.param, function(data){
			$scope.board.list = data.list;
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.pagination.totalcount;
			$scope.board.totalPage = data.pagination.totalpage;
		});
	};
	$scope.board.go(1);
	
	$scope.goHistory = function(idx){
		$scope.$emit("load", $scope.board.list[idx].conts);
	}
});

app.controller("reserveCtrl", function($scope, ajaxService, dialogService, $timeout, $filter) {
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
// 		$scope.lastDay();
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
	<h2>${view.title }</h2>
	<div>&gt;<span class="bar_tx">콘텐츠관리</span></div>
</div>
<div class="contents_wrap" data-ng-controller="modifyCtrl" data-ng-cloak>
	<div class="ct_wrap">
		<div class="conwrap_tap">
			<ul>
				<c:if test="${param.permit=='Y' }">
				<li><a href="${context_path }/super/homepage/modifyFrm.do?cms_menu_seq={{param.cms_menu_seq}}&amp;parent_menu_seq={{param.parent_menu_seq }}&amp;permit=${param.permit}"><span>메뉴관리</span></a></li>
				</c:if>
				<li class="on"><a href="#"><span>콘텐츠관리</span></a></li>
				<li data-ng-if="form.menu_type == '2'"><a href="${context_path }/super/homepage/bbs/index.do?cms_menu_seq={{form.cms_menu_seq}}&amp;parent_menu_seq={{form.parent_menu_seq}}&permit=${param.permit}"><span>게시판관리</span></a></li>
				<li data-ng-if="form.menu_type == '3' && !!form.manage_url">
					<a data-ng-if="form.inner_yn=='Y'" href="{{validUrl(form.manage_url + '&cms_menu_seq=' + form.cms_menu_seq+ '&parent_menu_seq=' + form.parent_menu_seq+ '&menu_level=' + form.menu_level+'&permit=${param.permit}')}}"><span>프로그램관리</span></a>
					<a data-ng-if="form.inner_yn=='N'" href="{{form.manage_url}}"><span>프로그램관리</span></a>
				</li>
		   	</ul>
		</div>
	    <div class="contents">
		<form id="wFrm" name="frm" method="post" novalidate="novalidate">
	    <table class="type1" style="margin-top:0;">
	    	<colgroup>
	    		<col width="200px" />
	    		<col width="*" />
	    	</colgroup>
	   		<caption></caption>
			<tr data-ng-show="form.menu_type=='1' || form.menu_type=='2' || form.menu_type=='3' || form.child_type=='2'">
				<th>콘텐츠 내용<br /><br />
				   <a ng-show="!!form.temp_conts"  data-ng-click="form.conts=form.temp_conts">
				        <img src="/images/container/cms_menu_b1_06.png" alt="임시저장" />
				   </a>
				</th>
				<td><textarea data-ng-model="form.conts" global-editor ng-height="'500px'"></textarea>
				</td>
			</tr>
			<tr>
				<th>CCL</th>
				<td>
					<ol class="select ccl_nuri">
						<li><label><input type="radio" data-ng-model="form.ccl_type" value="" ng-init="form.ccl_type=(form.ccl_type||'')"/><span alt="" style="display:block; padding:6px 33px; color:#fff; background:#abb1aa; border-radius:3px; border:solid 1px #999;">없 음</span></label></li>
						<li><label><input type="radio" data-ng-model="form.ccl_type" value="1" /><img src="/images/container/ccl_1.png" alt="" style="display:block;" /></label></li>
						<li><label><input type="radio" data-ng-model="form.ccl_type" value="2" /><img src="/images/container/ccl_2.png" alt="" style="display:block;" /></label></li>
						<li><label><input type="radio" data-ng-model="form.ccl_type" value="3" /><img src="/images/container/ccl_3.png" alt="" style="display:block;" /></label></li>
						<li><label><input type="radio" data-ng-model="form.ccl_type" value="4" /><img src="/images/container/ccl_4.png" alt="" style="display:block;" /></label></li>
						<li><label><input type="radio" data-ng-model="form.ccl_type" value="5" /><img src="/images/container/ccl_5.png" alt="" style="display:block;" /></label></li>
						<li><label><input type="radio" data-ng-model="form.ccl_type" value="6" /><img src="/images/container/ccl_6.png" alt="" style="display:block;" /></label></li>
					</ol>
					<div style="margin-top:5px; color:#ff7a1a; font-family:'NanumBarunGothicB';">
						<div ng-show="form.ccl_type==''">라이선스를 적용하지 않습니다.</div>
						<div ng-show="form.ccl_type=='1'">저작자표시 4.0 국제</div>
						<div ng-show="form.ccl_type=='2'">저작자표시-변경금지 4.0 국제</div>
						<div ng-show="form.ccl_type=='3'">저작자표시-동일조건변경허락 4.0 국제</div>
						<div ng-show="form.ccl_type=='4'">저작자표시-비영리 4.0 국제</div>
						<div ng-show="form.ccl_type=='5'">저작자표시-비영리-변경금지 4.0 국제</div>
						<div ng-show="form.ccl_type=='6'">저작자표시-비영리-동일조건변경허락 4.0 국제</div>
					</div>
				</td>
			</tr>
			<tr>
				<th>공공누리</th>
				<td>
					<ol class="select ccl_nuri">
						<li><label><input type="radio" data-ng-model="form.nuri_type" value="" ng-init="form.nuri_type=(form.nuri_type||'')"/><span alt="" style="display:block; padding:6px 33px; color:#fff; background:#abb1aa; border-radius:3px; border:solid 1px #999;">없 음</span></label></li>
						<li><label><input type="radio" data-ng-model="form.nuri_type" value="1" /><img src="/images/container/nuri_1.png" alt="" style="display:block;" /></label></li>
						<li><label><input type="radio" data-ng-model="form.nuri_type" value="2" /><img src="/images/container/nuri_2.png" alt="" style="display:block;" /></label></li>
						<li><label><input type="radio" data-ng-model="form.nuri_type" value="3" /><img src="/images/container/nuri_3.png" alt="" style="display:block;" /></label></li>
						<li><label><input type="radio" data-ng-model="form.nuri_type" value="4" /><img src="/images/container/nuri_4.png" alt="" style="display:block;" /></label></li>
					</ol>
					<div style="margin-top:5px; color:#ff7a1a; font-family:'NanumBarunGothicB';">
						<div ng-show="form.nuri_type==''">라이선스를 적용하지 않습니다.</div>
						<div ng-show="form.nuri_type=='1'">출처표시 / 상업적, 비상업적 이용가능 / 변형 등 2차적 저작물 작성 가능</div>
						<div ng-show="form.nuri_type=='2'">출처표시 / 비상업적 이용만 가능 / 변형 등 2차적 저작물 작성 가능</div>
						<div ng-show="form.nuri_type=='3'">출처표시 / 상업적, 비상업적 이용가능 / 변형 등 2차적 저작물 작성금지</div>
						<div ng-show="form.nuri_type=='4'">출처표시 / 비상업적 이용만 가능 / 변형 등 2차적 저작물 작성 금지</div>
					</div>
				</td>
			</tr>
			<tr>
				<th>태그</th>
				<td>
					<input type="text" class="normal" style="width:100%;" ng-model="form.tag_names" tagnames/>
					<p style="margin-top:5px;color:#555; letter-spacing:-1px;">※ 태그 작성시 , 로 구분 해야 합니다.</p>
				</td>
			</tr>
	    </table>
	    
	    <div class="btn_bottom">
	    	<div class="r_btn">
				<!-- <span class="bt_all">
					<span><input type="button" value="미리보기" class="btall" data-ng-click="preview()"/></span>
				</span> -->
				<input type="button" value="임시저장" class="bt_big_bt2" data-ng-click="temp_save()"/>
				<input type="button" value="예약배포" class="bt_big_bt2" data-ng-click="reserve()"/>
				<input type="button" value="저장" class="bt_big_bt4" data-ng-click="save()"/>
	        </div>
	    </div>
	    
		</form>
	    </div> 
	    <script type="text/javascript">
			$(document).ready(function(){
				var topBar = $(".titlebar").offset();
				$(window).scroll(function(){
					var docScrollY = $(document).scrollTop()
					var barThis = $("#topBar")
		
					if( docScrollY > topBar.top ) {
						barThis.addClass("top_bar_fix");
					}else{
						barThis.removeClass("top_bar_fix");
					}
				});
			})
		</script>
		
	</div>
    
    <div id="topBar">
    	<div class="topBar_inner">
			<div class="history" data-ng-controller="backupCtrl" data-ng-init="board.go(1)">
				<dl id="history_dl">
					<dt>콘텐츠 수정이력</dt>
					<dd data-ng-if="board.list.length==0" style="margin-left:15px;">수정이력이 없습니다.</dd>
					<dd data-ng-repeat="item in board.list">
						<a>
							<span class="history_1">{{item.cmod_dt|myDate:'yyyy-MM-dd HH:mm'}}</span>
							<span class="history_2">{{item.cmod_nm}}</span>
							<span class="history_btn" ng-click="goHistory($index)">복원</span>
						</a>
					</dd>
				</dl>
				<pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)" ng-mode="mini"></pagination>
			</div>
			<bookmark userid="${sessionScope.cms_member.member_id }"></bookmark>
	    </div>
		<span class="optBtn"><a href="javascript:void(0)"><img src="/images/cms/opt_close.gif" alt=""></a></span>
    </div>
</div>
<script type="text/ng-template" id="reserveTemplete.html">
	<div ng-controller="reserveCtrl" title="콘텐츠 예약배포 설정">
		<form id="rFrm" name="rFrm" method="post" novalidate="novalidate" data-ng-submit="ok()">
        <div>
			<div class="backup_temple back_margin" ng-bind-html="form.page_navi">
		</div>
		<div class="backup_temple2">
        <div>
          	<p>직접입력</p>
          	<div class="skj_box" style="overflow:hidden; text-align:left; border-bottom:none;">
				<select class="normal" style="float:left;" title="년" id="tyear" data-ng-model="form.year" data-ng-options="item as item for item in [1950, 2050]|range:4" ng-change="changeDate()"></select>
				<span style="float:left; margin:7px 0 0 3px;">년</span> 
				<select class="normal" style="float:left;" title="월" id="tmonth" data-ng-model="form.month" data-ng-options="item as item for item in [1, 12]|range:2" ng-change="changeDate()"></select>
				<span style="float:left; margin:7px 0 0 3px;">월</span>
				<select class="normal" style="float:left;" title="일" id="tday" data-ng-model="form.day" data-ng-options="item as item for item in [1, lastDay()]|range:2" ng-change="changeDate()"></select>
				<span style="float:left; margin:7px 0 0 3px;">일</span>
				<span style="float:left; margin-top:7px;"> / </span>
				<select class="normal" style="float:left;" title="시" id="thour" data-ng-model="form.hour" data-ng-options="item as item for item in [0, 23]|range:2" ng-change="changeDate()"></select>
				<span style="float:left; margin:7px 0 0 3px;">시</span> 
				<select class="normal" style="float:left;" title="분" id="tminute" data-ng-model="form.minute" data-ng-options="item as item for item in [0, 59]|range:2" ng-change="changeDate()"></select>
				<span style="float:left; margin:7px 0 0 3px;">분</span>
			</div>
        </div>
        <div class="skj_box2">
          	<p>스케쥴러 선택</p>
        </div>
        <div class="skj_box3">
          	<input type="text" data-ng-model="form.reserve_dt" datetimepicker2/>
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
</body>
</html>