<%@ page language="java" contentType="text/javascript; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf" %>
app.register.controller("listCtrl", function($rootScope, $scope, $timeout, $window, $routeParams, $location, ajaxService, dialogService) {
	$scope.board = {};
	var p = $location.search();
	angular.extend($scope.param, {
		rows : p.rows||'10',
		cpage : p.cpage||'1',
		group_seq : p.group_seq||1,
		condition : p.condition||"${empty param.condition ? 'member_nm' : param.condition}",	
		keyword : p.keyword||"${empty param.keyword ? '' : param.keyword}",	
		sort_nm : p.sort_nm||'member_id',
		sort : p.sort||'asc',
		shoseong : p.shoseong||'',
		block_yn : p.block_yn||'',
		dormancy_yn : p.dormancy_yn||'',
		del_yn : p.del_yn==undefined?'N':p.del_yn,
		sms_yn : p.sms_yn||'',
		email_yn : p.email_yn||''
	});
	
	$scope.selectable_user = function(){
		$timeout(function(){
			$("#listWrap").selectable();
			$('#listWrap>tr td.member_nm>a').draggable({
				distance: 5,
				start : function(){
				},
				helper: function(e, ui) {
					var set = $('<div><img src="/images/common/people.png" /></div>')
					.addClass('ui-state-active')
					.css({
						margin:"0px",padding:"0px",position: 'relative', overflow: 'hidden'
					});
					var	selected = $("#listWrap>tr.ui-selected");
					$.each(selected, function(i){
						var copy = $("<span style='display:none;'></span>")
						.html($(this).find(".member_nm ").attr("member_id"))
						.appendTo(set)
					});
					return set;
				},
				cursorAt: {left: 12, top: 9}
			});
			
		},300);
	}
	ajaxService.getJSON('<c:url value="/super/user_group/view.do"/>', $scope.param, function(data){
		$scope.data = data;
	});
	
	ajaxService.getSyncJSON('<c:url value="/super/member_user/list.do"/>', $scope.param, function(data){
		$scope.board.list = data.list;
		$scope.board.currentPage = $scope.param.cpage;
		$scope.board.totalCount = data.pagination.totalcount;
		$scope.board.totalPage = data.pagination.totalpage;
		$scope.selectable_user();
	});
	$scope.board.go = function(n){
		$scope.param.cpage=n;
		$scope.param.rnd = Math.random();
		$location.search($scope.param);
	};
	
	$scope.scrollOption = {
		width : 300	
	};

	$scope.chk_all_btn = function(){
		$("#board_div input[type=checkbox]").each(function(){
			if($scope.board.chk_all){
				$(this).prop("checked",true);
			}else{
				$(this).prop("checked",false);
			}
		})
	}
	
	//정렬
	$scope.board.sort = function(sort_nm, evt){
		if(angular.equals(sort_nm, $scope.param.sort_nm)){
			if($scope.param.sort == 'asc'){
				$scope.param.sort = 'desc';
			}else{
				$scope.param.sort = 'asc';
			}
		}else{
			$scope.param.sort = 'asc';
			$scope.param.sort_nm = sort_nm;
		}
		$scope.board.go(1);
	}
	$scope.board.choseong = function(shoseong, evt){
		$scope.param.shoseong = shoseong;
		$scope.board.go(1);
	}
	$scope.leave = function(item){
		if(!confirm("["+item.member_nm + "] 회원을 탈퇴 하시겠습니까?")){
			return false;
		}
		ajaxService.getJSON("<c:url value="/super/member_user/leave.do"/>", {leave_cont : "관리자에 의한 탈퇴", member_list : item.member_id}, function(data){
			if(data.rst == '1'){
				alert("["+item.member_nm + "] 님 회원정보가 탈퇴 처리되었습니다.");
				$scope.board.go(1);
			}else{
				alert(data.msg);
			}
		});
	}
	$scope.leaveChk = function(){
		var member_list = [];
		$("#board_div tbody#listWrap input[type=checkbox]:checked").each(function(){
			member_list.push($(this).val());
		})
		
		if(member_list.length==0){
			alert("탈퇴시킬 회원목록을 체크하여 주시기 바랍니다.");
			return false;
		}
	
		if(!confirm(member_list.length + " 명 회원을 탈퇴 하시겠습니까?")){
			return false;
		}
		ajaxService.getJSON("<c:url value="/super/member_user/leave.do"/>", {leave_cont : "관리자에 의한 탈퇴", member_list : member_list.join(",")}, function(data){
			if(data.rst > 0){
				alert(data.rst + " 명 회원정보가 탈퇴 처리되었습니다.");
				$scope.board.go(1);
			}else{
				alert(data.msg);
			}
		});
	}
	$scope.del = function(item){
		if(!confirm("["+item.member_nm + "] 회원을 삭제 하시겠습니까?")){
			return false;
		}
		ajaxService.getJSON("<c:url value="/super/member_user/del.do"/>", {member_list : item.member_id}, function(data){
			if(data.rst == '1'){
				alert("["+item.member_nm + "] 회원을 삭제 처리되었습니다.");
				$scope.board.go(1);
			}else{
				alert(data.msg);
			}
		});
	}
	$scope.delChk = function(){
		var member_list = [];
		$("#board_div tbody#listWrap input[type=checkbox]:checked").each(function(){
			member_list.push($(this).val());
		})
		
		if(member_list.length==0){
			alert("삭제시킬 회원목록을 체크하여 주시기 바랍니다.");
			return false;
		}
	
		if(!confirm(member_list.length + " 명 회원을 삭제 하시겠습니까?")){
			return false;
		}
	
		ajaxService.getJSON("<c:url value="/super/member_user/del.do"/>", {member_list : member_list.join(",")}, function(data){
			if(data.rst > 0){
				alert("["+data.rst + "] 명 회원을 삭제 처리되었습니다.");
				$scope.board.go(1);
			}else{
				alert(data.msg);
			}
		});
	}
	
	$scope.openAddMember = function(){
		var options = {
				title : '회원 추가',
				autoOpen: false,
				modal: true,
				width: "550",
				height: "auto",
				close: function(event, ui) {
				}
			};

		var param = {
			mode : 'ADD',
			group_seq : $scope.param.group_seq
		};
		dialogService.open("memberEditDialog", "/st_exclude/super/system/member_user/memberEditTemplete.do", param, options)
		.then(
			function(result) {
				alert("회원이 등록 되었습니다.");
				$scope.board.go(1);
			},
			function(error) {
			}
		);
	}
	
	$scope.openModMember = function(item){
		var options = {
				title : '회원 변경',
				autoOpen: false,
				modal: true,
				width: "550",
				height: "auto",
				close: function(event, ui) {
				}
			};

		var param = {
			mode : 'MOD',
			member_id : item.member_id
		};
		dialogService.open("memberEditDialog", "/st_exclude/super/system/member_user/memberEditTemplete.do", param, options)
		.then(
			function(result) {
				alert("회원정보가 변경 되었습니다.");
				$scope.board.go(1);
			},
			function(error) {
			}
		);
	}
	
	$scope.memberWakeup = function(item){
	    if(!confirm("계정 잠금 상태를 해제 하시겠습니까?")){
			return false;
		}
		ajaxService.getJSON("<c:url value="/super/member_user/memberWakeup.do"/>", {member_id: item.member_id}, function(data){
			alert("계정이 활성화 되었습니다.");
			$scope.board.go(1);
		});
	}
/*
	$(document).on("click", ".hitarea", function(){
		$(this).swapClass("expandable", "expandable-hitarea");
		$(this).siblings("ul").toggle();
	});
*/
});