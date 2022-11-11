<%@ page language="java" contentType="text/javascript; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
app.register.controller("listCtrl", function($scope, $timeout, $window, $routeParams, $location, ajaxService, $rootScope, $sce, $compile, dialogService) {
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
	
	$scope.custom = [];
	ajaxService.getSyncJSON('<c:url value="/super/system/board/element_list.do"/>', {'board_seq':$scope.param.board_seq,'view_focus':'a_list'}, function(data){
		$scope.custom = data;
	});
	
	$scope.returnColspan = function(cols){
		var colspan = 0;
		$.each(cols,function(){
			if($(this).column_name != 'notice_yn' && $(this).column_name != 'password'){
				colspan++;
			}
		})
		return colspan;
	}
	
	$scope.itemBind = function(rn,cols,item){
		//var html = "<p>";
		var html = "";
		var col_nm = cols.column_name;
		if(item[col_nm] != null){
		
			if(col_nm == 'rn'){
				if(item["notice_yn"] == 'Y'){
					html+= "<img src=\"/images/super/notice.png\" alt=\"공지\"/>";
				}else{
					html+= rn;
				}
				
			}else if(col_nm == 'thumb'){
				html+= "<img src='"+item[col_nm]+"' style='width:100px;height:100px;'/>";
				
			}else if(col_nm == 'title'){
				if(item["comment_cnt"] != null && item["comment_cnt"] != "0" && $scope.param.comment_yn == 'Y'){
					html+= item[col_nm]+" ("+item["comment_cnt"]+")";
				}else{
					html+= item[col_nm];
				}
				
				if(item["public_yn"] == 'N'){
					html+= "<label style='margin-left: 5px;'><img src='/images/article/style01_mp.gif' alt='비공개'></label>";
				}
								
			}else if(col_nm == 'public_yn'){
				if(item[col_nm] == 'Y'){
					html+= "공개";
				}else{
					html+= "비공개";
				}
				
			}else{
				html+= item[col_nm];
			}			
		}
		//html += "</p>";
		return $sce.trustAsHtml(html);
	}
	

	$scope.board.go = function(n){
		
		if($scope.param.rows == ''){
			$scope.param.rows = 10;
		}
		
		if(($scope.param.del_yn == 'Y' || $scope.param.del_yn == 'N')){
			//게시물관리
			$scope.param.gubun="";
			$scope.param.cpage=n;
			$scope.board.chk_all = false;
			ajaxService.getSyncJSON('<c:url value="/super/bbs/F/list.do"/>?cpage='+n, $scope.param, function(data){
				$scope.board.list = data.list;
				$scope.board.currentPage = n;
				$scope.board.totalCount = data.pagination.totalcount;
				$scope.board.totalPage = data.pagination.totalpage;
			});
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
