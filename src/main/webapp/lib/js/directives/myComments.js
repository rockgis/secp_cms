/**
 * 댓글
 * @param ang
 */
(function(ang){
	ang.module('myComments', ['myCommon']).directive('comments', [function() {
		return {
	        restrict: 'AE',
			templateUrl : function(elem, attrs){
				return contextPath + '/lib/js/partials/comments.html';
			},
	        scope: {
	        	menuSeq: '=cmsMenuSeq',
	        	seq: '=articleSeq'
	        },
	        replace : true,
	        controller : function($scope, $timeout, ajaxService){
	        	$scope.param = {
        			cms_menu_seq:$scope.menuSeq, 
        			article_seq : $scope.seq
	        	}
	        	
	        	$scope.board = {};
	        	$scope.board.go = function(n){
	        		$(".commentbox").block();
	        		$scope.param.cpage=n;
		        	var promise = ajaxService.getJSON("/super/comment_list.do?cpage="+n, $scope.param, function(data){
	        			$scope.board.list = data.list;
	        			$scope.board.currentPage = n;
	        			$scope.board.totalCount = data.pagination.totalcount;
	        			$scope.board.totalPage = data.pagination.totalpage;
		        	});
		        	promise.then(function(){
		        		$timeout(function(){
		        			$(".commentbox").unblock();
		        		}, 500);
		        	});
	        	};
	        	$scope.board.go(1);
	        	
	        	$scope.commentReplyOpen = function(seq){
	        		$scope.current_seq = seq;
	        		$("[class*='reply_zone_']").hide();
	        		$(".reply_zone_".concat(seq)).show();
	        	}
	        	$scope.commentReplyClose = function(seq){
	        		$(".reply_zone_".concat(seq)).hide();
	        	}
	        	$scope.commentSubmit = function(item){
	        		if($scope.cFrm.$invalid){
	        			if($scope.cFrm.$error.required){
	        				alert("필수값을 입력하여 주십시오.");
	        			}else{
	        				alert("값이 유효하지 않습니다.");
	        			}
	        			$("#cFrm .ng-invalid")[0].focus();
	        			return false;
	        		}
	        		
	        		var form = {
		        			cms_menu_seq : $scope.param.cms_menu_seq,
		        			article_seq : $scope.param.article_seq,
		        			conts : $scope.param.conts
	        		};
		        	ajaxService.getJSON("/super/comment_reg.do", form, function(data){
		        		$scope.param.conts = "";
		        		$scope.board.go(1);
		        	});
	        	}
	        	$scope.commentReply = function(item){
	        		if($scope.rFrm.$invalid){
	        			if($scope.rFrm.$error.required){
	        				alert("필수값을 입력하여 주십시오.");
	        			}else{
	        				alert("값이 유효하지 않습니다.");
	        			}
	        			$("#rFrm .ng-invalid")[0].focus();
	        			return false;
	        		}
	        		var form = {
		        			cms_menu_seq : item.cms_menu_seq,
		        			article_seq : item.article_seq,
		        			parent_seq : item.comment_seq,
		        			conts : item.reply_cont
	        		};
		        	ajaxService.getJSON("/super/re_comment_reg.do", form, function(data){
		        		item.reply_cont = "";
		        		$scope.board.go(1);
		        	});
	        	}
	        	$scope.commentDel = function(seq){
	        		if(!confirm("삭제하시겠습니까?")) return false;
	        		
		        	ajaxService.getJSON("/super/comment_del.do", {comment_seq:seq}, function(data){
		        		$scope.board.go(1);
		        	});
	        	}
	        }
	    };
	}]);
})(angular);