<%@ page language="java" contentType="text/javascript; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
app.register.controller("listCtrl", function($scope, $timeout, $window, $routeParams, $location, ajaxService) {
	$scope.board = {
		chk_all : false
	};
	var p = $location.search();
	angular.extend($scope.param, {
		rows : p.rows||10,
		cpage : p.cpage||1,
		cat : p.cat||'',
		condition : p.condition||'TITLE',
		keyword : p.keyword||'',
		del_yn : p.del_yn||'N'
	});
	ajaxService.getSyncJSON('<c:url value="/super/bbs/B/list.do"/>', $scope.param, function(data){
		$scope.board.list = data.list;
		$scope.board.currentPage = $scope.param.cpage;
		$scope.board.totalCount = data.pagination.totalcount;
		$scope.board.totalPage = data.pagination.totalpage;
	});
	$scope.board.go = function(n){
		if(($scope.param.del_yn == 'Y' || $scope.param.del_yn == 'N')){
			//게시물관리
			$scope.param.gubun="";
			$scope.param.cpage=n;
			$location.search($scope.param);
		}else if($scope.param.gubun == 'B'){
			//예약게시물관리
			$scope.param.del_yn= "X";
			ajaxService.getSyncJSON('<c:url value="/super/reserve/list.do"/>?cpage='+n, $scope.param, function(data){
				$scope.board.list = data.list;
				$scope.board.currentPage = n;
				$scope.board.totalCount = data.pagination.totalcount;
				$scope.board.totalPage = data.pagination.totalpage;
			});
		}
	};

	$scope.chk_all_btn = function(){
		$("#boardList input[type=checkbox]").each(function(){
			if($scope.board.chk_all){
				$(this).prop("checked",true);
			}else{
				$(this).prop("checked",false);
			}
		})
	}
	
	/* 예약 게시물 관리 */
	$scope.blankUrl = function(menu_url){
		if(!!menu_url){
			var newWindow = window.open("about:blank");
			newWindow.location.href = menu_url ;
		}else{
			alert("아직 적용전이거나 이미 삭제된 페이지 입니다.");
		}
	}
	$scope.del = function(item){
		if(!confirm("정말 삭제 하시겠습니까?")){
			return false;
		}
		ajaxService.getJSON("<c:url value="/super/reserve/del.do"/>", item, function(data){
			if(data.rst == '1'){
				$scope.board.go(1);
			}else{
				alert(data.msg);
			}
		});
	}
	/* 예약 게시물 관리 */
	
});
